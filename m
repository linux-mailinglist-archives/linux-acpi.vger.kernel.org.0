Return-Path: <linux-acpi+bounces-9647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74D9D1957
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 20:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7082DB2231F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821DB1E571E;
	Mon, 18 Nov 2024 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="U9Pe1zE3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206F191F99;
	Mon, 18 Nov 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959682; cv=none; b=XpM88SdU4kdnC+JokJue5mtTb3Ycksfo0inB6WKz8pzk/wnL7I7G5kkVsU/1T+tLIP7KsmJqLz3l/jH4Wakk8y1xA1VYjIcW0RL50UaA7S1XwjebXB8fJkP4rKj6ZFde3IenlFJlWu4rMJu5kqBRuLhJE6D1/NaeZs8EyLLZD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959682; c=relaxed/simple;
	bh=PhoZZLsSsraRjUZyLb9VT4KXzNtJeWOiHlWXghtTBN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCqPZzeX0fI9EkSkwSxzWK/wpmLMPRytraSOzVzLLLy3Px/G5E3thPAh38jchiIVnMIJIfGeb3FJkp8N/e7AR9H7fr9L0ZJRnUjgEdUAaPMAsb9aC5UP4JIp+GftpqqS3jRSF4VGztlRK4EyeFeCGnZSMWZNTLul5YoUq7kfEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=U9Pe1zE3; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731959596; x=1732564396; i=w_armin@gmx.de;
	bh=C23UJENaeAkNp4VGbRLo2NOGyzcrjl/JJgauoA6EQf0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U9Pe1zE3piC0I1vuelzV89zd44E8twM2oxREfHfEZrJjfx1UI/T/nAvuv4npX5cy
	 /+JXc0pO3P3XJoOVIUMP/KRlSNv4qvPn4LvI0fCCP1m06zibqgPEOq4eDD562+YOQ
	 X2SnQaJC/afmmm00peY3YFIlZrcSntAheWSvICGp+uOJAD/24minLlQ82NbbQBRjn
	 FPtnt8cGolFY6gXJ8N27s4VZea6dMdDvLSVVE0G2u6zZzntTh8G0JI8c6om8TJQ3c
	 0M44RLqA/rdaT3fnah2/pBpfYUnITDmXnHhoyMGBpjPrcoP5mkOLevInebN3VefyP
	 yKKY606bcgsmj3kNNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1twfz73yna-00zZsX; Mon, 18
 Nov 2024 20:53:16 +0100
Message-ID: <5c961eaa-9a3b-48cb-a0dc-f704dbb267ab@gmx.de>
Date: Mon, 18 Nov 2024 20:53:11 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/22] ACPI: platform_profile: Check all profile
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-19-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-19-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5iusdkqTQ9qtlTcEOYBndv5kdflset66miZ2lr+7S2MbuNdLH6B
 e7U0bTPFJKSPI6dJ/Q5QbaJO9GuW/H2O+CxKiEwGHEwFob2GnkVBmzNKxGS966YKvIV4smX
 j2gkw3YmI1wISh4l0F2FywjWAfmJbb9qFcxk3lA3/UVTmclhRDUWv/+yCCuDMHSS89MJJwj
 WL60/13OfrMqzZtvVNaSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P31X0yxX8Go=;diyw0izFH3r3WFq5U0DW4Aiapcs
 xjl6WxV3O+n1a2tzy8aStwTn2uBAQpsuiQEIFYZJbe0TwvJYluOkTVg7ySDE495B08Cv/wQUR
 nCeNJ3/MZNgxrjlohiBlNgD9xctFcON5VwVEvfnyvZ3stVzI/eFbMbH1ZHiq1yalufmrAtqwk
 rMpIFPDWHsDYsszCrVHsM6r/3Vth4GD/S/AjhDCb8XAhBTeWqlejAY9YrEDoIHe1EkJqdlM72
 Ce6enchV+5+bGqD1MnIgN+eX4IJSpqU7uiw5l1ClePcnFSs3QKvNahKUNUVpCeeYicg0/bNcx
 mj7mJ3Ua1qPzl4YuOiRZAykxI8fQVWQqcAtOjUxyb1+pA92L3LB28QaroEi1YMnOp+hGchd4y
 IXjuAh31X5t62eKQIB4gquVeG+MQ4c19ZB6gUMJQ/m9ydFJKilaKYiAAxV4K5b4wPBsGvOhsz
 1QtDNiy8Yw9u0/+4iHCF3D9dHfp2Y8bt8lC1e+D9bDm2n/D+9HCWAVrTuxHh30idwZaEUXeXv
 +7d6nObRImNS+YwZOWOfiSRH+DzntuqxL0wrEodu8wn0OK1CLBoT2IPDZMZGm2o4Q1lhmxyuq
 ejG/er3QXNm3JzswArP3BBK90sD5nZ6zlzI2r8+wXzvQfBHi8kXILyCqvdw+85EbAROT3O7u1
 BxhpfyabpoPEOg0XBxwq+bk1b017suS8e6y+fNDzCNx4AvHming9Q03wI70X9wA195wOjZ030
 M3vUOT24psj4//Utm8CwclmIlGnbUeqma+OpS5z+ysggiHNg+8yMzw+Mb3Dga+UWJBNSzqhna
 FrHhB1yCwT/FV/AyiQL/Lso5ecLKhI6RipaCOk4CBHZHeFq4xjgeJfHUXtcGI2v3lITMzKAOy
 UZld0vLA68iT+gQzXJaSWpxIeuqByBtV4k7m6HrOlJ4osaBcQDzvhbFAo

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> As multiple platform profile handlers might not all support the same
> profile, cycling to the next profile could have a different result
> depending on what handler are registered.
>
> Check what is active and supported by all handlers to decide what
> to do.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6:
>   * Handle cases of inconsistent profiles or all profile handlers
>     supporting custom.
> v5:
>   * Adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 2676f4a13689e..c574483be4fd1 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -423,28 +423,40 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>
>   int platform_profile_cycle(void)
>   {
> -	enum platform_profile_option profile;
> -	enum platform_profile_option next;
> +	enum platform_profile_option next =3D PLATFORM_PROFILE_LAST;
> +	enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
> +	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	int err;
>
>   	if (!class_is_registered(&platform_profile_class))
>   		return -ENODEV;
>
> +	set_bit(PLATFORM_PROFILE_LAST, choices);
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> +		err =3D class_for_each_device(&platform_profile_class, NULL,
> +					    &profile, _aggregate_profiles);
> +		if (err)
> +			return err;
>
> -		err =3D cur_profile->profile_get(cur_profile, &profile);
> +		if (profile =3D=3D PLATFORM_PROFILE_CUSTOM ||
> +		    profile =3D=3D PLATFORM_PROFILE_LAST)
> +			return -EINVAL;
> +
> +		err =3D class_for_each_device(&platform_profile_class, NULL,
> +					    choices, _aggregate_choices);
>   		if (err)
>   			return err;
>
> -		next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LA=
ST,
> +		/* never iterate into a custom if all drivers supported it */
> +		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
> +
> +		next =3D find_next_bit_wrap(choices,
> +					  PLATFORM_PROFILE_LAST,
>   					  profile + 1);
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

