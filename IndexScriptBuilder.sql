Select top 100 *
from (
SELECT OBJECT_NAME(fq.OBJECT_ID) AS TableName,
fq.name AS IndexName, qs.index_type_desc AS IndexType,

qs.avg_fragmentation_in_percent

FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) qs

INNER JOIN sys.indexes fq

ON fq.object_id = qs.object_id

AND fq.index_id = qs.index_id

WHERE qs.avg_fragmentation_in_percent > 0) f inner join 

--ORDER BY qs.avg_fragmentation_in_percent DESC
(SELECT 'ALTER INDEX ALL ON ' as altstart, o.name, ' REBUILD ;' as rebuilend,
  ddps.row_count 
FROM sys.indexes AS i
  INNER JOIN sys.objects AS o ON i.OBJECT_ID = o.OBJECT_ID
  INNER JOIN sys.dm_db_partition_stats AS ddps ON i.OBJECT_ID = ddps.OBJECT_ID
  AND i.index_id = ddps.index_id 
WHERE i.index_id < 2  AND o.is_ms_shipped = 0) r --ORDER BY ddps.row_count  desc
on f.TableName = r.name
Where f.IndexType = 'CLUSTERED INDEX'
order by f.avg_fragmentation_in_percent desc, r.row_count desc
