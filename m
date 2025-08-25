Return-Path: <linux-acpi+bounces-16014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A6B3442C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 16:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244A72A205D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342EF2FDC31;
	Mon, 25 Aug 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfNH551w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E72FE049;
	Mon, 25 Aug 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132068; cv=none; b=s+jEhQrcK5UqK/gigDQZNkCLWm5DyhgQ6y+H8uLGK02cva+ePhaQFxsL6fxJyWwHn4xk3Yk31Ht8zodSpCHurHO3RpiGn6S8WfCGvzK+6PAGNSWpaukKX7whC8cXRLoeyHqmtDUapkgGZPc4mrkwV+kfvlu0wqgty+zZMU/TAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132068; c=relaxed/simple;
	bh=ApS4gDzX8ZQaQ8AaSrrS8ONp7lmRrBdcwtLiHDw75r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR37qPs+2208vKxGMqC6jY2Jk/naSgE4ICP//cQ7jCuhp4PjrA20z2kgCL7gc3jQdJxATnphmFR56/TLO4O8sX8ZlCSdykXv/+F+clvjMAXn+NhWztO+Mq+cFQwE+EIdv7qTwceU2mke/DJGr3pgI0E+oa2RVAHKP8EOGhbWg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfNH551w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E63C4CEF4;
	Mon, 25 Aug 2025 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756132067;
	bh=ApS4gDzX8ZQaQ8AaSrrS8ONp7lmRrBdcwtLiHDw75r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GfNH551wfTBWzJ7Tb+DVoCiZNSBsceXV9k/VaP+xn/QRxbopZUI0A/We1cCB2eBYK
	 KgWmh5aKOW+gGcGnxf6lP3nWKGgw5LFlFqM53O0x4bTqPPlPmtKv1L6UlOSLVvDSrZ
	 C1m9gMs9RYz+EonbOd2u6qBxo1AMMfQoy5qfL0SdK9q1pquOpc8Kya3B+CnIFAD+po
	 fvOBFBLACCZiOut/AfCjrOXq4gntyQHApttB/LU5JMebTYey4Hcb+CE7U8Nr4kMNjf
	 WNKoD3zjgrY01zQVfLzzKPWlfcFVXiATsFYA+ks2QrsYx8ndIbXTPrFupx6mHN/3uX
	 853pKEyh/AcHA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-435de818a74so2582098b6e.2;
        Mon, 25 Aug 2025 07:27:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgLcnkbTgyHQpBqpnGwq8ptcJehGpKLujfs1C89k9iphAIPRzbt0haVJw6xsnh/+t245svCa9OfuEy@vger.kernel.org, AJvYcCWhON5Y38hZNJGnkmG3gbeVAAZzUHUUtUpudkFVfJxN5SFlmJ8AQ6PoLeHkmxVZTOe73vO4vYpGm6QmtfeO@vger.kernel.org
X-Gm-Message-State: AOJu0YyftzIQ/jAsZjyOJg30v0aAtLdMDXas/Xwbyfm9jntY8x/u9Syw
	yLcgkRJIv9t9gQJJNzKAE3F9oNeGhLIzN5HUW2XoBcWFAaFGhSMgTrga+2oljoWzKcjipPtys8H
	jmLhcRKGd99aUpGz3vDSCMMyvdaOJ4R8=
X-Google-Smtp-Source: AGHT+IEfbADSfLPLF8aW/ef/eVAG9EAIbckoOgXEoHNZQ+lyedT/ZZmze+Z7aldFTfdeDSpsh196TTWDrv/F7sgHe18=
X-Received: by 2002:a05:6808:15a9:b0:435:bb78:e304 with SMTP id
 5614622812f47-43785248e4bmr5227278b6e.32.1756132066577; Mon, 25 Aug 2025
 07:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754243159.git.mail@maciej.szmigiero.name>
In-Reply-To: <cover.1754243159.git.mail@maciej.szmigiero.name>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 16:27:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifhK_Or1h20taM79qLXBHhe3BNObDHg3K56SRnG250Gw@mail.gmail.com>
X-Gm-Features: Ac12FXypDQda601Y44Rps_hoWC632jcEgcPvrKWT__hGDnrP2BMLxIGup1UHvWU
Message-ID: <CAJZ5v0ifhK_Or1h20taM79qLXBHhe3BNObDHg3K56SRnG250Gw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] HP EliteBook 855 G7 WWAN modem power resource quirk
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 9:18=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> This laptop (and possibly similar models too) has power resource called
> "GP12.PXP_" for its Intel XMM7360 WWAN modem.
>
> For this power resource to turn ON power for the modem it needs certain
> internal flag called "ONEN" to be set:
> Method (_ON, 0, NotSerialized) // _ON_: Power On
> {
>         If (^^^LPCB.EC0.ECRG)
>         {
>                 If ((ONEN =3D=3D Zero))
>                 {
>                         Return (Zero)
>                 }
> (..)
>         }
> }
>
> This flag only gets set from this power resource "_OFF" method, while the
> actual modem power gets turned off during suspend by "GP12.PTS" method
> called from the global "_PTS" (Prepare To Sleep) method.
>
> In fact, this power resource "_OFF" method implementation just sets the
> aforementioned flag:
> Method (_OFF, 0, NotSerialized) // _OFF: Power Off
> {
>         OFEN =3D Zero
>         ONEN =3D One
> }
>
> Upon hibernation finish we try to set this power resource back ON since i=
ts
> "_STA" method returns 0 and the resource is still considered in use as it
> is declared as required for D0 for both the modem ACPI device (GP12.PWAN)
> and its parent PCIe port ACPI device (GP12).
> But the "_ON" method won't do anything since that "ONEN" flag is not set.
>
> Overall, this means the modem is dead after hibernation finish until the
> laptop is rebooted since the modem power has been cut by "_PTS" and its P=
CI
> configuration was lost and not able to be restored.
>
> The easiest way to workaround this issue is to call this power resource
> "_OFF" method before calling the "_ON" method to make sure the "ONEN"
> flag gets properly set.
>
> This makes the modem alive once again after hibernation finish - with
> properly restored PCI configuration space.
>
> Since this platform does *not* support S3 the fact that
> acpi_resume_power_resources() is also called during resume from S3 is
> not a problem there.
>
> Do the DMI based quirk matching and quirk flag initialization just
> once - in acpi_power_resources_init() function similar to existing
> acpi_*_init() functions.
>
> This way the whole resume path overhead of this change on other systems
> amounts to simple hp_eb_gp12pxp_quirk flag comparison.
>
> Opportunistically convert the single already existing DMI match-based
> quirk in this ACPI power resource handler ("leave unused power
> resources on" quirk) to the same one-time initialization in
> acpi_power_resources_init() function instead of re-running that DMI
> match each time acpi_turn_off_unused_power_resources() gets called.
>
>
> This Intel WWAN modem in general has *a lot* of issues with
> suspend/resume on various laptop platforms (not only HP).
>
> More patches are needed for these, hopefully they can be mainlined
> too so suspend/resume work out of the box for users (that's
> important functionality on a laptop).
>
> See the following ModemManager issue containing patches also for
> Thinkpad T14 G1 and Dell Precision 3561:
> https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/issues/992
>
>
> Changes from v2:
> * Split out the change adding power resource init function and converting
>   existing DMI-based quirk into a separate preparatory patch.
>
> * Create a replacement __acpi_power_on() method for the affected power
>   resource (including the power OFF and delay part) and call it from
>   acpi_resume_power_resources() instead of ordinary __acpi_power_on()
>   on the affected platform.
>
> * Rename leave_unused_power_resources_on_quirk into suggested shorter
>   unused_power_resources_quirk.
>
>
> Maciej S. Szmigiero (2):
>   ACPI: PM: Add power resource init function
>   ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power resource quirk
>
>  drivers/acpi/internal.h |  1 +
>  drivers/acpi/power.c    | 90 +++++++++++++++++++++++++++++++++++++++--
>  drivers/acpi/scan.c     |  1 +
>  3 files changed, 89 insertions(+), 3 deletions(-)

Both patches applied as 6.18 material with some minor edits in the
changelog of the second patch.

Thanks!

