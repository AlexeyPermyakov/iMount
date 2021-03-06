
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.Список.РежимВыбора = Параметры.РежимВыбора;
	Если Параметры.МножественныйВыбор <> Неопределено Тогда
		Элементы.Список.МножественныйВыбор = Параметры.МножественныйВыбор;
	КонецЕсли;
	
	// Обход автоматического сохранения пользовательских настроек для разных режимов.
	Если Параметры.РежимВыбора И Не ЗначениеЗаполнено(Параметры.КлючПользовательскихНастроек) Тогда
		Параметры.КлючПользовательскихНастроек = "РежимВыбора";
		Список.АвтоматическоеСохранениеПользовательскихНастроек = Ложь;
	КонецЕсли;
	
КонецПроцедуры
