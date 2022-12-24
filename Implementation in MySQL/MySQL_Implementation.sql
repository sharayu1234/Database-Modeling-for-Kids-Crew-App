#1 Find the number of sitters available for each age group in descending order.
SELECT AGE_GROUP as AgeGroup, count(BID) AS NumberofBabysitters 
FROM kids_crew_new.children 
GROUP BY age_group
ORDER BY NumberofBabysitters DESC;

#2 Find the number of sitters as per availability in descending order.
SELECT availability,count(availability)as NumOfSitters
FROM babysitter
GROUP BY availability
ORDER BY NumOfSitters DESC;

#3 Find the number of sitters for each type of service.
SELECT service, count(service) 
FROM service_type
GROUP BY service;

#4 Find the number of babysitters having an hourly rate greater than the average hourly rate
SELECT hourly_rate, count(BID)
FROM babysitting
GROUP BY hourly_rate
HAVING hourly_rate > (SELECT AVG(hourly_rate) FROM babysitting);

#5 Find the name of all babysitters available for pickup/dropoff in the evening.
SELECT b1.b_name, s.service,b1.availability
FROM babysitter b1, service_type s
WHERE b1.bid = s.bid AND service= 'pickup_dropoff' AND b1.availability = 'evening';

#6 What is the lowest, highest, and average hourly rate of Sitters? (Aggregation)
SELECT MIN(hourly_rate) as lowest, MAX(hourly_rate) as highest, AVG(hourly_rate) as avg 
FROM babysitting;

#7 Find the name of the babysitters that have a rating greater than 3 and serviced children for over 50 hrs. (Nested Query)
SELECT b_name FROM babysitter WHERE bid IN (SELECT bid
FROM experience
WHERE rating >3
AND hrs_logged_children >50);

#8 Find the name of all babysitters that are available in the morning along with the child assigned to them whose parent is a Surgeon. (Join)
SELECT b.b_name, c.c_name
FROM children c, babysitter b, parent p WHERE c.BID = b.BID AND p.PID = c.PID AND b.availability='morning'
AND p.occupation='Surgeon';

#9 Find the name, ID of the babysitter having an hourly rate greater than average in boston along with parent name, and their occupation.
SELECT b.BID, b.b_name, bs1.hourly_rate, b.city, p.p_name,P.occupation
FROM babysitter b, babysitting bs1, parent p
WHERE b.BID=bs1.BID AND b.PID = p.PID 
AND P.occupation IN (SELECT occupation 
	FROM parent WHERE city='boston') 
    AND bs1.hourly_rate > (SELECT AVG(bs2.hourly_rate) 
		FROM babysitting bs2) 
AND b.city='boston';

#10 Find the ID,Name, city, and Hourly Rate of all babysitters who have the highest salary of all babysitters located in the same city. (View, Join, ALL Operator)
CREATE VIEW babysitter_info as SELECT b1.bid, b1.b_name, b1.city,bs.hourly_rate
FROM babysitter b1, babysitting bs WHERE b1.bid = bs.bid;
SELECT b1.bid,b1.b_name,b1.city, b1.hourly_rate
FROM babysitter_info b1
WHERE b1.hourly_rate >=
ALL( SELECT b2.hourly_rate FROM babysitter_info b2 WHERE b2.city=b1.city)
ORDER BY b1.hourly_rate DESC, city DESC;

#11 Find the names of all parents that need babysitters in the morning.
SELECT p.p_name
FROM parent p
WHERE EXISTS
(SELECT *
FROM babysitter b
WHERE b.PID=p.PID
AND b.availability='morning');
        





