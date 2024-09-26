Return-Path: <linux-acpi+bounces-8445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9CE9879B3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 21:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F147281118
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBBF175D2C;
	Thu, 26 Sep 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="iaSpfOlv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C2522A;
	Thu, 26 Sep 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379696; cv=none; b=qeb/J8DH4gP5DKdBQRu7MUstC4wu5yB+lAEJbEwQhfyJg6nlIV8o0gfVEtmOwDL5t1EmQv9aKFJIuANbAe8njViFcyB5mD28TcRmcG925vst6cKmObCoHBRMHOlcE4ju1uIWnKnMu4j/EMWFNmHrdqk2o1TujMWGwDnH/1pPoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379696; c=relaxed/simple;
	bh=VNcnHSI7FM+BtMXNej3KurhjVWYVotK8INRGf6D/xP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0mJpNDbdx+tfW1z+BqXa63T0v/1wAnR4Ny5wQe7jDeVe+UprSRm8r8LvrNDvyKe0qblq5mUerYjiztQAwN53dTyWoo2OF+/vZnp+/MJ3vcJgPmnIGNaVQM57KCYqlU9JPjO3464lhWYzYRoGvQ2GcwiCrGB+6BZyEeyOuwsolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=iaSpfOlv; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id B35852E09B10;
	Thu, 26 Sep 2024 22:41:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727379690;
	bh=ICC/6aiJ2busU2zThORGo4pOzWfpSkXMkwWmE5bK+oM=;
	h=Received:From:Subject:To;
	b=iaSpfOlvQZr6/8CqVUV/2d6gnHHXVtlq59aOFar7bsmmFpefdrHSLX2tLJxk0tjcd
	 4PkVG7mfL3Syv228cRswo3o4tiZfE2U5baLR6dPupvH8JWiZKFzR3SnjyBvxJ32f22
	 5NzeGGjtpEITyycRV6fmgx4qoaEGV9Gu7Mf1Mrbk=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-2f762de00e5so14800361fa.3;
        Thu, 26 Sep 2024 12:41:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUBFhfDrGFqFlg2yvhvynPjc2rewtaZXWmdYhyHOTPDlrQxzpinLm6JS5mfE2b/QhyydcVAzu1eFJvX@vger.kernel.org,
 AJvYcCXMn5Nf4CJaw7577Yt+c873aX/jLvq/S0MFafJ6Ve3hZpDvW8MmUt4n7ve2kpS1MkAl4dT7aXjZHDfAXbNp@vger.kernel.org,
 AJvYcCXpHAAc8N4YXL5e7eV6DKMAJIRnCrgjYojKU1SwZBLKWLff9xWc0H/HAvdVfkSnBUiazrD6uz9aVfc1+8zQ5ryeI/ODRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwhSM5s5tm6wp0lu1GRoZHHW71e0nMrtoCcQhZlHyIuAlerZY
	FCZfcbZsLlhifnAakgsupP8bmfwpOX5VUQkjaVrM584xh9HOmLPz3cwZAL3GPTWAPgwNqBRnR4+
	GQR2TPSCkOHvyKl6NR491YlC0c34=
X-Google-Smtp-Source: 
 AGHT+IG5HA7+aYtyorVW7IZ1zx+clU+uCV6jFRnTzbxIT3FjgsgELhDDlI7z6Hrje+s0qosjbhjjzt3+6XgooIoVm0w=
X-Received: by 2002:a05:651c:b0f:b0:2ec:1810:e50a with SMTP id
 38308e7fff4ca-2f9d417a581mr5532621fa.32.1727379688569; Thu, 26 Sep 2024
 12:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org>
 <2d07d31e-87f6-4576-977d-336f3d0bbc81@app.fastmail.com>
 <7bfba4ef-0f42-4482-874f-77a4434eb338@kernel.org>
 <5dcc2f87-e8c0-4f33-9b75-054eb0acb81a@app.fastmail.com>
In-Reply-To: <5dcc2f87-e8c0-4f33-9b75-054eb0acb81a@app.fastmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Sep 2024 21:41:17 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFMXAPfPrUaVaNFch565Oh49m=ZWewx9K6603GPpO0Z4A@mail.gmail.com>
Message-ID: 
 <CAGwozwFMXAPfPrUaVaNFch565Oh49m=ZWewx9K6603GPpO0Z4A@mail.gmail.com>
Subject: Re: [RFC 0/2] "custom" ACPI platform profile support
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Mario Limonciello <superm1@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: <172737969008.545.2913244291928671667@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> >> Some suggestions:
> >>
> >> I'm wondering if we can make it so a driver can register only a 'custo=
m' profile as an extra profile handler?
> >>
> >> The thinking here is the custom setting in this series is implemented =
for the amd sps driver, and therefore on a regular Lenovo laptop wouldn't b=
e used, as the thinkpad_acpi driver will grab the profile slot, Users on Le=
novo systems aren't going to be able to get at these extra tweaks (unless t=
hey unload thinkpad_acpi, which has other side effects).
> >
> > Well the RFC was just to show it for the AMD PMF driver, but I think
> > that thinkpad_acpi, asus_armoury etc could all potentially implement th=
e
> > 'custom' bit too if they offer an ACPI-WMI interface to similar setting=
s.
> >
> >>
> >> If the sps driver can offer a custom mode, separately from thinkpad_ac=
pi, then users can tweak settings to their hearts content but get back to r=
egular mode when done.

I think I considered that as part of my userspace software and reached
the conclusion that if there is an EC, for most users it is best to
program it and forgo the extra features. Otherwise they get weird bugs
and conflicts, such as incorrect fan curves or their settings being
reset randomly.

On the Legion and Thinkpad series, the hardware binds would also cause
this (Fn + BMH)/(Legion Go L + Y), and for Legion series specifically,
the power button will have the wrong color.

So I do not know if it is worth exploring as having it controllable
from userspace in such a clean way. Of course, tinkerers could mess
around by disabling modules to try something out and that would work
fine, but I do not think it will be usable day to day.

I personally gave up on the idea. However, having a load order and
falling back to amd-pmf does have merit. E.g., the legion go will need
a quirk for pmf too, and probably most laptop lines going forward. So
that should be explored.

> >>
> >> I also think there needs to be a way that when you switch from custom =
back to a 'regular' profile that it would do a clean up of anything tweaked=
. e.g. when switching away from custom the ppd driver should call a 'custom=
 mode cleanup' function, so things can be undone and returned to how they w=
ere when it was started.
> >>
> >> Mark
> >
> > I guess what you're proposing is that multiple drivers register as
> > profile handlers and they might not all export the same features.
> >
> > If we did something like this we could instead have the core call
> > callbacks for all platform profile handlers.  We could also drop a pile
> > of quirks from amd-pmf where there are some ASUS systems that advertise
> > SPS in in the PMF framework and also asus-wmi provides it.
> >
> > If I'm following you right, I generally like this idea.
>
> Yep - that was the idea.
>
> This feels like a step towards giving more control to power users - whils=
t keeping the basic simple for regular folk.
>
> I can imagine utilities that would use this to enable specific configurat=
ions, via the custom profile mode, for many different scenario's; whilst st=
ill allowing a user to get back to the tested and vendor approved setting i=
f things go badly.

I will note that for handhelds, having a TDP slider is basic
functionality. So we need to find a way to give this control to users
without tainting the kernel or requiring special workarounds in the
case the manufacturer did not provide a WMI interface. This PR is a
step in that direction, but then we need to deal with hardware limits
and such to make sure it is safe.

As far as fPPT and sPPt go, I will be honest and say I never had a
user ask for them. However, unless the driver implements a LUT or some
basic logic to enable/disable some sort of boost, they will need to be
exposed to sysfs so userspace can do it. It does not mean that
userspace will need to show that to users, just that it will do the
interpolation to apply the correct boost if that is requested.

Here I will note Legion Space did not do that on the Legion Go on
WIndows for the first 5-6 months of its release. This lead to custom
mode being completely broken from a user's perspective. Since the
device is STT, if the user set the spl to 10W, well sPPT was 32W and
fPPT was 43W so the device just kept boosting forever.

However, one of the first BIOS versions added sPPT and fPPT to WMI, so
we never had that problem in Linux.

Now, Legion Space added sPPT and fPPT as sliders, which just causes
annoyance for users, as they have to edit 3 sliders instead of one to
get their desired performance level.

To that end, both Asus and Lenovo offer sPPT and fPPT adjustment, so
there is no risk with exposing that to userspace in Linux
specifically. As long as the limits are bounded.

Antheas

