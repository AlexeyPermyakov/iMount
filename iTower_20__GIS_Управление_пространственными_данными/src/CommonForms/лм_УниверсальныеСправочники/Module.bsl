

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СформироватьКомандыФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьСправочник(Команда)
	
	Отбор        = Новый Структура("ИмяКоманды", Команда.Имя);	
	СтрокиОтбора = КомандыФормы.НайтиСтроки(Отбор);
	
	ПараметрыФормы = Новый Структура("ВидСправочника", СтрокиОтбора[0].Ссылка);
	
	ФормаСписка = ПолучитьФорму("Справочник.лм_УниверсальныеСправочники.Форма.ФормаСписка", ПараметрыФормы, , Новый УникальныйИдентификатор);
	ФормаСписка.Открыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьКомандыФормы()
	
	ИмяПроцедурыФормы = "ОткрытьСправочник";
	Запрос            = Новый Запрос;
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	лм_ВидыУниверсальныхСправочников.Ссылка КАК Ссылка,
	               |	лм_ВидыУниверсальныхСправочников.Наименование КАК Наименование
	               |ИЗ
	               |	Справочник.лм_ВидыУниверсальныхСправочников КАК лм_ВидыУниверсальныхСправочников";
	
	Выборка = Запрос.Выполнить().Выбрать();
		
	Сч = 1;
	Пока Выборка.Следующий() Цикл
		Стр            = КомандыФормы.Добавить();
		ИмяКоманды     = "ОткрытьСправочник" + Строка(Формат(Сч, "ЧГ=0"));
		Стр.ИмяКоманды = ИмяКоманды;
		Стр.Ссылка     = Выборка.Ссылка;
		Сч = Сч + 1;
		
		НоваяКоманда           = Команды.Добавить(ИмяКоманды);
		НоваяКоманда.Действие  = ИмяПроцедурыФормы;
		НоваяКоманда.Заголовок = Выборка.Наименование;
		
		НовыйЭлемент            = Элементы.Вставить(ИмяКоманды,Тип("КнопкаФормы"));
		НовыйЭлемент.ИмяКоманды = ИмяКоманды;
		НовыйЭлемент.Заголовок  = Выборка.Наименование;
		НовыйЭлемент.Вид        = ВидКнопкиФормы.Гиперссылка;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
