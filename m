Return-Path: <linux-acpi+bounces-19461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954FCA98BF
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 23:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54FA631B8CF3
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14D296BDE;
	Fri,  5 Dec 2025 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CNGk3Iuf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360C40855
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975134; cv=none; b=ho9FO30E8Zj2agnkoNI3BoqL2L0LcvXalQ8JPHF1JzB+6VjNaRggk8cTlpaqA7hHbvTJ1/jedzWv5dZnKdtph9JkjWScg4+qN++UAzCvjBzKNYKN5xIgXVIozQhsY2h15j15gBS1SCbfkeAKbKJbLa3ARXM7dIQLAi6occnRmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975134; c=relaxed/simple;
	bh=I1Sxo2cYtC1+eHFlUeoL0yKeSP3OjYz3bIAO16atzmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtIrFaUMe/4U/+Shx6JSlaNSPFBU3NUNFXnyIDV1nQ/opDO6TuTCXK2rgfXU9c9LARFy3nLyEWL5sr2LboAHwgPyUupq09bfUDF6nDa6QAnq85jg97lTxiDK/N0byM8gOJD0HsBREFjGviGrRULudkEgn4Gu2cWOUKyamAz96HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CNGk3Iuf; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id A324C5E6C1
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 00:52:05 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id C02E65E6B0
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 00:52:03 +0200 (EET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0F6A8202203
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 00:52:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1764975122;
	bh=rfQvLTvdTRQu1VTh0ALwAxF9NUYxsvSgoKc96N1VDTM=;
	h=Received:From:Subject:To;
	b=CNGk3IufbldBQ6KcFOpyMlo7x3FJMCsHkXZWNVqzperr7IfRZj6ALkckbRi+p+eML
	 RxazvFhp5jyo5bCsRflgLkDl1Ti9CZd4+9cYNevNjgyCGsOi6chCKlYNszwm1rhEBe
	 q8y9uRsKGKYUeiPoBz+8qHu6JJH+afcpAxfeM6Fq/9+6QDIYp+ZBv5s7bSoR1VvVYt
	 mVT/DDXkyiDVsgtWcNkR6z+Q+HDxZ+Yv4sDTNQOJXNoeGeGVJ+ffikTg/LLqRxu1/5
	 YJchkW3jQXSS/y99SV8fJFcIf00/Ydn+iiEQsHy/iGxLV+/Cq5hY5jo5pRmXnFadwa
	 hg1vsM7okMDLA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-37b935df7bfso25113371fa.2
        for <linux-acpi@vger.kernel.org>;
 Fri, 05 Dec 2025 14:52:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVHUL7h5xC9LVDAiwMnAPkCZ2EFNuafoIWLqJMKIsOP1JsxlkwukVPOnnL6081f9ko1K9902DPDUYAy@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIyfIEJTiy6/8+vBVwzSXWBBgoid+XTYvmXePaW+zC2+Fcv1U
	6KmExk8cd6s14S5dGVc0zJx3lsBUFXMmyu3SIngBbaQijPxxBvce0Rbcy92o9uDc9ZAZfVWUBre
	2YrMctcz6DPuFmCx677TrhzIQanRKubM=
X-Google-Smtp-Source: 
 AGHT+IFwk17f7ui1mmT9vLQLxCEDMtpEWyTbJrFpHnsrK/QpgA1zEAoNjurquVP1/NhAwViX5Uc8kE357D70JwRPtdY=
X-Received: by 2002:a05:651c:b14:b0:37a:9558:5bda with SMTP id
 38308e7fff4ca-37ed1fd06dbmr1771561fa.14.1764975121061; Fri, 05 Dec 2025
 14:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 5 Dec 2025 23:51:49 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
X-Gm-Features: AQt7F2om0BtLxZ5KPbjnlHCL2r-3x6_F9Rtt42ImOwIlH8evrYGEugJS72hX27w
Message-ID: 
 <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Mario Limonciello <superm1@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org,
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176497512265.297022.15757085849323188992@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 5 Dec 2025 at 17:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 4, 2025 at 7:31=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
> >
> > On Thu, 4 Dec 2025 at 17:41, Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
> > >
> > > On Thu, Dec 4, 2025 at 4:04=E2=80=AFPM Dmitry Osipenko
> > > <dmitry.osipenko@collabora.com> wrote:
> > > >
> > > > On 12/3/25 17:58, Rafael J. Wysocki wrote:
> > > > >> Add `/sys/power/lps0_screen_off` interface to allow userspace to=
 control
> > > > >> Display OFF/ON DSM notifications at runtime.
> > > > > Why?
> > > > >
> > > > >> Writing "1" to this file triggers the OFF notification, and "0" =
triggers the ON notification.
> > > > >>
> > > > >> Userspace should write "1" after turning off all physical and re=
mote
> > > > >> displays. It should write "0" before turning on any of displays.
> > > > > This sets a limitation on the correct/expected usage of this
> > > > > interface.  How can the kernel ensure that the limitation is take=
n
> > > > > into account?  In principle, it should not allow OFF to be trigge=
red
> > > > > if any displays are "on", for example.
> > > > >
> > > > > And what exactly do you mean by "turning off a display".  Cutting
> > > > > power from it or something else?
> > > >
> > > > The common lowest level denominator for the "turned off display" sh=
ould
> > > > be that all display CRTCs are disabled and there are no active remo=
te
> > > > desktop sessions.
> > > >
> > > > For example, firmware of Intel laptops tracks state of a built-in
> > > > display internally and treats display being tuned off when either
> > > > display's CRTC is disabled or when backlight level is set to 0. Thi=
s may
> > > > be not the same for AMD firmware.
> > > >
> > > > Display On/Off notification is a hint to firmware that it's allowed=
 to
> > > > put machine into a lower power state where UI presented to a user m=
ay
> > > > become non-interactive.
> >
> > Jumping in for some more context
> >
> > The display on/off notifications do not put the hw into a low power
> > state. It purely affects the presentation of the device. Specifically,
> > the keyboard backlight/RGB, and for some devices the power button
> > light/built-in controller for handhelds.
> >
> > Although devices that pulse the power button light due to it are very
> > limited. In particular, I think it is Lenovo only. I have not run into
> > another manufacturer that uses it. Specifically, their consumer
> > revision. I would have to retest my thinkpad.
> >
> > Most manufacturers hook into the sleep DSMs for the power button or,
> > e.g. Asus, with the LPS0 _DSMs.
> >
> > If you think about it, it makes sense. Turning off the display does
> > not mean the device is not doing intensive work, such as rendering a
> > video. So CPU/GPU/power envelope are unaffected and that's true for
> > the ~7 manufacturers I tested.
> >
> > A lot of manufacturers do limit the power envelope as a response to
> > the sleep _DSMs. Specifically, this is true for both Lenovo and Asus
> > consumer divisions. For a device such as the Go S, it also completely
> > turns off the fan. Typical power envelope is ~7W for this. This is
> > also why there is a _DSM for speeding up resume and why I had a faux
> > resume state in my series.
>
> Well, this is all in "modern standby" context AFAICS, but in Linux it
> is different because Linux doesn't do "modern standby" now and it is
> unlikely to do "modern standby" going forward.
>
> In Linux, making the system look like it is suspended even though in
> fact it isn't may be quite confusing, as a user may think that it is
> now safe to put a laptop in a bag, for example, but in fact it isn't.

My thesis would be a proper userspace implementation running on a
laptop with a properly configured platform, it should be safe for the
user to put the laptop in their bag, even if it wakes up briefly
multiple times per hour without their knowledge or being perceivable.

It is also a very valid point that this is a _very fine_ line that
Windows crossed with its userspace implementation and soured the
perception of Modern Standby for a lot of users. Buggy platform
firmware/insufficient tooling/control for OEMs, early on also
contributed to this.

> > >
> > > To be precise, that's what MSDN has to say about it:
> > >
> > > "This _DSM Function will be invoked when the operating system has
> > > entered a state where all displays=E2=80=94local and remote, if any=
=E2=80=94have been
> > > turned off. This could occur based on some user action, e.g. a button
> > > press or lid close event, or expiration of some display power down
> > > timer."
> > >
> > > The "Intel Low-power S0 Idle" specification
> > > (https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_=
S0_Idle.pdf)
> > > says almost the same thing.
> > >
> > > None of them says what kind of hint this is to the firmware and what
> > > the firmware is expected to do in response to it.
> >
> > It is true that online documentation does not list the firmware
> > response. There is additional documentation that lists the exact entry
> > conditions for display on/off [1]
> >
> > Specifically, while it is a prerequisite of the CRTCs, local/remote,
> > being turned off, the actual condition mirrors when userspace would
> > present a lockscreen to the user. I.e., if it is due to inactivity,
> > those notifications fire 5 seconds after displays turn off, and if it
> > is due to explicit action, e.g., power button, it is instant.
> >
> > "However, the system continues to run and all applications continue to
> > operate normally as if the display was powered on." also implies that
> > no hw is powered off as part of this notification.
> >
> > [1] https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/display--sleep--and-hibernate-idle-timers
>
> Wouldn't just turning the display off be sufficient here?  Why do you
> want to go for platform notification in addition to it?

For this, see*

> > > > In practice, entering this lower power state makes device to preten=
d
> > > > that it has been suspended. On a laptop, keyboard backlight will be
> > > > turned off and power button LED will start blinking. This allows us=
 to
> > > > implement the "resume to a dark mode", mentioned in the cover lette=
r.
> > >
> > > Maybe, depending on what the firmware actually does.
> > >
> > > > It's up to userspace to make decision when and what DSM notificatio=
n
> > > > should be issued, thus the new sysfs control.
> > >
> > > Why would it be up to user space?
> > >
> > > > There is no strict requirement on having displays to be turned off =
when
> > > > Display OFF notification is issued. Machine won't blow up when disp=
lay
> > > > is enabled and OFF notification is set. Hence, it should be unneces=
sary
> > > > for kernel to be extra cautious RE trusting userspace.
> > >
> > > That is until one of them actually blows up when that happens.
> > >
> > > As it stands, I'm totally unconvinced.
> > >
> > > I generally think that allowing user space to trigger evaluation of
> > > AML via sysfs is risky, pretty much regardless of what the given AML
> > > has been designed for.  Turning that into kernel ABI is asking for
> > > trouble.
> >
> > I would tentatively agree, specifically in the way this series/ABI is
> > phrased. My suggestion would be a more generalizable ABI that is not
> > x86/ms specific.
>
> That would be less objectionable I think, but see below.
>
> > This way it can be bounded as appropriate to be safe
> > and then expanded to other devices/drivers, including those that do
> > not have an accompanying modern standby implementation.
> >
> > The risks for this are a bit overblown. A proper userspace
> > implementation would always ensure that the displays have turned off,
> > so in the case a niche device malfunctions with a display off
> > notification and an enabled CRTC would leave ample time for the 2-3
> > DRM patches required to block it on the kernel side to be merged.
> >
> > Moreover, I have personally tested these DSMs on around ~9 devices by
> > ~7 manufacturers, and we have been shipping a modified version of the
> > series I sent in 2024 to around 200k users. That series pulls the
> > notification firing above the place where DRM suspends the CRTCs and
> > there haven't been any issues due to it.
>
> So what value is added by this, if I may ask?

*here

There is a tendency by Microsoft to add OEM tooling that avoids the
need for creating platform drivers.

This includes the WMI implementation which allows Windows userspace to
talk to hardware without having a signed platform driver, and now this
standardized set of notifications. Maintaining a signed
vulnerability-free driver is expensive.

The Display On/Off notifications provide hooks for OEMs to customize
the inactive appearance of their device. Mostly, this is through
turning off auxiliary lights, such as the keyboard backlight.

The sleep notifications provide a way for OEMs to limit the thermal
envelope of their machine and make it look like it is asleep, so that
it is safe for that device to wake up multiple times per hour,
including in a bag, without looking like it is awake.

Here is an example with how these DSMs would work with thinkpads.

Windows does not have a Thinkpad backlight driver. There is auxiliary
and optional software, Vantage, which provides some of this. Assume it
is not installed. Then, in Linux, assume you disable the thinkpad
backlight driver, so upower loses control of the thinkpad keyboard
backlight. The thinkpad keyboard backlight is automatically controlled
by the EC through keyboard shortcuts. So are the power modes, via Fn+L
M H.

Then, assume that Linux implements these _DSMs, and hooks them via
systemd as following: display on/off is hooked to occur when logind
would lock the session, i.e. after 5 seconds of inactivity or pressing
the power button. The sleep notifications are triggered by
systemd-sleep, before suspend-then-hibernate begins.

The end result is that after the display turns off, the keyboard
backlight of the device will also turn off automatically without a
platform driver. This is true for all modern standby laptops at least
post ~2021. A lot of these do not have kernel drivers in linux.

Then, if the sleep state is supported (spotty in thinkpads but
available in a lot of other hw), when the RTC Wake Alarm/battery alarm
wakes the device and systemd briefly checks whether it should
hibernate, it will still look like it is asleep, and it will have a
reduced power envelope, reducing the risk of overheating if it is in a
bag and lowering standby power consumption.

I.e., without requiring vendor software, platform drivers, both
Windows and Linux present a full feature set out of the box.

> > > Now, AFAIK this particular _DSM interface has been designed to be par=
t
> > > of the "modern standby" (or equivalent) flows, not to be used
> > > separately, so assuming that it will always work the way you think it
> > > will when used separately is kind of walking on thin ice IMV.
> >
> > In Windows, the modern standby flow is implemented in userspace as a
> > coalescing function of different programs through their power manager
> > and exposed to hardware through three notifications (DIsplay On/Off,
> > Sleep, LPS0)[2]. My current understanding is that when it comes to the
> > Linux desktop, it is also the responsibility of userspace to handle
> > these different states, so for userspace to be able to implement this,
> > it would need an ABI to configure the device into a similar state.
>
> As I said, Linux doesn't do "modern standby" and for a reason.
>
> Windows is a vertical OS with user space and the kernel tied together
> more tightly.  There is even a "modern standby" API for applications
> IIUC.
>
> In Linux, the kernel may work with many different user space stacks,
> from Android to things like OpenWRT and it needs to accommodate all of
> them.  Moreover, applications may be totally oblivious to anything
> related to power management.

Sure, but since the majority of this lies in desktop userspace, those
applications are not affected. All the kernel needs is to provide an
ABI for these notifications just for desktop devices when the ACPI
notifications are present/a platform driver implements them.

> > What would be the way forward for this? I do not think it is realistic
> > to defer implementing these features because they are only supposed to
> > work with Windows.
> >
> > [2] https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/modern-standby-firmware-notifications
>
> I first need to be convinced that there is any value in allowing user
> space to trigger LPS0 _DSM functions.  So far, I see no such value.

See *

> > > And there is also a concern regarding all of the systems where this
> > > firmware interface is not present or not supported that will not get
> > > the "dark resume" experience associated with it.  If you want "dark
> > > resume" to be a feature of Linux, it should not depend on whether or
> > > not a particular firmware is there and actually works the way you
> > > like.
> > >
> >
> > There are two implications here: 1) all hardware should support a
>
> I guess you mean "options"?

Implications, as in that paragraph carries those two assumptions.

> > "dark resume" feature, 2) this feature should not be locked behind a
> > specific firmware/UEFI implementation.
> >
> > First one is not true. Legacy hardware that is not built with the
> > ability to wake up periodically without turning on its fan, backlight,
> > power light and with a reduced power envelope will never get the full
> > benefit of such a feature set.
>
> I guess by "hardware" you mean "platforms"?

I would tend towards "hardware", as legacy hardware that is part of
the same platform can have different behavior. E.g., not implementing
a sleep state.

> Anyway, this isn't about hardware/platform capabilities but mostly
> about how system suspend is implemented in the kernel.  In principle,
> "dark resume" should be possible on any platform where suspend-to-idle
> is supported if all device drivers support runtime PM and if it
> integrates properly with system suspend/resume.

There are certain hardware requirements for modern standby, such as a
modem that can stay connected to Wifi while suspended, having a
reduced power envelope for sleep, an EC that supports battery alarms,
charge notifications, etc.

The absence of some of these components will make certain parts of
"dark resume" less practical for older hardware, while in principle it
would work.

> > Second one is tenable with a proper ABI that can be implemented also
> > through e.g., EC platform drivers. In addition, pretty much all
> > laptops post ~2021 support a subset or all of these DSMs and S3
> > support has been retired, when it comes to AMD since the ~7000 series
> > APUs. This is not to say that all of it will work equally well though.
>
> No, this won't work.  You cannot generally rely on the platform
> firmware to handle things behind the kernel's back via some magic
> _DSM.

These notifications are not related to powering off certain hardware
components. It is not a prerequisite for certain hw to be powered off
before they are called (unlike LPS0) nor do they power off hardware**.

Instead, they provide OEMs with a way to tune their hardware for certain ca=
ses.

**handhelds and their controllers, this is a later discussion

> I'm honestly unsure if the "dark resume in Linux" idea has been
> thought through sufficiently at the conceptual level.
>
> IMV, the whole benefit from "dark resume" would be related to the
> handling of system wakeup events.
>
> Namely, in Linux, there is this concept of freezing user space which
> allows applications to not care about system suspend, so after user
> space has been frozen and before it is thawed on the way back from
> system suspend, there is nothing user space can do.  It is all handled
> by the kernel.
>
> When the system is resuming, the kernel decides what parts of the
> system will be powered up and whether or not displays will be turned
> on etc.  Basically, device drivers have suspend and resume callbacks
> that cause things to happen and everything depends on what they do.
> Nowadays, the majority of drivers follow the rule to power up
> everything on the way back from system suspend and this needs to be
> changed in the first place for "dark resume" to be viable.
>
> What they can do instead (again, in principle) is to allow the devices
> handled by them to stay in runtime suspend after a system resume, so
> they will get powered up only after the first access attempt from user
> space.  If that's what they do, the majority of devices may stay in
> runtime suspend at the point when user space is thawed and, ideally,
> only those needed for processing any new data will be resumed.  When
> this processing is over, the system may be suspended again without
> resuming all of the devices left in runtime suspend during the
> preceding system resume (and in this case it is better to go straight
> for full system suspend because that's how energy is saved).
>
> Accordingly, if a wakeup event occurs, it may be handled without
> "reviving" the entire system even though full-fledged system suspend
> and resume transitions are carried out every time.
>
> That would be my approach to making the "dark resume" concept work and
> honestly I don't see any different way to make it work in Linux.
>
> I would start with the graphics stacks and teach them to
> runtime-suspend the HW when the displays go off.  No firmware
> notifications are needed for this to work.  Then, I would teach
> graphics drivers to leave the devices in runtime-suspend if they are
> runtime-suspended when system suspend starts and to leave them in
> runtime-suspend throughout the system suspend and resume, so they are
> still runtime-suspended whey system resume is complete.  I'm not sure
> how far away graphics stacks are from this, but at least some of them
> support runtime PM, so maybe the fruits don't hang very high.  With
> that, you'd just need a way to trigger a system suspend after a period
> of inactivity when the displays are off and you have your "dark mode".
>

Yes, this is a fair description and how it should work, where the
addition of these notifications would enhance the process.

Runtime suspend is still weird in the current kernel. Most devices,
e.g., GPU/sd card fully wake up and then are re-suspended. I am not
sure how much of this can be prevented, and even if it can, it will be
a progressive per-driver optimization that is not a prerequisite for
"dark mode" but more of a fine tuning imo.

Antheas


