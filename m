Return-Path: <linux-acpi+bounces-19382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8EC9BEB9
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D383A5FF7
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17670257AD1;
	Tue,  2 Dec 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kVnKlO5V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF69234984
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688673; cv=none; b=uqJY2z/62Smo7dTSk3AqiS2qF1ikL0jQWLBIISx3GfvkJzpXhO5IHL0502xXmlul/6/RYv+JofCV6r6G8w/YFkDXowRd5sMdlgOjulCpRFwETaPOMgBpK0CSSEYQMX4gXzSZ6fLJwtQa45ly6img610nUR7miKHsvM0+4IiOVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688673; c=relaxed/simple;
	bh=7hBsxn2ur7mVuSly3KfnALr6KQuw+iihnqYxGHlW9wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0HuODy3isrvteWKGLI6lEhWzsF5mKS3nOCsI2XUVAhUC/LxYLFoCfRtJj0SlT4gW+wiCaGLqgAWh7hoGE5busRep3J+txW2+3VyrpWKJFbjVuU0c6L9ccvY1LG9dG+9sN41WcAD9w21o07kWgIB3oEbwCqWN20jdEn/ioNZTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kVnKlO5V; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 77D92BDA3B
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 17:17:46 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 99BE9BDA1E
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 17:17:44 +0200 (EET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id DEA7E201E23
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 17:17:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1764688664;
	bh=TaZdZUjsSOQ3gQbbZosy57SDfc7edw1o7Sq90lPtysI=;
	h=Received:From:Subject:To;
	b=kVnKlO5VonEUx3z7aT3O+5Ygjp1Mzrj8dz+1ekDTQnpd7dwmCFxOyAUH2599bm8h3
	 NjieMbEgkJ0bBO23f5hZ0NF70lRStKgsIaEHQeqJ0ktMHbFrJb964HXpW+fxG8hS/r
	 0SF6CNnhDJSGNi2w/EUOt7LeogPeJbPiC2gT9//UI76XITEgfk7nyORSMV1MS6NVx4
	 mTu5k7M8AYi59PXMy+DyoOt/SoJa74ucZFmgChBeGxGylPnMYrTcpPb+pi9//wINAY
	 TIg12EqF0rc5zdQtVZXWYNxIMjURXYBlKWQAUMdq2HvZhvEScIgtrHJVxXj1ciPyh2
	 S/G+mP4UWdwkw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-37b935df7bfso52209031fa.2
        for <linux-acpi@vger.kernel.org>;
 Tue, 02 Dec 2025 07:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWsV4iubNkA5nWnjlBSEIu36hd70kqtG4MT7rlA0JHA+GThFaASzH2HCh2kB3MQX3ye4eto9CoEcCkc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Hq0rEd3mF828bkzZe74TO9RMIVFWjyisKrjdeDZylsHN8i76
	fIjlWHnmy1cDnVn4tWtC4sp0dUnNr+ntGyH3vLeJqMrM8W4NmStOp10q4qoiWWGdOpPlTTQ8c/D
	NIP4Wal+lgx9jix7T/lvmALYWIXIlutk=
X-Google-Smtp-Source: 
 AGHT+IFX4g58cRvG3CG81Ccd8lpuxRbtBp1sEDvohRlMhWoVsNh6Mj16S4kytxb8/fPTP6oGegK8P6JB6guoVvYLJyw=
X-Received: by 2002:a05:651c:3247:20b0:37a:9558:5bda with SMTP id
 38308e7fff4ca-37cd91b6887mr93086321fa.14.1764688663112; Tue, 02 Dec 2025
 07:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
 <c7760b2d-c8cb-40fa-b1b1-8715e97e5cf0@kernel.org>
In-Reply-To: <c7760b2d-c8cb-40fa-b1b1-8715e97e5cf0@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 2 Dec 2025 16:17:31 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHi_U_R3ueJaYDaR_Pa6JntNbEh1dpwwbZW7jtrs5mbQw@mail.gmail.com>
X-Gm-Features: AWmQ_bkaTQ4UifoREbOeySvK5aF4HRdi9RhdDVuugCwISsSA2JH6zWSMkLm8r30
Message-ID: 
 <CAGwozwHi_U_R3ueJaYDaR_Pa6JntNbEh1dpwwbZW7jtrs5mbQw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Mario Limonciello <superm1@kernel.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org,
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176468866417.1664181.11372773656925504987@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 2 Dec 2025 at 15:30, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 12/2/25 3:32 AM, Antheas Kapenekakis wrote:
> > On Tue, 2 Dec 2025 at 05:36, Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> Add `/sys/power/lps0_screen_off` interface to allow userspace to control
> >> Display OFF/ON DSM notifications at runtime. Writing "1" to this file
> >> triggers the OFF notification, and "0" triggers the ON notification.
> >>
> >> Userspace should write "1" after turning off all physical and remote
> >> displays. It should write "0" before turning on any of displays.
> >>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >>   Documentation/ABI/testing/sysfs-power |  13 +++
> >>   drivers/acpi/x86/s2idle.c             | 149 +++++++++++++++++++++++---
> >>   2 files changed, 145 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> >> index d38da077905a..af7c81ae517c 100644
> >> --- a/Documentation/ABI/testing/sysfs-power
> >> +++ b/Documentation/ABI/testing/sysfs-power
> >> @@ -470,3 +470,16 @@ Description:
> >>
> >>                   Minimum value: 1
> >>                   Default value: 3
> >> +
> >> +What:          /sys/power/lps0_screen_off
> >
> > Hi,
> > thanks for having a second stab at this. My initial series for this
> > was kind of complicated, I would need to rewrite it anyway [1].
> >
> > I will second Mario on the integer values. The main.c file provides
> > the capabilities used in other power sysfs values and an ABI for doing
> > string options.
> >
> > For me, I have a bit of a problem with the ABI. I kind of prefer the
> > one in [1]. There are three sleep states in Modern Standby: Screen
> > Off, Sleep, and LPS0/DRIPS (and a fake resume one I added). The only
> > one the kernel is suspended in is LPS0.
> >
> > So the ABI should ideally be able to cover all three, even if at first
> > you only do screen off. This means the name kind of becomes a problem.
> > lps0_screen_off implies lps0 (is not the state, is also an ACPI x86
> > specific term) and is limited to screen_off (cannot add sleep).
> >
> > I used /sys/power/standby in my series, which I think was fine because
> > you'd be able to add hooks to it for general drivers in the future.
> > This way, it would not be limited to ACPI devices and the name implies
> > that.
>
> Why would you want to expose all those states to userspace?  I feel like
> it is going to be risky to have userspace changing the state machine for
> suspend like that.

The reasoning is that if userspace is to be made able to run while the
device is in those states it should be able to command the device to
enter them. Right now the sleep _DSMs are tucked above the LPS0 call
after userspace is frozen. Specifically for the sleep _DSM I am not
suggesting that all software should be able to run after it is called.
But this limitation responsibility is placed on the init system
currently for the Linux desktop (android has wakelocks).

In the case of systemd, this would be potentially two-tier freezer
groups. The first freezer group for userspace apps is implemented
already to improve hibernation behavior. A second freezer group could
be introduced for crucial lightweight services that are able to run
and hold locks under this sleep state. In addition,
suspend-then-hibernate/spurious wakeup checks* can also run in this
sleep state, to avoid powering on the power LED of a device/fan for
certain manufacturers when checks happen.

*non-existent currently-but newer Modern Standby devices like to wake
up randomly due to e.g. charge state change

> Since the _DSM call that is interesting here is focusing specifically on
> screen off I have a slightly different proposal on how this could work.

Both Sleep and Screen Off DSM are interesting but let's focus on
Screen Off for now.

> What about if instead of an explicit userspace calling interface it's an
> inhibition/voting interface:
>
> While in screen on:
> * By default no inhibitions are set.
> * If no inhibitions are set and all physical displays go into DPMS then
> DRM can do an call (using an exported symbol) to enter screen off.
> * If userspace is using a remote display it could set an inhibition.
> * When the inhibition is cleared (IE userspace indicates that a remote
> display is no longer in use) then:
>    * if all physical displays are already off call screen off.
>    * if at least one physical display is on do nothing (turning off
> physical displays would call screen off)
>
> While in screen off
> * When a physical display is turned DRM would use exported symbol to
> call screen on.
>   * When  an inhibitor is added call screen ON.

I think we have discussed some of the limitations of this approach in
a previous thread.

Userspace software that renders external displays would not have
rootful access to this API, it would use a dbus lock implemented by
systemd, in which case there is no need for a kernel side api

Exporting these symbols to DRM would cause potential timing issues if
a CRTC is turned on and off rapidly. The calls in Windows are
debounced, specifically to after 5 seconds the screen turns off due to
inactivity.

An inhibitor process in logind can handle this gracefully very simply.
Involving the DRM subsystem just adds a lot of complexity and it is
not clear what the benefit would be. There are no known devices that
hook DRM components into that DSM.

> By doing it this way userspace still has control, but it's not
> *mandatory* for userspace to be changed.

On that note, the screen off calls/userspace implementations are
optional under both patch series. If userspace is not aware of them,
they are still called by the kernel when suspending.

Current userland also duplicates the functionality of the screen off
call, which is primarily turning off the keyboard backlight. So along
implementing this call, userspace software like powerdevil/upower
needs to be tweaked to avoid doing that if the screen off state is
available.

Both need to happen concurrently in order for there to be a user
benefit. If we try to implement it on the kernel side with a DRM hook,
we would just cause an inconsistency with userspace keyboard
brightness control.

You should try this series or mine in [1] on any Modern Standby Device
such as any Thinkpad newer than e.g. 2020 to see how it works. Screen
off controls the kbd backlight and sleep controls the power button
light (Asus/OneXPlayer still use the AMD LPS0 for that; Certain Lenovo
products such as the Go S use the screen off state for it)

Antheas


