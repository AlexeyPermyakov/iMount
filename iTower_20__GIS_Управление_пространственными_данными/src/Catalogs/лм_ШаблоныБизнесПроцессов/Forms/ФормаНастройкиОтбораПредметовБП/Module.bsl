
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ТипПредмета")
			И ТипЗнч(Параметры.ТипПредмета) = Тип("СправочникСсылка.ИдентификаторыОбъектовМетаданных") Тогда
		СформироватьНастройкиОтбора(Параметры.ТипПредмета);
		Если Параметры.Свойство("НастройкиОтбора")
				И Параметры.НастройкиОтбора <> Неопределено
				И ТипЗнч(Параметры.НастройкиОтбора) = Тип("НастройкиКомпоновкиДанных") Тогда
			КомпоновщикНастроек.ЗагрузитьНастройки(Параметры.НастройкиОтбора);
		КонецЕсли;
	Иначе
		Отказ = Истина;
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Результат = ПолучитьНастройкиКомпоновщика();
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьНастройкиОтбора(ИдентификаторОбъектаМетаданных)
	
	АдресСхемыКомпоновкиДанных = лм_БизнесПроцессы.ПолучитьСхемуКомпоновкиДанныхОбъекта(ИдентификаторОбъектаМетаданных, УникальныйИдентификатор);
	СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновкиДанных);
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемыКомпоновкиДанных));
	КомпоновщикНастроек.ЗагрузитьНастройки(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
		
КонецПроцедуры

&НаСервере
Функция ПолучитьНастройкиКомпоновщика()
	
	Возврат КомпоновщикНастроек.ПолучитьНастройки();
	
КонецФункции

#КонецОбласти