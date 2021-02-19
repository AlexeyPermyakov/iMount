#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ДокументыПоПравамВходные = Неопределено;
	ДокументыПоПравамПараметр = Параметры.Документы;
	
	Если ЗначениеЗаполнено(ДокументыПоПравамПараметр) Тогда
		Попытка
			ДокументыПоПравамВходные = гисРаботаСJson.ПрочитатьНативно(ДокументыПоПравамПараметр, гисРаботаСКадастром.ЗемельныеУчасткиПолучитьМассивСвойствДатаПраваНаУчастокДокументы());
		Исключение
			ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ДокументыПоПравамВходные) И ТипЗнч(ДокументыПоПравамВходные) = Тип("Массив") Тогда 
		Для Каждого ДокументПоПравам Из ДокументыПоПравамВходные Цикл
			НоваяСтрока = ДокументыПоПравам.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ДокументПоПравам);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьИзменения(Команда)
	ЭтотОбъект.Закрыть(ПолучитьJsonДляВозврата());
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПолучитьСтруктуруДокумента()
	Возврат гисРаботаСКадастром.ЗемельныеУчасткиПолучитьСтруктуруДанныхПраваНаУчастокДокументы();
КонецФункции

&НаСервере
Функция ПолучитьJsonДляВозврата()
	МассивДокументов = Новый Массив;
	Для Каждого ДокументПоПравам Из ДокументыПоПравам Цикл
		Документ = ПолучитьСтруктуруДокумента();
		ЗаполнитьЗначенияСвойств(Документ, ДокументПоПравам);
		МассивДокументов.Добавить(Документ);
	КонецЦикла;
	Возврат гисРаботаСJson.ЗаписатьНативно(МассивДокументов);
КонецФункции

#КонецОбласти
