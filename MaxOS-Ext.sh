#!/bin/bash
#Writen by Emmitt Houston and Kyle Brockman while working at UW-Milwaukee.
#Based off code from http://stackoverflow.com/questions/14366390/bash-if-condition-check-if-element-is-present-in-array
#And an idea from UWM's JAMF support repo.

array_contains () {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

latest="10.12"
sysmodel=`sysctl hw.model | awk '{print $2}'`
#sysmodel="RackMac1,1" # 10.5 Test true
#sysmodel="MacBookPro1,1" # 10.6 Test true
#sysmodel="MacBook2,1" # 10.7 Test true
#sysmodel="iMac7,1" # 10.11 Test true


# Hardware Arraies
arr10_5=(PowerMac3,5 PowerMac3,6 PowerMac4,4 PowerMac6,1 PowerMac6,3 PowerMac6,4 PowerMac7,2 PowerMac7,3 PowerMac8,1 PowerMac8,2 PowerMac9,1 PowerMac10,1 PowerMac10,2 PowerMac11,2 PowerMac12,1 RackMac1,1 RackMac1,2 RackMac3,1 PowerBook3,5 PowerBook5,1 PowerBook5,2 PowerBook5,3 PowerBook5,4 PowerBook5,5 PowerBook5,6 PowerBook5,7 PowerBook5,8 PowerBook5,9 PowerBook6,1 PowerBook6,2 PowerBook6,3 PowerBook6,4 PowerBook6,5 PowerBook6,7 PowerBook6,8)
arr10_6=(iMac4,1 iMac4,2 Macmini1,1 MacBook1,1 MacBookPro1,1 MacBookPro1,2)
arr10_7=(iMac5,2 iMac5,1 iMac6,1 Macmini2,1 MacPro1,1 MacPro2,1 MacBook2,1 MacBook3,1 MacBook4,1 MacBookAir1,1 MacBookPro2,2 MacBookPro2,1 Xserve1,1 Xserve2,1)
arr10_11=(iMac7,1 iMac8,1 iMac9,1 Macmini3,1 MacPro3,1 MacPro4,1 MacBook5,1 MacBook5,2 MacBookAir2,1 MacBookPro3,1 MacBookPro4,1 MacBookPro5,1 MacBookPro5,2 MacBookPro5,3 MacBookPro5,4 MacBookPro5,5 Xserve3,1)

#array_contains2 arr10_7 "$sysmodel" && echo yes || echo no
if array_contains arr10_5 "$sysmodel"; then
  echo "<result>10.5</result>"
else
  if array_contains arr10_6 "$sysmodel"; then
    echo "<result>10.6</result>"
  else
    if array_contains arr10_7 "$sysmodel"; then
      echo "<result>10.7</result>"
    else
      if array_contains arr10_11 "$sysmodel"; then
        echo "<result>10.11</result>"
      else
        echo "<result>$latest</result>"
      fi
    fi
  fi
fi
