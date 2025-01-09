Return-Path: <linux-acpi+bounces-10500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5014FA08337
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 00:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD94B188BB3B
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B0204F98;
	Thu,  9 Jan 2025 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0KIKgXR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB8171658;
	Thu,  9 Jan 2025 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736463770; cv=none; b=u/Dt7aQYzoK8hxjdjhassyMxpqUubTumgxEkAu1CZ5CsdTGm1W7jMsBOH4BiK93eEG2+FcZK9+GwAbjkIURCPOV4Hjl2ozPc6VE80/PQHQRC2XR6v2TfUdD9Kt1S+UBnQsidK93XZI6DAb/fZZflYs/V5tX0zzrkglz0K30TiiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736463770; c=relaxed/simple;
	bh=G1C5M9Im2WE2lp8/0grSpGnWZYPCml4SvBjHerZb1Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckn6T/MiQ6y12dMeexsB8M8U4qIxgOxxdJdXTTZovZTWwnOdmzF+NweJXScQjDItbYLPiJyAESYdA3hup6gh+0F05uC+gYxcrQCWocDWyBa7/lAf9a+yWRKsQm1QH8erNO9kACZYlnrHPZh+folUMRWpQwLTMxKukaO+y4QJD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0KIKgXR; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5162571e761so534196e0c.2;
        Thu, 09 Jan 2025 15:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736463767; x=1737068567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+l0uaGvq7p01EImTDjUMKg1mmFv0ZoDTEyoqJIxhds=;
        b=M0KIKgXRn45tFpDcICO/ns8eoLyDYVNTtbTRsU3OEGGn7QGDXsqW1+36k2XF79rqlz
         UscuE6zhAaw6ozQ5jpMmK/kbdyT84PF9LY/pv8/NS9uVLJ+q+83B8grkfOzYU7dr9p/a
         TAKAfiQAGSEb6IrEDz8AypO2byA3GaFU2MUY97pPDQwgiQ3zXqCQg4Fv7oRkvyKTYcrH
         uM8xigeOLm2NbIMM2B75Ga+zUaJQQiorBuC53QOtMjd18919vRsgolguGKjHvGdGjDlf
         hrVAR51TDLGmFPHwh0AVRRJWZcKkUjHBAi0yHzJ36d+CgOPmSqPAcOcJSTxvDoeCsvss
         t1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736463767; x=1737068567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+l0uaGvq7p01EImTDjUMKg1mmFv0ZoDTEyoqJIxhds=;
        b=aPwv2eQo3H+gP0+diGclBB3kfyHb+M83sHgpomTHzAgjYl11dAYC3aB497b3ezyz8A
         muFBZ+9JKLNqe1xKpvNJVjZBIb83PZlNJ6JatfdYRLt6XdiSCIdodB+WOaAyVD+W2RK+
         GCzeTSAHlczUtzE+f9xYhkMpVmw8biwgZrG9U5Hx8bIwP622utKvckN+NkWJXFNy/KCX
         hxjbi9UqZZVgDz21HFQsNvtp0gyo3zOBA8gnkbSp22QAFe3SKx4X1US/zbY95C8kiF4q
         v3jD+LA28D9oN4D5f9XCaFEAKs1QrPh64aZMRXcrom5mx/6+Hx4O8ms6aK4EpxdmBHW8
         cMjw==
X-Forwarded-Encrypted: i=1; AJvYcCUQdzBhHtwfPzZuIz5ylRyI+l1X4ydLd+mMyXmnqIysYnoNdlp9uQGpfn4TdMrA9ZgswhVJSRGVdB9s@vger.kernel.org, AJvYcCVmhaZtQecd7PUw9k2pYatFz4cG7ddBq8cSFaJlJCeOe7vHdJVcoUpySK7DYD9uE48+oIspCt3RZ1Zy2MzA@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEyBn8Xpi9kNUeWka4BXSglb1OhL13gdezFunQpDmuQpP4Iv4
	jMv8/9Qj0Si/P6FTXsM3Q5tXp4EXQPYOdL4LrGkTHE1iqPNhTqpJ
X-Gm-Gg: ASbGncuSDPBcBSHTpdFfUdXVdxrE/LkgFQDgDlTRmViHNyGyKWh8X76jXYKK/dwn7sT
	jJLI4tHB3lcF8wIhahVYzVN3jItoIPlRzJOT7mavAA76ii31TgAWNjOmo4m3aINMgwTpsyyqpGl
	3MY2I9LchuKSp92cip5qvp3YwbZ5E/4u9Y5VMcKrqZz/SNEGW02K2NX6i/SE7ZDIJHT6+JOgzBN
	1yOPNza/j+iQb4nBPghziGO+yVCZRiWsNhgJ7d0frpgL6q+Esqbt/eY
X-Google-Smtp-Source: AGHT+IGv0tQHRLQYl9ZQE2Y+HBqUpnSt/LuM0e4RJijbr4XnBofH91qiVH/39Z5GawiwbdisAd50Eg==
X-Received: by 2002:a05:6122:4585:b0:509:e7d:b7b2 with SMTP id 71dfb90a1353d-51c6c4302fbmr8521004e0c.2.1736463766695;
        Thu, 09 Jan 2025 15:02:46 -0800 (PST)
Received: from alphacentauri ([2800:bf0:179:113e:f067:4e25:4298:6451])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fbd3401sm1400746e0c.16.2025.01.09.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 15:02:45 -0800 (PST)
Date: Thu, 9 Jan 2025 18:02:41 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Joshua Grisham <josh@joshuagrisham.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
	Ike Panhc <ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Colin Ian King <colin.i.king@gmail.com>, 
	Alexis Belmonte <alexbelm48@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
	ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH 02/18] ACPI: platform_profile: Add `choices` to
 platform_profile_ops
Message-ID: <nhc6pz63hsh4io6q4dvcnv72ycr57ropcfrhljr6qvxvi4frzu@imexq5k7ejzu>
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-3-kuurtb@gmail.com>
 <1c921cca-1ac8-4e73-94e2-79884f596287@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c921cca-1ac8-4e73-94e2-79884f596287@amd.com>

On Thu, Jan 09, 2025 at 10:32:31AM -0600, Mario Limonciello wrote:
> On 1/9/2025 09:06, Kurt Borja wrote:
> > Add a `choices` callback to platform_profile_ops, which lets drivers
> > specify how to select available profiles.
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
> > index 39a22e27acc5..9cb82173947c 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -464,12 +464,21 @@ int platform_profile_register(struct platform_profile_handler *pprof)
> >   	int err;
> >   	/* Sanity check the profile handler */
> > -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> > -	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
> > +	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> > +	    !pprof->ops->choices) {
> >   		pr_err("platform_profile: handler is invalid\n");
> >   		return -EINVAL;
> >   	}
> > +	err = pprof->ops->choices(pprof);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> > +		pr_err("platform_profile: no available profiles\n");
> > +		return -EINVAL;
> > +	}
> > +
> >   	guard(mutex)(&profile_lock);
> >   	/* create class interface for individual handler */
> > diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> > index 2a9716372d56..b69fcc4c3858 100644
> > --- a/drivers/platform/surface/surface_platform_profile.c
> > +++ b/drivers/platform/surface/surface_platform_profile.c
> > @@ -201,9 +201,20 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
> >   	return tp;
> >   }
> > +static int ssam_platform_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> 
> At first I didn't really like the callback, but it grew on me and I realized
> why I didn't like it is because it's confusing that the callback is called
> .choices() as well as the implementation used is called .choices.

To be fair, it is kind of ugly until the end of the series.

> 
> If anything it should be "set_choices" or "probe" with a slight leaning on
> probe()..

I agree. I'm going to rename it to probe, it's more general too. 

My only concern is that "probe" is very associated with the bus_type
abstraction. But it is a probe, so...

Thank you so much for reviewing this and for your feedback Mario.

~ Kurt

> 
> With probe the flow could be:
> 
> driver()
> ->platform_profile_register(ops)
> ->->drivers's implementation for platform_profile_probe()
> 
> 
> > +}
> > +
> >   static const struct platform_profile_ops ssam_platform_profile_ops = {
> >   	.profile_get = ssam_platform_profile_get,
> >   	.profile_set = ssam_platform_profile_set,
> > +	.choices = ssam_platform_profile_choices,
> >   };
> >   static int surface_platform_profile_probe(struct ssam_device *sdev)
> > @@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
> >   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> > -
> >   	return platform_profile_register(&tpd->handler);
> >   }
> > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> > index ac7b3ab8fd2a..1fa0cd69da8c 100644
> > --- a/drivers/platform/x86/acer-wmi.c
> > +++ b/drivers/platform/x86/acer-wmi.c
> > @@ -1900,9 +1900,22 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > +static int
> > +acer_predator_v4_platform_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
> >   	.profile_get = acer_predator_v4_platform_profile_get,
> >   	.profile_set = acer_predator_v4_platform_profile_set,
> > +	.choices = acer_predator_v4_platform_profile_choices,
> >   };
> >   static int acer_platform_profile_setup(struct platform_device *device)
> > @@ -1915,17 +1928,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
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
> >   		err = platform_profile_register(&platform_profile_handler);
> >   		if (err)
> >   			return err;
> > diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> > index 7c8391ac4dbb..37316bc3e071 100644
> > --- a/drivers/platform/x86/amd/pmf/sps.c
> > +++ b/drivers/platform/x86/amd/pmf/sps.c
> > @@ -387,9 +387,19 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > +static int amd_pmf_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops amd_pmf_profile_ops = {
> >   	.profile_get = amd_pmf_profile_get,
> >   	.profile_set = amd_pmf_profile_set,
> > +	.choices = amd_pmf_profile_choices,
> >   };
> >   int amd_pmf_init_sps(struct amd_pmf_dev *dev)
> > @@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
> >   	dev->pprof.dev = dev->dev;
> >   	dev->pprof.ops = &amd_pmf_profile_ops;
> > -	/* Setup supported modes */
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
> > -
> >   	/* Create platform_profile structure and register */
> >   	err = platform_profile_register(&dev->pprof);
> >   	if (err)
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index ef4129d91656..3e94986078a6 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3852,9 +3852,19 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> >   	return throttle_thermal_policy_write(asus);
> >   }
> > +static int asus_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
> >   	.profile_get = asus_wmi_platform_profile_get,
> >   	.profile_set = asus_wmi_platform_profile_set,
> > +	.choices = asus_wmi_platform_profile_choices,
> >   };
> >   static int platform_profile_setup(struct asus_wmi *asus)
> > @@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
> >   	asus->platform_profile_handler.dev = dev;
> >   	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
> > -	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED,
> > -		asus->platform_profile_handler.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE,
> > -		asus->platform_profile_handler.choices);
> > -
> >   	err = platform_profile_register(&asus->platform_profile_handler);
> >   	if (err == -EEXIST) {
> >   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index c824414565b6..386b22e9c922 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -1108,12 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
> >   	return wmax_thermal_control(supported_thermal_profiles[profile]);
> >   }
> > -static const struct platform_profile_ops awcc_platform_profile_ops = {
> > -	.profile_get = thermal_profile_get,
> > -	.profile_set = thermal_profile_set,
> > -};
> > -
> > -static int create_thermal_profile(struct platform_device *platform_device)
> > +static int thermal_profile_choices(struct platform_profile_handler *pprof)
> >   {
> >   	u32 out_data;
> >   	u8 sys_desc[4];
> > @@ -1146,19 +1141,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
> >   		profile = wmax_mode_to_platform_profile[mode];
> >   		supported_thermal_profiles[profile] = out_data;
> > -		set_bit(profile, pp_handler.choices);
> > +		set_bit(profile, pprof->choices);
> >   	}
> > -	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> > +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST))
> >   		return -ENODEV;
> >   	if (quirks->gmode) {
> >   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
> >   			WMAX_THERMAL_MODE_GMODE;
> > -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> >   	}
> > +	return 0;
> > +}
> > +
> > +static const struct platform_profile_ops awcc_platform_profile_ops = {
> > +	.profile_get = thermal_profile_get,
> > +	.profile_set = thermal_profile_set,
> > +	.choices = thermal_profile_choices,
> > +};
> > +
> > +static int create_thermal_profile(struct platform_device *platform_device)
> > +{
> >   	pp_handler.name = "alienware-wmi";
> >   	pp_handler.dev = &platform_device->dev;
> >   	pp_handler.ops = &awcc_platform_profile_ops;
> > diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> > index 1751b7235031..ba366c28d9a6 100644
> > --- a/drivers/platform/x86/dell/dell-pc.c
> > +++ b/drivers/platform/x86/dell/dell-pc.c
> > @@ -24,6 +24,7 @@
> >   #include "dell-smbios.h"
> >   static struct platform_device *platform_device;
> > +static int supported_modes;
> >   static const struct dmi_system_id dell_device_table[] __initconst = {
> >   	{
> > @@ -231,15 +232,29 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > +static int thermal_platform_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	if (supported_modes & DELL_QUIET)
> > +		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > +	if (supported_modes & DELL_COOL_BOTTOM)
> > +		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> > +	if (supported_modes & DELL_BALANCED)
> > +		set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	if (supported_modes & DELL_PERFORMANCE)
> > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> >   	.profile_get = thermal_platform_profile_get,
> >   	.profile_set = thermal_platform_profile_set,
> > +	.choices = thermal_platform_profile_choices,
> >   };
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
> >   	ret = platform_profile_register(thermal_handler);
> >   	if (ret)
> > diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> > index c37e44f7606c..3c2d4549eb7f 100644
> > --- a/drivers/platform/x86/hp/hp-wmi.c
> > +++ b/drivers/platform/x86/hp/hp-wmi.c
> > @@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > +static int hp_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	if (is_omen_thermal_profile()) {
> > +		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> > +	} else if (is_victus_thermal_profile()) {
> > +		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > +	} else {
> > +		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> > +	}
> > +
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static int omen_powersource_event(struct notifier_block *nb,
> >   				  unsigned long value,
> >   				  void *data)
> > @@ -1568,16 +1585,19 @@ static inline void omen_unregister_powersource_event_handler(void)
> >   static const struct platform_profile_ops platform_profile_omen_ops = {
> >   	.profile_get = platform_profile_omen_get,
> >   	.profile_set = platform_profile_omen_set,
> > +	.choices = hp_wmi_platform_profile_choices,
> >   };
> >   static const struct platform_profile_ops platform_profile_victus_ops = {
> >   	.profile_get = platform_profile_victus_get,
> >   	.profile_set = platform_profile_victus_set,
> > +	.choices = hp_wmi_platform_profile_choices,
> >   };
> >   static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
> >   	.profile_get = hp_wmi_platform_profile_get,
> >   	.profile_set = hp_wmi_platform_profile_set,
> > +	.choices = hp_wmi_platform_profile_choices,
> >   };
> >   static int thermal_profile_setup(struct platform_device *device)
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
> >   	err = platform_profile_register(&platform_profile_handler);
> >   	if (err)
> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> > index b49ee94f9bee..f5ea03763a54 100644
> > --- a/drivers/platform/x86/ideapad-laptop.c
> > +++ b/drivers/platform/x86/ideapad-laptop.c
> > @@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
> >   	return -EINTR;
> >   }
> > +static int dytc_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static void dytc_profile_refresh(struct ideapad_private *priv)
> >   {
> >   	enum platform_profile_option profile;
> > @@ -1066,6 +1075,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
> >   static const struct platform_profile_ops dytc_profile_ops = {
> >   	.profile_get = dytc_profile_get,
> >   	.profile_set = dytc_profile_set,
> > +	.choices = dytc_profile_choices,
> >   };
> >   static int ideapad_dytc_profile_init(struct ideapad_private *priv)
> > @@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
> >   	priv->dytc->priv = priv;
> >   	priv->dytc->pprof.ops = &dytc_profile_ops;
> > -	/* Setup supported modes */
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
> > -
> >   	/* Create platform_profile structure and register */
> >   	err = platform_profile_register(&priv->dytc->pprof);
> >   	if (err)
> > diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> > index 38d4745f6be1..8fa9308d4686 100644
> > --- a/drivers/platform/x86/inspur_platform_profile.c
> > +++ b/drivers/platform/x86/inspur_platform_profile.c
> > @@ -166,9 +166,19 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > +static int inspur_platform_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops inspur_platform_profile_ops = {
> >   	.profile_get = inspur_platform_profile_get,
> >   	.profile_set = inspur_platform_profile_set,
> > +	.choices = inspur_platform_profile_choices,
> >   };
> >   static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
> > @@ -186,10 +196,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
> >   	priv->handler.dev = &wdev->dev;
> >   	priv->handler.ops = &inspur_platform_profile_ops;
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> > -
> >   	return platform_profile_register(&priv->handler);
> >   }
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index 04a292af2bfc..a35453c3c605 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -10538,9 +10538,19 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
> >   	return err;
> >   }
> > +static int dytc_profile_choices(struct platform_profile_handler *pprof)
> > +{
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct platform_profile_ops dytc_profile_ops = {
> >   	.profile_get = dytc_profile_get,
> >   	.profile_set = dytc_profile_set,
> > +	.choices = dytc_profile_choices,
> >   };
> >   static struct platform_profile_handler dytc_profile = {
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
> > index a9db95bc360d..972a62be60b2 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -34,6 +34,7 @@ struct platform_profile_ops {
> >   				enum platform_profile_option *profile);
> >   	int (*profile_set)(struct platform_profile_handler *pprof,
> >   				enum platform_profile_option profile);
> > +	int (*choices)(struct platform_profile_handler *pprof);
> >   };
> >   struct platform_profile_handler {
> 

