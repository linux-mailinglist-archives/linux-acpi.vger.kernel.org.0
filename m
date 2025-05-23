Return-Path: <linux-acpi+bounces-13866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EFAC27A2
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1438E1894C97
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA4296FA7;
	Fri, 23 May 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="agsAbmY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IP7+WWPm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FC221DA8;
	Fri, 23 May 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017763; cv=none; b=BgpeXHiMXJqIsE0tArmaCZ7PehpOpauGKLwBi6fH9AZdpOmbYyKmr8XwABY0zJ2JmljjiFIUij72PokICmK2QsDOYdntY/05GdPLfUmT9BxlnFrVQ936BD/w6rApdGDvHBjjZN+JmBYXSdpvPbaksCJY1uido9jyAEPz2I45xxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017763; c=relaxed/simple;
	bh=Kw6bWuaiyS3+hflqZXKFnnrzeY0NQuNKqxzLWMI8hCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utuFc//aeyguVWqWKydR08dLGINwbrKBBxLziZdF/t91TifF49riQuADtX305BJS3PNo6nlQ25kMm4Fyh26QT72VdaXPcqn5RNzvBKEjkh+Fp6JHbxhHf+ukvaFVbAEI3juwMKgAiQ3h/7p/PixnBPot3nw7nPtSlA8jrq/InrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=agsAbmY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IP7+WWPm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AC521140115;
	Fri, 23 May 2025 12:29:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 23 May 2025 12:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1748017760;
	 x=1748104160; bh=/jlfPNouODknHqpqkHZeeFhINTA3VzKs1lAxLlE+jls=; b=
	agsAbmY33GMWvWyNeAaz6utYRbBJfT3Ry4Jq8JESCeXlyPhOJYokhBeY6M0X/Rsg
	Kem9qxXzOthnAOfSEen8pC7bds9o1CLHcQqwJjz4OGBGDgQNcXZeIX6S26z+E+N4
	Ml6n69RI5s2GieN6BqZQsMBCTlYYbc9ixYd6ufLP5SD0YEyhjYsPBWe1ayPYpOKv
	P6u+GU3Hao0WZoMuncTZ4aphvH3DFTF7vo52JMy3xfwrX0UphuwIYr9fSgjcYxd3
	s40ypq18yK1QxVrm1Pxhqgf8TLVWtJxF2KFIUuGGbt2WoPhKOZwQ9qEbXyF7wnwq
	IpYpPUvbEfOSwgl+M1gW5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748017760; x=
	1748104160; bh=/jlfPNouODknHqpqkHZeeFhINTA3VzKs1lAxLlE+jls=; b=I
	P7+WWPmfAGkSo1ldXj/sdRVvNyyFulS7EJZzeLDfDwPbEHj/WAOvvMJxAPes3JJN
	oTPsGFAX9waXsOkTBAb60Exojg5sN2qgyD5nAuLuLs6WAYeMA8Oom1EEK+bwtZPi
	ylNqDxfH2Zb5yTPSWEzLXIoWZhc3XpGVcHOboxWwAgDFycfv2r/ikp1aXIJIT7Sq
	hkQVuGaMweOuekbC7h/mDkCg1Fie5cJF52F6WXcp1B5TQjdTVjCMfNxQcdsKaIx8
	U7cPFuiqkOBJdeEdPVnC343CxAFDJTblh9D0XJPq+4UlB3zj604nXJ9IQ8AwNdP4
	O95LHXo01JxQ7BDWmR1HQ==
X-ME-Sender: <xms:X6IwaFWHPctf93jQ6FEg67qFg4cyLbR1Y3lf47CePyykrmt_jCMHDA>
    <xme:X6IwaFkZG5GxWlJpYmR2UDSJt-9FGi22AEnoiorD3HgV0bhKukLbJhSfodpnSDsA6
    MPJkTcY5YqoRR3o1iU>
X-ME-Received: <xmr:X6IwaBYZvKTIf4NsR8Gb6Z56QbeYwjjkDHsUAp5lsfv7ux534iBg4aXjW6O5fEOrEKtuXOaP7IBoGZ57fwHj66djSRaltKS3G2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelfeegucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggugfgjsehtkeertddttdejnecuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjse
    hjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefgfefhvdeuvdffteegueev
    lefhtdffgeefhefgffehtdegffefveetieeutdetnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    peifpggrrhhmihhnsehgmhigrdguvgdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X6IwaIXey5ugv4zkfWpdPRU1ccUIRNBkCtk92rxWUsQK6VZJZBzMqQ>
    <xmx:X6IwaPkAmTRSf7fyM4iBDIXJTrZq45ybrsOMZXhsRoX-YKNT9MJs7g>
    <xmx:X6IwaFe8dzDt7oALnJAGbSTTfu_DU4u0ojhsxpu784x4e5qYuDqYEA>
    <xmx:X6IwaJHsAruKQ1rSPXbSK_p0LBQEnRzLTp0UCjTUoycPkvH0GR8ZGw>
    <xmx:YKIwaONIxjOB8CBz6Ha4sBVid0pI8usgKKyBuE-FzCD_Z9dWgXtO76oU>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 12:29:19 -0400 (EDT)
Date: Fri, 23 May 2025 18:29:17 +0200
From: Janne Grunau <j@jannau.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Add support for non-ACPI
 platforms
Message-ID: <20250523162917.GC2575813@robin.jannau.net>
References: <20250518185111.3560-1-W_Armin@gmx.de>
 <CAJZ5v0hNmMtR4V0tYqD1dV2BqAKJ2sCOyBadkVtG3sS3V90uvw@mail.gmail.com>
 <a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de>
 <CAJZ5v0icRdTSToaKbdf=MdRin4NyB2MstUVaQo8VR6-n7DkVMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0icRdTSToaKbdf=MdRin4NyB2MstUVaQo8VR6-n7DkVMQ@mail.gmail.com>

On Fri, May 23, 2025 at 04:39:59PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 22, 2025 at 6:34 AM Armin Wolf <W_Armin@gmx.de> wrote:
> >
> > Am 21.05.25 um 22:17 schrieb Rafael J. Wysocki:
> >
> > > On Sun, May 18, 2025 at 8:51 PM Armin Wolf <W_Armin@gmx.de> wrote:
> > >> Currently the platform profile subsystem assumes that all supported
> > >> (i.e. ACPI-capable) platforms always run with ACPI being enabled.
> > >> However some ARM64 notebooks do not support ACPI and are instead
> > >> using devicetree for booting.
> > >>
> > >> Do not register the legacy sysfs interface on such devices as it
> > >> depends on the acpi_kobj (/sys/firmware/acpi/) being present. Users
> > >> are encouraged to use the new platform-profile class interface
> > >> instead.
> > > So how does it work in this case?
> > >
> > The platform profile subsystem also exposes a more modern class-based sysfs interface,
> > see Documentation/ABI/testing/sysfs-class-platform-profile for details.
> >
> > This interface does not depend on /sys/firmware/acpi being present, so userspace
> > programs can still control the platform profiles using the class-based interface.
> >
> > This will become very important once we have platform profile drivers not depending on
> > some sort of ACPI interface. I suspect that sooner or later some drivers for the embedded
> > controllers on ARM64 notebooks (devicetree!) will register with the platform profile subsystem.
> >
> > Apart from that this allows input drivers using platform_profile_cycle() to work on non-ACPI
> > platforms (like ARm64 devices using devicetree).
> 
> This driver though is located in drivers/acpi/ and depends on
> CONFIG_ACPI.  Moreover, the platform profile provider drivers need to
> select ACPI_PLATFORM_PROFILE so it gets built.  This means that there
> are no non-ACPI platform profile providers currently in the tree.
> 
> While the observation that the code in the driver, other than the
> legacy sysfs interface, doesn't really depend on ACPI is valid, if you
> want it to be used on systems without ACPI, it needs to be properly
> converted to a generic driver.
> 
> For now, it is better to simply make it fail to initialize without
> ACPI, so I'm going to apply this patch:
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/20250522141410.31315-1-alexghiti@rivosinc.com/

That unfortunately does not help with the hid-lenovo regression. Commit
84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd Fn
keys") added a platform_profile_cycle() call and thus a dependency on
platform_profile. hid-lenovo is used for USB and Bluetooth devices and
not just for Lenovo laptop/tablet specific devices.
Above patch just avoids the warning splat but still prevents loading
hid-lenovo when ACPI is enabled in the kernel (like Distro kernels) on
a non-ACPI system. This breaks devices like "Lenovo ThinkPad Compact
Keyboard with TrackPoint" on such systems.

I will send a patch to remove platform_profile_cycle() call as short
term regression fix and tell the original author to to resubmit once the
platform_profile dependency on non-ACPI systems is worked out.

Janne

