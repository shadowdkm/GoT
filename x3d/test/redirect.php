 <?php

       $data = isset($_GET['input']) ? $_GET['input'] : 90;
       echo "Value is ".$data;
       $data = ($input >= 150) ? 90: $data;
       header( "refresh:5;url=page.php?input=".($data+10));
?> 