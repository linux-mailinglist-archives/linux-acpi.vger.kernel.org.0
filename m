Return-Path: <linux-acpi+bounces-11566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2324A4866A
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95633A5742
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC31D6DA8;
	Thu, 27 Feb 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="lT7EMtVm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB11A841B;
	Thu, 27 Feb 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676733; cv=none; b=Yplt89V3iPf83I1AYU+BRCTOt8ik8k3UTDYtkvgcHfLy59zhN6qYvqgq0uv8gnfEn9OQDX0+wUcHGhHJ1d1m5fxaHtANACHcFAYMfVkTqRC51cWSdqls8RqLnqn/AJDSnX/11GJm5JvXrvisyn92ct/Gms/EE1x9Tw+f+zY+KhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676733; c=relaxed/simple;
	bh=EcUHgeUmMXAHQISxpsdRxBe6uS0XykI9CJJDggfkQjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTXx/q0zhaAngCkXGjpHopmP+CU/xCbuIczoLjWgCpI+hqs5iJwjMqBbdZ+wymxMZqNcp34t6fOJJflX7+BdBLc7QnSoh6SREJVGQhVaIhv9bxRdmiTZLtqyjOI5hmOSfurDwbQvBvMG6mVNdeKrOlfH1RgARtbu4cIkUXGQXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=lT7EMtVm; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 732112E08F89;
	Thu, 27 Feb 2025 19:18:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740676728;
	bh=0nXU5xsEytIKfQbjJdsE0RxmQdDG1VX9NebI89LZx0s=;
	h=Received:From:Subject:To;
	b=lT7EMtVmSjSR3B4nXSFQ/ihNs6KqgBLmFfd/ThnoSEmu2crOe59QiZsGQf9WN1smC
	 APOa7BmUiIhbKIeYXUW54kWrOGOpGiJcAuIkSxFFe3ONAVlbL8IWSzDs1OA5pWA7xZ
	 FaQXFTetPe8kUb3aMvxnP6DaDexQ602XWYjB6RC0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3091fecb637so10617071fa.1;
        Thu, 27 Feb 2025 09:18:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVBEPAzprP6x3XvxF/3eZqYpCbAZBXxmzRgg/KOtZ+y/bj2CXRvCx1Jpc24GUEjRbnhqSBWdeqzfLuj0wTCiOex7c0JrA==@vger.kernel.org,
 AJvYcCWHRu6k/ZsMlDWReEr+5fMTw0kZoaVXot7Zq0qW6luGqqfrm7hrojub1HBkBMsbVCD1v2+rtYFNtWr7@vger.kernel.org,
 AJvYcCXXctDUOjVDcXWQNNT/vPy/xzvfQJUgyWNebzQTTita92byWLlW0tdnlqu2zfW1cOPSSAjlAKlndOxtpi8l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3UgV9Fq7eKraCVRrLnSkOUi1pHnL8chPDaSXNyqlEYC8xzRWR
	76R0EhdTOlePTwDweuCG83/B7uIc5DP5zEKKhL5clbnsfe/kRB47//Tg+Mj9DzHzOz5csL0QGe0
	tONrL4uPqISRpy5Y/3QDrlGQOe1c=
X-Google-Smtp-Source: 
 AGHT+IEiEMOmXq+qQd1o83BhvunhsSfXPlqd4oR6As/oGK/bgLTJl5ELNc5wclQuxuvQLLDB6XMGJlk3FtPxO+N46FY=
X-Received: by 2002:a2e:7318:0:b0:308:fedf:8c26 with SMTP id
 38308e7fff4ca-30a80be2099mr60771391fa.7.1740676726658; Thu, 27 Feb 2025
 09:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227153603.131046-1-lkml@antheas.dev>
 <20250227153603.131046-3-lkml@antheas.dev>
 <26c21df0-c885-4948-8902-685dcb7f13b8@amd.com>
 <CAGwozwG8wqGCmVxK_dxGxWmqMofUGaThjiG9SaBEKWZ-EokjVQ@mail.gmail.com>
 <1ba0c88f-e0dc-4b9b-9ea2-47a6295910ce@amd.com>
In-Reply-To: <1ba0c88f-e0dc-4b9b-9ea2-47a6295910ce@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 27 Feb 2025 18:18:35 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGNV0gccAH-TXCi4PCnuWFOA0v8KkiZJ8Z+fZ+_ft6UAA@mail.gmail.com>
X-Gm-Features: AQ5f1JpFLTk5Q3jfVBX9HOvnFTbQNqP-2OHSkoN4vRIOaGXdY_sWUYp-x2bFqcE
Message-ID: 
 <CAGwozwGNV0gccAH-TXCi4PCnuWFOA0v8KkiZJ8Z+fZ+_ft6UAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: platform_profile: make amd-pmf a secondary
 handler
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
	me@kylegospodneti.ch, luke@ljones.dev
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174067672786.12619.13418233458344198997@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 27 Feb 2025 at 18:10, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/27/2025 11:04, Antheas Kapenekakis wrote:
> > On Thu, 27 Feb 2025 at 17:46, Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 2/27/2025 09:36, Antheas Kapenekakis wrote:
> >>> Since amd-pmf is expected to run alongside other platform handlers, it
> >>> should be able to accept all platform profiles. Therefore, mark it as
> >>> secondary and in the case of a custom profile, make it NOOP without an
> >>> error to allow primary handlers to receive a custom profile.
> >>> The sysfs endpoint will still report custom, after all.
> >>>
> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> ---
> >>>    drivers/platform/x86/amd/pmf/spc.c | 3 +++
> >>>    drivers/platform/x86/amd/pmf/sps.c | 8 ++++++++
> >>>    2 files changed, 11 insertions(+)
> >>>
> >>> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
> >>> index f34f3130c330..99c48378f943 100644
> >>> --- a/drivers/platform/x86/amd/pmf/spc.c
> >>> +++ b/drivers/platform/x86/amd/pmf/spc.c
> >>> @@ -219,12 +219,15 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
> >>>
> >>>        switch (dev->current_profile) {
> >>>        case PLATFORM_PROFILE_PERFORMANCE:
> >>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> >>>                val = TA_BEST_PERFORMANCE;
> >>>                break;
> >>>        case PLATFORM_PROFILE_BALANCED:
> >>>                val = TA_BETTER_PERFORMANCE;
> >>>                break;
> >>>        case PLATFORM_PROFILE_LOW_POWER:
> >>> +     case PLATFORM_PROFILE_COOL:
> >>> +     case PLATFORM_PROFILE_QUIET:
> >>>                val = TA_BEST_BATTERY;
> >>
> >> I would really prefer we do the absolute bare minimum to help this issue
> >> on ASUS (just special case quiet) and leave adding compat for other
> >> profiles for other development.
> >
> > I cannot risk other drivers having their options disabled. This can
> > have carry-on effects in other drivers too.
> >
> > Including in the legion v3 driver, in which you will end up disabling
> > balanced-performance. Since Derek posted the v3 for that today.
> >
>
> Sure - but let's handle that separately from this bug fix.  That driver
> will be targeted to 6.15 or later.
>
> We need to be cognizant about what can go into 6.14 needs to be bug
> fixes for drivers in tree.

For me to consider this problem resolved, I need a mitigation that
matches the behavior of this patch series 1-1.

If you have a better suggestion, I can implement it and test it real quick.

If this issue is not fully resolved, it will cause a lot of downstream
issues that will result in the legacy interface becoming unusable.

Acer and alienware implement balanced performance too. In the current tree.

> >> The reason for this is that if you look at power_modes_v2 there are
> >> actually 4 'possible' modes for v2 platforms.  So there is a bit of
> >> nuance involved and it's really not a 'bug fix' anymore by doing so much
> >> at once.
> >>
> >>>                break;
> >>>        default:
> >>> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> >>> index e6cf0b22dac3..a2a8511768ce 100644
> >>> --- a/drivers/platform/x86/amd/pmf/sps.c
> >>> +++ b/drivers/platform/x86/amd/pmf/sps.c
> >>> @@ -297,12 +297,15 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
> >>>
> >>>        switch (pmf->current_profile) {
> >>>        case PLATFORM_PROFILE_PERFORMANCE:
> >>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> >>>                mode = POWER_MODE_PERFORMANCE;
> >>>                break;
> >>>        case PLATFORM_PROFILE_BALANCED:
> >>>                mode = POWER_MODE_BALANCED_POWER;
> >>>                break;
> >>>        case PLATFORM_PROFILE_LOW_POWER:
> >>> +     case PLATFORM_PROFILE_COOL:
> >>> +     case PLATFORM_PROFILE_QUIET:
> >>>                mode = POWER_MODE_POWER_SAVER;
> >>>                break;
> >>>        default:
> >>> @@ -369,6 +372,10 @@ static int amd_pmf_profile_set(struct device *dev,
> >>>        struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
> >>>        int ret = 0;
> >>>
> >>> +     /* If the profile is custom, bail without an error. */
> >>> +     if (profile == PLATFORM_PROFILE_CUSTOM)
> >>> +             return 0;
> >>> +
> >>
> >> The legacy interface doesn't support writing custom.
> >>
> >> https://github.com/torvalds/linux/blob/v6.14-rc3/drivers/acpi/platform_profile.c#L382
> >>
> >> IoW this is dead code.
> >
> > Noted.
> >
> >>>        pmf->current_profile = profile;
> >>>
> >>>        /* Notify EC about the slider position change */
> >>> @@ -400,6 +407,7 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
> >>>        .probe = amd_pmf_profile_probe,
> >>>        .profile_get = amd_pmf_profile_get,
> >>>        .profile_set = amd_pmf_profile_set,
> >>> +     .secondary = true,
> >>
> >> I really don't understand the need for declaring primary / secondary.
> >> It really doesn't matter which driver can do it.  This same problem
> >> could happen in any direction.
> >
> > No. amd-pmf is responsible here. That's why you made the multiple
> > platform profile series after all. Other WMI drivers never load
> > together. To maintain existing compatibility, those drivers need to
> > still show the same options under the legacy endpoint.
>
> My point is mostly hypothetical right now because the realistic
> combinations right now are amd-pmf + other driver.
>
> >
> >> As a different suggestion; how about a new "generic" callback for
> >> 'compatibility' profiles?
> >>
> >> Right now the .probe() callback amd_pmf_get_pprof_modes() will set bits
> >> for visible profiles.
> >>
> >> How about an optional .compat_profiles() for the hidden one(s)?  This
> >> would allow any driver to implement them.
> >
> > amd-pmf cannot obscure any settings of the primary platform, so even
> > in this case it ends up implementing all of them, and compat profiles
> > becomes equivalent to .secondary with more steps (incl. a probe).
> >
> >>>    };
> >>>
> >>>    int amd_pmf_init_sps(struct amd_pmf_dev *dev)
> >>
>

