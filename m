Return-Path: <linux-acpi+bounces-18921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0C6C6183F
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0A514E1E0D
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B523630CD91;
	Sun, 16 Nov 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EUBzxqhP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142A23B63C;
	Sun, 16 Nov 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309674; cv=none; b=Fxi9EVZxHE9LUGzni9TQfg+SBbbnyaoubnwCFOWNEmXvPFT6VToU1EWc3EgkyiHlCfgRTF9OVQ6Jcbc5hwFXAtMC725zKvrhlILwAztCh5s8VuDDXgroN4R/TxWm1BNKuKFm5mq12H92fBhlwzfaw/vVIvUhBNJvUroal2uDupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309674; c=relaxed/simple;
	bh=KR3I0Lxry+3ncWlSaCjtdU51EkPLeOOSjCYTyVYxReI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyYMCVTJoy+FSmwpgHejWMTaNXok+F/E+HP2W3A+EfBgkbtqyR0UaOiCcC8rG6nfrGgJDX8VL1wATT9sFWuWTf1gSoq5sb2BmRn3e8zUKqZEbtxrAbOmDB60Gs9oC8ktyeDnvvfEzVjYNZdNHUCbRsH+hC1o+akeTquCilQ5iLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EUBzxqhP; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763309651; x=1763914451; i=w_armin@gmx.de;
	bh=uopaM0YZk1wcWqVXfd70vgo1302+4LOzKmged/UWZFE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EUBzxqhPANkNhz1gbUhUdvBbOksIzmSIRaIcD5STtaRYcjmDC5OBFTMnLdGn04x7
	 BCBM0p27Wz/sZK0fdARxhCHCbl7QTgO4sT1k5CFoFpfFJYKpZELvhnGwCTpQm51km
	 emEzHzZwp3SAjMNYMgonjpNB3CJppODy0fOIoLsyM72QW3C3FZmalMGJWU91jMgau
	 BPQGMy6y/NslWr4HorfUMOHmUxqK5Krh0sH0DezspuzaOZGvDyJAd5UwABjR8Z+2l
	 NMOktVO0zl8SfcyMnIrnddT+ap2j5wglfHDVZ+U/Wtcti6+gAalPwnaFJeZPSSkKQ
	 zEtDTjRMorTerE5Wjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1vschT0HPw-00iijT; Sun, 16
 Nov 2025 17:14:11 +0100
Message-ID: <3730c2dd-d96e-4905-9182-8752bcdc37da@gmx.de>
Date: Sun, 16 Nov 2025 17:14:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] platform/x86: lenovo-wmi-gamezone Use max-power
 rather than balanced-performance
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20251113212639.459896-1-derekjohn.clark@gmail.com>
 <20251113212639.459896-3-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251113212639.459896-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d4Q/LwbFZ0gV/krUxsiGb3adZtVR4ENcKvYnUA8YpXDa0LQGs3V
 HvshP5dcbgDZkR2/RWi3JpM/8ZCTdBzvFR9RZ6LiXh2nUX46R/oI+hZbg5rzIfBlNCb6U+W
 jibu/DGoNJ4DZlex5zd8H45pdU2yTrSuy6Epcn3NMwPOyjYzK1/RNj/WROh+8C/0PEXnWoi
 zUuojQSVpCc+HyanbXc7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VdXhmRyZxEk=;LD4ZhKqooJu9EGUkTJWiYW4ziXT
 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

Am 13.11.25 um 22:26 schrieb Derek J. Clark:

> When developing the gamezone WMI drivers, "extreme mode" was matched to
> the performance platform profile and "performance" was matched to the
> balanced-performance platform profile, but only if extreme mode was
> fully supported; otherwise performance was matched to the "performance"
> platform profile. This has led to quite a bit of confusion with users
> not understanding why the LED color indicating the platform profile
> doesn't match their expectations.
>
> To solve this, replace the confusing convention by using the new
> max-power profile to represent "extreme mode". While add it, update the
> documentation to reflect the expected LED colors in each operating mode.
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> driver
> ---
>   .../wmi/devices/lenovo-wmi-gamezone.rst       | 31 +++++++++----------
>   drivers/platform/x86/lenovo/wmi-gamezone.c    | 18 +++--------
>   2 files changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documen=
tation/wmi/devices/lenovo-wmi-gamezone.rst
> index 997263e51a7d..1769ad3d57b9 100644
> --- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> @@ -19,27 +19,26 @@ WMI GUID ``887B54E3-DDDC-4B2C-8B88-68A26A8835D0``
>   The Gamezone Data WMI interface provides platform-profile and fan curv=
e
>   settings for devices that fall under the "Gaming Series" of Lenovo dev=
ices.
>   It uses a notifier chain to inform other Lenovo WMI interface drivers =
of the
> -current platform profile when it changes.
> +current platform profile when it changes. The currently set profile can=
 be
> +determined by the user on the hardware by looking at the color of the p=
ower
> +or profile LED, depending on the model.
>  =20
>   The following platform profiles are supported:
> - - low-power
> - - balanced
> - - balanced-performance
> - - performance
> - - custom
> + - low-power, blue LED
> + - balanced, white LED
> + - performance, red LED
> + - max-power, purple LED
> + - custom, purple LED
>  =20
> -Balanced-Performance
> +Extreme Mode
>   ~~~~~~~~~~~~~~~~~~~~
>   Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profi=
le
> -enabled in their BIOS. For these devices, the performance platform prof=
ile
> -corresponds to the BIOS Extreme Mode, while the balanced-performance
> -platform profile corresponds to the BIOS Performance mode. For legacy
> -devices, the performance platform profile will correspond with the BIOS
> -Performance mode.
> -
> -For some newer devices the "Extreme Mode" profile is incomplete in the =
BIOS
> -and setting it will cause undefined behavior. A BIOS bug quirk table is
> -provided to ensure these devices cannot set "Extreme Mode" from the dri=
ver.
> +enabled in their BIOS. When available, this mode will be represented by=
 the
> +max-power platform profile.
> +
> +For a subset of these devices the "Extreme Mode" profile is incomplete =
in
> +the BIOS and setting it will cause undefined behavior. A BIOS bug quirk=
 table
> +is provided to ensure these devices cannot set "Extreme Mode" from the =
driver.
>  =20
>   Custom Profile
>   ~~~~~~~~~~~~~~
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platfo=
rm/x86/lenovo/wmi-gamezone.c
> index 0eb7fe8222f4..df475e52f79d 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> @@ -171,14 +171,10 @@ static int lwmi_gz_profile_get(struct device *dev,
>   		*profile =3D PLATFORM_PROFILE_BALANCED;
>   		break;
>   	case LWMI_GZ_THERMAL_MODE_PERFORMANCE:
> -		if (priv->extreme_supported) {
> -			*profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> -			break;
> -		}
>   		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>   		break;
>   	case LWMI_GZ_THERMAL_MODE_EXTREME:
> -		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		*profile =3D PLATFORM_PROFILE_MAX_POWER;
>   		break;
>   	case LWMI_GZ_THERMAL_MODE_CUSTOM:
>   		*profile =3D PLATFORM_PROFILE_CUSTOM;
> @@ -218,16 +214,12 @@ static int lwmi_gz_profile_set(struct device *dev,
>   	case PLATFORM_PROFILE_BALANCED:
>   		mode =3D LWMI_GZ_THERMAL_MODE_BALANCED;
>   		break;
> -	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> -		mode =3D LWMI_GZ_THERMAL_MODE_PERFORMANCE;
> -		break;
>   	case PLATFORM_PROFILE_PERFORMANCE:
> -		if (priv->extreme_supported) {
> -			mode =3D LWMI_GZ_THERMAL_MODE_EXTREME;
> -			break;
> -		}
>   		mode =3D LWMI_GZ_THERMAL_MODE_PERFORMANCE;
>   		break;
> +	case PLATFORM_PROFILE_MAX_POWER:
> +		mode =3D LWMI_GZ_THERMAL_MODE_EXTREME;
> +		break;
>   	case PLATFORM_PROFILE_CUSTOM:
>   		mode =3D LWMI_GZ_THERMAL_MODE_CUSTOM;
>   		break;
> @@ -338,7 +330,7 @@ static int lwmi_gz_platform_profile_probe(void *drvd=
ata, unsigned long *choices)
>  =20
>   	priv->extreme_supported =3D lwmi_gz_extreme_supported(profile_support=
_ver);
>   	if (priv->extreme_supported)
> -		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +		set_bit(PLATFORM_PROFILE_MAX_POWER, choices);
>  =20
>   	return 0;
>   }

