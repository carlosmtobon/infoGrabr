<?php
require_once 'include.php';

//test
  //goto_file('configure.php');
  //exit();

// determine what we are returning
$info_selected = get_get("getinfo");
$set_info = get_get("setinfo");
  
if ($info_selected == CONFERENCES_API)
{
  echo json_encode(query_db("SELECT * FROM `conference`;"));
}
else if ($info_selected == SERVICES_API)
{
  echo json_encode(query_db("SELECT * FROM `service`;"));
}
else if ($info_selected == ATTENDEES_API)
{
  echo json_encode(query_db("SElECT * FROM `attendee`;"));
}
else if ($info_selected == TOPLEADS_API)
{
  echo json_encode(query_db("SELECT * FROM `attendee` WHERE `lykerNum` = \"strongly agree\";"));
}
else if ($info_selected == CITY_TOTAL_API)
{
  echo json_encode(query_db("SELECT `city`, COUNT(`city`) AS `total` FROM `attendee` GROUP BY `city` ORDER BY `total` DESC;"));
}
else 
{
  echo "infoGrabr API v1.0";
}