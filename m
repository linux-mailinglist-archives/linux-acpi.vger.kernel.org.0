Return-Path: <linux-acpi+bounces-9370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8D99BF783
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC29B23F2E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F821219D;
	Wed,  6 Nov 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="sEwJWjDQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231020A5E7;
	Wed,  6 Nov 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922188; cv=none; b=AeGtaF7zP/xh48Jx9kEPNvZsrZ9cQ4uIx8GuMC2DvVR8SjeEwqV2S6GFA8JCTNBkkDAr8uJ2Am0MDakL8Pid4UXyAekFavt3YHtk+DCdzrSZ/xBepIOaPRNpgfct7mI8TTk1A1ZUsns9Ge3sJnpNWM1w+IU0NiqdjJhxdyzbz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922188; c=relaxed/simple;
	bh=6rY3cG+v5ZkBDZy4eaXEiJlWhQguf1E0Fx775aYZyb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWPYPMf4GuGbCSrw4pt7+7oM31Av591mqQfeoH74Q2we208eNCy5rF8fopUb4rnyP2/sLg2f1KLyw3NujZrcCyDk+/Jre2k81N6SHOlNBOtOinV9suiGkYEvgARghfj6gmQ8wPr0bHnTji0NXpy0Chrg34H+QAxIsIQcSOigKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=sEwJWjDQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730922119; x=1731526919; i=w_armin@gmx.de;
	bh=eZxLAN69pl4n008KtzyKisRYLFfLEAkYYuV+Sc4FS/Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sEwJWjDQ+MrjzbMBp2PWMW2FOTH0n76EE1WLiAqIRMnTwEssQu3+a3yy9bG/xSzq
	 yZr2ZWTNEYwzh1psbe3NaWhwGzourIfv6EdSOpF7ihcbCbWE3pxtc9DchTTSgYcrO
	 2lAVn94ySdTxq2vRM18Vsuepx+c/GkD9Z6hNrsZxE7m0/i8ZpJjzwtZ5gwea7Eqhg
	 hlmemqbsWAxoHMYcymgMd2pci2nRoTmcwF3v332/l+GfB3hWy1Rz0SYEGSYfzzats
	 aef9mEzEbKW8D12qJc0pXM8mxDGWC29Z/KMpEUMYl/jy92LP/HVrlbgzV+3tV0jdD
	 XQsyEPaBuLklZatXaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1tieYs27hF-00ceBJ; Wed, 06
 Nov 2024 20:41:59 +0100
Message-ID: <7a6a5c39-6b53-462d-8da8-0d66261c9c67@gmx.de>
Date: Wed, 6 Nov 2024 20:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/20] ACPI: platform_profile: Only show profiles
 common for all handlers
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
 <20241105153316.378-15-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-15-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AhRXbLESBadg2ewPfOgYPtH/UFCTDPE7WKs2Ngq6/gzfQwXH+x+
 frZoTP+XEDsdyptNDf093gBeN0TlrhzdAULtBgVN8xFPuwGItT87JKmVO701xOMRhUJB9fF
 LgovUX48IgSqmtCUCeNCVxrP47q1Fq41YlbOWgOvdPmCJxSfEV602lHF9oMSZ2tHdSt5CRd
 62DpPmNKjIGPFYCBNoSGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sa+gWLrMGVE=;z9qmVc89xrPcYHeY6cOn5TJLZw2
 iexSHlR4MJ3f91oC67YJdGb4X8+0S2/fkWI6z8VrImPQnsPEjmsxixbP9bOJqGSDB80Q/n/GA
 VC8uWFHTmtljhdX2nysWX4UCxxKhkiuqI+iTeyPnPJ1W6RAZNWhCSmk8Z+vK3hJ9GcDmeZlA2
 pb2V0LCR+izqBzycX8Ol5h/NSs7Fl8LM841shXB/DJUTtT9pp3O801DVVzI2R1mQn+CB/+ADh
 2RagCn4gVXHCFuUdry6mugyfJNgMD2kBfpjmG7h4RVEQzcLLDrh4LTf4SvNXkTPKBeSu89N20
 s49iAgUx637VGOheEjD7sGCc3i6YDHPcpc/rv5iPzH05AADTATQwSqIZs+VzsFuOOKC9iV9o+
 hzzSr6jnyplnLbGhZqvzZk2lYRsTh2Kh7ofxEKBwgGDyhmunNFP3DV2EvLkb8KT7mdHOv0/oX
 SeaeTaGGEnzFvvIOsPyc0Rwb1nN8lVcDAlDpBsR28Ij94Uwma7X+MKUDfOBNLaBhA5pEsWnK6
 PjIB4aoQXubTDfO+Fy72D8Rm1hS9M/0nX9tyypZ74hhyx3U6fLie/ByA0v6RUGbs3Hl3lZ8ox
 PiNXBQAYfqVEXq7jVoJ1hWB41Ml0shs/M37A0bsANsq5kKSUzSabrXhjV02fVZdgDDOsbX5P5
 lBbhw0sLsQIuNktPsWJ8uhWYz50Bb8R+LksSyYeIW43zKaqeMGTmOQp7sCwXBLJqFrklPl+rE
 pAAhKEdANbMyH0Qc2+ZOrPCv+J24bzQiAwWXopCfJvP1lKN4Xg9UCqjZdON3mi+9GNap1HOiO
 xXQr3UmCnx1KwkOSUxt2nZp9oXZkJznFNQNkF/ddP2X1akTZJB2fVK3aBeJpPwMTHkIEUKYXn
 CRa3y+CxoJQQtkfBTXQpaOb994lbUSEtvtVTThGT7+c6x3SuW6fOU93c7

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> If multiple platform profile handlers have been registered, don't allow
> switching to profiles unique to only one handler.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 55 +++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index c9917daf683cb..8de7c8352673e 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -235,27 +235,48 @@ static const struct class platform_profile_class =
=3D {
>   	.dev_groups =3D profile_groups,
>   };
>
> -static ssize_t platform_profile_choices_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> +/**
> + * _aggregate_choices - Aggregate the available profile choices
> + * @dev: The device
> + * @data: The available profile choices
> + * Return: 0 on success, -errno on failure
> + */
> +static int _aggregate_choices(struct device *dev, void *data)
>   {
> -	int len =3D 0;
> -	int i;
> +	unsigned long *aggregate =3D data;
> +	unsigned long choices =3D 0;
> +	int err;
>
> -	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> +	err =3D _get_class_choices(dev, &choices);
> +	if (err)
> +		return err;
>
> -		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> -			if (len =3D=3D 0)
> -				len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> -			else
> -				len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> -		}
> -	}
> -	len +=3D sysfs_emit_at(buf, len, "\n");
> +	if (!*aggregate)
> +		*aggregate =3D choices;
> +	else
> +		*aggregate &=3D choices;
>
> -	return len;
> +	return 0;
> +}
> +
> +/**
> + * platform_profile_choices_show - Show the available profile choices f=
or legacy sysfs interface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
> +static ssize_t platform_profile_choices_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	unsigned long aggregate =3D 0;
> +	int err;
> +
> +	err =3D class_for_each_device(&platform_profile_class, NULL,
> +				    &aggregate, _aggregate_choices);

Error handling seems to be missing.

Thanks,
Armin Wolf

> +
> +	return _commmon_choices_show(aggregate, buf);
>   }
>
>   static ssize_t platform_profile_show(struct device *dev,

