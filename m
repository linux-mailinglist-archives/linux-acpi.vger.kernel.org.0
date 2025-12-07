Return-Path: <linux-acpi+bounces-19475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2393CAB381
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 11:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 293433003129
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C727E7DA;
	Sun,  7 Dec 2025 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="MYr4Ij4o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFD224D6
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765103703; cv=none; b=Cj+th+yRjq1OckJgkO5KHsCG8ZzM7s1Fz1S7iLaBB13o8EoE2EDDOn3xNNGm0aclb2BVESn7aa+I8rTKuap+g/f5KgVVWVBUtuQi5GxDGrh3CNbwlG2myz2mvrvGFdEjS2eg/pM2M5OLsWdE/JrOrx5EdjCxeDiNyS5A2vWn2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765103703; c=relaxed/simple;
	bh=mgyG1fpaqMqjMtYTE6CAYYckEfJMe+xXDzbqF6w2b7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqCrYRWVuNZ8vzSdUgjHm/qShz21aN9qbbAV5a+HHphpf3cPoZtKcRON//XWY3cjnkDuQfayJDGBvpEiiTHaQAY1UcccG7f2BohShusAFKJUIm0U6RFIjdCKlP73iFhc+snaH2NcTsX4zfiKC9jBSDOq2+opmYKCwAaaDl40e/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=MYr4Ij4o; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 4A92B43DC9
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 10:34:52 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id B950343DD0
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 10:34:50 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CA55B200A55
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 12:34:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1765103690;
	bh=cVsRfrbkWrWZzWtWrdGAsPLanpgkNC/Z6Yej7PPZ2aE=;
	h=Received:From:Subject:To;
	b=MYr4Ij4o6Wdb2VVWEeyAYKojhIvPb2NhFU6LO2Hq6JpMsivXhuYERLqnPmGmMHssq
	 AWEBeFS2VRXefuLa7jNw1/9lvqJHHjjPYxUTLP47il/nz9xSVESR7tMwCIvx6Taw2D
	 LzIakL1Ik++hT613G2ocd2mMdvyNgIv5syYhh89Q6A3IB5daJwZlsebtTQSUZX6wMF
	 6vA/dmljfZ5SQggSD+5Spz0TT88GzsuwAbpEYYab5GCeqhrXkcNVyaUH09qonqWcqm
	 u34dzsAs+xAkuanc9aZq2nq2OazqoWqC1YtlLrjZDW0fpa70ehL/I8/z8UsGN+kVtn
	 cK5bqNzrFz2wA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-37a33b06028so31604221fa.2
        for <linux-acpi@vger.kernel.org>;
 Sun, 07 Dec 2025 02:34:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUmm5iCbDGB+dpkFDXxn9ZJ4MB/8mRbCFw+9Ir1D+Hp6srbFZY94E2Tx/GgTe3lDDgdyELeKGexXdcD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KGa9hydh02zSvsIREqc80GStm6A1QffSbF4OQ9NNduQJbPd9
	4OEoaSvec1Ks/K80XuxKfIH4G03krNHnvgMTjtNLZivWzzZVL2MoYxxOOysIb1RkGXakz8voYlN
	mXKLhULFbEeECtL3sqmm/t/GmijV7UP8=
X-Google-Smtp-Source: 
 AGHT+IFrJ6yPsZgphHuetUZSMTCEXTxI5XtzRplIvOIlz5DM0DpnYqF4WZ8QNFvW4q/jXmgbHOapzbBSj/Bia2QQi24=
X-Received: by 2002:a05:651c:212a:b0:37b:ad8b:7680 with SMTP id
 38308e7fff4ca-37ed1fba423mr13158471fa.9.1765103689145; Sun, 07 Dec 2025
 02:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
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
 <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
 <CAJZ5v0g5dwWSOQCTUFeD+ztFLyYrRR1Z=vt2C+c48SRbaNLJzg@mail.gmail.com>
 <2711fe57-1963-483e-b8fa-0c5ed0bd2ea9@kernel.org>
 <CAGwozwEp3Xc_pv-YGb_Xc46CcLKPppYaZbphV24kiNHM4Eqb-w@mail.gmail.com>
 <edfc3586-84fb-4dee-a047-9f204054e6f2@kernel.org>
In-Reply-To: <edfc3586-84fb-4dee-a047-9f204054e6f2@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 7 Dec 2025 11:34:36 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHUvxSY+qMVzid+0a6CoUZ96Pw1xeKMAem+1o=N23xbqg@mail.gmail.com>
X-Gm-Features: AQt7F2rs0MKc9G60Yyu5Vh3YaojS3NnTZWk5-4eyv4i3Ogyhu2T-VTU4ahpQTLU
Message-ID: 
 <CAGwozwHUvxSY+qMVzid+0a6CoUZ96Pw1xeKMAem+1o=N23xbqg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
X-PPP-Message-ID: 
 <176510369004.3884695.16878602246312218646@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 7 Dec 2025 at 01:31, Mario Limonciello <superm1@kernel.org> wrote:
>
>
>
> On 12/6/25 5:35 PM, Antheas Kapenekakis wrote:
> > On Sat, 6 Dec 2025 at 21:50, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >>>> I will reply to the earlier reply from Rafael with more context, but
> >>>> runtime suspend of the GPU is not part of or related to these
> >>>> notifications.
> >>>
> >>> Of course it isn't.
> >>>
> >>> What we were talking about was how to get from the "displays off, no
> >>> GUI activity" user space smoothly into system suspend and back.
> >>>
> >>> You are saying that this has been done already on AMD, so I'm not sure
> >>> why you want more.
> >>>
> >>
> >> I'm not aware this existing in any unique way for AMD.  The decision of
> >> displays off; start a timer and enter suspend would be the same for any
> >> vendor.
> >
> > AMD retains CRTC DPMS state from userspace to s0ix currently, and you
> > fixed hibernation recently too. Intel sometimes doesn't, the screen
> > will sometimes flash while entering suspend.
>
> I was talking about what Rafael said.  "What we were talking about was
> how to get from the displays off no guid activity user space smoothly
> into system suspend and back".

CRPC DPMS state is the most important user-perceptible factor in that
and it works at least.

> >
> > There is also runtime suspend on most components. Is there a case for
> > powering off the iGPU completely to improve energy use?
> >
>
> I don't really *think& there will be much of a difference.  We already
> go into GFXOFF when GC is idle, and SDMA, VCN, JPEG and VPE will be
> clock gated when not in use.
>
> Someone would have to do power profiling to see if it's significant
> enough difference to justify it.  The easiest way to check would be:
> 1) Turn off all displays
> 2) Connect over SSH
> 3) Collect a RAPL power measurement for the package.
> 4) Unbind the PCI device from amdgpu
> 5) Collect a RAPL power measurement for the package.
> 6) Compare 3 and 5.

Yes. Seems it would add complexity without much benefit from first glance.

> > The most expensive component in this process is unfreezing, then
> > runtime pm freezing the GPU IP blocks after s0ix exit, then unfreezing
> > it two seconds later to perform runtime checks and freezing it again.
> > So for multiple exits from suspend where the IP is inactive this will
> > keep repeating.
>
> I think we would set the auto-suspend delay appropriately if we did this
> and use DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME in this case.
>
> >
> >> But GPUs aren't only used for display.  If you're actively running a
> >> different workload (for example an LLM) using the GPU and happen to turn
> >> off all the displays you wouldn't want it to suspend.
> >>
> >> What you would want is to key off:
> >>
> >> 1) All displays are off.
> >> 2) All GPUs are unsused.
> >> 3) Some time has passed.
> >>
> >> I feel that if userspace is going to adopt a policy like this kernel
> >> drivers need to use runtime PM when displays are off and the GPUs aren't
> >> being used for anything else.
> >>
> >> At least for AMD this doesn't happen today and would require driver
> >> work.  But the same kind of work would be needed by any GPU driver.
> >>
> >
> > You could potentially do that, first you'd need to show that there is
> > a latency benefit to powering off the GPU over entering s0ix (as
> > userspace will be frozen in both cases for the GPU to suspend). Then,
> > you'd need to show that there is an energy benefit over just staying
> > unsuspended with userspace frozen and the GPU being in runtime
> > suspend. WIth both of these, a case could be made for powering off the
> > GPU completely for a marginal latency/energy benefit.
> >
> > These notifications do not affect runtime pm though so this discussion
> > is a bit tangential.
> >
>
> I'm not worried about the latency.  We can change the policy for the
> autosuspend delay if latency is a problem.
>
> If we added runtime suspend support to integrated GPUs this sounds like
> a really good thing to key off for that "display off notification" that
> started this whole thread.
>
> Some infrastructure could be added so DRM core could monitor runtime
> status for all GPUs on the system.  If they're all in runtime PM it
> could use an exported symbol to send LPS0 screen off and when any one of
> them exits then send LPS0 screen on.
>

But that notification is mostly used for the keyboard backlight.
Hooking it to DRM core will just cause unpredictable behavior with the
keyboard backlight (such as it turning off when reconfiguring the
displays). It is very easy to just have a little inactivity ABI for
userspace for it and avoid all of the complexity of that. Such an ABI
is backward compatible, as not using the ABI would produce the same
behavior the kernel has currently.

If not for energy efficiency, I would see a benefit in configuring
DPM_FLAG_* for certain common devices to reduce the latency of the
sleep script for resuming. That would make "dark resume" wake-ups have
less total time-span and power use.

For reducing resume latency, an important factor is for the kernel to
know that a wake-up source will "turn on the displays" where "turn on
the displays" equates to "the user initiated the wake-up and is ready
to interact with the device" and not something obscure related to DRM.
In the same way, the display on/off notifications are not related to
DRM but to whether the user is currently interacting with the device.

This is for two reasons: first, the DPMS delay for turning on a
monitor is 500ms-1s. Second, modern standby provides a firmware
notification to boost the thermal envelope of the device for user
interaction. Currently, if userspace initiates DPMS before suspend,
then the kernel will unsuspend with DPMS applied, leaving it up to
userspace to turn on the monitors. This means that the 500ms-1s delay
of resuming the monitors begins at the point userspace is unfrozen,
where it could begin when amdgpu resumes ~300ms earlier. Then, the
"intent for display to turn on" notification (which is rare-I do not
have a device with it) could marginally speed up kernel resume if it
is applied in lps0 exit, instead of e.g., a "dark resume" userspace
script 300ms later.

So there could be a potential 100ms savings there. But for that to
happen there would need to be some refactorings to classify wake-up
sources in-kernel-a substantial effort. In addition, kernel resume is
pretty light, most CPU use comes from unfreezing the fs and userspace.
Since the bulk of userspace unfreeze is now initiated by systemd, and
prior to initiating it, systemd could trigger the "intent to turn
displays on" notification/DPMS* itself, this would yield most of the
benefit.

I should note that while the "lps0 exit"->"sleep exit"->"display on"
notifications are squished together prior to resume beginning**, the
"intent to turn display on" notification which is meant to fire before
"sleep exit" so that the device looks like it is asleep while having a
boosted thermal envelope is irrelevant. "sleep exit"->"display on"
would first have to be pushed to userspace, so that userspace can wake
up in the "sleep" state, classify the wake-up source as e.g. a wake
rtc or the user interacting with the device, and only if the user is
interacting with it, fire the "intent to turn on display"
notification, unfreeze the rest of userspace, then fire "sleep exit",
"display on" together.

* For systemd to initiate DPMS, the compositor would need to be part
of the initial unfreeze and notified to resume early.

** This squishing together and firing before the kernel resumes is
a source of numerous obscure bugs in MS devices

Antheas


