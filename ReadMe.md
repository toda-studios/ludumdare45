# Ludum Dare 45

_A hastely made real-time strategy game._

## Minimal Viable Product (MVP)

- Build base
- Fight enemy
- Destroy enemy (win)

### Core Mechanics

- Build buildings
- Build units
- Fight for victory

### Core Elements

- Domination victory
- Base building

## Feature Wishlist

- Post-match screen
- Dynamic music
- Unique unit voices

## Gameplay Notes

**RTS Game**

## Technical Notes

Game Engine: [Godot](https://godotengine.org/)

### Engineering Design

***A Pseduo-ECS system***

As much as possible, the code for this project will try to replicate an ECS system.

Nodes will consist of four types of objects:

- Entities
- Components
- Systems
- Scenes

This system will help organize assets by function and help encourage best practices.

#### Entities

Nodes that can run independently and can be "dragged and dropped" into a scene.

Ex. A player is an Entity because it's movement and interaction system can run without any other nodes

#### Components

Nodes that can be applied to mutiple nodes to perform a specific task.

Ex. A fader script would be a component because it can be applied to relatively any node.

#### Systems

Nodes that manage a range of other nodes (usually components)

Ex. An RTS AI would be a system because it controls the values and components of unit entities.

#### Scenes

Scenes are nodes that run as the top level node.

Ex. A main menu would be a scene because it would be running as a root node.

### Directory System

This section outlines the way files are organized within this repository.

#### Root Directories

##### Audio

The `Audio` folder holds sound effects, music, ambience, and any other sound file.

##### Graphics

The `Graphics` folder holds sprites, textures, maps, shaders, and materials.

##### Resources

The `Resources` folder holds third party files such as useful scripts, fonts, and other files.

##### Scenes

The `Scenes` folder holds all the nodes that are intended to run as scenes.

##### Scripts

The `Scripts` folder holds all of the game's scripts. (`.gd` files)

##### Nodes

The `Nodes` folder holds all non-scene nodes.

#### Sub-directories
- Entities
- Components
- Systems

### Continous Intergration and Continous Deployment

***CI/CD***

Currently, the project does not having a working CI/CD pipeline. There is currently a WIP GitHub Actions push file called [build.yml](.github/workflows/build.yml).