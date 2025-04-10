local version = vim.version()
local header = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⣤⣤⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⢠⡞⣿⣿⣽⣷⣶⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡠⠔⣲⡶⠀⠀⠀⠀⠀⠀⢠⡿⣗⠢⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢟⣯⣿⣶⣶⣾⣿⣿⣿⣶⣾⣭⣛⠶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠙⠛⢻⣿⡼⣽⡿⡿⠻⣿⣿⢏⢋⣷⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠶⠋⢁⣤⣞⣫⠄⠀⠀⠀⠀⠀⠀⠈⢻⡾⢷⣌⠙⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢠⡏⣵⣶⡌⢿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡙⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡎⣯⢭⡙⡳⢮⡹⢺⡾⣾⣿⣿⡿⣿⣗⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⣁⡠⠔⠛⣩⠝⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⡙⢷⣸⠀⠙⢦⡀⠀⠀⠀⠀⠀⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢸⣇⡻⠿⢃⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢷⡷⡷⢝⣿⣗⣄⣈⠘⣿⣿⣻⠷⡿⣳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⢰⠏⠀⠀⠀⠀⣰⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⣽⠀⠀⠀⠹⣆⠀⠀⠀⠀⣿⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣘⣛⣛⣛⠛⡋⠙⠋⠙⠋⠹⠟⢿⣿⣿⣿⣿⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢿⠛⣒⢯⢻⣟⠓⡦⢙⢿⣳⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢿⠀⠀⠀⡿⠤⣀⡤⠖⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠓⢦⣤⣤⢽⡆⠀⠀⠀⣿⠀⢇⠀⠀⠀⠀⢀⡴⢞⣻⣿⣿⣿⣿⡟⠻⠉⠉⠀⠀⠀⠀⠄⠀⠀⠀⠈⠀⠿⢿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢧⡢⡉⠛⠞⣩⣯⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⢸⠀⠀⠀⣇⠀⠀⠱⣄⠀⠀⠀⠀⣤⣄⠀⢀⣄⣀⣠⣄⣀⡀⠀⣴⣶⠀⠀⢀⡴⠋⠀⠀⣸⠁⠀⠀⠀⢸⡀⢸⠀⠀⠀⣰⠏⣴⣿⣿⣿⣿⣿⡟⠓⠀⠀⠠⠴⠾⠿⠦⠴⠿⠷⣦⣄⠀⠀⠘⢻⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡄⠀⠀⠵⠷⠯⢟⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢸⡆⠀⠀⣿⣆⠀⠀⠹⣆⢀⣀⡶⠿⠟⠉⠁⠀⠉⠀⠈⠁⠉⠉⠛⠓⢦⣠⣾⣷⠀⠀⡰⠃⢀⣀⠤⠖⠚⢳⡜⠀⠀⢠⡟⣸⣿⣿⣿⣿⣿⡏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢧⠀⠀⠉⣹⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢀⡞⡽⣦⡾⣽⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠈⣇⠀⠀⠸⣿⣷⣄⢀⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⠀⠀⠀⠀⠀⠈⠉⢹⣦⣾⣷⡾⠓⣲⡤⠶⠚⠉⠀⠀⠀⢸⠇⣿⣿⣿⣿⣿⣿⡉⠀⠐⠀⣰⠀⠀⠀⠰⠶⠶⠆⠀⠀⠀⠀⠀⠂⠀⢉⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠇⠫⢚⢝⡷⣗⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⣟⠒⠲⠦⣽⣦⣹⠟⠁⠀⠀⠀⠀⠀⠀⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⡟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⢸⠸⣿⣿⣿⣿⣿⣯⡁⠀⠀⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠲⣿⡿⠀⠀⢈⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣖⣶⣟⠃⠀⠥⡌⢙⣼⢿⣵⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⢦⣄⣀⣀⣼⣅⡀⠀⠀⠙⠀⠀⠀⠀⠉⠁⠰⠄⠀⠀⠀⢠⣶⠀⠀⠀⠉⠀⡠⣤⣷⠶⠤⢤⣄⣀⠀⠀⠀⠀⠀⢸⡇⣿⣿⣿⣿⣿⣿⡁⠀⠀⠛⠛⠀⠀⠀⠘⠛⢻⡆⠀⠀⠀⠙⠁⠀⠀⣈⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣽⣯⣯⡆⠀⠈⣡⣿⣿⣮⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⠴⠶⣖⣒⠛⢷⣍⡲⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⢖⣩⡾⢿⣿⣶⡮⠭⠤⢬⡿⢦⠀⠀⠀⠸⣇⢹⣿⣿⣿⣿⣿⠁⣀⠀⠀⢀⣀⣀⣀⣀⣀⣸⣷⣀⣀⣀⡀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣤⠤⣿⣿⣿⣿⣽⢾⣿⣻⣧⠀⠲⢾⣫⣽⣿⣿⣿⣿⣿⣿⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠋⡿⠓⠒⠒⠲⠿⣿⡿⠿⠿⣶⣭⡓⢤⣀⠀⠀⠀⠀⠀⣀⣀⣀⡀⠴⣂⣠⣶⣿⠿⣯⣉⡀⠉⠛⢦⡀⠀⢻⣎⣧⠀⠀⠀⠹⣆⢻⣿⣿⣿⣿⣿⣧⡤⠀⠀⠤⠀⣿⣿⣿⣿⣿⣿⠀⠤⠀⠀⢤⣼⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⢀⣤⠶⠟⠋⠉⠀⠀⠀⠀⠠⡽⠛⡯⠻⠿⣿⣷⣽⣮⣷⣄⡈⢿⣻⣿⣿⣻⡿⣿⢿⣿⣿⣿⣿⡿⣿⣿⣿⣗⢶⣶⡦⣭⣍⣭⣭⡉⠉⣉⡉⠉⠉⠉⠉⠉⡩⢔⡲⣖⡿⡯⠽⠏⠓⠢⣄⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⢁⠞⠁⠀⢀⣴⣚⣉⣀⣀⣤⡼⠛⠙⣿⣿⣿⠿⠿⣭⣿⣿⠭⠽⠷⠒⠛⠙⠛⠿⣷⣖⠚⠙⠻⣿⡛⣾⠛⡆⠀⠻⣿⡇⠀⠀⠀⠙⢦⣌⣛⣛⣛⣹⣿⣷⣶⡀⣀⠀⠀⠀⠉⠉⠀⠀⠀⣀⢀⣶⣾⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⢠⣿⠁⠀⠀⠀⠐⠀⠐⢑⠀⠈⢣⡀⠀⠀⠀⠉⡀⠈⠈⡘⠻⣿⣜⠿⣝⡿⣟⣾⣟⣿⣻⣿⣿⣿⣿⣟⣿⣯⣿⢯⣿⢿⣞⣟⢝⣿⣟⣯⣳⡶⣶⢶⣢⣔⠁⡊⣀⡊⡃⠉⠁⠀⠀⠀⠀⠈⣧",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡷⠋⠀⠀⢠⡏⠀⡔⢉⠵⠿⠁⠐⣲⠶⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠓⡶⢚⣿⢿⡄⢻⠀⠀⠙⢿⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⣿⣿⣿⣿⣿⣶⣧⣤⣆⣰⣤⣼⣶⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣣⢠⡢⡀⢀⠀⠀⠀⠑⠀⠔⢀⣵⢄⠀⠀⠀⠐⢄⢄⢀⠄⠑⠻⣷⢟⡿⢿⣻⡧⣿⣸⢵⢷⣞⣯⢽⢿⣽⢯⣿⣻⣯⣻⣻⡯⣯⣿⢿⣟⢿⣪⢗⡹⣫⢯⣚⡷⡣⠃⠀⠀⠀⠀⠀⠀⠀⡏",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠁⠀⠀⠀⡾⢀⠞⠀⠸⣆⢰⡞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⢀⡾⠁⠈⣿⢸⡄⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⢑⢹⣾⢔⢕⢄⡄⠀⠊⢊⢛⣎⣾⣽⣶⣮⣴⣒⡒⠒⠚⡱⠦⢌⡙⠷⡘⠬⡘⠻⢗⡽⣿⣻⣹⣯⡾⣿⢿⣷⡹⣿⡿⡽⣿⣿⣞⢯⣛⢯⣫⢯⣾⢖⣵⣟⡝⢽⠀⠀⠀⠀⠀⠀⠀⡼⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣧⠎⠀⠀⠀⠹⡄⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢎⣤⠋⠀⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡿⡷⡥⣝⢽⠥⡰⣞⣦⡇⡮⣾⣿⢟⡟⠿⠻⢟⢿⣻⡱⣶⡤⣜⣲⠮⣕⡪⣦⢅⡃⠋⢙⢏⣟⣌⣽⣿⣿⣽⣿⣿⣿⡽⣝⣞⢿⢯⢯⣯⢻⢯⢯⢯⢞⣵⢳⣷⣟⠆⠠⣠⡴⠶⠤⢵⠃⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡏⠀⠀⠀⠀⠀⠈⠢⣽⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠋⠁⠀⠀⠀⠀⠀⠸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢽⣮⣽⡇⡉⢖⠀⡌⠀⠡⢠⢿⠏⠈⠃⠰⡀⢠⣛⢮⣀⢊⠀⢋⡿⣟⠶⡽⣣⣗⣿⣲⡤⣈⠍⢉⢿⣸⣉⣷⢿⣟⣷⠾⣽⡞⣿⣧⡯⣯⣿⣯⢿⡟⠾⢯⢿⢻⡃⡜⣄⣀⣈⣀⣠⠃⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡝⠌⠀⠀⠈⠖⠁⣀⣁⣊⣁⣀⣀⣀⣡⣤⣮⣧⣤⣨⣤⣬⣂⣑⣀⣀⣙⣎⣷⣾⢿⢻⢶⣝⣀⡀⠁⣁⠕⢫⠉⠹⣭⢹⠝⡝⢶⠯⣳⣭⣜⢯⡸⢽⣼⢿⠳⠚⠛⠛⠉⠉⠁⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣶⣦⣄⣠⣀⠃⠁⡀⠙⡌⠣⠍⢑⣺⢿⡯⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠒⠂⠐⠶⠶⠶⠶⠿⠭⠛⠛⠛⠛⠛⠒⠚⠒⠒⠈⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
}

local center = {
    {
        desc = "Find File                     ",
        keymap = "",
        key = "f",
        icon = "  ",
        action = "Telescope find_files",
    },
    {
        desc = "Recents",
        keymap = "",
        key = "r",
        icon = "  ",
        action = "Telescope oldfiles",
    },

    {
        desc = "Browse Files",
        keymap = "",
        key = "b",
        icon = "  ",
        action = "Telescope file_browser",
    },

    {
        desc = "New File",
        keymap = "",
        key = "n",
        icon = "  ",
        action = "enew",
    },

    {
        desc = "Show plugins",
        keymap = "",
        key = "L",
        icon = "  ",
        action = "Lazy",
    },

    {
        desc = "Update Plugins",
        keymap = "",
        key = "u",
        icon = "  ",
        action = "Lazy update",
    },

    {
        desc = "Manage Extensions",
        keymap = "",
        key = "e",
        icon = "  ",
        action = "Mason",
    },

    {
        desc = "Config",
        keymap = "",
        key = "c",
        icon = "  ",
        action = "Telescope find_files cwd=~/.config/nvim",
    },
    {
        desc = "Exit",
        keymap = "",
        key = "q",
        icon = "  ",
        action = "exit",
    },
}
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "dashboard",
    group = vim.api.nvim_create_augroup("Dashboard_au", { clear = true }),
    callback = function()
        vim.cmd([[
            setlocal buftype=nofile
            setlocal nonumber norelativenumber nocursorline noruler fillchars=eob:\
            nnoremap <buffer> <F2> :h news.txt<CR>
        ]])
    end,
})

return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#f38ba8', bg = 'NONE' }) -- from catppuccin palette
        local function footer()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "", "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end

        require("dashboard").setup({
            theme = "doom",
            config = {
                header = header,
                center = center,
                footer = footer,
            },
        })

        local bufferline_dashboard_group = vim.api.nvim_create_augroup("BufferlineDashboardToggle", { clear = true })
        local function toggle_tabline()
            local current_buf = vim.api.nvim_get_current_buf()
            local ft = vim.bo[current_buf].filetype
            local listed = vim.bo[current_buf].buflisted
            if ft == "dashboard" then
                vim.opt.showtabline = 0
            elseif ft == "neo-tree" then
                vim.opt.showtabline = 2
            elseif listed then
                vim.opt.showtabline = 2
            else
                vim.opt.showtabline = 0
            end
        end

        vim.api.nvim_create_autocmd("WinEnter", {
            group = bufferline_dashboard_group,
            pattern = "*",
            desc = "Toggle tabline based on buffer in focused window",
            callback = function()
                vim.schedule(toggle_tabline)
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            group = bufferline_dashboard_group,
            pattern = "dashboard",
            desc = "Hide tabline for dashboard",
            callback = function()
                vim.schedule(function()
                    vim.opt.showtabline = 0
                end)
            end,
        })

        vim.api.nvim_create_autocmd("BufEnter", {
            group = bufferline_dashboard_group,
            pattern = "*",
            nested = true,
            desc = "Show tabline for non-dashboard buffers",
            callback = function()
                if vim.bo.filetype ~= "" and vim.bo.buflisted and vim.bo.filetype ~= "dashboard" then
                    vim.opt.showtabline = 2
                end
            end,
        })

        vim.api.nvim_create_autocmd("VimEnter", {
            group = bufferline_dashboard_group,
            pattern = "*",
            nested = true,
            callback = function()
                vim.schedule(function()
                    if vim.bo.filetype ~= "dashboard" and vim.bo.buflisted then
                        vim.opt.showtabline = 2
                    elseif vim.bo.filetype == "dashboard" then
                        vim.opt.showtabline = 0
                    end
                end)
            end,
        })
    end,
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
    }
}
