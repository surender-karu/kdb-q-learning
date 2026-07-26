// Table
// tab:([]time:asc n?0D0;n?item;amount:n?100;n?city)

// List
// lst:10 20 30 40
// 1+til 10
// 0.1*1+til 10

// xs:0.01*-50+til 100
// 0 +/ xs
// (*/) 1+til 5
// (*\) 1+til 5
// 2#xs

// 10|2 
// 10&3

// {[xn] xn + (2 - xn*xn)%2*xn}/[1.0]

// Functions
// {[x] x*x} 5
// {[x] x*x} xs
// {x*x-1.0} xs

// 2#{x*x} 1+til 5
// 10 30, 20 40

// {-2#x}1 1
// {x, sum -2#x}1 1
// {x, sum -2#x}/[10;1 1]

symbols:`aapl`amzn`googl
// Create table columns
dates:2018.01.01+10000000?31 
times:10000000?24:00:00.0000
qtys:100*1+10000000?100
ixs:10000000?3
syms:symbols ixs
pxs:(1+10000000?0.03)*172.0 1189.0 1073.0 ixs
t:([] date:dates;time:times;sym:syms;qty:qtys;px:pxs)
t:`date`time xasc t

// Timing
\t select date, time, sym, qty, px from t where sym=`aapl
// Select top 5
5#select open:first px, close:last px by date, time from t where sym=`aapl

select open:first px, close:last px, low: min px, high: max px by date from t where sym=`aapl

rload `:/home/surender/q_tables/t
// Or 
t: get `:/home/surender/q_tables/t

// With strings mapped
t: update sym: symbols sym from get `:/home/surender/q_tables/t