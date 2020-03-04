for d in * ; do
  if [ "$d" != "medium" -a  "$d" != "test" ]; then
    for prob in $d/* ; do
      if [ -d "$prob" ]; then
        for human in $prob/* ; do
          if [ -d "$human" ]; then
            echo "$human"
            ./vrun.sh "$human" > "$human/result"
          fi
        done
      fi
    done
  fi
done

# ./vrun >