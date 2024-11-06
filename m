Return-Path: <linux-acpi+bounces-9339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A089BDDA3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972FC1C22F8B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6B190068;
	Wed,  6 Nov 2024 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VlcI5yI+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DF2AF07;
	Wed,  6 Nov 2024 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864111; cv=none; b=W03CIkyYlFryph3ScFbna+xxsloq4mw0AyRv3KXo+EkzB7kgH86/2veZ64jICcQNTFnqRt3OjgrJMhoFBaEHrKO+BNM5X8RiRKW2JmVhpNtaR7x3V591SVdUw/9YEZJHrIAKezL4F60ITFrXVJi3MAiGxGroHpGJwajqLGg4Nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864111; c=relaxed/simple;
	bh=HFq/kz8GiYuldPtRwrx+LMGCTPB2imsZ6sfhTlN7s9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqPcNXgUC74RAEWD5e7xA8vjAiRT3nZMFabcd4SAy63vy84+Jg2dMvZS1Ecx1gl22gVk/SyBh79oJXk66Yy82cOR6TVh1U/91kdkB3Bbzn5I4gxBMZfaTTNmcpnZGkKG03GYpLdEg0Iy0odCwM+JpDtYmm1O4T6+eKnAFNBAar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VlcI5yI+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730864045; x=1731468845; i=w_armin@gmx.de;
	bh=Zx1iO9v9dEnqKw0MzX55P4XciG9j6Q/wx3a3of3V200=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VlcI5yI+LpwoUop7HCgDzgI9wZpDOHdS7dMjsyxSxZwo2xrvHtA3Z06p74GK8XXx
	 VWfLmLBkYqqlrTMuPiriHBZOiBqll4LEifpOAdDCqiR185DlDT+tKo+sEpLGQvS0L
	 rWpYg5/6BqStNikQoVDh0C3bshAMPvrq7AVGdbZg7NIie68DcOQkJuuaQc7ZHOOn0
	 uoq59eQ4/37dIj1LxPId9lPXjey2jEQERRbXJGy98jokAPBsRMELpg6sVNFmWwb2G
	 cX4/MwLLt3c7R2wjtiiDwD4tljx/4JaJ0qvCmYsH1n2BUZ/h+NO/leDY60Dzl4Ry5
	 GBN1r4qnRJgtHcRP5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1tvFlq3qkQ-00sti5; Wed, 06
 Nov 2024 04:34:05 +0100
Message-ID: <30cc845c-4080-4128-964d-95e857beb9e7@gmx.de>
Date: Wed, 6 Nov 2024 04:34:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/20] ACPI: platform_profile: Add platform handler
 argument to platform_profile_remove()
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-5-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vgO1KWOyzv7w4IN42uTl9R2DD2F17ZJn0hYy1cVCEaGlFiDpZld
 g4SzTOM1AG/ey1G4lObnVvoJM+gUvR6DQE8yy4KJ5w5DWwAYLnqVk3gh5UvLF/MbsPjPAQw
 pF1KBEuTv706Zk21UJtIToUjRFEHql/9Nc4PHGa1vfZ7Uzg7KAZIlg3aT0O55JigW5CAnoc
 /JHRNtALJXFY+knIMb3HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fPBYL06awgA=;Wj2U+v+HcvsZawolDNOXwsj3Fvg
 c2xd/LDOBaUj+7dLG/FqNfz2jlIIVOwJLiaW41ouLQm5/k5IBVCl0iUt1hP/wDrfJJiR3Yc3j
 f0TwGLL+hsGXc5ZWsH18vB1x5K/HxcE2PLvhV6KgqaYeqLbLFNuL7Wav7HAWTxooBdt0f4502
 NxB2qsmZjdjCsLWhhf5olIGgrSCFR1Mnv6T4wqeGoMOUsncGfHTGYzONLk/9jrxNpmrQcQF4o
 eI0xtnv7kYsXnO7MGjPtJ6/nZwE/t+Y9tXUAaSsWD8lWqJuD4Zn5cNSJu1gD8bDj4aYeyJRv9
 jHQGSrF8kxGZlKaIrfW5kSZziN5Mn04HwTtPNM0xCKNedhd3nRWQxY9ZsbDMv3V+NAF8RhpoM
 FC0iIiGmbqrp3bHrR/bkrQwmzoNI5rZNwro2EZ3VH8FQMaY5gDDCoI2IJioIIgRwRwXZAAH5k
 RRN7/ouFu28ZZDMm5n1pglKbSVBoAaw9qCPH+USIRxby63iedgfDM2ib4xaAUisM6DkfUWy15
 ETXTEsR4RvLsoTFtKYD/luA9aLd9iIGpupr/hYK4VGS6dwN6uLl++3j3lVDBfLkbniZaDd0hQ
 Mmf6sRKu2HOa+ABGPE1stzKkE4SFMkAhOEr64lzygMkDa88+6XQUe+JZHK73VpAr+sUKwz70o
 cSpU1L127i4fx+WqcjfIXOApWnhW0k3csuawd9fSUg5MqVTcrpUI1NEWws55+GScbhOFgz3HD
 XmoXtmbLjB5+zDz6Qzac/47pdKZMusjhvPM1lAwMT7RpyTMK6MvZ4BsEixW1ULCUGiVr+h+bt
 lxj0kCCJxHnCNjOwhFC5gll8N32d8ldBlURJv5UWFwkY8=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> To allow registering and unregistering multiple platform handlers calls
> to platform_profile_remove() will need to know which handler is to be
> removed.  Add an argument for this.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>   * Add alienware-wmi too
> ---
>   drivers/acpi/platform_profile.c                     | 2 +-
>   drivers/platform/surface/surface_platform_profile.c | 6 +++++-
>   drivers/platform/x86/acer-wmi.c                     | 4 ++--
>   drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
>   drivers/platform/x86/asus-wmi.c                     | 4 ++--
>   drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
>   drivers/platform/x86/dell/dell-pc.c                 | 2 +-
>   drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
>   drivers/platform/x86/ideapad-laptop.c               | 2 +-
>   drivers/platform/x86/inspur_platform_profile.c      | 5 ++++-
>   drivers/platform/x86/thinkpad_acpi.c                | 2 +-
>   include/linux/platform_profile.h                    | 2 +-
>   12 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 5d9f3f7ba71c5..c76b8e3fdcde6 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -210,7 +210,7 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>
> -int platform_profile_remove(void)
> +int platform_profile_remove(struct platform_profile_handler *pprof)
>   {
>   	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drive=
rs/platform/surface/surface_platform_profile.c
> index 5f45f8e8cd69b..b449c4c8b883c 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssa=
m_device *sdev)
>   		return -ENOMEM;
>
>   	tpd->sdev =3D sdev;
> +	ssam_device_set_drvdata(sdev, tpd);
>
>   	tpd->handler.name =3D "Surface Platform Profile";
>   	tpd->handler.dev =3D &sdev->dev;
> @@ -228,7 +229,10 @@ static int surface_platform_profile_probe(struct ss=
am_device *sdev)
>
>   static void surface_platform_profile_remove(struct ssam_device *sdev)
>   {
> -	platform_profile_remove();
> +	struct ssam_platform_profile_device *tpd;
> +
> +	tpd =3D ssam_device_get_drvdata(sdev);
> +	platform_profile_remove(&tpd->handler);
>   }
>
>   static const struct ssam_device_id ssam_platform_profile_match[] =3D {
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer=
-wmi.c
> index aca4a5746bee1..b12965d9fcdb7 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2547,7 +2547,7 @@ static int acer_platform_probe(struct platform_dev=
ice *device)
>
>   error_hwmon:
>   	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>   error_platform_profile:
>   	acer_rfkill_exit();
>   error_rfkill:
> @@ -2570,7 +2570,7 @@ static void acer_platform_remove(struct platform_d=
evice *device)
>   	acer_rfkill_exit();
>
>   	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>   }
>
>   #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/a=
md/pmf/sps.c
> index 1b94af7c0e0c4..bd2bd6cfc39a0 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -426,5 +426,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>
>   void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
>   {
> -	platform_profile_remove();
> +	platform_profile_remove(&dev->pprof);
>   }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus=
-wmi.c
> index 78621b2af0ddb..0750e2fe65325 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -4886,7 +4886,7 @@ static int asus_wmi_add(struct platform_device *pd=
ev)
>   fail_custom_fan_curve:
>   fail_platform_profile_setup:
>   	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
>   fail_fan_boost_mode:
>   fail_platform:
>   	kfree(asus);
> @@ -4913,7 +4913,7 @@ static void asus_wmi_remove(struct platform_device=
 *device)
>   	asus_wmi_battery_exit(asus);
>
>   	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
>
>   	kfree(asus);
>   }
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index c03b1aa7dfb5f..3cf6c371d4220 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1065,7 +1065,7 @@ static int create_thermal_profile(struct platform_=
device *platform_device)
>   static void remove_thermal_profile(void)
>   {
>   	if (quirks->thermal)
> -		platform_profile_remove();
> +		platform_profile_remove(&pp_handler);
>   }
>
>   static int __init alienware_wmi_init(void)
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/=
dell/dell-pc.c
> index 730f97aab70cd..65989af2e4196 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -292,7 +292,7 @@ static int thermal_init(void)
>   static void thermal_cleanup(void)
>   {
>   	if (thermal_handler)
> -		platform_profile_remove();
> +		platform_profile_remove(thermal_handler);
>   	platform_device_unregister(platform_device);
>   }
>
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/=
hp-wmi.c
> index ffb09799142bc..6d6e13a0c6e2d 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1693,7 +1693,7 @@ static void __exit hp_wmi_bios_remove(struct platf=
orm_device *device)
>   	}
>
>   	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>   }
>
>   static int hp_wmi_resume_handler(struct device *device)
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x8=
6/ideapad-laptop.c
> index 24367c3590c99..80797c6ae8b0b 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1136,7 +1136,7 @@ static void ideapad_dytc_profile_exit(struct ideap=
ad_private *priv)
>   	if (!priv->dytc)
>   		return;
>
> -	platform_profile_remove();
> +	platform_profile_remove(&priv->dytc->pprof);
>   	mutex_destroy(&priv->dytc->mutex);
>   	kfree(priv->dytc);
>
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/pl=
atform/x86/inspur_platform_profile.c
> index 5a53949bbbf5f..53af73a7fbf7b 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -191,7 +191,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev=
, const void *context)
>
>   static void inspur_wmi_remove(struct wmi_device *wdev)
>   {
> -	platform_profile_remove();
> +	struct inspur_wmi_priv *priv;
> +
> +	priv =3D dev_get_drvdata(&wdev->dev);
> +	platform_profile_remove(&priv->handler);
>   }
>
>   static const struct wmi_device_id inspur_wmi_id_table[] =3D {
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86=
/thinkpad_acpi.c
> index 222fba97d79a7..13798c6d5fcf3 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10638,7 +10638,7 @@ static int tpacpi_dytc_profile_init(struct ibm_i=
nit_struct *iibm)
>
>   static void dytc_profile_exit(void)
>   {
> -	platform_profile_remove();
> +	platform_profile_remove(&dytc_profile);
>   }
>
>   static struct ibm_struct  dytc_profile_driver_data =3D {
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index daec6b9bad81f..bcaf3aa39160f 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -37,7 +37,7 @@ struct platform_profile_handler {
>   };
>
>   int platform_profile_register(struct platform_profile_handler *pprof);
> -int platform_profile_remove(void);
> +int platform_profile_remove(struct platform_profile_handler *pprof);
>   int platform_profile_cycle(void);
>   void platform_profile_notify(void);
>

