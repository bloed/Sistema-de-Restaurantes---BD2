-----------------BEGIN: Script to be run at Publisher 'LDA'-----------------
use [RESTAURANTES]
exec sp_addsubscription @publication = N'PublicacionRestaurantes', @subscriber = N'LDA', @destination_db = N'RESTAURANTESREPLICADA', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'PublicacionRestaurantes', @subscriber = N'LDA', @subscriber_db = N'RESTAURANTESREPLICADA', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 20151116, @active_end_date = 99991231, @enabled_for_syncmgr = N'False', @dts_package_location = N'Distributor'
GO
-----------------END: Script to be run at Publisher 'LDA'-----------------

