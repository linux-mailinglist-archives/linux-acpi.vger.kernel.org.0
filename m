Return-Path: <linux-acpi+bounces-12487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4E6A727E9
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 01:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA918977DF
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 00:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF0CDDD3;
	Thu, 27 Mar 2025 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="v6Nk7hWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nw4zHffZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF72C2C8;
	Thu, 27 Mar 2025 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743036680; cv=none; b=F0useipYIL8bIT+nzDW/GolA0PNZcKULGBLDnkg451yRhWWW85z3iwAF/KkZQvGarkv66r5AH1OzH9DrivqRnPfjs4gWrckWH0zjhlO28VkT2aKwQO2/+b23rTRrPHbT3G8Hw+bh7cvIbwYFnLrHB86/L4jwt8CJ0etWgb195CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743036680; c=relaxed/simple;
	bh=AmXMEkqXE1h1h0eF9MwFI2oBkJ4mzzLnIbNGT9AgyE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YYz15RboNkVGdTl0eIq+J2KtRQhYlzvrVJ6CKOFIigGJAgC7oQeyn413iFWxpc80oiV2vShP88BmlN/0OD6m1SLJcycJEPnXRtKlQbHrVc9G+jnRVvvc6gHuc/DVKHVtZu5mHyK9UvH3ppVrTJdgOwU56OFOUtPtmpS10ko1ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=v6Nk7hWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nw4zHffZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8156D1382D8F;
	Wed, 26 Mar 2025 20:51:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 20:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1743036677; x=1743123077; bh=aH
	gpfGvsQEpk4WJmGuLs0xRXWghu0gspE2h/8NA1P04=; b=v6Nk7hWcAZiXa1h681
	IFRM5aviXQ7RY/dzHCryRBc1p7z7LX9Wb+TY0OdSowW06eGHnm4Okyk1dy+OFKCM
	BWb5tzehwVwqR9adnSSTSeojJxT+LsuyNrfaOH1P15vGIaJHfQ4LhKl8n+f03jpm
	8Hs0Bcwz13mwTQpEWa0MevDO+4bwsi14FukJQhkc2lfQWrmNZr6ic+3IOgYTqSnA
	4WSTbwzjbsSm0y7Xn9pOL5WzFny3Z1E7mL2RNaiTPaHmXKuS47q1bWvcTo6LR+Qi
	pS6K+UFlKgA8P/MMBEthcqWxDoaB5a4X6c4IPUMF0JUyxbO2ns7r2paWYyW38sOM
	uYMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743036677; x=
	1743123077; bh=aHgpfGvsQEpk4WJmGuLs0xRXWghu0gspE2h/8NA1P04=; b=n
	w4zHffZ4rADErIe1X+uJIswEdPUn1G9Y1D6PvI9JfjsX3uGbcX3wuKH+c2V8mxqI
	4ggCFqeC1RnlXGP+gVOpKUoVmnckoKq9Ft+k82dNN9DJKfOWVqrP9vhT3+LGo1WF
	69hUrwaGFW1WKL5O/ccsxLv+DNNlrBdTd/TL4qoMf4lEpfr9AMSKZ9VIET972nUa
	1dgd7NaEjXEm7myusMQBsIJBL+io7BywRfe92hs4MLKjvIYp6LGOEyyWpB4buWAg
	flwLaKJyF0cY0xndwyZVeiZL73yWAoGPVW8W1+OVm+obea4SAW9MsAzm2EL0zNIy
	fz1Lr3Kxv4hRfWBErl60w==
X-ME-Sender: <xms:BaHkZzE2pJgqRmZOc3r0CjC7u86x9HrNtj8qEhIgaJn1557CB-IAVQ>
    <xme:BaHkZwU1vUFBOhiFcNR_pajS27VUDnzhxbfc_MXQ6df8hKd3uFbqyn425OVujLS2W
    A4h0FpzSYicEQ>
X-ME-Received: <xmr:BaHkZ1JpLiljDaaSJ_EzTIA21sXWkev5kw7oBJVY_qM4OzfQucMZeRo0BTZnURJpsZx4fTHGc0bh7KS-w_3DF7RWLUTjioC4gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesghdtreertddtjeen
    ucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomh
    grrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggft
    rfgrthhtvghrnhepgfdtgfdvteetffeluefgudfggeejkefgfeffvdehfffhtdefgefgue
    ehtdffueelnecuffhomhgrihhnpehquhgsvghsqdhoshdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphht
    thhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    igvghnqdguvghvvghlsehlihhsthhsrdigvghnphhrohhjvggtthdrohhrghdprhgtphht
    thhopehjghhrohhsshesshhushgvrdgtohhmpdhrtghpthhtoheprhgvghhrvghsshhioh
    hnsheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:BaHkZxHw3bMVFOEj4GGqr1F7NTButjSDBu25haS8k-b_IJPV6SGnhg>
    <xmx:BaHkZ5VBHkXyjj6geWdGr8S8gX93KOaq2dco7UjC7KVc2Ua93MzO1A>
    <xmx:BaHkZ8NmEMl3cQl7QcXC9X-_NQa7Kq-BplrfKg4Yox3SDVUNwtOrRA>
    <xmx:BaHkZ42EsKC3pRiXmr64C9QNIYUJ9869j1N5sDLyvw_fkfzNzJIrlA>
    <xmx:BaHkZ1pKcoIr0UaT5Kl3lc8iL4zvRqhhuVLqJYut77Enhw7a8HVr5uUr>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 20:51:15 -0400 (EDT)
Date: Thu, 27 Mar 2025 01:51:13 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	xen-devel <xen-devel@lists.xenproject.org>,
	Juergen Gross <jgross@suse.com>, regressions@lists.linux.dev
Subject: NULL pointer dereference in cpufreq_update_limits(?) under Xen PV
 dom0 - regression in 6.13
Message-ID: <Z-ShAR59cTow0KcR@mail-itl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jK9RafVCHRtlVVtN"
Content-Disposition: inline


--jK9RafVCHRtlVVtN
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Mar 2025 01:51:13 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	xen-devel <xen-devel@lists.xenproject.org>,
	Juergen Gross <jgross@suse.com>, regressions@lists.linux.dev
Subject: NULL pointer dereference in cpufreq_update_limits(?) under Xen PV
 dom0 - regression in 6.13

Hi,

I've got a report[1] that 6.13.6 crashes as listed below. It worked fine in
6.12.11. We've tried few simple things to narrow the problem down, but
without much success.

This is running in Xen 4.17.5, PV dom0, which probably is relevant here.
This is running on AMD Ryzen 9 7950X3D, with ASRock X670E Taichi
motherboard.
There are few more details in the original report (link below).

The kernel package (including its config saved into /boot) is here:
https://yum.qubes-os.org/r4.2/current/host/fc37/rpm/kernel-latest-6.13.6-1.=
qubes.fc37.x86_64.rpm
https://yum.qubes-os.org/r4.2/current/host/fc37/rpm/kernel-latest-modules-6=
=2E13.6-1.qubes.fc37.x86_64.rpm

The crash message:
[    9.367048] BUG: kernel NULL pointer dereference, address: 0000000000000=
070
[    9.368251] #PF: supervisor read access in kernel mode
[    9.369273] #PF: error_code(0x0000) - not-present page
[    9.370346] PGD 0 P4D 0
[    9.371222] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    9.372114] CPU: 0 UID: 0 PID: 128 Comm: kworker/0:2 Not tainted 6.13.6-=
1.qubes.fc37.x86_64 #1
[    9.373184] Hardware name: ASRock X670E Taichi/X670E Taichi, BIOS 3.20 0=
2/21/2025
[    9.374183] Workqueue: kacpi_notify acpi_os_execute_deferred
[    9.375124] RIP: e030:cpufreq_update_limits+0x10/0x30
[    9.375840] Code: 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 05 98 e4 21 02 <48=
> 8b 40 70 48 85 c0 74 06 e9 a2 36 38 00 cc e9 ec fe ff ff 66 66
[    9.377009] RSP: e02b:ffffc9004058be28 EFLAGS: 00010246
[    9.377667] RAX: 0000000000000000 RBX: ffff888005bf4800 RCX: ffff88805d6=
35fa8
[    9.378415] RDX: ffff888005bf4800 RSI: 0000000000000085 RDI: 00000000000=
00000
[    9.379127] RBP: ffff888005cd7800 R08: 0000000000000000 R09: 80808080808=
08080
[    9.379887] R10: ffff88800391abc0 R11: fefefefefefefeff R12: ffff888004e=
8aa00
[    9.380669] R13: ffff88805d635f80 R14: ffff888004e8aa15 R15: ffff8880059=
baf00
[    9.381514] FS:  0000000000000000(0000) GS:ffff88805d600000(0000) knlGS:=
0000000000000000
[    9.382345] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.383045] CR2: 0000000000000070 CR3: 000000000202c000 CR4: 00000000000=
50660
[    9.383786] Call Trace:
[    9.384335]  <TASK>
[    9.384886]  ? __die+0x23/0x70
[    9.385456]  ? page_fault_oops+0x95/0x190
[    9.386036]  ? exc_page_fault+0x76/0x190
[    9.386636]  ? asm_exc_page_fault+0x26/0x30
[    9.387215]  ? cpufreq_update_limits+0x10/0x30
[    9.387805]  acpi_processor_notify.part.0+0x79/0x150
[    9.388402]  acpi_ev_notify_dispatch+0x4b/0x80
[    9.389013]  acpi_os_execute_deferred+0x1a/0x30
[    9.389610]  process_one_work+0x186/0x3b0
[    9.390205]  worker_thread+0x251/0x360
[    9.390765]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.391376]  ? __pfx_worker_thread+0x10/0x10
[    9.391957]  kthread+0xd2/0x100
[    9.392493]  ? __pfx_kthread+0x10/0x10
[    9.393043]  ret_from_fork+0x34/0x50
[    9.393575]  ? __pfx_kthread+0x10/0x10
[    9.394090]  ret_from_fork_asm+0x1a/0x30
[    9.394621]  </TASK>
[    9.395106] Modules linked in: gpio_generic amd_3d_vcache acpi_pad(-) lo=
op fuse xenfs dm_thin_pool dm_persistent_data dm_bio_prison amdgpu amdxcp i=
2c_algo_bit drm_ttm_helper ttm crct10dif_pclmul drm_exec crc32_pclmul gpu_s=
ched
crc32c_intel drm_suballoc_helper polyval_clmulni drm_panel_backlight_quirks=
 polyval_generic drm_buddy ghash_clmulni_intel sha512_ssse3 drm_display_hel=
per sha256_ssse3 sha1_ssse3 xhci_pci cec nvme sp5100_tco xhci_hcd nvme_core=
 nvme_auth
video wmi xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntall=
oc xen_gntdev xen_evtchn scsi_dh_rdac scsi_dh_emc scsi_dh_alua uinput dm_mu=
ltipath
[    9.398698] CR2: 0000000000000070
[    9.399266] ---[ end trace 0000000000000000 ]---
[    9.399880] RIP: e030:cpufreq_update_limits+0x10/0x30
[    9.400528] Code: 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 05 98 e4 21 02 <48=
> 8b 40 70 48 85 c0 74 06 e9 a2 36 38 00 cc e9 ec fe ff ff 66 66
[    9.401673] RSP: e02b:ffffc9004058be28 EFLAGS: 00010246
[    9.402316] RAX: 0000000000000000 RBX: ffff888005bf4800 RCX: ffff88805d6=
35fa8
[    9.403060] RDX: ffff888005bf4800 RSI: 0000000000000085 RDI: 00000000000=
00000
[    9.403819] RBP: ffff888005cd7800 R08: 0000000000000000 R09: 80808080808=
08080
[    9.404581] R10: ffff88800391abc0 R11: fefefefefefefeff R12: ffff888004e=
8aa00
[    9.405332] R13: ffff88805d635f80 R14: ffff888004e8aa15 R15: ffff8880059=
baf00
[    9.406063] FS:  0000000000000000(0000) GS:ffff88805d600000(0000) knlGS:=
0000000000000000
[    9.406830] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.407561] CR2: 0000000000000070 CR3: 000000000202c000 CR4: 00000000000=
50660
[    9.408318] Kernel panic - not syncing: Fatal exception
[    9.409022] Kernel Offset: disabled
(XEN) Hardware Dom0 crashed: 'noreboot' set - not rebooting.

Looking at the call trace, it's likely related to ACPI, and Xen too, so
I'm adding relevant lists too.

Any ideas?

#regzbot introduced: v6.12.11..v6.13.6

[1] https://forum.qubes-os.org/t/kernel-latest-6-13-6-boot-loop/32926

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--jK9RafVCHRtlVVtN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmfkoQEACgkQ24/THMrX
1yw1pQgAiGheqvBVAzHRFCalG+1EJQd6wmukzpCgFaXCkqkogTtXUbL5pnar1ZGK
1FzPFjP788c944gItnjaT3DhndMNBosTVjxe3PuogF7hwZVM7DuJ3zsWpoQq9cyO
jsR/A3B25Nq9j4CM09Q74U+NRpS1sy3QtUH71D8+U0qhsc/RwrKzfrDD4RT/Az7X
OFU/6dT2hfi+4tlGWCSwPlSFss7oL6h2OvlfEBb8bKUoNX1C6r9wA4pMSqTI4mSz
HMUaAnKegjA5LekTjYiCoCX+CAm4yE03SPrVOimmLQa/Elh3s7PDt9PNesatzGxn
B5oM/RNS+k73QptVRsjTpl/DH8fS+w==
=zTtu
-----END PGP SIGNATURE-----

--jK9RafVCHRtlVVtN--

