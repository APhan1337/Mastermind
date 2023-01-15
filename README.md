# Mastermind
Mastermind Game for LinkedIn Reach Mobile Apprenticeship.

## Download Project
0. Install and launch [XCode](https://apps.apple.com/us/app/xcode/id497799835?mt=12).
1. Clone this repository within the XCode Welcome Window.

## Build & Run
1. Click the Play icon in the top-left of the toolbar. This will load the app in the Simulator.

## Product Spec
### 1. User Stories

**Required Must-have Stories**
- [ ] Ability to guess 4 number combination from 0 ~ 7 (Dupliucates are allowed).
- [ ] Ability to view the history of guesses and feedback.
- [ ] The number of guesses remaining is displayed (of 10 attempts).
- [ ] Use [Random Integer Generator API](https://www.random.org/integers/) to generate the number combinations.

**Optional Nice-to-have Stories**
- [ ] Configurable difficulty level.
- [ ] Change numbers into different theme(s).
- [ ] Add a timer for the entire game, or each guess attempts.
- [ ] Draw all of graphical components, add animations, and sounds.

## Thought Process
When designing this app, I wanted the user interaction to be kept at a minimum. So I designed a custom keyboard to the specification of digits 0 ~ 7, rather than using the system number pad keyboard that would allow invalid input (digits 8 and 9). In order to provide feedback each round, I designed a glossary of terms that add a gamification aspect to the feedback. Instead of having a pop-up modal, another layer of interaction, I have symbols representing the feedback. "!" for the amount of "correct number(s)" and "?" for the amount of "correct position(s)." That way, all information can be at-a-glance for this game.

## Wireframes
<p float="left">
    <img src="https://github.com/APhan1337/Mastermind/blob/main/Images/Wireframe%201.png" width=200 />
    <img src="https://github.com/APhan1337/Mastermind/blob/main/Images/Wireframe%202.png" width=200 />
    <img src="https://github.com/APhan1337/Mastermind/blob/main/Images/Wireframe%203.png" width=200 />
</p>
<p float="left">
    <img src="https://github.com/APhan1337/Mastermind/blob/main/Images/Wireframe%204.png" width=200 />
    <img src="https://github.com/APhan1337/Mastermind/blob/main/Images/Wireframe%205.png" width=200 />
    <img src="https://github.com/APhan1337/Mastermind/blob/main/Images/Wireframe%206.png" width=200 />
</p>

## Video Walkthrough
Here's a walkthrough of current progress:

<img src="https://github.com/APhan1337/Mastermind/blob/main/Images/App_Demo.gif" />