Return-Path: <linux-acpi+bounces-19470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88ECAAF70
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 00:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8890130D3962
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Dec 2025 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EFF2D94A3;
	Sat,  6 Dec 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XUar0BGq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C11A239A
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765064177; cv=none; b=c0JflOxlbmUUTBBPPD61fTuXW22tMdftncHnSYV3Z7LbTze87NkLoZuBgXtglkNPXYQClCD0CeyjwTxVpzbt8b7x6Uz7v4PemNi57bslMs5lfbcZqVb4xIyPdn3Koqi7r/jMgc0g8xQzcN5mE25YYUUfs13mGxkUDluboj3RVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765064177; c=relaxed/simple;
	bh=DdGXQ5zLBO+3FjfkBHUN7lD1UyN7g30O/Z91BWlh0tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCjX28aomOUw7QXZu1eiWOykSF+/uGnov8YPXXcECEMZI5rqR1LC++pj0K7462DBSSvBbpSkcxPuW1fWq8qH4EirwSPEUq+nXl1o7nMmsrSdA4WmxKWGW4q6BvIrLoL7CsWHL3uRmiVKfOCunxiPfAUBv8v+Y4ZyF+r3MHP4nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XUar0BGq; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id A4D045E4BE
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 01:36:07 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id B81575E505
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 01:36:06 +0200 (EET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 61FFB201E3A
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 01:36:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1765064165;
	bh=eKVNbDh/uYt9Ge3G+WxGquCZl34Qd1OX2/HcDNXAywc=;
	h=Received:From:Subject:To;
	b=XUar0BGqEjc1cGUktA7iEscGCrny9KXb7jKH1jppUSolypDVdd8vsHyoNHGFb7jFr
	 xycNIV/t4844s3QKgu1dUlGCViCtNYIoOt82tfNbomsQBE8ElrN6FtLrypcDK3ShAW
	 rSI+SUNpVDo7DuT1xlu9kRUN2y7Dnt9BJvUNp+kYUHKYKVmplMJ+iGgbSu13HyXn9T
	 CbavdGJO7Ph8A1aHUN1tmJzwXyL/NlryV61pjyVF/WL/7Z5pJk9VBlNRhlCQ0eV3su
	 HlAkuDkzbXKtBPOyJG5rdrF5e+aG45VGJ5JKGNOWoUWE+A/bXd1egLgTbv+/I1/u+v
	 bLXvqxgNbaAZQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-37a415a22ecso32607371fa.0
        for <linux-acpi@vger.kernel.org>;
 Sat, 06 Dec 2025 15:36:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUE2d+UO+euRrn6JqqCH0ac0zmkS8BQ8RdeEXurgHNSkqiOSctq/mM3p22A8LWZph9II3lb8q99bw4N@vger.kernel.org
X-Gm-Message-State: AOJu0Ywymd8Kz5X5C0VS6i6z1uDL/AaPStpIYJ4GxiOCf0w+dEcsH/QB
	JxxXCSUlANJONP3gH4IkmSdy4PYYk1acVYYWB6NplPr9Nc4peDwiXFvBtjvnhfQjkTMnO22lDqT
	E3Qbt1s/FwXGSYU5eDsYL7aseejdCQs4=
X-Google-Smtp-Source: 
 AGHT+IGjq2UxuK0IxnMh0NbSvwLnpRvM9fO9tLJMOSygbZ7R4KN9wUbCIKHLsuA9GWJJ8w+rfrDuXcIfE1pDbXrEPsE=
X-Received: by 2002:a2e:9b4c:0:b0:37e:6884:6756 with SMTP id
 38308e7fff4ca-37ed20668dbmr7756061fa.14.1765064164685; Sat, 06 Dec 2025
 15:36:04 -0800 (PST)
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
 <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
 <CAJZ5v0g5dwWSOQCTUFeD+ztFLyYrRR1Z=vt2C+c48SRbaNLJzg@mail.gmail.com>
 <2711fe57-1963-483e-b8fa-0c5ed0bd2ea9@kernel.org>
In-Reply-To: <2711fe57-1963-483e-b8fa-0c5ed0bd2ea9@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 7 Dec 2025 00:35:52 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEp3Xc_pv-YGb_Xc46CcLKPppYaZbphV24kiNHM4Eqb-w@mail.gmail.com>
X-Gm-Features: AQt7F2pktM6lQOTQj3tzKF_f1NhiYfH1JwlQTpu2l4f1kcRlVDipWdIPAh_PgQ8
Message-ID: 
 <CAGwozwEp3Xc_pv-YGb_Xc46CcLKPppYaZbphV24kiNHM4Eqb-w@mail.gmail.com>
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
 <176506416579.1442918.12486818707685459156@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 6 Dec 2025 at 21:50, Mario Limonciello <superm1@kernel.org> wrote:
>
> >> I will reply to the earlier reply from Rafael with more context, but
> >> runtime suspend of the GPU is not part of or related to these
> >> notifications.
> >
> > Of course it isn't.
> >
> > What we were talking about was how to get from the "displays off, no
> > GUI activity" user space smoothly into system suspend and back.
> >
> > You are saying that this has been done already on AMD, so I'm not sure
> > why you want more.
> >
>
> I'm not aware this existing in any unique way for AMD.  The decision of
> displays off; start a timer and enter suspend would be the same for any
> vendor.

AMD retains CRTC DPMS state from userspace to s0ix currently, and you
fixed hibernation recently too. Intel sometimes doesn't, the screen
will sometimes flash while entering suspend.

There is also runtime suspend on most components. Is there a case for
powering off the iGPU completely to improve energy use?

The most expensive component in this process is unfreezing, then
runtime pm freezing the GPU IP blocks after s0ix exit, then unfreezing
it two seconds later to perform runtime checks and freezing it again.
So for multiple exits from suspend where the IP is inactive this will
keep repeating.

> But GPUs aren't only used for display.  If you're actively running a
> different workload (for example an LLM) using the GPU and happen to turn
> off all the displays you wouldn't want it to suspend.
>
> What you would want is to key off:
>
> 1) All displays are off.
> 2) All GPUs are unsused.
> 3) Some time has passed.
>
> I feel that if userspace is going to adopt a policy like this kernel
> drivers need to use runtime PM when displays are off and the GPUs aren't
> being used for anything else.
>
> At least for AMD this doesn't happen today and would require driver
> work.  But the same kind of work would be needed by any GPU driver.
>

You could potentially do that, first you'd need to show that there is
a latency benefit to powering off the GPU over entering s0ix (as
userspace will be frozen in both cases for the GPU to suspend). Then,
you'd need to show that there is an energy benefit over just staying
unsuspended with userspace frozen and the GPU being in runtime
suspend. WIth both of these, a case could be made for powering off the
GPU completely for a marginal latency/energy benefit.

These notifications do not affect runtime pm though so this discussion
is a bit tangential.

Antheas


