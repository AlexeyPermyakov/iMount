
#Область ПрограммныйИнтерфейс

Функция СоздатьБизнесПроцессНаОсновании(ИмяКоманды, Предмет = Неопределено) Экспорт
	
	Если НЕ СтрНачинаетсяС(ИмяКоманды, "лм_БизнесПроцесс_") Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	СтрокаИдентификатора = СтрЗаменить(Сред(ИмяКоманды, СтрДлина("лм_БизнесПроцесс_") + 1), "_", "-");
	ШаблонБизнесПроцесса = Справочники.лм_ШаблоныБизнесПроцессов.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаИдентификатора));
	Возврат лм_БизнесПроцессы.СоздатьБизнесПроцессПоШаблону(ШаблонБизнесПроцесса,,,,, Предмет);
	
КонецФункции

Функция ФормаНастройкиДействияОбработки(ТипДействия) Экспорт
	
	Возврат лм_БизнесПроцессы.ФормаНастройкиДействияОбработки(ТипДействия);
	
КонецФункции

#КонецОбласти