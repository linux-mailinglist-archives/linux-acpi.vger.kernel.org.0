Return-Path: <linux-acpi+bounces-13738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97766AB92A9
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 01:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B59AA20230
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1424D289E35;
	Thu, 15 May 2025 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="xL3ctv5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAAh2Rw+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6719FA93;
	Thu, 15 May 2025 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747350344; cv=none; b=YtRroZLdSJ6yJK2pbLQq4ry5ZekcwWqG1HyLXXdygKkB+ksDe4nMo6+MbhKNCWGQ4JaLUGqBoYh0rCI56NkFgaEdDfmXQX6VE9hDrH0QhUhsEyMe+IObZ+qU7VZkf6xRHW31zx/WRFZZXhQVhsTP2BRcV25nGmv/n048B5c842o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747350344; c=relaxed/simple;
	bh=cEs2+yF34Xs4bBvxmMPvMak1IG58tE0mb3L9XJmKztw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHVz2ynWeI6Xl24tHK0owlEBmXkY572OTYgSDq36aqPDQmG4VBHMJGbMHNSQL/tVjIhlA/44j2iOj+oMcciUxdM3G1A2n76FBOjlyTazt2VvqYAdYRyo6/zRSU6CKmamW4tzypmjjmDAsxdQQ6W2q1Te4Vt3DcyBiKCXp9MGP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=xL3ctv5Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DAAh2Rw+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADB261140135;
	Thu, 15 May 2025 19:05:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 15 May 2025 19:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747350339; x=1747436739; bh=bG3/nCBxpO
	ZP1UZbjEgqjPi/B/eWSTRKLZU8uiNiaGA=; b=xL3ctv5Q5JKe9RG6cpJUi3m+2B
	mXyE53WkQQQz8PL58s4wy/KR/nSG7LYHJlIEhN8MoOokMO6eboq/XkzRp/3t55un
	Dn6eHMjjYs6Hus0N6bMa3X5D2jt6+4GhBSHDa/nfkCkv9IHdUl16KZcJOr5r2H3y
	qudYjfCeZbBkzhPAT7OG0KQ94qRQ15z/8+Q8pM9pfEhF+SJW/2jxEYkhP6YM2O++
	udb/KVVi/qB0xGazAM9/yJMWbh2PYkcpVvtW7LNcvB6D7fh4eo+EBAIklRa87nC6
	m7UsSJFoOUfkl4WJ+F1Gtcbhn+7syKwQOplBhlnAUaALbiXbTGRemNlRtCCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747350339; x=1747436739; bh=bG3/nCBxpOZP1UZbjEgqjPi/B/eWSTRKLZU
	8uiNiaGA=; b=DAAh2Rw+ZHZVrlgmFuQDZ/MdjeD+LgmkYuJNxkZA57C5c/yoVFS
	iOH06ELePSodrx+CJbZ2L6oixmm5AOdoj1ppinOPlLtTi8n0jK28+pwYUlDfCc0R
	K34acJF5gaFLdq9jc4MrmRtc3kX1b/nypYNRHqoFudkrsCd1dPolktJUZiLlPTb5
	zQGmWFkKe+oB9j1/YK5g9DNxQB8J5pBaINT7xHHkE3IenH+Rn6Cf59T3pF+/k0MY
	OgUQ36rMwnS2Aiv76hILoE9e8AKU6wYCXwjbeX0fJ/0N2+/4kjPXPEBa9N5y8i/u
	qLsf12zYivmwuHC/naYXIZLDdgEHNzhLUlg==
X-ME-Sender: <xms:Q3MmaEKWyNfHXh4KOTydO-MK4shTldf0KzgOR4s5debRrDqPxMfo-A>
    <xme:Q3MmaEJiNSBYulFuo6BdzTBa3cLIXZQM28l5sz2KnBHQl2Ig3bEslTJfk_lq47YsZ
    0maqPHBjPhsNEgas-o>
X-ME-Received: <xmr:Q3MmaEt6OnWZNmEnuKkmkfvyWSJFC1Inrj5C-t2WibcEGw8UfKHJ-wjjJh8fPnPLAwu2ngHfH39h_1xX98oO61qT_AqCfxl3o08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedu
    geethfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvgdprhgtph
    htthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhshhhnuhhotghvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhise
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Q3MmaBbgzH_9mbQAB8GQ3i4SLbum3Poy7iO7RfJ5yU7J3phZH_lljw>
    <xmx:Q3MmaLbxGmA07ZdDzM0CBdLusX7oXq1HMixyqMOJtTf_CLQb6E3sFg>
    <xmx:Q3MmaNAKUUmm5bviBcrKVQ0qpReOg1IifEJr6uxlPTH574FwcSk2tg>
    <xmx:Q3MmaBYMltETE4U8NwIdGLJ6357t8EUHCZ1PLJr5hU1zQVcg2l-AxQ>
    <xmx:Q3MmaMIoLIA3xuY3iwT6mjwvGHTH8qW-NAU5tDhKctrVrgwfVsiL7STm>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 19:05:38 -0400 (EDT)
Date: Fri, 16 May 2025 01:05:37 +0200
From: Janne Grunau <j@jannau.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Vishnu Sankar <vishnuocv@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: Unbreak USB/BT keyboards on non-ACPI
 platforms
Message-ID: <20250515230537.GA1556976@robin.jannau.net>
References: <20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net>
 <b77edae0-50bd-4039-9487-15bb69389c6c@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b77edae0-50bd-4039-9487-15bb69389c6c@gmx.de>

On Fri, May 16, 2025 at 12:05:11AM +0200, Armin Wolf wrote:
> Am 12.05.25 um 23:55 schrieb Janne Grunau via B4 Relay:
> 
> > From: Janne Grunau <j@jannau.net>
> >
> > Commit 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd
> > Fn keys") added a dependency on ACPI_PLATFORM_PROFILE to cycle through
> > power profiles. This breaks USB and Bluetooth keyboards on non-ACPI
> > platforms since platform_profile_init() fails. See the warning below for
> > the visible symptom but cause is the dependency on the platform_profile
> > module.
> >
> > [  266.225052] kernel: usb 1-1.3.2: new full-speed USB device number 9 using xhci_hcd
> > [  266.316032] kernel: usb 1-1.3.2: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
> > [  266.327129] kernel: usb 1-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > [  266.327623] kernel: usb 1-1.3.2: Product: ThinkPad Compact USB Keyboard with TrackPoint
> > [  266.328096] kernel: usb 1-1.3.2: Manufacturer: Lenovo
> > [  266.337488] kernel: ------------[ cut here ]------------
> > [  266.337551] kernel: WARNING: CPU: 4 PID: 2619 at fs/sysfs/group.c:131 internal_create_group+0xc0/0x358
> > [  266.337584] kernel: Modules linked in: platform_profile(+) nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft>
> > [  266.337685] kernel:  apple_sio spi_apple apple_dart soundcore spmi_apple_controller pinctrl_apple_gpio i2c_pasemi_platform apple_admac i2c_pasemi_core clk_apple_nco xhci_pla>
> > [  266.337717] kernel: CPU: 4 UID: 0 PID: 2619 Comm: (udev-worker) Tainted: G S      W          6.14.4-400.asahi.fc41.aarch64+16k #1
> > [  266.337750] kernel: Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> > [  266.337776] kernel: Hardware name: Apple Mac mini (M1, 2020) (DT)
> > [  266.337808] kernel: pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > [  266.337834] kernel: pc : internal_create_group+0xc0/0x358
> > [  266.337860] kernel: lr : sysfs_create_group+0x20/0x40
> > [  266.337886] kernel: sp : ffff800086f877a0
> > [  266.337914] kernel: x29: ffff800086f877b0 x28: 0000000000000000 x27: ffffb66d0b338348
> > [  266.337939] kernel: x26: ffffb66d0b338358 x25: ffffb66d528c7c50 x24: ffffb66d507e37b0
> > [  266.337965] kernel: x23: 0000fffebf6708d8 x22: 0000000000000000 x21: ffffb66d0b370340
> > [  266.337991] kernel: x20: ffffb66d0b370308 x19: 0000000000000000 x18: 0000000000000000
> > [  266.338029] kernel: x17: 554e514553007373 x16: ffffb66d4f8c2268 x15: 595342555300656c
> > [  266.338051] kernel: x14: 69666f72702d6d72 x13: 00353236353d4d55 x12: 4e51455300737361
> > [  266.338075] kernel: x11: ffff6adf91b80100 x10: 0000000000000139 x9 : ffffb66d4f8c2288
> > [  266.338097] kernel: x8 : ffff800086f87620 x7 : 0000000000000000 x6 : 0000000000000000
> > [  266.338116] kernel: x5 : ffff6adfc896e100 x4 : 0000000000000000 x3 : ffff6adfc896e100
> > [  266.338139] kernel: x2 : ffffb66d0b3703a0 x1 : 0000000000000000 x0 : 0000000000000000
> > [  266.338155] kernel: Call trace:
> > [  266.338173] kernel:  internal_create_group+0xc0/0x358 (P)
> > [  266.338193] kernel:  sysfs_create_group+0x20/0x40
> > [  266.338206] kernel:  platform_profile_init+0x48/0x3ff8 [platform_profile]
> > [  266.338224] kernel:  do_one_initcall+0x60/0x358
> > [  266.338239] kernel:  do_init_module+0x94/0x260
> > [  266.338257] kernel:  load_module+0x5e0/0x708
> > [  266.338271] kernel:  init_module_from_file+0x94/0x100
> > [  266.338290] kernel:  __arm64_sys_finit_module+0x268/0x360
> > [  266.338309] kernel:  invoke_syscall+0x6c/0x100
> > [  266.338327] kernel:  el0_svc_common.constprop.0+0xc8/0xf0
> > [  266.338346] kernel:  do_el0_svc+0x24/0x38
> > [  266.338365] kernel:  el0_svc+0x3c/0x170
> > [  266.338385] kernel:  el0t_64_sync_handler+0x10c/0x138
> > [  266.338404] kernel:  el0t_64_sync+0x1b0/0x1b8
> > [  266.338419] kernel: ---[ end trace 0000000000000000 ]---
> >
> > Fixes: 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd Fn keys")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Janne Grunau <j@jannau.net>
> >
> > ------>8---------
> > I don't see an easy solution to keep the functionality in generic HID
> > code which is used on non-ACPI platforms. Solution for this are not
> > trivial so remove the functionality for now.
> > Cc-ing the ACPI maintainers in the case they can think of a solution for
> > this issue.
> 
> Hi,
> 
> i think we can fix that. We just have to skip the compat stuff if acpi_kobj is NULL (means that ACPI is not used).
> The modern platform profile interface is generic enough to also work on non-ACPI systems.
> 
> Can you test a patch?

I can easily test patches

Janne

