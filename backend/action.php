<?php
require_once 'include.php';

// check if we are performing any action (add/delete)
$additem = get_post("additem");
$delitem = get_post("deleteitem");
if (isset($additem) && ($additem == "conference" || $additem == "service"))
{
    if ($additem == "conference") // adding a conference
    {
        $date = get_post("date");
        $name = get_post("name");

        // validate params
        if (!isset($date) || $date == null || !isset($name) || $name == null || $name == "")
        {
            //
            echo "Invalid conference name OR date!"; // invalid
            exit();
        }

        // check duplicate conference name and date
        $dupname = query_db("SELECT * FROM `conference` WHERE `name` = '$name'  AND `date` = '$date';");
        if (count($dupname) > 0)
        {
            echo "Duplicate conference name and date!"; // invalid
            exit();
        }

        // add conference to db
        db_command("INSERT INTO `conference` (`date`, `name`) VALUES ('$date', '$name')");
    }
    else if ($additem == "service") // adding a service
    {
        $name = get_post("name");

        // validate params
        if (!isset($name) || $name == null || $name == "")
        {
            //
            echo "Invalid service name!"; // invalid
            exit();
        }

        // check duplicate service name
        $dupname = query_db("SELECT * FROM `service` WHERE `name` = \"$name\";");
        if (count($dupname) > 0)
        {
            echo "Duplicate service name!"; // invalid
            exit();
        }

        // add service to db
        db_command("INSERT INTO `service` (`name`) VALUES ('$name')");
    }
}
else if (isset($delitem) && ($delitem == "conference" || $delitem === "service"))
{
    $id = get_post("id");

    // delete from db
    db_command("DELETE FROM `$delitem` WHERE id = '$id'");
}
else
{
    echo "Error performing action"; // invalid
    exit();
}


echo "1"; // valid