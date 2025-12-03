Return-Path: <linux-acpi+bounces-19403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B5C9EA99
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 11:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1F4E1609
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D002E8B63;
	Wed,  3 Dec 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XgTV3rUi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CE2E7BB5
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756806; cv=none; b=ZBuwBlCW2vkSH/EjawaHS2kHMrSCvbEWhbjm5XU9Uw2HFRvUzDgVpn58rqA3d6sHyowVSpMoSGb/vVZUCWdVLbXzx1Bq0xebNtlq1bVx1WJax9Fx3Kiqozcx8IUtK7RePpj1XqqpoUr9eQtTV+So40Xrde4edtlxkJfZWg7QgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756806; c=relaxed/simple;
	bh=xiO6yUoSorPLzzs22ZWq3AW+Eb7Aiok5LPrV7Sv79sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLsF85PSqKO6omTb3lWnym/jl5VEYW++3LfIfuHwwbky5YNwVUHo/aODjS/K9hSm80PQZzvs2y2BJXhEB+/ebYZp8RIYTV6s+1qgXAD3CxrO0mEMv3ZKQm8Bevym3oQ/WHNCRL94feXjOeQVqz10kwFS9gUS2Jm+Io/i94jaEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XgTV3rUi; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id BDCF643FE6
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 10:13:14 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 4EB2943ED1
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 10:13:13 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6611F201DFB
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 12:13:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1764756792;
	bh=ystVRlB5GzrP6kiPxnK2FZKeHRDPMpJtByIw/RIGM/0=;
	h=Received:From:Subject:To;
	b=XgTV3rUiufTTkhrZfDNYx04x0chm0aoBjZWKThaNfL2g+orI1GkpCtTgHLO4x5gcr
	 OoZkI6Sq3NrERRTFGjMiTE0K66OXXaq4l3L1ul+HX+OHpU79ipYq201bZkXyH0XLad
	 C8D25jKIMV5A0dJuo6gCLpUjWbbTUbBQDAoWT+YSZ2ns9KluRbm7mnnWyA4s+g1U+M
	 0R7pRNiie6OhQ47Dkkbv+6DhYB77+Gsbgd2Dt+jVcy+DRV4QiQ1okAhQo6gIjgg8u7
	 W/DkT1eXcOBvo9vrJSrJxI7AWjOWPwpDBk3JIUv8tgObz4wDj9Exy1J3ejm9l/Fo8W
	 95m3yL1ZGNd7g==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-37d056f5703so62828661fa.0
        for <linux-acpi@vger.kernel.org>;
 Wed, 03 Dec 2025 02:13:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXWP9PrWWaKewdh1PU4RmPmbftEdyO3peTxzkRjp6dsY/aXpwdcklVXAw//GPv2bZ9eeFj8fCRbgRGG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5vFytvR2qCbkaQ03EUmzCznItDsvC+RIxmQW2S0qRzxkv1pL
	KGYLYgJCBLnPFXNvq4AjPmjCM6rgCyVZpnTieMon+4YXzaoA+bpx5nFyulMXJ3l5xh0sgsFRDzl
	qLRZCL8OtR6FnSGk9I2M62oyYkZ2d6v0=
X-Google-Smtp-Source: 
 AGHT+IE6dO5cX16bgmMma+Xl2x1Mttlofbd/WG8z1lQH6uGUP3ZH/prrPtHg0rWn8Ex9vXz2fUFi9oHm3uX20JoqkYQ=
X-Received: by 2002:a2e:8809:0:b0:37a:9558:5bda with SMTP id
 38308e7fff4ca-37e6378da8bmr4625451fa.14.1764756791710; Wed, 03 Dec 2025
 02:13:11 -0800 (PST)
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
In-Reply-To: <82357e17-56ec-4dd6-82b2-0b8308f7aec2@collabora.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 3 Dec 2025 11:12:59 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEDJbFoZJsqyOycHbv-LwGqOC-MG3K_duVEEqfKfXMUhA@mail.gmail.com>
X-Gm-Features: AWmQ_bkrFVFOYH8OHn468IWDzdZ9i6p4_RsZrZYr5ZK3wRU8Cic-DJ1BS8zFVhk
Message-ID: 
 <CAGwozwEDJbFoZJsqyOycHbv-LwGqOC-MG3K_duVEEqfKfXMUhA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 Lennart Poettering <lennart@poettering.net>,
	Daniel Stone <daniels@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176475679278.2257852.15066177133417332945@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 3 Dec 2025 at 07:47, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 12/3/25 05:12, Mario Limonciello (AMD) (kernel.org) wrote:
> >
> >
> > On 12/2/2025 4:35 PM, Dmitry Osipenko wrote:
> >> On 12/3/25 00:25, Mario Limonciello (AMD) (kernel.org) wrote:
> >>>> An inhibitor process in logind can handle this gracefully very simply.
> >>>> Involving the DRM subsystem just adds a lot of complexity and it is
> >>>> not clear what the benefit would be. There are no known devices that
> >>>> hook DRM components into that DSM.
> >>>>
> >>>>> By doing it this way userspace still has control, but it's not
> >>>>> mandatory for userspace to be changed.
> >>>>
> >>>> On that note, the screen off calls/userspace implementations are
> >>>> optional under both patch series. If userspace is not aware of them,
> >>>> they are still called by the kernel when suspending.
> >>>
> >>> With the proposal I mentioned you can get the LPS0 _DSM called on a
> >>> handheld when the screen gets called without changing userspace.
> >>>
> >>>>
> >>>> Current userland also duplicates the functionality of the screen off
> >>>> call, which is primarily turning off the keyboard backlight. So along
> >>>> implementing this call, userspace software like powerdevil/upower
> >>>> needs to be tweaked to avoid doing that if the screen off state is
> >>>> available.
> >>>
> >>> Sure Any hooking for turning off LEDs manually based off the screen off
> >>> _DSM is totally feasible.
> >>
> >> It's not that trivial to add screen on/off hooks to DRM, there is no one
> >> central place for that from what I can tell. I'm seeing variant with DRM
> >> hooks as unnecessary complexity that doesn't solve any practical problem.
> >
> > Is it really that hard?  I figured that any time
> > connector->dpms != mode from drm_atomic_connector_commit_dpms() could
> > walk through all the connectors and make a judgement call whether to
> > notify the potentially exported symbol.
>
> - drm_atomic_connector_commit_dpms() is used only for atomic ioctl path
> - there is another legacy kms path
> - AFAICT, DRM takes a different path when display is enabled initially
> by kernel
>
> Here we have 3 places where to plug the hook. Gives a strong feeling of
> a red flag, IMO.
>
> >> A week ago in a private conversation, Daniel Stone gave an example of
> >> laptop's lid-close handling that is done purely in userspace.
> >> Technically, kernel could have DRM hooks for that too, but it doesn't.
> >
> > All the way into hardware sleep?  There are certain requirements needed
> > for hardware sleep that kernel drivers are normally used to put devices
> > into the right state.  I guess PCIe devices you can hack around with
> > userspace PCI config space writes but you're going to confuse the kernel
> > pretty badly.
>
> - Userspace gets notification for a changed lid state
> - Userspace takes action of turning display on/off
> - Kernel DRM doesn't know and doesn't care about lid state,
> force-disabling display on machine suspension
>
> Don't see how this is different for the case of the LPS0 notifications.
> Maybe I'm not getting your point well, in that case please clarify more.
>
> >> Userspace would need to be taught about new power modes in any case.
> >> Addition of DRM hooks should require a well-defined justification, which
> >> is currently absent.
> >>
> >
> > Why does userspace need to know about them?  Besides the inhibitor can't
> > this be invisible to userspace?  I thought this mostly is for the
> > firmware to flash some LEDs and maybe change some power limits.
>
> What I was saying is that LPS0 inhibitors would represent the power mode
> controls by themselves. Userspace would have to know how to drive them.
>
> Userspace power managers are already driving displays DPMS. Combining
> this with knowledge about the LPS0 inhibitors gives userspace ability to
> support the new device power states. Hence, there is no practical need
> to bother kernel DRM with the LPS0 burden.

_Technically_ DPMS is driven by the compositor, not by any power manager.

However, I think for Gnome and KDE they link to logind's inactivity
hook so practically you are correct for inactivity.

Moreover, traditionally, compositors do not fire DPMS for suspend, the
kernel does. I think KDE fixed that recently though. This is why the
display used to wake up twice during hibernation, and why you get a
frozen display when suspending/resuming. This also complicates
suspend-then-hibernate checks because the display wakes up. i.e., they
should fire DPMS for suspend but a lot for them don't

With compositors such as gamescope that do not have a dbus API it gets
more hairy. And it also means that the power manager/kernel cannot
control DPMS without the compositor's consent. If they do that, the
compositor will crash due to rejected commits. We have a suspend hook
for gamescope on Bazzite though, it improves suspend appearance.

Just throwing in this for context, although it builds more of a case
of not involving DRM.

Best,
Antheas

> --
> Best regards,
> Dmitry
>

On Wed, 3 Dec 2025 at 07:47, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 12/3/25 05:12, Mario Limonciello (AMD) (kernel.org) wrote:
> >
> >
> > On 12/2/2025 4:35 PM, Dmitry Osipenko wrote:
> >> On 12/3/25 00:25, Mario Limonciello (AMD) (kernel.org) wrote:
> >>>> An inhibitor process in logind can handle this gracefully very simply.
> >>>> Involving the DRM subsystem just adds a lot of complexity and it is
> >>>> not clear what the benefit would be. There are no known devices that
> >>>> hook DRM components into that DSM.
> >>>>
> >>>>> By doing it this way userspace still has control, but it's not
> >>>>> mandatory for userspace to be changed.
> >>>>
> >>>> On that note, the screen off calls/userspace implementations are
> >>>> optional under both patch series. If userspace is not aware of them,
> >>>> they are still called by the kernel when suspending.
> >>>
> >>> With the proposal I mentioned you can get the LPS0 _DSM called on a
> >>> handheld when the screen gets called without changing userspace.
> >>>
> >>>>
> >>>> Current userland also duplicates the functionality of the screen off
> >>>> call, which is primarily turning off the keyboard backlight. So along
> >>>> implementing this call, userspace software like powerdevil/upower
> >>>> needs to be tweaked to avoid doing that if the screen off state is
> >>>> available.
> >>>
> >>> Sure Any hooking for turning off LEDs manually based off the screen off
> >>> _DSM is totally feasible.
> >>
> >> It's not that trivial to add screen on/off hooks to DRM, there is no one
> >> central place for that from what I can tell. I'm seeing variant with DRM
> >> hooks as unnecessary complexity that doesn't solve any practical problem.
> >
> > Is it really that hard?  I figured that any time
> > connector->dpms != mode from drm_atomic_connector_commit_dpms() could
> > walk through all the connectors and make a judgement call whether to
> > notify the potentially exported symbol.
>
> - drm_atomic_connector_commit_dpms() is used only for atomic ioctl path
> - there is another legacy kms path
> - AFAICT, DRM takes a different path when display is enabled initially
> by kernel
>
> Here we have 3 places where to plug the hook. Gives a strong feeling of
> a red flag, IMO.
>
> >> A week ago in a private conversation, Daniel Stone gave an example of
> >> laptop's lid-close handling that is done purely in userspace.
> >> Technically, kernel could have DRM hooks for that too, but it doesn't.
> >
> > All the way into hardware sleep?  There are certain requirements needed
> > for hardware sleep that kernel drivers are normally used to put devices
> > into the right state.  I guess PCIe devices you can hack around with
> > userspace PCI config space writes but you're going to confuse the kernel
> > pretty badly.
>
> - Userspace gets notification for a changed lid state
> - Userspace takes action of turning display on/off
> - Kernel DRM doesn't know and doesn't care about lid state,
> force-disabling display on machine suspension
>
> Don't see how this is different for the case of the LPS0 notifications.
> Maybe I'm not getting your point well, in that case please clarify more.
>
> >> Userspace would need to be taught about new power modes in any case.
> >> Addition of DRM hooks should require a well-defined justification, which
> >> is currently absent.
> >>
> >
> > Why does userspace need to know about them?  Besides the inhibitor can't
> > this be invisible to userspace?  I thought this mostly is for the
> > firmware to flash some LEDs and maybe change some power limits.
>
> What I was saying is that LPS0 inhibitors would represent the power mode
> controls by themselves. Userspace would have to know how to drive them.
>
> Userspace power managers are already driving displays DPMS. Combining
> this with knowledge about the LPS0 inhibitors gives userspace ability to
> support the new device power states. Hence, there is no practical need
> to bother kernel DRM with the LPS0 burden.
>
> --
> Best regards,
> Dmitry
>


