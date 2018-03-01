function Lesson()
{
    var id, name, type, sector, teacher, auditorium, day, start, end;
}

var lessons = [];


function insertLesson(name, type, sector, teacher, auditorium, day, start, end)
{
    var x = 0, y = 0;

    for(var i = 0; i < lessons.length; i++)
    {
        if(name === lessons[i][0].name)
        {
            x = i;
            y = lessons[i].length;

            break;
        }
        else
        {
            x = i+1;
            y = 0;
        }
    }

    if(x === lessons.length)
    {
        lessons[x] = [];
    }

    lessons[x][y] = new Lesson();


    if(type === 0)
    {
        type = "(Θ)";
    }
    else if(type === 1)
    {
        type = "(Ε)";
    }

    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

    if(day === "Monday" || day === "Tuesday" || day === "Wednesday" || day === "Thursday" || day === "Friday")
    {
        for(var i = 0; i < 5; i++)
        {
            if(days[i] === day)
            {
                day = i;

                break;
            }
        }
    }

    lessons[x][y].id = x +" " +y;

    lessons[x][y].name = name;
    lessons[x][y].type = type;
    lessons[x][y].sector = sector;
    lessons[x][y].teacher = teacher;
    lessons[x][y].auditorium = auditorium;
    lessons[x][y].day = day;
    lessons[x][y].start = start;
    lessons[x][y].end = end;
}

// Sectors: 0 --> Κοινό, 1 --> Δικτύων, 2 --> Υπολογιστλών, 3 --> Λογισμικού, 4 --> Όλα

function PointLessons()
{
    var lessonsI;
    var lessonsJ;
}

var time = new Array(5);

for(var i = 0; i < time.length; i++)
{
    time[i] = new Array(24);
}

for(var i = 0; i < time.length; i++)
{
    for(var j = 0; j < time[i].length; j++)
    {
        time[i][j] = [];
    }
}


function assignTimeDuplicated()
{
    var d, h, l, l1, l2, duration;

    for(var i = 0; i < lessons.length; i++)
    {
        for(var j = 0; j < lessons[i].length; j++)
        {
            d = lessons[i][j].day;
            h = lessons[i][j].start;
            duration = lessons[i][j].end - lessons[i][j].start;

            l = time[d][h].length;
            time[d][h][l]  = new PointLessons();
            time[d][h][l].lessonsI = i;
            time[d][h][l].lessonsJ = j;


            if(duration >= 2)
            {
                l1 = time[d][h + 1].length;
                time[d][h + 1][l1] = new PointLessons();
                time[d][h + 1][l1].lessonsI = i;
                time[d][h + 1][l1].lessonsJ = j;
            }

            if(duration === 3)
            {
                l2 = time[d][h+2].length;
                time[d][h+2][l2]  = new PointLessons();
                time[d][h+2][l2].lessonsI = i;
                time[d][h+2][l2].lessonsJ = j;
            }

        }
    }
}


function assignTime()
{
    var d, h, l, duration;

    for(var i = 0; i < lessons.length; i++)
    {
        for(var j = 0; j < lessons[i].length; j++)
        {
            d = lessons[i][j].day;
            h = lessons[i][j].start;
            l = time[d][h].length;
            duration = lessons[i][j].end - lessons[i][j].start;

            time[d][h][l]  = new PointLessons();

            time[d][h][l].lessonsI = i;
            time[d][h][l].lessonsJ = j;

        }
    }
}


function reset()
{
    time = new Array(5);

    for(var i = 0; i < time.length; i++)
    {
        time[i] = new Array(24);
    }

    for(var i = 0; i < time.length; i++)
    {
        for(var j = 0; j < time[i].length; j++)
        {
            time[i][j] = [];
        }
    }
}


var gsec = 4;

function fSec()
{
    if(document.getElementById('r2').checked)
    {
        gsec = 1;
    }
    else if(document.getElementById('r3').checked)
    {
        gsec = 2;
    }
    else if(document.getElementById('r4').checked)
    {
        gsec = 3;
    }
    else if(document.getElementById('r1').checked)
    {
        gsec = 4;
    }
}


// ex ειναι το εξαμηνο που διδασκονται τα μαθηματα που δινονται
function printLessonsD(ex)
{
    reset();

    assignTimeDuplicated();

    if(ex >= 5)
    {
        fSec();
    }

    var days = ["Δευτέρα", "Τρίτη", "Τετάρτη", "Πέμπτη", "Παρασκευή"];

    var s = "";

    s += "<table><tr><th>Ώρες</th> ";
    for(var i = 0; i < days.length; i++)
    {
        s += " <th> " +days[i] +" </th> ";
    }
    s += " </tr>";

    var arrI, arrJ;

    for(var j = 8; j < 20; j++)
    {
        s += "<tr>";
        s += "<th>" +j +"-" +(j+1) +"</th>";

        for(i = 0; i < 5; i++)
        {
            s += "<td>";

            for(var k = 0; k < time[i][j].length; k++)
            {
                s += "<p>";

                arrI = time[i][j][k].lessonsI;
                arrJ = time[i][j][k].lessonsJ;

                if(gsec === 4 || lessons[arrI][arrJ].sector === gsec || lessons[arrI][arrJ].sector === 0)
                {
                    s += lessons[arrI][arrJ].name + " " + lessons[arrI][arrJ].type + " "
                        + lessons[arrI][arrJ].teacher + " " + lessons[arrI][arrJ].auditorium;
                }

                s += " </p>";
            }

            s += "</td>";
        }

        s += "</tr>";
    }

    s += "</table>";

    document.getElementById('t1').innerHTML = s;
}

// ex ειναι το εξαμηνο που διδασκονται τα μαθηματα που δινονται
function printLessons(ex)
{
    reset();

    assignTime();

    if(ex >= 5)
    {
        fSec();
    }

    var days = ["Δευτέρα", "Τρίτη", "Τετάρτη", "Πέμπτη", "Παρασκευή"];

    var s = "";

    s += "<table><tr> ";
    for(var i = 0; i < days.length; i++)
    {
        s += " <th> " +days[i] +" </th> ";
    }
    s += " </tr>";

    var arrI, arrJ;

    for(var i = 0; i < 5; i++)
    {
        s += " <td>";

        for(var j = 8; j < 20; j++)
        {
            for(var k = 0; k < time[i][j].length; k++)
            {
                s += "<p>";

                arrI = time[i][j][k].lessonsI;
                arrJ = time[i][j][k].lessonsJ;

                if(gsec === 4 || lessons[arrI][arrJ].sector === gsec || lessons[arrI][arrJ].sector === 0)
                {
                    s += lessons[arrI][arrJ].name + " " + lessons[arrI][arrJ].type + " "
                        + lessons[arrI][arrJ].teacher + " " + lessons[arrI][arrJ].auditorium + ", "
                        + lessons[arrI][arrJ].start + " - " + lessons[arrI][arrJ].end;

                    s += "<br>";
                    s += "<br>";
                }

                s += "</p>";
            }
        }

        s += " </td>";
    }

    document.getElementById('t1').innerHTML = s;
}




