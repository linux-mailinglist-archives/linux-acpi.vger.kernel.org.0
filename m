Return-Path: <linux-acpi+bounces-11568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32725A48693
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE6618861AA
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F1F1DE2C3;
	Thu, 27 Feb 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Aaf7w9pg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F014BF8F;
	Thu, 27 Feb 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677305; cv=none; b=hdXBv6wcGXO2+CgyClGj+4fOnS79aP9RZHTDx+d4M6y0Fd+q0AyyOmG9TOQT0ChmWHmgxtoDYubrar7vJUjETcMUoNPKehqfPSGR+WervKISpgHcqLIPGfqalHjl0X9YDgZnXdRB7VQRiylN3wqf3ekBMOgK6pKbMVhAd0mUp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677305; c=relaxed/simple;
	bh=ikWj5+7SXGJyZUnbkxLELvI1YVvn2VIrtNvfHs/FeC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfHZaJSL+pAVf/S93bd3nqolQts/8GE00ZhpwaK9E562Cni341XHi1X7GlV4HQlfGNrbZX35YqD65vjdIMnUMS1xVEQSp6SHQ6743kr2wkBB2lPyHVWYgP3iIO8HbH3dFD9MEPv+JJrWFZ/yI5nbA1eDoUjYOtaQdfZJAVRT+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Aaf7w9pg; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 5B2D42E09048;
	Thu, 27 Feb 2025 19:28:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740677299;
	bh=ByF8KDVTX2D/v89FI2SCLVExRI54mmWywXip2G9Ozm8=;
	h=Received:From:Subject:To;
	b=Aaf7w9pg++QXb94nonrF51mbU6pBVRodN46Io0MFRVlReMC9W6HZq7RwXCUFrb4a6
	 MECmYMM/wILHuACd7y8Vyyysef2+LkPn0Dt5dnIFqA6GME1aTjQzXRl/4kpl+K5IrI
	 oxyYZmsULwDHMB/wCo95qN7GpLx+Kbu35Uj7K+wE=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.51) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f51.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5494bc4d741so170264e87.2;
        Thu, 27 Feb 2025 09:28:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV15bLyJCNS+qyLJjBfu3EstP4Lw92YYbVlREUzkT6mYtOcw3NjqogWqLl+T7g216M1Y+86aJTZE0cMiBFpdTOA+mzPJA==@vger.kernel.org,
 AJvYcCV6eOH/BepLkE94Z7KrwiA3HqTi3Ub4w5QVtaRdJybGcqVfProyY2WRJqGk70ugCi+cxFdamTZncEhYvKex@vger.kernel.org,
 AJvYcCX8awZXDLweIcvAfJfG5FATDG5gtgPrrnmwNh9xRtkpq32pySoBY6ezRR+q65k0uz/Cqc2VpmoCiqWF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+H1+Di6EFYHG1SEVfKH6YnYv6Qr/G1Ikq9OkCf4xgTzk3yRC
	IFCTsLWPkAW5MGBiuzZM/f8NJrFKXhNC5zllYBz/o9kBdaOU9OsWc4jq10mtR/mPgMNA5TRfvr8
	7y1oNo2YO0veCC7WrBHtnp3u6ZK8=
X-Google-Smtp-Source: 
 AGHT+IG7UkmgUD97cjOzynCm+z0eL9rr30mWW5Hs435/iy6GpesJxUsye64CEJqei3gpXE2KvSk5Z/2W4rlzAaC1dPY=
X-Received: by 2002:a05:6512:114b:b0:545:d72:95e5 with SMTP id
 2adb3069b0e04-5494c107c7emr206581e87.7.1740677298628; Thu, 27 Feb 2025
 09:28:18 -0800 (PST)
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
 <CAGwozwGNV0gccAH-TXCi4PCnuWFOA0v8KkiZJ8Z+fZ+_ft6UAA@mail.gmail.com>
 <1722456c-1c1d-4213-a7dd-926a650fd0c6@amd.com>
In-Reply-To: <1722456c-1c1d-4213-a7dd-926a650fd0c6@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 27 Feb 2025 18:28:04 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEqVkDC_HvuJhGE=PUep-73RVFnuZNWh0E+8ucfko1F8g@mail.gmail.com>
X-Gm-Features: AQ5f1JrWZnOZ_3gXRf7f-fGTYakbjzUXySofcvqILgBQ0zXDMBnQ3pw1wz6pIAI
Message-ID: 
 <CAGwozwEqVkDC_HvuJhGE=PUep-73RVFnuZNWh0E+8ucfko1F8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: platform_profile: make amd-pmf a secondary
 handler
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
	me@kylegospodneti.ch, luke@ljones.dev
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174067729971.13119.14815397925895685673@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 27 Feb 2025 at 18:24, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/27/2025 11:18, Antheas Kapenekakis wrote:
> > On Thu, 27 Feb 2025 at 18:10, Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 2/27/2025 11:04, Antheas Kapenekakis wrote:
> >>> On Thu, 27 Feb 2025 at 17:46, Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> On 2/27/2025 09:36, Antheas Kapenekakis wrote:
> >>>>> Since amd-pmf is expected to run alongside other platform handlers, it
> >>>>> should be able to accept all platform profiles. Therefore, mark it as
> >>>>> secondary and in the case of a custom profile, make it NOOP without an
> >>>>> error to allow primary handlers to receive a custom profile.
> >>>>> The sysfs endpoint will still report custom, after all.
> >>>>>
> >>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>> ---
> >>>>>     drivers/platform/x86/amd/pmf/spc.c | 3 +++
> >>>>>     drivers/platform/x86/amd/pmf/sps.c | 8 ++++++++
> >>>>>     2 files changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
> >>>>> index f34f3130c330..99c48378f943 100644
> >>>>> --- a/drivers/platform/x86/amd/pmf/spc.c
> >>>>> +++ b/drivers/platform/x86/amd/pmf/spc.c
> >>>>> @@ -219,12 +219,15 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
> >>>>>
> >>>>>         switch (dev->current_profile) {
> >>>>>         case PLATFORM_PROFILE_PERFORMANCE:
> >>>>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> >>>>>                 val = TA_BEST_PERFORMANCE;
> >>>>>                 break;
> >>>>>         case PLATFORM_PROFILE_BALANCED:
> >>>>>                 val = TA_BETTER_PERFORMANCE;
> >>>>>                 break;
> >>>>>         case PLATFORM_PROFILE_LOW_POWER:
> >>>>> +     case PLATFORM_PROFILE_COOL:
> >>>>> +     case PLATFORM_PROFILE_QUIET:
> >>>>>                 val = TA_BEST_BATTERY;
> >>>>
> >>>> I would really prefer we do the absolute bare minimum to help this issue
> >>>> on ASUS (just special case quiet) and leave adding compat for other
> >>>> profiles for other development.
> >>>
> >>> I cannot risk other drivers having their options disabled. This can
> >>> have carry-on effects in other drivers too.
> >>>
> >>> Including in the legion v3 driver, in which you will end up disabling
> >>> balanced-performance. Since Derek posted the v3 for that today.
> >>>
> >>
> >> Sure - but let's handle that separately from this bug fix.  That driver
> >> will be targeted to 6.15 or later.
> >>
> >> We need to be cognizant about what can go into 6.14 needs to be bug
> >> fixes for drivers in tree.
> >
> > For me to consider this problem resolved, I need a mitigation that
> > matches the behavior of this patch series 1-1.
> >
> > If you have a better suggestion, I can implement it and test it real quick.
>
> I think just covering the QUIET == LOW_POWER is the important one for now.

Sure, how do we do that? You want to make amd-pmf accept both just for
6.14? I would be ok with that.

> >
> > If this issue is not fully resolved, it will cause a lot of downstream
> > issues that will result in the legacy interface becoming unusable.
> >
> > Acer and alienware implement balanced performance too. In the current tree.
>
> But do Acer and Alienware have designs that amd-pmf will bind at the
> same time?
>
> I'm not so sure.

From a quick google search, Acer Swift Edge 16 - 8840U. But we do not
have a lot of acer users I'd say.

> >
> snip
> >>
>

