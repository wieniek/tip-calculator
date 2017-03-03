# Pre-work - *Tip Calculator*

**Tip Calculator** is iOS application which provides easy way to calculate tip and total amounts for a bill.

Submitted by: **Wieniek Sliwinski**

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [X] Remembering the bill amount across app restarts (if \<10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Plus/minus buttons in the settings screen can be used to increase and decrease preset tip amounts.
- [X] Implemented singleton pattern to store data when switching between differnt application views. This way the application does not need to read/write to user defaults when user switches screens. Writing to user defaults is still required to store parameters on application restart.
- [X] Implemented MVC pattern by refactoring the code and creating strictures for data model. Data model implementation code is therefore separated from view controller implementation.
- [ ] More TBD

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src="http://i.imgur.com/m0yhOnV.gif" title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap][1].

## Notes

Challenges encountered while building the app.
1. No refresh on application wake from background.
2. Animations, layer positioning.

## License

	Copyright [2017] [Wieniek]
	
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	
	    http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

[1]:	http://www.cockos.com/licecap/