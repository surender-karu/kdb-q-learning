show 29
show "Hello"
show `AAPL

show .z.p

show 1 2 3 4 / lists
show `AAPL`AMZN`GOOGL / symbols
show "APPL" "AMZN" "GOOGL" / strings
show `a`b!1 2 / dictionaries

// 4 % 2
// date - 2000.01.01

// String list

// n:10000
// item:`apple`banana`orange`pear 
// city:`beijing`chicago`london`paris

tab: ([] timestamp: `timestamp$(); sym: `symbol$(); price: `float$(); qty: `float$())

show tab;

`tab insert (.z.p; `AAPL; 172.0; 100.0)
`tab insert (.z.p; `AMZN; 1189.0; -10.0)
`tab insert (.z.p; `GOOGL; 1073.0; 140.0)
`tab insert (.z.p; `AAPL; 172.0; 50.0)

show select from tab where sym=`AAPL;