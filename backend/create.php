<?php
  require_once 'include.php';
  
  $handle = fopen("php://input", "rb");
  $raw_post_data = '';
  while (!feof($handle)) {
    $raw_post_data .= fread($handle, 8192);
  }
  
  fclose($handle);
  
  // retrieve attendee information
  $attendee_data = $raw_post_data;
  $info_arr = explode(";", $attendee_data);
  
  /*
  INSERT INTO `infograbr_db`.`attendee` (`id`, `confName`, `confId`, `cgtServices`, `firstName`, `lastName`, `address`, `city`, `company`, `country`, `email`, `extraInfo`, `membership`, `office`, `organization`, `phone1`, `phone2`, `state`, `zipcode`, `projectTimeframe`, `dateCreated`, `lykerNum`) VALUES (NULL, '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21');
  */
  
  $address = $info_arr[0];
  $cgtServices = $info_arr[1];
  $city = $info_arr[2];
  $company = $info_arr[3];
  $confId = $info_arr[4];
  $country = $info_arr[5];
  $email = $info_arr[6];
  $extraInfo = $info_arr[7];
  $firstName = $info_arr[8];
  $lastName = $info_arr[9];
  $membership = $info_arr[10];
  $office = $info_arr[11];
  $organization = $info_arr[12];
  $phone1 = $info_arr[13];
  $phone2 = $info_arr[14];
  $projectTimeframe = $info_arr[15];
  $state = $info_arr[16];
  $zipcode = $info_arr[17];
  $confName = $info_arr[18];
  $dateCreated = $info_arr[19];
  $lykerNum = $info_arr[20];
  
  db_command("INSERT INTO `attendee`
    (`id`, `confName`, `confId`, `cgtServices`, `firstName`, `lastName`, `address`, 
    `city`, `company`, `country`, `email`, `extraInfo`, `membership`, `office`, `organization`, 
    `phone1`, `phone2`, `state`, `zipcode`, `projectTimeframe`, 
    `dateCreated`, `lykerNum`)
    VALUES (NULL, \"$confName\", \"$confId\", \"$cgtServices\", \"$firstName\", \"$lastName\", \"$address\", \"$city\", \"$company\", \"$country\", \"$email\", 
    \"$extraInfo\", \"$membership\", \"$office\", \"$organization\", 
    \"$phone1\", \"$phone2\", \"$state\", \"$zipcode\", \"$projectTimeframe\", \"$dateCreated\", \"$lykerNum\");
  ");
  
  var_dump($info_arr);