Return-Path: <linux-acpi+bounces-19446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7FDCA862E
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B2193004510
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10BD340D84;
	Fri,  5 Dec 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9HohqIM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF23112BE
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952352; cv=none; b=WAzWPLKDkLDoeWLR8Z0xCyGIOB/9jSNBieO4T89j7rBm8CbZfTbCmSLISVvNlAJwS3cs3NMsg6gHV9GFu55hptWC85WzJ8Ay5FWsH4K/LT3Fjs1DvpeOlsYqEn2OmIuVIQYLQSRzD7/l5BIPKrmx7hiCuRwcTBd+i3v3oHxR2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952352; c=relaxed/simple;
	bh=qz5kxhzVa4r3joxN4Vdcq8+3q2U8yYYZGyZdZ7MJb94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aok2N8Ss1Mn8zB8Nu3stg85k7unDQwTZ456/4V8DydWAEeXQnljXIZcT2VWt5bhRJBS3P3Hn57GJNd0lcsbTUaF5fz3qyrFU0ff1Hq2tUJM4kfubcbkhffZicD6I7ctg2SQ8pE4LoFvXYP3VyceI4m//Em/frM1tXmZqUjEPyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9HohqIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52867C19422
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764952351;
	bh=qz5kxhzVa4r3joxN4Vdcq8+3q2U8yYYZGyZdZ7MJb94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I9HohqIMMpjHCufgjoLqpR0z0jx77aFAu6DpVJi+K3IAHvQQU9PIYfHFqqcdsvr5+
	 Lm7J0UucwNLlh4JCe09Wv/X3rQXZUFnZiSOR0455dJE2hGrCmzPT0cAem+BWuk+D+f
	 Q1BxEGpszW9ywYdJje+tNhUg/GclKEtPgpfPKYzfhDdLhzAYpUFwxYOMA1Y0Pv7qi3
	 MEWJdpAtxQ7DRzk5mnwMiRIyDtYny+kbbFeIig/TwWu3z8WAH5aN7hGNWQK74ZQHbp
	 96lIdYQMv0ys8OPRqtfULZh0685ca+DgBnl1kJRSFs0svjwNmUHybm6wXoRjLNhyUh
	 ysOC84OC9ECyA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6571763793bso1225773eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 08:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXu0cETQOpsl4UCYW2dvFjrpRdO8f1HdUNmMw0Eq/KIXgRqunghRPUjZ/Uyf1hyd8oSH/+gEbZubVPS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4m0J87pLzah+iNRY5JzODqV58W46Q7cPSr36mx7mwpez6dcIn
	lZ3D0DXGwMA0XUp9Dw6VXxRbQdcXvTyK5p1zhKoX3YjxVBGMAW5BqZsO/gKSGB/nFqoi9alnGT5
	78N4rkDK59ZzxlInzD8bqXIBR2e1U3v4=
X-Google-Smtp-Source: AGHT+IEnWg2DG3jBKWT1sJuYE3EP5kQiaFRH9rFd3XZi4km51O6PRtKk76WVQ+7Q45wbfTNs9RyUAVIlD17GeVxVZz4=
X-Received: by 2002:a05:6808:80b0:b0:44f:76aa:77d5 with SMTP id
 5614622812f47-45379cb3ba6mr4098611b6e.16.1764952350449; Fri, 05 Dec 2025
 08:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com> <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com> <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
In-Reply-To: <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Dec 2025 17:32:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
X-Gm-Features: AWmQ_bkT6l3XTPbW_PyTQ2327tJif3sKTnXzhLITGInSyGV8Oo5Lxyjwoq7nunI
Message-ID: <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Mario Limonciello <superm1@kernel.org>, Robert Beckett <bob.beckett@collabora.com>, 
	linux-acpi@vger.kernel.org, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 7:31=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> On Thu, 4 Dec 2025 at 17:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Dec 4, 2025 at 4:04=E2=80=AFPM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> > >
> > > On 12/3/25 17:58, Rafael J. Wysocki wrote:
> > > >> Add `/sys/power/lps0_screen_off` interface to allow userspace to c=
ontrol
> > > >> Display OFF/ON DSM notifications at runtime.
> > > > Why?
> > > >
> > > >> Writing "1" to this file triggers the OFF notification, and "0" tr=
iggers the ON notification.
> > > >>
> > > >> Userspace should write "1" after turning off all physical and remo=
te
> > > >> displays. It should write "0" before turning on any of displays.
> > > > This sets a limitation on the correct/expected usage of this
> > > > interface.  How can the kernel ensure that the limitation is taken
> > > > into account?  In principle, it should not allow OFF to be triggere=
d
> > > > if any displays are "on", for example.
> > > >
> > > > And what exactly do you mean by "turning off a display".  Cutting
> > > > power from it or something else?
> > >
> > > The common lowest level denominator for the "turned off display" shou=
ld
> > > be that all display CRTCs are disabled and there are no active remote
> > > desktop sessions.
> > >
> > > For example, firmware of Intel laptops tracks state of a built-in
> > > display internally and treats display being tuned off when either
> > > display's CRTC is disabled or when backlight level is set to 0. This =
may
> > > be not the same for AMD firmware.
> > >
> > > Display On/Off notification is a hint to firmware that it's allowed t=
o
> > > put machine into a lower power state where UI presented to a user may
> > > become non-interactive.
>
> Jumping in for some more context
>
> The display on/off notifications do not put the hw into a low power
> state. It purely affects the presentation of the device. Specifically,
> the keyboard backlight/RGB, and for some devices the power button
> light/built-in controller for handhelds.
>
> Although devices that pulse the power button light due to it are very
> limited. In particular, I think it is Lenovo only. I have not run into
> another manufacturer that uses it. Specifically, their consumer
> revision. I would have to retest my thinkpad.
>
> Most manufacturers hook into the sleep DSMs for the power button or,
> e.g. Asus, with the LPS0 _DSMs.
>
> If you think about it, it makes sense. Turning off the display does
> not mean the device is not doing intensive work, such as rendering a
> video. So CPU/GPU/power envelope are unaffected and that's true for
> the ~7 manufacturers I tested.
>
> A lot of manufacturers do limit the power envelope as a response to
> the sleep _DSMs. Specifically, this is true for both Lenovo and Asus
> consumer divisions. For a device such as the Go S, it also completely
> turns off the fan. Typical power envelope is ~7W for this. This is
> also why there is a _DSM for speeding up resume and why I had a faux
> resume state in my series.

Well, this is all in "modern standby" context AFAICS, but in Linux it
is different because Linux doesn't do "modern standby" now and it is
unlikely to do "modern standby" going forward.

In Linux, making the system look like it is suspended even though in
fact it isn't may be quite confusing, as a user may think that it is
now safe to put a laptop in a bag, for example, but in fact it isn't.

> >
> > To be precise, that's what MSDN has to say about it:
> >
> > "This _DSM Function will be invoked when the operating system has
> > entered a state where all displays=E2=80=94local and remote, if any=E2=
=80=94have been
> > turned off. This could occur based on some user action, e.g. a button
> > press or lid close event, or expiration of some display power down
> > timer."
> >
> > The "Intel Low-power S0 Idle" specification
> > (https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0=
_Idle.pdf)
> > says almost the same thing.
> >
> > None of them says what kind of hint this is to the firmware and what
> > the firmware is expected to do in response to it.
>
> It is true that online documentation does not list the firmware
> response. There is additional documentation that lists the exact entry
> conditions for display on/off [1]
>
> Specifically, while it is a prerequisite of the CRTCs, local/remote,
> being turned off, the actual condition mirrors when userspace would
> present a lockscreen to the user. I.e., if it is due to inactivity,
> those notifications fire 5 seconds after displays turn off, and if it
> is due to explicit action, e.g., power button, it is instant.
>
> "However, the system continues to run and all applications continue to
> operate normally as if the display was powered on." also implies that
> no hw is powered off as part of this notification.
>
> [1] https://learn.microsoft.com/en-us/windows-hardware/design/device-expe=
riences/display--sleep--and-hibernate-idle-timers

Wouldn't just turning the display off be sufficient here?  Why do you
want to go for platform notification in addition to it?

> > > In practice, entering this lower power state makes device to pretend
> > > that it has been suspended. On a laptop, keyboard backlight will be
> > > turned off and power button LED will start blinking. This allows us t=
o
> > > implement the "resume to a dark mode", mentioned in the cover letter.
> >
> > Maybe, depending on what the firmware actually does.
> >
> > > It's up to userspace to make decision when and what DSM notification
> > > should be issued, thus the new sysfs control.
> >
> > Why would it be up to user space?
> >
> > > There is no strict requirement on having displays to be turned off wh=
en
> > > Display OFF notification is issued. Machine won't blow up when displa=
y
> > > is enabled and OFF notification is set. Hence, it should be unnecessa=
ry
> > > for kernel to be extra cautious RE trusting userspace.
> >
> > That is until one of them actually blows up when that happens.
> >
> > As it stands, I'm totally unconvinced.
> >
> > I generally think that allowing user space to trigger evaluation of
> > AML via sysfs is risky, pretty much regardless of what the given AML
> > has been designed for.  Turning that into kernel ABI is asking for
> > trouble.
>
> I would tentatively agree, specifically in the way this series/ABI is
> phrased. My suggestion would be a more generalizable ABI that is not
> x86/ms specific.

That would be less objectionable I think, but see below.

> This way it can be bounded as appropriate to be safe
> and then expanded to other devices/drivers, including those that do
> not have an accompanying modern standby implementation.
>
> The risks for this are a bit overblown. A proper userspace
> implementation would always ensure that the displays have turned off,
> so in the case a niche device malfunctions with a display off
> notification and an enabled CRTC would leave ample time for the 2-3
> DRM patches required to block it on the kernel side to be merged.
>
> Moreover, I have personally tested these DSMs on around ~9 devices by
> ~7 manufacturers, and we have been shipping a modified version of the
> series I sent in 2024 to around 200k users. That series pulls the
> notification firing above the place where DRM suspends the CRTCs and
> there haven't been any issues due to it.

So what value is added by this, if I may ask?

> > Now, AFAIK this particular _DSM interface has been designed to be part
> > of the "modern standby" (or equivalent) flows, not to be used
> > separately, so assuming that it will always work the way you think it
> > will when used separately is kind of walking on thin ice IMV.
>
> In Windows, the modern standby flow is implemented in userspace as a
> coalescing function of different programs through their power manager
> and exposed to hardware through three notifications (DIsplay On/Off,
> Sleep, LPS0)[2]. My current understanding is that when it comes to the
> Linux desktop, it is also the responsibility of userspace to handle
> these different states, so for userspace to be able to implement this,
> it would need an ABI to configure the device into a similar state.

As I said, Linux doesn't do "modern standby" and for a reason.

Windows is a vertical OS with user space and the kernel tied together
more tightly.  There is even a "modern standby" API for applications
IIUC.

In Linux, the kernel may work with many different user space stacks,
from Android to things like OpenWRT and it needs to accommodate all of
them.  Moreover, applications may be totally oblivious to anything
related to power management.

> What would be the way forward for this? I do not think it is realistic
> to defer implementing these features because they are only supposed to
> work with Windows.
>
> [2] https://learn.microsoft.com/en-us/windows-hardware/design/device-expe=
riences/modern-standby-firmware-notifications

I first need to be convinced that there is any value in allowing user
space to trigger LPS0 _DSM functions.  So far, I see no such value.

> > And there is also a concern regarding all of the systems where this
> > firmware interface is not present or not supported that will not get
> > the "dark resume" experience associated with it.  If you want "dark
> > resume" to be a feature of Linux, it should not depend on whether or
> > not a particular firmware is there and actually works the way you
> > like.
> >
>
> There are two implications here: 1) all hardware should support a

I guess you mean "options"?

> "dark resume" feature, 2) this feature should not be locked behind a
> specific firmware/UEFI implementation.
>
> First one is not true. Legacy hardware that is not built with the
> ability to wake up periodically without turning on its fan, backlight,
> power light and with a reduced power envelope will never get the full
> benefit of such a feature set.

I guess by "hardware" you mean "platforms"?

Anyway, this isn't about hardware/platform capabilities but mostly
about how system suspend is implemented in the kernel.  In principle,
"dark resume" should be possible on any platform where suspend-to-idle
is supported if all device drivers support runtime PM and if it
integrates properly with system suspend/resume.

> Second one is tenable with a proper ABI that can be implemented also
> through e.g., EC platform drivers. In addition, pretty much all
> laptops post ~2021 support a subset or all of these DSMs and S3
> support has been retired, when it comes to AMD since the ~7000 series
> APUs. This is not to say that all of it will work equally well though.

No, this won't work.  You cannot generally rely on the platform
firmware to handle things behind the kernel's back via some magic
_DSM.

I'm honestly unsure if the "dark resume in Linux" idea has been
thought through sufficiently at the conceptual level.

IMV, the whole benefit from "dark resume" would be related to the
handling of system wakeup events.

Namely, in Linux, there is this concept of freezing user space which
allows applications to not care about system suspend, so after user
space has been frozen and before it is thawed on the way back from
system suspend, there is nothing user space can do.  It is all handled
by the kernel.

When the system is resuming, the kernel decides what parts of the
system will be powered up and whether or not displays will be turned
on etc.  Basically, device drivers have suspend and resume callbacks
that cause things to happen and everything depends on what they do.
Nowadays, the majority of drivers follow the rule to power up
everything on the way back from system suspend and this needs to be
changed in the first place for "dark resume" to be viable.

What they can do instead (again, in principle) is to allow the devices
handled by them to stay in runtime suspend after a system resume, so
they will get powered up only after the first access attempt from user
space.  If that's what they do, the majority of devices may stay in
runtime suspend at the point when user space is thawed and, ideally,
only those needed for processing any new data will be resumed.  When
this processing is over, the system may be suspended again without
resuming all of the devices left in runtime suspend during the
preceding system resume (and in this case it is better to go straight
for full system suspend because that's how energy is saved).

Accordingly, if a wakeup event occurs, it may be handled without
"reviving" the entire system even though full-fledged system suspend
and resume transitions are carried out every time.

That would be my approach to making the "dark resume" concept work and
honestly I don't see any different way to make it work in Linux.

I would start with the graphics stacks and teach them to
runtime-suspend the HW when the displays go off.  No firmware
notifications are needed for this to work.  Then, I would teach
graphics drivers to leave the devices in runtime-suspend if they are
runtime-suspended when system suspend starts and to leave them in
runtime-suspend throughout the system suspend and resume, so they are
still runtime-suspended whey system resume is complete.  I'm not sure
how far away graphics stacks are from this, but at least some of them
support runtime PM, so maybe the fruits don't hang very high.  With
that, you'd just need a way to trigger a system suspend after a period
of inactivity when the displays are off and you have your "dark mode".

