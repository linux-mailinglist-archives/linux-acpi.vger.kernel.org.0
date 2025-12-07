Return-Path: <linux-acpi+bounces-19477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F04CAB3CF
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B343006633
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2321257A;
	Sun,  7 Dec 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdHfYnfU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7B1922F5
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765106408; cv=none; b=TCPi5MVtXNY1s+N69e5NwQxMidDMn3cPXBIVIa2f3t7ZzcUib5g6/Cr8tsJ42wCXdyH8I6rGj9eED9D49j9ow5CP+6EE4TDU00dlsQxLdcADfp2QtbueMa8tPiOMWHvZsZq/hygO6uhNdjUAouavxySjuKaT8F07bVVWFn6uK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765106408; c=relaxed/simple;
	bh=CeputXGR6kpFtTCXMbxCHITdaZrcQzw77+2KBM88GCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8T7qlFJWe7d1jB+Yvc9BTeiRDnP/I/AG9pww+mpxOcRY0qGi8athhpteNwgDxD3PQtIXdCZkvGn3WwXqAX5BFlmjy3Yjbd/0yh19GATLedeQPUKrvi6hxdP7feVKPn51g4yZ1Zsn0EvnAWugvMP97VUmwfn+aU9LRCpJtq7aUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdHfYnfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B808C116B1
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765106408;
	bh=CeputXGR6kpFtTCXMbxCHITdaZrcQzw77+2KBM88GCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VdHfYnfUv+H8trnyfJQiFdJjtt9BKCD2QeWQWHS+mRzZYqleXNZBmk2M3JwLxlWtj
	 tGr/eAOnNxt6KgGx7IEHp/5xh17e7+nK6BEoLdZFS1aKbWtx1eyCR8CfyT9hnBRqKv
	 a9gHLjPu6gODEPATCT3oE65Isf0spzxWdVJQcc7GcYPnEwLRCUVZp3PoZUSIvrT8xX
	 DVjerlRkfCvjouUj80RwKhmZ/GWRyXcw+0qFjrsNDrEB48t0ZNv7WtuPWqRg9dsdRA
	 VyBAhWwujq8/Iabl5fMOe8lrU6WhjOWlNrH5CFRwtrHas0FMktBKrqwRMg4legB1Dk
	 M+lHyuaYG2p/g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-657490df6f3so1650616eaf.2
        for <linux-acpi@vger.kernel.org>; Sun, 07 Dec 2025 03:20:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV38Oo+OdWC9C9XD4Wt0BCmHp6Z4CBHx6/44Nwz8oorEtrljtjbcpHSHdiL6ZjR448LnCRAFKLphYYi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2sDBHwTqj891CarNdwD4tNgGUvzlq4vv9fbfA4fdv5LOCsRyK
	vyX8nRhxqxDV8KVtL0K//qUGKXJxU67YNllah0h+16AWd2WiAboS1qOGQ4JBmpOpfbuFULRqGl1
	L+21/0HoXvIIjoDvscZzt4OZ4a364ON8=
X-Google-Smtp-Source: AGHT+IHJXgb9xwUGF6qphEfkjdXsu1uRPZttpz8JZbAtUi8D9qkDAMbqoneLkSgMo2O5RlA0EZMXddR1wR3+2lMSn2Q=
X-Received: by 2002:a05:6820:f033:b0:659:9a49:8fff with SMTP id
 006d021491bc7-6599a9648b6mr2233757eaf.44.1765106407668; Sun, 07 Dec 2025
 03:20:07 -0800 (PST)
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
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
 <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com> <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
In-Reply-To: <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 7 Dec 2025 12:19:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j3wNtqYQDsVr+74-Gn-WM9FDmoqxrLULVD+UJtfVgLtQ@mail.gmail.com>
X-Gm-Features: AQt7F2pFAOX76m5yi0BCeGRBHKi4QUqXigfzDPisUV-NFtMvif92Ad_gfoFZifU
Message-ID: <CAJZ5v0j3wNtqYQDsVr+74-Gn-WM9FDmoqxrLULVD+UJtfVgLtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Mario Limonciello <superm1@kernel.org>, 
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org, 
	kernel@collabora.com, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 12:06=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> GMail did something silly to my reply to this message, so resending it
> in case it didn't make it to the lists.  Sorry for duplicates.
>
> On Fri, Dec 5, 2025 at 11:52=3DE2=3D80=3DAFPM Antheas Kapenekakis
> <lkml@antheas.dev> wrote:
> >
> > On Fri, 5 Dec 2025 at 17:32, Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
> > >
> > > On Thu, Dec 4, 2025 at 7:31=3DE2=3D80=3DAFPM Antheas Kapenekakis <lkm=
l@antheas.dev> wrote:
> > > >
> > > > On Thu, 4 Dec 2025 at 17:41, Rafael J. Wysocki <rafael@kernel.org> =
wrote:
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
> That's what Android phones/tablets do, but that's a vertical software sta=
ck.
>
> To implement something like this you need (a) support from the GFX driver
> in the kernel to go into system suspend back and forth without turning
> displays on and off, and (b) a mechanism to trigger system suspend
> automatically after a period of inactivity while in the "displays off, no
> GUI activity" state, and (c) support for system wakeup events in (b).
>
> I'm not sure what the LPS0 _DSM role is in that.
>
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
> > > > > entered a state where all displays=3DE2=3D80=3D94local and remote=
, if any=3D=3DE2=3D80=3D94have been
> > > > > turned off. This could occur based on some user action, e.g. a bu=
tton
> > > > > press or lid close event, or expiration of some display power dow=
n
> > > > > timer."
> > > > >
> > > > > The "Intel Low-power S0 Idle" specification
> > > > > (https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Po=
wer_S0_Idle=3D.pdf)
> > > > > says almost the same thing.
> > > > >
> > > > > None of them says what kind of hint this is to the firmware and w=
hat
> > > > > the firmware is expected to do in response to it.
> > > >
> > > > It is true that online documentation does not list the firmware
> > > > response. There is additional documentation that lists the exact en=
try
> > > > conditions for display on/off [1]
> > > >
> > > > Specifically, while it is a prerequisite of the CRTCs, local/remote=
,
> > > > being turned off, the actual condition mirrors when userspace would
> > > > present a lockscreen to the user. I.e., if it is due to inactivity,
> > > > those notifications fire 5 seconds after displays turn off, and if =
it
> > > > is due to explicit action, e.g., power button, it is instant.
> > > >
> > > > "However, the system continues to run and all applications continue=
 t=3D
> o
> > > > operate normally as if the display was powered on." also implies th=
at
> > > > no hw is powered off as part of this notification.
> > > >
> > > > [1] https://learn.microsoft.com/en-us/windows-hardware/design/devic=
e-experiences/display--sleep--and-hibernate-idle-timers
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
>
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
>
> Assuming that the answer is "yes", which I'm not convinced about at
> all, can't the kernel simply defer the "screen on" notification to
> some time after thawing user space, so it can avoid doing it and the
> corresponding "screen off" one if the system is suspended again
> quickly enough? Perhaps so long as the GFX driver opts in?
>
> And now we get to the most important thing: even before trying to do
> the above, let alone exposing anything to user space, the existing
> suspend-to-idle flow in the kernel needs to be adjusted to do the
> "screen off" notification much earlier and the "screen off"

The second one obviously should be "screen on", sorry for the typo.

> notification much later than they are done today.  I think that you
> should be able to argue convincingly for making this change.
>
> If this doesn't universally work for whatever reason, anything more
> will be out of the question.

So let me repeat for extra clarity.

The only change related to the LPS0 "screen off" and "screen on"
notifications that would be tentatively acceptable to me ATM, would be
to modify the suspend-to-idle flow to do the "screen off" notification
earlier (possibly even at the start of it) and the corresponding
"screen on" notification later (possibly at the end of it), provided
that one can convincingly argue that this should not introduce
regressions.

