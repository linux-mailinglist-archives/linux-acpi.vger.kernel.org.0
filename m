Return-Path: <linux-acpi+bounces-9003-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E99B16DA
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE984283472
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3091D222B;
	Sat, 26 Oct 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io3x9+VZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E21D1F7E
	for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937233; cv=none; b=BmUyJM8crSphZjoQIX2f8H8LnGeVuSBx5gIatMtCVa6Nwch8PwB4obrykmTVcRx8YosFj+9IDdZqUL5FbjmSJZLVZe6ETpNzyAZP9Re9GUgMfMTXhi5fm9UOrpZwWKM1gtcI7L7b3uV/8Zl1KV/NFRKRLp33+jnM1tBUB65TB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937233; c=relaxed/simple;
	bh=PAK7NI+Y1o5iQ60Gw/nX6qw7Ywizo6BTKFn5FMcdDzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOHg3BgJQe8QAMG9lse11gMXxKZi0SSwkvU1Hzr4GMGqYQUx0NYk8FgzgYQ4mmeGPQWxcn6184YQyYhADl/TIqJ6XaOPKp+U5cXmKdWyXHfFC/ifDORbLMo7CES51qYDPTO823i7xZscXExUTeXMYLlONBQDzmEWo+uFenNmZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=io3x9+VZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729937230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMNuE59JmqK6i5X+rh8qjVYOKDitaozUbQbEJSiekN8=;
	b=io3x9+VZD/epuYl0C+nDPAk0QY3XTK2y2ZTEvK3z8sD85/UmSGGDhsEw1ZvmF/67J/R+Zs
	sLT3fQS0nX7a8umpjrv6sklB/THMluQePfRpWOEU94rWo/4hyWPYubYpK0p8PXX0sqz1+E
	+Lz/KDwGdoVheTLTVLzV5tOeOxZG+t8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-G3QFgCl0M-aX1CM22oXeKQ-1; Sat, 26 Oct 2024 06:07:08 -0400
X-MC-Unique: G3QFgCl0M-aX1CM22oXeKQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0710ca24so175125666b.3
        for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 03:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937227; x=1730542027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMNuE59JmqK6i5X+rh8qjVYOKDitaozUbQbEJSiekN8=;
        b=J3vSUK8ZFdP8UllRi24leoBDoDnp2d5Qr2ND59R/oO6zvpY2ze+JHYF7qMXfCbnEUY
         77Q0sqiFmnrk/+hiSU8Or/eNo+7Pjr2HKqy1kIgjZiyDvYt/4pE9Hbe/H8c1gLUwLgA/
         AMIcxPJ96hxSguWiqygpk9OtS8Nl804U8o2Y/M5/LatZgJXmUNHxjcfsgQxkzQVsl8zF
         G0HA1uDOq/xhIOvriTrF3HcV8Th+HYQaaFX6NBb50taCAD1OKS19rFoZZsQo53Xwcl+v
         i6Jl5y4vFfMQcYNA1r//+rm7FAFWKQb00GXRpAJ51yHtmCAz2D+LeE4g77Eyg3Hx7fmt
         1ung==
X-Forwarded-Encrypted: i=1; AJvYcCUMDNxKRV9SF0B+VnpMNVpitJg/qwG0DWHG6yfaaEH9lmXHOdv1eU+OAnXr/do8GDkv+MxG4BERKsbk@vger.kernel.org
X-Gm-Message-State: AOJu0YyPU7DdMbkjBKJaezdY7ERpq6OSTj+hs7D4KVv7Oj6fEq7sZ1Az
	TOmUVJTUWBpnmFjx4KwUVzMSPj21CavEA4jhZulcXVimG15gsDI9FFfRmdY/sGMfmfEkZG29OpZ
	yBZWJCVdVU+hKPuthQlvc38N0qyrrbia15o4O4pzRtiksTD9i9DvnbqVwR0k=
X-Received: by 2002:a17:907:94c7:b0:a9a:4f78:c3 with SMTP id a640c23a62f3a-a9de5ce2538mr173309566b.21.1729937227487;
        Sat, 26 Oct 2024 03:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYxEdi2Gh+VM9LosfHrDuUA5oGbguIFd+1UdystNEmcdRJcScApcCIvWidRJOLAVdVEJ2X2g==
X-Received: by 2002:a17:907:94c7:b0:a9a:4f78:c3 with SMTP id a640c23a62f3a-a9de5ce2538mr173307266b.21.1729937226845;
        Sat, 26 Oct 2024 03:07:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e0b2400sm159362666b.45.2024.10.26.03.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:07:06 -0700 (PDT)
Message-ID: <9ee054fa-44c4-4808-ba1f-dd22b265e6f1@redhat.com>
Date: Sat, 26 Oct 2024 12:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] ACPI: platform_profile: Add platform handler argument
 to platform_profile_remove()
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
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
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-4-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241025193055.2235-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Oct-24 9:30 PM, Mario Limonciello wrote:
> To allow registering and unregistering multiple platform handlers calls
> to platform_profile_remove() will need to know which handler is to be
> removed.  Add an argument for this.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/platform_profile.c                     | 2 +-
>  drivers/platform/surface/surface_platform_profile.c | 2 +-
>  drivers/platform/x86/acer-wmi.c                     | 4 ++--
>  drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
>  drivers/platform/x86/asus-wmi.c                     | 4 ++--
>  drivers/platform/x86/dell/dell-pc.c                 | 2 +-
>  drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
>  drivers/platform/x86/ideapad-laptop.c               | 2 +-
>  drivers/platform/x86/inspur_platform_profile.c      | 4 +++-
>  drivers/platform/x86/thinkpad_acpi.c                | 2 +-
>  include/linux/platform_profile.h                    | 2 +-
>  11 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d2f7fd7743a13..c24744da20916 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -205,7 +205,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
>  
> -int platform_profile_remove(void)
> +int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
>  	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 958afd7bce223..0879b739c5e8b 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -228,7 +228,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>  
>  static void surface_platform_profile_remove(struct ssam_device *sdev)
>  {
> -	platform_profile_remove();
> +	platform_profile_remove(&sdev->tpd->handler);
>  }
>  
>  static const struct ssam_device_id ssam_platform_profile_match[] = {
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 53fbc9b4d3df7..71761d4220c26 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2546,7 +2546,7 @@ static int acer_platform_probe(struct platform_device *device)
>  
>  error_hwmon:
>  	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>  error_platform_profile:
>  	acer_rfkill_exit();
>  error_rfkill:
> @@ -2569,7 +2569,7 @@ static void acer_platform_remove(struct platform_device *device)
>  	acer_rfkill_exit();
>  
>  	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index e2d0cc92c4396..cfa88c0c9e594 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -425,5 +425,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>  
>  void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
>  {
> -	platform_profile_remove();
> +	platform_profile_remove(&dev->pprof);
>  }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index c7c104c65a85a..f5f8cda7fd19c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -4885,7 +4885,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_custom_fan_curve:
>  fail_platform_profile_setup:
>  	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
>  fail_fan_boost_mode:
>  fail_platform:
>  	kfree(asus);
> @@ -4912,7 +4912,7 @@ static void asus_wmi_remove(struct platform_device *device)
>  	asus_wmi_battery_exit(asus);
>  
>  	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
>  
>  	kfree(asus);
>  }
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 3cf79e55e3129..4196154cc37d9 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -273,7 +273,7 @@ static int thermal_init(void)
>  static void thermal_cleanup(void)
>  {
>  	if (thermal_handler) {
> -		platform_profile_remove();
> +		platform_profile_remove(thermal_handler);
>  		kfree(thermal_handler);
>  	}
>  }
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 26cac73caf2b9..bb8771d8b5cd8 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1692,7 +1692,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
>  	}
>  
>  	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>  }
>  
>  static int hp_wmi_resume_handler(struct device *device)
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 1f94c14c3b832..50819ac919e87 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1135,7 +1135,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
>  	if (!priv->dytc)
>  		return;
>  
> -	platform_profile_remove();
> +	platform_profile_remove(&priv->dytc->pprof);
>  	mutex_destroy(&priv->dytc->mutex);
>  	kfree(priv->dytc);
>  
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 03da2c8cf6789..f6bc5ca9da91d 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -190,7 +190,9 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>  
>  static void inspur_wmi_remove(struct wmi_device *wdev)
>  {
> -	platform_profile_remove();
> +	struct inspur_wmi_priv *priv;
> +	priv = dev_get_drvdata(&wdev->dev);
> +	platform_profile_remove(&priv->handler);
>  }
>  
>  static const struct wmi_device_id inspur_wmi_id_table[] = {
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index c8c316b8507a5..619a4db74e5f3 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10637,7 +10637,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>  
>  static void dytc_profile_exit(void)
>  {
> -	platform_profile_remove();
> +	platform_profile_remove(&dytc_profile);
>  }
>  
>  static struct ibm_struct  dytc_profile_driver_data = {
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6fa988e417428..58279b76d740e 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -36,7 +36,7 @@ struct platform_profile_handler {
>  };
>  
>  int platform_profile_register(struct platform_profile_handler *pprof);
> -int platform_profile_remove(void);
> +int platform_profile_remove(struct platform_profile_handler *pprof);
>  int platform_profile_cycle(void);
>  void platform_profile_notify(void);
>  


