--left join of weather table on rides table

select * from dbo.addresses -- rides table
select * from dbo.joined_weather_data -- weather table

SELECT *
FROM dbo.addresses a
LEFT JOIN dbo.joined_weather_data b
ON CONVERT(DATE, a.date_time) = b.datetime
