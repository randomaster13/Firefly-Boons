TraitTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/TraitText.en.sjson')
GUIAnimationsFile = rom.path.combine(rom.paths.Content, 'Game/Animations/GUIAnimations.sjson')
HelpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')

Order = {
    'Id',
    'InheritFrom',
    'DisplayName',
    'Description',
}

-- Order for GUIAnimationsFile (credit to zanncdwbl)
IconOrder = {
    'Name',
    'InheritFrom',
    'FilePath',
}