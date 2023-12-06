Return-Path: <linux-acpi+bounces-2173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABB8072A3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 15:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B48F1F211D2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0991A2D61F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XknO4s2c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE1B112
	for <linux-acpi@vger.kernel.org>; Wed,  6 Dec 2023 04:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lQNfvPCw3j/wOYSAPm81sd4y0Q9870OtK1TcsteLT1M=; b=XknO4s2cpEiUCyKxHTQK+HS9wP
	XRRMD593tlwhzLg2rI/iEr3n7zohlFsWg2pI2WePRqmmfWJ8SORKPLJczwZ+REnFLNv5zxJvlXfWs
	oUI6L8iDqoFR0Ri+/9zc0zk5nIqARO1vgXBXg7Kaymx2J9axP1ktP/ROK7FbT6ad9unSiLGFT4cwp
	KSzczsZLOkXUIHF3vPGnnjRQGB7/L2Y0VDcYdyXtJm8nBHeolDCu3RB/hJFiAmTwaHAPXax5sxc92
	Y5KKBfZRhpViiKvyXgmQPKYgZ6zsDVP0XAzZD3Bx08H02Na5TeFF2hE+1PFLKDRa+YOpOAS9dqTbG
	L3NHGUcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rArF6-00AIZL-2W;
	Wed, 06 Dec 2023 12:43:08 +0000
Date: Wed, 6 Dec 2023 04:43:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: warning in drivers/acpi/platform_profile.c, line 74
Message-ID: <ZXBsXCY2hP5vp9El@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

on my AMD-based Thinkapd T14s get the warning below very frequently
in the kernel log:

Something seems to be out of bounds for the platform profiles, what
is the best ay to figure out what is going on here?


[64338.910509] WARNING: CPU: 0 PID: 867 at drivers/acpi/platform_profile.c:=
74 platform_profile_show+0xa2/0xd0 [platform_profile]
[64338.910593] Modules linked in: usbkbd(E) usbhid(E) ctr(E) ccm(E) cmac(E)=
 rfcomm(E) qrtr_mhi(E) bnep(E) btusb(E) btrtl(E) btintel(E) btbcm(E) blueto=
oth(E) ath11k_pci(E) ath11k(E) qmi_helpers(E) joydev(E) sha3_generic(E) jit=
terentropy_rng(E) sha512_generic(E) nls_iso8859_1(E) mac80211(E) vfat(E) dr=
bg(E) fat(E) ansi_cprng(E) ecdh_generic(E) ecc(E) crc16(E) libarc4(E) snd_c=
tl_led(E) intel_rapl_msr(E) snd_acp6x_pdm_dma(E) snd_soc_acp6x_mach(E) snd_=
soc_dmic(E) snd_hda_codec_realtek(E) intel_rapl_common(E) thinkpad_acpi(E) =
snd_hda_codec_hdmi(E) snd_soc_core(E) snd_hda_codec_generic(E) crc32_pclmul=
(E) nvram(E) ghash_clmulni_intel(E) ledtrig_audio(E) cfg80211(E) platform_p=
rofile(E) snd_hda_intel(E) tpm_crb(E) snd_intel_dspcfg(E) snd_hda_codec(E) =
snd_hwdep(E) snd_pci_acp6x(E) aesni_intel(E) snd_acp_config(E) libaes(E) sn=
d_hda_core(E) snd_soc_acpi(E) crypto_simd(E) cryptd(E) pcspkr(E) snd_pcm(E)=
 tpm_tis(E) wmi_bmof(E) tpm_tis_core(E) ucsi_acpi(E) snd_timer(E) tpm(E) sn=
d(E) typec_ucsi(E) mhi(E) soundcore(E) rfkill(E) typec(E)
[64338.911365]  rng_core(E) ac(E) battery(E) amd_pmc(E) hid_multitouch(E) e=
vdev(E) serio_raw(E) loop(E) efi_pstore(E) ip_tables(E) x_tables(E) autofs4=
(E) efivarfs(E) hid_generic(E) i2c_hid_acpi(E) i2c_hid(E) xhci_pci(E) hid(E=
) nvme(E) nvme_core(E) xhci_hcd(E) t10_pi(E) crc32c_intel(E) psmouse(E) thu=
nderbolt(E) usbcore(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) usb_common(=
E) crct10dif_generic(E) crct10dif_pclmul(E) crct10dif_common(E) fan(E) i2c_=
designware_platform(E) i2c_designware_core(E)
[64338.911762] CPU: 0 PID: 867 Comm: power-profiles- Tainted: G        W   =
E      6.6.2 #1946
[64338.911794] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET65W (=
1.35 ) 08/08/2023
[64338.911810] RIP: 0010:platform_profile_show+0xa2/0xd0 [platform_profile]
[64338.911871] Code: c6 08 e1 b8 c0 48 89 ef e8 bb bf f1 ef 48 98 48 8b 54 =
24 08 65 48 2b 14 25 28 00 00 00 75 2b 48 83 c4 10 5b 5d e9 5e eb bb f0 <0f=
> 0b 48 c7 c0 fb ff ff ff eb da 48 c7 c7 a0 c0 b8 c0 e8 d7 78 bb
[64338.911894] RSP: 0018:ffffa4efc251fdd8 EFLAGS: 00010296
[64338.911925] RAX: 0000000088b3abe0 RBX: 0000000000000000 RCX: ffffffffc0b=
8c060
[64338.911947] RDX: 0000000000000000 RSI: ffffa4efc251fddc RDI: ffffffffc0b=
8c0a0
[64338.911966] RBP: ffff9325f19ca000 R08: ffff932280e383c0 R09: ffff9322977=
43b00
[64338.911984] R10: ffffa4efc251fe70 R11: ffff93228243a498 R12: ffffa4efc25=
1fe98
[64338.912002] R13: ffffa4efc251fe70 R14: 0000000000000001 R15: 00000000000=
00001
[64338.912021] FS:  00007fe1030dd680(0000) GS:ffff93299ee00000(0000) knlGS:=
0000000000000000
[64338.912046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[64338.912067] CR2: 0000000002afa040 CR3: 00000001417bc000 CR4: 00000000007=
50ef0
[64338.912088] PKRU: 55555554
[64338.912102] Call Trace:
[64338.912122]  <TASK>
[64338.912139]  ? platform_profile_show+0xa2/0xd0 [platform_profile]
[64338.912188]  ? __warn+0x7d/0x130
[64338.912238]  ? platform_profile_show+0xa2/0xd0 [platform_profile]
[64338.912290]  ? report_bug+0x18d/0x1c0
[64338.912345]  ? handle_bug+0x3c/0x70
[64338.912384]  ? exc_invalid_op+0x13/0x60
[64338.912420]  ? asm_exc_invalid_op+0x16/0x20
[64338.912487]  ? platform_profile_show+0xa2/0xd0 [platform_profile]
[64338.912541]  ? platform_profile_show+0x5e/0xd0 [platform_profile]
[64338.912592]  sysfs_kf_seq_show+0xa3/0xf0
[64338.912636]  seq_read_iter+0x122/0x470
[64338.912687]  vfs_read+0x1b4/0x300
[64338.912755]  ksys_read+0x63/0xe0
[64338.912799]  do_syscall_64+0x3a/0x90
[64338.912841]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[64338.912876] RIP: 0033:0x7fe1037f80dc
[64338.912904] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 e9 =
d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48=
> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 3f d6 f8 ff 48
[64338.912927] RSP: 002b:00007fff32cec810 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[64338.912962] RAX: ffffffffffffffda RBX: 0000559ba59fb9b0 RCX: 00007fe1037=
f80dc
[64338.912983] RDX: 0000000000001000 RSI: 0000559ba5a15960 RDI: 00000000000=
00009
[64338.913002] RBP: 00007fff32cec948 R08: 0000000000000000 R09: 00007fe1038=
d2df0
[64338.913021] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[64338.913040] R13: 00007fff32cec950 R14: 0000000000000000 R15: 00000000000=
00009
[64338.913098]  </TASK>
[64338.913112] ---[ end trace 0000000000000000 ]---

