Return-Path: <linux-acpi+bounces-11646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48486A4A2D2
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1464D17263D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE541F874C;
	Fri, 28 Feb 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="i8P/t/rv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEYXbThM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E01C175A;
	Fri, 28 Feb 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771601; cv=none; b=mbXfZTrLLiJ4K1oWVa7qbyCMucLIq63nYFHLurOXTUGumYWdSM/HSR/JymdJp5NLFHfthuQmYH5ABzrB/be/WlddmoCyyLoNTnMdGq+XawgDUmb4jsSkOXc/pHIOQAEskYUY8cP0sRRK1w6o9qps1W7qnJ5lS5wi9UwBEosr7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771601; c=relaxed/simple;
	bh=UxdNkeBKO37OV1vMRv877Um2tsDhVAyHaSCUlJQDqxM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aQUR+rMEs5rU1Q1fvhUcAUAAQ7+KLk17BvXZGqs0KCjISFuT7ZhXuUb2i9Je3aqqN0Z43nTsbl8MtxZ6tHGV5nwEcp7z11ruAl3AldHap7vyYC9QT7Jhsw8RYvJKsAfRdbGk1BXHCScVAAXBPI1eZb7TBRIrATZcG5LNHpYq/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=i8P/t/rv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEYXbThM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4507911400F4;
	Fri, 28 Feb 2025 14:39:57 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Fri, 28 Feb 2025 14:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740771597;
	 x=1740857997; bh=ojNmDz2qig07cyhiEsyL/M34fSZvZTTLQtKaP/23R+0=; b=
	i8P/t/rvklNpUj/XTeypz3MuHpiTfPnVmsstEvWkyupoGftjkEsgrRZG3VOs6kT1
	PR4sVYeHTemj6BzXorhyuKcOlFDthQwJnmvts9jP/bWYtjo56wYYGu/dmvDMTW4e
	ImqiXntFKYMH3aGk3YVEjvWdAsbFZuy0GWsHQtU78VVzRZuf0E0Gnq/ub5CbY7Ad
	4u9wGXmYL6EdLeDHv4T8pp1cQwIxvr9e0UM75zOFbjcbEDyGKpfYrIdFEHR7oQii
	V3Gu7Gtp7jENUQN1OPZN3/KK5WcLrWRni78MjDcioG7/QZ8knkfWpZewcxx0kKAa
	+h0ERvbgMixdFFW7yb3qHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740771597; x=
	1740857997; bh=ojNmDz2qig07cyhiEsyL/M34fSZvZTTLQtKaP/23R+0=; b=U
	EYXbThMNz0IwVe7EyLiwkZJcPqQmI2MccmgMaSJOXQ7q8wS/9kPKFcVkta0vCX85
	Bbps/8ZUhFvSFyRA/OiLVDYJipsIdGRKl2uZg/8D1qealID2u9OUe7QOA0VLTIGI
	5qe8+zD5vw+KXcnClmoXN7LKnORPJ7w0XRb7OqItQ1G5HfAncf4aMAD+jatQFYt4
	lhK5G1Trqokrngq1evJRG6nvxnfPvt94tDRVjSKpIHayBHH2mH1HLf38aursNksH
	TVYiIwFAueh8yIw4Mnde+VB3Z8gson88Vese4FwLxR7GANUPBEGWIFtQhWsTNrdu
	B2y7sk7kOLW9JucUbDXJQ==
X-ME-Sender: <xms:DBHCZ2EisAtGCu7MIdLH9dclXwKJhmOch_rsy-InnAilFkU041aaRg>
    <xme:DBHCZ3XlQ1C1Dh6gqv9zMMfVaYe2NFgJR1AZZtvw3lFsTQck8KB2wDiC9JpH9AhHU
    eC6bQDIhHfaAjaZ7Vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeluddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnheptdffvefgtefhveet
    uddvfeelveektdduvdelgfehgfeikeffjeetjeevffektdfhnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprh
    gtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhhigrmhdq
    shhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimh
    honhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehlkhhmlhesrghnthhhvggr
    shdruggvvhdprhgtphhtthhopegsvghnrghtohdruggvnhhishelieesghhmrghilhdrtg
    homhdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuh
    hpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgeskhihlhgvghhoshhp
    ohgunhgvthhirdgthhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuh
    igrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:DBHCZwIpTCJYEwJloYgP-MFkx-vwO6ZfudXLSwwVU7ye4HHrC21ejw>
    <xmx:DBHCZwGuANY66dmeweAcMa2O3UCZto43ZtJPsY8xs3_kakMzbFS7aQ>
    <xmx:DBHCZ8XAzj1lj3W3BGVfXHR1ZXAPE_356QRAAiAibw4atX3np443Xg>
    <xmx:DBHCZzOuux62YJpmDtkFy5GQpcdKtBy_m3B68R1rCcrR-qK0HBdQug>
    <xmx:DRHCZ9WSvJLJopEeEuxEyAxUGkvjq_ubHYrqOOSKb8snRwGEO8lI-HUP>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA3D53C0065; Fri, 28 Feb 2025 14:39:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 14:39:35 -0500
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
Message-Id: <fcf58c76-2c0b-4892-96aa-c9b5b35c3e68@app.fastmail.com>
In-Reply-To: <20250228170155.2623386-1-superm1@kernel.org>
References: <20250228170155.2623386-1-superm1@kernel.org>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Mario,

On Fri, Feb 28, 2025, at 12:01 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When two drivers provide platform profile handlers but use different
> strings to mean (essentially) the same thing the legacy interface won't
> export them because it only shows profiles common to multiple drivers.
>
> This causes an unexpected behavior to people who have upgraded from an
> earlier kernel because if multiple drivers have bound platform profile
> handlers they might not be able to access profiles they were expecting.
>
> Introduce a concept of a "hidden choice" that drivers can register and
> the platform profile handler code will utilize when using the legacy
> interface.
>
> There have been some other attempts at solving this issue in other ways.
> This serves as an alternative to those attempts.
>
> Link: 
> https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
> Link: 
> https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Cc: "Luke D. Jones" <luke@ljones.dev>
>
> Mario Limonciello (3):
>   ACPI: platform_profile: Add support for hidden choices
>   platform/x86/amd: pmf: Add 'quiet' to hidden choices
>   platform/x86/amd: pmf: Add balanced-performance to hidden choices
>
>  drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
>  drivers/platform/x86/amd/pmf/sps.c | 11 ++++
>  include/linux/platform_profile.h   |  3 +
>  3 files changed, 87 insertions(+), 21 deletions(-)
>
> -- 
> 2.43.0

The patches are all good - but my question is do we really need the whole hidden implementation bit?

If the options are not hidden, and someone chooses quiet or balanced-performance for the amd-pmf driver - does it really matter that it's going to do the same as low-power or performance?

So, same feedback as I had for Antheas's patches. I understand why this is being proposed but for me it is making things unnecessarily complicated.

My personal vote remains that the amd_pmf driver carries the superset to keep everyone happy (sorry - it sucks to be the CPU vendor that has to play nice with everyone).

Mark

