while true:
   stdout.write("> ")
   let input = readLine(stdin)
   if input.len() == 0:
      echo("goodbye!")
      break
   echo input
