SELECT p.name_project,
	   count(*)
FROM public.project p
INNER JOIN public.commit c 
	ON p.id_project = c.id_project
group by p.name_project
order by p.name_project;

SELECT p.name_project,
	   count(*)
FROM public.project p
INNER JOIN public.execution_control e 
on e.id_project = p.id_project
INNER JOIN public.refactoring_item r 
ON r.id_execution_control = e.id_execution_control
group by p.name_project
order by p.name_project;

SELECT p.name_project,
	   TRIM(UPPER(r.refactoring_name)),
	   count(*)
FROM public.project p
INNER JOIN public.execution_control e 
on e.id_project = p.id_project
INNER JOIN public.refactoring_item r 
ON r.id_execution_control = e.id_execution_control
group by p.name_project,
	     TRIM(UPPER(r.refactoring_name))
order by p.name_project;


SELECT p.name_project,
	   count(*)
FROM public.project p
INNER JOIN public.execution_control e 
on e.id_project = p.id_project
INNER JOIN public.refactoring_item r 
ON r.id_execution_control = e.id_execution_control
WHERE TRIM(UPPER(r.refactoring_name)) = 'MOVE CLASS' 
group by p.name_project
order by p.name_project;


