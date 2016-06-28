SELECT p.name_project,
count(*) as total_refactoring
FROM public.refactoring_item r
INNER  JOIN public.execution_control e
	ON e.id_execution_control = r.id_execution_control
INNER JOIN public.project p
	on p.id_project = e.id_project
GROUP BY p.name_project
ORDER BY p.name_project;