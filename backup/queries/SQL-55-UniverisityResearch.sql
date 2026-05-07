ALTER AUTHORIZATION ON DATABASE::UniversityResearchSystem TO sa;

-- Question 1:
select R.Id as RID, R.FirstName , R.Building , RP.Id as PID, RP.Title
from WorksOn WO
 right join Researcher R on R.Id = WO.ResearcherId
 left join ResearchProject RP on WO.ProjectId = RP.Id

-- =======================


-- Question 2:
select CONCAT(R.FirstName ,' ', R.MiddleName,' ' , R.LastName ) as FullName, R.Email
from  ResearchProject RP
 inner join Researcher R on R.Id = RP.LeaderId
 inner join ProjectFundingAgency FA on RP.Id = FA.ProjectId


-- =======================


-- Question 3:
select R.* , P.*
from Researcher R CROSS JOIN Publication P


-- =======================


-- Question 4:
select RS.Id as [SID] ,RS.FirstName as SName, RSD.FirstName as supervised  , S.Role , S.SupervisionStartDate  
from Supervises S
left join Researcher RS on S.SupervisorId = RS.Id
inner join Researcher RSD on S.SupervisedId = RSD.Id


-- ============================

--Question 5 :  xxxxxx problem

select R.*
from Researcher R 
inner join  Publishes Pub on Pub.ResearcherId = R.Id
left join (
		select WO.*
		from WorksOn WO left join ResearchProject RP
		on WO.ProjectId = RP.Id
		where RP.Status != 'Active'
		) as DUMMY on R.Id = DUMMY.ResearcherId

-- =======================================
-- Question 8 :
SELECT TOP 3 *  
FROM Researcher 
ORDER BY LastName  

SELECT *  
FROM Researcher  
ORDER BY LastName  
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY 

-- Results are the same
-- functionally in that case are same as they gave same results
-- , but in general they are not the same
-- Offset advantages--> we can start from any pos and get any number of that pos and more efficecntly
-- than if we tried to get it by top , as top would be really good to get the top N 
-- but if we wnated the get the top n from pos 50 for example , it would be diffucult to use
-- top
-- also the key advantage is the pagination idea , which used usually to decrease the overhead of the request and response
-- as amount of data , to make request and the response , to be light

-- ===========================



-- Question 10 :
select Title, type , CitationCount , DENSE_RANK()
		over (partition by p.type order by p.citationCount) as Rank
from Publication p
-- ===========================


-- Question 11 :
select RP.Title , RP.Status , RP.Budget, 
		DENSE_RANK() over(partition by [status] order by budget) as rank
from ResearchProject RP

-- difference between ranking with gaps or not , as with gaps that
-- jumps and give same rank for dupliactes but doesnot follow the 
-- order of numbering at all  , leaving gaps because of the duplicates 
-- as it jumps and escape the next number by the number of duplicates
-- but the one with no gaps does not follow that at all , it does not escape any numbers


-- ==============================

-- Question 13 :
-- 1. from , 2. where , 3.Group by,
-- 4.having , 5. select ,6. order by , 7. top,
-- 8. offset-fetch
-- ================================
-- Question 17 :
select *
from Researcher R
where R.email like '%@university.edu'

-- ==================================

-- Question 31 :
select distinct R.*
from Researcher R
inner join Supervises S on S.SupervisorId = R.Id
inner join ResearchProject RP on RP.LeaderId = R.Id

-- ==================================


-- Question 15 :
select CONCAT(R.FirstName ,' ' ,R.MiddleName, ' ', R.LastName) , 
	  LOWER(R.Email) , DATEDIFF (YEAR,R.DateOfBirth, GETDATE()) 
from Researcher R

-- ==========================


-- Question 7 :
select R.*
from Researcher R
order by R.LastName
offset 10 rows 
fetch next 10 rows only


-- ============================

-- Question 9 :
select R.*,
	ROW_NUMBER() over (partition by R.building order by R.DateOfBirth ) as Rank
from Researcher R
-- ================================


-- Question 6 :
select top (5) with ties pub.*
from Publication pub
order by pub.CitationCount desc


-- ===============================

-- Question 19 :
select  RP.*,
	 (case
	 when RP.Budget <= 50000 then 'Small'
	 when RP.Budget > 150000 then 'Large'
	 else 'Medium'
	 end) as Category

from ResearchProject RP 
where RP.Budget is not null 

-- =================================

-- Question 18:
select R.Building , R.DateOfBirth,R.Email,
	   R.FirstName, R.Id , 
	   case
		when R.MiddleName is null then 'N/A'
		else R.MiddleName
	   end as MiddleName, R.LastName ,
	   case
		when R.RoomNumber is null then 'N/A'
		else R.RoomNumber 
	   end as RoomNumber
from Researcher R
-- ========================


-- Question 16 :-

select 
    RP.Title,case
	when RP.EndDate is null then DATEDIFF(DAY , RP.StartDate, GETDATE())
    else DATEDIFF(DAY,RP.StartDate, RP.EndDate) 
	END AS DURATION , 
	FORMAT(RP.StartDate,'MM/yyyy') as STARTDATE
from ResearchProject RP

-- ================================
-- Question 28 :-
 select top(1) TA.*
 from (select top(2) RP.*
 from ResearchProject RP
 order by RP.Budget desc) as TA
 order by TA.Budget 
-- ===============================

