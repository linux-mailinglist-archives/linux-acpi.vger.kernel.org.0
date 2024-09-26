Return-Path: <linux-acpi+bounces-8439-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582479874F6
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E775283924
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D9762F7;
	Thu, 26 Sep 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ltdR0C40";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d41l0W2W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161B43AA9;
	Thu, 26 Sep 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359154; cv=none; b=PNYJN82Vp0B0xYZ4/59lfeWrULF5q/bGlTEAsPThdJ05rhwD2boI7qPeW+ZVDSC0d01J9OKM77ugCOIDxiczrW7oyWE8dtfdhfqq9jJqCcP7Lh5vO1crRqDxTKrQIUOjiAnkldAcWWn+JN71jjMCGxnAnvAg/BQWpZRRrG0b6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359154; c=relaxed/simple;
	bh=QEu5DqaOtx8qz8TFmnVAti29F7Qxc7meqVeCJk5ssG4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qw+IZXW8H2jiFxlM/KbFp7b3WbiwLq8giX7Hf6Y4bI7YDk4vvC+L4uPzi7GMwoFWizlmCqxIkAxLk6w6t9gPRVj2C4Oqk8YUshYTZOzNd9Imius9klDVNcpTwI9dADitCg3f3rUKIcV6jqxgA9kHXzncyPXMA/5bSLkFV81m21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ltdR0C40; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d41l0W2W; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BA39113802AA;
	Thu, 26 Sep 2024 09:59:10 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 09:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1727359150;
	 x=1727445550; bh=84+mwDfyDZSdx1IUW7exFBbe4aENBWcv2GSlmNEglTg=; b=
	ltdR0C40VZgznstqFxG25d4BINry7NifFCtbg6t0idTmCqFefcKN2nB9Co954LrQ
	hsqo/xWm/Pwq+4LYAlTkRvmiqrPC9zOWLu4ghZc88+bS4AAKlWOb9upi8e11AxAz
	F7qqiMindnsM9G4ZNzp8WvO/Xp92w3+XeybIJFWvEAteZJwcWccZfokPF85KerYz
	XOufQYEWySOicUIvaLuli0spo6cPqoxBka0JVEwKunMEQ1eAkgne0AwLb/WSVBym
	rCaSF/9lb7kyaBwEwZG5W96NYhFsMeOMf6AGnjTAv2yDsTWH5Yl7B3s69LTAv0Id
	Vl6ZobkYSbw33sCVOroYaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727359150; x=
	1727445550; bh=84+mwDfyDZSdx1IUW7exFBbe4aENBWcv2GSlmNEglTg=; b=d
	41l0W2Wu8rd/qcZBWiIAi+1eaIy32sxnz9XcDCL7GbmTktceiPxZv28LPmEhqUK6
	H4kRRhed8sHWLPUSGSaL6dI521OXw9GywXlhlY8K4GgO0Deo7zenfwQMlgUYxy2p
	SYsMVf0ONmhxvy37+oAM8VTxSHHnHLf8PP1EqYLCMdAZMx0aHvJ63AbHF2lFoaMn
	apMdAvOtQFanShBc8g7mvRRkW/ILAy8vvF7XYLr4l2mwYd67CZc0702SetFNIoHn
	yPhww/mtfktUo3dqkU5ZfNhtBai7Lxtq6NCVzYJR638Y4eDesM7P/YHKarwbP15c
	f2xZNe/zbgcbu/AncFxoA==
X-ME-Sender: <xms:rmj1ZhK6LH2pNCjqd7fE8SfKkl9ZpzlYolJG0t12BPS_ag1wqN13CA>
    <xme:rmj1ZtKBxedNPLI4oow0f4Gn0f72-ShnUQ3V0kzxxKP-4l5g-PEa4I2c8dw6YN46a
    F6asAydTUhhIJzReH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehlkhhmlhesrghnthhhvggrshdruggvvhdprhgtphhtthhopegsvghnrghtohdr
    uggvnhhishelieesghhmrghilhdrtghomhdprhgtphhtthhopeguvghrvghkjhhohhhnrd
    gtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsuhhpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmvgeskhihlhgvghhoshhpohgunhgvthhirdgthhdprhgtphhtthhopehilhhp
    ohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:rmj1ZptKs-LGt8Z4KtOM4MvK_ik1IUQ7820dsjsadN3YBTCIbquVVw>
    <xmx:rmj1ZiZyJRF-YUDjNAawbgMlUDr_-BAlCag0OaxZEvvTgJ_GVLWuPA>
    <xmx:rmj1ZoaCy1yWqoheFLjoAXl4g4_6vtM7cVmgL2VmAu1ZmNMnfA4eEQ>
    <xmx:rmj1ZmCTWWJTx9XMlMsWeHj2wJBUo4Kq68iKFIOMiAdX5PGqeptDqw>
    <xmx:rmj1Zoqbiqqt_kn0NJ_DQgS84eOIqrMAsCAtB-95DWNG6sjfYmYovxY6>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA5C63C0066; Thu, 26 Sep 2024 09:59:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 09:58:47 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Mario Limonciello" <superm1@kernel.org>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Antheas Kapenekakis" <lkml@antheas.dev>, me@kylegospodneti.ch,
 "Denis Benato" <benato.denis96@gmail.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
Message-Id: <2d07d31e-87f6-4576-977d-336f3d0bbc81@app.fastmail.com>
In-Reply-To: <20240926025955.1728766-1-superm1@kernel.org>
References: <20240926025955.1728766-1-superm1@kernel.org>
Subject: Re: [RFC 0/2] "custom" ACPI platform profile support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks Mario,

On Wed, Sep 25, 2024, at 10:59 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> There are two major ways to tune platform performance in Linux:
>  * ACPI platform profile
>  * Manually tuning APU performance
>
> Changing the ACPI platform profile is a "one stop shop" to change
> performance limits and fan curves all at the same time.
>
> On AMD systems the manual tuning methods typically involve changing
> values of settings such as fPPT, sPPT or SPL.
>
> The problem with changing these settings manually is that the definition
> of the ACPI platform profile if supported by the hardware is no longer
> accurate.  At best this can cause misrepresenting the state of the
> platform to userspace and at worst can cause the state machine into an
> invalid state.
>
> The existence and continued development of projects such as ryzenadj which
> manipulate debugging interfaces show there is a demand for manually tuning
> performance.
>
> Furthermore some systems (such as ASUS and Lenovo handhelds) offer an
> ACPI-WMI interface for changing these settings. If using anything outside
> that WMI interface the state will be wrong.  If using that WMI interface
> the platform profile will be wrong.
>
> This series introduces a "custom" ACPI platform profile and adds support
> for the AMD PMF driver to use it when a user has enabled manual
> adjustments.
>
> If agreeable a similar change should be made to asus-armoury and any other
> drivers that export the ability to change these settings but also a
> platform profile.
>

As someone who supports customers on Lenovo devices and hits the occasional situation where a user has made strange tweaks to different power related settings, and then complains about power or thermal issues - I love the idea that it can be made clear the system has been 'adjusted' in a non standard way. I can also see why users would want interfaces to do those changes.

Some suggestions:

I'm wondering if we can make it so a driver can register only a 'custom' profile as an extra profile handler?

The thinking here is the custom setting in this series is implemented for the amd sps driver, and therefore on a regular Lenovo laptop wouldn't be used, as the thinkpad_acpi driver will grab the profile slot, Users on Lenovo systems aren't going to be able to get at these extra tweaks (unless they unload thinkpad_acpi, which has other side effects).

If the sps driver can offer a custom mode, separately from thinkpad_acpi, then users can tweak settings to their hearts content but get back to regular mode when done.

I also think there needs to be a way that when you switch from custom back to a 'regular' profile that it would do a clean up of anything tweaked. e.g. when switching away from custom the ppd driver should call a 'custom mode cleanup' function, so things can be undone and returned to how they were when it was started.

Mark

