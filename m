Return-Path: <linux-acpi+bounces-19479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC9CAB3F3
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 12:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09742304E578
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0282D0C8B;
	Sun,  7 Dec 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kIBzSlQJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62916227E82
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765108279; cv=none; b=mdJhru16tupa2qzYM38Noqk8CfbuFpDhFa5Tce+XQzPDyPukfOiiTFBNAlNTW4d/2ZGhl/BEdiKJCkPL2pbvqJX1eReQbfw13JWSL7tIE1FRtfMEYas8pBN9DbGoF5sPNOSb2DpkRkpDJEQB/QKRKyYe1hCnithl3z8S/gqe4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765108279; c=relaxed/simple;
	bh=AzhIUdMUeXolczBaq8sDvIrk10CFKYDNu3Vy7IRO4ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qk8lJlEpRJmXR9aIz29FX/CmxZ/cu4y5+oaH+iSh9G5H/p/Nm81BqaG2leqJmH6UKBqdHEtdl6C2mTywFD3ji7uN4rvKSMpHe0U+aGX5OkCW1OIS0kL01lo7Eq4ZAzxgobSlqWZxk1qhYPfMgidaejVJx0sgGKzbDN2YbijCyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kIBzSlQJ; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 6F1853FCB8
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 13:51:09 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 359533FC9F
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 13:51:08 +0200 (EET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 86760201BB7
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 13:51:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1765108267;
	bh=9N00A6VIV5QhXMvvNfmh0FZWT/wBuW9xq940XL/gtzo=;
	h=Received:From:Subject:To;
	b=kIBzSlQJLK4qlGSJAVB4OL3iba8pb+Md0nWz3FVW2WkzAlT3uLYqMKqtsZXIsCjWf
	 rTVvDoXOvb0ZlsZz6O8jZEcly1+P1iBhE/iovwfg+sdmITJ6pNj5L1lBGeJxkFXTi2
	 OihhCxtXSx7M77ljL6GCekeRevxgia8i4qmJzWnkHCharI8R6iMVtnDxkptqCNJmEG
	 lVLt2zDSxEhqbTj0OkY/gwwoAwYzY/5PpsrYlXPt86PJh8JwYlv1uHHCPRro7AM2le
	 huQrl4ezlUeWubmqyoiSRM6NXuOEObESNI7WRVWvINHIShrAlpfK3JeL7RHCZggSrc
	 wJbG8x2MDt23w==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-37bbb36c990so40135061fa.0
        for <linux-acpi@vger.kernel.org>;
 Sun, 07 Dec 2025 03:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUMxNWtnqZtheNuTHHXmFu1gTWGke0T1WwlB809aBp20aF2dQ7u5RJkKLY2TMENHyLCpWYdTcbspMC6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfs8CCfRnGVPfss8GqEnYNpK6Z2oc5vvN6YSI5Fbl1dyDYmGZN
	nf5VBLFL6cXpWDyu/tLnMW5CxRSrGZVnJCuLG3EyO3m75d3Hi43rVRIjjfF8xEc9MtnabNk1BGD
	/d8Yioqt5qkjO/PdPkQqfVbrMAu2vFk8=
X-Google-Smtp-Source: 
 AGHT+IHeHXxsOQuLeoDNU5a5V6j2su44tH/TZ2GU2WYAEJ7pVEnhKJZ1saT5i9LYaT7yfNOanb0YYP5519O9FyYCyFg=
X-Received: by 2002:a2e:bc26:0:b0:376:41f5:a6ca with SMTP id
 38308e7fff4ca-37e6cb227d1mr34517321fa.0.1765108266689; Sun, 07 Dec 2025
 03:51:06 -0800 (PST)
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
 <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
 <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
 <CAJZ5v0j3wNtqYQDsVr+74-Gn-WM9FDmoqxrLULVD+UJtfVgLtQ@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0j3wNtqYQDsVr+74-Gn-WM9FDmoqxrLULVD+UJtfVgLtQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 7 Dec 2025 12:50:55 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEgfH+QRpBXNGhZG5hxNF28A3ALbrABGYJg7RuFKDrM0A@mail.gmail.com>
X-Gm-Features: AQt7F2oGmCJSjS4IEFhGY4ffjp9KLYK4nz_ZeWtBV2pmEQbHSFww9DMQIFMC2G0
Message-ID: 
 <CAGwozwEgfH+QRpBXNGhZG5hxNF28A3ALbrABGYJg7RuFKDrM0A@mail.gmail.com>
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
 <176510826778.4125611.9800877712761782992@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 7 Dec 2025 at 12:20, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Dec 7, 2025 at 12:06=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > GMail did something silly to my reply to this message, so resending it
> > in case it didn't make it to the lists.  Sorry for duplicates.
> >
> > On Fri, Dec 5, 2025 at 11:52=3DE2=3D80=3DAFPM Antheas Kapenekakis
> > <lkml@antheas.dev> wrote:
> > >
> > > On Fri, 5 Dec 2025 at 17:32, Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > > >
> > > > On Thu, Dec 4, 2025 at 7:31=3DE2=3D80=3DAFPM Antheas Kapenekakis <l=
kml@antheas.dev> wrote:
> > > > >
> > > > > On Thu, 4 Dec 2025 at 17:41, Rafael J. Wysocki <rafael@kernel.org=
> wrote:
> > > > > >
> >
> > [cut]
> >
> > > >
> > > > In Linux, making the system look like it is suspended even though i=
n
> > > > fact it isn't may be quite confusing, as a user may think that it i=
s
> > > > now safe to put a laptop in a bag, for example, but in fact it isn'=
t.
> > >
> > > My thesis would be a proper userspace implementation running on a
> > > laptop with a properly configured platform, it should be safe for the
> > > user to put the laptop in their bag, even if it wakes up briefly
> > > multiple times per hour without their knowledge or being perceivable.
> >
> > That's what Android phones/tablets do, but that's a vertical software s=
tack.
> >
> > To implement something like this you need (a) support from the GFX driv=
er
> > in the kernel to go into system suspend back and forth without turning
> > displays on and off, and (b) a mechanism to trigger system suspend
> > automatically after a period of inactivity while in the "displays off, =
no
> > GUI activity" state, and (c) support for system wakeup events in (b).
> >
> > I'm not sure what the LPS0 _DSM role is in that.
> >
> > > It is also a very valid point that this is a _very fine_ line that
> > > Windows crossed with its userspace implementation and soured the
> > > perception of Modern Standby for a lot of users. Buggy platform
> > > firmware/insufficient tooling/control for OEMs, early on also
> > > contributed to this.
> > >
> > > > > >
> > > > > > To be precise, that's what MSDN has to say about it:
> > > > > >
> > > > > > "This _DSM Function will be invoked when the operating system h=
as
> > > > > > entered a state where all displays=3DE2=3D80=3D94local and remo=
te, if any=3D=3DE2=3D80=3D94have been
> > > > > > turned off. This could occur based on some user action, e.g. a =
button
> > > > > > press or lid close event, or expiration of some display power d=
own
> > > > > > timer."
> > > > > >
> > > > > > The "Intel Low-power S0 Idle" specification
> > > > > > (https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_=
Power_S0_Idle=3D.pdf)
> > > > > > says almost the same thing.
> > > > > >
> > > > > > None of them says what kind of hint this is to the firmware and=
 what
> > > > > > the firmware is expected to do in response to it.
> > > > >
> > > > > It is true that online documentation does not list the firmware
> > > > > response. There is additional documentation that lists the exact =
entry
> > > > > conditions for display on/off [1]
> > > > >
> > > > > Specifically, while it is a prerequisite of the CRTCs, local/remo=
te,
> > > > > being turned off, the actual condition mirrors when userspace wou=
ld
> > > > > present a lockscreen to the user. I.e., if it is due to inactivit=
y,
> > > > > those notifications fire 5 seconds after displays turn off, and i=
f it
> > > > > is due to explicit action, e.g., power button, it is instant.
> > > > >
> > > > > "However, the system continues to run and all applications contin=
ue t=3D
> > o
> > > > > operate normally as if the display was powered on." also implies =
that
> > > > > no hw is powered off as part of this notification.
> > > > >
> > > > > [1] https://learn.microsoft.com/en-us/windows-hardware/design/dev=
ice-experiences/display--sleep--and-hibernate-idle-timers
> > > >
> > > > Wouldn't just turning the display off be sufficient here?  Why do y=
ou
> > > > want to go for platform notification in addition to it?
> >
> > [cut]
> >
> > > There is a tendency by Microsoft to add OEM tooling that avoids the
> > > need for creating platform drivers.
> > >
> > > This includes the WMI implementation which allows Windows userspace t=
o
> > > talk to hardware without having a signed platform driver, and now thi=
s
> > > standardized set of notifications. Maintaining a signed
> > > vulnerability-free driver is expensive.
> > >
> > > The Display On/Off notifications provide hooks for OEMs to customize
> > > the inactive appearance of their device. Mostly, this is through
> > > turning off auxiliary lights, such as the keyboard backlight.
> > >
> > > The sleep notifications provide a way for OEMs to limit the thermal
> > > envelope of their machine and make it look like it is asleep, so that
> > > it is safe for that device to wake up multiple times per hour,
> > > including in a bag, without looking like it is awake.
> >
> > This is based on a very optimistic assumption that generally cannot be
> > verified I'm afraid.
> >
> > (1) User space must not do anything silly like Bitcoin mining while
> > this is done.
> > (2) The firmware must not be cheating.
> > (3) The GFX driver needs to be able to transition transparently
> > between the "displays off" graphics state and the system suspend and
> > resume flows.
> > (4) The GFX driver activity needs to be coordinated at least somewhat
> > with whatever user space entity would be responsible for triggering
> > the notifications so they do not get completely out of sync.
> >
> > > Here is an example with how these DSMs would work with thinkpads.
> > >
> > > Windows does not have a Thinkpad backlight driver. There is auxiliary
> > > and optional software, Vantage, which provides some of this. Assume i=
t
> > > is not installed. Then, in Linux, assume you disable the thinkpad
> > > backlight driver, so upower loses control of the thinkpad keyboard
> > > backlight. The thinkpad keyboard backlight is automatically controlle=
d
> > > by the EC through keyboard shortcuts. So are the power modes, via Fn+=
L
> > > M H.
> > >
> > > Then, assume that Linux implements these _DSMs, and hooks them via
> > > systemd as following: display on/off is hooked to occur when logind
> > > would lock the session, i.e. after 5 seconds of inactivity or pressin=
g
> > > the power button. The sleep notifications are triggered by
> > > systemd-sleep, before suspend-then-hibernate begins.
> > >
> > > The end result is that after the display turns off, the keyboard
> > > backlight of the device will also turn off automatically without a
> > > platform driver. This is true for all modern standby laptops at least
> > > post ~2021. A lot of these do not have kernel drivers in linux.
> > >
> > > Then, if the sleep state is supported (spotty in thinkpads but
> > > available in a lot of other hw), when the RTC Wake Alarm/battery alar=
m
> > > wakes the device and systemd briefly checks whether it should
> > > hibernate, it will still look like it is asleep, and it will have a
> > > reduced power envelope, reducing the risk of overheating if it is in =
a
> > > bag and lowering standby power consumption.
> > >
> > > I.e., without requiring vendor software, platform drivers, both
> > > Windows and Linux present a full feature set out of the box.
> >
> > I guess it would be rather useful to start the discussion with this
> > proposed flow, some time might have been saved by everyone.
> >
> > IIUC, the point is to make the system look "suspended" if it goes out
> > of suspend briefly in response to a wakeup event (the other potential
> > "benefits" of what the notifications can possibly do are in the domain
> > of marketing IMV), but is it really worth the hassle?
> >
> > Assuming that the answer is "yes", which I'm not convinced about at
> > all, can't the kernel simply defer the "screen on" notification to
> > some time after thawing user space, so it can avoid doing it and the
> > corresponding "screen off" one if the system is suspended again
> > quickly enough? Perhaps so long as the GFX driver opts in?
> >
> > And now we get to the most important thing: even before trying to do
> > the above, let alone exposing anything to user space, the existing
> > suspend-to-idle flow in the kernel needs to be adjusted to do the
> > "screen off" notification much earlier and the "screen off"
>
> The second one obviously should be "screen on", sorry for the typo.
>
> > notification much later than they are done today.  I think that you
> > should be able to argue convincingly for making this change.
> >
> > If this doesn't universally work for whatever reason, anything more
> > will be out of the question.
>
> So let me repeat for extra clarity.
>
> The only change related to the LPS0 "screen off" and "screen on"
> notifications that would be tentatively acceptable to me ATM, would be
> to modify the suspend-to-idle flow to do the "screen off" notification
> earlier (possibly even at the start of it) and the corresponding
> "screen on" notification later (possibly at the end of it), provided
> that one can convincingly argue that this should not introduce
> regressions.
>

From what I recall that was my original plan.

Yeah, it is a fair way forward. @Dmitry how would you like to approach
this? SInce you re-started the discussion. What is your timeline/KPIs
for this.

I could personally try to whip up a small series after the merge
window by rewriting what I have[1]. I have more experience now in
drafting this kind of thing and that series added some cruft to the pm
core with multiple additions to platform_s2idle_ops

There is a _small_ quantitative difference due to moving the calls.
Specifically, the power light responds a tad slower when waking a
device. For the legion go (non-s) devices, Lenovo added a dummy 5
second timer to resuming the controllers because of some Windows bugs,
and moving the calls causes the timer to start later. But that's the
OEM intended behavior...

Antheas

[1] https://github.com/bazzite-org/patchwork/commits/pm-bleeding/modern-sta=
ndby/


