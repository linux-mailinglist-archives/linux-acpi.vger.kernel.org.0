Return-Path: <linux-acpi+bounces-8493-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2080A98A0F9
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A251C25513
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5617DE1A;
	Mon, 30 Sep 2024 11:40:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3117C22F;
	Mon, 30 Sep 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696458; cv=none; b=XldLTZh61J1IdJ2BJMTm073ZXLLjvblQzd1XfK7il4xSwRFLRlann4ciYCXIgsy/NHhoDTi2uT56RAkrt3y0Ucz26z6KThXjmcUXITMptQQ2aNlGhUowmm9C/f/eHStIJsBX9IoO6rYrEsWMMoMal7ZKTOthtwajP079aSS6w3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696458; c=relaxed/simple;
	bh=6XZHWXaW/hXRMzoHx6Zs4cO/DJfHnTpx0fi3E6RSO9E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n8gIwiYrxpcX9Kf44lBu//H3k7krBX+AdPBrmE8A1LIoeb3wRADxwJykpw5vOdH616gD6vfuA7MF+q18rTWaMWCuIFLe8yG+YQgOKucMAa1wxV0jHG0JOwDGKFan3wdQsRNhvqtOD2C924OntgOHOhKVUWlDViwP1qu95nx7n/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C0E2992009C; Mon, 30 Sep 2024 13:40:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B251B92009B;
	Mon, 30 Sep 2024 12:40:47 +0100 (BST)
Date: Mon, 30 Sep 2024 12:40:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Pavel Machek <pavel@ucw.cz>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info, 
    ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bricked Thinkpad x220 with 6.12-rc0
In-Reply-To: <ZvpSD127BexmugnX@duo.ucw.cz>
Message-ID: <alpine.DEB.2.21.2409301232360.21893@angie.orcam.me.uk>
References: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz> <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com> <ZvXJjU7gpAchSqiy@amd.ucw.cz> <alpine.DEB.2.21.2409290048590.21893@angie.orcam.me.uk> <ZvpSD127BexmugnX@duo.ucw.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 30 Sep 2024, Pavel Machek wrote:

> > > No beep. And no beep when I tried booting with RAM removed.
> > 
> >  According to: 
> > <https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/x220_x220i_x220tablet_x220itablet_ug_en.pdf>
> > pulsating power-on LED indicates the sleep mode:
> > 
> > "The power switch stays lit whenever the computer is on, blinks when the 
> > computer is in sleep (standby) mode, and is off when the computer is
> > off."
> 
> So... I disconnected CMOS battery and now I have two different
> blinking patterns. I googled a bit, and it seems it is symptom of some
> PROM failing. So likely Linux had nothing to do with this, and sorry
> for the noise.

 One final thought: have you tried another PSU?  I've seen all kinds of 
weird behaviour with hardware due to issues with a PSU.

 To give you an odd example: an Ethernet switch failing to communicate 
despite the link established with exactly one other device and working 
correctly with everything else.  What would you blame?  The other device?  
No.  With its PSU replaced the switch started to communicate with said 
device too.

 If there are power regulators onboard the x220, it might be worth 
checking them too (as well as any associated electrolytic capacitors).

> I have X230 now. Suspend/resume works without bricking it with
> (different?) 6.12-rc0. I hate the keyboard, and X230 came with bad
> battery and won't charge X220's battery (bad Lenovo!!), so I got
> another X220. If this one dies with blinking LED, I'll certainly let
> the world know.

 Good luck!

  Maciej

