Return-Path: <linux-acpi+bounces-19453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 783ACCA9168
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 20:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 957B93009B54
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C931AAB9;
	Fri,  5 Dec 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogls52x4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23331AA9C
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963434; cv=none; b=WwNkq5XexN8w9XlkpTcpMEbSAG3rV2Q2M9CRDb+2ndL7T+vK30mjXRxAV9c+XgJoj+e2/ryA/oRW0uAtRYUGpDA5LKcX/Dn5vJXLZp6AjlkntrHLSqLcB3n4p0ewf1F7MN0FxkLttDkl/j8aVI7HCRQ9+6KppqIVXy+Yn1GLIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963434; c=relaxed/simple;
	bh=2Ytsjk11x96GPAln39gS+7c8dY8JbpbkwQJkutvez/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scR9B4h+0tEMWKTdeBmejQwN7TJOgXvn4vLAyPosa6c3geyLwWPFsE4A4rJjRbD8ZtEcW+ti5UIFc5r2wauAOAWuBAO4vbi3XWlXZqcWJlkH8wRfhJ6owbuEO1Eccs80920i8AKD6JPzXgvwUtqbwqmIwZ9DVt78JVcHEG3n2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogls52x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDCAC2BC87
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 19:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764963434;
	bh=2Ytsjk11x96GPAln39gS+7c8dY8JbpbkwQJkutvez/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ogls52x4zTlUbk4iCVUYasN1hW7/qSWj7Fj9n+uShkN0qjlEgvHoP2pXVK9pPEKjS
	 Ma1QtqZLV86cVxL0eG8FkCu9EkEJPyye1pVK0dIlQm2PZoFoR5VLSLc49BNOglnBXn
	 4zwa1JvozLNPcVfnDRQ/UUeOPuy1zJXSCZfZv5UxZX2CoYgIOwcmnVOzMsatXjt8YG
	 VGutKqTIH/EcSLZku1gAkyJZb7quGBKM+v5qnPA/AvgNPLqU2idTclEFDvYTH+77Z6
	 ng5ctCo8KfIWNFVYr4vbM3pE4FZRpwNvU6qCia/N5VUtCn/WjfYRurZrazS88rd1af
	 y6Dlm0QhNRRQA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e80c483a13so1984722fac.2
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 11:37:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxv2rKRBUptjnpYi+HKvO5idZSUOVjlqbpl+YdV90x0+ouQqs4pRzwk8nqNXmBdHVx5NnUyKS0TKFG@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEZUK1QP0jAj+DDil5mSMCDLWE0VxlO+hdnbxg+z0gLaY49AK
	QXZL0K7HkR8X73SOooD50QDk6Vesa47Ov4GOo4Nd2lFgiLXgMh5b+hUZvEjhvREVEtF1772DCrC
	clupV46PsXWMKQoCUkvYogcD8Pm8xV2Q=
X-Google-Smtp-Source: AGHT+IF7mn7zE/nwInSrxE8KmIbM6pSPPIxBFZ9gGZUsQq9yc+VWYBQw805uNRvYx1XunyiVpOrqjB0aXw2W1lzUoGc=
X-Received: by 2002:a05:6820:61c:b0:659:9a49:8e45 with SMTP id
 006d021491bc7-6599a8c4386mr161621eaf.21.1764963433352; Fri, 05 Dec 2025
 11:37:13 -0800 (PST)
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
 <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org> <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
 <411ea5f1-7cc7-4a2e-99b4-2891f3aa344e@kernel.org>
In-Reply-To: <411ea5f1-7cc7-4a2e-99b4-2891f3aa344e@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Dec 2025 20:37:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hQMGarx96oU-OHXh8665FJ2UP4dJpVKoxCgdyi8fZ1QA@mail.gmail.com>
X-Gm-Features: AWmQ_bm_HUQmG6oGj4RvoG9ZUV10mMXK534cgfN0AKeUIkhPqg_ZZpbLUz28QME
Message-ID: <CAJZ5v0hQMGarx96oU-OHXh8665FJ2UP4dJpVKoxCgdyi8fZ1QA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Antheas Kapenekakis <lkml@antheas.dev>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Robert Beckett <bob.beckett@collabora.com>, 
	linux-acpi@vger.kernel.org, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:07=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 12/5/25 11:22 AM, Rafael J. Wysocki wrote:
> > On Fri, Dec 5, 2025 at 5:47=E2=80=AFPM Mario Limonciello (AMD) (kernel.=
org)
> > <superm1@kernel.org> wrote:
> >>
> >>> I would start with the graphics stacks and teach them to
> >>> runtime-suspend the HW when the displays go off.  No firmware
> >>> notifications are needed for this to work.
> >>
> >> Well the problem with this is there is a sizable latency to runtime
> >> suspend hardware when displays go off.  For example you would need to
> >> redo link training when you spin the hardware back up.
> >>
> >> What we do today (AMD *dGPU* centric) is runtime suspend the hardware
> >> when no displays are connected and nothing else is using the GPU (for
> >> offload purposes).
> >
> > The latency problem can be addressed by using autosuspend instead of
> > synchronous suspend.  Just set the autosuspend timer when displays go
> > off.
>
> Sorry I probably confused the problem by saying latency to suspend the
> hardware.  That doesn't matter.  It's a problem of latency when they
> *come back up*.  Let me give a hypothetical that will demonstrate.
>
> Let's say I have the following:
> * Desktop with a dGPU connected to it.
> * My DE has a setting for compositor to blank the monitor after 5 minutes=
.
> * My DE has a setting to starting system suspend after 10 minutes.
> * You set up auto-suspend on the dGPU for 15 seconds.
> * No non-display work running.
>
> You walk away for 6 minutes.  The dGPU will have entered runtime PM from
> the auto-suspend.  You come back to the machine and you wiggle the
> mouse.  Because the dGPU was auto-suspended you gotta wait for it to
> spin back up, you have to wait for link training again etc.

Yes.

> This is pretty much the same that would have happened if you walked away
> for 10 minutes now!  Your "5 minute blank monitor" turned into "5 minute
> turn off dGPU".

Well, the wakeup latency is the cost of saving energy.

> >
> >> On AMD APU we don't use runtime suspend.  If you ignore the latency I
> >> could see an argument for proxying the status of displays to indicate
> >> runtime suspended, but I don't know what it really buys you.
> >
> > Well, the lack of runtime PM is a problem and I don't see how it can
> > be overcome easily.
> >
> > The main issue is that when the system is resuming and there is no
> > runtime PM support, the device in question must be powered up during
> > the system resume flow.
>
> I don't think this is actually a problem.  The reason is in my below
> comment.
>
> >
> >>> Then, I would teach
> >>> graphics drivers to leave the devices in runtime-suspend if they are
> >>> runtime-suspended when system suspend starts and to leave them in
> >>> runtime-suspend throughout the system suspend and resume, so they are
> >>> still runtime-suspended whey system resume is complete.  I'm not sure
> >>> how far away graphics stacks are from this, but at least some of them
> >>> support runtime PM, so maybe the fruits don't hang very high.  With
> >>> that, you'd just need a way to trigger a system suspend after a perio=
d
> >>> of inactivity when the displays are off and you have your "dark mode"=
.
> >>
> >> I think even without kernel changes this can be accomplished today wit=
h
> >> userspace.
> >>
> >> There will be change events when the displays are turned off and you c=
an
> >> listen to and set a timer to enter system suspend based upon how long
> >> they are off.
> >
> > True, but that's just about suspending.  To avoid powering up devices
> > on the way back from system suspend, runtime PM support and
> > integration of it with system suspend-resume is necessary.
>
> Yes and no.  For most device types I would agree; but the compositor
> controls DPMS on each CRTC which impacts whether anything is displayed.
>
> If the compositor chooses to turn off the displays the GPU hardware will
> remain active but display IP will be off or in a low power state.  This
> will still have significant power savings by the displays being off.

OK, so you basically want the GPU to avoid turning displays on during
resume from system suspend if they were off before the suspend
transition has started.  This still needs to be handled by the GPU
driver in the kernel IIUC.

