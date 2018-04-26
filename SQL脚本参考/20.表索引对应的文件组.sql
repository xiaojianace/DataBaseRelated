/*
     功能说明:查询如何统计当前instance， 
			 哪个库的哪些表使用分区表，以及分别使用了哪个分区schema， 
			 以及相对应的分区函数， 对应的文件组是什么。
*/
SELECT Object_name(p.object_id) AS ObjectName,
       i.name                   AS IndexName,
       p.index_id               AS IndexID,
       ds.name                  AS PartitionScheme,
       p.partition_number       AS PartitionNumber,
       fg.name                  AS FileGroupName,
       prv_left.value           AS LowerBoundaryValue,
       prv_right.value          AS UpperBoundaryValue,
       CASE pf.boundary_value_on_right
         WHEN 1 THEN 'RIGHT'
         ELSE 'LEFT'
       END                      AS Range,
       p.rows                   AS Rows
FROM   sys.partitions AS p
       JOIN sys.indexes AS i
         ON i.object_id = p.object_id
            AND i.index_id = p.index_id
       JOIN sys.data_spaces AS ds
         ON ds.data_space_id = i.data_space_id
       JOIN sys.partition_schemes AS ps
         ON ps.data_space_id = ds.data_space_id
       JOIN sys.partition_functions AS pf
         ON pf.function_id = ps.function_id
       JOIN sys.destination_data_spaces AS dds2
         ON dds2.partition_scheme_id = ps.data_space_id
            AND dds2.destination_id = p.partition_number
       JOIN sys.filegroups AS fg
         ON fg.data_space_id = dds2.data_space_id
       LEFT JOIN sys.partition_range_values AS prv_left
         ON ps.function_id = prv_left.function_id
            AND prv_left.boundary_id = p.partition_number - 1
       LEFT JOIN sys.partition_range_values AS prv_right
         ON ps.function_id = prv_right.function_id
            AND prv_right.boundary_id = p.partition_number
WHERE  Objectproperty(p.object_id, 'ISMSShipped') = 0
UNION ALL
--non-partitioned table/indexes
SELECT Object_name(p.object_id) AS ObjectName,
       i.name                   AS IndexName,
       p.index_id               AS IndexID,
       NULL                     AS PartitionScheme,
       p.partition_number       AS PartitionNumber,
       fg.name                  AS FileGroupName,
       NULL                     AS LowerBoundaryValue,
       NULL                     AS UpperBoundaryValue,
       NULL                     AS Boundary,
       p.rows                   AS Rows
FROM   sys.partitions AS p
       JOIN sys.indexes AS i
         ON i.object_id = p.object_id
            AND i.index_id = p.index_id
       JOIN sys.data_spaces AS ds
         ON ds.data_space_id = i.data_space_id
       JOIN sys.filegroups AS fg
         ON fg.data_space_id = i.data_space_id
WHERE  Objectproperty(p.object_id, 'ISMSShipped') = 0
ORDER  BY ObjectName,
          IndexID,
          PartitionNumber; 

--SP_HELP DLDBDMI  ----文件组是根据聚集索引来的