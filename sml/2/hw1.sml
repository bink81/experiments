fun is_older (date1 : int*int*int, date2 : int*int*int) =
    if (#1 date1) < (#1 date2)
    then true
    else if (#1 date1) > (#1 date2)
    then false
    else if (#2 date1) < (#2 date2)
    then true
    else if (#2 date1) > (#2 date2)
    then false
    else if (#3 date1) < (#3 date2)
    then true
    else if (#3 date1) > (#3 date2)
    then false
    else false

fun number_in_month ( dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else if (#2 (hd dates)) = month
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)


fun number_in_months ( dates : (int*int*int) list, months : int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month ( dates : (int*int*int) list, month : int) =
    if null dates
    then []
    else if (#2 (hd dates)) = month
    then (hd dates) :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months ( dates : (int*int*int) list, months : int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth ( strings : (string) list, n : int) =
    if n = 1
    then hd strings
    else get_nth(tl strings, n - 1)

val m = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
fun date_to_string (date : int*int*int) =
	get_nth(m, (#2 date)) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)

fun number_before_reaching_sum ( sum: int, numbers : int list) =
	let
	 fun f( current: int, numbers : int list, number : int) = 
	 if current < sum
	 then f(current + hd numbers, tl numbers, number + 1)
	 else number
	in
		f(0, numbers, 0) - 1
	end

val daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]

fun what_month(n : int) =
	number_before_reaching_sum(n, daysInMonths) + 1

fun month_range(day1 : int, day2 : int) =
	if day1 > day2
	then []
	else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest(dates : (int*int*int) list) =
    if null dates
    then NONE
    else 
    	let
			fun oldest_nonempty (xs : (int*int*int) list) =
				if null (tl xs)
				then hd xs
				else let 
						val tl_ans = oldest_nonempty(tl xs)
				     in
						 if is_older(hd xs, tl_ans)
						 then hd xs
						 else tl_ans
				     end
		in
	    	SOME (oldest_nonempty dates)
	    end