local DATA = {}
DATA.Name = "[LSCS] HoldType Butterfly"
DATA.HoldType = "lscs_butterfly"
DATA.BaseHoldType = "melee2"
DATA.Translations = {} 
DATA.Translations[ ACT_MP_STAND_IDLE ] = "phalanx_r_idle"
DATA.Translations[ ACT_MP_WALK ] = "b_run"
DATA.Translations[ ACT_MP_RUN ] = "b_run"
DATA.Translations[ ACT_MP_JUMP ] = "wos_bs_shared_jump_descend"
DATA.Translations[ ACT_MP_CROUCH_IDLE ] = {
	{ Sequence = "couch_idle", Weight = 1 },
}

