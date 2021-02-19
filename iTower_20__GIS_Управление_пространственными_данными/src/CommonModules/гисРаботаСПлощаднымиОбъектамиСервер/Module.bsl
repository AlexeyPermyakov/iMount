////////////////////////////////////////////////////////////////////////////////
// Серверный модуль для работы с площадными объектами (линия, полигон).
// Основное назначение:
//  - типовые действия по получению какой-либо информации из GeoJson;
//  - перевод геометрии из одной системы координат в другую.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Переводит геометрию из местной системы координат в систему координат WGS-84.
//
// Параметры:
//  ГеометрияКадастра		 - Строка - исходная геометрия кадастра;
//  ПараметрыПереводаВWgs84	 - СправочникСсылка.гисПараметрыПереводаВWgs84 - используемые параметры перевода;
//  ГеометрияWgs			 - Строка - сюда будет записана итоговая геометрия в системе координат WGS-84;
//  Наименование			 - Строка - наименование объекта, нужно для вывода ошибки.
// 
// Возвращаемое значение:
//   - Булево - результат выполнения перевода:
//			Истина - успешно;
//			Ложь - с ошибкой.
//
Функция ГеометрияПеревестиИзМскВWgs84(ГеометрияКадастра, ПараметрыПереводаВWgs84, ГеометрияWgs, Наименование) Экспорт
	Попытка
		ГеоJson = гисРаботаСJson.ПрочитатьНативно(ГеометрияКадастра);
		geometry = ГеоJson.geometry;
		
		coordinates = geometry.coordinates;
		Если geometry.type = "LineString" Тогда
			Для Каждого Линия Из coordinates Цикл
				ПереведенныеКоординаты = гисГисСервер.ПеревестиМскВWgs84(Линия[0], Линия[1], ПараметрыПереводаВWgs84);
				Линия[0] = ПереведенныеКоординаты.Долгота;
				Линия[1] = ПереведенныеКоординаты.Широта;
			КонецЦикла;
		ИначеЕсли geometry.type = "MultiLineString" Тогда
			Для Каждого Ломаная Из coordinates Цикл
				Для Каждого Линия Из Ломаная Цикл
					ПереведенныеКоординаты = гисГисСервер.ПеревестиМскВWgs84(Линия[0], Линия[1], ПараметрыПереводаВWgs84);
					Линия[0] = ПереведенныеКоординаты.Долгота;
					Линия[1] = ПереведенныеКоординаты.Широта;
				КонецЦикла;
			КонецЦикла;
		ИначеЕсли geometry.type = "Polygon" Тогда
			Для Каждого Контур Из coordinates Цикл
				Для Каждого Координаты Из Контур Цикл
					ПереведенныеКоординаты = гисГисСервер.ПеревестиМскВWgs84(Координаты[0], Координаты[1], ПараметрыПереводаВWgs84);
					Координаты[0] = ПереведенныеКоординаты.Долгота;
					Координаты[1] = ПереведенныеКоординаты.Широта;
				КонецЦикла;
			КонецЦикла;
		ИначеЕсли geometry.type = "MultiPolygon" Тогда
			Для Каждого contour Из coordinates Цикл
				Для Каждого Контур Из contour Цикл
					Для Каждого Координаты Из Контур Цикл
						ПереведенныеКоординаты = гисГисСервер.ПеревестиМскВWgs84(Координаты[0], Координаты[1], ПараметрыПереводаВWgs84);
						Координаты[0] = ПереведенныеКоординаты.Долгота;
						Координаты[1] = ПереведенныеКоординаты.Широта;
					КонецЦикла;
				КонецЦикла;
			КонецЦикла;
		Иначе
			ОбщегоНазначения.СообщитьПользователю(Наименование + ": ошибка при переводе геометрии из МСК в WGS!" 
				+ Символы.ПС + "Не работаем с типом " + geometry.type);
			Возврат Ложь;
		КонецЕсли;
		geometry.Вставить("coordinates", coordinates);
		
		ГеоJson.Вставить("geometry", geometry);
		
		ГеометрияWgs = гисРаботаСJson.ЗаписатьНативно(ГеоJson);
	Исключение
		ОбщегоНазначения.СообщитьПользователю(Наименование + ": ошибка при переводе геометрии из МСК в WGS!" + Символы.ПС + ОписаниеОшибки());
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
КонецФункции

// Переводит геометрию из системы координат WGS-84 в местную систему координат.
//
// Параметры:
//  ГеометрияWgs			 - Строка - исходная геометрия в системе координат WGS-84;
//  ПараметрыПереводаВWgs84	 - СправочникСсылка.гисПараметрыПереводаВWgs84 - используемые параметры перевода;
//  ГеометрияКадастра		 - Строка - сюда будет записана итоговая кадастровая геометрия;
//  Наименование			 - Строка - наименование объекта, нужно для вывода ошибки.
// 
// Возвращаемое значение:
//   - Булево - результат выполнения перевода:
//			Истина - успешно;
//			Ложь - с ошибкой.
//
Функция ГеометрияПеревестиИзWgs84ВМск(ГеометрияWgs, ПараметрыПереводаВWgs84, ГеометрияКадастра, Наименование) Экспорт
	Попытка
		ГеоJson = гисРаботаСJson.ПрочитатьНативно(ГеометрияWgs);
		geometry = ГеоJson.geometry;
		
		coordinates = geometry.coordinates;
		Если geometry.type = "LineString" Тогда
			Для Каждого Линия Из coordinates Цикл
				ПереведенныеКоординаты = гисГисСервер.ПеревестиWgs84ВМск(Линия[0], Линия[1], ПараметрыПереводаВWgs84);
				Линия[0] = ПереведенныеКоординаты.Долгота;
				Линия[1] = ПереведенныеКоординаты.Широта;
			КонецЦикла;
		ИначеЕсли geometry.type = "MultiLineString" Тогда
			Для Каждого Ломаная Из coordinates Цикл
				Для Каждого Линия Из Ломаная Цикл
					ПереведенныеКоординаты = гисГисСервер.ПеревестиWgs84ВМск(Линия[0], Линия[1], ПараметрыПереводаВWgs84);
					Линия[0] = ПереведенныеКоординаты.Долгота;
					Линия[1] = ПереведенныеКоординаты.Широта;
				КонецЦикла;
			КонецЦикла;
		ИначеЕсли geometry.type = "Polygon" Тогда
			Для Каждого Контур Из coordinates Цикл
				Для Каждого Координаты Из Контур Цикл
					ПереведенныеКоординаты = гисГисСервер.ПеревестиWgs84ВМск(Координаты[0], Координаты[1], ПараметрыПереводаВWgs84);
					Координаты[0] = ПереведенныеКоординаты.Долгота;
					Координаты[1] = ПереведенныеКоординаты.Широта;
				КонецЦикла;
			КонецЦикла;
		ИначеЕсли geometry.type = "MultiPolygon" Тогда
			Для Каждого contour Из coordinates Цикл
				Для Каждого Контур Из contour Цикл
					Для Каждого Координаты Из Контур Цикл
						ПереведенныеКоординаты = гисГисСервер.ПеревестиWgs84ВМск(Координаты[0], Координаты[1], ПараметрыПереводаВWgs84);
						Координаты[0] = ПереведенныеКоординаты.Долгота;
						Координаты[1] = ПереведенныеКоординаты.Широта;
					КонецЦикла;
				КонецЦикла;
			КонецЦикла;
		Иначе
			ОбщегоНазначения.СообщитьПользователю(Наименование + ": ошибка при переводе геометрии из WGS в МСК!" 
				+ Символы.ПС + "Не работаем с типом " + geometry.type);
			Возврат Ложь;
		КонецЕсли;
		geometry.Вставить("coordinates", coordinates);
		
		ГеоJson.Вставить("geometry", geometry);
		
		ГеометрияКадастра = гисРаботаСJson.ЗаписатьНативно(ГеоJson);
	Исключение
		ОбщегоНазначения.СообщитьПользователю(Наименование + ": ошибка при переводе геометрии из WGS в МСК!" + Символы.ПС + ОписаниеОшибки());
		Возврат Ложь;
	КонецПопытки;
	Возврат Истина;
КонецФункции

#КонецОбласти
