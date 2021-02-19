
#Область ПрограммныйИнтерфейс

Процедура ПриИзмененииРеквизитаФормыЗадачи(Элемент, Форма, СоответствиеЗависимых, СоответствиеРеквизитов) Экспорт
	
	ИмяТаблицыСоставДанных = лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных();
	
	Если Элемент.Родитель <> Неопределено И Элемент.Родитель.Имя = ИмяТаблицыСоставДанных Тогда
		ТекущиеДанные = Элемент.Родитель.ТекущиеДанные;
		Если ТекущиеДанные <> Неопределено Тогда
			Форма[ТекущиеДанные.ИмяРеквизита] = ТекущиеДанные.НовоеЗначение;
		КонецЕсли;
	КонецЕсли;
	
	Если Элемент.Имя = "ПредметСсылка" Тогда
		ПерезаполнитьПоДаннымПредмета(Форма);		
	КонецЕсли;
	
	Если Элемент.Имя = "лм_ТаблицаСвязейЭлементМассиваНСИ" Тогда
		ТекущиеДанные                    = Элемент.Родитель.ТекущиеДанные;
		ТекущиеДанные.Связи_СтатусЗаписи = лм_БизнесПроцессыВызовСервераПереопределяемый.ЗначениеРеквизитаОбъекта(ТекущиеДанные.ЭлементМассиваНСИ, "СтатусЗаписи");
		ТекущиеДанные.КодЭлемента        = лм_БизнесПроцессыВызовСервераПереопределяемый.ЗначениеРеквизитаОбъекта(ТекущиеДанные.ЭлементМассиваНСИ, "Код");
	КонецЕсли;
	
	ПрефиксСвязанного = "лм_Связанный_";
	Если СтрЗаканчиваетсяНа(Элемент.Имя, "_Выбран") И Элемент.Родитель <> Неопределено И СтрНачинаетсяС(Элемент.Родитель.Имя, ПрефиксСвязанного) Тогда
		УстановитьЗначениеФлагаВыбран(Элемент, Форма, ПрефиксСвязанного);
	КонецЕсли;
	
	ОбновитьОтображениеСоставаДанных(Форма, СоответствиеЗависимых, СоответствиеРеквизитов);	
	
КонецПроцедуры

Процедура ВыполнитьПереопределяемуюКоманду(Команда, Форма) Экспорт
	
	Если СтрСравнить(Команда.Имя, "ВыполнитьНормализацию") = 0 Тогда
		ВыполнитьНормализациюДанных(Форма);
	КонецЕсли;
	
	Если СтрСравнить(Команда.Имя, "СкопироватьЗаявку") = 0 Тогда
		//РаботаСБизнесПроцессамиКлиент.СкопироватьЗаявку(Форма);
	КонецЕсли;
	
	Если СтрСравнить(Команда.Имя, "НормализоватьСвязаннуюЗапись") = 0 Тогда
		НормализоватьСвязаннуюЗапись(Форма);
	КонецЕсли;

КонецПроцедуры

Процедура ПриАктивизацииСтрокиТаблицыФормыЗадачи(Элемент, Форма) Экспорт
	
	Если Элемент.Имя = лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных() И Элемент.ТекущиеДанные <> Неопределено Тогда		
		Если Элемент.ТекущиеДанные.ТолькоПросмотр = Истина Тогда
			УстановитьСвойствоТолькоПросмотрВЯчейкеТаблицы(Элемент.ПодчиненныеЭлементы.лм_СоставДанныхНовоеЗначение, Истина);	
		Иначе
			УстановитьСвойствоТолькоПросмотрВЯчейкеТаблицы(Элемент.ПодчиненныеЭлементы.лм_СоставДанныхНовоеЗначение, Ложь);	
			Если Элемент.ТекущиеДанные.ИспользоватьОбработчикВыбора Тогда
				Элемент.ПодчиненныеЭлементы.лм_СоставДанныхНовоеЗначение.КнопкаВыбора         = Истина;
				Элемент.ПодчиненныеЭлементы.лм_СоставДанныхНовоеЗначение.РедактированиеТекста = Ложь;
			КонецЕсли;			
		КонецЕсли;
		
		Если Элемент.ТекущиеДанные.СтатусБПИндексКартинки = 0 Тогда
			УстановитьСвойствоТолькоПросмотрВЯчейкеТаблицы(Элемент.ПодчиненныеЭлементы.лм_СоставДанныхНовоеЗначение, Истина);
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

Процедура НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма) Экспорт
	
	ИмяТаблицыСоставДанных = лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных();
	
	Если Элемент.Родитель <> Неопределено И Элемент.Родитель.Имя = ИмяТаблицыСоставДанных Тогда
		ТекущиеДанные = Элемент.Родитель.ТекущиеДанные;
		Если ТекущиеДанные.ИспользоватьОбработчикВыбора Тогда
			ОбработчикЗаполненияЗначения = УправлениеЗначениямиВызовСервера.ЗначениеРеквизита(ТекущиеДанные.Поле, "ОбработчикЗаполненияЗначения");						
			ТекЗначение                  = ?(ДанныеВыбора <> Неопределено, ДанныеВыбора, Элемент.ТекстРедактирования);
			НачалоВыбораОбработчик(Элемент, ТекЗначение, СтандартнаяОбработка, Форма, ОбработчикЗаполненияЗначения, "НовоеЗначение", ТекущиеДанные, ТекущиеДанные.ТипЗначения);	
		КонецЕсли;
		
	ИначеЕсли Элемент.Родитель <> Неопределено Тогда
		МассивОбработчиков = лм_БизнесПроцессыКлиентСерверПереопределяемый.ОбработчикиПолейТаблиц();
		текРодитель = Элемент; // Инициализация поиска основного родителя элемента
		Пока текРодитель.Родитель <> Неопределено И ТипЗнч(текРодитель.Родитель) <> Тип("УправляемаяФорма") Цикл
			текРодитель        = текРодитель.Родитель;
			Отбор              = Новый Структура("ИмяТаблицы,ИмяПоля", текРодитель.Имя, Элемент.Имя);
			СтрокиОтбора       = лм_ОбщегоНазначенияКлиентСервер.НайтиСтрокиТаблицыОбъекта(МассивОбработчиков, Отбор);		
			Если СтрокиОтбора.Количество() <> 0 Тогда
				ТекущиеДанные    = текРодитель.ТекущиеДанные;
				СтрокаОбработчик = СтрокиОтбора[0];
				ТекЗначение      = ?(ДанныеВыбора <> Неопределено, ДанныеВыбора, Элемент.ТекстРедактирования);
				НачалоВыбораОбработчик(Элемент, ТекЗначение, СтандартнаяОбработка, Форма, СтрокаОбработчик.Обработчик, СтрокаОбработчик.ИмяРеквизита, ТекущиеДанные, СтрокаОбработчик.ТипЗначения);
				Прервать;	// Обработчик найден
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если ТипЗнч(Элемент) = Тип("ПолеФормы") Тогда
		ТипФайл = Тип("СправочникСсылка.лм_БизнесПроцессПрисоединенныеФайлы");
		ТипРеквизитаФормы = Неопределено;
		ТипыЗначенийРеквизита = Новый ОписаниеТипов;
		ИмяРеквизита = "";
		Если Элемент.Родитель.Имя = ИмяТаблицыСоставДанных Тогда
			ТипыЗначенийРеквизита = Элемент.Родитель.ТекущиеДанные.ТипЗначения;
			ИмяРеквизита = Элемент.Родитель.ТекущиеДанные.ИмяРеквизита;
		Иначе
			Если ТипЗнч(Элемент.Родитель) = Тип("ТаблицаФормы") Тогда
				ИмяПоляТаблицы    = Прав(Элемент.Имя, СтрДлина(Элемент.Имя) - СтрДлина(Элемент.Родитель.Имя));
				ТипРеквизитаФормы = ТипЗнч(Элемент.Родитель.ТекущиеДанные[ИмяПоляТаблицы]);
			ИначеЕсли ТипЗнч(Элемент.Родитель) <> Тип("ГруппаФормы") Тогда 
		    	ТипРеквизитаФормы = ТипЗнч(Форма[Элемент.Имя]);
			КонецЕсли;
		КонецЕсли;
		
		Если ТипРеквизитаФормы = ТипФайл ИЛИ ТипыЗначенийРеквизита.СодержитТип(ТипФайл) Тогда
			НачалоВыбораФайла(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма, ИмяРеквизита);
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

Процедура Выбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, Форма) Экспорт
	
	Если Поле.Имя = "лм_СоставДанныхСтатусБП" Тогда
		ТекущиеДанные = Элемент.ТекущиеДанные;
		Если ТекущиеДанные.СтатусБПИндексКартинки = 1 Тогда
			ВыполнитьЗапускПодпроцесса(Элемент, Элемент.ТекущиеДанные, Форма);
		ИначеЕсли ТекущиеДанные.СтатусБПИндексКартинки = 0 Тогда
			ОткрытьФормуПодпроцесса(Форма, Элемент.ТекущиеДанные);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник, Форма) Экспорт
	
	Если ИмяСобытия = "РедактированиеЗначения" Тогда
		ИмяТаблицыСоставДанных = лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных();
		ТекущиеДанные = Форма.Элементы[ИмяТаблицыСоставДанных].ТекущиеДанные;
		Если ТекущиеДанные <> Неопределено Тогда
			Форма[ТекущиеДанные.ИмяРеквизита] = ТекущиеДанные.НовоеЗначение;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередНачаломДобавленияСтрокиТаблицыФормыЗадачи(Элемент, Отказ, Копирование, Родитель, Группа, Параметр, Форма) Экспорт
	
	
КонецПроцедуры

Процедура ПередУдалениемСтрокиТаблицыФормыЗадачи(Элемент, Отказ, Форма) Экспорт
	
	Если Элемент.Имя = "лм_ТаблицаСвязей" Тогда
		Отказ                           = Истина;
		Элемент.ТекущиеДанные.КУдалению = Не Элемент.ТекущиеДанные.КУдалению;
	КонецЕсли;
		
КонецПроцедуры

Процедура ПриОткрытииФормыЗадачи(Форма) Экспорт
	
	ОбновитьОтображениеСоставаДанных(Форма);	
	
КонецПроцедуры

Процедура ПослеЗакрытияПодчиненнойФормы(Форма, Результат, ДополнительныеПараметры, СоответствиеЗависимых, СоответствиеРеквизитов) Экспорт
	
	ИмяФормы = "";
	ДополнительныеПараметры.Свойство("ИмяФормы", ИмяФормы);
	
	Если ИмяФормы = "ОбщаяФорма.НормализацияЗаписи" Тогда
		ПрименитьРезультатНормализации(Форма, Результат, СоответствиеЗависимых, СоответствиеРеквизитов);
	ИначеЕсли ИмяФормы = "ОбщаяФорма.НормализоватьСвязаннуюЗапись" Тогда
		ПрименитьРезультатНормализацииСвязанной(Форма, Результат, СоответствиеЗависимых, СоответствиеРеквизитов, ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриПолученииНастроекДействияТочкиОбработки(ТипДействия, НастройкаДействия) Экспорт
	
	Если ТипДействия = ПредопределенноеЗначение("Перечисление.лм_ТипыДействийТочкиОбработки.ЗаписьДанныхСправочникаНСИ")
		 ИЛИ ТипДействия = ПредопределенноеЗначение("Перечисление.лм_ТипыДействийТочкиОбработки.ИнициализацияДанныхСправочникаНСИ")
		 ИЛИ ТипДействия = ПредопределенноеЗначение("Перечисление.лм_ТипыДействийТочкиОбработки.ПереносПрисоединенныхФайловВЗаписьСправочникаНСИ") Тогда
		НастройкаДействия = Новый Структура;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеИнтерактивногоСозданияБизнесПроцесса(БизнесПроцесс) Экспорт
	
	ЗадачиПользователя = лм_БизнесПроцессыВызовСервераПереопределяемый.ЗадачиТекущегоПользователя(БизнесПроцесс);
	Если ЗадачиПользователя.Количество() > 0 Тогда
		Для Каждого Задача Из ЗадачиПользователя Цикл
			ПараметрыФормы = Новый Структура("Ключ", Задача);
			ОткрытьФорму("БизнесПроцесс.лм_БизнесПроцесс.Форма.ДействиеВыполнить", ПараметрыФормы);
		КонецЦикла;
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'Созданный бизнес-процесс не содержит задач для текущего пользователя на первом этапе'"));
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриОкончанииРедактированияСтрокиТаблицы(Форма, Элемент, НоваяСтрока, ОтменаРедактирования) Экспорт
	
// Подсистема MDMЯдро
	//Если СтрСравнить(Элемент.Имя, "лм_ТаблицаПереходныхКлючей") = 0 Тогда
	//	текДанные = Элемент.ТекущиеДанные;
	//	Если текДанные <> Неопределено Тогда
	//		сткПереходныйКлюч = ИнтеграцияКлиентСервер.Новый_ПереходныйКлюч();
	//		ЗаполнитьЗначенияСвойств(сткПереходныйКлюч, текДанные);
	//		
	//		// Сформируем коллекцию переходных ключей из данных формы
	//		дфкТПК = Форма.лм_ТаблицаПереходныхКлючей;
	//		
	//		// Добавим измененную строку в коллекцию переходных ключей
	//		ИнтеграцияВызовСервера.ДобавитьПереходныйКлючВТаблицуПереходныхКлючей(дфкТПК, сткПереходныйКлюч);
	//		
	//		// Перенесем данные в данные формы
	//		КопироватьДанныеФормы(дфкТПК, Форма.лм_ТаблицаПереходныхКлючей);
	//	КонецЕсли;
	//КонецЕсли;
// Конец Подсистема MDMЯдро

КонецПроцедуры

Процедура ПриНачалеРедактированияСтрокиТаблицы(Форма, Элемент, НоваяСтрока, Копирование) Экспорт
	
	// Здесь заполняются реквизиты ТЧ, которые были заполнены как предопределенные
	Попытка
		ИмяРеквизитаАдреса			= лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяРеквизитаПредзаполненныхДанных();		
		мсвПредзаполненныеЗначения	= ПолучитьИзВременногоХранилища(Форма[ИмяРеквизитаАдреса]);
	Исключение	
		Возврат;
	КонецПопытки;
	
	Если мсвПредзаполненныеЗначения.Количество() Тогда
		ТекущиеДанные = Элемент.ТекущиеДанные;
		Для каждого сткПредопределенноеЗначение Из мсвПредзаполненныеЗначения Цикл
			Для каждого КлючИЗначение Из сткПредопределенноеЗначение Цикл
				Если ТекущиеДанные.Свойство(КлючИЗначение.Ключ) Тогда
					Если НЕ ЗначениеЗаполнено(ТекущиеДанные[КлючИЗначение.Ключ]) И ЗначениеЗаполнено(КлючИЗначение.Значение) Тогда
						ТекущиеДанные[КлючИЗначение.Ключ] = КлючИЗначение.Значение;	
					КонецЕсли; 
				Иначе
					Прервать;
				КонецЕсли; 	
			КонецЦикла;
		КонецЦикла; 
	КонецЕсли; 

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура УстановитьЗначениеФлагаВыбран(Элемент, Форма, ПрефиксСвязанного)
	
	ИмяСвязанного      = Сред(Элемент.Родитель.Имя, СтрДлина(ПрефиксСвязанного) + 1);
	ИмяРеквизитаВыбран = ИмяСвязанного + "_Выбран";
	ТекЗначение        = Элемент.Родитель.ТекущиеДанные[ИмяРеквизитаВыбран];
	
	Если ТекЗначение = Истина Тогда
		ТаблицаСвязанного = Форма[Элемент.Родитель.Имя];
		КоличествоСтрок   = ТаблицаСвязанного.Количество();		
		Сч = 0;
		Пока Сч < КоличествоСтрок Цикл
			Если Сч = Элемент.Родитель.ТекущаяСтрока Тогда
				Сч = Сч + 1;
				Продолжить;				
			КонецЕсли;
			ТаблицаСвязанного[Сч][ИмяРеквизитаВыбран] = Ложь;
			Сч = Сч + 1;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьСвойствоТолькоПросмотрВЯчейкеТаблицы(Элемент, ЗначениеСвойства)
	
	Если ЗначениеСвойства = Истина Тогда
		Элемент.РедактированиеТекста = Ложь;
		Элемент.КнопкаВыпадающегоСписка = Ложь;
		Элемент.КнопкаВыбора = Ложь;
		Элемент.КнопкаОчистки = Ложь;
		Элемент.КнопкаРегулирования = Ложь;
		Элемент.КнопкаСоздания = Ложь;
		Элемент.ИсторияВыбораПриВводе = ИсторияВыбораПриВводе.НеИспользовать;		
	Иначе
		Элемент.РедактированиеТекста = Истина;
		Элемент.КнопкаВыпадающегоСписка = Неопределено;
		Элемент.КнопкаВыбора = Неопределено;
		Элемент.КнопкаОчистки = Неопределено;
		Элемент.КнопкаРегулирования = Неопределено;
		Элемент.КнопкаСоздания = Неопределено;
		Элемент.ИсторияВыбораПриВводе = ИсторияВыбораПриВводе.Авто;		
	КонецЕсли;
		
КонецПроцедуры

Процедура ВыполнитьЗапускПодпроцесса(Элемент, ТекущиеДанные, Форма)
	
	СписокШаблонов = Неопределено;
	МассивТипов = ТекущиеДанные.ТипЗначения.Типы();
	
	Для Каждого Тип Из МассивТипов Цикл
		Если Тип <> Тип("СправочникСсылка.ИдентификаторыОбъектовМетаданных") Тогда
			СписокШаблонов = лм_БизнесПроцессыВызовСервераПереопределяемый.ПолучитьСписокШаблоновДляЗапускаПодпроцесса(Тип);
			Прервать;
		КонецЕсли;		
	КонецЦикла;
	
	Если СписокШаблонов <> Неопределено И СписокШаблонов.Количество() <> 0 Тогда
		Шаблон = СписокШаблонов[0].Значение;
		Подпроцесс = лм_БизнесПроцессыВызовСервераПереопределяемый.СоздатьБизнесПроцессПоШаблону(Шаблон);
		Если Подпроцесс <> Неопределено Тогда
			лм_БизнесПроцессыКлиент.ПослеИнтерактивногоСозданияБизнесПроцесса(Подпроцесс);
		КонецЕсли;
		ТекущиеДанные.СтатусБПИндексКартинки = 0;
		ТаблицаПодпроцессов = Форма[лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыПодпроцессов()];
		Стр = ТаблицаПодпроцессов.Добавить();
		Стр.Подпроцесс = Подпроцесс;
		Стр.ИмяПоля = ТекущиеДанные.Поле;
		УстановитьСвойствоТолькоПросмотрВЯчейкеТаблицы(Элемент.ПодчиненныеЭлементы.лм_СоставДанныхНовоеЗначение, Истина);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОткрытьФормуПодпроцесса(Форма, ТекущиеДанные)
	
	ТаблицаПодпроцессов = Форма[лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыПодпроцессов()];
	
	Для Каждого Стр Из ТаблицаПодпроцессов Цикл
		Если Стр.ИмяПоля = ТекущиеДанные.Поле Тогда
			ПараметрыФормы = Новый Структура("Ключ", Стр.Подпроцесс);
			ОткрытьФорму("БизнесПроцесс.лм_БизнесПроцесс.ФормаОбъекта", ПараметрыФормы);
			Прервать;
		КонецЕсли;
	КонецЦикла;
			
КонецПроцедуры

Процедура ОбновитьОтображениеСоставаДанных(Форма, СоответствиеЗависимых = Неопределено, СоответствиеРеквизитов = Неопределено)
		
	Попытка
		ИмяТаблицыДанных             = лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных();
		СоставДанных                 = Форма[ИмяТаблицыДанных];
		ЭлементыФормы                = Форма.Элементы;
		ТаблицаДанных                = ЭлементыФормы[ИмяТаблицыДанных];
		ГруппаУниверсальныеСтруктуры = ЭлементыФормы["ГруппаУниверсальныеСтруктуры"];
		ВариантСортировки            = Форма[лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяРеквизитаВариантСортировкиАтрибутовСправочникаНСИ()];
	Исключение
		Возврат;
	КонецПопытки;
	
	Для Каждого Элемент Из ГруппаУниверсальныеСтруктуры.ПодчиненныеЭлементы Цикл
		Если ТипЗнч(Элемент) = Тип("ПолеФормы") Тогда
			Элемент.Видимость = Ложь;
		КонецЕсли;
	КонецЦикла;
		
	Если СоответствиеЗависимых <> Неопределено Тогда
		
		стрДанныеПредмета = Новый Структура;
		Если ЗначениеЗаполнено(Форма.Объект.Предмет) Тогда
			Если Не Форма.Объект.Выполнена Тогда
				стрДанныеПредмета = ПолучитьИзВременногоХранилища(Форма.АдресДанныхПредмета);
			Иначе
				стрДанныеПредмета = лм_БизнесПроцессыВызовСервераПереопределяемый.ПолучитьСтруктуруДанныхПредметаИзПараметров(Форма.Объект.Ссылка);
			КонецЕсли;
		КонецЕсли;
				
		СоответствиеСтрокТаблицыДанных = Новый Соответствие;
		Для Каждого Стр Из СоставДанных Цикл
			СоответствиеСтрокТаблицыДанных.Вставить(Стр.ИмяРеквизита, Стр);	
		КонецЦикла;
				
		ДанныеЗависимостей                  = лм_УниверсальныеСтруктурыДанныхКлиентСервер.ПолучитьДанныеЗависимостей(Форма, СоответствиеЗависимых);
		МассивДоступныхТиповДляПодпроцессов = лм_БизнесПроцессыВызовСервераПереопределяемый.СформироватьМассивДоступныхТиповДляПодпроцессов();
		ТаблицаПодпроцессов                 = Форма[лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыПодпроцессов()];
				
		Для Каждого ДанныеЗависимости Из ДанныеЗависимостей Цикл
			
			СтрокаСостава = СоответствиеСтрокТаблицыДанных[ДанныеЗависимости.Ключ];
			
			Если СтрокаСостава = Неопределено И ДанныеЗависимости.Значение.Видимость = Истина Тогда
				ИмяРеквизита  = Сред(ДанныеЗависимости.Ключ, 4);
				СтрокаСостава = лм_БизнесПроцессыКлиентСерверПереопределяемый.ДобавитьСтрокуСоставаДанных(Форма, СоставДанных, СоответствиеРеквизитов[ИмяРеквизита], МассивДоступныхТиповДляПодпроцессов, ТаблицаПодпроцессов, стрДанныеПредмета);
			КонецЕсли;
			
			Если СтрокаСостава <> Неопределено Тогда
				ЗаполнитьЗначенияСвойств(СтрокаСостава, ДанныеЗависимости.Значение);
			КонецЕсли;
		КонецЦикла;
				
	КонецЕсли;
			
	ПрименитьНастройкиОтображенияТочки(Форма, СоставДанных, ТаблицаДанных);
	
	ВыполнитьСортировкуАтрибутов(СоставДанных, ВариантСортировки);
	
КонецПроцедуры

Процедура ВыполнитьСортировкуАтрибутов(СоставДанных, ВариантСортировки)
	
	Отбор                = Новый Структура("ВидДанных", "Классификатор");
	СтрокиКлассфикаторов = СоставДанных.НайтиСтроки(Отбор);
	
	Сч = 1;
	
	Для Каждого Стр Из СоставДанных Цикл
		Если Стр.ВидДанных = "ДополнительноеСвойство" Тогда
			Стр.Порядок = 1;
		Иначе
			Стр.Порядок = Сч;
			Сч = Сч + 1;	
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Стр Из СтрокиКлассфикаторов Цикл
		Если ЗначениеЗаполнено(Стр.Поле) Тогда
			МассивАтрибутов = лм_БизнесПроцессыВызовСервераПереопределяемый.ПолучитьТаблицуПорядкаАтрибутовПоКлассификатору(Стр.НовоеЗначение, ВариантСортировки);
			Для Каждого Атрибут Из МассивАтрибутов Цикл
				ОтборАтрибута = Новый Структура("Поле", Атрибут);
				СтрокиОтбора  = СоставДанных.НайтиСтроки(ОтборАтрибута);
				Если СтрокиОтбора.Количество() <> 0 Тогда
					СтрокиОтбора[0].Порядок = Сч;
					Сч = Сч + 1;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	СоставДанных.Сортировать("Порядок");
		
КонецПроцедуры

Процедура ПрименитьНастройкиОтображенияТочки(Форма, СоставДанных, ТаблицаДанных)
	
	ТаблицаНастроекОтображения = Форма[лм_БизнесПроцессыКлиентСервер.ИмяТаблицыНастроекОтображения()];	
	лм_БизнесПроцессыКлиентСерверПереопределяемый.УстановитьОтображениеСоставаДанных(СоставДанных, ТаблицаНастроекОтображения);
	
	ОтборСтрок = Новый ФиксированнаяСтруктура("Видимость", Истина);
	ТаблицаДанных.ОтборСтрок = ОтборСтрок;
		
КонецПроцедуры

Процедура ВыполнитьНормализациюДанных(Форма)
	
	//Сообщения = Новый Массив();
	//	
	//Данные = Новый Массив();
	//СоставДанных = Форма[лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных()];
	//Для Каждого ЭлементКоллекции Из СоставДанных Цикл
	//	Запись = УправлениеНСИКлиентСервер.СтруктураНастройкиСправочникаСоЗначением();
	//	Запись.Имя = ЭлементКоллекции.Поле;
	//	Запись.Представление = ЭлементКоллекции.Наименование;
	//	Запись.ОписаниеТипа = ЭлементКоллекции.ТипЗначения;
	//	Запись.ВидДанных = ЭлементКоллекции.ВидДанных;
	//	Запись.Значение = ЭлементКоллекции.НовоеЗначение;
	//	Данные.Добавить(Запись);
	//КонецЦикла;
	//
	//Объект = Форма.Объект;
	//РезультатПроверкиПравил = лм_БизнесПроцессыВызовСервераПереопределяемый.ПроверкаПравилНормализацииКлассификационныхГруппировок(Объект.Ссылка, Данные, Сообщения);	
	//	
	//ДополнительныеПараметры = Новый Структура();
	//ДополнительныеПараметры.Вставить("ИмяФормы", "ОбщаяФорма.НормализацияЗаписи");
	//	
	//ОткрытьФорму(
	//	"ОбщаяФорма.НормализацияЗаписи",
	//	// todo: когда будет понимание с формой элемента, БизнесПроцесс переименовать в Контекст
	//	Новый Структура("Запись, РезультатПроверкиПравил, БизнесПроцесс",
	//		Объект.Предмет,
	//		РезультатПроверкиПравил,
	//		Объект.БизнесПроцесс),
	//	,
	//	,
	//	,
	//	,
	//	Новый ОписаниеОповещения("Подключаемый_ПослеЗакрытияПодчиненнойФормы", Форма, ДополнительныеПараметры)
	//);
	//
КонецПроцедуры

Процедура НормализоватьСвязаннуюЗапись(Форма)
	
	Сообщения = Новый Массив();
	Данные = Новый Массив();
	СсылкаНаПроверяемыйОбъект = Неопределено;
	ствРеквизиты = ПолучитьИзВременногоХранилища(Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяРеквизитаСоответствияРеквизитов()]);

	ТекущийЭлемент = Форма.ТекущийЭлемент;
		
	Если НЕ ТипЗнч(ТекущийЭлемент) = Тип("ТаблицаФормы") Тогда
		Возврат;
	КонецЕсли;
	
	Если СтрНачинаетсяС(ТекущийЭлемент.Имя, "лм_" + РаботаСБизнесПроцессамиКлиентСервер.ПрефиксРеквизитаСвязанныеЭлементы()) Тогда
		ТекущиеДанные = ТекущийЭлемент.ТекущиеДанные;	
		Если ТекущиеДанные = Неопределено Тогда
			Возврат;
		КонецЕсли;
		Префикс = СтрЗаменить(ТекущийЭлемент.Имя, "лм_" + РаботаСБизнесПроцессамиКлиентСервер.ПрефиксРеквизитаСвязанныеЭлементы(), "") + "_";
		
		Для каждого Реквизит Из ствРеквизиты Цикл
			Если СтрНачинаетсяС(Реквизит.Ключ, Префикс) Тогда
				Если Реквизит.Ключ = Префикс + "Выбран" Тогда
					Продолжить;	
				КонецЕсли;
				ВидДанных = "";
				//Если СтрНачинаетсяС(Реквизит.Ключ, Префикс + УправлениеНСИКлиентСервер.ВидДанныхКлассификатор()) Тогда
				//	ВидДанных = УправлениеНСИКлиентСервер.ВидДанныхКлассификатор();
				//	Имя = СтрЗаменить(Реквизит.Ключ, Префикс + УправлениеНСИКлиентСервер.ВидДанныхКлассификатор() + "_", "");
				//Иначе
					ВидДанных = УправлениеНСИКлиентСервер.ВидДанныхРеквизит();;		
					Имя = СтрЗаменить(Реквизит.Ключ, Префикс, "");
				//КонецЕсли; 
				Запись = УправлениеНСИКлиентСервер.СтруктураНастройкиСправочникаСоЗначением();
				Запись.Имя = Имя;
				Запись.Значение = ТекущиеДанные[Реквизит.Значение.ИмяПоля];
				Запись.ОписаниеТипа = ТипЗнч(ТекущиеДанные[Реквизит.Значение.ИмяПоля]);
				Запись.Представление = Реквизит.Значение.Синоним;			
				Запись.ВидДанных = ВидДанных;  
				Данные.Добавить(Запись);

				Если Запись.Имя = "Ссылка" Тогда
					СсылкаНаПроверяемыйОбъект = Запись.Значение;
				КонецЕсли; 
			КонецЕсли; 	
		КонецЦикла; 
				
		Объект = Форма.Объект;
		РезультатПроверкиПравил = лм_БизнесПроцессыВызовСервераПереопределяемый.ПроверкаПравилНормализацииКлассификационныхГруппировокСвязанных(Объект.Ссылка, Данные, Сообщения, СсылкаНаПроверяемыйОбъект);	
			
		ДополнительныеПараметры = Новый Структура();
		ДополнительныеПараметры.Вставить("ИмяФормы", "ОбщаяФорма.НормализоватьСвязаннуюЗапись");
		ДополнительныеПараметры.Вставить("ИмяТаблицыДанных", ТекущийЭлемент.Имя);
		ДополнительныеПараметры.Вставить("Префикс", Префикс);
		ДополнительныеПараметры.Вставить("ТекущаяСтрока", ТекущийЭлемент.ТекущаяСтрока);
			
		ОткрытьФорму(
			"ОбщаяФорма.НормализацияЗаписи",
			Новый Структура("РезультатПроверкиПравил", РезультатПроверкиПравил),
			,
			,
			,
			,
			Новый ОписаниеОповещения("Подключаемый_ПослеЗакрытияПодчиненнойФормы", Форма, ДополнительныеПараметры)
		);
		
	КонецЕсли; 
	
КонецПроцедуры

Процедура ПрименитьРезультатНормализацииСвязанной(Форма, Результат, СоответствиеЗависимых, СоответствиеРеквизитов, ДополнительныеПараметры)
	
	ИмяТаблицыДанных = ДополнительныеПараметры.ИмяТаблицыДанных; 
	Префикс = ДополнительныеПараметры.Префикс;
	ТекущаяСтрока = ДополнительныеПараметры.ТекущаяСтрока;
	
	Если Результат <> Неопределено И ТипЗнч(Результат) = Тип("Структура") Тогда		
		СоставДанных = Форма[ИмяТаблицыДанных];			
		Если Результат.Итог <> Неопределено Тогда
			Для Каждого СтрокаДанных Из Результат.Итог Цикл
				Если СтрокаДанных.ВидДанных = "Реквизит" Тогда
					ИмяРеквизита = Префикс + лм_СтроковыеФункцииКлиентСервер.ПолучитьВалидныйИдентификатор(СтрокаДанных.Имя);	
				Иначе
					Продолжить;
				КонецЕсли;
				
				Если СоставДанных[ТекущаяСтрока].Свойство(ИмяРеквизита) Тогда
					СоставДанных[ТекущаяСтрока][ИмяРеквизита] = СтрокаДанных.Значение;	
				КонецЕсли; 
			КонецЦикла;
		КонецЕсли;	
	КонецЕсли;	
	
КонецПроцедуры



Процедура ПерезаполнитьПоДаннымПредмета(Форма)
	
	Предмет                                                                          = Форма.Объект.Предмет;
	ИмяТаблицыДанных                                                                 = лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных();
	СоставДанных                                                                     = Форма[ИмяТаблицыДанных];
	ЭлементСоставДанных                                                              = Форма.Элементы[ИмяТаблицыДанных];
	ЭлементСоставДанных.ПодчиненныеЭлементы.лм_СоставДанныхТекущееЗначение.Видимость = ЗначениеЗаполнено(Предмет);
	АдресСтруктурыДанных	= Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяРеквизитаАдресаУниверсальнойСтруктуры()];
	СтруктураДанных			= ПолучитьИзВременногоХранилища(АдресСтруктурыДанных);
	
	СпециальныеРеквизиты = ПолучитьМассивСпециальныхРеквизитов();
	
	Для Каждого Стр Из СоставДанных Цикл
		Стр.ТекущееЗначение = Неопределено; 
		Отбор = Новый Структура("ИмяРеквизита", Стр.ИмяРеквизита);
		СтрокиОтбора = лм_ОбщегоНазначенияКлиентСервер.НайтиСтрокиТаблицыОбъекта(СпециальныеРеквизиты, Отбор);
		Если СтрокиОтбора.Количество() <> 0 Тогда
			Стр.НовоеЗначение = "";
			Форма[Стр.ИмяРеквизита] = "";
		КонецЕсли;
	КонецЦикла;
	
	сткДанныеСправочникаНСИ		= Новый Структура;
	
	Если ЗначениеЗаполнено(Предмет) Тогда
		ДанныеПредмета            = лм_БизнесПроцессыВызовСервераПереопределяемый.ПолучитьСтруктуруДанныхПредмета(Предмет);
		
		лм_БизнесПроцессыВызовСервераПереопределяемый.ПриЗаполненииДанныхСправочникаНСИ(сткДанныеСправочникаНСИ, Предмет, СтруктураДанных[0]);
		
		Форма.АдресДанныхПредмета = ПоместитьВоВременноеХранилище(ДанныеПредмета, Форма.УникальныйИдентификатор);
	Иначе
		Форма.АдресДанныхПредмета = "";
	КонецЕсли;
	
	Для Каждого сткОписаниеРеквизита Из СтруктураДанных[0].Реквизиты Цикл
		ИмяРеквизита		= сткОписаниеРеквизита.ИмяПоля;
		ИмяРеквизитаФормы	= "лм_" + ИмяРеквизита;
		
		ЗначениеРеквизита = Неопределено;
		Если сткДанныеСправочникаНСИ.Свойство(ИмяРеквизита) Тогда
			ЗначениеРеквизита = сткДанныеСправочникаНСИ[ИмяРеквизита];
		КонецЕсли;
		
		// Состав данных
		СтрокиСостава = СоставДанных.НайтиСтроки(Новый Структура("ИмяРеквизита", ИмяРеквизитаФормы));
		Если СтрокиСостава.Количество() > 0 Тогда
			СтрокаСостава = СтрокиСостава[0]; 
			СтрокаСостава.ТекущееЗначение = ЗначениеРеквизита;
			
			Отбор = Новый Структура("ИмяПоля", ИмяРеквизита);
			СтрокиОтбора = лм_ОбщегоНазначенияКлиентСервер.НайтиСтрокиТаблицыОбъекта(СпециальныеРеквизиты, Отбор);				
			Если СтрокиОтбора.Количество() <> 0 Тогда
				СтрокаСостава.НовоеЗначение = ЗначениеРеквизита;
				Форма[СтрокиОтбора[0].ИмяРеквизита] = ЗначениеРеквизита;
			КонецЕсли;
		КонецЕсли;
		
		// Связанный справочник
		Если РаботаСБизнесПроцессамиКлиентСервер.ЭтоРеквизитСвязанныеЭлементы(ИмяРеквизита) Тогда
			// удалим с формы данные предыдущего предмета
			сткДопПараметры = Новый Структура;
			ИмяРеквизитаТаблицы	= ИмяРеквизитаФормы;
			ИмяРеквизитаСсылка	= РаботаСБизнесПроцессамиКлиентСервер.ИмяРеквизитаСсылка_РеквизитаСвязанныеЭлементы(ИмяРеквизита);
			
			ТаблицаРеквизита = Форма[ИмяРеквизитаТаблицы];
			
			// Удалим с формы данные предыдущего предмета
			мсвСтрокиДляУдаления = Новый Массив;
			Для Каждого стрРеквизит Из ТаблицаРеквизита Цикл
				Если ЗначениеЗаполнено(стрРеквизит[ИмяРеквизитаСсылка]) Тогда
					мсвСтрокиДляУдаления.Добавить(стрРеквизит);
				КонецЕсли;
			КонецЦикла;
			Для Каждого стрРеквизит Из мсвСтрокиДляУдаления Цикл
				ТаблицаРеквизита.Удалить(стрРеквизит);
			КонецЦикла;
			
			// Добавим данные текущего предмета
			Если ТипЗнч(ЗначениеРеквизита) = Тип("Массив") Тогда
				Для Каждого сткРеквизитаИсточник Из ЗначениеРеквизита Цикл
					стрРеквизит = ТаблицаРеквизита.Добавить();
					
					сткДопПараметры.Очистить();
					Для Каждого кзРеквизит Из сткРеквизитаИсточник Цикл
						сткДопПараметры.Вставить(кзРеквизит.Ключ + "_Текущий", кзРеквизит.Значение);
					КонецЦикла;
					
					ЗаполнитьЗначенияСвойств(стрРеквизит, сткДопПараметры);
					ЗаполнитьЗначенияСвойств(стрРеквизит, сткРеквизитаИсточник);
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
		// Таблица переходных ключей
		Если СтрСравнить(ИмяРеквизита, "ТаблицаПереходныхКлючей") = 0 Тогда
			сткДопПараметры = Новый Структура;
			ИмяРеквизитаТаблицы	= ИмяРеквизитаФормы;
			
			ТаблицаРеквизита = Форма[ИмяРеквизитаТаблицы];
			
			// Удалим с формы данные предыдущего предмета
			мсвСтрокиДляУдаления = Новый Массив;
			Для Каждого стрРеквизит Из ТаблицаРеквизита Цикл
				Если стрРеквизит.Выбран = Истина Тогда
					мсвСтрокиДляУдаления.Добавить(стрРеквизит);
				КонецЕсли;
			КонецЦикла;
			Для Каждого стрРеквизит Из мсвСтрокиДляУдаления Цикл
				ТаблицаРеквизита.Удалить(стрРеквизит);
			КонецЦикла;
			
			// Добавим данные текущего предмета
			Если ТипЗнч(ЗначениеРеквизита) = Тип("Массив") Тогда
				Для Каждого сткРеквизитаИсточник Из ЗначениеРеквизита Цикл
					стрРеквизит = ТаблицаРеквизита.Добавить();
					
					сткДопПараметры.Очистить();
					Для Каждого кзРеквизит Из сткРеквизитаИсточник Цикл
						сткДопПараметры.Вставить(кзРеквизит.Ключ + "_Текущий", кзРеквизит.Значение);
					КонецЦикла;
					
					ЗаполнитьЗначенияСвойств(стрРеквизит, сткДопПараметры);
					ЗаполнитьЗначенияСвойств(стрРеквизит, сткРеквизитаИсточник);
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
		// Таблица связей
		Если СтрСравнить(ИмяРеквизита, "ТаблицаСвязей") = 0 Тогда
			ТаблицаРеквизита = Форма[ИмяРеквизитаФормы];
			
			// Удалим с формы данные предыдущего предмета
			мсвСтрокиДляУдаления = Новый Массив;
			Для Каждого стрРеквизит Из ТаблицаРеквизита Цикл
				Если стрРеквизит.Связи_Выбран = Истина Тогда
					мсвСтрокиДляУдаления.Добавить(стрРеквизит);
				КонецЕсли;
			КонецЦикла;
			Для Каждого стрРеквизит Из мсвСтрокиДляУдаления Цикл
				ТаблицаРеквизита.Удалить(стрРеквизит);
			КонецЦикла;
			
			// Добавим данные текущего предмета
			Если ТипЗнч(ЗначениеРеквизита) = Тип("Массив") Тогда
				Для Каждого сткРеквизитаИсточник Из ЗначениеРеквизита Цикл
					стрРеквизит = ТаблицаРеквизита.Добавить();						
					ЗаполнитьЗначенияСвойств(стрРеквизит, сткРеквизитаИсточник);
				КонецЦикла;
			КонецЕсли;				
		КонецЕсли;
		
	КонецЦикла;
		
КонецПроцедуры

Функция ПолучитьМассивСпециальныхРеквизитов()
	
	МассивРеквизитов = Новый Массив;
	
	Стр = Новый Структура("ИмяРеквизита, ИмяПоля", "лм_Код", "Код");
	МассивРеквизитов.Добавить(Стр);
	
	ПриПолученииМассиваСпециальныхРеквизитов(МассивРеквизитов);
	
	Возврат МассивРеквизитов;
	
КонецФункции

Процедура ПриПолученииМассиваСпециальныхРеквизитов(МассивРеквизитов)


КонецПроцедуры

Процедура ПрименитьРезультатНормализации(Форма, Результат, СоответствиеЗависимых, СоответствиеРеквизитов)
	
	Если Результат <> Неопределено Тогда
		Если ТипЗнч(Результат) = Тип("Структура") Тогда
			ИмяТаблицыДанных = лм_БизнесПроцессыКлиентСерверПереопределяемый.ИмяТаблицыДанных();
			СоставДанных = Форма[ИмяТаблицыДанных];
			Если Результат.ВыбранныйЭлемент <> Неопределено Тогда
				Предмет = Результат.ВыбранныйЭлемент;
				Если Форма.Объект.Предмет <> Предмет Тогда
					Форма.Объект.Предмет = Предмет;
					
					ПерезаполнитьПоДаннымПредмета(Форма);
				КонецЕсли;
			КонецЕсли;
			
			Если Результат.Итог <> Неопределено Тогда
				Для Каждого СтрокаДанных Из Результат.Итог Цикл
					Если СтрокаДанных.ВидДанных = "Реквизит" Тогда
						ИмяРеквизита = "лм_" + лм_СтроковыеФункцииКлиентСервер.ПолучитьВалидныйИдентификатор(СтрокаДанных.Имя);	
					Иначе
						ИмяРеквизита = "лм_" + СтрокаДанных.ВидДанных + "_" + лм_БизнесПроцессыВызовСервераПереопределяемый.ЗначениеРеквизитаОбъекта(СтрокаДанных.Имя, "Код");
					КонецЕсли;
					
					СтрокиСостава = СоставДанных.НайтиСтроки(Новый Структура("ИмяРеквизита", ИмяРеквизита));
					Если СтрокиСостава.Количество() > 0 Тогда
						СтрокаСостава = СтрокиСостава[0]; 
						СтрокаСостава.НовоеЗначение = СтрокаДанных.Значение;
						Форма[ИмяРеквизита] = СтрокаДанных.Значение;
					КонецЕсли;
				КонецЦикла;
				
				ОбновитьОтображениеСоставаДанных(Форма, СоответствиеЗависимых, СоответствиеРеквизитов);
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(Форма.Объект.Предмет) И Форма.Элементы.Найти("ПредметСсылка") = Неопределено  Тогда
				Форма.Элементы.Предмет.Видимость = Ложь;
			ИначеЕсли ЗначениеЗаполнено(Форма.Объект.Предмет) И Форма.Элементы.Найти("ПредметСсылка") = Неопределено Тогда
				Форма.Элементы.Предмет.Видимость   = Истина;
				Форма.Элементы.Предмет.Гиперссылка = Истина;
				Форма.Элементы.Предмет.ЦветТекста  = Новый Цвет(28, 85, 174);
				Форма.ПредметСтрокой               = лм_БизнесПроцессыВызовСервераПереопределяемый.ПредметСтрокой(Форма.Объект.Предмет);
			КонецЕсли;
			
			Если Результат.Продолжить = Истина Тогда
				// если нормализация была вызвана при переходе на следующий шаг БП
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура НачалоВыбораОбработчик(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма, ОбработчикЗаполненияЗначения, ПолеРезультата, ТекущиеДанные, ТипЗначения)
		
	СтандартнаяОбработка = Ложь;
	
	ДополнительныеПараметры = Новый Структура("ФормаВладелец, ИмяРеквизита, ТекущиеДанныеТЧ, ОповеститьФормуВладельца, ПолеВведенногоЗначения",
												Форма,
												ПолеРезультата,
												ТекущиеДанные,
												Истина,
												УправлениеЗначениямиВызовСервера.ЗначениеРеквизита(ОбработчикЗаполненияЗначения, "ПолеВведенногоЗначения"));
												
	Оповещение = Новый ОписаниеОповещения("РедактированиеЗначенияЗавершениеВвода", УправлениеЗначениямиКлиент, ДополнительныеПараметры);												
	
	УправлениеЗначениямиКлиент.ПоказатьФормуРедактированияЗначения(
		Форма, Элемент, ДанныеВыбора, СтандартнаяОбработка,
		 ДанныеВыбора, 
		  ОбработчикЗаполненияЗначения, 
		   Оповещение);
		
КонецПроцедуры

Процедура НачалоВыбораФайла(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма, ИмяРеквизита)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("РежимВыбора", Истина);
	ПараметрыОткрытия.Вставить("ВладелецФайла", Форма.Объект.БизнесПроцесс);
	
	ПараметрыОповещения = Новый Структура("Элемент, Форма, ИмяРеквизита", Элемент, Форма, ИмяРеквизита);
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ОбработкаОповещенияВыборФайла", ЭтотОбъект, ПараметрыОповещения); 
	
	ОткрытьФорму("Обработка.РаботаСФайлами.Форма.ПрисоединенныеФайлы", ПараметрыОткрытия,,,,,ОповещениеОЗакрытии);
		
КонецПроцедуры

Процедура ОбработкаОповещенияВыборФайла(РезультатЗакрытия, ДополнительныеПараметры) Экспорт

	Если ТипЗнч(ДополнительныеПараметры.Элемент.Родитель) = Тип("ТаблицаФормы") Тогда
		ИмяПоляТаблицы = Прав(ДополнительныеПараметры.Элемент.Имя, СтрДлина(ДополнительныеПараметры.Элемент.Имя) - СтрДлина(ДополнительныеПараметры.Элемент.Родитель.Имя));
		ДополнительныеПараметры.Элемент.Родитель.ТекущиеДанные[ИмяПоляТаблицы] = РезультатЗакрытия;
		Если ЗначениеЗаполнено(ДополнительныеПараметры.ИмяРеквизита) Тогда
			ДополнительныеПараметры.Форма[ДополнительныеПараметры.ИмяРеквизита] = РезультатЗакрытия;
		КонецЕсли;
	Иначе	
		ДополнительныеПараметры.Форма[ДополнительныеПараметры.Элемент.Имя] = РезультатЗакрытия;	
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти