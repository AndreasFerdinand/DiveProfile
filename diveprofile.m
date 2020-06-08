
workingdir = "./"
sourcefilename = "depth.txt"
divelocation = "The Sea"
divedate = "6.6.2020"


targetfilepath = [ workingdir strrep( divelocation, " ", "_" ) "-" divedate ".svg" ]

depth = load("-ascii", [workingdir sourcefilename] )

depthcount = length(depth)
timelimit = ( depthcount / 2 ) - 0.5

time = 0:0.5:timelimit;


depthdelta = diff(depth)
depthdelta = [0,depthdelta]

buckets = [ sum( depth<5 ), sum( 5 <= depth & depth < 10 ), sum( 10 <= depth & depth < 15 ), sum( 15 <= depth & depth < 20 ), sum( 20 <= depth & depth < 25 )  ]
buckets = buckets * 0.5

divelength = sum( buckets )

subplot (2, 1, 1)
plot(time, depth, time, depthdelta, "linestyle",":" )
grid on
axis ("ij")
title([ divelocation ", " divedate ])
xlabel("Zeit / Minute")
ylabel("Tiefe / Meter")
legend ("Tiefe","Delta","location","southeast");


subplot (2, 1, 2)
bar(buckets,"facecolor", "y", "edgecolor", "b");
grid on
xlabel("Tiefenbereich / Meter, obere Schranke nicht im Intervall enthalten")
ylabel("Dauer / Minute")
xticklabels({"0-5","5-10","10-15","15-20","20-25"})

text([1:length(buckets)], buckets'+0.5, num2str(buckets','%0.1f'),'HorizontalAlignment','center','VerticalAlignment','bottom')
text(0.02,23, ["Gesamtdauer: " num2str(divelength)])

saveas (1, targetfilepath);