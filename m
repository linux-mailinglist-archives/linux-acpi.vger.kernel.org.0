Return-Path: <linux-acpi+bounces-10753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C9A16253
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9873A561A
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E61DEFF5;
	Sun, 19 Jan 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUYAM1tS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607363CB;
	Sun, 19 Jan 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298677; cv=none; b=lxDh34eetheaJ0cRI6Kn1cKrWK76H0X17Xn/lqI/2siTjxQgvSwzNk1rFPAAUyqPx5rFPUzUIhDlIEHM4J8+m/uSZ8igEQTb2S21RVb2+Nu83GQJtcVbiVeW2ulCZYwceqZxhQ/y/zo4uKHz/P40sRrPtKz89gyg7COR42AbekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298677; c=relaxed/simple;
	bh=hlMM5Ua7T0ny8pgzxbCfeM3Av+h26E+tvNHWZMV4lGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVa8J1BS0HM85z16ayWKQZjnSV5B6lLzPCu6Re4WajRIl90M82/2einkB4MeK3ofbYl4NDjaE8UfgqMbO4TbQ+RoSwj0y7xvYX12tNtKTnbM7ydcT7aNJo/V0HuBLV7PP+mUW/3c5CZpiU8oPTZUgzdOds9aDiz9exinQjQ4I0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUYAM1tS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso28549605e9.0;
        Sun, 19 Jan 2025 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737298673; x=1737903473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DffJB0lTuVD42PDlF7IJqkL13ayp3hcEO1833cRWbu4=;
        b=bUYAM1tSgpmy+hFQjt+srxTGuPru7lcJfERYwdG/qwSjMm7hTzHOftD722Uow+VqMZ
         jiwKXSiPrY0RV5lA/E5AzBIe/uUM/qZgaRqzoSexBfa1kzGLhiZSmNQHvoQVKH4bSpCx
         dZkDCkZIIN5XLm+EO07TI6k+l7Dc6rcXpUa0R+g1PjZNeKMIlci2UjNHOBoXfSwIq6MQ
         aapoxrCwIm0rNXOHCL1jQMf1NGTGvdzanF+jEqawUrkSQWNKejhXqwY71oFdTDff8JRq
         ccMnwS73iugXWRFre9TYYlyw424otsjyeGz3lrrh3AJRHMobuPzTz3Zv2P7d+EOGSO+Y
         l2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737298673; x=1737903473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DffJB0lTuVD42PDlF7IJqkL13ayp3hcEO1833cRWbu4=;
        b=Y7YNr7Jd730DDBEF2av+/DQ5CLh9Qd3IX9BY3DveEx2my1EK1LTeJhyiKmhYXt2whQ
         Hg0p8zMecaNxRfRxhwJKZwNeuuFabFZ5ElwduB7FV04eXtlXx8Z1Jk1KmC5NTFwyXiRA
         gpWjOYv94U6Ef0UWzXVSomchq5KQlbbqWTb/IC+vdf5XNN8Ru8yQM7iizGURaAdM0UhA
         C7E10QCsAfJqtqVGwF7N0vvBtdEsrr62XpuzSpuklAOyAha/wAqcupCOcvBBw8XBHuJw
         wc1wY6PDX0JVqNzpOoOeva3Q+qVytplacxJyheh4lsaqn8WQqQS32UyDkdcHQeEbFMFM
         L/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9nb8YUwEiDbtC4YiEVL959WNebUT1uQjRQRTDCLUivcBCFxOuZMgyqv9pcGMWM/ca2pxHGMWq99ge@vger.kernel.org, AJvYcCVgiw5fIipXldqWhNtH0jCl4/ftW4N3nHTnKjiuMzr2/b1EN1lPFydCIkALULrtMnA9byYpZ98n+cCG0GpR4R+gLNqzMA==@vger.kernel.org, AJvYcCXhKCY9foK08WbxF07yPioSKov/Je+QT7gV+FkU3teRaUJJBKUoQE2RaOKUUiYaXBywPANA/4mW4AOXuEmS@vger.kernel.org
X-Gm-Message-State: AOJu0YxKY//zC/p3P3p5je5zuSj7Ej6eQOfATsrwR+mYpt7uG2ap3YAw
	akTPZ0UTU23EE+MZDOlHN9whW67Xu07s20cfq7l432EStunaNac5
X-Gm-Gg: ASbGnct9wr2oSP77shutiRRDoi910fNYytmBZy/6en3XEWZZXuJfMYTu0DNGpDfiky/
	8QE253/0uUbTet50bq+8DYanES96zXE/pjea4Ab3uY47CxRkerH1T8kzZ/OWaEHhoGKUcbrK54N
	uKuh9kP7wWFAUjlSJgESIHQDMVHQeuHCNsIKFCCCgSVVkiF7LTYhl3IjILcXrULgndNp9urU2pJ
	bA307ZiHdRek0Go3HdbkecLMb17uV16T3wTzAWQyOzgPWXacKfYM8CWnmzJfLKQPEomxiR6Qu3i
	JJVqL3xFVVaH4WFbIOU8z9KI9BWAsjeTIsimj5k/YLCyGNs=
X-Google-Smtp-Source: AGHT+IEjPLMwO1Xhcjy3cVRUXH7dQ2+PJg9xr+Tq0m5Cg02Rt3tT1IB8UprgJXG62sokhxyKtbaFPQ==
X-Received: by 2002:a05:600c:2e11:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-438926daa5emr77020585e9.8.1737298673201;
        Sun, 19 Jan 2025 06:57:53 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904621cdsm104748795e9.27.2025.01.19.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 06:57:52 -0800 (PST)
Message-ID: <ed32abca-5d38-4ef4-aafb-fd047732920f@gmail.com>
Date: Sun, 19 Jan 2025 15:57:51 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/19] ACPI: platform_profile: Remove
 platform_profile_handler from callbacks
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
 <20250116002721.75592-4-kuurtb@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20250116002721.75592-4-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 1:27 AM, Kurt Borja wrote:
> Devices can now set drvdata to the class device, thus passing the
> platform_profile_handler to callbacks is unnecessary. Instead pass the
> class device.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/acpi/platform_profile.c                    |  4 ++--
>   .../platform/surface/surface_platform_profile.c    |  8 ++++----
>   drivers/platform/x86/acer-wmi.c                    |  4 ++--
>   drivers/platform/x86/amd/pmf/sps.c                 |  8 ++++----
>   drivers/platform/x86/asus-wmi.c                    |  8 ++++----
>   drivers/platform/x86/dell/alienware-wmi.c          |  4 ++--
>   drivers/platform/x86/dell/dell-pc.c                |  4 ++--
>   drivers/platform/x86/hp/hp-wmi.c                   | 14 +++++++-------
>   drivers/platform/x86/ideapad-laptop.c              |  8 ++++----
>   drivers/platform/x86/inspur_platform_profile.c     |  8 ++++----
>   drivers/platform/x86/thinkpad_acpi.c               |  4 ++--
>   include/linux/platform_profile.h                   |  6 ++----
>   12 files changed, 39 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 689541d2e66c..bd90aa4e8371 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -65,7 +65,7 @@ static int _store_class_profile(struct device *dev, void *data)
>   	if (!test_bit(*bit, handler->choices))
>   		return -EOPNOTSUPP;
>   
> -	return handler->profile_set(handler, *bit);
> +	return handler->profile_set(dev, *bit);
>   }
>   
>   /**
> @@ -102,7 +102,7 @@ static int get_class_profile(struct device *dev,
>   
>   	lockdep_assert_held(&profile_lock);
>   	handler = to_pprof_handler(dev);
> -	err = handler->profile_get(handler, &val);
> +	err = handler->profile_get(dev, &val);
>   	if (err) {
>   		pr_err("Failed to get profile for handler %s\n", handler->name);
>   		return err;
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index edb9362003a4..26c1230e75df 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -154,14 +154,14 @@ static int convert_profile_to_ssam_fan(struct ssam_device *sdev, enum platform_p
>   	}
>   }
>   
> -static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
> +static int ssam_platform_profile_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
>   	struct ssam_platform_profile_device *tpd;
>   	enum ssam_tmp_profile tp;
>   	int status;
>   
> -	tpd = dev_get_drvdata(&pprof->class_dev);
> +	tpd = dev_get_drvdata(dev);
>   
>   	status = ssam_tmp_profile_get(tpd->sdev, &tp);
>   	if (status)
> @@ -175,13 +175,13 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
> +static int ssam_platform_profile_set(struct device *dev,
>   				     enum platform_profile_option profile)
>   {
>   	struct ssam_platform_profile_device *tpd;
>   	int tp;
>   
> -	tpd = dev_get_drvdata(&pprof->class_dev);
> +	tpd = dev_get_drvdata(dev);
>   
>   	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
>   	if (tp < 0)
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 1aedf0ef4189..c68c0d744a69 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1950,7 +1950,7 @@ static int acer_toggle_turbo(void)
>   }
>   
>   static int
> -acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
> +acer_predator_v4_platform_profile_get(struct device *dev,
>   				      enum platform_profile_option *profile)
>   {
>   	u8 tp;
> @@ -1984,7 +1984,7 @@ acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
>   }
>   
>   static int
> -acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
> +acer_predator_v4_platform_profile_set(struct device *dev,
>   				      enum platform_profile_option profile)
>   {
>   	int err, tp;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 259a598acd3e..cf2e51f67787 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -282,10 +282,10 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
>   	return (pmf->current_profile == PLATFORM_PROFILE_BALANCED) ? true : false;
>   }
>   
> -static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
> +static int amd_pmf_profile_get(struct device *dev,
>   			       enum platform_profile_option *profile)
>   {
> -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>   
>   	*profile = pmf->current_profile;
>   	return 0;
> @@ -363,10 +363,10 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
>   	return 0;
>   }
>   
> -static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
> +static int amd_pmf_profile_set(struct device *dev,
>   			       enum platform_profile_option profile)
>   {
> -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>   	int ret = 0;
>   
>   	pmf->current_profile = profile;
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index f91099792cb9..6b8b30551d36 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3800,13 +3800,13 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>   
>   /* Platform profile ***********************************************************/
> -static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> +static int asus_wmi_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = dev_get_drvdata(&pprof->class_dev);
> +	asus = dev_get_drvdata(dev);
>   	tp = asus->throttle_thermal_policy_mode;
>   
>   	switch (tp) {
> @@ -3826,13 +3826,13 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> +static int asus_wmi_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = dev_get_drvdata(&pprof->class_dev);
> +	asus = dev_get_drvdata(dev);
>   
>   	switch (profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 154c417a438c..0346f8e88bf8 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1026,7 +1026,7 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
>   	return 0;
>   }
>   
> -static int thermal_profile_get(struct platform_profile_handler *pprof,
> +static int thermal_profile_get(struct device *dev,
>   			       enum platform_profile_option *profile)
>   {
>   	u32 out_data;
> @@ -1052,7 +1052,7 @@ static int thermal_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int thermal_profile_set(struct platform_profile_handler *pprof,
> +static int thermal_profile_set(struct device *dev,
>   			       enum platform_profile_option profile)
>   {
>   	if (quirks->gmode) {
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 1a0a721d706f..c86b05b5a1cb 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -185,7 +185,7 @@ static int thermal_set_mode(enum thermal_mode_bits state)
>   	return dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
>   }
>   
> -static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +static int thermal_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	switch (profile) {
> @@ -202,7 +202,7 @@ static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
>   	}
>   }
>   
> -static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +static int thermal_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	int ret;
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 8e5e1422e024..b8e62dc9cecd 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1221,7 +1221,7 @@ static int platform_profile_omen_get_ec(enum platform_profile_option *profile)
>   	return 0;
>   }
>   
> -static int platform_profile_omen_get(struct platform_profile_handler *pprof,
> +static int platform_profile_omen_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
>   	/*
> @@ -1318,7 +1318,7 @@ static int platform_profile_omen_set_ec(enum platform_profile_option profile)
>   	return 0;
>   }
>   
> -static int platform_profile_omen_set(struct platform_profile_handler *pprof,
> +static int platform_profile_omen_set(struct device *dev,
>   				     enum platform_profile_option profile)
>   {
>   	int err;
> @@ -1345,7 +1345,7 @@ static int thermal_profile_set(int thermal_profile)
>   							   sizeof(thermal_profile), 0);
>   }
>   
> -static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> +static int hp_wmi_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	int tp;
> @@ -1374,7 +1374,7 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> +static int hp_wmi_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	int err, tp;
> @@ -1440,11 +1440,11 @@ static int platform_profile_victus_get_ec(enum platform_profile_option *profile)
>   	return 0;
>   }
>   
> -static int platform_profile_victus_get(struct platform_profile_handler *pprof,
> +static int platform_profile_victus_get(struct device *dev,
>   				       enum platform_profile_option *profile)
>   {
>   	/* Same behaviour as platform_profile_omen_get */
> -	return platform_profile_omen_get(pprof, profile);
> +	return platform_profile_omen_get(dev, profile);
>   }
>   
>   static int platform_profile_victus_set_ec(enum platform_profile_option profile)
> @@ -1472,7 +1472,7 @@ static int platform_profile_victus_set_ec(enum platform_profile_option profile)
>   	return 0;
>   }
>   
> -static int platform_profile_victus_set(struct platform_profile_handler *pprof,
> +static int platform_profile_victus_set(struct device *dev,
>   				       enum platform_profile_option profile)
>   {
>   	int err;
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index ed0d880a07a9..fc317f42bb82 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -933,10 +933,10 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>    * dytc_profile_get: Function to register with platform_profile
>    * handler. Returns current platform profile.
>    */
> -static int dytc_profile_get(struct platform_profile_handler *pprof,
> +static int dytc_profile_get(struct device *dev,
>   			    enum platform_profile_option *profile)
>   {
> -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
>   
>   	*profile = dytc->current_profile;
>   	return 0;
> @@ -986,10 +986,10 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
>    * dytc_profile_set: Function to register with platform_profile
>    * handler. Sets current platform profile.
>    */
> -static int dytc_profile_set(struct platform_profile_handler *pprof,
> +static int dytc_profile_set(struct device *dev,
>   			    enum platform_profile_option profile)
>   {
> -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
>   	struct ideapad_private *priv = dytc->priv;
>   	unsigned long output;
>   	int err;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 471fca50d1c9..47d2dbbf3392 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -84,10 +84,10 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
>    *         0x0: No Error
>    *         0x1: Error
>    */
> -static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
> +static int inspur_platform_profile_set(struct device *dev,
>   				       enum platform_profile_option profile)
>   {
> -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -131,10 +131,10 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
>    *         0x1: Performance Mode
>    *         0x2: Power Saver Mode
>    */
> -static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> +static int inspur_platform_profile_get(struct device *dev,
>   				       enum platform_profile_option *profile)
>   {
> -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 8be3f4e5366d..0abe22228fdb 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10415,7 +10415,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>    * dytc_profile_get: Function to register with platform_profile
>    * handler. Returns current platform profile.
>    */
> -static int dytc_profile_get(struct platform_profile_handler *pprof,
> +static int dytc_profile_get(struct device *dev,
>   			    enum platform_profile_option *profile)
>   {
>   	*profile = dytc_current_profile;
> @@ -10490,7 +10490,7 @@ static int dytc_cql_command(int command, int *output)
>    * dytc_profile_set: Function to register with platform_profile
>    * handler. Sets current platform profile.
>    */
> -static int dytc_profile_set(struct platform_profile_handler *pprof,
> +static int dytc_profile_set(struct device *dev,
>   			    enum platform_profile_option profile)
>   {
>   	int perfmode;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 1c8fdda51eaa..5296d886c243 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -34,10 +34,8 @@ struct platform_profile_handler {
>   	struct device class_dev;
>   	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -	int (*profile_get)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option *profile);
> -	int (*profile_set)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option profile);
> +	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> +	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>   };
>   
>   int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);


