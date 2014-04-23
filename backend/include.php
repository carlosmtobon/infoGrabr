<?php
date_default_timezone_set('America/New_York');

// ---

// api switches
define("CONFERENCES_API", "conferences");
define("SERVICES_API", "services");
define("ATTENDEES_API", "attendees");
define("TOPLEADS_API", "topleads");
define("LIKERT_TOTAL_API", "likert");
define("STATE_TOTAL_API", "state");
define("CITY_TOTAL_API", "city");

// db configuration
define("DB_SERVER", "db.eniopn.com");
define("DB_PORT", 3306);
define("DB_USER", "infograbr_usr");
define("DB_PASSWORD", "$1nf0gr4bR#");
define("DB_DEFAULTDB", "infograbr_db");

// ---

session_start();

//http://stackoverflow.com/questions/2203943/include-constant-in-string-without-concatenating
$constant = function($cons)
{
    return constant($cons);
};


function query_db($sql)
{
    // connect to database
    $db = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_DEFAULTDB, DB_PORT);

    if($db->connect_error)
    {
        die('Unable to connect to database [' . $db->connect_error . ']');
    }

    $result = $db->query($sql);
    if($result === false)
    {
        die('There was an error running the query [' . $db->error . ']');
    }


    $arr = $result->fetch_all(MYSQLI_ASSOC);
    return $arr;
}

function db_command($sql)
{
    // connect to database
    $db = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_DEFAULTDB, DB_PORT);

    if($db->connect_error)
    {
        die('Unable to connect to database [' . $db->connect_error . ']');
    }

    $result = $db->query($sql);

    if($result === false)
    {
        die('There was an error running the query [' . $db->error . ']');
    }

    return $result;
}

function get_post($var)
{
    if (isset($_POST[$var]) === true)
    {
        return mysql_escape_mimic($_POST[$var]);
    }
    return null;
}

function get_get($var)
{
    if (isset($_GET[$var]) === true)
    {
        return mysql_escape_mimic($_GET[$var]);
    }
    return null;
}

// http://stackoverflow.com/questions/7016965/alternative-to-mysql-real-escape-string-access-denied
function mysql_escape_mimic($inp)
{
    if(is_array($inp))
        return array_map(__METHOD__, $inp);

    if(!empty($inp) && is_string($inp))
    {
        return str_replace(array('\\', "\0", "\n", "\r", "'", '"', "\x1a"), array('\\\\', '\\0', '\\n', '\\r', "\\'", '\\"', '\\Z'), $inp);
    }

    return $inp;
}

function do_logout()
{
    session_start();
    session_destroy();
}

function goto_file($filename)
{
    header('Location: ' . $filename, true);
}
