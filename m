Return-Path: <linux-acpi+bounces-9055-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67A9B37AE
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDEBB23D45
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6631DF276;
	Mon, 28 Oct 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9iva7Xd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2D1DE8BC;
	Mon, 28 Oct 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136712; cv=none; b=GHRWW6T3WvmQUeuoX4g+sZTlWGcnhVWNWJRYOs/li2u3NGoJ8miHNYuKYN3RMRX1//mXl4MU5nMmp9Nc8+S163DV4nYQYJVFBzVaFmy7A99DhCaCubLhRCAw6e/lf8lB2dFhutc3qh8Fmo8ND57Zn2vjB164H30EPBXRJ+tB8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136712; c=relaxed/simple;
	bh=A6EgKmu/5pPYpqBsB+qry9zFLzRLAKjAcj21dW1vo0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsZlrafxrYnS4AozeFvk8feXr0qdiVvrJmdZ7ORurKb0sjWb9OhrtokFIriusWXwz8mAcICe55mBIGcOkx/GETxO793gy1B3/2Iq5gaTQZmhgqJe2kxBXCyDNOUlfAUVK/vRUcRSXEdZODuLFYh9fswEU37hPXiW4K2PHzKzg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9iva7Xd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315baec69eso46505335e9.2;
        Mon, 28 Oct 2024 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730136708; x=1730741508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKyEdAhye6hzvO346v2kKw8A4cLUIEN8DkIhBXVC/Wk=;
        b=G9iva7XddI1BHOhXXL7Q3YCZnQxOJwOu+ZYuQ32xhF3kzI/KtWwfggwV6JoWxx7K1X
         VExlWzYJINqolpzU8SPtVx9GuH7KqErSxYcLSPVtA9H0EAbp4mJRswz+7K5YnpMukIMA
         FEYKJFNtAdnYzUcy+tCDnzt12xMk+j+CnX+v7KzUKCFBfHbn2lEr4LBI7zgj2NiLoLdT
         8Du/1DKUl3D05GPNIKVX0WVU/SrxEKVL4Aym+vp/jJ8K2QRsCjvVmJ7Gp3DMtibVuj9+
         2dWToLNBGxPjGgsQ0vFs+u7ygSTsNX56MMvZGQr3PhwbwhpRpa033fVk9zRnr/IAzV3O
         l7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136708; x=1730741508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKyEdAhye6hzvO346v2kKw8A4cLUIEN8DkIhBXVC/Wk=;
        b=UJsPu7WkU6DIBbEmuBr2qWupVwauI+o0ZH7ilazEDdgoI2K8ZTOhpoJu+pfDKBnUkK
         ssK/bZX4iClxokwPSR5aIJzdLFTnJyCl2VXVZKJMIVg7y4NC89YibZKYHEJz7v2Op4Mn
         t9WBDjzryiBP4yMpTTEuiDUSzHLjXwkdy7NnTzy9geFC0HFSf8QboEyJGY/1bqj5l68L
         4OJDvYbUQtA+WTPeRElX7NZLiPN32PSqMSA+PgLlN0iC0GwgIJR9Gy9zxlmQdhq2VQEr
         8x3+sGp1A2DIUJjJpBUnWaKRl575i3E4+3IkwqlP5e72j6D368y90wxkT7jCPyV3Bit3
         RQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUyJXU/fa0RgsIzlGNSp48ZV+ew9yaCKct80oqO85If7SrLFADlm5nxwukMQWOjvyNSY5hpXzQWMlc@vger.kernel.org, AJvYcCVMqpMqKQbAoOF6yr9SrZaOk75+QAOhKKNCZmk+vk+rrOptoIz36RqZX0m2CQFfgP5R1+PV9yYLUXewN71M@vger.kernel.org, AJvYcCWawk1q9SRPymfFgSI29NsIGor4wZECtN0jUKEoAj3cicuENh+rQkvHra4k1gOEDTgeUxaywOf61WKdVeBWFjRlTI9aCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyORwYeXHF3aK8qiYfKw2oIjZj0e+cLOh3ue36JmqD7JWMGoR
	lHRq3SKlwsMRVVEi6782ZJ/ZYtAFwgcD9O+0AddjWgq7cKL7Abfz
X-Google-Smtp-Source: AGHT+IHCwI6Z8gzv/Lq7X0+NT/GzVU12aVJB+72QINu6jhNUvtpmD2T4QCKKe2f61dzzjukQOThGMg==
X-Received: by 2002:adf:f18c:0:b0:37d:4a2d:6948 with SMTP id ffacd0b85a97d-38061163a43mr6623124f8f.33.1730136707889;
        Mon, 28 Oct 2024 10:31:47 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b49d20sm10011912f8f.62.2024.10.28.10.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:31:47 -0700 (PDT)
Message-ID: <78cd20c2-de9d-4440-b487-77a1ac505f17@gmail.com>
Date: Mon, 28 Oct 2024 18:31:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] ACPI: platform_profile: Add platform handler
 argument to platform_profile_remove()
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
 <20241028020131.8031-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20241028020131.8031-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 3:01 AM, Mario Limonciello wrote:
> To allow registering and unregistering multiple platform handlers calls
> to platform_profile_remove() will need to know which handler is to be
> removed.  Add an argument for this.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Use ssam_device_get_drvdata() for surface
> ---
>   drivers/acpi/platform_profile.c                     | 2 +-
>   drivers/platform/surface/surface_platform_profile.c | 5 ++++-
>   drivers/platform/x86/acer-wmi.c                     | 4 ++--
>   drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
>   drivers/platform/x86/asus-wmi.c                     | 4 ++--
>   drivers/platform/x86/dell/dell-pc.c                 | 2 +-
>   drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
>   drivers/platform/x86/ideapad-laptop.c               | 2 +-
>   drivers/platform/x86/inspur_platform_profile.c      | 5 ++++-
>   drivers/platform/x86/thinkpad_acpi.c                | 2 +-
>   include/linux/platform_profile.h                    | 2 +-
>   11 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d2f7fd7743a13..c24744da20916 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -205,7 +205,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>   
> -int platform_profile_remove(void)
> +int platform_profile_remove(struct platform_profile_handler *pprof)
>   {
>   	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>   
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index a18eb93eebb92..1c9e37b1f4761 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -228,7 +228,10 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   static void surface_platform_profile_remove(struct ssam_device *sdev)
>   {
> -	platform_profile_remove();
> +	struct ssam_platform_profile_device *tpd;
> +
> +	tpd = ssam_device_get_drvdata(sdev);
> +	platform_profile_remove(&tpd->handler);
>   }
>   
>   static const struct ssam_device_id ssam_platform_profile_match[] = {
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 53fbc9b4d3df7..71761d4220c26 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2546,7 +2546,7 @@ static int acer_platform_probe(struct platform_device *device)
>   
>   error_hwmon:
>   	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>   error_platform_profile:
>   	acer_rfkill_exit();
>   error_rfkill:
> @@ -2569,7 +2569,7 @@ static void acer_platform_remove(struct platform_device *device)
>   	acer_rfkill_exit();
>   
>   	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index e2d0cc92c4396..cfa88c0c9e594 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -425,5 +425,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   
>   void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
>   {
> -	platform_profile_remove();
> +	platform_profile_remove(&dev->pprof);
>   }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index c7c104c65a85a..f5f8cda7fd19c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -4885,7 +4885,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>   fail_custom_fan_curve:
>   fail_platform_profile_setup:
>   	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
>   fail_fan_boost_mode:
>   fail_platform:
>   	kfree(asus);
> @@ -4912,7 +4912,7 @@ static void asus_wmi_remove(struct platform_device *device)
>   	asus_wmi_battery_exit(asus);
>   
>   	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
>   
>   	kfree(asus);
>   }
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 3cf79e55e3129..4196154cc37d9 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -273,7 +273,7 @@ static int thermal_init(void)
>   static void thermal_cleanup(void)
>   {
>   	if (thermal_handler) {
> -		platform_profile_remove();
> +		platform_profile_remove(thermal_handler);
>   		kfree(thermal_handler);
>   	}
>   }
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 26cac73caf2b9..bb8771d8b5cd8 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1692,7 +1692,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
>   	}
>   
>   	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>   }
>   
>   static int hp_wmi_resume_handler(struct device *device)
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 1f94c14c3b832..50819ac919e87 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1135,7 +1135,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
>   	if (!priv->dytc)
>   		return;
>   
> -	platform_profile_remove();
> +	platform_profile_remove(&priv->dytc->pprof);
>   	mutex_destroy(&priv->dytc->mutex);
>   	kfree(priv->dytc);
>   
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 03da2c8cf6789..d8fd59b826f3a 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -190,7 +190,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   
>   static void inspur_wmi_remove(struct wmi_device *wdev)
>   {
> -	platform_profile_remove();
> +	struct inspur_wmi_priv *priv;
> +
> +	priv = dev_get_drvdata(&wdev->dev);
> +	platform_profile_remove(&priv->handler);
>   }
>   
>   static const struct wmi_device_id inspur_wmi_id_table[] = {
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index c8c316b8507a5..619a4db74e5f3 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10637,7 +10637,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   
>   static void dytc_profile_exit(void)
>   {
> -	platform_profile_remove();
> +	platform_profile_remove(&dytc_profile);
>   }
>   
>   static struct ibm_struct  dytc_profile_driver_data = {
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6fa988e417428..58279b76d740e 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -36,7 +36,7 @@ struct platform_profile_handler {
>   };
>   
>   int platform_profile_register(struct platform_profile_handler *pprof);
> -int platform_profile_remove(void);
> +int platform_profile_remove(struct platform_profile_handler *pprof);
>   int platform_profile_cycle(void);
>   void platform_profile_notify(void);
>   

Looks good to me, thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

