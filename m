Return-Path: <linux-acpi+bounces-9413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A099C00AF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831ED1F21DEA
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834BE1DED77;
	Thu,  7 Nov 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BzfQq4Wh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E71DE8A1;
	Thu,  7 Nov 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969951; cv=none; b=ZSZnLctCSPA8aLxgkGVYW7s+ePP0iU1P2gkGrZYjhfN/o20IVYp0Dk/Yx+k/yxVvYqdZl86BEva1ean/CQzLXWm60Ni8yfy2bX19ELUZjso9tmAYX3zMmu/7IIzF1Kk4aZLIC1O0V+4kACAw7/enD/aQTJgyRwvXIIzgrBmtCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969951; c=relaxed/simple;
	bh=HzLdsoyErUhSMOpPXvjwxrQ36OAZ/NZ49E4akJD+32Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV1HMnBg3BeFQI3Md5928dVXVoZ9/r/2HIFpiIvq24uLVWvETh3gjHNBOaRWEVyP3Kuswqo1eFkeVfHWz19hIMHxbVcRfQY0IA6EVCLpEHAwLJdm3uV/+xoxovTjSAWeHCGP/YuD1pQ6DhWyd2bgYwEY1R7CCFgZ/S36z0Lu3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BzfQq4Wh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730969883; x=1731574683; i=w_armin@gmx.de;
	bh=SU68SlzFV1+44QFj6alvL+ek3vrtw9Tg/Xom2jzheOI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BzfQq4WhyXJHuQMsGo+YjzSEB88Tsp+31J7CZ/H5N49LlewSR+SR+APNrQtQYQOf
	 8vEC5Syf0/xSzmIdA5VGGZV2xHp6O8MPbPmHAztNep4tdY/45Dtt3YuzcNy+LWqAg
	 QeycrPW2SOUWpJgOg0s281LXhine1Lp1Hvn4+QdWIlznd/VXuJEr9yBtKyu3UWEWh
	 pMiYB6QghJrLjGcKG7SrPz9sHAvm1WYk5Ab8YXDcZ4AM6GS8OVRd+oxhEjnCwQUIC
	 oiprU48SsubS+UN7D8G/NamfkWB0SAswH+NYfoe9PzMYLJiCLrX2Y/6spXRyin3ik
	 MgyY/Az1hpXGD2N2QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1trlIu1n4l-012b44; Thu, 07
 Nov 2024 09:58:03 +0100
Message-ID: <989e7297-97f9-4d55-be28-78128572fed2@gmx.de>
Date: Thu, 7 Nov 2024 09:58:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/20] ACPI: platform_profile: Check all profile
 handler to calculate next
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-18-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-18-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PAE0GQ1MrZHtmTNxHNxsLPfPreWTFJw2PB8Sxs7HmXojgcieSuk
 nKuHTAwAoy4jZ++8i8SBjIRCLsXCyjp0Ybt5JLbswP3pZ8vO9zSIlbpb+iUzqKoyZtadgHg
 BLKrlXa6U54QQfGOQ7K0ztWiYSBRmAhcQrRvxi6uUMyKHROjS124slASfNpA7P/kVMi4NxL
 4Ai413MWYPh6c7kXYrA6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D20ULot7zzw=;pr6llb1Et0ycvoUwAgxRDEOctQU
 MaFXaSV9tb+BFKQIve7O6GxHkzUViurHWvnHor//YA83q4EwF7W+lxl+q7XV4KCZZ7slzDlH2
 Kr4v6EYke6jKgN43phUX90FDL7OzSL6MycF6wzWzDGJnyUVGvbByV6W/OqQjYCpwHqbYD9Uq+
 5zJ0n7/qeJw9f3r1ijw6LbFJ/o7sfAhLBC3pvOT7nKlWEtsW7Skf4GsMtCDh6rW3EK0vbfIJy
 nUk0Jblk/aGEsDHCJdtViLBtdflXb5rX7POndi/WB7hmKl9f5xTY1ki+9+0yowtlPsU/zBkA1
 EMTv1/zFDzw7xuoE6H+ifdNUOIwStLmyu0RGRn06jUlxUPrMuNR7iTyCkJvlG0RncapW8eO3h
 C6z2XQlPl3v76imExu4qoTYeQH9+LEmXnUjz4kx6WRACXCjkEKiAl1jtuuNX1jDrpBgcbRsLO
 1BCdIXlbo8T2DiUl750MKSRD2equHKsOQMkDCV1cK3h5y99QFS1T4o8D8V/dkIBxJ8poMQPDi
 weIf4bL1rsjFvvA/hXMWGB7v1v5UIt4C1+Z24tpK1vz4V2q3W2N8pXIQpIOwSE2xtjjAF+z9w
 fx00gUvHhqvbOYbwVC2cvtaEr+fmps4ccsMiQ6rQn5t0qDf2n9r8C2TISeSTxICA9ZPbeOcax
 wuwblqjXSU7qIRx8SrCJerRuhUPzxtH1TWeCuGu6fYcB30Ixwvw8URJ2AMFD9gpbatCkgJ2zu
 MuSXWbE7ogvpgxPr/SI6KUSHdYBTAtJ17eXcKn3q1Fogy2uB2S+x4zqVyyhaAhwLKpy36r01O
 rGq7sWjbqXtNzvMP4EGH3b3txyQq0amVtztzFawMP0W73f7qVwLFFrhvXjIqiAYbHbgX/15Kq
 UQaSEOpS4twnqrsChcHzldInJ4V3nk058mnVtc4VWQOFXT6YMe+PGJnRQ

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

> As multiple platform profile handlers might not all support the same
> profile, cycling to the next profile could have a different result
> depending on what handler are registered.
>
> Check what is active and supported by all handlers to decide what
> to do.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 7f302ac4d3779..2c466f2d16b42 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -411,34 +411,39 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>
>   int platform_profile_cycle(void)
>   {
> +	enum platform_profile_option next =3D PLATFORM_PROFILE_LAST;
>   	enum platform_profile_option profile;
> -	enum platform_profile_option next;
> +	unsigned long choices;
>   	int err;
>
>   	if (!class_is_registered(&platform_profile_class))
>   		return -ENODEV;
>
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> +		err =3D class_for_each_device(&platform_profile_class, NULL,
> +					    &profile, _aggregate_profiles);
> +		if (err)
> +			return err;
>
> -		err =3D cur_profile->profile_get(cur_profile, &profile);
> +		err =3D class_for_each_device(&platform_profile_class, NULL,
> +					    &choices, _aggregate_choices);
>   		if (err)
>   			return err;
>
> -		next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LA=
ST,
> +		next =3D find_next_bit_wrap(&choices,
> +					  PLATFORM_PROFILE_LAST,
>   					  profile + 1);

Could it be that this would lead to be "custom" profile being selected und=
er some conditions?
Also _aggregate_profiles() expects profile to be initialized with PLATFORM=
_PROFILE_LAST.

Thanks,
Armin Wolf

>
> -		if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST))
> -			return -EINVAL;
> +		err =3D class_for_each_device(&platform_profile_class, NULL, &next,
> +					    _store_class_profile);
>
> -		err =3D cur_profile->profile_set(cur_profile, next);
>   		if (err)
>   			return err;
>   	}
>
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -	return 0;
> +
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>

