Return-Path: <linux-acpi+bounces-10271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 080849FA862
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 23:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A27816515F
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4918FDC8;
	Sun, 22 Dec 2024 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mYrTncKV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BB2B2CF;
	Sun, 22 Dec 2024 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734905439; cv=none; b=PgNuLWs+OST47dRoFaWuQszJJP/kSg4jzK+HEhPcOnSZfKv4xOQGqoacaa1VVP0Tj8JSr/WuXhJypsVlzqK5qP/I7QcKxw2rmUzl4s8NTA6Hqh5WVH5h7aTVDFyVzVaLtO8JxDdBVUt7btFNMFVtSKdcWsVzMXIaJvqjoa46fSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734905439; c=relaxed/simple;
	bh=oqwVAE/6mgOoOJT2DNKvPP1Rxlwj3xgLdrbjl8vhjPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A837PWqcD2pluyg9a2GSyWnBzcyrntSy5l7oim5c4+elQz3IIsmzfyekXbfwnj0jkPs88bNMR+SSNEtj8og+u9UukQ2JjLhkkQorQP1Uyikb/NXQ1/Fay5M4cWC7z+ekPoXSrRMjwAp/cKVRqDQ03pGLvA74memiaB/Mk+aagRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mYrTncKV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734905388; x=1735510188; i=w_armin@gmx.de;
	bh=9S5lsMKNvuL/3CybXeaq9ioLvqg9TfkUihqACV4c00w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mYrTncKV7SQ3Cq0e24YHChzUMYFR8+8k4yqQEWbH5msy4ItESR8COR/gdGKjxGPu
	 mhG68v3IaW36bDEN/gCQ9E69cggwvwexSHbZEDSspspoAP4Z+3LXtaQtuTdAOlBJk
	 R/NH34MjU8YW7Zzwuu+OccAXtTVLNtCzTkyycLAbvsvqmhJ1Ykz7oYVduCE8HFTtg
	 bWwUslzVAkEnVUp1gD+5PgbqnvwUtUphMbDQrWXibUpUCgfkc2y+nUXE6qEnjTDbV
	 K+G/E97MEL2NAiEfx1GqN0t4s7vujyrp9a2bJyfMnoqalKERXSz0tKHxBvA3R+eVv
	 r6QukUJuZrBzjidrmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1tmWqN2cgW-00yN4u; Sun, 22
 Dec 2024 23:09:47 +0100
Message-ID: <5f173547-f643-4ac1-919b-cd864b2969fe@gmx.de>
Date: Sun, 22 Dec 2024 23:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Add
 devm_platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241221070817.3764-2-kuurtb@gmail.com>
 <20241221070817.3764-4-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241221070817.3764-4-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QON1IIn52thbvNWhV1q68pbvqld2x233FfUbiNKF8UuYfRgVUYN
 BrAyuTUWlNOjrAFBrV7XSRlIz5H1B4r2PlRk/txz7UtM+zKxOiofwYp7WzPp9et0wFbu6is
 fRTaowr20rhGYnLoDG4lrJOFnjIEo6fELyndzepYWGN2Onh4qs63uWNYKA04IH95KVIIJyC
 6H7uQcCbkihNEdSW6ZW6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:viIFtTChA58=;Om7hwquKT4jOA2jMel/j/QIZpNW
 2caFJPY4S1u8HfpwNhjCTd+buwUW8B4//93AyGieBue/lMRH0k5DDvA+8vUs8LSiJOQ9WKkzM
 KPGmMIRjj4rql5odgFzPjuDF1xlj4uwffBKsgJZRJwAgaDq+gmd/xAYdQ2DE74CTkcKmFooM4
 pSEjbmxuy7txN0PonnM3rMTEiZNm70iLhZtxrAvZzsQL5JIi3UmZvfPdM/M/PhUNCNFPX6Od7
 kcwrB6FcIktKTLPuniUHKv4fzPEyjxzv+UnArQrrjQ1frPbUJQsmXWwhUX74CMebcCj9xtJ7l
 +COhnn2ks5aCSYztB5To3dWKOlMrvYAKl0+lgEi76r+D8TvC5EBM/w6ixjcSY+tQiWC1OvOb5
 C+sp0F0ncn8zd1aR0/kSfFPSFm6J7KZNrbAOQyjiWim35OtIZ7G4RX5R9EqSe3pN1jbxBGebN
 +EbZryrFNZq3bwDwoFx9SyCGxWji5bJDy1jeHd4s2g5OqROIbmJlodPBHHG6eOXhpfT+jINyZ
 73aqax9p5N/1T7b3Pfo8el9siKSerhyYu01/mgvpnwlwVejbToz3ZIXZiZuyXiZhYhELP5uxv
 kBgvvQEVzeKbiX/eorRXcETeh4EoWnzS3mm4XZYcOD11fx0Qn7DX46og/YAjsjSqAa/gsPQLK
 52xJPBX8NqdtalUFVP4zMtIPj6LhHAA+3paI3wq+ZmsLnAC2SvwCgiRql2msm7Z6tO7jszkxN
 LiOq+FREGXhMzy/W1Bzfe7fYzdDuYYLq0USiHDYQBkvkSt/MTQ1mpVGxXGnAQxvwNkn1HDceS
 M3X+F/DpDNrWmcdajtN3lDStxFmFhkd96JUxRbzfhcoGpp10loaC2pEwLqI8DNCe+YLT93v14
 gomzQGUJx7y752lM/1CC8RGFTeWWNdqSQmdcLCddcuidICrXQwqsQK7f3yxXRQq16D+6CR8ar
 ikq5Ml58nNImXhwVQG8MaEjK2RX6h1CPiMDj8cSmUJ/5CiAk0Bup4pJQO7zXV0+jbsYnvHo61
 lRkVnD9ppVEhdfmmOwi8CHg13E/+oOJagEAjF6NIL2hLO37RH+CxRusRfAp+AjpogDvGyxTtR
 9I5NNpbImpXabOJDP7JafBScscFDZl

Am 21.12.24 um 08:08 schrieb Kurt Borja:

> Platform profile's lifetime is usually tied to a device's lifetime,
> therefore add a device managed version of platform_profile_register().
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/acpi/platform_profile.c  | 27 +++++++++++++++++++++++++++
>   include/linux/platform_profile.h |  2 +-
>   2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 75a1415190ac..d0c88decef8b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -519,6 +519,33 @@ int platform_profile_remove(struct platform_profile=
_handler *pprof)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_remove);
>
> +static void devm_platform_profile_release(struct device *dev, void *res=
)
> +{
> +	platform_profile_remove(*(struct platform_profile_handler **) res);

Please introduce a local variable instead of using a convoluted cast like =
this.

> +}
> +
> +int devm_platform_profile_register(struct platform_profile_handler *ppr=
of)
> +{
> +	struct platform_profile_handler **dr;
> +	int ret;
> +
> +	dr =3D devres_alloc(devm_platform_profile_release, sizeof(*dr), GFP_KE=
RNEL);
> +	if (!dr)
> +		return -ENOMEM;

Maybe it would make sense to turn dr into a normal pointer? AFAIK there is=
 no benefit in
having another pointer if we can just use the original pointer.

Thanks,
Armin Wolf

> +
> +	ret =3D platform_profile_register(pprof);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	*dr =3D pprof;
> +	devres_add(pprof->dev, dr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_profile_register);
> +
>   static int __init platform_profile_init(void)
>   {
>   	int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index 0682bb4c57e5..d8114435865b 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -41,7 +41,7 @@ struct platform_profile_handler {
>
>   int platform_profile_register(struct platform_profile_handler *pprof);
>   int platform_profile_remove(struct platform_profile_handler *pprof);
> +int devm_platform_profile_register(struct platform_profile_handler *ppr=
of);
>   int platform_profile_cycle(void);
>   void platform_profile_notify(struct platform_profile_handler *pprof);
> -
>   #endif  /*_PLATFORM_PROFILE_H_*/

