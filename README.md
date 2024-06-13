# shoesly

Shoes Marketplace App

## Getting Started

### 1 - Install Andoird Studio

This link can be used to download and install android studio, if not already installed. If you already have android studio install on you computer skip this step.

https://developer.android.com/studio

### 2 - Environment Setup

If you already have flutter and dart SDK setup, you can skip this step.
Use the following link to download and setup flutter and dart SDK in your android studio.
This will allow you to create and run flutter applications.

https://docs.flutter.dev/get-started/install

### 3 - Create project from Git

To create project from Git navigate to File -> New -> Project from Version Controll Source(VCS).

<img width="585" alt="Screenshot 2024-06-13 at 6 41 05 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/9992dd50-8d00-4b13-92f1-bb6eddc0c1ae">

Next copy the git clone URL from github source code.

![Screenshot 2024-06-13 at 6 54 44 PM](https://github.com/fazalahmed3012/shoesly/assets/12868468/1d9e6b40-71e3-46b3-abc7-c653e9968623)

Now paste the copied URL to the Version Control window opened in Android Studio

<img width="912" alt="Screenshot 2024-06-13 at 6 55 45 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/235e2bc4-2bd6-4d17-a3b9-f1e9f39e3365">

Now hit the clone button and the project will be cloned to your computer. Once the project is loaded you will see errors like the image below. Don't worry its normal, it shows these errors because you need to download and load the required flutter packages required to run the project,

<img width="1512" alt="Screenshot 2024-06-13 at 7 12 46 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/24b8b0e4-ff88-40d0-a4b3-bf7ac4b054be">

### 4 - Download the requried flutter packages

To download the required flutter packages navigate to Tools -> Flutter -> Flutter Pub Get. the will execute a flutter command to download and load all the required packages that are included in the pubspec.yaml file.

<img width="1097" alt="Screenshot 2024-06-13 at 7 15 02 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/28fc81b2-a6ee-4cf5-a3ed-f0fad0d05b07">

An other way to do it is through terminal. you can open terminal from launch pad and navigate to the project and run command "flutter pub get" or you can just open the terminal in android studio and run this command right here. To do so you need to click on terminal icon in bottom left and type "flutter pub get" and press enter as shown in image below

<img width="1512" alt="Screenshot 2024-06-13 at 7 15 23 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/fcb770d8-3457-47c1-8bb6-f81cf07d6825">

### 5 - Running the project

To run this project you would be required to either run iOS/Android simulator or you can connect a physical iOS or an android phone to your computer. 
For android phone, the phone must have developer mode turned on and debugging turned on.

You can just click the devices menu on top to see all the available device and virtual device options as well.

<img width="450" alt="Screenshot 2024-06-13 at 8 22 42 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/95403bff-c781-47df-8cf1-49d4bcc19c48">

I will be opening iOS simulator to run the project but you can run it on the physical device or create a virtual device, by going to device manager from the top right menu and clicking on the + button to add new device. Once you have selected and created the device it should be visible in the list and play button can be used to run this device as shown below

<img width="387" alt="Screenshot 2024-06-13 at 8 25 41 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/aa81657d-310f-4885-bf24-409fc09e961e">

Once your device is detected by android studio either a physical one or a virtual one press the green play in the top bar and your project will be built and run on that device.

<img width="1512" alt="Screenshot 2024-06-13 at 8 36 06 PM" src="https://github.com/fazalahmed3012/shoesly/assets/12868468/4c7ecbb9-fdd5-4338-8b17-9b26f0269b19">

## Development Challenges

I was not familiar with data storage on firbase or using firebase firestore. At first I uploaded all the required files such as brand and product images to firebase storage. Then I add the required firebase packages to the project and configure it using flutter fire. I instead of using firestore, used real-time database and had problem with sorting and filtering data. I tried to get the required results but failed to do so. After a few trys i did some research and got to know about firestore configuration and how you can sort and filter data. I rewrote the code for database integration and final was successful with firestore integration and data flow was smooth. Now i am able to not just get and insert data into the database, but also can sort data by using orderBy() function and filter through that data using where() function.

The next challenge I faced was while building UI, specificly filter UI. The price slider used in the design was a custom one, I searched for such slider widgets and if any package would be available to implement the required design but failed many times. Eventually I stumbled upon a custom slider package "syncfusion_flutter_sliders", it was a big help. This package helped me design price slider that was quite close to the design provided. I was so close yet so far, everything was perfect except the slider thumb. So I decided to create a custom thumb, I searched only for ways to create custom thumbs and using those pointers I ended up making my own custom thumb that was pixel prefect.


