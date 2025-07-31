Return-Path: <linux-acpi+bounces-15446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF92B17182
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 14:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9BA81205
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F582BE7BB;
	Thu, 31 Jul 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="HsHUIQxN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5A202C3E;
	Thu, 31 Jul 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966204; cv=none; b=bYavMVb2tlh5J3GkSPA7Aaxf6StjLhNUH1x2LZzq9X/wWDOoNamrMP6Dkr8HOclQ+VEUI3Pjq7KsCrEy/Uvh2d5wHnKhAJlhsYDh1E+QwxBOdCI7fN5APD3o+cAO3Wu4yIYArxJbOnmJDfKpxfcF2BPjrLDgAkgL1A5D+SWB15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966204; c=relaxed/simple;
	bh=EUcqOYAoUZZo6jVQsf33OnLLIY67eITwS6BV2AZFyZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWnTCUXw+w+r6jb9/GUomz9DoH1Kh4T3BhFICfsYWWB5owqbhO4rpYZQjyRx1mXoB2z5awh2jcNsMNXKlADZZJWDv/0np/qTw+bcnBSLOCszr2rFXhEqm6t2FFP/YbkN2bMuuIivl+ad+7VqbNTmhzjRXqnho8gdPUCGNhASPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=HsHUIQxN; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753966188; x=1754570988; i=spasswolf@web.de;
	bh=EN6HJdlLXkQi35xQvftFjc+spysryAxQXjC/mP0W5i8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HsHUIQxNC74lVOyqvGo2F57kQ9DpriZ84tmn/ISKpskqEWhgCIy1NAypT5SQfwDh
	 Oc3hsx14zq5+wJwg5xE4XMrC6/vrnbFCd8263bYzbtAyqvRJNH9MScEIDWWsxD4Tb
	 kdH6DEF5fvA0k6iE2SbD+1qg6m2NA4z8KDuFowgvg0P9EFFNnNmsYNjSaWqTp5xHE
	 wYVmO6m249UHVMAvFMIfaV1QKA6YxC9O7537mOwTREm7RA+gocm0d56RsYjAoDk1b
	 aqjXWqiBGwb7rxqskCZ7EbuUHiyqm56oH7Jftx3gu3xgaYYpz+VhhfANhjE8R3dyl
	 bIQSTh11zPu72gT5YA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from lisa ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1u5Nx23Psh-00l4wE; Thu, 31
 Jul 2025 14:49:47 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Warnings when loading amd-pstate-ut kernel module in linux-next-202507{29,31}
Date: Thu, 31 Jul 2025 14:49:43 +0200
Message-ID: <20250731124944.2869-1-spasswolf@web.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C3+0Vz6vRdpfkwnExjC7YZaTFKBh6HjRsfJ1vUkVooNHmsjdaDS
 CzlAuxq/Ut7VKXiucBK/9fVbCViKSrmZslfCN8ZVup1f6t7kx7M3G1T320xRxLk9WpLYcUV
 NZ9+JvNpzmyhHbEil3gO1LWlqSOnjgoPRLKiOSeXVBddz/B9lrHtb0rBvhc3exMylrWCIiz
 xWdYTvf3v/ey32NjV0lRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SgdMiQv4zBg=;68qiG5zeDJnIqFYYVCenT6GBl/7
 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

When loading the amd-pstate-ut kernel module in next-202507{29,31} the
following warnings appear in dmesg (both with and without PREEMPT_RT):

2025-07-30T09:47:04.974193+02:00 lisa kernel: [ T3205] amd_pstate_ut: 1    =
amd_pstate_ut_acpi_cpc_valid	 success!
2025-07-30T09:47:04.974204+02:00 lisa kernel: [ T3205] amd_pstate_ut: 2    =
amd_pstate_ut_check_enabled	 success!
2025-07-30T09:47:04.974206+02:00 lisa kernel: [ T3205] amd_pstate_ut: 3    =
amd_pstate_ut_check_perf	 success!
2025-07-30T09:47:04.974207+02:00 lisa kernel: [ T3205] amd_pstate_ut: 4    =
amd_pstate_ut_check_freq	 success!
2025-07-30T09:47:04.974209+02:00 lisa kernel: [ T3205] ------------[ cut he=
re ]------------

The following message appears about ~100 times (almost identical, some are =
on a differnent CPU)

2025-07-30T09:47:04.974210+02:00 lisa kernel: [ T3205] freq_qos_remove_requ=
est() called for unknown object
2025-07-30T09:47:04.974212+02:00 lisa kernel: [ T3205] WARNING: kernel/powe=
r/qos.c:607 at freq_qos_remove_request+0x89/0xa0, CPU#6: modprobe/3205
2025-07-30T09:47:04.974225+02:00 lisa kernel: [ T3205] Modules linked in: a=
md_pstate_ut(+) ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_eve=
nt snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat =
fat snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg=
 btusb snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn snd_hda_codec btrtl snd_=
soc_core btintel uvcvideo snd_hda_core btbcm btmtk snd_hwdep videobuf2_vmal=
loc snd_pcm_oss videobuf2_memops uvc videobuf2_v4l2 snd_mixer_oss bluetooth=
 videodev snd_pcm snd_rn_pci_acp3x snd_acp_config snd_timer videobuf2_commo=
n msi_wmi snd_soc_acpi ecdh_generic ecc sparse_keymap mc wmi_bmof snd edac_=
mce_amd k10temp ccp snd_pci_acp3x soundcore ac battery button joydev hid_se=
nsor_accel_3d hid_sensor_prox hid_sensor_gyro_3d hid_sensor_magn_3d hid_sen=
sor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industri=
alio amd_pmc evdev hid_sensor_iio_common mt7921e mt7921_common mt792x_lib m=
t76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics =
efi_pstore configfs
2025-07-30T09:47:04.974227+02:00 lisa kernel: [ T3205]  efivarfs autofs4 ex=
t4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper tt=
m drm_panel_backlight_quirks drm_exec drm_suballoc_helper amdxcp drm_buddy =
xhci_pci gpu_sched hid_multitouch xhci_hcd drm_display_helper hid_sensor_hu=
b mfd_core hid_generic i2c_hid_acpi psmouse usbcore amd_sfh i2c_hid nvme dr=
m_kms_helper serio_raw hid nvme_core r8169 cec i2c_piix4 usb_common crc16 i=
2c_smbus i2c_designware_platform i2c_designware_core
2025-07-30T09:47:04.974229+02:00 lisa kernel: [ T3205] CPU: 6 UID: 0 PID: 3=
205 Comm: modprobe Not tainted 6.16.0-next-20250729-master #178 PREEMPT_{RT=
,(full)}=20
2025-07-30T09:47:04.974230+02:00 lisa kernel: [ T3205] Hardware name: Micro=
-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/=
11/2024
2025-07-30T09:47:04.974232+02:00 lisa kernel: [ T3205] RIP: 0010:freq_qos_r=
emove_request+0x89/0xa0
2025-07-30T09:47:04.974233+02:00 lisa kernel: [ T3205] Code: eb e5 48 8d 73=
 08 b9 ff ff ff ff ba 02 00 00 00 e8 6c fb ff ff eb d0 48 c7 c6 c0 ea 20 bb=
 48 c7 c7 40 f5 44 bb e8 c7 a1 f9 ff <0f> 0b b8 ea ff ff ff 5b e9 e5 a4 e0 =
ff b8 ea ff ff ff e9 db a4 e0
2025-07-30T09:47:04.974235+02:00 lisa kernel: [ T3205] RSP: 0018:ffff9f57d2=
6f7ba0 EFLAGS: 00010282
2025-07-30T09:47:04.974236+02:00 lisa kernel: [ T3205] RAX: 000000000000000=
0 RBX: ffff9262c1b22b70 RCX: 0000000000000027
2025-07-30T09:47:04.974238+02:00 lisa kernel: [ T3205] RDX: ffff92652e796d4=
8 RSI: 0000000000000001 RDI: ffff92652e796d40
2025-07-30T09:47:04.974240+02:00 lisa kernel: [ T3205] RBP: ffff9262c0cb240=
0 R08: 0000000000000000 R09: ffff9f57d26f7970
2025-07-30T09:47:04.974241+02:00 lisa kernel: [ T3205] R10: ffff92648f9fffa=
8 R11: 0000000000000003 R12: ffffffffffffffff
2025-07-30T09:47:04.974242+02:00 lisa kernel: [ T3205] R13: ffff9262c0cb240=
0 R14: ffffffffbb6df900 R15: 00000000ffffffff
2025-07-30T09:47:04.974244+02:00 lisa kernel: [ T3205] FS:  00007f1bf1501f0=
0(0000) GS:ffff926572bce000(0000) knlGS:0000000000000000
2025-07-30T09:47:04.974245+02:00 lisa kernel: [ T3205] CS:  0010 DS: 0000 E=
S: 0000 CR0: 0000000080050033
2025-07-30T09:47:04.974247+02:00 lisa kernel: [ T3205] CR2: 00007f169574600=
2 CR3: 00000001f81e2000 CR4: 0000000000750ef0
2025-07-30T09:47:04.974248+02:00 lisa kernel: [ T3205] PKRU: 55555554
2025-07-30T09:47:04.974250+02:00 lisa kernel: [ T3205] Call Trace:
2025-07-30T09:47:04.974251+02:00 lisa kernel: [ T3205]  <TASK>
2025-07-30T09:47:04.974252+02:00 lisa kernel: [ T3205]  acpi_processor_ppc_=
exit+0x55/0x70
2025-07-30T09:47:04.974254+02:00 lisa kernel: [ T3205]  acpi_processor_noti=
fier+0x3b/0x60
2025-07-30T09:47:04.974255+02:00 lisa kernel: [ T3205]  blocking_notifier_c=
all_chain+0x5b/0x80
2025-07-30T09:47:04.974257+02:00 lisa kernel: [ T3205]  cpufreq_policy_free=
+0xfc/0x140
2025-07-30T09:47:04.974258+02:00 lisa kernel: [ T3205]  subsys_interface_un=
register+0x11d/0x130
2025-07-30T09:47:04.974260+02:00 lisa kernel: [ T3205]  cpufreq_unregister_=
driver+0x2f/0xc0
2025-07-30T09:47:04.974261+02:00 lisa kernel: [ T3205]  amd_pstate_unregist=
er_driver+0x10/0x40
2025-07-30T09:47:04.974262+02:00 lisa kernel: [ T3205]  amd_pstate_update_s=
tatus+0x9c/0xe0
2025-07-30T09:47:04.974263+02:00 lisa kernel: [ T3205]  amd_pstate_ut_check=
_driver+0x22/0xb0 [amd_pstate_ut]
2025-07-30T09:47:04.974265+02:00 lisa kernel: [ T3205]  amd_pstate_ut_init+=
0x1c/0x1000 [amd_pstate_ut]
2025-07-30T09:47:04.974267+02:00 lisa kernel: [ T3205]  ? wmi_bmof_driver_e=
xit+0xf30/0xf30 [wmi_bmof]
2025-07-30T09:47:04.974268+02:00 lisa kernel: [ T3205]  do_one_initcall+0x4=
8/0x290
2025-07-30T09:47:04.974270+02:00 lisa kernel: [ T3205]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2025-07-30T09:47:04.974281+02:00 lisa kernel: [ T3205]  ? __kmalloc_cache_n=
oprof+0x7c/0x160
2025-07-30T09:47:04.974283+02:00 lisa kernel: [ T3205]  do_init_module+0x5b=
/0x230
2025-07-30T09:47:04.974285+02:00 lisa kernel: [ T3205]  init_module_from_fi=
le+0x83/0xd0
2025-07-30T09:47:04.974286+02:00 lisa kernel: [ T3205]  idempotent_init_mod=
ule+0xf9/0x2f0
2025-07-30T09:47:04.974288+02:00 lisa kernel: [ T3205]  __x64_sys_finit_mod=
ule+0x68/0xd0
2025-07-30T09:47:04.974289+02:00 lisa kernel: [ T3205]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2025-07-30T09:47:04.974291+02:00 lisa kernel: [ T3205]  do_syscall_64+0x65/=
0xfc0
2025-07-30T09:47:04.974292+02:00 lisa kernel: [ T3205]  entry_SYSCALL_64_af=
ter_hwframe+0x55/0x5d
2025-07-30T09:47:04.974293+02:00 lisa kernel: [ T3205] RIP: 0033:0x7f1bf16f=
b779
2025-07-30T09:47:04.974294+02:00 lisa kernel: [ T3205] Code: ff c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d=
 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d =
4f 86 0d 00 f7 d8 64 89 01 48
2025-07-30T09:47:04.974295+02:00 lisa kernel: [ T3205] RSP: 002b:00007fff3e=
7ea698 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
2025-07-30T09:47:04.974297+02:00 lisa kernel: [ T3205] RAX: ffffffffffffffd=
a RBX: 000056406adbfa30 RCX: 00007f1bf16fb779
2025-07-30T09:47:04.974298+02:00 lisa kernel: [ T3205] RDX: 000000000000000=
4 RSI: 000056406410632b RDI: 0000000000000003
2025-07-30T09:47:04.974300+02:00 lisa kernel: [ T3205] RBP: 000000000000000=
4 R08: 0000000000000000 R09: 000056406adc1420
2025-07-30T09:47:04.974301+02:00 lisa kernel: [ T3205] R10: 000000000000000=
0 R11: 0000000000000246 R12: 000056406410632b
2025-07-30T09:47:04.974303+02:00 lisa kernel: [ T3205] R13: 000000000004000=
0 R14: 000056406adbfb60 R15: 0000000000000000
2025-07-30T09:47:04.974304+02:00 lisa kernel: [ T3205]  </TASK>
2025-07-30T09:47:04.974306+02:00 lisa kernel: [ T3205] ---[ end trace 00000=
00000000000 ]---

[...]

2025-07-30T09:47:05.985112+02:00 lisa kernel: [ T3205] amd_pstate_ut: 5    =
amd_pstate_ut_check_driver	 success!


I bisected this (in between v6.16 and next-20250729) and found
the first bad commit to be
commit d33bd88ac0eb ("ACPI: processor: perflib: Fix initial _PPC limit appl=
ication").

Note that there is another bug [0] when loading amd-pstate-ut. This bug
is present in every version since at least v6.13 while the warning issue
reported in this email is only present in linux-next.

[0] https://lore.kernel.org/lkml/20250731092316.3191-1-spasswolf@web.de/T/#u


Bert Karwatzki
=20=20=20=20

