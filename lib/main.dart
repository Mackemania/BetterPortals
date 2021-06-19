import 'package:objd/core.dart';

void main(List<String> args) {
  createProject(
    Project(
      name: "betterportalsdp",
      target:"./",
      version: 17,
      description: "Unofficial datapack to let you get back to your portal from the nether",
      generate: Pack(
        name: "betterportalsdp",
        load: File(
          "load",
          child: Tellraw(Entity.Player(), show: [TextComponent("Successfullly loaded BetterPortalsDP", color: Color.Green)])
        ),
        main: File(
          "main",
          child: MainWidget()
        )
      )
    ),
    args
  );
}

class MainWidget extends Widget {
  @override
  Widget generate(Context context) {

    Score locX = Score(Entity(selector: "s"), "locX");
    Score locY = Score(Entity(selector: "s"), "locY");
    Score locZ = Score(Entity(selector: "s"), "locZ");
    Score dX = Score(Entity(selector: "s"), "dX");
    Score dY = Score(Entity(selector: "s"), "dY");
    Score dZ = Score(Entity(selector: "s"), "dZ");
    Score tpX = Score(Entity(selector: "s"), "tpX");
    Score tpY = Score(Entity(selector: "s"), "tpY");
    Score tpZ = Score(Entity(selector: "s"), "tpZ");
    Group setupScoreboard = Group(
      children: [
        locX,
        locY,
        locZ,
        dX,
        dY,
        dZ,
        tpX,
        tpY,
        tpZ
      ]
    );

    Group enterNether = Group(
      prefix: "execute as @a[tag=!Portal,nbt={Dimension:'minecraft:the_nether'}] run",
      children: [
        Log("Added Portal"),
        Command("/execute as @s store result score @s tpX run data get entity @s enteredNetherPosition.x"),
        Command("/execute as @s store result score @s tpY run data get entity @s enteredNetherPosition.y"),
        Command("/execute as @s store result score @s tpZ run data get entity @s enteredNetherPosition.z"),
        Tag(
          "Portal",
          entity: Entity(selector: "s"),
        )
      ]
    );

    int range = 64;
    Group exitNether = Group(
      prefix: "execute as @a[tag=Portal,nbt={Dimension:'minecraft:overworld'}] run",
        children: [
          Log("Removed Portal"),
          Command("/execute as @s store result score @s locX run data get entity @s Pos[0]"),
          Command("/execute as @s store result score @s locY run data get entity @s Pos[1]"),
          Command("/execute as @s store result score @s locZ run data get entity @s Pos[2]"),
          dX.setEqual(locX).subtractScore(tpX),
          dY.setEqual(locY).subtractScore(tpY),
          dZ.setEqual(locZ).subtractScore(tpZ),
          Execute(
            as: Entity(
              selector: "s",
              scores: [
                Score(
                  Entity(
                    selector: "s"
                  ),
                  "dX"
                ).matchesRange(Range(-range, range)),
                Score(
                  Entity(
                    selector: "s"
                  ),
                  "dY"
                ).matchesRange(Range(-range, range)),
                Score(
                  Entity(
                    selector: "s"
                  ),
                  "dZ"
                ).matchesRange(Range(-range, range))]
              ),
            children: [
              Command("/function scoretp:tp")
              ]
            ),
          Tag(
            "Portal",
            entity: Entity(selector: "s"),
          ).removeIfExists()
        ]
      );

    Group full = Group(children: [setupScoreboard, enterNether, exitNether]);
    return full;
  }
}