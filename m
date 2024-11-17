Return-Path: <linux-acpi+bounces-9617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EED69D0555
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C23DB219F2
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCF1DAC9A;
	Sun, 17 Nov 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fzN12BBm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B571DA618;
	Sun, 17 Nov 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869998; cv=none; b=cBi4vHRQNmrvEX9vq1YXt0OVykhbgOJcXOu1ZT9jcmqsFEma5TKeh6gdrUjwkD+gzfr2aMJdhH6PJ33y+TA0VMnkf+QS8PCc9Oe95IHi/TR/eWvR+KSmtrgnVUidiDf2/XFH4eINGAih/GZD4XY+iojr0JUAVj0R8oR041usPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869998; c=relaxed/simple;
	bh=V+BYFHNehulXb0ZANJpD22/ACXBkvf2wAgowPGiqgbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9sPuteewEuNqpS5hUyEjSKXFFb+ao0Qa5wh4OB+A314bUcAxrjczeMTEalK0z79a0dUyW7GI25nW2D+oyaRaZh056x81X1tA+rUPKFjrUP1c7QrsBUiPV42MJctBqrgzwkxdEwrGm5b6XIpMhI2bEwxhgukD+pREUOJcSafDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fzN12BBm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731869907; x=1732474707; i=w_armin@gmx.de;
	bh=zxOSyfXyXYjXQJsdchbbCyaVr+FBI9muXo9KpfxNh+0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fzN12BBmxdvf6zl/vAKWOHO5GJ6iDDo6vbve7Uu42PM+mBBAe5lo5Bvp2+7KlvPj
	 n4W68HUraA7kPD2AXp7aG/jNW9C9TjEtNUu2GhghqHTsgtsTwHft79WKEsOBpE7rm
	 DwCekKX4qZo8ifNpOR60tRX3BVSwxIuDmCz9/QSeHqrkii4O3NJMpFCX189rhLglA
	 XwPIuOEkP/UvwLkQqx+nddKe0Y2OURO8jOD/TL6iFYXPjUqC7i3Zbtg6QoCCEbHkr
	 dE41QeLaQ/W9G5Qxp7opR8W08Tz3vKrd0X3Pv/9VcDWTpkRiM+YZY1DSHb5o/X15v
	 hbmIDv+92Ewl81F0qQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1tU90C2O3v-00KPxB; Sun, 17
 Nov 2024 19:58:27 +0100
Message-ID: <9016eec6-cb67-4ec6-9cb2-4d51f8a0852d@gmx.de>
Date: Sun, 17 Nov 2024 19:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/22] ACPI: platform_profile: Add device pointer into
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CH1oEMEIoUcY3ybwkB/Fmk+OOG+iCc8ANSOZFCYO+jyXEj+JYhJ
 /5X3oRk1VZeoPKRTIoXm76U7h38nhYIXqwelEeG4yo6d3ixsLKCT2eYyNOKlt/IlCAZ/CDd
 a0fhnyBNF+oZtYah8pXsDrg/MlnsUzAQ1Q4sMiPTl/iVe9XrrrnLTULMxsj6g/WgtZ5vRCb
 KC1qlctt1J/cCA6J7n33A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4F6WmZQBonU=;catOkghe2EqrVXS4KOAkjBbxOjQ
 TLEQFphPc/oNod+ka93d8KS5WccRYOPD67JoqarbG+SL6vCRx5FMf3wPZefpPEdndPDCq+E5b
 dTgDr7+Lj8ZYmTVh2vUd15CwtoyWCa5cgcrFo2IeJZZdtBzj/mZ5U3k2UoF4uzrTja4qDaZGi
 jRDDiypYYFnpCIsisCjk4fAksWIcYS8eZZkoc+pN0gdJrLEspiWue9u/jk1TFXJd2I/hremL6
 UAhOH+ExJ+dwtxEOB8smmfVTC6G7BeOJXMtA2b4kH8qyHp2z+SwxJZOuDuK02Nt10dpFqFrj2
 qAN9nA4BJoPF4R+sMoJ9C6uQKpM951Gr9RpKnt3yZKdyxJpgV/VMUMtxrMdi9LfxLWEj7gpcE
 Pu1mljEpGOKKAfvOdZiMy8F5WflmTEt7lQlGBogvY6O9CaOXYqNA9T8Z38Jr+CzlEBZtoO3if
 ATJdd4U2+SXSw7NHfu9xXq/mONa2yxVRZHyfq9dh94KWvUIJCOEU6b+Kv4tDZ0R3O4jhOGuJ1
 9hsMVr1+GEGHNC0DDTscBEQfPnLnB3TXhHfHDI3kI3S7P2sZNipWZ3/yAVpzYHRlOp9wrHaMJ
 g9b5fx7DVd4gy5ClqtiqmbCLQccNaa/qPB/mj0d0GCIIP7PxfNo0IR7hkf68zkTK4OXJbfPdE
 x7Ij63cJh95SGh3+W+CUE6Q189DIRa5VS9ZU3HYtkSHud7NbWwyKrd+BOTklT3/0s4BZMsnqJ
 xfrWWUJrYu7w5r26UriP3hhok3HFOTT4iQW18XdiZ5mHrPWpyLHRwyB3cgznc0v4d4j8a64Sw
 GiAX9Pi9LrheYE6IHuWPtuPesjEqL4UYmtz4gLg0iDRroMAkv3ZvZ639krLkTc7PgaguVbxSw
 SIICTDwlqoweNwSOpulsJfT+bI11CrzU0/Qavf77O8CjAchEklApJd0zo

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> In order to let platform profile handlers manage platform profile
> for their driver the core code will need a pointer to the device.
>
> Add this to the structure and use it in the trivial driver cases.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6:
>   * Don't require to be set
> v4:
>   * add alienware-wmi too
> ---
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
>   11 files changed, 17 insertions(+), 6 deletions(-)
>
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
> index 805497e44b3a5..e5724e76a2082 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -257,6 +257,7 @@ static int thermal_init(void)
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

