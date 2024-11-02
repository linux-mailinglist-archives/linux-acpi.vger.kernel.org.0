Return-Path: <linux-acpi+bounces-9260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3579B9E72
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 10:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4499D282D5B
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678516DC3C;
	Sat,  2 Nov 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvhe4o5N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A86168483;
	Sat,  2 Nov 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730541414; cv=none; b=NmBKiDtAkWZdDeFRrDFatte1bx+AII/9m53dqy07miT6U+off65GlRW7TQMmUSXoMEPjOVv8S3O/tjyW3Ak5KhR1vZLji2OnmtFHb6t9C8SuixA0s0ihUOgwe+oM3maGZObZZK44ZPChjr2i99lNbjLFPQAQXnrfHCjYoSGrEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730541414; c=relaxed/simple;
	bh=O8oxt0HSg6BBXyGiy0q6zQEt8ggOag0pRfI/KWjXgzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoYZnj6R5Z+xh8QlufiieG4l4pMlaG4s3MuHrZ2qVIydSIM5AR4i+It6U5K1pDuB2/gIflYT9QBDLah6GXJzhXWd5qQsBNF3/L9P7KDHSydGDwc5nbjqOg7BjSLGPNuc2clAbOxv33s9/jqgEcB9Y4A11Ee1W+baOePcy0hujjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvhe4o5N; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9aa8895facso445559866b.2;
        Sat, 02 Nov 2024 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730541411; x=1731146211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNKePvoTnY7Ct0tO3NEQWZDQeRQcX5+t+KCC7Wqlyl0=;
        b=fvhe4o5NbvvL2Li3XWF0WKiHhj4On9saSenHCEXlRCNHh17tU0ITpOx6iayScnras2
         uLVp91Z1WEndvuRQktCUo9qwVVp1uH1Nw18tKmLs6lHSNtw0fGAwfTgRIcLpaTXyEEL7
         f/RnNb2paWjDM+YtTQNxDio2DcqCJ+z9yEGPVAkP2LPs5OMDL4aBXrI6igziBYQK+GD7
         IyjhFvrfWfzRq/+H20TvYJYcPMG9IBnZGUk15LMy4zqw94kb5WWhmnimTA5APCUBqD7r
         1E79yNlsW2XE1JY41Nrq3y9QEClwLjMe07FzoDuxu5ryclz1LdExyo+/W6PjwRrz5raa
         LSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730541411; x=1731146211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNKePvoTnY7Ct0tO3NEQWZDQeRQcX5+t+KCC7Wqlyl0=;
        b=nBh5vW01ogQExJ/J5aWh7pJwBGmHphAz1WuZuBGCCI0ngK6VkxVMInhEC1RCai974i
         eE4gr0NdCbP6rSVDpQ71EpFpyf4bjoseiukP4p7zHum3rhm/CJ5kwAoYdAklia1uXK4K
         dbmeRVYF8+Asau3ncH7X/UJy8V1KDZ2vMWAYJCk5FoELMJsZYkCZZy/pC3UaPxVF7buj
         aHgH3szemrVjIsciDxct+/uT1rbHCIZPKm1wikldyLoFtmZQuC5DUlyZaQjWixYAVYI0
         KfU9RywXddEFIX0CMNuNMVt9iNqPsnBzTb1PX6h1EQDuUc3hcXp2+7sSYMEyfjnltGEF
         Xd+g==
X-Forwarded-Encrypted: i=1; AJvYcCUe3mSOIwNvP1jvkUHWInWj/L0cwB0wtygf/vLrybUuL320wx6eMzFfpVEFJoOlCcB5nj3ewfMBJ4JQt1PH@vger.kernel.org, AJvYcCWN+BTVz1a2LT9iWJtsGshfQnUVlIqHa3fEn6p7JDXQGXTE7hUG9/EMlZr5aeX6cSSrf7G4urYyBzoXOT+ZypIDgwsQcw==@vger.kernel.org, AJvYcCWqemRKg46CLWroXU5H5XEeRmSonnn1fg+Pd8eQDPU2klFbpDsBojCf/X3nxW75rKE8MGaSaREMnQdG@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVr5/lqbj+deuPl/K+4nI9S3UHk98Ug9Ic6NVVHlhqzyXyuUy
	Dkv2dSbEErVaR0mZLd6taBj0YmiEWRR7HiZh8lepbbKc25IVb2ES
X-Google-Smtp-Source: AGHT+IETkCSv9ErHOlrMA4Qbg71S4uSPBrM/74McMGIQcRM8tCEKHfVSmTd8ruEcKRoCQKUFMmTeAw==
X-Received: by 2002:a17:906:794c:b0:a99:e505:2089 with SMTP id a640c23a62f3a-a9de61ce121mr1157732366b.45.1730541410626;
        Sat, 02 Nov 2024 02:56:50 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566845c1sm292432466b.210.2024.11.02.02.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 02:56:50 -0700 (PDT)
Message-ID: <38522602-eff5-4274-b3f5-9736fe6ab16c@gmail.com>
Date: Sat, 2 Nov 2024 10:56:48 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/22] ACPI: platform_profile: Add device pointer into
 platform profile handler
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20241031040952.109057-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/24 5:09 AM, Mario Limonciello wrote:
> In order to let platform profile handlers manage platform profile
> for their driver the core code will need a pointer to the device.
> 
> Add this to the structure and use it in the trivial driver cases.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c                     | 5 +++++
>   drivers/platform/surface/surface_platform_profile.c | 1 +
>   drivers/platform/x86/acer-wmi.c                     | 5 +++--
>   drivers/platform/x86/amd/pmf/sps.c                  | 1 +
>   drivers/platform/x86/asus-wmi.c                     | 1 +
>   drivers/platform/x86/dell/dell-pc.c                 | 1 +
>   drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
>   drivers/platform/x86/ideapad-laptop.c               | 1 +
>   drivers/platform/x86/inspur_platform_profile.c      | 1 +
>   drivers/platform/x86/thinkpad_acpi.c                | 1 +
>   include/linux/platform_profile.h                    | 1 +
>   11 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d2f7fd7743a13..5d9f3f7ba71c5 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -179,6 +179,11 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   {
>   	int err;
>   
> +	if (!pprof->dev) {
> +		pr_err("platform_profile: handler device is not set\n");
> +		return -EINVAL;
> +	}
> +
>   	mutex_lock(&profile_lock);
>   	/* We can only have one active profile */
>   	if (cur_profile) {
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 9d3e3f9458186..b73cfdd920c66 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -212,6 +212,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   	tpd->sdev = sdev;
>   
>   	tpd->handler.name = "Surface Platform Profile";
> +	tpd->handler.dev = &sdev->dev;
>   	tpd->handler.profile_get = ssam_platform_profile_get;
>   	tpd->handler.profile_set = ssam_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 13a97afe0112d..a5caa529351ea 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1878,12 +1878,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int acer_platform_profile_setup(void)
> +static int acer_platform_profile_setup(struct platform_device *device)
>   {
>   	if (quirks->predator_v4) {
>   		int err;
>   
>   		platform_profile_handler.name = "acer-wmi";
> +		platform_profile_handler.dev = &device->dev;
>   		platform_profile_handler.profile_get =
>   			acer_predator_v4_platform_profile_get;
>   		platform_profile_handler.profile_set =
> @@ -2536,7 +2537,7 @@ static int acer_platform_probe(struct platform_device *device)
>   		goto error_rfkill;
>   
>   	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
> -		err = acer_platform_profile_setup();
> +		err = acer_platform_profile_setup(device);
>   		if (err)
>   			goto error_platform_profile;
>   	}
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index e2d0cc92c4396..1b94af7c0e0c4 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -406,6 +406,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	}
>   
>   	dev->pprof.name = "amd-pmf";
> +	dev->pprof.dev = dev->dev;
>   	dev->pprof.profile_get = amd_pmf_profile_get;
>   	dev->pprof.profile_set = amd_pmf_profile_set;
>   
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6177fbee60573..1a8c29aafe892 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3921,6 +3921,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
>   
>   	asus->platform_profile_handler.name = "asus-wmi";
> +	asus->platform_profile_handler.dev = dev;
>   	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
>   	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index b145fedb6b710..730f97aab70cd 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -260,6 +260,7 @@ static int thermal_init(void)
>   		goto cleanup_platform_device;
>   	}
>   	thermal_handler->name = "dell-pc";
> +	thermal_handler->dev = &platform_device->dev;
>   	thermal_handler->profile_get = thermal_platform_profile_get;
>   	thermal_handler->profile_set = thermal_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 10a853b6b0514..1b6677e176769 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1565,7 +1565,7 @@ static inline void omen_unregister_powersource_event_handler(void)
>   	unregister_acpi_notifier(&platform_power_source_nb);
>   }
>   
> -static int thermal_profile_setup(void)
> +static int thermal_profile_setup(struct platform_device *device)
>   {
>   	int err, tp;
>   
> @@ -1625,6 +1625,7 @@ static int thermal_profile_setup(void)
>   	}
>   
>   	platform_profile_handler.name = "hp-wmi";
> +	platform_profile_handler.dev = &device->dev;
>   	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
>   
> @@ -1664,7 +1665,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>   	if (err < 0)
>   		return err;
>   
> -	thermal_profile_setup();
> +	thermal_profile_setup(device);
>   
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 6c72d1b6a2aff..feaf98819dc82 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1103,6 +1103,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	mutex_init(&priv->dytc->mutex);
>   
>   	priv->dytc->pprof.name = "ideapad-laptop";
> +	priv->dytc->pprof.dev = &priv->platform_device->dev;
>   	priv->dytc->priv = priv;
>   	priv->dytc->pprof.profile_get = dytc_profile_get;
>   	priv->dytc->pprof.profile_set = dytc_profile_set;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 03da2c8cf6789..5a53949bbbf5f 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -178,6 +178,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	dev_set_drvdata(&wdev->dev, priv);
>   
>   	priv->handler.name = "inspur-wmi";
> +	priv->handler.dev = &wdev->dev;
>   	priv->handler.profile_get = inspur_platform_profile_get;
>   	priv->handler.profile_set = inspur_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index c8c316b8507a5..222fba97d79a7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10616,6 +10616,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   	dbg_printk(TPACPI_DBG_INIT,
>   			"DYTC version %d: thermal mode available\n", dytc_version);
>   
> +	dytc_profile.dev = &tpacpi_pdev->dev;
>   	/* Create platform_profile structure and register */
>   	err = platform_profile_register(&dytc_profile);
>   	/*
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6fa988e417428..daec6b9bad81f 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,6 +28,7 @@ enum platform_profile_option {
>   
>   struct platform_profile_handler {
>   	const char *name;
> +	struct device *dev;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	int (*profile_get)(struct platform_profile_handler *pprof,
>   				enum platform_profile_option *profile);

Looks good to me, thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

