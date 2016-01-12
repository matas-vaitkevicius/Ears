 declare @i int =0
    declare @lat int =0
      declare @long int =0
  while (@i < 10000000)
  begin
  set @lat =(select (0.9 -Rand()*1.8)*100)
 set @long =(select (0.9 -Rand()*1.8)*100)
    insert into TEst
  select geography::Point(@lat, @long,4326)
  
  
set @i =@i+1
 
 end

 
GO

CREATE SPATIAL INDEX [SpatialIndex-20160112-215249] ON [dbo].[Test]
(
	[coord]
)USING  GEOGRAPHY_GRID 
WITH (GRIDS =(LEVEL_1 = LOW,LEVEL_2 = MEDIUM,LEVEL_3 = LOW,LEVEL_4 = LOW), 
CELLS_PER_OBJECT = 16, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]

GO
print 'start'
 print cast(getdate() as time)
  DECLARE @g geography;


   declare @point nvarchar(50)  =''
 declare @i int =0
    declare @lat int =0
      declare @long int =0
  while (@i < 100)
  begin
  set @lat =(select (0.9 -Rand()*1.8)*100)
 set @long =(select (0.9 -Rand()*1.8)*100)
 set @point = (select 'POINT('+CONVERT(varchar(10), @lat)+ '  ' +CONVERT(varchar(10), @long)+')')
 SET @g = geography::STGeomFromText(@point, 4326);
    SELECT TOP 1000
        @g.STDistance(st.[coord]) AS [DistanceFromPoint (in meters)] 
    ,   st.[coord]
    ,   st.id
FROM    [Test] st 
WHERE   @g.STDistance(st.[coord]) <= 100000
ORDER BY @g.STDistance(st.[coord]) ASC
  
  print @i
set @i =@i+1
 
 end
 print cast(getdate() as time)
 print 'end'