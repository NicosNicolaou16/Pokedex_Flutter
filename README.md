# Pokedex_Flutter

The Pokedex - Pokemon app is a project that applied some Flutter technologies recommended by Flutter
Community such as Bloc Pattern for UI management. Drift SQL Database,
Dio for Network Manager, Get It for Dependencies Injection and Hero Widget for Shared Elements
between the screens.

> [!IMPORTANT]  
> Similar project with (Kotlin Language) :point_right: [Pokedex_Compose](https://github.com/NicosNicolaou16/Pokedex_Compose) :point_left: <br />

# Examples

<p align="left">
  <a title="simulator_image"><img src="examples/Screenshot_20240817_012140.png" height="500" width="200"></a>
  <a title="simulator_image"><img src="examples/Screenshot_20240817_012157.png" height="500" width="200"></a>
  <a title="simulator_image"><img src="examples/Screenshot_20240817_012221.png" height="500" width="200"></a>
  <a title="simulator_image"><img src="examples/example_gif1.gif" height="500" width="200"></a>
  <a title="simulator_image"><img src="examples/example_gif2.gif" height="500" width="200"></a>
</p>

# The Project Contain the following technologies and libraries

[Dio Network Manager](https://pub.dev/packages/dio) is responsible for making requests and
retrieving data from the remote server. <br />
[Drift Database](https://drift.simonbinder.eu/docs/getting-started/) is responsible for saving the
retrieved data from the remote server, querying data from the local database, and supporting offline
functionality. ([Drift Database Documentation](https://pub.dev/packages/drift)) <br />
[Bloc Patterns using single state](https://pub.dev/packages/flutter_bloc) along with repositories
and services, separates business logic, data access, and UI by using streams to handle state and
manage data flow. ([Bloc Pattern Documentation](https://bloclibrary.dev/getting-started/)) <br />
[Cached Network Image](https://pub.dev/packages/cached_network_image) is a package that it is
responsible for loading the images and supports offline functionality.  <br />
[Get It (Dependencies Injection)](https://pub.dev/packages/get_it) is a lightweight dependency
injection package for Flutter that allows you to register and access services globally, promoting
cleaner and more maintainable code.  <br />
[Hero Widget](https://docs.flutter.dev/ui/animations/hero-animations) creates a smooth animation for
shared elements between screens by linking them with a common tag.  <br />
The percentage for showing the skills of each Pokémon is calculated using
the [percentages_with_animation](https://pub.dev/packages/percentages_with_animation) built by
[NicosNicolaou16](https://github.com/NicosNicolaou16). <br />

# Versioning

Flutter SDK version: 3.35.3 <br />
Dart Version: 3.8.1 <br />

# Feeds/Urls/End Point (parsing some data from the response)

## (Links References for Ends Points)

https://pokeapi.co/ <br />
https://github.com/PokeAPI/sprites (GitHub) <br />

# References

https://dribbble.com/shots/6540871-Pokedex-App# - Get some UI - not completely use it (CHECK THE
LINK FOR THE DESIGN) <br />
https://ideas.fandom.com/wiki/Pok%C3%A9_Ball_Pok%C3%A9mon_Ideas_(Super_Smash_Bros._series)?file=Pok%C3%A9_Ball_Redraw_by_oykawoo.png - app icon <bf />
https://ideas.fandom.com/wiki/Pok%C3%A9_Ball_Pok%C3%A9mon_Ideas_(Super_Smash_Bros._series) - app icon <bf />