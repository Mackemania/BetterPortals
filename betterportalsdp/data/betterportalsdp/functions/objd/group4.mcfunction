execute as @s[tag=Debug] run tellraw @a [{"text":"Console > ","color":"dark_aqua"},{"text":"Removed Portal"}]
execute as @s store result score @s locX run data get entity @s Pos[0]
execute as @s store result score @s locY run data get entity @s Pos[1]
execute as @s store result score @s locZ run data get entity @s Pos[2]
scoreboard players operation @s dX = @s locX
scoreboard players operation @s dX -= @s tpX
scoreboard players operation @s dY = @s locY
scoreboard players operation @s dY -= @s tpY
scoreboard players operation @s dZ = @s locZ
scoreboard players operation @s dZ -= @s tpZ
execute as @s[scores={dX=-64..64,dY=-64..64,dZ=-64..64}] run function scoretp:tp
scoreboard players operation @s tpX = @s locX
scoreboard players operation @s tpY = @s locY
scoreboard players operation @s tpZ = @s locZ
execute if entity @s[tag=Portal] run tag @s remove Portal
