/*sp_addmessage [ @msgnum= ] msg_id (arriba de 51000), [ @severity= ] severity (16), [ @msgtext= ] 'msg' 
     [ , [ @lang= ] 'language' ] 
     [ , [ @with_log= ] { 'TRUE' | 'FALSE' } ] 
     [ , [ @replace= ] 'replace' ] */
--FORMATO : RAISERROR(50001,16,1)
exec sp_addmessage  @msgnum=50001,
					@severity=16,
					@msgtext='Nombre de restaurante repetido. Esoja otro nombre.',
					@replace='replace',
					@lang = 'us_english'
exec sp_addmessage  @msgnum=50002,
					@severity=16,
					@msgtext='Categoria de restaurante no existe. Asegurase de escribirla bien.',
					@replace='replace',
					@lang = 'us_english'
exec sp_addmessage  @msgnum=50003,
					@severity=16,
					@msgtext='Cuadra no existe. Asegurase de escribirla bien. EJ: Cuadra1.',
					@replace='replace',
					@lang = 'us_english'
exec sp_addmessage  @msgnum=50004,
					@severity=16,
					@msgtext='Nombre de ingrediente repetido. Escoger otro.',
					@replace='replace',
					@lang = 'us_english'
exec sp_addmessage  @msgnum=50005,
					@severity=16,
					@msgtext='Categoria de ingrediente no existe. Asegurese de escribirlo bien.',
					@replace='replace',
					@lang = 'us_english'
exec sp_addmessage  @msgnum=50006,
					@severity=16,
					@msgtext='Nombre de ingrediente no existe. Asegurese de escribirlo bien.',
					@replace='replace',
					@lang = 'us_english'

select * from sys.messages where message_id > 50000--para ver los user defined messages