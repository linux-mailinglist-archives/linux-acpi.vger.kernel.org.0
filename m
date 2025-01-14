Return-Path: <linux-acpi+bounces-10626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F5AA10C4C
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9711674D3
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A21885BF;
	Tue, 14 Jan 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE9EiW8+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458D232459;
	Tue, 14 Jan 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872290; cv=none; b=nWyDt1uV1kDyfMkPRomf66urjM0fiFTBQeOSjD+bnUS8IUNAX0sYTmHd1DFpCh1ewt5evBUPOTjugBjNReiPCIktsw3Tpdwr0PecWo31xpSLwLw8nTRo6gQMHvNmo9tQFKrFr5gMhUmV2KBuNac8Ag8hz2iHVKGO5VEhswszOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872290; c=relaxed/simple;
	bh=P9K5NKDIVzq/z0N2T6ss8Z3HFbz0/CvU1y4fZ2J3bc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr/F/9bargVqnonkO71H0Ga3NFS66yJpxb96oEwTGnK69WXNKrP0bQRv2rT09uZvQCKa/QVddWfq7yvKDAzyFO6HCONKb/M5J1V+d5QNExg+SMUoHxHtk9M5seik8lHq7jRiBoaCOOKoVk5s4QHDUOTjcJog4ZCjqrZXfl0OSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE9EiW8+; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e4a6b978283so10924541276.0;
        Tue, 14 Jan 2025 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736872286; x=1737477086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAAztX1oAoDJ3wHJqZ04YpZEnUJlQEKqq6Ayu7Ye1/4=;
        b=CE9EiW8+DPZcvuikwWgDbQmr1ScsYb44f+omnHe6aPyA4VvNhuGpm5D+5i/P1CHAAn
         okxydXMER4Uf71L96nSM6Xm+cFlOaDawbQtlX8viAhgCg9UjmyE8Zzru9g1ICbHu/ncA
         /yc3pYl0mtVMrdTenZCiFZ1XDkNEfiyoaFsqnB/McMaEGKk6/PyHxJpEVgqz6s5gHbKF
         nxKCWI7sI3po6cy9rBo6ln6B1NYZjHZCsdLsE8UKvM6WVj4Whr+2gVlco0N8BjpIPWIV
         SU7bAIFpuu7tXlEC5ldSNJdv1SA5SsTTROGPvqDgWPClRh6dbEtSDb9UzsN3DFEIMrvO
         zmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736872286; x=1737477086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAAztX1oAoDJ3wHJqZ04YpZEnUJlQEKqq6Ayu7Ye1/4=;
        b=uJ0G5Lv7fz8SWBGkkD0efIOg4sLrydttVcpXF7m7RglbpZCxbV/vqM1bMquhMsq7vQ
         6JCKCAfuACVOW5/sjqw851o79ArRCbAjo7ZGfUwNMzOHL6qe6jef4icOELenAruwqj9Y
         J27g4dIAu42+7k4VfieXuw4hf9PaiOAyOXEyzGF/Fl1Ud5MPsDsfYVOiSDZhFu+VtMHh
         4xQvyDHh1D4cZkR0M/r/n/Hw9qgoEupOJSIR9bRAT6/NmKdEw1ijA4L33HEEZ4Br5Wb4
         zuIjiCh4NQRArWvmWZH3G5CjsY4or+0NhKezna3sOpbQdlogbRYfKNuXPXrQHO1/6IXQ
         HkOA==
X-Forwarded-Encrypted: i=1; AJvYcCWYs+qNQ5sBLYMuY1Y7EMrAqzIrUHpqF/q+Q+uqQogax/CALVj3soRfNBovND8ORoGuhBdDaeMgrmL+@vger.kernel.org, AJvYcCWtnhuHtIi6btPrpkd7OTTWSYaxkI8G9CN+GWHCM0it1TaxkQ59HzT+vsHJ2RvyGQ1N2U2hzsBQxQLfMa5d@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBf9riYS60SN8/anW/DXD5JCTyrYkA5MSP/egKMjS6tyoo3Hk
	t64oUQnJwEelJDbF9SqGhwcZ+znbkbK5fYewsykBuSeN9Ix1QlG3
X-Gm-Gg: ASbGncsrKynPaTc6Xq1ZbmUq/fUrY1Zk47Blydfm8db3VU4Z6Epqt5dTQH8YwsYNer3
	4yPEr9WOcmbdl8ucgAehQM/heLVjhdjT3UAwW2IxryGqJACzvY5Eo+7nyPiupqTS3wkg8DqB4v+
	e6wPOBFSy3ksFvfi7n9hjzxAfGq4gtFO3Pd8ZLPIQC9BvcAwKlQaGDv8hRpswrx35asGnEETCZu
	n+AFtM+aX0ri4M7D/CUq4cPQVDVOmn+mFtezCtRaWgR5KBZhc9UzA==
X-Google-Smtp-Source: AGHT+IFzqREaF4Bng0RwNhOKJKuPSDjzCAoNwi/6Z2mevhyc2CVkMYmy4RFSLnevLVL/GL4pW/JDGg==
X-Received: by 2002:a05:690c:6f06:b0:6e2:1c94:41f8 with SMTP id 00721157ae682-6f5494ea761mr164605937b3.10.1736872286033;
        Tue, 14 Jan 2025 08:31:26 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bd3sm21940237b3.49.2025.01.14.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:31:25 -0800 (PST)
Date: Tue, 14 Jan 2025 11:31:20 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Joshua Grisham <josh@joshuagrisham.com>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
	Ike Panhc <ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Alexis Belmonte <alexbelm48@gmail.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
	ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 05/18] ACPI: platform_profile: Add `probe` to
 platform_profile_ops
Message-ID: <k36dxs46y5riaiqwvse5ldxeiday6o6p2j74kmsusnmnkwsoyx@m5iyooae27dr>
References: <20250114153726.11802-1-kuurtb@gmail.com>
 <20250114153726.11802-6-kuurtb@gmail.com>
 <a0a3fecf-6b03-48f8-a03d-a7076f31e2dc@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a3fecf-6b03-48f8-a03d-a7076f31e2dc@amd.com>

Hi Mario,

On Tue, Jan 14, 2025 at 10:20:15AM -0600, Mario Limonciello wrote:
> On 1/14/2025 09:37, Kurt Borja wrote:
> > Add a `probe` callback to platform_profile_ops, which lets drivers
> > initialize the choices member manually.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >   drivers/acpi/platform_profile.c               | 13 +++++++--
> >   .../surface/surface_platform_profile.c        | 16 ++++++----
> >   drivers/platform/x86/acer-wmi.c               | 24 ++++++++-------
> >   drivers/platform/x86/amd/pmf/sps.c            | 15 ++++++----
> >   drivers/platform/x86/asus-wmi.c               | 16 ++++++----
> >   drivers/platform/x86/dell/alienware-wmi.c     | 24 +++++++++------
> >   drivers/platform/x86/dell/dell-pc.c           | 26 ++++++++++-------
> >   drivers/platform/x86/hp/hp-wmi.c              | 29 +++++++++++++------
> >   drivers/platform/x86/ideapad-laptop.c         | 15 ++++++----
> >   .../platform/x86/inspur_platform_profile.c    | 14 ++++++---
> >   drivers/platform/x86/thinkpad_acpi.c          | 15 ++++++----
> >   include/linux/platform_profile.h              |  1 +
> >   12 files changed, 137 insertions(+), 71 deletions(-)
> > 
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> > index 440654e21620..34e22b006ccc 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -466,12 +466,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
> >   	int err;
> >   	/* Sanity check the profile handler */
> > -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> > -	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
> > +	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> > +	    !pprof->ops->probe) {
> >   		pr_err("platform_profile: handler is invalid\n");
> >   		return -EINVAL;
> >   	}
> > +	err = pprof->ops->probe(drvdata, pprof->choices);
> > +	if (err < 0)
> 
> Any particular reason to specifically look for less than zero?  Did you want
> to have the probe() return something positive in some circumstances?
> 
> If not I think this should be fine:
> 
> if (err)

Ack.

I did it out of habit.

> 
> > +		return err;
> > +
> > +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> > +		pr_err("platform_profile: no available profiles\n");
> 
> Doesn't pr_fmt handle the prefix?

This file doesn't have pr_fmt :( I'll log it with dev_err and add a
pr_fmt in a separate patch.

Thank you again for reviewing this!

If Ilpo doesn't have any comments I'll send a v3 right away.

~ Kurt

> 
> > +		return -EINVAL;
> > +	}
> > +
> >   	guard(mutex)(&profile_lock);
> >   	/* create class interface for individual handler */
> > diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> > index 76967bfeeef8..48cfe9cb89c8 100644
> > --- a/drivers/platform/surface/surface_platform_profile.c
> > +++ b/drivers/platform/surface/surface_platform_profile.c
> > @@ -201,7 +201,18 @@ static int ssam_platform_profile_set(struct device *dev,
> >   	return tp;
> >   }
> > +static int ssam_platform_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops ssam_platform_profile_ops = {
> > +	.probe = ssam_platform_profile_probe,
> >   	.profile_get = ssam_platform_profile_get,
> >   	.profile_set = ssam_platform_profile_set,
> >   };
> > @@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
> >   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> > -
> >   	return platform_profile_register(&tpd->handler, tpd);
> >   }
> > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> > index 91ae48adf6cf..6953e36dbfde 100644
> > --- a/drivers/platform/x86/acer-wmi.c
> > +++ b/drivers/platform/x86/acer-wmi.c
> > @@ -1916,7 +1916,20 @@ acer_predator_v4_platform_profile_set(struct device *dev,
> >   	return 0;
> >   }
> > +static int
> > +acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
> > +	.probe = acer_predator_v4_platform_profile_probe,
> >   	.profile_get = acer_predator_v4_platform_profile_get,
> >   	.profile_set = acer_predator_v4_platform_profile_set,
> >   };
> > @@ -1931,17 +1944,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
> >   		platform_profile_handler.ops =
> >   			&acer_predator_v4_platform_profile_ops;
> > -		set_bit(PLATFORM_PROFILE_PERFORMANCE,
> > -			platform_profile_handler.choices);
> > -		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > -			platform_profile_handler.choices);
> > -		set_bit(PLATFORM_PROFILE_BALANCED,
> > -			platform_profile_handler.choices);
> > -		set_bit(PLATFORM_PROFILE_QUIET,
> > -			platform_profile_handler.choices);
> > -		set_bit(PLATFORM_PROFILE_LOW_POWER,
> > -			platform_profile_handler.choices);
> > -
> >   		err = platform_profile_register(&platform_profile_handler, NULL);
> >   		if (err)
> >   			return err;
> > diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> > index 6ae82ae86d22..e710405b581f 100644
> > --- a/drivers/platform/x86/amd/pmf/sps.c
> > +++ b/drivers/platform/x86/amd/pmf/sps.c
> > @@ -387,7 +387,17 @@ static int amd_pmf_profile_set(struct device *dev,
> >   	return 0;
> >   }
> > +static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops amd_pmf_profile_ops = {
> > +	.probe = amd_pmf_profile_probe,
> >   	.profile_get = amd_pmf_profile_get,
> >   	.profile_set = amd_pmf_profile_set,
> >   };
> > @@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
> >   	dev->pprof.dev = dev->dev;
> >   	dev->pprof.ops = &amd_pmf_profile_ops;
> > -	/* Setup supported modes */
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
> > -
> >   	/* Create platform_profile structure and register */
> >   	err = platform_profile_register(&dev->pprof, dev);
> >   	if (err)
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index d88860dd028b..3d77f7454953 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3852,7 +3852,17 @@ static int asus_wmi_platform_profile_set(struct device *dev,
> >   	return throttle_thermal_policy_write(asus);
> >   }
> > +static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
> > +	.probe = asus_wmi_platform_profile_probe,
> >   	.profile_get = asus_wmi_platform_profile_get,
> >   	.profile_set = asus_wmi_platform_profile_set,
> >   };
> > @@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
> >   	asus->platform_profile_handler.dev = dev;
> >   	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
> > -	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED,
> > -		asus->platform_profile_handler.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE,
> > -		asus->platform_profile_handler.choices);
> > -
> >   	err = platform_profile_register(&asus->platform_profile_handler, asus);
> >   	if (err == -EEXIST) {
> >   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index f7a854d40575..0146d2f93be6 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -1078,12 +1078,7 @@ static int thermal_profile_set(struct device *dev,
> >   	return wmax_thermal_control(supported_thermal_profiles[profile]);
> >   }
> > -static const struct platform_profile_ops awcc_platform_profile_ops = {
> > -	.profile_get = thermal_profile_get,
> > -	.profile_set = thermal_profile_set,
> > -};
> > -
> > -static int create_thermal_profile(struct platform_device *platform_device)
> > +static int thermal_profile_probe(void *drvdata, unsigned long *choices)
> >   {
> >   	enum platform_profile_option profile;
> >   	enum wmax_thermal_mode mode;
> > @@ -1116,19 +1111,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
> >   		profile = wmax_mode_to_platform_profile[mode];
> >   		supported_thermal_profiles[profile] = out_data;
> > -		set_bit(profile, pp_handler.choices);
> > +		set_bit(profile, choices);
> >   	}
> > -	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> > +	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
> >   		return -ENODEV;
> >   	if (quirks->gmode) {
> >   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
> >   			WMAX_THERMAL_MODE_GMODE;
> > -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	}
> > +	return 0;
> > +}
> > +
> > +static const struct platform_profile_ops awcc_platform_profile_ops = {
> > +	.probe = thermal_profile_probe,
> > +	.profile_get = thermal_profile_get,
> > +	.profile_set = thermal_profile_set,
> > +};
> > +
> > +static int create_thermal_profile(struct platform_device *platform_device)
> > +{
> >   	pp_handler.name = "alienware-wmi";
> >   	pp_handler.dev = &platform_device->dev;
> >   	pp_handler.ops = &awcc_platform_profile_ops;
> > diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> > index 9010a231f209..32b3be0723f8 100644
> > --- a/drivers/platform/x86/dell/dell-pc.c
> > +++ b/drivers/platform/x86/dell/dell-pc.c
> > @@ -24,6 +24,7 @@
> >   #include "dell-smbios.h"
> >   static struct platform_device *platform_device;
> > +static int supported_modes;
> >   static const struct dmi_system_id dell_device_table[] __initconst = {
> >   	{
> > @@ -231,7 +232,22 @@ static int thermal_platform_profile_get(struct device *dev,
> >   	return 0;
> >   }
> > +static int thermal_platform_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	if (supported_modes & DELL_QUIET)
> > +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +	if (supported_modes & DELL_COOL_BOTTOM)
> > +		set_bit(PLATFORM_PROFILE_COOL, choices);
> > +	if (supported_modes & DELL_BALANCED)
> > +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	if (supported_modes & DELL_PERFORMANCE)
> > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> > +	.probe = thermal_platform_profile_probe,
> >   	.profile_get = thermal_platform_profile_get,
> >   	.profile_set = thermal_platform_profile_set,
> >   };
> > @@ -239,7 +255,6 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> >   static int thermal_init(void)
> >   {
> >   	int ret;
> > -	int supported_modes;
> >   	/* If thermal commands are not supported, exit without error */
> >   	if (!dell_smbios_class_is_supported(CLASS_INFO))
> > @@ -265,15 +280,6 @@ static int thermal_init(void)
> >   	thermal_handler->dev = &platform_device->dev;
> >   	thermal_handler->ops = &dell_pc_platform_profile_ops;
> > -	if (supported_modes & DELL_QUIET)
> > -		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> > -	if (supported_modes & DELL_COOL_BOTTOM)
> > -		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> > -	if (supported_modes & DELL_BALANCED)
> > -		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> > -	if (supported_modes & DELL_PERFORMANCE)
> > -		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> > -
> >   	/* Clean up if failed */
> >   	ret = platform_profile_register(thermal_handler, NULL);
> >   	if (ret)
> > diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> > index 60328b35be74..75bcd8460e7c 100644
> > --- a/drivers/platform/x86/hp/hp-wmi.c
> > +++ b/drivers/platform/x86/hp/hp-wmi.c
> > @@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct device *dev,
> >   	return 0;
> >   }
> > +static int hp_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	if (is_omen_thermal_profile()) {
> > +		set_bit(PLATFORM_PROFILE_COOL, choices);
> > +	} else if (is_victus_thermal_profile()) {
> > +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +	} else {
> > +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +		set_bit(PLATFORM_PROFILE_COOL, choices);
> > +	}
> > +
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static int omen_powersource_event(struct notifier_block *nb,
> >   				  unsigned long value,
> >   				  void *data)
> > @@ -1566,16 +1583,19 @@ static inline void omen_unregister_powersource_event_handler(void)
> >   }
> >   static const struct platform_profile_ops platform_profile_omen_ops = {
> > +	.probe = hp_wmi_platform_profile_probe,
> >   	.profile_get = platform_profile_omen_get,
> >   	.profile_set = platform_profile_omen_set,
> >   };
> >   static const struct platform_profile_ops platform_profile_victus_ops = {
> > +	.probe = hp_wmi_platform_profile_probe,
> >   	.profile_get = platform_profile_victus_get,
> >   	.profile_set = platform_profile_victus_set,
> >   };
> >   static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
> > +	.probe = hp_wmi_platform_profile_probe,
> >   	.profile_get = hp_wmi_platform_profile_get,
> >   	.profile_set = hp_wmi_platform_profile_set,
> >   };
> > @@ -1598,8 +1618,6 @@ static int thermal_profile_setup(struct platform_device *device)
> >   			return err;
> >   		platform_profile_handler.ops = &platform_profile_omen_ops;
> > -
> > -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> >   	} else if (is_victus_thermal_profile()) {
> >   		err = platform_profile_victus_get_ec(&active_platform_profile);
> >   		if (err < 0)
> > @@ -1614,8 +1632,6 @@ static int thermal_profile_setup(struct platform_device *device)
> >   			return err;
> >   		platform_profile_handler.ops = &platform_profile_victus_ops;
> > -
> > -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
> >   	} else {
> >   		tp = thermal_profile_get();
> > @@ -1631,15 +1647,10 @@ static int thermal_profile_setup(struct platform_device *device)
> >   			return err;
> >   		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
> > -
> > -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
> > -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> >   	}
> >   	platform_profile_handler.name = "hp-wmi";
> >   	platform_profile_handler.dev = &device->dev;
> > -	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
> >   	err = platform_profile_register(&platform_profile_handler, NULL);
> >   	if (err)
> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> > index 96e99513b0b5..050919a28d2b 100644
> > --- a/drivers/platform/x86/ideapad-laptop.c
> > +++ b/drivers/platform/x86/ideapad-laptop.c
> > @@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct device *dev,
> >   	return -EINTR;
> >   }
> > +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static void dytc_profile_refresh(struct ideapad_private *priv)
> >   {
> >   	enum platform_profile_option profile;
> > @@ -1064,6 +1073,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
> >   };
> >   static const struct platform_profile_ops dytc_profile_ops = {
> > +	.probe = dytc_profile_probe,
> >   	.profile_get = dytc_profile_get,
> >   	.profile_set = dytc_profile_set,
> >   };
> > @@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
> >   	priv->dytc->priv = priv;
> >   	priv->dytc->pprof.ops = &dytc_profile_ops;
> > -	/* Setup supported modes */
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
> > -
> >   	/* Create platform_profile structure and register */
> >   	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
> >   	if (err)
> > diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> > index d0a8e4eebffa..06df3aae9a56 100644
> > --- a/drivers/platform/x86/inspur_platform_profile.c
> > +++ b/drivers/platform/x86/inspur_platform_profile.c
> > @@ -164,7 +164,17 @@ static int inspur_platform_profile_get(struct device *dev,
> >   	return 0;
> >   }
> > +static int inspur_platform_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops inspur_platform_profile_ops = {
> > +	.probe = inspur_platform_profile_probe,
> >   	.profile_get = inspur_platform_profile_get,
> >   	.profile_set = inspur_platform_profile_set,
> >   };
> > @@ -184,10 +194,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
> >   	priv->handler.dev = &wdev->dev;
> >   	priv->handler.ops = &inspur_platform_profile_ops;
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> > -
> >   	return platform_profile_register(&priv->handler, priv);
> >   }
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index 9978fd36a3d1..5c250867678f 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -10538,7 +10538,17 @@ static int dytc_profile_set(struct device *dev,
> >   	return err;
> >   }
> > +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops dytc_profile_ops = {
> > +	.probe = dytc_profile_probe,
> >   	.profile_get = dytc_profile_get,
> >   	.profile_set = dytc_profile_set,
> >   };
> > @@ -10584,11 +10594,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> >   {
> >   	int err, output;
> > -	/* Setup supported modes */
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
> > -
> >   	err = dytc_command(DYTC_CMD_QUERY, &output);
> >   	if (err)
> >   		return err;
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> > index 6013c05d7b86..5ad1ab7b75e4 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -31,6 +31,7 @@ enum platform_profile_option {
> >   struct platform_profile_handler;
> >   struct platform_profile_ops {
> > +	int (*probe)(void *drvdata, unsigned long *choices);
> >   	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> >   	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
> >   };
> 

