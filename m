Return-Path: <linux-acpi+bounces-11434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3422A42E4E
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 21:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1420D189907C
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA2925485D;
	Mon, 24 Feb 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="KF1zgztu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbwUAOAp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552193B2A0;
	Mon, 24 Feb 2025 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430363; cv=none; b=sFDQiu548IDFWwTy6fqSCvc7CafhnzGyoj7g2MwYv4zW/01aUpRdO0PQZbt3doLUnC3RO1BCz4hNjQYl2WnaxEmYX4pTRfzNKQg2lYGtDsheKuE16G4ZZWcgl3lu71hKeUgn+HhJ9xW9NYk6hjWw30kGfcRvC21y7fZAVOipTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430363; c=relaxed/simple;
	bh=i2lSlrPBMuCRNw51I1wI0TjkpQ3iZ7HBx4oolxNaP4E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XuvhiolVyRABgRAGT8wih5nuNr7xdkgzrEt1RaK6XRFu+dmHtNYz0RC9/X1jtP2Re/Hp1TTn2BuyVuxbSlUyhpjhh7ygF4atbsJrCqE8xDfTx4bOR/9gUYudkhGPszCahoxqt3oJt2HLaeD57CyR+WKzvLu/dyCpzYhr/DlFzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=KF1zgztu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SbwUAOAp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C2A3114011B;
	Mon, 24 Feb 2025 15:52:39 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-04.internal (MEProxy); Mon, 24 Feb 2025 15:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740430358;
	 x=1740516758; bh=i2lSlrPBMuCRNw51I1wI0TjkpQ3iZ7HBx4oolxNaP4E=; b=
	KF1zgztuVJfQPMr5qsB9V+f8gFU7nB812dEm7IgO+/iG7w77kS7oEdJTiuvL2WdE
	SzYHmaRfKlFG/fy24Du7Bgn/rO/4f+D04P8Fs+8mkrqIgF8jtowqlY70P9KkSId3
	gn0gVDsLxAtUgxzC5OE88UW/p3Y+7x7muCmXPlmo4l7iJJTxdFHUi2RDyRs5x1BY
	5vj8qkiH5B1nRGERdEh0PC0Thj4YSLJ2qXJeBa8f9ew0sjyBI5rsR91jLx3wAxyK
	k+x8jvpc/tQd2bNTZK/SGBuY1NzWkPxyZZxh8eeudZpT7vRLBQCu2y6E4XViG9Hu
	i55zMQMqAEZS8nVlBEyg+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740430358; x=
	1740516758; bh=i2lSlrPBMuCRNw51I1wI0TjkpQ3iZ7HBx4oolxNaP4E=; b=S
	bwUAOAp9C0g9dRp9ScxzHZUBkmk9xdzpvaU7fzG3v6dhhp7jtPy51zqpkOnEPxsd
	iilSrfBuwpojzOobL6h3df2KdtHuW8ejLUpUQjTCqzj0xJk08PyXUEQed3eg9yq0
	qeFq1TXpffY+ld6Q/fWLfCxlJJ6KwvDedTDJY6aot2aZ3DtwL7i+9sH77gs1R+HH
	miIWLAS+KXl+WKcnK8BYUUtWvzpc4Q3JzDceoOv/6vE7oaln3YxpBauM50yYbNrG
	27AbMFxEAvU29Y+RMSkoHEpaPPnKBy/ulKkDZyJIrQeJxJgPZzsHW9dgbaPqpZ8L
	EpYZ36cC/5XUDD5pdRT9g==
X-ME-Sender: <xms:Fty8Z3EOuMRZdmp0kfHoNFu99MyMT25Nx4d363oIbiEK6ledJScDkA>
    <xme:Fty8Z0XIebV7aWozZ3Rsd5tRto7vRqHDc6I1ClPYZg8_y5z2hLfZDqDm6Lts2tXe-
    ZK3EjHI-51kMrKOkdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhm
    pdhrtghpthhtoheplhhkmhhlsegrnhhthhgvrghsrdguvghvpdhrtghpthhtoheplhgvnh
    gssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehkhihlvghgohhsphhoughnvghtihdrtghhpdhrtghpth
    htohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Fty8Z5KbxBs--EDSSYIHHQghE0tWHjlKnd2D4BQoODJRPXj5yS_5Eg>
    <xmx:Fty8Z1HV9sE_OhGTxLrDpku4DO_In6vpiCThzTtL2cEy64PnxrT6Rg>
    <xmx:Fty8Z9Vdr3qWODQxevL7aoemEYu3YxvKkTD_FGHjP476xA0rmORHWA>
    <xmx:Fty8ZwPuOoKluflvZdaEDdE1Uypz449qT1mRkOKwsFgOEVDJQsrIrg>
    <xmx:Fty8Z1TsH1Oira0Dw7Zud8iG8qJF5M2i2QqEoIowVt7CavmBssp-770O>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B7F23C0066; Mon, 24 Feb 2025 15:52:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Feb 2025 15:52:17 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Antheas Kapenekakis" <lkml@antheas.dev>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, me@kylegospodneti.ch
Message-Id: <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
In-Reply-To: <20250224195059.10185-1-lkml@antheas.dev>
References: <20250224195059.10185-1-lkml@antheas.dev>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with multiple
 handlers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Antheas,

On Mon, Feb 24, 2025, at 2:50 PM, Antheas Kapenekakis wrote:
> On the Asus Z13 (2025), a device that would need the amd-pmf quirk that
> was removed on the platform_profile refactor, we see the following output
> from the sysfs platform profile:
>
> $ cat /sys/firmware/acpi/platform_profile_choices
> balanced performance
>
> I.e., the quiet profile is missing. Which is a major regression in terms of
> power efficiency and affects both tuned, and ppd (it also affected my
> software but I fixed that on Saturday). This would affect any laptop that
> loads both amd-pmf and asus-wmi (around 15 models give or take?).
>
> The problem stems from the fact that asus-wmi uses quiet, and amd-pmf uses
> low-power. While it is not clear to me what the amd-pmf module is supposed
> to do here, and perhaps some autodetection should be done and make it bail,
> if we assume it should be kept, then there is a small refactor that is
> needed to maintain the existing ABI interface.
>
> This is the subject of this patch series.
>
> Essentially, we introduce the concept of a "secondary" handler. Secondary
> handlers work exactly the same, except for the fact they are able to
> receive all profile names through the sysfs interface. The expectation
> here would be that the handlers choose the closest appropriate profile
> they have, and this is what I did for the amd-pmf handler.
>
> In their own platform_profile namespace, these handlers still work normally
> and only accept the profiles from their probe functions, with -ENOSUP for
> the rest.
>
> In the absence of a primary handler, the options of all secondary handlers
> are unioned in the legacy sysfs, which prevents them from hiding each
> other's options.
>
> With this patch series applied, the sysfs interface will look like this:
>
> $ cat /sys/firmware/acpi/platform_profile_choices
> quiet balanced performance
>
> And writing quiet to it results in the profile being applied to both
> platform profile handlers.
>
> $ echo low-power > /sys/firmware/acpi/platform_profile
> bash: echo: write error: Operation not supported
> $ echo quiet > /sys/firmware/acpi/platform_profile
> $ cat /sys/class/platform-profile/platform-profile-*/{name,profile}
> asus-wmi
> amd-pmf
> quiet
> quiet
>
> Agreed ABI still works:
> $ echo quiet > /sys/class/platform-profile/platform-profile-0/profile
> $ echo quiet > /sys/class/platform-profile/platform-profile-1/profile
> bash: echo: write error: Operation not supported
> $ echo low-power > /sys/class/platform-profile/platform-profile-0/profile
> bash: echo: write error: Operation not supported
> $ echo low-power > /sys/class/platform-profile/platform-profile-1/profile
>

I understand where you're coming from with this implementation but my concern is this is making profiles more complicated - and they're already becoming hard to understand (and debug) for users.

I'm not a huge fan of multiple profile handlers, but can see why some people might want them and that they're a valid tool to have (especially given some of the limitations of what platform vendors themselves implement).

In patch #3 it states that 'It is the expectation that secondary handlers will pick the closest profile they have to what was sent'. I'm not convinced that is true, or desired.

e.g. Quiet and low-power are different things and can have different implementations. One is giving you as much power as possible with the fans running below a certain audible level; and one is giving you a system with as low-power consumption as possible, but still be usable. They're admittedly not very different in practice - but they can be different.

Would it be better here to ask AMD to implement a quiet profile (maybe it can be based on low-power, at least initially)?
I think that would solve the ASUS issue and not introduce another layer of complexity.

Mark

