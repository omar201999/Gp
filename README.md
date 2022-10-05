# H.Partner Application
H.Partner is a mobile application developed using Flutter. It supports both Android and IOS.

H.Partner is a Nutrition System application. It allows the user to calculate daily his calories, protein, car, and fat,.
the user can buy from market off app healthy products,
the user can follow her health by charts that used in our app

## Table of contents
- ### [main packages used](https://github.com/Atevaz/health_partner/blob/master/README.md#main-packages-used-1)
- ### [Folder structure](https://github.com/Atevaz/health_partner/blob/master/README.md#folder-structure-1)
- ### [Screenshots](https://github.com/Atevaz/health_partner/blob/master/README.md#screenshots-1)
- ### [Demo video](https://github.com/Atevaz/health_partner/blob/master/README.md#Demo)

## Main packages used
- [firebase_core](https://pub.dev/packages/firebase_core) to make integration database
- [firebase_auth](https://pub.dev/packages/firebase_auth) to handle authentication
- [firebase_storage](https://pub.dev/packages/firebase_storage) to save media of app in it
- [tflite](https://pub.dev/packages/tflite) to used machine learning model in our app
- [fl_chart](https://pub.dev/packages/fl_chart) to handle charts of analytics
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) as state management
- [shared_preferences](https://pub.dev/packages/shared_preferences) to handle caching data
- [internet_connection_checker](https://pub.dev/packages/internet_connection_checker) to handle internet connection
- [image_picker](https://pub.dev/packages/image_picker) to pick image from mobile storage
- [flutter_localizations](https://pub.dev/packages/easy_localization) to handle localization

## Folder structure
We have applied clean archeticture concept and here is the basic folder structure:

core folder structure that flutter provides:

```
h_partner
├── android
├── assets
├── build
├── ios
├── lib
└── test
```


Here is the folder structure we have been using in this project:
```
lib
├── layout
├── model
├── modules
├── shared
└── main.dart
```

### layout
This folder containes the business logic of the application specificly state management.

```
layout
├── admin layout
└── home-layout
```

### model
This folder contains all models related to the application
```
model
├── feedback_model.dart
├── meals_model.dart
├── new_order_model.dart
├── product_model.dart
├── recipes_model.dart
└── user_model.dart
```

### modules
This folder contains all screens and designs related to the application
```
modules
├── add_info
├── change_address_and_phone
├── block_user
├── breakfast
├── buy_now
├── camera
├── cart
├── complete_diary
├── customer_dashboard
├── dinner
├── edit_goal
├── feedback
├── home
├── login
├── lunch
├── market
├── meal_item
├── nutrition
├── onBoarding
├── order_layout
├── recipe
├── register
├── result_of_detection
├── search_recipe_screen
├── snacks
└── water_track
```

### shared
This folder contains everything used anywhere in the app .
```
shared
├── components
├── localization
├── network
├── styles
└── bloc_observer
```
## Screenshots
|<img src="https://user-images.githubusercontent.com/101355785/194030068-629ee6ee-84ef-453b-9ec5-d22d9cdddddb.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194030092-84584391-dbbe-4e66-a819-f0f063e38f64.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194030115-f1279a10-bdcc-4bae-8951-d45e33ca1565.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194030133-1847ac30-990c-4091-ba00-72af9583c966.jpg" width ="200">|
|<img src="https://user-images.githubusercontent.com/101355785/194031475-177b5bc4-97df-416b-948f-5a62bf84e32b.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194031485-7e578c08-3df8-4631-b74c-668d5c56ee77.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194031489-a793d491-e95d-450e-a042-f239a00db293.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194031495-42e3638b-af0b-460f-bc02-406bb95b1713.jpg" width ="200">
|<img src="https://user-images.githubusercontent.com/101355785/194046352-a6b0d6cf-ed0e-4bff-8c22-6adf40451907.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194046362-9f47687e-eb3c-49eb-a4a8-90c1226e54cd.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194046367-e1d9497b-7a6f-4620-973a-c3b91ced1a1d.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194046369-0dbb1b09-4fb8-4799-ac44-876dd9ae7a9b.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194046378-dbcb5d83-479c-4fec-9246-06d4817c8af8.jpg" width ="200">
|<img src="https://user-images.githubusercontent.com/101355785/194050310-3ffda929-e132-44bf-999f-adf05ebca285.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194050320-7abcfb1f-ae4b-45be-b55f-751e3b70af64.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194050324-0f1fcaf4-441e-4c02-8c72-7722b45ddf9d.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194050623-8c21c022-13bf-4c50-845e-b928b580a949.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194050631-fd9c99fc-4e4b-4376-9190-1cfee08a4d57.jpg" width ="200">
|<img src="https://user-images.githubusercontent.com/101355785/194050774-1cb19315-f93d-4b1c-a2bf-6782242b1c10.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194050787-303ec1bc-3800-4335-a2a9-9ba1319b11c2.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194050798-d92b911e-ea97-490c-a6e1-c085fc02c982.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194050805-0c3cb3a9-6b57-498e-a8f6-b82d947b7384.jpg" width ="200">|<img src="https://user-
images.githubusercontent.com/101355785/194051152-e10850bd-0b62-4587-90cd-5885eaf5854c.jpg" width ="200">
|<img src="https://user-images.githubusercontent.com/101355785/194051161-fcdef4bd-9420-4d46-a1aa-7696c0205f7b.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194051167-3d7e53f6-4ffc-40e3-89ed-c30923dbaba7.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194051174-48dd3552-e5c7-442a-88fc-386feedc59d7.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194051430-1437bc42-3502-4881-946f-e1430034ede3.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194051435-f9557dab-02f5-495c-b138-5bbdded62544.jpg" width ="200">|
|<img src="https://user-images.githubusercontent.com/101355785/194053298-0dfd7624-483e-4452-98f5-a4eba0da2fb9.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194053312-6f6698d1-a199-41d9-8b5a-3cc0672a46bc.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194053320-bc1bdee0-3208-44e4-bafc-5515fb82c6b9.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194053324-69646056-c0a9-4d8c-8c7c-1ec1566f6777.jpg" width ="200">|
|<img src="https://user-images.githubusercontent.com/101355785/194053757-ac980286-2eb4-44fc-bb7d-f5f73ab47883.jpg" width ="200">|<img src="https://user-images.githubusercontent.com/101355785/194053763-18d39485-ef3a-4275-8896-4ae813b7bb0c.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194053764-58eb9041-d66f-4296-9aba-428dc9b207d5.jpg" width="200">|<img src="https://user-images.githubusercontent.com/101355785/194053770-8f616e98-861b-4b49-a2c4-e835a9b4e0a3.jpg" width ="200">|

## Demo

https://www.youtube.com/watch?v=FR8rsPSzJb4&ab_channel=omaressam