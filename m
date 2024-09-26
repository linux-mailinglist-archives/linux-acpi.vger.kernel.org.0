Return-Path: <linux-acpi+bounces-8429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A87C986F12
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2921728AFA3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110311A4E8D;
	Thu, 26 Sep 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IY7aM5vm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC81D5ACF;
	Thu, 26 Sep 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340039; cv=none; b=RPRAMG70z1uJ8PzOo0QBXHlVHbD/UTaa5+8XdOmIz1AYTBAQHvyqJYTis864fbtuqWrMZRKHmUNC5F0SA7FefcXXJe3lhQCgx7AQZb4TIJ0YIbdugAiOSJdjtnTIVbNHW6eWJVcmg6rYKMED3i3HFtXlFT8UduDY8edJueEEmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340039; c=relaxed/simple;
	bh=TORR6vSdlthDV3D7Mttqa6Y0d3EA/9COCIbgvfYa20w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elpnZJo8ONzUoRWp8/ZfWj7rrA2VHJgkCQpHFZopXxwlcjza32XgNCIAG0WUxAng+OWRKDo0XXDu81I5AEIsfAdI/CjE4fAzR4ClPybrDQplmkAArTJNewpNtQiDdrpWPQ3aYsXFpObOtN6ku9gFq6KdrfmvB5KVIZg9NTnA5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IY7aM5vm; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 191E32E08154;
	Thu, 26 Sep 2024 11:40:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727340025;
	bh=pCwNv+obHIaPpwKmIRsp2qsyEXFkpXtUdABVsbUprLg=;
	h=Received:From:Subject:To;
	b=IY7aM5vmd9EQ5EZTaPikKAwPD3zBsPiyx7rbvX6ahzQ1vDpgSUjHypBMTIfrc3Zzo
	 0clJ8YLAt6uFOlwRu91Qj9OlLufSio1hrV9taekD6PeR+Nx2dfmnzbv6yGpEQAmvbZ
	 6O32vS9qh+Do/KmlnhlEZsjPgutKANR4ejvhVRNs=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2f762de00fbso8350191fa.2;
        Thu, 26 Sep 2024 01:40:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVCnQF6ED35rk67M7WEskN71SmIA6tdNuTzcTA40xz1O6Qsgzx+HkYhXEZQMUx5apMiu5n/3tTdBGIs@vger.kernel.org,
 AJvYcCVzN6N2BzWNlFEF1a0jtxcg0d76RRd35UayiFwyIgs0hLcbm36hFmRWkK8Dp/6/mtSiqLxMDJTsukmdAdPhGm7cVceNUw==@vger.kernel.org,
 AJvYcCXw/amEBeQKRH/TDGf5fgSejzdYHNbRMzlRH8vYN+y58fVNIyZlm4GMSAO8/KrHOpxxk2APpF1feGC7HA4B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ot5x62o2u/LHE9WPSKVS/tAFWA8LrTslTJhKrBRcLMgljAVQ
	+OkXEsZ57pk7pRNZo19aU73oxsxfejcEDjT9O/VmVhX0LpX121OPWDyzJETRYLxridoog13FbSS
	NmoJi7hfo9PWxUjXMDwMoQmWjprE=
X-Google-Smtp-Source: 
 AGHT+IHX/DXvRxsjnzkx9rGoyfzY+jG7EkBujq7y+0Eqs8DUTTnaxO4ZZjatpypglmAPIyo007/yI2+OCOhosiMuHf0=
X-Received: by 2002:a2e:819:0:b0:2ef:2344:deec with SMTP id
 38308e7fff4ca-2f91ca61108mr22667141fa.45.1727340023091; Thu, 26 Sep 2024
 01:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org>
In-Reply-To: <20240926025955.1728766-1-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Sep 2024 10:40:11 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFW-YfVb-CW0uVuZ4wG+Kw9oZaRNkMAZfjvQC98BYxp8Q@mail.gmail.com>
Message-ID: 
 <CAGwozwFW-YfVb-CW0uVuZ4wG+Kw9oZaRNkMAZfjvQC98BYxp8Q@mail.gmail.com>
Subject: Re: [RFC 0/2] "custom" ACPI platform profile support
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172734002453.18578.3074044221983098740@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Mario,
Indeed, the proposal looks good but has a few rough edges that would
make it unsuitable to use currently. Well, for the handheld use-case
at least.

This relates to issues of auto-discovery and how the kernel taint is
applied. For the kernel taint, see my comments on patch 2.

> There are two major ways to tune platform performance in Linux:
>  * ACPI platform profile
>  * Manually tuning APU performance
>
> Changing the ACPI platform profile is a "one stop shop" to change
> performance limits and fan curves all at the same time.

For laptops. A majority of users of handhelds find 3 settings too limiting.

> On AMD systems the manual tuning methods typically involve changing
> values of settings such as fPPT, sPPT or SPL.

Those names are amd-pmf specific and this proposal does not allow for
auto-discovery.

Instead, expose attributes `custom_mode` and `custom_mode_choices`,
that allow for querying the system for available custom modes and
whether userspace can use them.

In this case, the modes for amd-pmf could be `amd-pmf-spl` and `amd-pmf-user`.

`amd-pmf-spl` could export the attrs {spl_min, spl_max, spl} and allow
setting TDP using a slider a la Steam Deck. Here, manufacturers should
be given complete control, e.g., with a LUT and the kernel should not
taint.

`amd-pmf-user` would expose what is shown in this proposal and taint
the kernel. Unfortunately, without manufacturer intervention, this
would be the default for the foreseeable future for boutique devices
(e.g., GPD, OneXPlayer, Ayaneo).

> The problem with changing these settings manually is that the definition
> of the ACPI platform profile if supported by the hardware is no longer
> accurate.  At best this can cause misrepresenting the state of the
> platform to userspace and at worst can cause the state machine into an
> invalid state.
>
> The existence and continued development of projects such as ryzenadj which
> manipulate debugging interfaces show there is a demand for manually tuning
> performance.

-demand- -> requirement. Over 90% of handheld users will end up using a slider.

> Furthermore some systems (such as ASUS and Lenovo handhelds) offer an
> ACPI-WMI interface for changing these settings. If using anything outside
> that WMI interface the state will be wrong.  If using that WMI interface
> the platform profile will be wrong.
>
> This series introduces a "custom" ACPI platform profile and adds support
> for the AMD PMF driver to use it when a user has enabled manual
> adjustments.
>
> If agreeable a similar change should be made to asus-armoury and any other
> drivers that export the ability to change these settings but also a
> platform profile.

Indeed, it would be nice if such a change could be made for all
manufacturer drivers. Much of this proposal would lower the need for
something like asus-armoury, as asus-wmi would be fully capable of
supporting this with few changes and around 70% of the asus-armoury
attrs would then live under /sys/platform.

This also gives us the opportunity for a much needed rename of the variables.

I can speak with the out-of-tree Lenovo Legion Linux's maintainers and
see if they would like to collaborate on this as well.

Antheas

