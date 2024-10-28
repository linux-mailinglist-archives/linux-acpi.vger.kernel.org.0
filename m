Return-Path: <linux-acpi+bounces-9051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95E9B379E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B491C21753
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB41DF278;
	Mon, 28 Oct 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR0/QZK5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414E1DEFDC;
	Mon, 28 Oct 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136434; cv=none; b=LeGrwfBcnKqVx+JLAh3jEVow4H7qL8bE3UhN/hh7J6hsjOqeTguh75GtdLjic70MJvKuYW045J5CHyCcUGEmyAK/MCZ+o+3i9Vzqf+zjvrmEzpoAoa49oMWJ/iXVHdarinZx6+i/iZmuHOUgz3RoFIne4mFFW1JSqJpw306dGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136434; c=relaxed/simple;
	bh=wcc6EUi/qQH5YrvpcTs9JF6ZdhFFrzdwGVfl6k/AfuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etyD4DsnT0n+zXaz83tLKDkPTBjiHotc6qUQNfwqKjetmmUv6oVosqn7rXbi8oTmzMWYed2Sxq2UUsNT05ebgdevSUR82UQkloavBXDPrHGPGF45hSJZXukIIHeCj29uuHcIhh3JL+c3odscsyoeZ69M2b+xj93sP6cd8kYqWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR0/QZK5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so3401990f8f.3;
        Mon, 28 Oct 2024 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730136430; x=1730741230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GIuXZYtbfms35RWsodZBw69RyvFI/nKrjcrpHMkH7Y=;
        b=FR0/QZK54VvvMsV3qYd9ShSAw1lSICYoAIIuNgesxkRu8tZu5FcApgMF282590wFLh
         lDrUierUPZDiJwoE5nqwegSsL9DuL7tLzzBP9Q7g1VSpvFVclmhEyDZqCux9Aw++nPLN
         3MLKVu7O2iNfDbb1ugfQSRhbGvT4RGexcw7wamzw5emVoGAzC9aIWjQF6PDT3qg5xO7Z
         o2YUf1SWJdf7UdheXcDsSpWJyEqCja7quXIeIARWdA6sS5JntJj2TuhO2huVizeX5V/A
         oRq4F1EXQQt83PH3+Xv1NSu3crZOasnQT62xVqmutJG7ShBCVaj4H0hX7/o/c3NUVayb
         mMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136430; x=1730741230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GIuXZYtbfms35RWsodZBw69RyvFI/nKrjcrpHMkH7Y=;
        b=QO0ybbKQkfVG4HGEIbdaaKfCEWoaE7ywsuXpN6mEK7FS5EljpiBHCi4eIXyQZus8gN
         4XUBuPnDJETLyav+mQ7EBKQY/AszjlyEczini05hySIQOrxg1DasipazGcD+8Q+s+C3Q
         mX3EIdcKSnSmTrTPGmcsfdEwtSR+DdqVRLJGSY5/4g9EvFUJdQau7jirkZliVifNqP3A
         vJi+04BYop/pkmHZoTQbr+sUr30kyIyWBDIwYJLtAxm1nVYxcgZnRO+LxB1k2yt0chhk
         A4+tUpL4YT2A8/MRkQpRLls87/KdpRmz+Nx6zIEpm1aXT7XA/tZrexFsxIhN9tsW3vDk
         xU5A==
X-Forwarded-Encrypted: i=1; AJvYcCUGtBJbj0MTqQsLvD3JMMKYJWIVEEv2sf/lEOg17c1MUSnvSCz8phLbjmNW/3+UlP/W7kp+8YDwdhsg2r/7PTP/E2HxFA==@vger.kernel.org, AJvYcCUpKGtWdGerCSNDK5Yck8wYpvUkPudYQyHfHGMV5C/WHBGmicOH6CGDzKhoWIo3AWfPrTedtCc1Aacb@vger.kernel.org, AJvYcCXbkQipFIhUWNZZSeXsGkATjG2QBsv5Pe2SlasmGwuyw1MZJ8RPTjF/TVBRZ3LP1IVG3mXyZqVCXAZrI+6J@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhryR+lFI+ts3NmYTnnQ0YM17IATZ7gMzHMLVKuVMRgTX3nO/
	zXfx4W78d6Veh9rfwqms9comlLqiKhHePIy53O6ogtXeUECPJS3m
X-Google-Smtp-Source: AGHT+IFH8FZp94+bKDiSZ1DtHoihHVoS504HyDVsUZF8bRqN83ikfipHPjeoB5lbWq4aG1ptY76Egw==
X-Received: by 2002:a5d:6810:0:b0:37d:52db:a0a7 with SMTP id ffacd0b85a97d-3806110a2b6mr6831795f8f.2.1730136429374;
        Mon, 28 Oct 2024 10:27:09 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479a4sm10018841f8f.55.2024.10.28.10.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:27:08 -0700 (PDT)
Message-ID: <d3e2b18f-fa6f-4776-a26a-9fdd54256795@gmail.com>
Date: Mon, 28 Oct 2024 18:27:07 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] ACPI: platform-profile: Add a name member to
 handlers
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
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <20241028020131.8031-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20241028020131.8031-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 3:01 AM, Mario Limonciello wrote:
> In order to prepare for allowing multiple handlers, introduce
> a name field that can be used to distinguish between different
> handlers.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/surface/surface_platform_profile.c | 1 +
>   drivers/platform/x86/acer-wmi.c                     | 1 +
>   drivers/platform/x86/amd/pmf/sps.c                  | 1 +
>   drivers/platform/x86/asus-wmi.c                     | 1 +
>   drivers/platform/x86/dell/dell-pc.c                 | 1 +
>   drivers/platform/x86/hp/hp-wmi.c                    | 1 +
>   drivers/platform/x86/ideapad-laptop.c               | 1 +
>   drivers/platform/x86/inspur_platform_profile.c      | 1 +
>   drivers/platform/x86/thinkpad_acpi.c                | 1 +
>   include/linux/platform_profile.h                    | 1 +
>   10 files changed, 10 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 3de864bc66108..61aa488a80eb5 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -211,6 +211,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->sdev = sdev;
>   
> +	tpd->handler.name = "Surface Platform Profile";
>   	tpd->handler.profile_get = ssam_platform_profile_get;
>   	tpd->handler.profile_set = ssam_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index d09baa3d3d902..53fbc9b4d3df7 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1878,6 +1878,7 @@ static int acer_platform_profile_setup(void)
>   	if (quirks->predator_v4) {
>   		int err;
>   
> +		platform_profile_handler.name = "acer-wmi";
>   		platform_profile_handler.profile_get =
>   			acer_predator_v4_platform_profile_get;
>   		platform_profile_handler.profile_set =
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 92f7fb22277dc..e2d0cc92c4396 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -405,6 +405,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   		amd_pmf_set_sps_power_limits(dev);
>   	}
>   
> +	dev->pprof.name = "amd-pmf";
>   	dev->pprof.profile_get = amd_pmf_profile_get;
>   	dev->pprof.profile_set = amd_pmf_profile_set;
>   
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2ccc23b259d3e..c7c104c65a85a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3910,6 +3910,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   
>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
>   
> +	asus->platform_profile_handler.name = "asus-wmi";
>   	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
>   	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 972385ca1990b..3cf79e55e3129 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -247,6 +247,7 @@ static int thermal_init(void)
>   	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
>   	if (!thermal_handler)
>   		return -ENOMEM;
> +	thermal_handler->name = "dell-pc";
>   	thermal_handler->profile_get = thermal_platform_profile_get;
>   	thermal_handler->profile_set = thermal_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 81ccc96ffe40a..26cac73caf2b9 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
>   		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	}
>   
> +	platform_profile_handler.name = "hp-wmi";
>   	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
>   
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 9d8c3f064050e..1f94c14c3b832 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1102,6 +1102,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   
>   	mutex_init(&priv->dytc->mutex);
>   
> +	priv->dytc->pprof.name = "ideapad-laptop";
>   	priv->dytc->priv = priv;
>   	priv->dytc->pprof.profile_get = dytc_profile_get;
>   	priv->dytc->pprof.profile_set = dytc_profile_set;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 8440defa67886..03da2c8cf6789 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -177,6 +177,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->wdev = wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>   
> +	priv->handler.name = "inspur-wmi";
>   	priv->handler.profile_get = inspur_platform_profile_get;
>   	priv->handler.profile_set = inspur_platform_profile_set;
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 4c1b0553f8720..c8c316b8507a5 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10549,6 +10549,7 @@ static void dytc_profile_refresh(void)
>   }
>   
>   static struct platform_profile_handler dytc_profile = {
> +	.name = "thinkpad-acpi",
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index f5492ed413f36..6fa988e417428 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -27,6 +27,7 @@ enum platform_profile_option {
>   };
>   
>   struct platform_profile_handler {
> +	const char *name;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	int (*profile_get)(struct platform_profile_handler *pprof,
>   				enum platform_profile_option *profile);

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

