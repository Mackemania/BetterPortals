execute as @s[tag=Debug] run tellraw @a [{"text":"Console > ","color":"dark_aqua"},{"text":"Added Portal"}]
execute as @s store result score @s tpX run data get entity @s enteredNetherPosition.x
execute as @s store result score @s tpY run data get entity @s enteredNetherPosition.y
execute as @s store result score @s tpZ run data get entity @s enteredNetherPosition.z
tag @s add Portal
