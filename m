Return-Path: <linux-acpi+bounces-10754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03706A16256
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E49188568A
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF61DF244;
	Sun, 19 Jan 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBPt0KYk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92563CB;
	Sun, 19 Jan 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298736; cv=none; b=fIKDAsGyoGybSk3uabjYKoA/t6KkDMwtpi5R2qQr2V0kOjX4ONyCYxHpdhuq1cQl0FxyM0L/+8wQq75ovzQ+igxbi3hdowMownfrV0IK2iX4tCa1QSnfb4itNMradi4HaW203BH6uS16etT5cowInS/WXQ289PiPN8k2nrIvZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298736; c=relaxed/simple;
	bh=oUCP197iiDMqxAQEsAJCst+sdTUudgKalmY3OtH9kl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5ZhjnCFSGHF2erh7LLwEi2OdcX3CHoIURD9YusTKXpUD5ID0tVIOHyChXvgHuuZaO9JV2VTPKwRu5tSLcdxCme8z9JueVqRI4g7Lvtq7Sjf7wjHBrYd54nE93jIk3HuyijSqNLq5re5iJnGACUe1c14EeueOKLkwDRvQhxq5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBPt0KYk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4368a293339so41420095e9.3;
        Sun, 19 Jan 2025 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737298733; x=1737903533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXGBsI501Z0Hviv3ibmq8j7YmZRMknB2v5/MpnYzuB0=;
        b=GBPt0KYkob76noO0LvxsPwygdXOEIm1alELZp+TB0ty56piP2a3s7ZE2GGYhejgyoO
         p72mgegRi9abOXE1a3vzDm9mCM8UXMytus5mK+hJUqxm/o0C343Yfnr6gWg6a7NOTA3n
         Ya/AN4hjSnQjVk/5wmEDmvdvUUesBq6Tj62fg/m/Nnc57xLyq0o/spH2FA80W4AIxLeh
         lgEQm6fvDCFHCswnlrehow310n7iuIHv5iuBdxw50BMK/qK0Hoq/LPxuAVVpH0S2lvEK
         7fkMEU/Trm5krP8WIAS/fLOYjumnAl3YxVXVEPdx6rOwZpPOy4RAtzjT1bwe6HJWtKNM
         Z4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737298733; x=1737903533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXGBsI501Z0Hviv3ibmq8j7YmZRMknB2v5/MpnYzuB0=;
        b=LyYYsgxvyJNx/qYYQjWLmGxL4kYe6XMi4UmCAwtF2t4+QPhiG+GlVPsWerTIMFArqe
         xiLCr66hXI+NO566S3i/tprFMwHS+z/CQw4VPrTadjUJxThQJOMJWdI1nLtMgn//skYM
         f27iy916GiTdkSiZVoFO0HhRPmUUh1sRi1nNa3vJ+BcVpkjcfZXXyXtIeh55E/qK/nK5
         ZlZuN03iJQExf9H0GXGvjmqWm2yF2DLEBUj/V3lWQCMMkm/AmMBaQti9AEYIPHcwOzLw
         OYNrjRGH2UhQNLqMXiQ82wOdyvti1NhlDsOG3iB2P3NvUGkNmXCeL3dQJ9OhEqCLDcC6
         cEQA==
X-Forwarded-Encrypted: i=1; AJvYcCV7BbKwk6VB04wV/p3h4LXy3Gag1rqjaBCj4HuHAJ5vNuXR/IjVRuyIHTpZwk9PXm9FTtuQmiXUJsSa@vger.kernel.org, AJvYcCVLX0BGFCANPaj0d+5WlMkPtQQOr0MynleFc0AxSGlVogZpcRf/KJIn/lVen10e1i6SwPLBkvEDgCjGvB6SpEH0H2ugaQ==@vger.kernel.org, AJvYcCVWawuuzqq3Iwk/7fVU87VZO1MSPdLw7zCcKQON7CcJZIyKy4TMdqdMQkD5jrc5EAd2VeQa0TWXrn72VFGV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18C3+54bbSsR5rozAWFfLsbXLjTbajY5GYmfqRKDQXNyfaUST
	vfpc38BvNm0mCvmRDrnH9USW0aXzSRBiOREldrYnFl/0bZ5x+Eo2
X-Gm-Gg: ASbGncs7uxPfnC1kjC6WE+5iCkgeDt/FtDfrGlSjZlB8xyOgg4ENIjGn9GUX/i07NJN
	/0KXlI7inoiPwkolvpr01Jb0V/occtMOb2TmXe9HQNoJBf+w/xYpEhUMJrfhjmK9QwS9skinZjL
	0vLQMGZmRdtpiORcK1gjCHnohfgGpwqQlof1t182H/p/aHSdzOrF4KvL0l/MH1c/oxSJyLwyXG6
	YmiZXiH8KNQ+pito5RBwyBVoBK0wHeEhFLrQurwmcyF2h14cV/Yhvi9SK0qQejlhdSjyjqB0Ktz
	/DhUg6Ytuvj9Am3wfSFs7ubKSYH+jCth0P4iA/c5kyTa5FU=
X-Google-Smtp-Source: AGHT+IEmHREwWtmzK4Xbu20fSb8MKOo2zrRzHHMhaqn7u79it6s6RQU2f6Q8JeAOuQdaDrOqvDddpg==
X-Received: by 2002:a05:600c:ccc:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-4389141c1e5mr79218075e9.20.1737298732284;
        Sun, 19 Jan 2025 06:58:52 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7528076sm166108245e9.25.2025.01.19.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 06:58:51 -0800 (PST)
Message-ID: <87d258a0-7dbf-4c28-8bac-a60d22e0d2c0@gmail.com>
Date: Sun, 19 Jan 2025 15:58:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] ACPI: platform_profile: Add `ops` member to
 handlers
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>,
 Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250116002721.75592-1-kuurtb@gmail.com>
 <20250116002721.75592-5-kuurtb@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20250116002721.75592-5-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 1:27 AM, Kurt Borja wrote:
> Replace *profile_get and *profile_set members with a general *ops
> member.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/acpi/platform_profile.c               |  6 ++---
>   .../surface/surface_platform_profile.c        |  8 +++++--
>   drivers/platform/x86/acer-wmi.c               | 11 +++++----
>   drivers/platform/x86/amd/pmf/sps.c            |  8 +++++--
>   drivers/platform/x86/asus-wmi.c               |  8 +++++--
>   drivers/platform/x86/dell/alienware-wmi.c     |  8 +++++--
>   drivers/platform/x86/dell/dell-pc.c           |  8 +++++--
>   drivers/platform/x86/hp/hp-wmi.c              | 24 ++++++++++++++-----
>   drivers/platform/x86/ideapad-laptop.c         |  8 +++++--
>   .../platform/x86/inspur_platform_profile.c    |  8 +++++--
>   drivers/platform/x86/thinkpad_acpi.c          |  8 +++++--
>   include/linux/platform_profile.h              | 10 ++++++--
>   12 files changed, 84 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index bd90aa4e8371..161a05d57b0f 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -65,7 +65,7 @@ static int _store_class_profile(struct device *dev, void *data)
>   	if (!test_bit(*bit, handler->choices))
>   		return -EOPNOTSUPP;
>   
> -	return handler->profile_set(dev, *bit);
> +	return handler->ops->profile_set(dev, *bit);
>   }
>   
>   /**
> @@ -102,7 +102,7 @@ static int get_class_profile(struct device *dev,
>   
>   	lockdep_assert_held(&profile_lock);
>   	handler = to_pprof_handler(dev);
> -	err = handler->profile_get(dev, &val);
> +	err = handler->ops->profile_get(dev, &val);
>   	if (err) {
>   		pr_err("Failed to get profile for handler %s\n", handler->name);
>   		return err;
> @@ -466,7 +466,7 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
>   
>   	/* Sanity check the profile handler */
>   	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -	    !pprof->profile_set || !pprof->profile_get) {
> +	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
>   		pr_err("platform_profile: handler is invalid\n");
>   		return -EINVAL;
>   	}
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 26c1230e75df..76967bfeeef8 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -201,6 +201,11 @@ static int ssam_platform_profile_set(struct device *dev,
>   	return tp;
>   }
>   
> +static const struct platform_profile_ops ssam_platform_profile_ops = {
> +	.profile_get = ssam_platform_profile_get,
> +	.profile_set = ssam_platform_profile_set,
> +};
> +
>   static int surface_platform_profile_probe(struct ssam_device *sdev)
>   {
>   	struct ssam_platform_profile_device *tpd;
> @@ -214,8 +219,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->handler.name = "Surface Platform Profile";
>   	tpd->handler.dev = &sdev->dev;
> -	tpd->handler.profile_get = ssam_platform_profile_get;
> -	tpd->handler.profile_set = ssam_platform_profile_set;
> +	tpd->handler.ops = &ssam_platform_profile_ops;
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index c68c0d744a69..63e6bd1fe339 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2019,6 +2019,11 @@ acer_predator_v4_platform_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
> +	.profile_get = acer_predator_v4_platform_profile_get,
> +	.profile_set = acer_predator_v4_platform_profile_set,
> +};
> +
>   static int acer_platform_profile_setup(struct platform_device *device)
>   {
>   	if (quirks->predator_v4) {
> @@ -2027,10 +2032,8 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   
>   		platform_profile_handler.name = "acer-wmi";
>   		platform_profile_handler.dev = &device->dev;
> -		platform_profile_handler.profile_get =
> -			acer_predator_v4_platform_profile_get;
> -		platform_profile_handler.profile_set =
> -			acer_predator_v4_platform_profile_set;
> +		platform_profile_handler.ops =
> +			&acer_predator_v4_platform_profile_ops;
>   
>   		err = WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES,
>   						   (u8 *)&supported_profiles);
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index cf2e51f67787..6ae82ae86d22 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -387,6 +387,11 @@ static int amd_pmf_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops amd_pmf_profile_ops = {
> +	.profile_get = amd_pmf_profile_get,
> +	.profile_set = amd_pmf_profile_set,
> +};
> +
>   int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   {
>   	int err;
> @@ -407,8 +412,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   
>   	dev->pprof.name = "amd-pmf";
>   	dev->pprof.dev = dev->dev;
> -	dev->pprof.profile_get = amd_pmf_profile_get;
> -	dev->pprof.profile_set = amd_pmf_profile_set;
> +	dev->pprof.ops = &amd_pmf_profile_ops;
>   
>   	/* Setup supported modes */
>   	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6b8b30551d36..992956c89d38 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3852,6 +3852,11 @@ static int asus_wmi_platform_profile_set(struct device *dev,
>   	return throttle_thermal_policy_write(asus);
>   }
>   
> +static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
> +	.profile_get = asus_wmi_platform_profile_get,
> +	.profile_set = asus_wmi_platform_profile_set,
> +};
> +
>   static int platform_profile_setup(struct asus_wmi *asus)
>   {
>   	struct device *dev = &asus->platform_device->dev;
> @@ -3878,8 +3883,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   
>   	asus->platform_profile_handler.name = "asus-wmi";
>   	asus->platform_profile_handler.dev = dev;
> -	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
> -	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
> +	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>   
>   	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
>   	set_bit(PLATFORM_PROFILE_BALANCED,
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 0346f8e88bf8..b8359b177a0f 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1078,6 +1078,11 @@ static int thermal_profile_set(struct device *dev,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>   
> +static const struct platform_profile_ops awcc_platform_profile_ops = {
> +	.profile_get = thermal_profile_get,
> +	.profile_set = thermal_profile_set,
> +};
> +
>   static int create_thermal_profile(struct platform_device *platform_device)
>   {
>   	enum platform_profile_option profile;
> @@ -1124,10 +1129,9 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
>   	}
>   
> -	pp_handler.profile_get = thermal_profile_get;
> -	pp_handler.profile_set = thermal_profile_set;
>   	pp_handler.name = "alienware-wmi";
>   	pp_handler.dev = &platform_device->dev;
> +	pp_handler.ops = &awcc_platform_profile_ops;
>   
>   	return devm_platform_profile_register(&pp_handler, NULL);
>   }
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index c86b05b5a1cb..9010a231f209 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -231,6 +231,11 @@ static int thermal_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> +	.profile_get = thermal_platform_profile_get,
> +	.profile_set = thermal_platform_profile_set,
> +};
> +
>   static int thermal_init(void)
>   {
>   	int ret;
> @@ -258,8 +263,7 @@ static int thermal_init(void)
>   	}
>   	thermal_handler->name = "dell-pc";
>   	thermal_handler->dev = &platform_device->dev;
> -	thermal_handler->profile_get = thermal_platform_profile_get;
> -	thermal_handler->profile_set = thermal_platform_profile_set;
> +	thermal_handler->ops = &dell_pc_platform_profile_ops;
>   
>   	if (supported_modes & DELL_QUIET)
>   		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index b8e62dc9cecd..60328b35be74 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1565,6 +1565,21 @@ static inline void omen_unregister_powersource_event_handler(void)
>   	unregister_acpi_notifier(&platform_power_source_nb);
>   }
>   
> +static const struct platform_profile_ops platform_profile_omen_ops = {
> +	.profile_get = platform_profile_omen_get,
> +	.profile_set = platform_profile_omen_set,
> +};
> +
> +static const struct platform_profile_ops platform_profile_victus_ops = {
> +	.profile_get = platform_profile_victus_get,
> +	.profile_set = platform_profile_victus_set,
> +};
> +
> +static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
> +	.profile_get = hp_wmi_platform_profile_get,
> +	.profile_set = hp_wmi_platform_profile_set,
> +};
> +
>   static int thermal_profile_setup(struct platform_device *device)
>   {
>   	int err, tp;
> @@ -1582,8 +1597,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.profile_get = platform_profile_omen_get;
> -		platform_profile_handler.profile_set = platform_profile_omen_set;
> +		platform_profile_handler.ops = &platform_profile_omen_ops;
>   
>   		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	} else if (is_victus_thermal_profile()) {
> @@ -1599,8 +1613,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.profile_get = platform_profile_victus_get;
> -		platform_profile_handler.profile_set = platform_profile_victus_set;
> +		platform_profile_handler.ops = &platform_profile_victus_ops;
>   
>   		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>   	} else {
> @@ -1617,8 +1630,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err)
>   			return err;
>   
> -		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
> -		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
> +		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
>   
>   		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>   		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index fc317f42bb82..96e99513b0b5 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1063,6 +1063,11 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>   	{}
>   };
>   
> +static const struct platform_profile_ops dytc_profile_ops = {
> +	.profile_get = dytc_profile_get,
> +	.profile_set = dytc_profile_set,
> +};
> +
>   static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   {
>   	int err, dytc_version;
> @@ -1105,8 +1110,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	priv->dytc->pprof.name = "ideapad-laptop";
>   	priv->dytc->pprof.dev = &priv->platform_device->dev;
>   	priv->dytc->priv = priv;
> -	priv->dytc->pprof.profile_get = dytc_profile_get;
> -	priv->dytc->pprof.profile_set = dytc_profile_set;
> +	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
>   	/* Setup supported modes */
>   	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 47d2dbbf3392..d0a8e4eebffa 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -164,6 +164,11 @@ static int inspur_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops inspur_platform_profile_ops = {
> +	.profile_get = inspur_platform_profile_get,
> +	.profile_set = inspur_platform_profile_set,
> +};
> +
>   static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   {
>   	struct inspur_wmi_priv *priv;
> @@ -177,8 +182,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   
>   	priv->handler.name = "inspur-wmi";
>   	priv->handler.dev = &wdev->dev;
> -	priv->handler.profile_get = inspur_platform_profile_get;
> -	priv->handler.profile_set = inspur_platform_profile_set;
> +	priv->handler.ops = &inspur_platform_profile_ops;
>   
>   	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
>   	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 0abe22228fdb..9e26f5670fc7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10539,12 +10539,16 @@ static int dytc_profile_set(struct device *dev,
>   	return err;
>   }
>   
> -static struct platform_profile_handler dytc_profile = {
> -	.name = "thinkpad-acpi",
> +static const struct platform_profile_ops dytc_profile_ops = {
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
>   
> +static struct platform_profile_handler dytc_profile = {
> +	.name = "thinkpad-acpi",
> +	.ops = &dytc_profile_ops,
> +};
> +
>   static void dytc_profile_refresh(void)
>   {
>   	enum platform_profile_option profile;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 5296d886c243..6013c05d7b86 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,14 +28,20 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };
>   
> +struct platform_profile_handler;
> +
> +struct platform_profile_ops {
> +	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> +	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
> +};
> +
>   struct platform_profile_handler {
>   	const char *name;
>   	struct device *dev;
>   	struct device class_dev;
>   	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> -	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
> +	const struct platform_profile_ops *ops;
>   };
>   
>   int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);


