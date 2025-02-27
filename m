Return-Path: <linux-acpi+bounces-11564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C2A48621
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4313D3A74C7
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9011D5AD3;
	Thu, 27 Feb 2025 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="AqrKTlG5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA71BD000;
	Thu, 27 Feb 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675898; cv=none; b=sQwh3IHVGTQgoZAtL4CMU+2MoQbB88I7x18pJMZ7DsuWmeswJOlzc94din39FnyFtpiJioP4bZy0+DskrwA7qNms5NdERWwleYJPWIC5YxYmq6v329oZTL6BMt09onTl4oIP7MbyVz4OlxAh1eVlsousCTYdAkQC9FIrjTFK2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675898; c=relaxed/simple;
	bh=IpzSwpQluQm6I1YjqsXB3FznvWyYqQ0pMG3+6mzdmZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qr55S4zP2GiAxBC6bCTPPp+9DeFd57Q/7Ytrhzo1cKRPil1a3BnM/V/6hEKrHME+u4dUrTEOy9HyLdtB6ED5d6JqAwq+fCEZ2af5IsVLyrHkideyJ33a7TbAqm9nJhVsz08EZE0WofRqU8CmKaefVnXpLpskglvSX9CdBj+KKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=AqrKTlG5; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D2B422E09025;
	Thu, 27 Feb 2025 19:04:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740675891;
	bh=uctSlkUrMlvHx12sB1tLgVZZkb6XinjT+9cqV4eWdrc=;
	h=Received:From:Subject:To;
	b=AqrKTlG5y5AeISQMVCFGS72PE96HijuE81nnDi5fgQKMz5zWdbuagRyRf87jxMbrd
	 suOZ1I3GgSgT4VLg2dKfBJZ4t/GuwYh5r8cMILED/F+Sy3HYtnoP1EUjrt1Us82HLe
	 ty20e40w6r8KtIJ3c20HGcn3u0eNiWkl+On0u/vs=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-30a69c1a8d3so13557181fa.3;
        Thu, 27 Feb 2025 09:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVb6yC3In7ankkRsB8Y+uk7Dc2dqPCjPI12QklRdKBbnRNg/cENYayKVBty118fyoREWGqrmhgJko0gMrdoltMrXXaJyg==@vger.kernel.org,
 AJvYcCWbO/aG+mwJNEiFcGafVeoxFsd2yy3e356SkjBS0STZ8BcSP3GEFA/B6zzo95JSvJ6eMiNLe2A5l72e@vger.kernel.org,
 AJvYcCX+sIEgj5CjCHA1dXkAtaTlaXY89r92YVPJRhWg3vTBGsGGhUXrQKf3l0KON9NwBGMDNBS2KyonrdVM7YQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwTISU2TTKfShW9Q+TUffOZSKbQ2DNqVBoUWGogbDqaOK4n4Fp1
	jIXJ4T/AgfAPj8FsA/9mf5yCm+0wxvqCFsOlrul0IOmbRD8WHaa/kplJRaLDXpAs78i3OSkLSyD
	qN3RpHLqYnFiLZ5IL6cNgNjdQpM8=
X-Google-Smtp-Source: 
 AGHT+IFi8/u7RYnWU+yBp7WaJ48+k2U5vzl9uTrylS5JlOVvEQo0LI18tCVl9j2wDfupmlamNXH+NwY7+k2m6+UqGEU=
X-Received: by 2002:a2e:8950:0:b0:308:eabd:2991 with SMTP id
 38308e7fff4ca-30a5985e216mr99513221fa.1.1740675890057; Thu, 27 Feb 2025
 09:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227153603.131046-1-lkml@antheas.dev>
 <20250227153603.131046-3-lkml@antheas.dev>
 <26c21df0-c885-4948-8902-685dcb7f13b8@amd.com>
In-Reply-To: <26c21df0-c885-4948-8902-685dcb7f13b8@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 27 Feb 2025 18:04:38 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG8wqGCmVxK_dxGxWmqMofUGaThjiG9SaBEKWZ-EokjVQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrM1bqkemwyvdtc5NJhNjjFLWRx1ZJiFq-t_e5lSbgYJmoU1B5C23ISdH0
Message-ID: 
 <CAGwozwG8wqGCmVxK_dxGxWmqMofUGaThjiG9SaBEKWZ-EokjVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: platform_profile: make amd-pmf a secondary
 handler
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
	me@kylegospodneti.ch, luke@ljones.dev
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174067589159.17842.9673566004388985449@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 27 Feb 2025 at 17:46, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/27/2025 09:36, Antheas Kapenekakis wrote:
> > Since amd-pmf is expected to run alongside other platform handlers, it
> > should be able to accept all platform profiles. Therefore, mark it as
> > secondary and in the case of a custom profile, make it NOOP without an
> > error to allow primary handlers to receive a custom profile.
> > The sysfs endpoint will still report custom, after all.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/platform/x86/amd/pmf/spc.c | 3 +++
> >   drivers/platform/x86/amd/pmf/sps.c | 8 ++++++++
> >   2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
> > index f34f3130c330..99c48378f943 100644
> > --- a/drivers/platform/x86/amd/pmf/spc.c
> > +++ b/drivers/platform/x86/amd/pmf/spc.c
> > @@ -219,12 +219,15 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
> >
> >       switch (dev->current_profile) {
> >       case PLATFORM_PROFILE_PERFORMANCE:
> > +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> >               val = TA_BEST_PERFORMANCE;
> >               break;
> >       case PLATFORM_PROFILE_BALANCED:
> >               val = TA_BETTER_PERFORMANCE;
> >               break;
> >       case PLATFORM_PROFILE_LOW_POWER:
> > +     case PLATFORM_PROFILE_COOL:
> > +     case PLATFORM_PROFILE_QUIET:
> >               val = TA_BEST_BATTERY;
>
> I would really prefer we do the absolute bare minimum to help this issue
> on ASUS (just special case quiet) and leave adding compat for other
> profiles for other development.

I cannot risk other drivers having their options disabled. This can
have carry-on effects in other drivers too.

Including in the legion v3 driver, in which you will end up disabling
balanced-performance. Since Derek posted the v3 for that today.

> The reason for this is that if you look at power_modes_v2 there are
> actually 4 'possible' modes for v2 platforms.  So there is a bit of
> nuance involved and it's really not a 'bug fix' anymore by doing so much
> at once.
>
> >               break;
> >       default:
> > diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> > index e6cf0b22dac3..a2a8511768ce 100644
> > --- a/drivers/platform/x86/amd/pmf/sps.c
> > +++ b/drivers/platform/x86/amd/pmf/sps.c
> > @@ -297,12 +297,15 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
> >
> >       switch (pmf->current_profile) {
> >       case PLATFORM_PROFILE_PERFORMANCE:
> > +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> >               mode = POWER_MODE_PERFORMANCE;
> >               break;
> >       case PLATFORM_PROFILE_BALANCED:
> >               mode = POWER_MODE_BALANCED_POWER;
> >               break;
> >       case PLATFORM_PROFILE_LOW_POWER:
> > +     case PLATFORM_PROFILE_COOL:
> > +     case PLATFORM_PROFILE_QUIET:
> >               mode = POWER_MODE_POWER_SAVER;
> >               break;
> >       default:
> > @@ -369,6 +372,10 @@ static int amd_pmf_profile_set(struct device *dev,
> >       struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
> >       int ret = 0;
> >
> > +     /* If the profile is custom, bail without an error. */
> > +     if (profile == PLATFORM_PROFILE_CUSTOM)
> > +             return 0;
> > +
>
> The legacy interface doesn't support writing custom.
>
> https://github.com/torvalds/linux/blob/v6.14-rc3/drivers/acpi/platform_profile.c#L382
>
> IoW this is dead code.

Noted.

> >       pmf->current_profile = profile;
> >
> >       /* Notify EC about the slider position change */
> > @@ -400,6 +407,7 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
> >       .probe = amd_pmf_profile_probe,
> >       .profile_get = amd_pmf_profile_get,
> >       .profile_set = amd_pmf_profile_set,
> > +     .secondary = true,
>
> I really don't understand the need for declaring primary / secondary.
> It really doesn't matter which driver can do it.  This same problem
> could happen in any direction.

No. amd-pmf is responsible here. That's why you made the multiple
platform profile series after all. Other WMI drivers never load
together. To maintain existing compatibility, those drivers need to
still show the same options under the legacy endpoint.

> As a different suggestion; how about a new "generic" callback for
> 'compatibility' profiles?
>
> Right now the .probe() callback amd_pmf_get_pprof_modes() will set bits
> for visible profiles.
>
> How about an optional .compat_profiles() for the hidden one(s)?  This
> would allow any driver to implement them.

amd-pmf cannot obscure any settings of the primary platform, so even
in this case it ends up implementing all of them, and compat profiles
becomes equivalent to .secondary with more steps (incl. a probe).

> >   };
> >
> >   int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>

