Return-Path: <linux-acpi+bounces-9337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F59BDD92
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541F41C22F3D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B718FDCE;
	Wed,  6 Nov 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XGLqpZMT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DEE64D;
	Wed,  6 Nov 2024 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863746; cv=none; b=mMo5Wgp7dRZvbShW82gWJ6CNFQuWFdSg47cJRclF16KZxB/2P0B4ld+lqO0RM2FnsBPwVPD6VZfuW0P5nrCY5DtJaEcXzBadeXTemND+HxhZwGJMavCOr5p6n9lddq81HcCUozkEHHctY2CAEYe2SG6FrR741CKlUc/b2FOrZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863746; c=relaxed/simple;
	bh=8z6mpgKtC0sYeqR0f+xWDWY6CcphlBo6RSvoTKOEBBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGlplH8RJsyMsjx8H5cAw/MqbB/iWtwRiQI4/aiStr/Ay02RCD37wOoPkZg8iX1mSTPctyOfUD8CNAOULUGeTlWaCL8+N+hJ9Cp2/8SZAkucvKkogUYTz7eRl+yBK5Qm5/mycw+ot2kCk8IK76XkeNsTzzqmFEjj2BCopwi4SrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XGLqpZMT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730863673; x=1731468473; i=w_armin@gmx.de;
	bh=OBK21Tdfv+zM+bjwEo6sEkfi8wm7ScdHlW2LsThsuBU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XGLqpZMTbefGSy8loj6LO8tgMYQ24t79ng3csogl0lK8n+OIHMbT/unwpuUcKaTd
	 q3XD5gKrKtU3wLEAJn5IygeJ9gdb97jtZFpLdp+/oHSHa7Br2CHUV5MOSplb8QeiQ
	 sGpmDxS0voUg9dyMnInYbUIQD9xv3a/Ywvn2IyAokFUZ21OenwaePhRQGSChBpLEP
	 LwnvQAtVTV2n7wIE6784X2IL5LEd4fD46zVv3yCe9kJp+h6QBrkUdjU9uDBRjuQo2
	 c3C6V9Dmi7eL7SO7no9OXAn4/7Yvy8HvtaWhHmoJOoLLYXWydtyzu2RM1B0GIZwft
	 idVe/iXpl7HfO/0rTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1tnogM1aI7-00y9AK; Wed, 06
 Nov 2024 04:27:53 +0100
Message-ID: <380cefa1-f578-495c-9f31-685482f44721@gmx.de>
Date: Wed, 6 Nov 2024 04:27:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/20] ACPI: platform-profile: Add a name member to
 handlers
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
 <20241105153316.378-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gO2nxtetvOO/R0uIm86U+FcTp/kghC079QDE/BddopcfAI+PJz7
 5+jtpiwxbcZEtCyCGD4MPmuDFPZ6RCmNazIZqg3Zkdg1gdUIXSsmI+U/gZQ+8vTR9hN0LxJ
 SU/vC2IP2bUWGqhSAGs2sR5amLEGA098LZwTQW6+wVMIh1TYIxZmH1rc1GPeKVd8rNmVnOv
 eMW/BJLOYrvo5Ed5oPM2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UNWYe+cr6cA=;AmKccz5XqBE4VwkkrQCApsVu95q
 G6Trg4HAl+jkcNLBbDCk75xIRSX0KHnh6Z9Ra+8aGWq11Drk0o9MPj6pCkapIUN/IM3tp3c4g
 4ProSATpjBmqQRbWjUBn3rJxfquEV3nfriD+3WBELhDw20t+n97cYCpCaNhjC4olS7cdIVvxL
 87F5GdNsYZIGt3o64jZEgb1O5kFQfw+Of/OEMT/rRukOvv9QqyPL87YeiiNYrfruXZuCk5lUD
 56Ys2qGhSKnIkc2kZaFrqYLa4AtbSEXF7NtWRcBZNLOUordX4RxSmJUieN+4eEnhy8FSY0Gfi
 rQPpxpjcF9L7j9Nxb1d9RLFiaOf9UaYBHlcK7pRuWG3jQLGagEDq/u6nu6C5VL5vX7pn8W2Iv
 UvVxyxM2AselEcWvftUROaQgP5HAMiz0Y59EJYgf6q5g5vHjE7xxaOOa0pXb6URSFjrFG+oY5
 TrKQzelWY9YJs8PUCF8wmZqrVk54tDWdPXKwmNRXHHLGyZV9Klj39ndV7oSKo5rzHaupkA7x9
 C0dlSJ76ZQmQZ67JSx0W65V64ScgBdAdsdDIBkq42iZOote8gdQE/0417makRTpAl7qcdyd93
 L22v6APVt0Zi6ow5tCCB+Hs9hZca9+uCUXm4R9nDO6ib5CUmPJPhET4KBeB4+XJyiZP0Ix1Hz
 RtBpoJGaPusNmZ64FtW/rZcOj/0PX6oVBu42Gjpq6NrK2VplU12Oly5gaQbGP1Av3rWLjEO40
 dol+Muj9sxYNxqnLHKluAimrcb0JstApjIoAMWf9a2YSw1/Fl4T6HTVGWUgx5QtsfnzgF8DpQ
 NHuFjgB1YHNPtMgHU4Z0BbrA==

Am 05.11.24 um 16:32 schrieb Mario Limonciello:

> In order to prepare for allowing multiple handlers, introduce
> a name field that can be used to distinguish between different
> handlers.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>   * add alienware-wmi too
> ---
>   drivers/platform/surface/surface_platform_profile.c | 1 +
>   drivers/platform/x86/acer-wmi.c                     | 1 +
>   drivers/platform/x86/amd/pmf/sps.c                  | 1 +
>   drivers/platform/x86/asus-wmi.c                     | 1 +
>   drivers/platform/x86/dell/alienware-wmi.c           | 1 +
>   drivers/platform/x86/dell/dell-pc.c                 | 1 +
>   drivers/platform/x86/hp/hp-wmi.c                    | 1 +
>   drivers/platform/x86/ideapad-laptop.c               | 1 +
>   drivers/platform/x86/inspur_platform_profile.c      | 1 +
>   drivers/platform/x86/thinkpad_acpi.c                | 1 +
>   include/linux/platform_profile.h                    | 1 +
>   11 files changed, 11 insertions(+)
>
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drive=
rs/platform/surface/surface_platform_profile.c
> index 3de864bc66108..61aa488a80eb5 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -211,6 +211,7 @@ static int surface_platform_profile_probe(struct ssa=
m_device *sdev)
>
>   	tpd->sdev =3D sdev;
>
> +	tpd->handler.name =3D "Surface Platform Profile";
>   	tpd->handler.profile_get =3D ssam_platform_profile_get;
>   	tpd->handler.profile_set =3D ssam_platform_profile_set;
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer=
-wmi.c
> index d09baa3d3d902..53fbc9b4d3df7 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1878,6 +1878,7 @@ static int acer_platform_profile_setup(void)
>   	if (quirks->predator_v4) {
>   		int err;
>
> +		platform_profile_handler.name =3D "acer-wmi";
>   		platform_profile_handler.profile_get =3D
>   			acer_predator_v4_platform_profile_get;
>   		platform_profile_handler.profile_set =3D
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/a=
md/pmf/sps.c
> index 92f7fb22277dc..e2d0cc92c4396 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -405,6 +405,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   		amd_pmf_set_sps_power_limits(dev);
>   	}
>
> +	dev->pprof.name =3D "amd-pmf";
>   	dev->pprof.profile_get =3D amd_pmf_profile_get;
>   	dev->pprof.profile_set =3D amd_pmf_profile_set;
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus=
-wmi.c
> index 2ccc23b259d3e..c7c104c65a85a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3910,6 +3910,7 @@ static int platform_profile_setup(struct asus_wmi =
*asus)
>
>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile sup=
port\n");
>
> +	asus->platform_profile_handler.name =3D "asus-wmi";
>   	asus->platform_profile_handler.profile_get =3D asus_wmi_platform_prof=
ile_get;
>   	asus->platform_profile_handler.profile_set =3D asus_wmi_platform_prof=
ile_set;
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index a800c28bb4d51..ac0038afd98fa 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1056,6 +1056,7 @@ static int create_thermal_profile(void)
>
>   	pp_handler.profile_get =3D thermal_profile_get;
>   	pp_handler.profile_set =3D thermal_profile_set;
> +	pp_handler.name =3D "alienware-wmi";
>
>   	return platform_profile_register(&pp_handler);
>   }
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/=
dell/dell-pc.c
> index 972385ca1990b..3cf79e55e3129 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -247,6 +247,7 @@ static int thermal_init(void)
>   	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
>   	if (!thermal_handler)
>   		return -ENOMEM;
> +	thermal_handler->name =3D "dell-pc";
>   	thermal_handler->profile_get =3D thermal_platform_profile_get;
>   	thermal_handler->profile_set =3D thermal_platform_profile_set;
>
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/=
hp-wmi.c
> index 81ccc96ffe40a..26cac73caf2b9 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
>   		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	}
>
> +	platform_profile_handler.name =3D "hp-wmi";
>   	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choice=
s);
>
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x8=
6/ideapad-laptop.c
> index 9d8c3f064050e..1f94c14c3b832 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1102,6 +1102,7 @@ static int ideapad_dytc_profile_init(struct ideapa=
d_private *priv)
>
>   	mutex_init(&priv->dytc->mutex);
>
> +	priv->dytc->pprof.name =3D "ideapad-laptop";
>   	priv->dytc->priv =3D priv;
>   	priv->dytc->pprof.profile_get =3D dytc_profile_get;
>   	priv->dytc->pprof.profile_set =3D dytc_profile_set;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/pl=
atform/x86/inspur_platform_profile.c
> index 8440defa67886..03da2c8cf6789 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -177,6 +177,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev,=
 const void *context)
>   	priv->wdev =3D wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>
> +	priv->handler.name =3D "inspur-wmi";
>   	priv->handler.profile_get =3D inspur_platform_profile_get;
>   	priv->handler.profile_set =3D inspur_platform_profile_set;
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86=
/thinkpad_acpi.c
> index 4c1b0553f8720..c8c316b8507a5 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10549,6 +10549,7 @@ static void dytc_profile_refresh(void)
>   }
>
>   static struct platform_profile_handler dytc_profile =3D {
> +	.name =3D "thinkpad-acpi",
>   	.profile_get =3D dytc_profile_get,
>   	.profile_set =3D dytc_profile_set,
>   };
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
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
>
> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2

