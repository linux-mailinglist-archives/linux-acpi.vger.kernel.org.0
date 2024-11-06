Return-Path: <linux-acpi+bounces-9338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6B9BDD9F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1881284D9D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150318FDD2;
	Wed,  6 Nov 2024 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PFc11oQe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF92AF07;
	Wed,  6 Nov 2024 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864024; cv=none; b=HB0y4/SFa3qGussFnv5eMSbeAOHODVzil3cd5dpiiFGiUplm2GdnRbpTYaToVPjv8PIqT1aoxaadUI5pZY4KYShb6VgrkEUTDIV1smc0N6ksj5szYBo90SqgBmbqZKHNNVVQzG4D4khPdPuJIIkHc9JcjnVM61ztgju+5G/e2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864024; c=relaxed/simple;
	bh=Y7TxJJawyqqH/g2nFKC7ISmrzbASZNV9Adp4g/a1+b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gP1OYnjQErWyuc/uFn7METk/QswG9kXdtLppZTqM2bsfHKhbHOF4EH7GS00mIxzlUly8tmr//eZAaoMDskCYgtauIsBKJuIsSp9OpES8oXKkAksyLupSD1TG6umdZ8VOR66RprhPF3wpIvpuFR80B2KYMsbODmySHYs4D+zFmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PFc11oQe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730863945; x=1731468745; i=w_armin@gmx.de;
	bh=ukMCI0MlTTHp4oLR9E5hiEq/4R6CY6lx9Y/dQMzsktc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PFc11oQedtuDyM0SfPVA+wTzM3OZFk5en5HcvBQQcJOEdGPPvpz7HvPYwRUumLPp
	 MjtFDJGpGIRd+C0wXzY6ljqNSDepqyhYZJU4MAXDXbHfvC86j7qrzDL2z1zf4ZPeK
	 C1UQTpl6+Y/6yD+N+uTVLF/Wu9QUuZtWlW6TtzCm0/9y73atM4x9v8L8vfl6bnazY
	 U49bjvATtwCvA77MFUS3HAhXtbwiHurGgxPLKt1LuO1+1tS2RXkp2AZhTmMEbOal3
	 Mb8sHCUJ4Yltd1fKOlZHstSs3VqB+HoPP16WQlq2RCqkmgT8dA0lzY1kA2nxEDGkC
	 pshj5w87Kkid2Jlmnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1tzwcA2fTj-010xGK; Wed, 06
 Nov 2024 04:32:25 +0100
Message-ID: <bf149e17-5199-4242-8986-0660b972848d@gmx.de>
Date: Wed, 6 Nov 2024 04:32:23 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/20] ACPI: platform_profile: Add device pointer into
 platform profile handler
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
 <20241105153316.378-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a8pWviK8k9T5dWAz8wcLTQTiLyqPqn8PUO46JG2FzaFfjf3pQwi
 Vq38OiJ8iROjdWjXJ/fksWpTDPAkjW8LPwXTpHGqsG/Zroogc5AkwbA+DxsliBVKyYN2K7+
 yxGiivhOqFXwj6CiKZImINBp0Ydpfs7MCsYtVUWBhTdHn0xq+v7zusM9SILqzEvOL2iQJoO
 pOI6oQiGJU4NcJJpuSNHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fuPgS1ZI8dQ=;K6Jz3kvdemDar8aMcRh55Kmet3u
 SOxd+O2oHtM9LTn1sjbVHLOtzvKrq0mVH9SbW3ELZwlqs68fp6ADl1SrCh9JIseIxyK9Hb/wf
 HR07oPoAcQ2H9JgjjCb8EXaaWVJQCfrnbRgeWb16ICmHqo1pI8gF1bHzvj99XSohe87Ixb9m0
 g3X4hxt0mRj+tXoQ2NqRK43G1VQU27T1XJs8wAkFyaE5MmrdrxbRnv7vJBZRvEdbEKxTeNaRX
 LmabdBjcCCRgtUpTZ6gttHhBUngpwH4IV4Wja1dEdiNbqiVlfRIC/mSDwUZ45FCxHOXJt4qx8
 5xhRnhNxzDUHXr47TRTxbJgiZsbEfVjhfE5WJyThh/9m6WR1sckmnsAus32aQTz7zRcfbfHQU
 w7vZQhCq7zYaL54iC60m/42jfovSVX9kanEUcr+9ofnKWkmcTf+mGLOBRChIcXgu5hHT3vn0n
 C42mymsgL5xHCMzrsxL3stsvjbREAYO3jRlKYxBAyw5EET/0G/Z9/9w1XsEsqDFkgnWkMSsfk
 L24gPnCoVw1qSUsQ4ZFhPiRIqNC9z6kdQ2XscImQFJZCWyE5+9n0f2LgXM8g2xKqEyX0CuwKw
 JozNI/LVkKqesCXmZnDbtRzN/hNaYFvwEFDievR/gIzmEySBeYTX+c+TICV1eTGPoRvd0YH6Z
 7c2a7TuXlvfgWWQgv5jMYJd6tVjz5sX4sS5uR7yyesXRBlZx3c0kzmWTyjkmlMUdjvbTDruOg
 PwM3mFj/5rLoguvE1aBWvinPknL/oL20V/CFuSyPnCj72fqohLgkl8tquxBm4meBO7c1ivXqe
 jSsvXvJVzRNd7cwiaSU4XJL6hxg6hU/7zHIcXe6+Ini5I=

Am 05.11.24 um 16:32 schrieb Mario Limonciello:

> In order to let platform profile handlers manage platform profile
> for their driver the core code will need a pointer to the device.
>
> Add this to the structure and use it in the trivial driver cases.
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>   * add alienware-wmi too
> ---
>   drivers/acpi/platform_profile.c                     | 5 +++++
>   drivers/platform/surface/surface_platform_profile.c | 1 +
>   drivers/platform/x86/acer-wmi.c                     | 5 +++--
>   drivers/platform/x86/amd/pmf/sps.c                  | 1 +
>   drivers/platform/x86/asus-wmi.c                     | 1 +
>   drivers/platform/x86/dell/alienware-wmi.c           | 5 +++--
>   drivers/platform/x86/dell/dell-pc.c                 | 1 +
>   drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
>   drivers/platform/x86/ideapad-laptop.c               | 1 +
>   drivers/platform/x86/inspur_platform_profile.c      | 1 +
>   drivers/platform/x86/thinkpad_acpi.c                | 1 +
>   include/linux/platform_profile.h                    | 1 +
>   12 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index d2f7fd7743a13..5d9f3f7ba71c5 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -179,6 +179,11 @@ int platform_profile_register(struct platform_profi=
le_handler *pprof)
>   {
>   	int err;
>
> +	if (!pprof->dev) {
> +		pr_err("platform_profile: handler device is not set\n");
> +		return -EINVAL;
> +	}

Is there a reason why we require "dev" to be set? AFAIK having no parent d=
evice should be ok.

Thanks,
Armin Wolf

> +
>   	mutex_lock(&profile_lock);
>   	/* We can only have one active profile */
>   	if (cur_profile) {
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drive=
rs/platform/surface/surface_platform_profile.c
> index 61aa488a80eb5..5f45f8e8cd69b 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -212,6 +212,7 @@ static int surface_platform_profile_probe(struct ssa=
m_device *sdev)
>   	tpd->sdev =3D sdev;
>
>   	tpd->handler.name =3D "Surface Platform Profile";
> +	tpd->handler.dev =3D &sdev->dev;
>   	tpd->handler.profile_get =3D ssam_platform_profile_get;
>   	tpd->handler.profile_set =3D ssam_platform_profile_set;
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer=
-wmi.c
> index 53fbc9b4d3df7..aca4a5746bee1 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1873,12 +1873,13 @@ acer_predator_v4_platform_profile_set(struct pla=
tform_profile_handler *pprof,
>   	return 0;
>   }
>
> -static int acer_platform_profile_setup(void)
> +static int acer_platform_profile_setup(struct platform_device *device)
>   {
>   	if (quirks->predator_v4) {
>   		int err;
>
>   		platform_profile_handler.name =3D "acer-wmi";
> +		platform_profile_handler.dev =3D &device->dev;
>   		platform_profile_handler.profile_get =3D
>   			acer_predator_v4_platform_profile_get;
>   		platform_profile_handler.profile_set =3D
> @@ -2531,7 +2532,7 @@ static int acer_platform_probe(struct platform_dev=
ice *device)
>   		goto error_rfkill;
>
>   	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
> -		err =3D acer_platform_profile_setup();
> +		err =3D acer_platform_profile_setup(device);
>   		if (err)
>   			goto error_platform_profile;
>   	}
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/a=
md/pmf/sps.c
> index e2d0cc92c4396..1b94af7c0e0c4 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -406,6 +406,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	}
>
>   	dev->pprof.name =3D "amd-pmf";
> +	dev->pprof.dev =3D dev->dev;
>   	dev->pprof.profile_get =3D amd_pmf_profile_get;
>   	dev->pprof.profile_set =3D amd_pmf_profile_set;
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus=
-wmi.c
> index c7c104c65a85a..78621b2af0ddb 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3911,6 +3911,7 @@ static int platform_profile_setup(struct asus_wmi =
*asus)
>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile sup=
port\n");
>
>   	asus->platform_profile_handler.name =3D "asus-wmi";
> +	asus->platform_profile_handler.dev =3D dev;
>   	asus->platform_profile_handler.profile_get =3D asus_wmi_platform_prof=
ile_get;
>   	asus->platform_profile_handler.profile_set =3D asus_wmi_platform_prof=
ile_set;
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index ac0038afd98fa..c03b1aa7dfb5f 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1017,7 +1017,7 @@ static int thermal_profile_set(struct platform_pro=
file_handler *pprof,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>
> -static int create_thermal_profile(void)
> +static int create_thermal_profile(struct platform_device *platform_devi=
ce)
>   {
>   	u32 out_data;
>   	enum wmax_thermal_mode mode;
> @@ -1057,6 +1057,7 @@ static int create_thermal_profile(void)
>   	pp_handler.profile_get =3D thermal_profile_get;
>   	pp_handler.profile_set =3D thermal_profile_set;
>   	pp_handler.name =3D "alienware-wmi";
> +	pp_handler.dev =3D &platform_device->dev;
>
>   	return platform_profile_register(&pp_handler);
>   }
> @@ -1125,7 +1126,7 @@ static int __init alienware_wmi_init(void)
>   	}
>
>   	if (quirks->thermal) {
> -		ret =3D create_thermal_profile();
> +		ret =3D create_thermal_profile(platform_device);
>   		if (ret)
>   			goto fail_prep_thermal_profile;
>   	}
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/=
dell/dell-pc.c
> index b145fedb6b710..730f97aab70cd 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -260,6 +260,7 @@ static int thermal_init(void)
>   		goto cleanup_platform_device;
>   	}
>   	thermal_handler->name =3D "dell-pc";
> +	thermal_handler->dev =3D &platform_device->dev;
>   	thermal_handler->profile_get =3D thermal_platform_profile_get;
>   	thermal_handler->profile_set =3D thermal_platform_profile_set;
>
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/=
hp-wmi.c
> index 26cac73caf2b9..ffb09799142bc 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1565,7 +1565,7 @@ static inline void omen_unregister_powersource_eve=
nt_handler(void)
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
>   	platform_profile_handler.name =3D "hp-wmi";
> +	platform_profile_handler.dev =3D &device->dev;
>   	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choice=
s);
>
> @@ -1664,7 +1665,7 @@ static int __init hp_wmi_bios_setup(struct platfor=
m_device *device)
>   	if (err < 0)
>   		return err;
>
> -	thermal_profile_setup();
> +	thermal_profile_setup(device);
>
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x8=
6/ideapad-laptop.c
> index 1f94c14c3b832..24367c3590c99 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1103,6 +1103,7 @@ static int ideapad_dytc_profile_init(struct ideapa=
d_private *priv)
>   	mutex_init(&priv->dytc->mutex);
>
>   	priv->dytc->pprof.name =3D "ideapad-laptop";
> +	priv->dytc->pprof.dev =3D &priv->platform_device->dev;
>   	priv->dytc->priv =3D priv;
>   	priv->dytc->pprof.profile_get =3D dytc_profile_get;
>   	priv->dytc->pprof.profile_set =3D dytc_profile_set;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/pl=
atform/x86/inspur_platform_profile.c
> index 03da2c8cf6789..5a53949bbbf5f 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -178,6 +178,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev,=
 const void *context)
>   	dev_set_drvdata(&wdev->dev, priv);
>
>   	priv->handler.name =3D "inspur-wmi";
> +	priv->handler.dev =3D &wdev->dev;
>   	priv->handler.profile_get =3D inspur_platform_profile_get;
>   	priv->handler.profile_set =3D inspur_platform_profile_set;
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86=
/thinkpad_acpi.c
> index c8c316b8507a5..222fba97d79a7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10616,6 +10616,7 @@ static int tpacpi_dytc_profile_init(struct ibm_i=
nit_struct *iibm)
>   	dbg_printk(TPACPI_DBG_INIT,
>   			"DYTC version %d: thermal mode available\n", dytc_version);
>
> +	dytc_profile.dev =3D &tpacpi_pdev->dev;
>   	/* Create platform_profile structure and register */
>   	err =3D platform_profile_register(&dytc_profile);
>   	/*
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
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

