Return-Path: <linux-acpi+bounces-10499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE210A082F4
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 23:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED63E3A7AF6
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 22:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DA22054E3;
	Thu,  9 Jan 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/RBAq9y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF644A1A;
	Thu,  9 Jan 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736463108; cv=none; b=UtFvT1kBnVCCby/wGynfYvmbeR2fBT8aJB5Y9NzxGGV+5b1WkSdnb7sHcZbBaesVXT1Dta/BuJ+gRu+mxjmXO65q/qyhkf3+43zE3sr10PJnetVGWXipN73VRijAi0bi+mETw91eTK8maggRc/O/QlxVSqFi48UyO6NQGmye6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736463108; c=relaxed/simple;
	bh=1M+KCOWXZSb8UT7wbZxzMM8UfwONM0GJ7IQUFIaW0Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFW7+5oHu5oU/dRx1tNhQVQuOHeNl9q5dx2ZRIAFnrZlapc4boKPKtnf6S3AjzRrTJhDHxHFUK9uwNAksBr01/wKXv5WxXJcEvjN60P0duSk5DmOc7Vfkz6uTkK9A0/LsqT2NDYyogPlyA5cyk6kRRmqRv4S8GYiPg8kD/Eeu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/RBAq9y; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-518a861612eso1172002e0c.1;
        Thu, 09 Jan 2025 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736463105; x=1737067905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGJnRWt0DgSi7hCIX2Q/eqKHJGFtLqyXOXzV5bzfFrU=;
        b=N/RBAq9yRu7H3RcKOs+/3QUEp94XTjxgnp/fNt2J/EKxqK9AqRGLZFX6fOkHLocAUJ
         Zpebrdb9qG9LvB8PdeiTrDq5RaL511/ahk3vGLiRgY27/whaodYHvVPxXNUpxqMF9w68
         l3R+yPwPpI6ogSySG3RBgI/7GpC9JDYw/KONjoY5f3Bo0Fu5ejnd8c0aHcXgm16WyjY6
         Ll025xcKnvrpc9/rF3Phdp8iAqZ7O0fZfD+83u8mtyFTW+CVBjrBGeMW8PbBX9KOdJBM
         atnlnsm+iwlz1JG6+xYmRtlAbz7Lys/H9fqLrGiB33f20WVaXawZn85NVYCh3FS+NRlG
         KBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736463105; x=1737067905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGJnRWt0DgSi7hCIX2Q/eqKHJGFtLqyXOXzV5bzfFrU=;
        b=OC73s8yD+Rp73QsDMkaYXh02QfMsYkS9n4G7yJ9tQtSgFLqkmQ7IgZjxRuffkvEZZu
         I5D3Vq6j/tSSaVrHfmKEVAg5CfZpXpGFDkPlcF4Uww3rNgjd0mEFeos6J9GJqCGNWOc3
         qLg65KfVAV8NsYnLSLMV38+m9saSlSDFB3SmAccJ5jm7FTokWtIeP5DBPy4slXvtgzhs
         hGR+rvAJ9xInMYMjb3zBGfDEsTmkWcLqehiDrJxa8uvR2eGCiesgNXjEM2xbysJZ0tbU
         9mANoEqizOPLrwvfK3dKxxApLXXmsaOmgINR8Ut2v7P6ngKfBfx5v3CgZpjZxVFSNCXQ
         qukQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaSH2esZtD5ENOR8twAVKeSt7X7a3kSywXMtyoe/s7unYpcTrC/55B63svIthchFGwFWjLlriCM7Pp@vger.kernel.org, AJvYcCX/Vn7nr+Mr2gmxtjhbvB0irszwq/Zq4f8czDDCNqwOlBeh6fxR1Xa1q9p3BmpXNUXO8sunN3VQBDVPl0sF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lht6rM4GaumLt3wph42fAb+DawG3Zh5s0eskEIy4EW2eJphm
	i2ngA0wt+63Fi9KabD0nG7rM+6x0bEFiI/z3qHlGDpmWPsxqs0Ak
X-Gm-Gg: ASbGncvLfQCVqYCwADaEQ6Eu9BkfAMrDVDG7SsbEtFcJZHABj26C9TSKAtfI+QMQPr0
	4KUzBGsPjgCi0vlZuskt0FeqQ43O+mpljmcOf6deM5jMCef3E5SI7kXUSx8xkb6YJzZ8WH16owf
	S/gQXBeuIy7eXrGYMVB4F6FrpCHyz49fanYYHXyQ+c6+jsiieNO1v7RHMrT62x2mTSUmkBeiSpS
	d0ZGRlVeRaCp98eJC20rZLN5PylXA0lVaAMDRPJ/w0Se9LFgjoIUlqv
X-Google-Smtp-Source: AGHT+IE2mxNyWuFtAfvYZvSGkL6+qxe7xBYhncNNvbv6hr7iigt4SJYruLMQSzBd1Wu+u2CwoWlmSQ==
X-Received: by 2002:ac5:c20d:0:b0:515:20e6:7861 with SMTP id 71dfb90a1353d-51c7c73f836mr4402427e0c.2.1736463104622;
        Thu, 09 Jan 2025 14:51:44 -0800 (PST)
Received: from alphacentauri ([2800:bf0:179:113e:f067:4e25:4298:6451])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fb9bcd9sm1410553e0c.6.2025.01.09.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 14:51:44 -0800 (PST)
Date: Thu, 9 Jan 2025 17:51:40 -0500
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
Subject: Re: [PATCH 15/18] ACPI: platform_profile: Remove
 platform_profile_handler from callbacks
Message-ID: <kfeoy5stq4drxf5hnzoe7kyf2yuotyuuweeynuxeqme3uqifhh@ok5stom6h2n7>
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-16-kuurtb@gmail.com>
 <eb746e5b-74a2-4d9a-9e7d-a914e96051fe@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb746e5b-74a2-4d9a-9e7d-a914e96051fe@amd.com>

On Thu, Jan 09, 2025 at 10:42:01AM -0600, Mario Limonciello wrote:
> On 1/9/2025 09:06, Kurt Borja wrote:
> > Devices can now set drvdata to the class device, thus passing the
> > platform_profile_handler to callbacks is unnecessary. Instead pass the
> > class device.
> > 
> If not too hard; could you bring this earlier in the series?
> 
> If so it would avoid some ping-ponging on some of the files from when you
> introduced the choices callback.

Sure! This can be moved to 5/18 with some modifications.

> 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >   drivers/acpi/platform_profile.c               |  6 ++--
> >   .../surface/surface_platform_profile.c        | 18 ++++++------
> >   drivers/platform/x86/acer-wmi.c               | 16 +++++------
> >   drivers/platform/x86/amd/pmf/sps.c            | 16 +++++------
> >   drivers/platform/x86/asus-wmi.c               | 16 +++++------
> >   drivers/platform/x86/dell/alienware-wmi.c     | 12 ++++----
> >   drivers/platform/x86/dell/dell-pc.c           | 14 +++++-----
> >   drivers/platform/x86/hp/hp-wmi.c              | 28 +++++++++----------
> >   drivers/platform/x86/ideapad-laptop.c         | 16 +++++------
> >   .../platform/x86/inspur_platform_profile.c    | 16 +++++------
> >   drivers/platform/x86/thinkpad_acpi.c          | 12 ++++----
> >   include/linux/platform_profile.h              |  8 ++----
> >   12 files changed, 88 insertions(+), 90 deletions(-)
> > 
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> > index fdf79b81b62e..8d034d928e32 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -67,7 +67,7 @@ static int _store_class_profile(struct device *dev, void *data)
> >   	if (!test_bit(*bit, handler->choices))
> >   		return -EOPNOTSUPP;
> > -	return handler->ops->profile_set(handler, *bit);
> > +	return handler->ops->profile_set(dev, *bit);
> >   }
> >   /**
> > @@ -104,7 +104,7 @@ static int get_class_profile(struct device *dev,
> >   	lockdep_assert_held(&profile_lock);
> >   	handler = to_pprof_handler(dev);
> > -	err = handler->ops->profile_get(handler, &val);
> > +	err = handler->ops->profile_get(dev, &val);
> >   	if (err) {
> >   		pr_err("Failed to get profile for handler %s\n", handler->name);
> >   		return err;
> > @@ -490,7 +490,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
> >   	if (!pprof)
> >   		return ERR_PTR(-ENOMEM);
> > -	err = ops->choices(pprof);
> > +	err = ops->choices(drvdata, pprof->choices);
> >   	if (err < 0)
> >   		return ERR_PTR(err);
> > diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> > index 965940223892..0d059986cc5c 100644
> > --- a/drivers/platform/surface/surface_platform_profile.c
> > +++ b/drivers/platform/surface/surface_platform_profile.c
> > @@ -154,14 +154,14 @@ static int convert_profile_to_ssam_fan(struct ssam_device *sdev, enum platform_p
> >   	}
> >   }
> > -static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
> > +static int ssam_platform_profile_get(struct device *dev,
> >   				     enum platform_profile_option *profile)
> >   {
> >   	struct ssam_platform_profile_device *tpd;
> >   	enum ssam_tmp_profile tp;
> >   	int status;
> > -	tpd = dev_get_drvdata(&pprof->class_dev);
> > +	tpd = dev_get_drvdata(dev);
> >   	status = ssam_tmp_profile_get(tpd->sdev, &tp);
> >   	if (status)
> > @@ -175,13 +175,13 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
> > +static int ssam_platform_profile_set(struct device *dev,
> >   				     enum platform_profile_option profile)
> >   {
> >   	struct ssam_platform_profile_device *tpd;
> >   	int tp;
> > -	tpd = dev_get_drvdata(&pprof->class_dev);
> > +	tpd = dev_get_drvdata(dev);
> >   	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
> >   	if (tp < 0)
> > @@ -201,12 +201,12 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
> >   	return tp;
> >   }
> > -static int ssam_platform_profile_choices(struct platform_profile_handler *pprof)
> > +static int ssam_platform_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> > index 2059b29dd36b..2900ba060cc4 100644
> > --- a/drivers/platform/x86/acer-wmi.c
> > +++ b/drivers/platform/x86/acer-wmi.c
> > @@ -1827,7 +1827,7 @@ static int acer_toggle_turbo(void)
> >   }
> >   static int
> > -acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
> > +acer_predator_v4_platform_profile_get(struct device *dev,
> >   				      enum platform_profile_option *profile)
> >   {
> >   	u8 tp;
> > @@ -1862,7 +1862,7 @@ acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
> >   }
> >   static int
> > -acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
> > +acer_predator_v4_platform_profile_set(struct device *dev,
> >   				      enum platform_profile_option profile)
> >   {
> >   	int tp;
> > @@ -1901,13 +1901,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
> >   }
> >   static int
> > -acer_predator_v4_platform_profile_choices(struct platform_profile_handler *pprof)
> > +acer_predator_v4_platform_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> > index e8d2de9bb646..700a6ef39201 100644
> > --- a/drivers/platform/x86/amd/pmf/sps.c
> > +++ b/drivers/platform/x86/amd/pmf/sps.c
> > @@ -282,10 +282,10 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
> >   	return (pmf->current_profile == PLATFORM_PROFILE_BALANCED) ? true : false;
> >   }
> > -static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
> > +static int amd_pmf_profile_get(struct device *dev,
> >   			       enum platform_profile_option *profile)
> >   {
> > -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> > +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
> >   	*profile = pmf->current_profile;
> >   	return 0;
> > @@ -363,10 +363,10 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
> >   	return 0;
> >   }
> > -static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
> > +static int amd_pmf_profile_set(struct device *dev,
> >   			       enum platform_profile_option profile)
> >   {
> > -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> > +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
> >   	int ret = 0;
> >   	pmf->current_profile = profile;
> > @@ -387,11 +387,11 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int amd_pmf_profile_choices(struct platform_profile_handler *pprof)
> > +static int amd_pmf_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index 809ab0353b68..11e5fcecf3a4 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3800,13 +3800,13 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> >   static DEVICE_ATTR_RW(throttle_thermal_policy);
> >   /* Platform profile ***********************************************************/
> > -static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > +static int asus_wmi_platform_profile_get(struct device *dev,
> >   					enum platform_profile_option *profile)
> >   {
> >   	struct asus_wmi *asus;
> >   	int tp;
> > -	asus = dev_get_drvdata(&pprof->class_dev);
> > +	asus = dev_get_drvdata(dev);
> >   	tp = asus->throttle_thermal_policy_mode;
> >   	switch (tp) {
> > @@ -3826,13 +3826,13 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> > +static int asus_wmi_platform_profile_set(struct device *dev,
> >   					enum platform_profile_option profile)
> >   {
> >   	struct asus_wmi *asus;
> >   	int tp;
> > -	asus = dev_get_drvdata(&pprof->class_dev);
> > +	asus = dev_get_drvdata(dev);
> >   	switch (profile) {
> >   	case PLATFORM_PROFILE_PERFORMANCE:
> > @@ -3852,11 +3852,11 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> >   	return throttle_thermal_policy_write(asus);
> >   }
> > -static int asus_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> > +static int asus_wmi_platform_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> > -	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 1eaa746eb4f1..19b7cd95018c 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -1055,7 +1055,7 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
> >   	return 0;
> >   }
> > -static int thermal_profile_get(struct platform_profile_handler *pprof,
> > +static int thermal_profile_get(struct device *dev,
> >   			       enum platform_profile_option *profile)
> >   {
> >   	u32 out_data;
> > @@ -1081,7 +1081,7 @@ static int thermal_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int thermal_profile_set(struct platform_profile_handler *pprof,
> > +static int thermal_profile_set(struct device *dev,
> >   			       enum platform_profile_option profile)
> >   {
> >   	if (quirks->gmode) {
> > @@ -1107,7 +1107,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
> >   	return wmax_thermal_control(supported_thermal_profiles[profile]);
> >   }
> > -static int thermal_profile_choices(struct platform_profile_handler *pprof)
> > +static int thermal_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> >   	u32 out_data;
> >   	u8 sys_desc[4];
> > @@ -1140,17 +1140,17 @@ static int thermal_profile_choices(struct platform_profile_handler *pprof)
> >   		profile = wmax_mode_to_platform_profile[mode];
> >   		supported_thermal_profiles[profile] = out_data;
> > -		set_bit(profile, pprof->choices);
> > +		set_bit(profile, choices);
> >   	}
> > -	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST))
> > +	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
> >   		return -ENODEV;
> >   	if (quirks->gmode) {
> >   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
> >   			WMAX_THERMAL_MODE_GMODE;
> > -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	}
> >   	return 0;
> > diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> > index 4ff80ed4f157..1ba2e58451e1 100644
> > --- a/drivers/platform/x86/dell/dell-pc.c
> > +++ b/drivers/platform/x86/dell/dell-pc.c
> > @@ -184,7 +184,7 @@ static int thermal_set_mode(enum thermal_mode_bits state)
> >   	return dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> >   }
> > -static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> > +static int thermal_platform_profile_set(struct device *dev,
> >   					enum platform_profile_option profile)
> >   {
> >   	switch (profile) {
> > @@ -201,7 +201,7 @@ static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> >   	}
> >   }
> > -static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> > +static int thermal_platform_profile_get(struct device *dev,
> >   					enum platform_profile_option *profile)
> >   {
> >   	int ret;
> > @@ -230,16 +230,16 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int thermal_platform_profile_choices(struct platform_profile_handler *pprof)
> > +static int thermal_platform_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> >   	if (supported_modes & DELL_QUIET)
> > -		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> >   	if (supported_modes & DELL_COOL_BOTTOM)
> > -		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_COOL, choices);
> >   	if (supported_modes & DELL_BALANCED)
> > -		set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
> >   	if (supported_modes & DELL_PERFORMANCE)
> > -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> > index 1b9e176f8d6f..3849cf761a46 100644
> > --- a/drivers/platform/x86/hp/hp-wmi.c
> > +++ b/drivers/platform/x86/hp/hp-wmi.c
> > @@ -1221,7 +1221,7 @@ static int platform_profile_omen_get_ec(enum platform_profile_option *profile)
> >   	return 0;
> >   }
> > -static int platform_profile_omen_get(struct platform_profile_handler *pprof,
> > +static int platform_profile_omen_get(struct device *dev,
> >   				     enum platform_profile_option *profile)
> >   {
> >   	/*
> > @@ -1318,7 +1318,7 @@ static int platform_profile_omen_set_ec(enum platform_profile_option profile)
> >   	return 0;
> >   }
> > -static int platform_profile_omen_set(struct platform_profile_handler *pprof,
> > +static int platform_profile_omen_set(struct device *dev,
> >   				     enum platform_profile_option profile)
> >   {
> >   	int err;
> > @@ -1345,7 +1345,7 @@ static int thermal_profile_set(int thermal_profile)
> >   							   sizeof(thermal_profile), 0);
> >   }
> > -static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > +static int hp_wmi_platform_profile_get(struct device *dev,
> >   					enum platform_profile_option *profile)
> >   {
> >   	int tp;
> > @@ -1374,7 +1374,7 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> > +static int hp_wmi_platform_profile_set(struct device *dev,
> >   					enum platform_profile_option profile)
> >   {
> >   	int err, tp;
> > @@ -1440,11 +1440,11 @@ static int platform_profile_victus_get_ec(enum platform_profile_option *profile)
> >   	return 0;
> >   }
> > -static int platform_profile_victus_get(struct platform_profile_handler *pprof,
> > +static int platform_profile_victus_get(struct device *dev,
> >   				       enum platform_profile_option *profile)
> >   {
> >   	/* Same behaviour as platform_profile_omen_get */
> > -	return platform_profile_omen_get(pprof, profile);
> > +	return platform_profile_omen_get(dev, profile);
> >   }
> >   static int platform_profile_victus_set_ec(enum platform_profile_option profile)
> > @@ -1472,7 +1472,7 @@ static int platform_profile_victus_set_ec(enum platform_profile_option profile)
> >   	return 0;
> >   }
> > -static int platform_profile_victus_set(struct platform_profile_handler *pprof,
> > +static int platform_profile_victus_set(struct device *dev,
> >   				       enum platform_profile_option profile)
> >   {
> >   	int err;
> > @@ -1488,19 +1488,19 @@ static int platform_profile_victus_set(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int hp_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> > +static int hp_wmi_platform_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> >   	if (is_omen_thermal_profile()) {
> > -		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_COOL, choices);
> >   	} else if (is_victus_thermal_profile()) {
> > -		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> >   	} else {
> > -		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> > -		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> > +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +		set_bit(PLATFORM_PROFILE_COOL, choices);
> >   	}
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> > index 55aac0190624..1937a2f00bec 100644
> > --- a/drivers/platform/x86/ideapad-laptop.c
> > +++ b/drivers/platform/x86/ideapad-laptop.c
> > @@ -933,10 +933,10 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
> >    * dytc_profile_get: Function to register with platform_profile
> >    * handler. Returns current platform profile.
> >    */
> > -static int dytc_profile_get(struct platform_profile_handler *pprof,
> > +static int dytc_profile_get(struct device *dev,
> >   			    enum platform_profile_option *profile)
> >   {
> > -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> > +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
> >   	*profile = dytc->current_profile;
> >   	return 0;
> > @@ -986,10 +986,10 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
> >    * dytc_profile_set: Function to register with platform_profile
> >    * handler. Sets current platform profile.
> >    */
> > -static int dytc_profile_set(struct platform_profile_handler *pprof,
> > +static int dytc_profile_set(struct device *dev,
> >   			    enum platform_profile_option profile)
> >   {
> > -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> > +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
> >   	struct ideapad_private *priv = dytc->priv;
> >   	unsigned long output;
> >   	int err;
> > @@ -1023,11 +1023,11 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
> >   	return -EINTR;
> >   }
> > -static int dytc_profile_choices(struct platform_profile_handler *pprof)
> > +static int dytc_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> > index 9e2f24de0207..3d45df807b8b 100644
> > --- a/drivers/platform/x86/inspur_platform_profile.c
> > +++ b/drivers/platform/x86/inspur_platform_profile.c
> > @@ -84,10 +84,10 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
> >    *         0x0: No Error
> >    *         0x1: Error
> >    */
> > -static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
> > +static int inspur_platform_profile_set(struct device *dev,
> >   				       enum platform_profile_option profile)
> >   {
> > -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> > +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
> >   	u8 ret_code[4] = {0, 0, 0, 0};
> >   	int ret;
> > @@ -131,10 +131,10 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
> >    *         0x1: Performance Mode
> >    *         0x2: Power Saver Mode
> >    */
> > -static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> > +static int inspur_platform_profile_get(struct device *dev,
> >   				       enum platform_profile_option *profile)
> >   {
> > -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> > +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
> >   	u8 ret_code[4] = {0, 0, 0, 0};
> >   	int ret;
> > @@ -164,11 +164,11 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > -static int inspur_platform_profile_choices(struct platform_profile_handler *pprof)
> > +static int inspur_platform_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index 964f842ef756..2e9740b7e328 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -10415,7 +10415,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
> >    * dytc_profile_get: Function to register with platform_profile
> >    * handler. Returns current platform profile.
> >    */
> > -static int dytc_profile_get(struct platform_profile_handler *pprof,
> > +static int dytc_profile_get(struct device *dev,
> >   			    enum platform_profile_option *profile)
> >   {
> >   	*profile = dytc_current_profile;
> > @@ -10490,7 +10490,7 @@ static int dytc_cql_command(int command, int *output)
> >    * dytc_profile_set: Function to register with platform_profile
> >    * handler. Sets current platform profile.
> >    */
> > -static int dytc_profile_set(struct platform_profile_handler *pprof,
> > +static int dytc_profile_set(struct device *dev,
> >   			    enum platform_profile_option profile)
> >   {
> >   	int perfmode;
> > @@ -10539,11 +10539,11 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
> >   	return err;
> >   }
> > -static int dytc_profile_choices(struct platform_profile_handler *pprof)
> > +static int dytc_profile_choices(void *drvdata, unsigned long *choices)
> >   {
> > -	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> > -	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> >   	return 0;
> >   }
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> > index 97ce9bd476ab..0824a12b9998 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -31,11 +31,9 @@ enum platform_profile_option {
> >   struct platform_profile_handler;
> >   struct platform_profile_ops {
> > -	int (*profile_get)(struct platform_profile_handler *pprof,
> > -				enum platform_profile_option *profile);
> > -	int (*profile_set)(struct platform_profile_handler *pprof,
> > -				enum platform_profile_option profile);
> > -	int (*choices)(struct platform_profile_handler *pprof);
> > +	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> > +	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
> > +	int (*choices)(void *drvdata, unsigned long *choices);
> >   };
> >   struct platform_profile_handler {
> 

