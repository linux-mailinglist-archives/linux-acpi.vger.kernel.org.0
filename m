Return-Path: <linux-acpi+bounces-19464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99CDCAA89A
	for <lists+linux-acpi@lfdr.de>; Sat, 06 Dec 2025 15:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78CAB302A39C
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Dec 2025 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4222FE07F;
	Sat,  6 Dec 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKx+tsCy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606D221710
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765031712; cv=none; b=cZJ2g6IMwa4BiidqWGOgXliHu2hZbRIdDl5tKMJQyZNW91f9MyGKGftDAA9hTRj+BsXnhs7DcVGOstCGnyKy6ASWI/J2AdErEnr8aVglTf+LjCkuaxgqorS19oIcXPRP6M8NVFSGt8sci8MdNJamtlmV8IjlE3lSdR4N6gVFVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765031712; c=relaxed/simple;
	bh=4HYSN/+VGNmkQRcC/RCstWXJraB8VvD0vo1DkwcCj6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpeW5M6bdFdgLQVhKmdSTE5blm5X43PUYvAe5mdFkHWmsVmf7O/so4EOr86IN57+KEoDElZQ/nlv6vNsZDSaxSpzaimRGOVmaRqy5vaJMMQ565j0ATYI2+Vul/IB4RsGU3+W0hW4DFCfkr65TZV2FtAiRM+6LCG/X+j+YHmZtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKx+tsCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C1C19421
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765031711;
	bh=4HYSN/+VGNmkQRcC/RCstWXJraB8VvD0vo1DkwcCj6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iKx+tsCyFsMVeeCZusSd9uxRIxk+9KgtxWNkGYDfFkagq2JG3uNFsKbaOZv4KitWe
	 Fxg0msd9uupLAMc5G6D40IHwAq0tP2J9KncPxfIITMEzbnWQYPgHFx+IF8cWGjjKsY
	 9A/2BNDvfMH2OAzxrNzz2jrZzKITrfk6qDDPJi4uMyMoVFQPDtzyfeGyTR1QF2U8ps
	 C4iPZ8dQJ4kCG4wjnAK6uZ1CbEDpv9165QWpmsSWU+sn50AtQwRlRGITweDrFGCcDR
	 42XwoPqR/mYsS3Ln+JB04K0zqkzmipnYGS4N0QEdtT6mMbqCc9bncv4vlorWE8bNGt
	 umtReBwViVnOw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-657c68a08a7so1579622eaf.1
        for <linux-acpi@vger.kernel.org>; Sat, 06 Dec 2025 06:35:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXErqm0Icv6DwXh2NQ8S7ZwSQXIqQ6ONpm8K7zAIwGT5QUKgNYntuoZA5+d9IlaASXjbvPpa0wuppzN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94ayJUZ/567JTTfT0YI+DOUVhRxbOQMx7mURlIezq41o7OWAo
	M7bSothbcjsar0GNAqJZvpLXeVz7y0iBC4ZBccXyDwk1q4hhFB+q/5stjwmw64pOtGiysESUtaU
	+XFQFXpb/rDahNcRNLoypKfmIYe7ScDs=
X-Google-Smtp-Source: AGHT+IGW6/dcOZO+x0lYstd8EBjGFaCeOA/bEpPprFoHzT7JTEIRHjGj+J4VdqadeWewE9Fh5NFDTXQrznrSYo7R7SQ=
X-Received: by 2002:a05:6820:2201:b0:659:9a49:8f4b with SMTP id
 006d021491bc7-6599a8c3c15mr1135282eaf.16.1765031710983; Sat, 06 Dec 2025
 06:35:10 -0800 (PST)
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
 <411ea5f1-7cc7-4a2e-99b4-2891f3aa344e@kernel.org> <CAJZ5v0hQMGarx96oU-OHXh8665FJ2UP4dJpVKoxCgdyi8fZ1QA@mail.gmail.com>
 <6d7b916a-8c37-499a-84a6-5facbe0e3bd4@kernel.org> <CAJZ5v0jqdQw57t7Moj4o2eWt54t1wBvn8_0N9L-orn_JzFGWyw@mail.gmail.com>
 <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
In-Reply-To: <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 6 Dec 2025 15:34:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g5dwWSOQCTUFeD+ztFLyYrRR1Z=vt2C+c48SRbaNLJzg@mail.gmail.com>
X-Gm-Features: AQt7F2r6ABmhXXqtJdHA8KflEKu5Ef4Yxr6Z-FtqmXHFpEGLwmT4cF94y8dhb2Y
Message-ID: <CAJZ5v0g5dwWSOQCTUFeD+ztFLyYrRR1Z=vt2C+c48SRbaNLJzg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
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

On Fri, Dec 5, 2025 at 10:52=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> On Fri, 5 Dec 2025 at 21:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Dec 5, 2025 at 8:42=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> > >
> > > On 12/5/25 1:37 PM, Rafael J. Wysocki wrote:
> > > > On Fri, Dec 5, 2025 at 7:07=E2=80=AFPM Mario Limonciello <superm1@k=
ernel.org> wrote:
> > > >>
> > > >> On 12/5/25 11:22 AM, Rafael J. Wysocki wrote:
> > > >>> On Fri, Dec 5, 2025 at 5:47=E2=80=AFPM Mario Limonciello (AMD) (k=
ernel.org)
> > > >>> <superm1@kernel.org> wrote:
> > > >>>>
> > > >>>>> I would start with the graphics stacks and teach them to
> > > >>>>> runtime-suspend the HW when the displays go off.  No firmware
> > > >>>>> notifications are needed for this to work.
> > > >>>>
> > > >>>> Well the problem with this is there is a sizable latency to runt=
ime
> > > >>>> suspend hardware when displays go off.  For example you would ne=
ed to
> > > >>>> redo link training when you spin the hardware back up.
> > > >>>>
> > > >>>> What we do today (AMD *dGPU* centric) is runtime suspend the har=
dware
> > > >>>> when no displays are connected and nothing else is using the GPU=
 (for
> > > >>>> offload purposes).
> > > >>>
> > > >>> The latency problem can be addressed by using autosuspend instead=
 of
> > > >>> synchronous suspend.  Just set the autosuspend timer when display=
s go
> > > >>> off.
> > > >>
> > > >> Sorry I probably confused the problem by saying latency to suspend=
 the
> > > >> hardware.  That doesn't matter.  It's a problem of latency when th=
ey
> > > >> *come back up*.  Let me give a hypothetical that will demonstrate.
> > > >>
> > > >> Let's say I have the following:
> > > >> * Desktop with a dGPU connected to it.
> > > >> * My DE has a setting for compositor to blank the monitor after 5 =
minutes.
> > > >> * My DE has a setting to starting system suspend after 10 minutes.
> > > >> * You set up auto-suspend on the dGPU for 15 seconds.
> > > >> * No non-display work running.
> > > >>
> > > >> You walk away for 6 minutes.  The dGPU will have entered runtime P=
M from
> > > >> the auto-suspend.  You come back to the machine and you wiggle the
> > > >> mouse.  Because the dGPU was auto-suspended you gotta wait for it =
to
> > > >> spin back up, you have to wait for link training again etc.
> > > >
> > > > Yes.
> > > >
> > > >> This is pretty much the same that would have happened if you walke=
d away
> > > >> for 10 minutes now!  Your "5 minute blank monitor" turned into "5 =
minute
> > > >> turn off dGPU".
> > > >
> > > > Well, the wakeup latency is the cost of saving energy.
> > > >
> > > >>>
> > > >>>> On AMD APU we don't use runtime suspend.  If you ignore the late=
ncy I
> > > >>>> could see an argument for proxying the status of displays to ind=
icate
> > > >>>> runtime suspended, but I don't know what it really buys you.
> > > >>>
> > > >>> Well, the lack of runtime PM is a problem and I don't see how it =
can
> > > >>> be overcome easily.
> > > >>>
> > > >>> The main issue is that when the system is resuming and there is n=
o
> > > >>> runtime PM support, the device in question must be powered up dur=
ing
> > > >>> the system resume flow.
> > > >>
> > > >> I don't think this is actually a problem.  The reason is in my bel=
ow
> > > >> comment.
> > > >>
> > > >>>
> > > >>>>> Then, I would teach
> > > >>>>> graphics drivers to leave the devices in runtime-suspend if the=
y are
> > > >>>>> runtime-suspended when system suspend starts and to leave them =
in
> > > >>>>> runtime-suspend throughout the system suspend and resume, so th=
ey are
> > > >>>>> still runtime-suspended whey system resume is complete.  I'm no=
t sure
> > > >>>>> how far away graphics stacks are from this, but at least some o=
f them
> > > >>>>> support runtime PM, so maybe the fruits don't hang very high.  =
With
> > > >>>>> that, you'd just need a way to trigger a system suspend after a=
 period
> > > >>>>> of inactivity when the displays are off and you have your "dark=
 mode".
> > > >>>>
> > > >>>> I think even without kernel changes this can be accomplished tod=
ay with
> > > >>>> userspace.
> > > >>>>
> > > >>>> There will be change events when the displays are turned off and=
 you can
> > > >>>> listen to and set a timer to enter system suspend based upon how=
 long
> > > >>>> they are off.
> > > >>>
> > > >>> True, but that's just about suspending.  To avoid powering up dev=
ices
> > > >>> on the way back from system suspend, runtime PM support and
> > > >>> integration of it with system suspend-resume is necessary.
> > > >>
> > > >> Yes and no.  For most device types I would agree; but the composit=
or
> > > >> controls DPMS on each CRTC which impacts whether anything is displ=
ayed.
> > > >>
> > > >> If the compositor chooses to turn off the displays the GPU hardwar=
e will
> > > >> remain active but display IP will be off or in a low power state. =
 This
> > > >> will still have significant power savings by the displays being of=
f.
> > > >
> > > > OK, so you basically want the GPU to avoid turning displays on duri=
ng
> > > > resume from system suspend if they were off before the suspend
> > > > transition has started.
>
> This is already the case for AMD. For Intel, it's more complicated...
>
> But it is true that it should be handled kernel side. I also think
> that it was fixed for hibernation, again for AMD, already.
>
> > > > This still needs to be handled by the GPU
> > > > driver in the kernel IIUC.
> > >
> > > Yes.  To be clear (in case you didn't see from my comments in this
> > > thread) I'm not a fan of this being a userspace interface to the LPS0
> > > screen off.
> >
> > So we agree here, good.
> >
> > > I feel if this state is to exist in the Linux state machine this shou=
ld
> > > be DRM core entering it when displays are off.
> >
> > Something like that.
> >
>
> Why should unplugging the HDMI cable from my desktop or changing
> display configuration cause the case RGB/keyboard backlight to turn
> off?

I'm not sure what you are talking about here, sorry.

We clearly are not on the same page with this and you need to get
everyone on the same page if you want this to get anywhere.  As I said
before, as it stands today, it's going nowhere.

> I will reply to the earlier reply from Rafael with more context, but
> runtime suspend of the GPU is not part of or related to these
> notifications.

Of course it isn't.

What we were talking about was how to get from the "displays off, no
GUI activity" user space smoothly into system suspend and back.

You are saying that this has been done already on AMD, so I'm not sure
why you want more.

> CRPC DPMS latency is higher when initiated by userspace instead of the
> early resume hooks of the kernel and adds wake-up latency. Not being
> able to fire the intent to turn display on notification as part of
> early resume to boost the thermal envelope also adds latency. Both of
> these issues, while not related to this series, are a valid tangential
> discussion and center around the fact that the kernel cannot classify
> certain wake-up sources as being able to turn on the display
> currently, so it can make a judgement call itself.

The last paragraph doesn't add anything useful IMV.

