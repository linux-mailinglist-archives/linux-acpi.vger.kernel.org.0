Return-Path: <linux-acpi+bounces-8480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17528989223
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FBA281130
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F333F6;
	Sun, 29 Sep 2024 00:30:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67149538A;
	Sun, 29 Sep 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727569852; cv=none; b=EbRWX4b9KFTFzauR7rTG1GyOlGqFRTZy52P4JQFOMKfQggifJqlJOYA7sWDHab1oYzOSXTCe+tOuolvmZeSeRNVHyfXbv1WrV+FVjEMBIzmjucvU5JsTyTsOvfHA1ZeWDiEHfB1UranjqlB4NDScIYlPi4fhVVURmeEFZhAW3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727569852; c=relaxed/simple;
	bh=wkC0ylvHkYKBubt20kyRIlUGtXWDFhbHoS4BMq2qwA0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DEKaeeahvFU37Kt22Pwf5z3EdXO71lvmAPnvM14H/qppWyASQKfe6AQKC98gxbpk+7AEQfIGR88yYJOpOtXadLjp6Ez6vsQDcVLOZhN1kqQ9OHx1sJElh8ptFYNBwQClsLxUvYqLpZy29Yus6gRm9zWn3Ha5emK3hZTI2FeysDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0E8B292009C; Sun, 29 Sep 2024 02:30:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0AFD492009B;
	Sun, 29 Sep 2024 01:30:42 +0100 (BST)
Date: Sun, 29 Sep 2024 01:30:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Pavel Machek <pavel@ucw.cz>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info, 
    ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bricked Thinkpad x220 with 6.12-rc0
In-Reply-To: <ZvXJjU7gpAchSqiy@amd.ucw.cz>
Message-ID: <alpine.DEB.2.21.2409290048590.21893@angie.orcam.me.uk>
References: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz> <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com> <ZvXJjU7gpAchSqiy@amd.ucw.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 26 Sep 2024, Pavel Machek wrote:

> > > When I press power button, it starts producing some noise (hdd
> > > spinning up), but power light goes pulsating, not on, and I stare at
> > > black screen.
> > 
> > No beep?
> 
> No beep. And no beep when I tried booting with RAM removed.

 According to: 
<https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/x220_x220i_x220tablet_x220itablet_ug_en.pdf>
pulsating power-on LED indicates the sleep mode:

"The power switch stays lit whenever the computer is on, blinks when the 
computer is in sleep (standby) mode, and is off when the computer is off."

I guess the system has become confused somehow.  In the old days pressing 
and holding <Insert> while powering a PC up would clear any leftover NVRAM 
(ESCD BIOS) state (I earned a dinner once this way).  I guess this trick 
no longer works nowadays?

 I presume you've studied the linked document for any hints?

 NB I do believe disconnecting all the power sources is enough for the EC 
to get completely reset.  It's also what said document suggests to try if 
you can't bring a system out of sleep (standby).

  Maciej

