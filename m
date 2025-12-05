Return-Path: <linux-acpi+bounces-19460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABDCA96E4
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 22:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF633080AD1
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 21:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A32848BB;
	Fri,  5 Dec 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CAkob2Ot"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE559277819
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764971565; cv=none; b=iJOyD0+TAgb81ZcQynIj8JqZXWQu2kLWSHPwwNUNYKKcnluA3nZd1qLXu9yovaCcRDFILtoDjXgyD+vgj9ipzh2zsXOCi3Bpnb9OvZX1kjeUegQtEj5VXq4GhVrwks0/ScXpMi1amSA2dmWtOVHHXE+ww92haFsDpIz+FDp3cyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764971565; c=relaxed/simple;
	bh=Gy8kXlMlJaAj9c2W6E2mo4ewEICl0PI32BqdFbVHrPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWSMuFwaQxQ9t94+Lcc6in265DAPfpNZNrwdKRU3wkVtLfrCE8+xa6Gj3wV2OIulb5EX3smxl4ZckrLuKeLDke30iv/HZ8Jat2Qr6+mBj6NYQwo8InDQbDY1UiPHz8sxUIuGF09K2lTpIbuLxejf31D9HFMW4xIJPzuSd6mUhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CAkob2Ot; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 9FA8941D10
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 23:52:34 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 9A5B541D24
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 23:52:33 +0200 (EET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 7CC801FFF00
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 23:52:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1764971552;
	bh=3UAowdJhz6D1DELEqX2ykhk5IO1dnEu9/WfYQBTzn3Q=;
	h=Received:From:Subject:To;
	b=CAkob2OtfN8vIklGhHpmvnd9K69qe9aTV1REo5wwZtXvRGkANNzRfax2IKbXM60ev
	 aLgfjg0fgNihwMFPQZuMwQDIaUj8Ijrl5SoG0ah9wDfsESJOYZoxaS8mgcD0fY8XB4
	 QTNiI8IGEzIwxIfB0TELBm0nIw84JMTk1bIIt3QOc4prrgctQ/WnTvhC9d3PBXDXf0
	 1TGsT3AjdjCC+Zr86eV/Uael9qsDiW/OHAUz91wltQYp5wtrdCMx6xvJW+jHmuF+Jc
	 gptukSVZAVr3HvkfN92UUZ0i+VWNKUBAFWXslu+II/1tWm6W4o6a5KLer81tSItj9q
	 3GPMr5hsdTdYw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-37bac34346dso18066301fa.2
        for <linux-acpi@vger.kernel.org>;
 Fri, 05 Dec 2025 13:52:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVFe2puHF5zihCn8ApWBjaxCJZrUflJXQhXGeXyYjdKiZv6871olRGi6r8rCqoselrOXauOWFPYwFmy@vger.kernel.org
X-Gm-Message-State: AOJu0YyEis9u+o6Qu4AqRrRQOgYw3GimRK1v5O2r0g/AthPtQeDVX2Ym
	1KKv0Ipu2SSxAvdqxreNfkCI96037LZPlk3PhI900Z8uX2uSqPFp4tiUy0A+6GsjHoxIWUm2Pf2
	bH/3PAXMNppNX8JNetTXKd/JbcNWohDY=
X-Google-Smtp-Source: 
 AGHT+IGv+mOn61SuwyDf63TJcNGa2/QoVmGvyUOAnKBMsJNjfBnA0HksUK2DWtEpBRxNypZLRJdFpdQJsmNdMAGVY/c=
X-Received: by 2002:a05:651c:2223:b0:36b:3a21:9c04 with SMTP id
 38308e7fff4ca-37ed83c38d1mr1789651fa.36.1764971551966; Fri, 05 Dec 2025
 13:52:31 -0800 (PST)
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
 <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org>
 <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
 <411ea5f1-7cc7-4a2e-99b4-2891f3aa344e@kernel.org>
 <CAJZ5v0hQMGarx96oU-OHXh8665FJ2UP4dJpVKoxCgdyi8fZ1QA@mail.gmail.com>
 <6d7b916a-8c37-499a-84a6-5facbe0e3bd4@kernel.org>
 <CAJZ5v0jqdQw57t7Moj4o2eWt54t1wBvn8_0N9L-orn_JzFGWyw@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0jqdQw57t7Moj4o2eWt54t1wBvn8_0N9L-orn_JzFGWyw@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 5 Dec 2025 22:52:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
X-Gm-Features: AQt7F2r-5RHO_GkdaD6U2JOuJlALmfz1LAKY1-obKC5J9hba48yhViZDyK2YIdw
Message-ID: 
 <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
 <176497155274.112359.16671564883728146892@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 5 Dec 2025 at 21:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Dec 5, 2025 at 8:42=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
> >
> > On 12/5/25 1:37 PM, Rafael J. Wysocki wrote:
> > > On Fri, Dec 5, 2025 at 7:07=E2=80=AFPM Mario Limonciello <superm1@ker=
nel.org> wrote:
> > >>
> > >> On 12/5/25 11:22 AM, Rafael J. Wysocki wrote:
> > >>> On Fri, Dec 5, 2025 at 5:47=E2=80=AFPM Mario Limonciello (AMD) (ker=
nel.org)
> > >>> <superm1@kernel.org> wrote:
> > >>>>
> > >>>>> I would start with the graphics stacks and teach them to
> > >>>>> runtime-suspend the HW when the displays go off.  No firmware
> > >>>>> notifications are needed for this to work.
> > >>>>
> > >>>> Well the problem with this is there is a sizable latency to runtim=
e
> > >>>> suspend hardware when displays go off.  For example you would need=
 to
> > >>>> redo link training when you spin the hardware back up.
> > >>>>
> > >>>> What we do today (AMD *dGPU* centric) is runtime suspend the hardw=
are
> > >>>> when no displays are connected and nothing else is using the GPU (=
for
> > >>>> offload purposes).
> > >>>
> > >>> The latency problem can be addressed by using autosuspend instead o=
f
> > >>> synchronous suspend.  Just set the autosuspend timer when displays =
go
> > >>> off.
> > >>
> > >> Sorry I probably confused the problem by saying latency to suspend t=
he
> > >> hardware.  That doesn't matter.  It's a problem of latency when they
> > >> *come back up*.  Let me give a hypothetical that will demonstrate.
> > >>
> > >> Let's say I have the following:
> > >> * Desktop with a dGPU connected to it.
> > >> * My DE has a setting for compositor to blank the monitor after 5 mi=
nutes.
> > >> * My DE has a setting to starting system suspend after 10 minutes.
> > >> * You set up auto-suspend on the dGPU for 15 seconds.
> > >> * No non-display work running.
> > >>
> > >> You walk away for 6 minutes.  The dGPU will have entered runtime PM =
from
> > >> the auto-suspend.  You come back to the machine and you wiggle the
> > >> mouse.  Because the dGPU was auto-suspended you gotta wait for it to
> > >> spin back up, you have to wait for link training again etc.
> > >
> > > Yes.
> > >
> > >> This is pretty much the same that would have happened if you walked =
away
> > >> for 10 minutes now!  Your "5 minute blank monitor" turned into "5 mi=
nute
> > >> turn off dGPU".
> > >
> > > Well, the wakeup latency is the cost of saving energy.
> > >
> > >>>
> > >>>> On AMD APU we don't use runtime suspend.  If you ignore the latenc=
y I
> > >>>> could see an argument for proxying the status of displays to indic=
ate
> > >>>> runtime suspended, but I don't know what it really buys you.
> > >>>
> > >>> Well, the lack of runtime PM is a problem and I don't see how it ca=
n
> > >>> be overcome easily.
> > >>>
> > >>> The main issue is that when the system is resuming and there is no
> > >>> runtime PM support, the device in question must be powered up durin=
g
> > >>> the system resume flow.
> > >>
> > >> I don't think this is actually a problem.  The reason is in my below
> > >> comment.
> > >>
> > >>>
> > >>>>> Then, I would teach
> > >>>>> graphics drivers to leave the devices in runtime-suspend if they =
are
> > >>>>> runtime-suspended when system suspend starts and to leave them in
> > >>>>> runtime-suspend throughout the system suspend and resume, so they=
 are
> > >>>>> still runtime-suspended whey system resume is complete.  I'm not =
sure
> > >>>>> how far away graphics stacks are from this, but at least some of =
them
> > >>>>> support runtime PM, so maybe the fruits don't hang very high.  Wi=
th
> > >>>>> that, you'd just need a way to trigger a system suspend after a p=
eriod
> > >>>>> of inactivity when the displays are off and you have your "dark m=
ode".
> > >>>>
> > >>>> I think even without kernel changes this can be accomplished today=
 with
> > >>>> userspace.
> > >>>>
> > >>>> There will be change events when the displays are turned off and y=
ou can
> > >>>> listen to and set a timer to enter system suspend based upon how l=
ong
> > >>>> they are off.
> > >>>
> > >>> True, but that's just about suspending.  To avoid powering up devic=
es
> > >>> on the way back from system suspend, runtime PM support and
> > >>> integration of it with system suspend-resume is necessary.
> > >>
> > >> Yes and no.  For most device types I would agree; but the compositor
> > >> controls DPMS on each CRTC which impacts whether anything is display=
ed.
> > >>
> > >> If the compositor chooses to turn off the displays the GPU hardware =
will
> > >> remain active but display IP will be off or in a low power state.  T=
his
> > >> will still have significant power savings by the displays being off.
> > >
> > > OK, so you basically want the GPU to avoid turning displays on during
> > > resume from system suspend if they were off before the suspend
> > > transition has started.

This is already the case for AMD. For Intel, it's more complicated...

But it is true that it should be handled kernel side. I also think
that it was fixed for hibernation, again for AMD, already.

> > > This still needs to be handled by the GPU
> > > driver in the kernel IIUC.
> >
> > Yes.  To be clear (in case you didn't see from my comments in this
> > thread) I'm not a fan of this being a userspace interface to the LPS0
> > screen off.
>
> So we agree here, good.
>
> > I feel if this state is to exist in the Linux state machine this should
> > be DRM core entering it when displays are off.
>
> Something like that.
>

Why should unplugging the HDMI cable from my desktop or changing
display configuration cause the case RGB/keyboard backlight to turn
off?

I will reply to the earlier reply from Rafael with more context, but
runtime suspend of the GPU is not part of or related to these
notifications.

CRPC DPMS latency is higher when initiated by userspace instead of the
early resume hooks of the kernel and adds wake-up latency. Not being
able to fire the intent to turn display on notification as part of
early resume to boost the thermal envelope also adds latency. Both of
these issues, while not related to this series, are a valid tangential
discussion and center around the fact that the kernel cannot classify
certain wake-up sources as being able to turn on the display
currently, so it can make a judgement call itself.

Antheas


