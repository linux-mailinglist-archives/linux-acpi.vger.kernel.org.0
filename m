Return-Path: <linux-acpi+bounces-10755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A3A16269
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 16:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960CD3A5B83
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496C1DF27E;
	Sun, 19 Jan 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QerjGbgs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817763CB;
	Sun, 19 Jan 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298826; cv=none; b=q6H76KrAsUf1/EEAUxt0CYMTcLIauH5fKZ43BKSk09SAAQiHgXxF3UyUDbujDH8GQqIgV3lQ9UawHlMPYASVyNP2z9ppFL1IBmBIZBMGEH85CHHGnKtFq6NhdtcGCXb9QO7SnZLoVAxQ50GGWbx3WVI6dOPHgDeX2xopMlvK/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298826; c=relaxed/simple;
	bh=DtqAYZahdR+8H+Ufp4Vl/wQCqNZP3SoUvezYh4J/1Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpdcdOQ0kp/jrIo40848p/hiAoBnr0EORQafxeAzP0/ofqTYdAdk406XzP8mEUHgWTVW9aXsA6wz90HfWMP/ZcbrBFTlqI+cS8G2fjYUsibekNJqsRaq3Z0+J0hCuXrgzJ0v1hE7M7ID3QAwujMkt9Kk4uwlyxfS5FPmhb6++qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QerjGbgs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so36978515e9.1;
        Sun, 19 Jan 2025 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737298822; x=1737903622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AARjV9Vmg3Tl4RRsY3puzmKEatPg0t35OIO3zDra5s=;
        b=QerjGbgsEVZt+y1ClbTvlBdTSxN4slgwC8K8G0Sb12p0oGMTunmPs55aZQibF4GtIU
         EvzLvWl1IBmofKf36oZy0qx8Se50GzA5m9dDDe4VPzTWr0N+hDTlOaeaRVVi+Ij3R8yY
         wW0wvYNWJbyW9MamNfbtHkHTMwDLbsjjtjZ8u8wEZzbFOEC8R3BXoGOd9C/YyAobYEIi
         l81UygGsgKYJz1osUpgh3YrAgYewYzdqJB9iQp7r0E5epTXeW2b7rEyy0w208Fe6BbPl
         zb70/hX/HDcEA4LAbys+yTBiAZdqptqjB4O7RnHf5C9R+H2SUDmiUSZm8WonMNJRNsCU
         cD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737298822; x=1737903622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AARjV9Vmg3Tl4RRsY3puzmKEatPg0t35OIO3zDra5s=;
        b=SZcsWmzzO52QMuX+P5yib9GaLvdIaGLIQoENUUmR+l04lq4tHklBM9WG5/fNzErSEw
         nsLuS2LKmkjI+XASVaLGk0NhtEY2fbHvFovW6o0OxVR1wuvIvy3rqeD3ZiiFYtlmQi5R
         A9J0a1NiKMr/HUSzftRb7BMu3K5RkKIGR63d00QUz46+bm5FyqTcbu2vtEf0kV3Qnrsk
         Jkz/ORCjF4/Ku3gjs8/9arv60ky3aAQB7Q3yI5FGaha2c+DbeY/OfgtpjjISuUPr1K+2
         3rC2JGX1IKX76Tfz/TrZHAJH16o8tEdt1wkcxIpASh7o5nhW8GISIhceZbX1MDVzzisT
         0yUg==
X-Forwarded-Encrypted: i=1; AJvYcCUU3PfB4ulC5ZuJytFmuy0Lu5dNO7aZQ/prn5JCwTrICYeGkZQ2dLfOHpWj7RYhbxz+iiHZ+5nVctamK49V0DkI2mD5Sg==@vger.kernel.org, AJvYcCUg5zvDE/sn8R2w8QoQj5Wdg8JbD4aqm76byx3ZmNe2dzfC3o0iSH25olrtZykk6dRF1dREvKOSsNDtfYAG@vger.kernel.org, AJvYcCXRH5hEjk95SwDgtsg9j/w2LnMASOA6s0pIxGKRJ2LJyBZEs0QbnF+R2wxICgnsKUrYbV9HJ+guNWQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyWKFffdY858TxG+f/WN63WheU1j/4WvooTFe0Y8HjovqtlZ4
	YF5vE/vBaQQD17h8asiXV0yueI1xdyS2lFkebHu+TespkKAuqBZ1
X-Gm-Gg: ASbGncuI6c+KLZvrr98hwWVOtDMfPuzmgU7C0+VTSQs7rrvDqbFQSdhdIl2Gq+uDjPa
	IEq5G2j33av82P5fNvZCPIoZReuFkC5dfviiislZbFOcy21x3HyjN1VyXhVYxWUJtFrIiQ1ypGu
	+afl0Lyo9IqDzbd624lYzk3jC4cu+uJpY/bo9bmPAvUQvYqw5Hn3N0IXLhcT6kOV7d/ASda/MW5
	LFko7h5FKQ8aCFOnT1DaXkN4wcMTFrLNHU/RBlzq3O/gkvEhDIGTDIs1WbPfnLUjGQMmwyR7AwP
	NEU1ahOyBt9FwDX+AnNc23lEiytpiPmOrQrLLcLiUdaV580=
X-Google-Smtp-Source: AGHT+IHe8mhWLMEf9zAXaaUjaX2LtgMim9lBV/kwNsMVobyrmsUL1vjLD6VTvfl3pt6c2rll111OxQ==
X-Received: by 2002:a05:6000:1aca:b0:385:fb8d:8658 with SMTP id ffacd0b85a97d-38bf57b7fbdmr9458148f8f.40.1737298822181;
        Sun, 19 Jan 2025 07:00:22 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322ad74sm7943289f8f.56.2025.01.19.07.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 07:00:21 -0800 (PST)
Message-ID: <6629b978-6345-4007-b661-01c43a366f6e@gmail.com>
Date: Sun, 19 Jan 2025 16:00:18 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] ACPI: platform_profile: Add `probe` to
 platform_profile_ops
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
 <20250116002721.75592-6-kuurtb@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20250116002721.75592-6-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 1:27 AM, Kurt Borja wrote:
> Add a `probe` callback to platform_profile_ops, which lets drivers
> initialize the choices member manually.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/acpi/platform_profile.c               | 15 +++-
>   .../surface/surface_platform_profile.c        | 16 ++--
>   drivers/platform/x86/acer-wmi.c               | 88 ++++++++++---------
>   drivers/platform/x86/amd/pmf/sps.c            | 15 ++--
>   drivers/platform/x86/asus-wmi.c               | 16 ++--
>   drivers/platform/x86/dell/alienware-wmi.c     | 24 +++--
>   drivers/platform/x86/dell/dell-pc.c           | 26 +++---
>   drivers/platform/x86/hp/hp-wmi.c              | 29 ++++--
>   drivers/platform/x86/ideapad-laptop.c         | 15 ++--
>   .../platform/x86/inspur_platform_profile.c    | 14 ++-
>   drivers/platform/x86/thinkpad_acpi.c          | 15 ++--
>   include/linux/platform_profile.h              |  1 +
>   12 files changed, 172 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 161a05d57b0f..120f8402facd 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -465,12 +465,23 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
>   	int err;
>   
>   	/* Sanity check the profile handler */
> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
> +	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> +	    !pprof->ops->probe) {
>   		pr_err("platform_profile: handler is invalid\n");
>   		return -EINVAL;
>   	}
>   
> +	err = pprof->ops->probe(drvdata, pprof->choices);
> +	if (err) {
> +		dev_err(pprof->dev, "platform_profile probe failed\n");
> +		return err;
> +	}
> +
> +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> +		dev_err(pprof->dev, "Failed to register a platform_profile class device with empty choices\n");
> +		return -EINVAL;
> +	}
> +
>   	guard(mutex)(&profile_lock);
>   
>   	/* create class interface for individual handler */
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 76967bfeeef8..48cfe9cb89c8 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -201,7 +201,18 @@ static int ssam_platform_profile_set(struct device *dev,
>   	return tp;
>   }
>   
> +static int ssam_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops ssam_platform_profile_ops = {
> +	.probe = ssam_platform_profile_probe,
>   	.profile_get = ssam_platform_profile_get,
>   	.profile_set = ssam_platform_profile_set,
>   };
> @@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> -
>   	return platform_profile_register(&tpd->handler, tpd);
>   }
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 63e6bd1fe339..4d62a61cb241 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2019,7 +2019,53 @@ acer_predator_v4_platform_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int
> +acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	unsigned long supported_profiles;
> +	int err;
> +
> +	err = WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES,
> +					   (u8 *)&supported_profiles);
> +	if (err)
> +		return err;
> +
> +	/* Iterate through supported profiles in order of increasing performance */
> +	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_ECO, &supported_profiles)) {
> +		set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +		acer_predator_v4_max_perf =
> +			ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
> +	}
> +
> +	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET, &supported_profiles)) {
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +		acer_predator_v4_max_perf =
> +			ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
> +	}
> +
> +	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED, &supported_profiles)) {
> +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +		acer_predator_v4_max_perf =
> +			ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
> +	}
> +
> +	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE, &supported_profiles)) {
> +		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +		acer_predator_v4_max_perf =
> +			ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE;
> +	}
> +
> +	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO, &supported_profiles)) {
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +		acer_predator_v4_max_perf =
> +			ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
> +	.probe = acer_predator_v4_platform_profile_probe,
>   	.profile_get = acer_predator_v4_platform_profile_get,
>   	.profile_set = acer_predator_v4_platform_profile_set,
>   };
> @@ -2027,7 +2073,6 @@ static const struct platform_profile_ops acer_predator_v4_platform_profile_ops =
>   static int acer_platform_profile_setup(struct platform_device *device)
>   {
>   	if (quirks->predator_v4) {
> -		unsigned long supported_profiles;
>   		int err;
>   
>   		platform_profile_handler.name = "acer-wmi";
> @@ -2035,47 +2080,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   		platform_profile_handler.ops =
>   			&acer_predator_v4_platform_profile_ops;
>   
> -		err = WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES,
> -						   (u8 *)&supported_profiles);
> -		if (err)
> -			return err;
> -
> -		/* Iterate through supported profiles in order of increasing performance */
> -		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_ECO, &supported_profiles)) {
> -			set_bit(PLATFORM_PROFILE_LOW_POWER,
> -				platform_profile_handler.choices);
> -			acer_predator_v4_max_perf =
> -				ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
> -		}
> -
> -		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET, &supported_profiles)) {
> -			set_bit(PLATFORM_PROFILE_QUIET,
> -				platform_profile_handler.choices);
> -			acer_predator_v4_max_perf =
> -				ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
> -		}
> -
> -		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED, &supported_profiles)) {
> -			set_bit(PLATFORM_PROFILE_BALANCED,
> -				platform_profile_handler.choices);
> -			acer_predator_v4_max_perf =
> -				ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
> -		}
> -
> -		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE, &supported_profiles)) {
> -			set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> -				platform_profile_handler.choices);
> -			acer_predator_v4_max_perf =
> -				ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE;
> -		}
> -
> -		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO, &supported_profiles)) {
> -			set_bit(PLATFORM_PROFILE_PERFORMANCE,
> -				platform_profile_handler.choices);
> -			acer_predator_v4_max_perf =
> -				ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
> -		}
> -
>   		err = platform_profile_register(&platform_profile_handler, NULL);
>   		if (err)
>   			return err;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 6ae82ae86d22..e710405b581f 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -387,7 +387,17 @@ static int amd_pmf_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops amd_pmf_profile_ops = {
> +	.probe = amd_pmf_profile_probe,
>   	.profile_get = amd_pmf_profile_get,
>   	.profile_set = amd_pmf_profile_set,
>   };
> @@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	dev->pprof.dev = dev->dev;
>   	dev->pprof.ops = &amd_pmf_profile_ops;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
> -
>   	/* Create platform_profile structure and register */
>   	err = platform_profile_register(&dev->pprof, dev);
>   	if (err)
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 992956c89d38..e775ec7371ce 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3852,7 +3852,17 @@ static int asus_wmi_platform_profile_set(struct device *dev,
>   	return throttle_thermal_policy_write(asus);
>   }
>   
> +static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
> +	.probe = asus_wmi_platform_profile_probe,
>   	.profile_get = asus_wmi_platform_profile_get,
>   	.profile_set = asus_wmi_platform_profile_set,
>   };
> @@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   	asus->platform_profile_handler.dev = dev;
>   	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>   
> -	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED,
> -		asus->platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE,
> -		asus->platform_profile_handler.choices);
> -
>   	err = platform_profile_register(&asus->platform_profile_handler, asus);
>   	if (err == -EEXIST) {
>   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index b8359b177a0f..e7209863e7dc 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1078,12 +1078,7 @@ static int thermal_profile_set(struct device *dev,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>   
> -static const struct platform_profile_ops awcc_platform_profile_ops = {
> -	.profile_get = thermal_profile_get,
> -	.profile_set = thermal_profile_set,
> -};
> -
> -static int create_thermal_profile(struct platform_device *platform_device)
> +static int thermal_profile_probe(void *drvdata, unsigned long *choices)
>   {
>   	enum platform_profile_option profile;
>   	enum wmax_thermal_mode mode;
> @@ -1116,19 +1111,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   		profile = wmax_mode_to_platform_profile[mode];
>   		supported_thermal_profiles[profile] = out_data;
>   
> -		set_bit(profile, pp_handler.choices);
> +		set_bit(profile, choices);
>   	}
>   
> -	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> +	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
>   		return -ENODEV;
>   
>   	if (quirks->gmode) {
>   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>   			WMAX_THERMAL_MODE_GMODE;
>   
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   	}
>   
> +	return 0;
> +}
> +
> +static const struct platform_profile_ops awcc_platform_profile_ops = {
> +	.probe = thermal_profile_probe,
> +	.profile_get = thermal_profile_get,
> +	.profile_set = thermal_profile_set,
> +};
> +
> +static int create_thermal_profile(struct platform_device *platform_device)
> +{
>   	pp_handler.name = "alienware-wmi";
>   	pp_handler.dev = &platform_device->dev;
>   	pp_handler.ops = &awcc_platform_profile_ops;
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 9010a231f209..32b3be0723f8 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -24,6 +24,7 @@
>   #include "dell-smbios.h"
>   
>   static struct platform_device *platform_device;
> +static int supported_modes;
>   
>   static const struct dmi_system_id dell_device_table[] __initconst = {
>   	{
> @@ -231,7 +232,22 @@ static int thermal_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static int thermal_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> +	.probe = thermal_platform_profile_probe,
>   	.profile_get = thermal_platform_profile_get,
>   	.profile_set = thermal_platform_profile_set,
>   };
> @@ -239,7 +255,6 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
>   static int thermal_init(void)
>   {
>   	int ret;
> -	int supported_modes;
>   
>   	/* If thermal commands are not supported, exit without error */
>   	if (!dell_smbios_class_is_supported(CLASS_INFO))
> @@ -265,15 +280,6 @@ static int thermal_init(void)
>   	thermal_handler->dev = &platform_device->dev;
>   	thermal_handler->ops = &dell_pc_platform_profile_ops;
>   
> -	if (supported_modes & DELL_QUIET)
> -		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> -	if (supported_modes & DELL_COOL_BOTTOM)
> -		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> -	if (supported_modes & DELL_BALANCED)
> -		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> -	if (supported_modes & DELL_PERFORMANCE)
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> -
>   	/* Clean up if failed */
>   	ret = platform_profile_register(thermal_handler, NULL);
>   	if (ret)
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 60328b35be74..75bcd8460e7c 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int hp_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	if (is_omen_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	} else if (is_victus_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	} else {
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	}
> +
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static int omen_powersource_event(struct notifier_block *nb,
>   				  unsigned long value,
>   				  void *data)
> @@ -1566,16 +1583,19 @@ static inline void omen_unregister_powersource_event_handler(void)
>   }
>   
>   static const struct platform_profile_ops platform_profile_omen_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = platform_profile_omen_get,
>   	.profile_set = platform_profile_omen_set,
>   };
>   
>   static const struct platform_profile_ops platform_profile_victus_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = platform_profile_victus_get,
>   	.profile_set = platform_profile_victus_set,
>   };
>   
>   static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = hp_wmi_platform_profile_get,
>   	.profile_set = hp_wmi_platform_profile_set,
>   };
> @@ -1598,8 +1618,6 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &platform_profile_omen_ops;
> -
> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	} else if (is_victus_thermal_profile()) {
>   		err = platform_profile_victus_get_ec(&active_platform_profile);
>   		if (err < 0)
> @@ -1614,8 +1632,6 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &platform_profile_victus_ops;
> -
> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>   	} else {
>   		tp = thermal_profile_get();
>   
> @@ -1631,15 +1647,10 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
> -
> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	}
>   
>   	platform_profile_handler.name = "hp-wmi";
>   	platform_profile_handler.dev = &device->dev;
> -	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
>   
>   	err = platform_profile_register(&platform_profile_handler, NULL);
>   	if (err)
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 96e99513b0b5..050919a28d2b 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct device *dev,
>   	return -EINTR;
>   }
>   
> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static void dytc_profile_refresh(struct ideapad_private *priv)
>   {
>   	enum platform_profile_option profile;
> @@ -1064,6 +1073,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>   };
>   
>   static const struct platform_profile_ops dytc_profile_ops = {
> +	.probe = dytc_profile_probe,
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
> @@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	priv->dytc->priv = priv;
>   	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
> -
>   	/* Create platform_profile structure and register */
>   	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
>   	if (err)
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index d0a8e4eebffa..06df3aae9a56 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -164,7 +164,17 @@ static int inspur_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static int inspur_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops inspur_platform_profile_ops = {
> +	.probe = inspur_platform_profile_probe,
>   	.profile_get = inspur_platform_profile_get,
>   	.profile_set = inspur_platform_profile_set,
>   };
> @@ -184,10 +194,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->handler.dev = &wdev->dev;
>   	priv->handler.ops = &inspur_platform_profile_ops;
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> -
>   	return platform_profile_register(&priv->handler, priv);
>   }
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 9e26f5670fc7..62b2ddfe7c0a 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10539,7 +10539,17 @@ static int dytc_profile_set(struct device *dev,
>   	return err;
>   }
>   
> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dytc_profile_ops = {
> +	.probe = dytc_profile_probe,
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
> @@ -10585,11 +10595,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   {
>   	int err, output;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
> -
>   	err = dytc_command(DYTC_CMD_QUERY, &output);
>   	if (err)
>   		return err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6013c05d7b86..5ad1ab7b75e4 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -31,6 +31,7 @@ enum platform_profile_option {
>   struct platform_profile_handler;
>   
>   struct platform_profile_ops {
> +	int (*probe)(void *drvdata, unsigned long *choices);
>   	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
>   	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>   };


