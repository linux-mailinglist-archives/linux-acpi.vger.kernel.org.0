Return-Path: <linux-acpi+bounces-19478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13DCAB3F0
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 12:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7593045094
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53C28469F;
	Sun,  7 Dec 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="l08DwPhj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43D24466C
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765107749; cv=none; b=DCYPzJdNJ+a9yDtKHNhFxFlZ7ol0K5xOmEq/HRFxzte9njlrFcsOmcZ6pgue1QIolAEJIsUlgZ58OT8D8vWsAuJ7iD2yEoXFVI911faXhOl3QoXBpkw6wCTlyHylL6FO3I0lrahvfyBbcfKVDTJJatARNVskSatohLBs4I9it40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765107749; c=relaxed/simple;
	bh=CY0Ywklqe54VIItlbssP6hy0mtXhSrA66eT4F2YRJcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUj52ILnZgFZ8UVYsF2ICh157AysADpQZIJ2z64I1Ygj4EfeazV9fr2nHK5MljoxUC4XPdgNVGxl8uli01zBKJyuQ5BmZK0LF0FHhrcrIWuntzrMbmKcNq6Ace8Gyej8Ah4E0G16qz7dSh0SDfXemRJnRnY3BebaHxuWLeWkhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=l08DwPhj; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id A44325DF1B
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 13:42:24 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 2D98F5E51E
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 13:42:23 +0200 (EET)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 99928201C73
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 13:42:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1765107741;
	bh=XfSKtgIUWZ7ClFZmyc5xWFvcdox7UZBoXA7x2gIwwNk=;
	h=Received:From:Subject:To;
	b=l08DwPhjJvkDc+PXuchOqi28l+hnLP21tBQ2+fb1PcQX7+7fYgng7h4X8O6R3wGGV
	 wfl28TVEU1Edr3m+NYwIBIbJskKQZxNV7i9lyAxLfdWppCS2sy4ChujJ1236leUPiG
	 p3iH9auEuw/0IAo1KQSVSp1Iy54lYdTAmY7z0ulWZBhvCzl1k2EHYPPECFMDa2uCKG
	 3Rx6ryWAcXhdYbdm+hcYMzHBotOqaFemmNchlHUvyJPLq+MvA3jKhouM/Qi8Mj8OTY
	 74uz5ZS0jqi1C893wyVl0OB4CsZuKIF7txsPmQB1XyRCg5QZrEw7M/Epza4Gauh67r
	 SkJPugDpVcPXQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.53) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f53.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5959105629bso3672190e87.2
        for <linux-acpi@vger.kernel.org>;
 Sun, 07 Dec 2025 03:42:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXH81fQL+G4NDyL1RPsE6dgi+YmF3iUl7empsVn11bCe/ikV62Ugzd6vYoroRsrg7Pn4lieye9BJGGp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2LcwZ4uJ61Dlwh9FT4NMsx2nnEBMoIltqHD7ULiyDgwHJTU+
	aVkK+wYU2LyPEGSjW7ZFl3inDo3qDox/ZYnCkrsXGqX1Nqc/MgRnIeGLyeIvg5NXp1u+EcyqTeT
	ZV3AopsHWtgDV+kfuoECXA/SIrplkGJU=
X-Google-Smtp-Source: 
 AGHT+IFk4aXzEJqDUYF77uCvVsLiZd2t6R/YoU94NYZrfrw+9TpQTnXHQDpxEKWsDQsDErxQF4T/9+0GyHdeBgk1DJI=
X-Received: by 2002:a05:651c:254e:20b0:37b:a664:acde with SMTP id
 38308e7fff4ca-37ed206e751mr10436541fa.32.1765107740818; Sun, 07 Dec 2025
 03:42:20 -0800 (PST)
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
In-Reply-To: 
 <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 7 Dec 2025 12:42:09 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG39oUYxLMm3638GxnS-n=yXU-ZypK7wJDwPXv2w=ZDjQ@mail.gmail.com>
X-Gm-Features: AQt7F2p18Tg7cq8sU2APVCVRcvaRaG21wz-UDEcXfY-YRhJXWahWMRa4l6Pwq74
Message-ID: 
 <CAGwozwG39oUYxLMm3638GxnS-n=yXU-ZypK7wJDwPXv2w=ZDjQ@mail.gmail.com>
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
X-PPP-Message-ID: 
 <176510774189.4099087.10375168551671238945@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 7 Dec 2025 at 12:07, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> GMail did something silly to my reply to this message, so resending it
> in case it didn't make it to the lists.  Sorry for duplicates.
>
> On Fri, Dec 5, 2025 at 11:52=E2=80=AFPM Antheas Kapenekakis
> <lkml@antheas.dev> wrote:
> >
> > On Fri, 5 Dec 2025 at 17:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Dec 4, 2025 at 7:31=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.dev> wrote:
> > > >
> > > > On Thu, 4 Dec 2025 at 17:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
>
> [cut]
>
> > >
> > > In Linux, making the system look like it is suspended even though in
> > > fact it isn't may be quite confusing, as a user may think that it is
> > > now safe to put a laptop in a bag, for example, but in fact it isn't.
> >
> > My thesis would be a proper userspace implementation running on a
> > laptop with a properly configured platform, it should be safe for the
> > user to put the laptop in their bag, even if it wakes up briefly
> > multiple times per hour without their knowledge or being perceivable.
>
> That's what Android phones/tablets do, but that's a vertical software stack.
>
> To implement something like this you need (a) support from the GFX driver
> in the kernel to go into system suspend back and forth without turning
> displays on and off, and (b) a mechanism to trigger system suspend
> automatically after a period of inactivity while in the "displays off, no
> GUI activity" state, and (c) support for system wakeup events in (b).

a) is already implemented for AMD devices. I have not done a lot of
intel testing. Compositors just need to fire DPMS themselves.
b) already implemented by systemd
c) systemd has a binary called systemd-sleep[1]. After inactivity,
this script is called and is responsible for implementing the current
suspend target, whether that is sleep, suspend-then-hibernate.

It is currently pretty basic, and only handles one type of wake-up
event. This is the RTC timer/Battery alarm and only if in a
suspend-then-hibernate flow. Everything else is assumed to resume the
system and unfreezes userspace/turns on the displays.

But an initial "dark resume" feature/the sleep notification would go
in that file. For a more complete implementation, more userspace
refactoring would be needed, e.g., a secondary state after systemctl
suspend with some services that can mark to run periodically and are
frozen separately.

[1] https://github.com/systemd/systemd/blob/80cfe9abf267e9e51049e9d6200f02b7922bd4d7/src/sleep/sleep.c

> I'm not sure what the LPS0 _DSM role is in that.

Nothing, these _DSMs just contain vendor code for configuring device
appearance that is out of scope for kernel drivers.

> > It is also a very valid point that this is a _very fine_ line that
> > Windows crossed with its userspace implementation and soured the
> > perception of Modern Standby for a lot of users. Buggy platform
> > firmware/insufficient tooling/control for OEMs, early on also
> > contributed to this.
> >
> > > > >
> > > > > To be precise, that's what MSDN has to say about it:
> > > > >
> > > > > "This _DSM Function will be invoked when the operating system has
> > > > > entered a state where all displays=E2=80=94local and remote, if any==E2=80=94have been
> > > > > turned off. This could occur based on some user action, e.g. a button
> > > > > press or lid close event, or expiration of some display power down
> > > > > timer."
> > > > >
> > > > > The "Intel Low-power S0 Idle" specification
> > > > > (https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle=.pdf)
> > > > > says almost the same thing.
> > > > >
> > > > > None of them says what kind of hint this is to the firmware and what
> > > > > the firmware is expected to do in response to it.
> > > >
> > > > It is true that online documentation does not list the firmware
> > > > response. There is additional documentation that lists the exact entry
> > > > conditions for display on/off [1]
> > > >
> > > > Specifically, while it is a prerequisite of the CRTCs, local/remote,
> > > > being turned off, the actual condition mirrors when userspace would
> > > > present a lockscreen to the user. I.e., if it is due to inactivity,
> > > > those notifications fire 5 seconds after displays turn off, and if it
> > > > is due to explicit action, e.g., power button, it is instant.
> > > >
> > > > "However, the system continues to run and all applications continue t=
> o
> > > > operate normally as if the display was powered on." also implies that
> > > > no hw is powered off as part of this notification.
> > > >
> > > > [1] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/display--sleep--and-hibernate-idle-timers
> > >
> > > Wouldn't just turning the display off be sufficient here?  Why do you
> > > want to go for platform notification in addition to it?
>
> [cut]
>
> > There is a tendency by Microsoft to add OEM tooling that avoids the
> > need for creating platform drivers.
> >
> > This includes the WMI implementation which allows Windows userspace to
> > talk to hardware without having a signed platform driver, and now this
> > standardized set of notifications. Maintaining a signed
> > vulnerability-free driver is expensive.
> >
> > The Display On/Off notifications provide hooks for OEMs to customize
> > the inactive appearance of their device. Mostly, this is through
> > turning off auxiliary lights, such as the keyboard backlight.
> >
> > The sleep notifications provide a way for OEMs to limit the thermal
> > envelope of their machine and make it look like it is asleep, so that
> > it is safe for that device to wake up multiple times per hour,
> > including in a bag, without looking like it is awake.
>
> This is based on a very optimistic assumption that generally cannot be
> verified I'm afraid.
>
> (1) User space must not do anything silly like Bitcoin mining while
> this is done.
> (2) The firmware must not be cheating.
> (3) The GFX driver needs to be able to transition transparently
> between the "displays off" graphics state and the system suspend and
> resume flows.
> (4) The GFX driver activity needs to be coordinated at least somewhat
> with whatever user space entity would be responsible for triggering
> the notifications so they do not get completely out of sync.

1: Currently, it is fine for userspace to wake up and mine bitcoin in
a user's bag. My Nvidia thinkpad does that currently, it wakes up,
fails to hibernate and drains the battery. Sigh. So I am not sure why
in this case the kernel would need to be stricter.

2: Even if it "cheats", or e.g., does nothing, for the sleep state
that would mean an unbound power envelope. If the userspace
implementation is a bit reserved and e.g., handles wake-ups that
should not be a problem. For more advanced use-cases years down the
line perhaps it would be more of a problem.

3: Already done in the kernel side

4: Even if they unsync, I've tested them thoroughly in that state and
I have not found a device that malfunctions yet. So the implementation
of the check could be deferred.

> > Here is an example with how these DSMs would work with thinkpads.
> >
> > Windows does not have a Thinkpad backlight driver. There is auxiliary
> > and optional software, Vantage, which provides some of this. Assume it
> > is not installed. Then, in Linux, assume you disable the thinkpad
> > backlight driver, so upower loses control of the thinkpad keyboard
> > backlight. The thinkpad keyboard backlight is automatically controlled
> > by the EC through keyboard shortcuts. So are the power modes, via Fn+L
> > M H.
> >
> > Then, assume that Linux implements these _DSMs, and hooks them via
> > systemd as following: display on/off is hooked to occur when logind
> > would lock the session, i.e. after 5 seconds of inactivity or pressing
> > the power button. The sleep notifications are triggered by
> > systemd-sleep, before suspend-then-hibernate begins.
> >
> > The end result is that after the display turns off, the keyboard
> > backlight of the device will also turn off automatically without a
> > platform driver. This is true for all modern standby laptops at least
> > post ~2021. A lot of these do not have kernel drivers in linux.
> >
> > Then, if the sleep state is supported (spotty in thinkpads but
> > available in a lot of other hw), when the RTC Wake Alarm/battery alarm
> > wakes the device and systemd briefly checks whether it should
> > hibernate, it will still look like it is asleep, and it will have a
> > reduced power envelope, reducing the risk of overheating if it is in a
> > bag and lowering standby power consumption.
> >
> > I.e., without requiring vendor software, platform drivers, both
> > Windows and Linux present a full feature set out of the box.
>
> I guess it would be rather useful to start the discussion with this
> proposed flow, some time might have been saved by everyone.
>
> IIUC, the point is to make the system look "suspended" if it goes out
> of suspend briefly in response to a wakeup event (the other potential
> "benefits" of what the notifications can possibly do are in the domain
> of marketing IMV), but is it really worth the hassle?

When it comes to the kernel side, I do not think it is much work. The
draft series I had was around 12 kernel patches and could be condensed
a bit.

> Assuming that the answer is "yes", which I'm not convinced about at
> all, can't the kernel simply defer the "screen on" notification to
> some time after thawing user space, so it can avoid doing it and the
> corresponding "screen off" one if the system is suspended again
> quickly enough? Perhaps so long as the GFX driver opts in?

Can't be delayed arbitrarily. Since it controls the suspend
light/keyboard backlight to have correct behavior it needs to fire at
exact moments to look correct. When it comes to resuming through user
input, the faster the better.

> And now we get to the most important thing: even before trying to do
> the above, let alone exposing anything to user space, the existing
> suspend-to-idle flow in the kernel needs to be adjusted to do the
> "screen off" notification much earlier and the "screen off"
> notification much later than they are done today.  I think that you
> should be able to argue convincingly for making this change.
>
> If this doesn't universally work for whatever reason, anything more
> will be out of the question.
>

Yeah, that is a fair way forward. Moving the notifications for
sleep/display on to after userspace freeze, before userspace unfreeze.
Then optionally hooking drm to turn off crtcs before the notifications
(I did not follow the patches for that; it might already be the case).

Antheas


