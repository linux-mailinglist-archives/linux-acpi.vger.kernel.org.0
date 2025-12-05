Return-Path: <linux-acpi+bounces-19457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA8CA933C
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 21:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40827303BE3C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247CF2E8882;
	Fri,  5 Dec 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grhs+k56"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B92D7812
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965176; cv=none; b=VrRC7xyNSuyCRWkG0XQnVUO47yxD6ZmST1ZdKHzBlI+T1AOtpLE0awtcGbbvoPY1vxPaxFw4lK1uca7E6cNu6GeQry9aULAMcWb+CoMzbmiOAA2/QCKV6YwovEfjDsIkyPFFxED+1YHipPCzEuAyi/dk4h3S2Ebp6wVtqcpb3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965176; c=relaxed/simple;
	bh=EmVlpXTxgjA8gZhrQvvxERhpHk9cKXuDAgOLOQ08nq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBCiaENKVWC3FdN0Bfh7s6Exf2mf4Qe1q6Jpqqp/GSKzhbVnvfXPagiuAbE120YjN1tqb4MKNP6L1o3niTuPnas41S+GfPWMtPyNT9Q2+72e3YeG6Nxjx/jHoYUZCz/foMAtYqMHM2swqrxs3oIvL30fN96TqSoyYf8jxH4cvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grhs+k56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA8EC4AF0D
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 20:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764965175;
	bh=EmVlpXTxgjA8gZhrQvvxERhpHk9cKXuDAgOLOQ08nq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Grhs+k56argGh7OPVxjXrhgW1NVnGQpaRXzGRRZJy9wj+rb+4zHGFACgJZJYpRG7S
	 qsakE3QRrAMoLjgo/y0Pol+ns8Kp9XepAmUM8Z8XfhhE3AGV+LwgyhS0EidsyEYKv4
	 yZsyC8410SlSXDBjpTXYoSaaz1KAF5HVsU3utO4X+R5W7fg/jlzOhPzoxUvapHnjDz
	 90PzVecMQyXRvpO/puRV3afd2UULwhDvY2M3uomohas8l2cZzDyYRFAKJeyvbgC5kD
	 8/1OcX93vrzfiE4CAfCkZK7ywXAutGTvpU0BSW0T1j+wcWJET7lc1pRN7H6yPeu7o1
	 41mCXOr+6Z3CQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656d9230ceaso824464eaf.2
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 12:06:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc35lBagwU8VU3TeiF5f6FSzfjHFrCdZ4l+JsaP+x25WY+u8qptZ1pfIyALJr4gpuX5CYkRj35F6WD@vger.kernel.org
X-Gm-Message-State: AOJu0YzUb0LaP8F3rLRxM7Z+bC1p+CNmCK0l5gup/APmOANbNL/pgyX9
	vwvBUexiJDUY3TPwHQA5DlycZZqvifWlPeSCyR1FVQLG2sx8625Txz9bqlKUi4VUkmlboqy9lOv
	7AKIEHo/k8slnsGNF2oBnvhnNCXeebHk=
X-Google-Smtp-Source: AGHT+IEg8oXRbLTXiVhdXykB3swM9oO7gXkPhI0VIZFDfXH5x5MXQlo0paz7uXBPVEKSjNoGD2llLv/5cWwKiBcM0fo=
X-Received: by 2002:a05:6820:2015:b0:659:9a49:90c4 with SMTP id
 006d021491bc7-6599a9774aemr187186eaf.67.1764965174870; Fri, 05 Dec 2025
 12:06:14 -0800 (PST)
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
 <6d7b916a-8c37-499a-84a6-5facbe0e3bd4@kernel.org>
In-Reply-To: <6d7b916a-8c37-499a-84a6-5facbe0e3bd4@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Dec 2025 21:06:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jqdQw57t7Moj4o2eWt54t1wBvn8_0N9L-orn_JzFGWyw@mail.gmail.com>
X-Gm-Features: AWmQ_bnH9hdK2j8hHHaKzzn9L6Bxt3a-v3w2zKuWpRyqTpErIdpVKYn9CV3ujy8
Message-ID: <CAJZ5v0jqdQw57t7Moj4o2eWt54t1wBvn8_0N9L-orn_JzFGWyw@mail.gmail.com>
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

On Fri, Dec 5, 2025 at 8:42=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 12/5/25 1:37 PM, Rafael J. Wysocki wrote:
> > On Fri, Dec 5, 2025 at 7:07=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> On 12/5/25 11:22 AM, Rafael J. Wysocki wrote:
> >>> On Fri, Dec 5, 2025 at 5:47=E2=80=AFPM Mario Limonciello (AMD) (kerne=
l.org)
> >>> <superm1@kernel.org> wrote:
> >>>>
> >>>>> I would start with the graphics stacks and teach them to
> >>>>> runtime-suspend the HW when the displays go off.  No firmware
> >>>>> notifications are needed for this to work.
> >>>>
> >>>> Well the problem with this is there is a sizable latency to runtime
> >>>> suspend hardware when displays go off.  For example you would need t=
o
> >>>> redo link training when you spin the hardware back up.
> >>>>
> >>>> What we do today (AMD *dGPU* centric) is runtime suspend the hardwar=
e
> >>>> when no displays are connected and nothing else is using the GPU (fo=
r
> >>>> offload purposes).
> >>>
> >>> The latency problem can be addressed by using autosuspend instead of
> >>> synchronous suspend.  Just set the autosuspend timer when displays go
> >>> off.
> >>
> >> Sorry I probably confused the problem by saying latency to suspend the
> >> hardware.  That doesn't matter.  It's a problem of latency when they
> >> *come back up*.  Let me give a hypothetical that will demonstrate.
> >>
> >> Let's say I have the following:
> >> * Desktop with a dGPU connected to it.
> >> * My DE has a setting for compositor to blank the monitor after 5 minu=
tes.
> >> * My DE has a setting to starting system suspend after 10 minutes.
> >> * You set up auto-suspend on the dGPU for 15 seconds.
> >> * No non-display work running.
> >>
> >> You walk away for 6 minutes.  The dGPU will have entered runtime PM fr=
om
> >> the auto-suspend.  You come back to the machine and you wiggle the
> >> mouse.  Because the dGPU was auto-suspended you gotta wait for it to
> >> spin back up, you have to wait for link training again etc.
> >
> > Yes.
> >
> >> This is pretty much the same that would have happened if you walked aw=
ay
> >> for 10 minutes now!  Your "5 minute blank monitor" turned into "5 minu=
te
> >> turn off dGPU".
> >
> > Well, the wakeup latency is the cost of saving energy.
> >
> >>>
> >>>> On AMD APU we don't use runtime suspend.  If you ignore the latency =
I
> >>>> could see an argument for proxying the status of displays to indicat=
e
> >>>> runtime suspended, but I don't know what it really buys you.
> >>>
> >>> Well, the lack of runtime PM is a problem and I don't see how it can
> >>> be overcome easily.
> >>>
> >>> The main issue is that when the system is resuming and there is no
> >>> runtime PM support, the device in question must be powered up during
> >>> the system resume flow.
> >>
> >> I don't think this is actually a problem.  The reason is in my below
> >> comment.
> >>
> >>>
> >>>>> Then, I would teach
> >>>>> graphics drivers to leave the devices in runtime-suspend if they ar=
e
> >>>>> runtime-suspended when system suspend starts and to leave them in
> >>>>> runtime-suspend throughout the system suspend and resume, so they a=
re
> >>>>> still runtime-suspended whey system resume is complete.  I'm not su=
re
> >>>>> how far away graphics stacks are from this, but at least some of th=
em
> >>>>> support runtime PM, so maybe the fruits don't hang very high.  With
> >>>>> that, you'd just need a way to trigger a system suspend after a per=
iod
> >>>>> of inactivity when the displays are off and you have your "dark mod=
e".
> >>>>
> >>>> I think even without kernel changes this can be accomplished today w=
ith
> >>>> userspace.
> >>>>
> >>>> There will be change events when the displays are turned off and you=
 can
> >>>> listen to and set a timer to enter system suspend based upon how lon=
g
> >>>> they are off.
> >>>
> >>> True, but that's just about suspending.  To avoid powering up devices
> >>> on the way back from system suspend, runtime PM support and
> >>> integration of it with system suspend-resume is necessary.
> >>
> >> Yes and no.  For most device types I would agree; but the compositor
> >> controls DPMS on each CRTC which impacts whether anything is displayed=
.
> >>
> >> If the compositor chooses to turn off the displays the GPU hardware wi=
ll
> >> remain active but display IP will be off or in a low power state.  Thi=
s
> >> will still have significant power savings by the displays being off.
> >
> > OK, so you basically want the GPU to avoid turning displays on during
> > resume from system suspend if they were off before the suspend
> > transition has started.  This still needs to be handled by the GPU
> > driver in the kernel IIUC.
>
> Yes.  To be clear (in case you didn't see from my comments in this
> thread) I'm not a fan of this being a userspace interface to the LPS0
> screen off.

So we agree here, good.

> I feel if this state is to exist in the Linux state machine this should
> be DRM core entering it when displays are off.

Something like that.

