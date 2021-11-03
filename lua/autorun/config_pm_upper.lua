PMUpper = {}

-- Allow a player to be a props (Default : false)
PMUpper.iAllowProps = false

-- Allow a player to be a ragdoll (Default : true)
PMUpper.iAllowRagdoll = true

-- Only this groups have access to menu (Default : PMUpper.tGroupAccess = {})
-- Ex : PMUpper.tGroupAccess = {
--          ["vip"] = true,
--      }
PMUpper.tGroupAccess = {}

-- The copy to clipboard must contain (Default : PMUpper.MustContain = {})
-- To Disable :
PMUpper.MustContain = {}
-- To Enable : 
--[[ 
PMUpper.tMustContain = {
    ["player"] = true
} 
]]

PMUpper.tLang = {
    ["NotAccess"] = "Vous n'avez pas accés à ce menu",
    ["PropsNotAllowed"] = "Les props ne sont pas autorisés",
    ["RagdollNotAllowed"] = "Les ragdoll ne sont pas autorisés",
    ["MustContain"] = "Le model doit contenir : %s",
}

-- Touche to open the gui (Default : F2)
if CLIENT then
    PMUpper.sKeyOpenGui = "F2"
end