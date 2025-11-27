Return-Path: <linux-acpi+bounces-19340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C726C9044C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 23:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A6E3AA1E0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 22:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACCB2F39D1;
	Thu, 27 Nov 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LteZ6hBh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D82417F0;
	Thu, 27 Nov 2025 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764281452; cv=none; b=XxgahbpDV2irn0h4r7M41KHZphSJEJaU9K3bXOT3NmTUB6koWW1pNo/hBdYy+WHUSDLuQreDIhYCY47nGTdxEEnkygNUC65KNfoEcplWzmndi050kpjzyG0IwWrzRXBd3pBrT1NvE/VQWq1Z5WOnPn2fc3B5mZY0YcTlN+5Oy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764281452; c=relaxed/simple;
	bh=YihSFRFsLdmu0EcURJ2bsbi+8sCWobnsznbfVNPDyE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ijzm4kpOiLNFS8/hegLpvYGdF3KkDi4+aX+pYv6qmPuAFEkaQmnVSJiItnYqxmid6y6JucPMHdGSli6GRm6wQVNgrA3Ef0fEB13TUB56jXqoRR0DP1Mpw7sJc1kp5m5ZpIOn52XNXj/S49YbnUWP3yc0xN9eTQPirfoqg6cAg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LteZ6hBh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764281439; x=1764886239; i=w_armin@gmx.de;
	bh=KkpmvFqnZRW0WvnMnH5qxo/p7EECyX5VCsTo5sjgSUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LteZ6hBhmoOAc0FT2z2G0L0Mz+9so268UGckLUJCWyF1AxIgzrPi/Aq5OqaNjBgJ
	 1mxv2RJeCjFIedeAwmd0TDLF6PJZQb+zdvgZ8+c9zEKD4Gycy1tsqMtG932IvA2VK
	 aZfmN3LWlx7PVEBM89u0DksBQc6NYrDWvHS/nXcT5iFPENg431RhSJnqS+ifYdXcy
	 d8Ly4HmYTBBCP281bZu3YbG+L7h37Yw5H6FT+9nhAy10n8NcAUzwoZJ+AzY34i4eK
	 0ad17IV0QH6GEgDlSX7PvO2z1TB5HFWbjIDmH5offNxjjWZFIEoJ5jXHNNbFoldU0
	 FMx/JIebXoxC8EePiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1vZzeg0Mjx-00Vkgk; Thu, 27
 Nov 2025 23:10:39 +0100
Message-ID: <317ca1e0-5217-4ed4-8d66-b35fae6b6a67@gmx.de>
Date: Thu, 27 Nov 2025 23:10:35 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] acpi: platform_profile - Add max-power profile
 option
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
References: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
 <20251127151605.1018026-2-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251127151605.1018026-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aOyL4FZ1z6hhH9D9DSGkxuJEIED48mcAngkRTwyqe49dn+Bnx9X
 tBXedYf0sHHj8JLnP3wN9+aEkbk7ROtHYjThDau7f9MG8GIoZcLpUrWKdGq6onuuQvPGB5o
 061kMPLsa2Ti5Zb8RmbSjBhbPzP6V2crohfzTvnTEiCadaFxDqX2fIDypVY3tB0CQbltsZ4
 x8e2DEZrg8TktNw54zi0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QOd8MtEGcJo=;Eq+WgzQjD6r72eDSqflJn0BetgR
 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

Am 27.11.25 um 16:16 schrieb Derek J. Clark:

> Some devices, namely Lenovo Legion devices, have an "extreme" mode where
> power draw is at the maximum limit of the cooling hardware. Add a new
> "max-power" platform profile to properly reflect this operating mode.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>   drivers/acpi/platform_profile.c                        | 7 +++++--
>   include/linux/platform_profile.h                       | 1 +
>   3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Do=
cumentation/ABI/testing/sysfs-class-platform-profile
> index dc72adfb830a..fcab26894ec3 100644
> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -23,6 +23,8 @@ Description:	This file contains a space-separated list=
 of profiles supported
>   					power consumption with a slight bias
>   					towards performance
>   		performance		High performance operation
> +		max-power		Higher performance operation that may exceed
> +					internal battery draw limits when on AC power
>   		custom			Driver defined custom profile
>   		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index b43f4459a4f6..ea04a8c69215 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -37,6 +37,7 @@ static const char * const profile_names[] =3D {
>   	[PLATFORM_PROFILE_BALANCED] =3D "balanced",
>   	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
>   	[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> +	[PLATFORM_PROFILE_MAX_POWER] =3D "max-power",
>   	[PLATFORM_PROFILE_CUSTOM] =3D "custom",
>   };
>   static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
> @@ -506,7 +507,8 @@ int platform_profile_cycle(void)
>   		if (err)
>   			return err;
>  =20
> -		if (profile =3D=3D PLATFORM_PROFILE_CUSTOM ||
> +		if (profile =3D=3D PLATFORM_PROFILE_MAX_POWER ||
> +		    profile =3D=3D PLATFORM_PROFILE_CUSTOM ||
>   		    profile =3D=3D PLATFORM_PROFILE_LAST)
>   			return -EINVAL;
>  =20
> @@ -515,7 +517,8 @@ int platform_profile_cycle(void)
>   		if (err)
>   			return err;
>  =20
> -		/* never iterate into a custom if all drivers supported it */
> +		/* never iterate into a custom or max power if all drivers supported =
it */
> +		clear_bit(PLATFORM_PROFILE_MAX_POWER, data.aggregate);
>   		clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
>  =20
>   		next =3D find_next_bit_wrap(data.aggregate,
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index a299225ab92e..855b28340e95 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -24,6 +24,7 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_BALANCED,
>   	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>   	PLATFORM_PROFILE_PERFORMANCE,
> +	PLATFORM_PROFILE_MAX_POWER,
>   	PLATFORM_PROFILE_CUSTOM,
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };

