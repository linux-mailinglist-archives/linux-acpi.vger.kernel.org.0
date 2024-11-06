Return-Path: <linux-acpi+bounces-9375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4129BF83C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3126A1F23324
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCEA20C301;
	Wed,  6 Nov 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WCKKsTn5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EC14F9D9;
	Wed,  6 Nov 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926612; cv=none; b=L65mq2+XOLSjvl6d4MXDNS5F7rwPIufYjF/MtH918VwnctyYxxQnzvB0PvxHtEpTT6vDhdh/xCRZlu4UvkLVjHY+S+Qtx8jknLkT+kV/LOkHOlH0Ef3+Y6VpUSfx58ZQKtQlzyECpb79gL5IY5o2vUtOdc8vIVAPCat0ZusTzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926612; c=relaxed/simple;
	bh=emDfYC5gsNT0ZkPmo70caNBsgspO/o843GkMMi2Sc5M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fuQxa19eSIdS2PLe3Yt4g+RMBsFjO78AjmptSngbzTORr7RR2e7r7o/dtgsFqkBOY724vPMTT6ewpt8nK4hg7N5m+fI1vlwBF7XOmAaMGEF2VMDtDYEIgrD7dctRuaVnVd5EsGqbLfWgTknqueg3pw3iV5woM+oypc4UgknlEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WCKKsTn5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730926543; x=1731531343; i=w_armin@gmx.de;
	bh=7gLnTY8NsEwYaE8L+E3HF94pvqFpm0jDrjzUD9d3p5g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WCKKsTn5HO/lJStk7LCXkocpUcy9uj/f3rzvrO+M1mq2Dk0rTQDVUI0u8uJfcQ3Z
	 Ulr8hSqOb159NfweSpLdpROarVy9Yn4MZHkXSi2aBCCFO0QPYw1hjm499x34Hb7Us
	 8WgddsBKzumz44QDh0Nzd7CnKh/fvTyfAl6YUfvSvuZzlMglxOdPszr7HBTExVQrg
	 v6Di12v5knWSDcWlm63XTJEPGmC6q0lPVgQ5H7Owa8+8os4sRORGqtsU+xjD4PMRJ
	 EDTjIPyk3iaO+/rn1hwlHfjZdP6Xk6rS9xHegZVGLiyd2qkwzTluUQDR0vy9hs3CB
	 zPtMl04zMq+MuH5eZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1teYzT2C2O-00kIaB; Wed, 06
 Nov 2024 21:55:43 +0100
Message-ID: <2d9e5ff1-1e4b-4e50-86bd-970c652c39c7@gmx.de>
Date: Wed, 6 Nov 2024 21:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4 17/20] ACPI: platform_profile: Check all profile
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-18-mario.limonciello@amd.com>
Content-Language: en-US
In-Reply-To: <20241105153316.378-18-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6T44JRw88vFGOMiDnicxFdYWi3AFF8XZYz2jm6IoJecfW0MTqyb
 UUXLkU9Dy7igZOWeyOIFHujSEizR6xzbakuu5lQ5TveTuQ5q5VrETF1HacqIyWjCDXANXw/
 4T5j2HI53xpWt7TRnqS79KZHYxfoZym6+E2gSRYF1IsyRHbhKEBqMKY6kSyX6fUBVJPB1Cn
 yaYbSc2uLzGQXJdDW5Zdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zaUN1DBUT/U=;7XwXDYxkycQdkmvGQlIt0biBN5h
 sKXVsc9EZpLNH1olIFhKQXTF0NKu0KeXTc408msvt2F7GfcnWYd2i+e4uLnX04+LdGxfu5pK4
 lEFumusQDAC73dqvXyvqyOMZnoArvH0hBAeZkOJSV8Wv8PftovDtbj/qF6lJRGY3a4n3QApvZ
 jZlb6MaHx3YdLSJh3rPs5p9aP7nojgmakB9iFUE7g+k0lIKrZjBF+TrltHK+bMOCoLKSErms7
 6nMrm0ZPSFrVMFb7I8A5tFfDQra9FxIMMdOELWsREmjgqRBTIBZ+9FSxexakIOQJyyH03iMeR
 Lddy+gjqkjbkjuDCzI1zwh865w5r/5tgQVQSFaH3QRojzW5P5D11OUm9NOAHqlIKRbBLMoVtu
 uRdxu/6nMI/Teaofl/sVNCGWxTUXhQVdZz/UHm/v9VS3I1XMg0DWV0w8G+KCrL6oYbPtA3PbQ
 sIo2Q2Q6pm2xGcfQy5OcuJ1mpaNSyLfiB2882Q6iXTlorneWReVPbLYvRDyvXDt/p7yf5Ya9r
 NZn7aByib01vq512wYb6GPiXShQw/BjowfAK2Y6YmaGvbfHmthKv1RPF+p/bYYmZAM4ySxROM
 Av685fY24SBKgzb9MV9mObOMgC19CcqO7qAV3cUIAEjZb8NHlUVhG28+5vwwYH8fmb9PAyEWc
 HfFm6zgyk8eAXRMPVZVnDNxnmam9rSWqvTbXnKjQBDfOACV8YNgul+50evetc/DhvxQMWGuR/
 evk6ZfmosOaQ1KmWAOuMSSDdE4mtA7uVNNhwtaKGMsANwaIVkwl7NBBr/Q5oG6CJwMBXNbVgJ
 +/SLqZkNgKDOU6pvdZNHi6gOZeFzrcof1eu+NJhi91P6g=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> As multiple platform profile handlers might not all support the same
> profile, cycling to the next profile could have a different result
> depending on what handler are registered.
>
> Check what is active and supported by all handlers to decide what
> to do.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 35 ++++++++++++++++++---------------
>   1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 7861fccc2e58c..568485e285061 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -378,34 +378,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
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
> -	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {

Since the aggregated choices might change at any moment, we still need
some locking here.

Thanks,
Armin Wolf

> -		if (!cur_profile)
> -			return -ENODEV;
> +	err =3D class_for_each_device(&platform_profile_class, NULL,
> +				    &profile, _aggregate_profiles);
> +	if (err)
> +		return err;
>
> -		err =3D cur_profile->profile_get(cur_profile, &profile);
> -		if (err)
> -			return err;
> +	err =3D class_for_each_device(&platform_profile_class, NULL,
> +				    &choices, _aggregate_choices);
> +	if (err)
> +		return err;
>
> -		next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LA=
ST,
> -					  profile + 1);
> +	next =3D find_next_bit_wrap(&choices,
> +				  PLATFORM_PROFILE_LAST,
> +				  profile + 1);
>
> -		if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST))
> -			return -EINVAL;
> +	err =3D class_for_each_device(&platform_profile_class, NULL, &next,
> +				    _store_class_profile);
>
> -		err =3D cur_profile->profile_set(cur_profile, next);
> -		if (err)
> -			return err;
> -	}
> +	if (err)
> +		return err;
>
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -	return 0;
> +
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>

