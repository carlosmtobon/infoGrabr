<?php
require_once 'include.php';

//test
  //goto_file('configure.php');
  //exit();

// determine what we are returning
$info_selected = get_get("getinfo");

if ($info_selected == CONFERENCES_API)
{
    echo json_encode(query_db("SELECT * FROM `conference`;"));
}
else if ($info_selected == SERVICES_API)
{
    echo json_encode(query_db("SELECT * FROM `service`;"));
}
else
{
    echo "infoGrabr API v1.0";
}