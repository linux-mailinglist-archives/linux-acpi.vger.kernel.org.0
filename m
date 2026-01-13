Return-Path: <linux-acpi+bounces-20227-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73976D17E3C
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 11:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF40301E6D5
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63F38A2B5;
	Tue, 13 Jan 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="fvPwFD+i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D13876C4
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299119; cv=none; b=dLDe54MPXe19pT8yCzVKl2HB+V3JgbxAiXBi/Knu0kLRmsseaXuE5g4D+9YRkI191S0ZOdIkxSH+u9x6BgR8X3jBnFR3xLnspEfxt1KE/tluYV7uRWxylezlq2CpdoxQjFri0VxO2AFMvytY/lSImQ96TwBYYSVEYciALkrnKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299119; c=relaxed/simple;
	bh=eq1RoM0ytpH+JijQ0jwf6pxBAclzx6l0bDTF01ZBCWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV+5eK97O+kFZLVGeiNXSG2imiX/uXx4C156Q2yuyMbeF9fGNQ1AiOKC6tDdowT5LvXB0+0ioBt8g3VcicsmL+uTK4Ps/sCXiMffb9HyBaZuBBpMU9w3akVU7Z4XuNKKUuOU/wshooPCid4KiHEcrMIpEJDYRwA/+5v/mOUjriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=fvPwFD+i; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 4DD0DBC287
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 12:11:48 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 5655BBC266
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 12:11:47 +0200 (EET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2B6D2202475
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 12:11:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1768299106;
	bh=eq1RoM0ytpH+JijQ0jwf6pxBAclzx6l0bDTF01ZBCWc=;
	h=Received:From:Subject:To;
	b=fvPwFD+iu8H0cBizhxABvI3gG95Xbc14XIPmyUbMks4/vBCJkyfjkiQUUCotlriuc
	 JhYqghECeYRMDpqdinuWYtP1I2bCSY1LFGa2n3UW5pv6+jUKq4sbx2YfztJuvWUfDG
	 rNQk5DjOJObkoeUBOcguwxIRDJpWRS2eKCmqTzQbCnMCRZaEd1Fpvo/17CWhuflr0k
	 1HtbaAUWqd2nbQTiWmC95pje6NRsSvFH1IyKwRiQsE6+VYOojEvTUUskCzpoMC+a6I
	 d1N6wE34/l4ZdwP7ay+aNQFcBsXZlu4kkmPgQgMBqFzoUGnWx6FYs3dU3EX1OJb2Ni
	 30Omw/NfLPtVg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-382fceabddfso51448431fa.1
        for <linux-acpi@vger.kernel.org>;
 Tue, 13 Jan 2026 02:11:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWHV/ttDHi+E2lXGBn8pm9KL3N9xhpHrrDTH38n0h23XdKZ/8Zv+SVye4+N1wxzzuRTb11aLIko/N+Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4icRcHjEG8n1rZI/Q6QFoF5cbjfUccIi3ipGZ9jVryAtElOAk
	Sd2NM+zzyNOQfUva8lmAbScexwAehj8dfY12im7XqjlKeqarTHRaBqpWiV2d8zoELQbKOBzIX6+
	1aAS8/LJuHNEYOkBteHCnT78vDaplBh0=
X-Google-Smtp-Source: 
 AGHT+IE55BtDJDkfvTRfOj4h1VZhFQpkIrBLnp9HwtXnVPRPaAjXEG2cN6nnGl5AQIwU+ouKdcHibZy+odfc5MLb/Hc=
X-Received: by 2002:a05:651c:198d:b0:383:1ec5:9634 with SMTP id
 38308e7fff4ca-3831ec5ab2cmr36322301fa.16.1768299105363; Tue, 13 Jan 2026
 02:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
 <3ca00958-13e5-4732-b500-aa9673a4c965@collabora.com>
In-Reply-To: <3ca00958-13e5-4732-b500-aa9673a4c965@collabora.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 13 Jan 2026 12:11:33 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHLkL5xAXzaKoTyLCGzNjjHUf+bNu8qo+-Tpex7NK6=GA@mail.gmail.com>
X-Gm-Features: AZwV_Qh8TfjaoL_PsLUMWHNjGzrmold_ZjPaOMrfP_8NZfvtY4-dR2wM-vo161s
Message-ID: 
 <CAGwozwHLkL5xAXzaKoTyLCGzNjjHUf+bNu8qo+-Tpex7NK6=GA@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
	superm1@kernel.org, systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176829910659.1567712.14657745351880940436@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 13 Jan 2026 at 11:50, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hello,
>
> On 1/12/26 23:33, Antheas Kapenekakis wrote:
> > On Fri, 26 Dec 2025 at 12:27, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >>
> >> This series introduces a new runtime standby ABI to allow firing Modern
> >> Standby firmware notifications that modify hardware appearance from userspace
> >> without suspending the kernel. This allows userspace to set the inactivity
> >> state of the device so that it looks like it is asleep (e.g., flashing the
> >> power button) while still being able to perform basic computations.
> >>
> >> snip
> >>
> >> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> >> --
> >> 2.52.0
> >>
> >
> > Happy new year everyone
> >
> > Small bump on this as all of us are starting to get back from holidays
> >
> > I still have to bump an asus series before I get back to this. I would
> > appreciate some feedback in the interim.
> >
> > I think targeting 6.20/7.0? is unrealistic so there is no rush from my side
> >
> > Antheas
>
> Thanks a lot for sending these patches! I briefly looked through them
> last week and will make another iteration soon.

Hi Dmitry,
can you expand a bit on your use-case/KPIs/timeline for your series?

Is it handhelds/laptops or what is the intended use-case?

[2] before the rewrite had been tested on most handheld makes and SKUs
(over 70 models) and laptop manufacturers and it performs as expected.
As it is multiple months of research I'd like to get some credit for it.

Happy to collaborate in any case, especially if you will log hours on
this and can push a variant through faster. I am not sure if starting
from scratch is worthwhile for either of us

Best,
Antheas


> --
> Best regards,
> Dmitry
>


