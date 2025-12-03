Return-Path: <linux-acpi+bounces-19414-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC3C9F561
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8B40930012DB
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F90301716;
	Wed,  3 Dec 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="QmtdbdhN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EE2FC030
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773242; cv=none; b=eJPd4Y1fijUuCW53N0YTk5Xk4XvCcNZpDMwxHmfeEem+Lenj1c7dCfK6+gJrLt45G9gUaC8zS8GDy7ZEcTlCr06kEmQB2f17iQJW9vxe3vcLPjkSunaKatIsXfFZNCutC/qLd9itDbouqG/tqynv5zs5Qbwu9tHeCilYAlh6ybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773242; c=relaxed/simple;
	bh=ZkOLngFurbnSoLUYqpMJHZjmwRJB8whzCwkVz78kbxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFuy18h2lR9rOMj1LcwIVAHjtVg/AeCleTmqd/oXgNFOhkRuy5EiVTkRr3Z3Y//QustbCHReXRl+dMYmYBZDgetMQFk51lTj3Oc07PkUrY8AY5J9g7rMorZK3xlg9KI4T2TkPoQfOHb7WClZYIAvnW4t69kSD108Wp/QaMG16ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=QmtdbdhN; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id BCA8643E18
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 14:47:10 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 9E6D943EB1
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 14:47:09 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id AB2FA201CC9
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 16:47:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1764773229;
	bh=nRMlrNEnyX90YNnp1Yx7X81QiAxFhMYPm3iEhoBEYiA=;
	h=Received:From:Subject:To;
	b=QmtdbdhNj2O8s4gohpNxuMhqTMeLrkQ3aSbiA7At4Xy1klxXLWGbley3SipAx+XVw
	 rM7B/mLHdvjMu5NcyV7swXr1oMp0Jd6dTTN9n6YVq3vjPENbfUXb1WIh13C2qJz9YZ
	 FA4VWfOJFbLRvPGS+fMnh6nBCg8/7SO5ygpBewWvzArYEGClbcQzaa3BQGdCSZYxv3
	 mvYdTGq+RfoAzmKmuGYCsZnlSkygZFOwEDwuB3yur7yLdbKYiYWN1HyJxz5XzzdMaK
	 UNS8S7HYcuyfeKH2nzaJ6ui6dGwr0b5QnmcbdZMkCQdRz/VZEvE0KHs5GXmp6jqcig
	 Zj7JVAvTPb1qQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-37b9d8122fdso60041541fa.3
        for <linux-acpi@vger.kernel.org>;
 Wed, 03 Dec 2025 06:47:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUJNsZiRXa7VIPnaOn4JYC1YV4syY6M297+KkiK5n21OoTffWSGfFe82E7h3gKFUn7h6teP+HDktOne@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQp6HWZ1/SKk7df66IkE7z/9UJltJJyWxBMocxlGbyu0/CvV3
	/9zawUAMj96y9FBdgKAjvKmW78Mc/lQz6FmYtmTNdO9kgrmuNjMgnc7vU8Q4pXA4gF1VrV8FvWs
	6ewNmTfDMfcrArj0mFJfnjFtL//nMYVc=
X-Google-Smtp-Source: 
 AGHT+IHqAMhPGj4Q9ZbzuWbrADEJKcGuNyvfKevnZhGJzPym8FPaIaBqtM+F/z3LAQ+CFEEcLzY+nfS3NCMvMMTh/lM=
X-Received: by 2002:a2e:92c4:0:b0:37a:3963:ce8f with SMTP id
 38308e7fff4ca-37e6399b4e0mr8145531fa.33.1764773228128; Wed, 03 Dec 2025
 06:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
 <c7760b2d-c8cb-40fa-b1b1-8715e97e5cf0@kernel.org>
 <CAGwozwHi_U_R3ueJaYDaR_Pa6JntNbEh1dpwwbZW7jtrs5mbQw@mail.gmail.com>
 <02103d95-7bca-4db0-81c6-ac36429ea0bb@kernel.org>
 <35f69c12-ecd4-4b21-bfb0-53bf57f0febf@collabora.com>
 <ba7f9789-fd57-4d53-bf9a-15e85657ddd7@kernel.org>
 <82357e17-56ec-4dd6-82b2-0b8308f7aec2@collabora.com>
 <CAGwozwEDJbFoZJsqyOycHbv-LwGqOC-MG3K_duVEEqfKfXMUhA@mail.gmail.com>
 <2d4040dd-87e0-4cc4-9cce-3560e7b026c9@kernel.org>
In-Reply-To: <2d4040dd-87e0-4cc4-9cce-3560e7b026c9@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 3 Dec 2025 15:46:56 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEamNQJMh_zrFPbq1VeBtK+2i6iSJyRAm=unAQRVfZErg@mail.gmail.com>
X-Gm-Features: AWmQ_bkCpW7zik4PI_hOGRTpWLin_tMKpi3uhWnUIoeA69lqZDW8uv7WGt-E-5g
Message-ID: 
 <CAGwozwEamNQJMh_zrFPbq1VeBtK+2i6iSJyRAm=unAQRVfZErg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Mario Limonciello <superm1@kernel.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Lennart Poettering <lennart@poettering.net>,
 Daniel Stone <daniels@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>,
	linux-acpi@vger.kernel.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176477322900.3578605.1654450910652660426@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 3 Dec 2025 at 15:34, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 12/3/25 4:12 AM, Antheas Kapenekakis wrote:
> > On Wed, 3 Dec 2025 at 07:47, Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 12/3/25 05:12, Mario Limonciello (AMD) (kernel.org) wrote:
> >>>
> >>>
> >>> On 12/2/2025 4:35 PM, Dmitry Osipenko wrote:
> >>>> On 12/3/25 00:25, Mario Limonciello (AMD) (kernel.org) wrote:
> >>>>>> An inhibitor process in logind can handle this gracefully very simply.
> >>>>>> Involving the DRM subsystem just adds a lot of complexity and it is
> >>>>>> not clear what the benefit would be. There are no known devices that
> >>>>>> hook DRM components into that DSM.
> >>>>>>
> >>>>>>> By doing it this way userspace still has control, but it's not
> >>>>>>> mandatory for userspace to be changed.
> >>>>>>
> >>>>>> On that note, the screen off calls/userspace implementations are
> >>>>>> optional under both patch series. If userspace is not aware of them,
> >>>>>> they are still called by the kernel when suspending.
> >>>>>
> >>>>> With the proposal I mentioned you can get the LPS0 _DSM called on a
> >>>>> handheld when the screen gets called without changing userspace.
> >>>>>
> >>>>>>
> >>>>>> Current userland also duplicates the functionality of the screen off
> >>>>>> call, which is primarily turning off the keyboard backlight. So along
> >>>>>> implementing this call, userspace software like powerdevil/upower
> >>>>>> needs to be tweaked to avoid doing that if the screen off state is
> >>>>>> available.
> >>>>>
> >>>>> Sure Any hooking for turning off LEDs manually based off the screen off
> >>>>> _DSM is totally feasible.
> >>>>
> >>>> It's not that trivial to add screen on/off hooks to DRM, there is no one
> >>>> central place for that from what I can tell. I'm seeing variant with DRM
> >>>> hooks as unnecessary complexity that doesn't solve any practical problem.
> >>>
> >>> Is it really that hard?  I figured that any time
> >>> connector->dpms != mode from drm_atomic_connector_commit_dpms() could
> >>> walk through all the connectors and make a judgement call whether to
> >>> notify the potentially exported symbol.
> >>
> >> - drm_atomic_connector_commit_dpms() is used only for atomic ioctl path
> >> - there is another legacy kms path
> >> - AFAICT, DRM takes a different path when display is enabled initially
> >> by kernel
> >>
> >> Here we have 3 places where to plug the hook. Gives a strong feeling of
> >> a red flag, IMO.
>
> It could easily be a symbol that all 3 places call which enumerates
> connectors and decides whether to call the LPS0 symbol.
>
> But yeah; you might be right it's too complex.
>
> >>
> >>>> A week ago in a private conversation, Daniel Stone gave an example of
> >>>> laptop's lid-close handling that is done purely in userspace.
> >>>> Technically, kernel could have DRM hooks for that too, but it doesn't.
> >>>
> >>> All the way into hardware sleep?  There are certain requirements needed
> >>> for hardware sleep that kernel drivers are normally used to put devices
> >>> into the right state.  I guess PCIe devices you can hack around with
> >>> userspace PCI config space writes but you're going to confuse the kernel
> >>> pretty badly.
> >>
> >> - Userspace gets notification for a changed lid state
> >> - Userspace takes action of turning display on/off
> >> - Kernel DRM doesn't know and doesn't care about lid state,
> >> force-disabling display on machine suspension
> >>
> >> Don't see how this is different for the case of the LPS0 notifications.
> >> Maybe I'm not getting your point well, in that case please clarify more.
>
> I thought you were talking about total sleep handling, but you're just
> talking about other userspace events related to a lid.  This is much
> different.
>
> >>
> >>>> Userspace would need to be taught about new power modes in any case.
> >>>> Addition of DRM hooks should require a well-defined justification, which
> >>>> is currently absent.
> >>>>
> >>>
> >>> Why does userspace need to know about them?  Besides the inhibitor can't
> >>> this be invisible to userspace?  I thought this mostly is for the
> >>> firmware to flash some LEDs and maybe change some power limits.
> >>
> >> What I was saying is that LPS0 inhibitors would represent the power mode
> >> controls by themselves. Userspace would have to know how to drive them.
> >>
> >> Userspace power managers are already driving displays DPMS. Combining
> >> this with knowledge about the LPS0 inhibitors gives userspace ability to
> >> support the new device power states. Hence, there is no practical need
> >> to bother kernel DRM with the LPS0 burden.
> >
> > _Technically_ DPMS is driven by the compositor, not by any power manager.
> >
> > However, I think for Gnome and KDE they link to logind's inactivity
> > hook so practically you are correct for inactivity.
> >
> > Moreover, traditionally, compositors do not fire DPMS for suspend, the
> > kernel does. I think KDE fixed that recently though. This is why the
> > display used to wake up twice during hibernation, and why you get a
> > frozen display when suspending/resuming. This also complicates
> > suspend-then-hibernate checks because the display wakes up. i.e., they
> > should fire DPMS for suspend but a lot for them don't
> >
> > With compositors such as gamescope that do not have a dbus API it gets
> > more hairy. And it also means that the power manager/kernel cannot
> > control DPMS without the compositor's consent. If they do that, the
> > compositor will crash due to rejected commits. We have a suspend hook
> > for gamescope on Bazzite though, it improves suspend appearance.
>
> It's OT and tangential to this thread; but Gamescope should probably
> grow native DPMS control for this particular case.

It does have native DPMS control now for the inactivity case, not for
the suspend path, but it is managed by the Steam Client.

> >
> > Just throwing in this for context, although it builds more of a case
> > of not involving DRM.
> >
>
> I don't feel it's appropriate to build new API in the kernel to work
> around shortcomings of an individual compositor.
>

Well with wayland compositors the environment is more fragmented. But
in general it is the responsibility of the compositor to control
monitor state incl. DPMS. Of course, that is informed by the
inactivity state of the device, which is again the shared
responsibility of the input handling part of the compositor and
logind.

For SteamOS, that would be the steam client + gamescope. KDE is
kwin+logind+powerdevil.

I do not see why there would be a need to tie that responsibility to
the screen off state to the graphics component of the compositor,
which e.g. controls the keyboard backlight.

Even in Windows that is not the case, this screen off state is
controlled independently and there is something like a 5 second
inactivity buffer before it toggles after the displays switch off.

Antheas


