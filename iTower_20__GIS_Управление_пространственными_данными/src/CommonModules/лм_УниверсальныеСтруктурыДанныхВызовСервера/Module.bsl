
#Область СлужебныйПрограммныйИнтерфейс

Процедура ЗаписатьУниверсальнуюСтруктуру(ДанныеСтруктуры) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);	
	СтандартнаяОбработка = Истина;
		
	лм_УниверсальныеСтруктурыДанныхПереопределяемый.ЗаписатьУниверсальнуюСтруктуру(СтандартнаяОбработка, ДанныеСтруктуры);	
	
	Если СтандартнаяОбработка Тогда
		лм_УниверсальныеСтруктурыДанных.ЗаписатьУниверсальнуюСтруктуру(ДанныеСтруктуры);	
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьДанныеУниверсальнойСтруктуры(ИдентификаторСтруктуры, ДополнительныеПараметры = Неопределено) Экспорт
	
	Возврат лм_УниверсальныеСтруктурыДанных.ПолучитьДанныеУниверсальнойСтруктуры(ИдентификаторСтруктуры, ДополнительныеПараметры);
	
КонецФункции

Процедура ПриПолученииДанныхУниверсальнойСтруктуры(УниверсальнаяСтруктура, ДополнительныеПараметры) Экспорт
	
	лм_УниверсальныеСтруктурыДанныхПереопределяемый.ПриПолученииДанныхУниверсальнойСтруктуры(УниверсальнаяСтруктура, ДополнительныеПараметры);
		
КонецПроцедуры

Процедура СформироватьДанныеСтруктурыВФоне(ИдентификаторСтруктуры, АдресСтруктуры, ВладелецСтруктуры, ДополнительныеПараметры = Неопределено) Экспорт
	
	Параметры = Новый Массив;
	Параметры.Добавить(ИдентификаторСтруктуры);
	Параметры.Добавить(АдресСтруктуры);
	Параметры.Добавить(ВладелецСтруктуры);
	Параметры.Добавить(ДополнительныеПараметры);
		
	ФоновыеЗадания.Выполнить("лм_УниверсальныеСтруктурыДанных.СформироватьДанныеСтруктурыВФоне", Параметры);
	
КонецПроцедуры

Процедура ВычислитьХешСуммуУниверсальнойСтруктуры(УниверсальнаяСтруктура) Экспорт
	
	ЗаписьXML = Новый ЗаписьXML();
	ЗаписьXML.УстановитьСтроку();
	СериализаторXDTO.ЗаписатьXML(ЗаписьXML, УниверсальнаяСтруктура);
	СтрокаXML = ЗаписьXML.Закрыть();		
	
	ХешСтруктуры = Новый ХешированиеДанных(ХешФункция.MD5);
	ХешСтруктуры.Добавить(СтрокаXML);
	
	УниверсальнаяСтруктура.ХешСумма = Строка(ХешСтруктуры.ХешСумма);
		
КонецПроцедуры

Функция ПроверитьСуществованиеУниверсальнойСтруктуры(ИдентификаторСтруктуры) Экспорт
	
	Возврат лм_УниверсальныеСтруктурыДанных.ПроверитьСуществованиеУниверсальнойСтруктуры(ИдентификаторСтруктуры);
		
КонецФункции

#КонецОбласти
