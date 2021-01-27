-- If you make changes to this, back it up in case a new update overwrites it.

PLUGIN.config = {
    defaultCharData = [[Date of Birth: YYYY-MM-DD
Gender: ?
Housing: ?

Additional Info:
- None]],
    loyaltyLevels = {
        [-15] = {
            name = "ANTI-CITIZEN",
            color = Color(255, 0, 0)
        },
        [-10] = {
            name = "MALIGNANT",
            color = Color(255, 128, 0)
        },
        [10] = {
            name = "BLACK",
            color = Color(0, 0, 0)
        },
        [20] = {
            name = "BROWN",
            color = Color(102, 51, 0)
        },
        [30] = {
            name = "RED",
            color = Color(255, 0, 0)
        },
        [40] = {
            name = "BLUE",
            color = Color(0, 0, 255)
        },
        [50] = {
            name = "GREEN",
            color = Color(0, 255, 0)
        },
        [60] = {
            name = "WHITE",
            color = Color(255, 255, 255)
        },
        [70] = {
            name = "GOLD",
            color = Color(212, 175, 55)
        },
        [100] = {
            name = "PLATINUM",
            color = Color(192, 192, 192)
        }
    }
};