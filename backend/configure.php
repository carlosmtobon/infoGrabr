<?php
require_once 'include.php';

// grab info from database
$res = db_command("SELECT * FROM `service`;");
if (!$res)
{
    echo "Error fetching services!";
    exit();
}
$services_rows = $res->fetch_all(MYSQLI_ASSOC);
$services_cols = $res->fetch_fields();

$res = db_command("SELECT * FROM `conference`;");
if (!$res)
{
    echo "Error fetching conferences!";
    exit();
}
$conferences_rows = $res->fetch_all(MYSQLI_ASSOC);
$conferences_cols = $res->fetch_fields();
?>

<html>
<head>
    <title>Configure infoGrabr Server</title>
    <script src="libs/js/jquery-2.1.0.min.js"></script>
    <script src="libs/js/jquery-ui-1.10.4.custom.min.js"></script>
    <link rel="stylesheet" media="screen" type="text/css" href="css/ui-lightness/jquery-ui-1.10.4.custom.min.css" />
</head>

<body>
    <h1><p>Services:</p></h1>
    <p>
        <table>
            <tr>
                <td align="right">Name:</td>
                <td><input type='text' id='servicename'></td>
                <td align="right"><button onclick='addService()'>add</button></td>
            </tr>
        </table>
    </p>
    <table border="1">
        <?php
            // populate table columns
            foreach ($services_cols as $col)
            {
                   echo"<th>$col->name</th>";
            }
            // populate table rows
            if (count($services_rows) > 0)
            {
                foreach ($services_rows as $row)
                {
                    echo "<tr>";
                    foreach ($services_cols as $col)
                    {
                        $val = $row[$col->name];
                        echo "<td>$val</td>";
                    }
                    $id = $row['id'];
                    echo "<td><button onclick='deleteRecord(\"service\",$id)' >delete</button> </td></tr>\n";
                    echo "</tr>";
                }
            }
        ?>
    </table>


    <h1><p>Conferences:</p></h1>
    <div>
        <table>
            <tr>
                <td align="right">Name:</td>
                <td><input type='text' id='conferencename'></td>
            </tr>
            <tr>
                <td align="right">Date:</td>
                <td><input id='conferencedate'></td>
            </tr>
            <tr>
                <td></td>
                <td align="right"><button onclick='addConference()'>add</button></td>
            </tr>
        </table>
    </div>
    <script>
        var today = new Date();
        $("#conferencedate").val(today.getFullYear() + '-' + (today.getMonth()+1) + '-' + today.getDate());
        $("#conferencedate" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
        $(function()
            {
                $("#conferencedate" ).datepicker();
                $("#conferencedate" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
            }
        );
    </script>
    <br>
    <div>
    <table border="1">
        <?php
        // populate table columns
        foreach ($conferences_cols as $col)
        {
            echo"<th>$col->name</th>";
        }
        // populate table rows
        if (count($conferences_rows) > 0)
        {
            foreach ($conferences_rows as $row)
            {
                echo "<tr>";
                foreach ($conferences_cols as $col)
                {
                    $val = $row[$col->name];
                    echo "<td>$val</td>";
                }
                $id = $row['id'];
                echo "<td><button onclick='deleteRecord(\"conference\",$id)' >delete</button> </td></tr>\n";
                echo "</tr>";
            }
        }
        ?>
    </table>
    </div>

    <script>
        function deleteRecord(type, id)
        {
            var data = "deleteitem=" + type + "&id=" + id;
            $.post("action.php", data)
                .done(function(data)
                {
                    if (data == "1")
                    {
                        location.reload();
                    }
                });
        }

        function addRecord(type, rdata)
        {
            var data = "additem=" + type + "&" + rdata;
            $.post("action.php", data)
                .done(function(data)
                {
                    if (data === "1")
                        location.reload();
                    else
                    {
                        $("#servicename").val('');
                        $("#conferencename").val('');
                        alert(data);
                    }
                });
        }

        function addConference()
        {
            var data = "date=" + $('#conferencedate').val() + "&name=" + $("#conferencename").val();
            addRecord("conference", data);
        }

        function addService()
        {
            var data = "name=" + $("#servicename").val();
            addRecord("service", data);
        }
    </script>
</body>

</html>