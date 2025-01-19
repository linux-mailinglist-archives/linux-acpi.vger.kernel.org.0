Return-Path: <linux-acpi+bounces-10752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08409A1624E
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FF7188563C
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C41DED7D;
	Sun, 19 Jan 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRDSeGpP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A263CB;
	Sun, 19 Jan 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298541; cv=none; b=cmswb0SFOB4gbCd8mLxQN4px5wqxEJFmtPzK1Vsu6t2pUtaUOnjWIweSae8X7nhvkoS/+mFB0Vm0MTT3TO23EPVmaKvsiHRdkZykF9vKjDf+MV3UgNQjDmpe9GLZ8DnM8QQC/K+CcZMJQgUNgGteBRh8DF0zO7kR21UzLMw7MqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298541; c=relaxed/simple;
	bh=d6+OodACIUBBZFaVwRH4AhoJyssWAC5/AX+U+NrpSqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qz0pmIR2A6oy3JHv5QUIJBnG/PkwoWOihgq1ADvUXRzDWZAWSH323LDDiJsS5dKcpjJ9zEe3Bu/jLs9W7J+HeByU5ZjGgCnF5U53RawbqhS2+H0ew1ywYoMKBdZu7WtOEiu+VyQbdtShd968BZhbdg0VGgvAIaUsZ5NYeCUct6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRDSeGpP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d6d5765so2036818f8f.3;
        Sun, 19 Jan 2025 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737298538; x=1737903338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZo7kjreGQYa44/D0ZXoH0Re7rycZxstJh3ysoUhAlI=;
        b=mRDSeGpPPUWjWWg/6vtjgh78cZ3Nh5CJ+xTbtlUTSEmml0qdKWhzuKi4H0qTA4gtKe
         CJukKTDCuCyNoE7iFuTVX0UCMjComD1k8URdcX7ogrt83p5wSDxdAHaQWiC3LzlYEV4e
         NRxwfsvSjcFGowBUkXTzHn9MUgLlVBZNhLGYmnWFg3XJZvwkwY3/yoqWgEyUGlZihm8f
         xiCGFEUA6XHfvFzvyuPXVDd3F3HgFPta1vGGion14MnFWOJqxUC44r9w8UsmB2GDtHyD
         gXfJTuttVhweCvAZhViyNQsvvAz49BairjZCKeWXcSdQYOjYAD4LsoXWpCrFC8Jj2lR6
         xB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737298538; x=1737903338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZo7kjreGQYa44/D0ZXoH0Re7rycZxstJh3ysoUhAlI=;
        b=rV0KhyqvfvxQerkI0DeWSDFrDKI1SR29F+P0gG/507msO4RfPI0nwbEt7BbpS72a4c
         zPJYrUyrhQgiMxXRHZ4+9xj0B58yYQHkJh81ryLHsfUjrtoMsZ0flvBrycmoPwW8bLjL
         dN+AzcnqT7D2zD4dm2sfy8meEOyQ52VqrOg2bWjdH+puBZ7h0hJsNft5h5cBEFKgKHO4
         6DHovbb/Y1nFwUG4ITqzJeDyxBHm9xkLygs77BGhoIOmKEJan0vTGmm/8NA431t0PChz
         C5vugpNza+k5kdN1oFMnRph958dSvAT4Ir8WCWm1aIKc4r9Eh+Jr4jTJ7MKl2iGEddyO
         JiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW9MzIPBOBjLdQxRdj8GhBzp/dtL8+eu1XyW9w5YCHvegF/KPw1a7WHKt1GRPh1yPSy2yBy7g0BCeZCUinfZHOiCqTww==@vger.kernel.org, AJvYcCVC8qYJ/x0KjebQnKXru476hFzUXWXQMhYX0whb2nqH+/Fw10+UT5VlCLPrIxHRKvtGWEa+UtyJabplRsIS@vger.kernel.org, AJvYcCWMVh+cVvpdnNYj+01GmSqITR8HEv8NEipWr7k1NnlLIMKY43pAQPBO/BK6tzkNFX/7IoWAzAZQGr0A@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IhwY0ygtxjMNjzEpsHkJa79/zvYq+ztmgk5qT4g3Y7nglDOp
	MdW1R8c21Fk7eDC7WtmttkB7Ed02SLChmXFIXkDEzeUgzyGrIxR0
X-Gm-Gg: ASbGnctt2murVUWpFvA1p6I0/00OYCv8AjtXIuOCTqJQ9ItxBWVl+bAafvbk6OPWt41
	bclyh1PKdkKFNP2LrfTEnAbdkjjqDr62vP9vxUgSstbgU8XLl3AJJPz3fIoS93t+D2BPkEpExHL
	qZwYmez2+sELXND72/TZhWpsSJkgUi4TT6BrcLppv513UMN2Rh4VWmlvFbzWMEwcb4ZueAAoQXC
	nKUun8J8FEL0pDGKxi33Xld2X7ptK5RlPRX/upcTU3EM/zaEbJLEo/vHMbczWjCxgh3ZZ/0RCxG
	IFRQ9bgQUkD50vPEOQylbHJUajuq9onPQ3Lh55BsN67Aywg=
X-Google-Smtp-Source: AGHT+IHSEh3Ej9pE62puV/Xr9yCewOS24NLi5tVilLLNpZf5i7BqktYj+YffwFLnAka7qRMwNuH6ug==
X-Received: by 2002:a5d:59ad:0:b0:38b:ed7b:f78c with SMTP id ffacd0b85a97d-38bf566f41cmr7863396f8f.6.1737298537486;
        Sun, 19 Jan 2025 06:55:37 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322236csm7901840f8f.39.2025.01.19.06.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 06:55:36 -0800 (PST)
Message-ID: <944696bd-89d0-4ee6-800d-71413e1dd7b1@gmail.com>
Date: Sun, 19 Jan 2025 15:55:33 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/19] ACPI: platform_profile: Let drivers set drvdata
 to the class device
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
 <20250116002721.75592-3-kuurtb@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20250116002721.75592-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 1:27 AM, Kurt Borja wrote:
> Add *drvdata to platform_profile_register() signature and assign it to
> the class device.
> 
> While at it, pass specific driver state as drvdata to replace uses of
> container_of() with dev_get_drvdata().
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/acpi/platform_profile.c                     | 7 ++++---
>   drivers/platform/surface/surface_platform_profile.c | 6 +++---
>   drivers/platform/x86/acer-wmi.c                     | 2 +-
>   drivers/platform/x86/amd/pmf/sps.c                  | 6 +++---
>   drivers/platform/x86/asus-wmi.c                     | 6 +++---
>   drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
>   drivers/platform/x86/dell/dell-pc.c                 | 2 +-
>   drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
>   drivers/platform/x86/ideapad-laptop.c               | 6 +++---
>   drivers/platform/x86/inspur_platform_profile.c      | 8 +++-----
>   drivers/platform/x86/thinkpad_acpi.c                | 2 +-
>   include/linux/platform_profile.h                    | 4 ++--
>   12 files changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 15f24adc57d4..689541d2e66c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -460,7 +460,7 @@ int platform_profile_cycle(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>   
> -int platform_profile_register(struct platform_profile_handler *pprof)
> +int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
>   {
>   	int err;
>   
> @@ -480,6 +480,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   
>   	pprof->class_dev.class = &platform_profile_class;
>   	pprof->class_dev.parent = pprof->dev;
> +	dev_set_drvdata(&pprof->class_dev, drvdata);
>   	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
>   	err = device_register(&pprof->class_dev);
>   	if (err) {
> @@ -529,7 +530,7 @@ static void devm_platform_profile_release(struct device *dev, void *res)
>   	platform_profile_remove(*pprof);
>   }
>   
> -int devm_platform_profile_register(struct platform_profile_handler *pprof)
> +int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
>   {
>   	struct platform_profile_handler **dr;
>   	int ret;
> @@ -538,7 +539,7 @@ int devm_platform_profile_register(struct platform_profile_handler *pprof)
>   	if (!dr)
>   		return -ENOMEM;
>   
> -	ret = platform_profile_register(pprof);
> +	ret = platform_profile_register(pprof, drvdata);
>   	if (ret) {
>   		devres_free(dr);
>   		return ret;
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 6c87e982bfc8..edb9362003a4 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -161,7 +161,7 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
>   	enum ssam_tmp_profile tp;
>   	int status;
>   
> -	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
> +	tpd = dev_get_drvdata(&pprof->class_dev);
>   
>   	status = ssam_tmp_profile_get(tpd->sdev, &tp);
>   	if (status)
> @@ -181,7 +181,7 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
>   	struct ssam_platform_profile_device *tpd;
>   	int tp;
>   
> -	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
> +	tpd = dev_get_drvdata(&pprof->class_dev);
>   
>   	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
>   	if (tp < 0)
> @@ -224,7 +224,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
>   
> -	return platform_profile_register(&tpd->handler);
> +	return platform_profile_register(&tpd->handler, tpd);
>   }
>   
>   static void surface_platform_profile_remove(struct ssam_device *sdev)
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index acf610d59168..1aedf0ef4189 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2073,7 +2073,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   				ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
>   		}
>   
> -		err = platform_profile_register(&platform_profile_handler);
> +		err = platform_profile_register(&platform_profile_handler, NULL);
>   		if (err)
>   			return err;
>   
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index bd2bd6cfc39a..259a598acd3e 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -285,7 +285,7 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
>   static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
>   			       enum platform_profile_option *profile)
>   {
> -	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
>   
>   	*profile = pmf->current_profile;
>   	return 0;
> @@ -366,7 +366,7 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
>   static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
>   			       enum platform_profile_option profile)
>   {
> -	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
>   	int ret = 0;
>   
>   	pmf->current_profile = profile;
> @@ -416,7 +416,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
>   
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&dev->pprof);
> +	err = platform_profile_register(&dev->pprof, dev);
>   	if (err)
>   		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
>   			err);
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6c674de60ec0..f91099792cb9 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3806,7 +3806,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> +	asus = dev_get_drvdata(&pprof->class_dev);
>   	tp = asus->throttle_thermal_policy_mode;
>   
>   	switch (tp) {
> @@ -3832,7 +3832,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> +	asus = dev_get_drvdata(&pprof->class_dev);
>   
>   	switch (profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
> @@ -3887,7 +3887,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE,
>   		asus->platform_profile_handler.choices);
>   
> -	err = platform_profile_register(&asus->platform_profile_handler);
> +	err = platform_profile_register(&asus->platform_profile_handler, asus);
>   	if (err == -EEXIST) {
>   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
>   		return 0;
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index d7f577e0d146..154c417a438c 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1129,7 +1129,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   	pp_handler.name = "alienware-wmi";
>   	pp_handler.dev = &platform_device->dev;
>   
> -	return devm_platform_profile_register(&pp_handler);
> +	return devm_platform_profile_register(&pp_handler, NULL);
>   }
>   
>   /*
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 3797a5721dbd..1a0a721d706f 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -271,7 +271,7 @@ static int thermal_init(void)
>   		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
>   
>   	/* Clean up if failed */
> -	ret = platform_profile_register(thermal_handler);
> +	ret = platform_profile_register(thermal_handler, NULL);
>   	if (ret)
>   		goto cleanup_thermal_handler;
>   
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 6d6e13a0c6e2..8e5e1422e024 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1629,7 +1629,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
>   
> -	err = platform_profile_register(&platform_profile_handler);
> +	err = platform_profile_register(&platform_profile_handler, NULL);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index dc98f862a06d..ed0d880a07a9 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -936,7 +936,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>   static int dytc_profile_get(struct platform_profile_handler *pprof,
>   			    enum platform_profile_option *profile)
>   {
> -	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
>   
>   	*profile = dytc->current_profile;
>   	return 0;
> @@ -989,7 +989,7 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
>   static int dytc_profile_set(struct platform_profile_handler *pprof,
>   			    enum platform_profile_option profile)
>   {
> -	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
>   	struct ideapad_private *priv = dytc->priv;
>   	unsigned long output;
>   	int err;
> @@ -1114,7 +1114,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
>   
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&priv->dytc->pprof);
> +	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
>   	if (err)
>   		goto pp_reg_failed;
>   
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 53af73a7fbf7..471fca50d1c9 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -87,8 +87,7 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
>   static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
>   				       enum platform_profile_option profile)
>   {
> -	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
> -						    handler);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -135,8 +134,7 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
>   static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
>   				       enum platform_profile_option *profile)
>   {
> -	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
> -						    handler);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -186,7 +184,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
>   
> -	return platform_profile_register(&priv->handler);
> +	return platform_profile_register(&priv->handler, priv);
>   }
>   
>   static void inspur_wmi_remove(struct wmi_device *wdev)
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d99573e7a983..8be3f4e5366d 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10641,7 +10641,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   
>   	dytc_profile.dev = &tpacpi_pdev->dev;
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&dytc_profile);
> +	err = platform_profile_register(&dytc_profile, NULL);
>   	/*
>   	 * If for some reason platform_profiles aren't enabled
>   	 * don't quit terminally.
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 8a9b8754f9ac..1c8fdda51eaa 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -40,9 +40,9 @@ struct platform_profile_handler {
>   				enum platform_profile_option profile);
>   };
>   
> -int platform_profile_register(struct platform_profile_handler *pprof);
> +int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
>   int platform_profile_remove(struct platform_profile_handler *pprof);
> -int devm_platform_profile_register(struct platform_profile_handler *pprof);
> +int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
>   int platform_profile_cycle(void);
>   void platform_profile_notify(struct platform_profile_handler *pprof);
>   


