Return-Path: <linux-acpi+bounces-9340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93629BDDAA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65515284D9F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5C19046E;
	Wed,  6 Nov 2024 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Xle+/9tt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357F19004E;
	Wed,  6 Nov 2024 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864207; cv=none; b=OmWJyFR9fTHImlTFpKDO0NXZ8Hrn+JPgQ7E0d947WfizvdYaP6PAoxM9Pw+O/L4NEMrcekQMi1Xf7bIPrgrqbXHcBKbUDWRTJAao8cTTgVr8UirQT2H7PCx2eagp6/J7c3BuQb/QQVNMUNHVJYJAWjn2QUU/yr3vENaOT79mdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864207; c=relaxed/simple;
	bh=DuNwxyaz1AleDbmlDR/nEZe/JyQy8LcjkAIT5MEfnuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifx+rhQ92QLKrcL4AW+cJE9FKueWfUG/MVjxM3MZOBGsgsH03diALSNfO5m7Hu+kEzL5OICjKjhNMvrgKkJxL/mbeeAKPv5rzvQo0eSbPJ4V3y0YSy12BOk+STlVoN05m7sTWaABh5Pvbczwit8ZjlaE6VbVosSpobqV/lxmzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Xle+/9tt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730864137; x=1731468937; i=w_armin@gmx.de;
	bh=jXqDYe1E/BAwByeQJ31UBQ/1XPkaUfqGAI18n6Ypbps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xle+/9ttiVKsdcDJRF/xgXMagIe/KbsoRZJ3shHE4DiR4Rp7v5ZN0YiEgt2Q+ABt
	 bfOt1QE343eNaW2pVDJYMprEiNlipATQ/oHFb7no3VRMZIK4tLWRolOR8inADtxjh
	 EGWtSGHoFqYwDbz/7t5h+CDXD16SN9DY98qJE1cygqF9Nco5xXP6NtjjWy1Y/R5yv
	 bMRateE85P/PuG370JLJ7bh8Guod1onJJBSJkOiCmfTQRIrusHpoVvsIuOHBworqo
	 beXUc3LWhHosaoAFZ+njX92UZNOeSjzhh31MbwFnCpvR5oXmrr1e3EVEjLfHyGkAP
	 5DMxEk6tdtPUSgX7iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1tKp413tBF-00KwST; Wed, 06
 Nov 2024 04:35:37 +0100
Message-ID: <b08c3be4-14e3-432c-8a39-176bd77e2595@gmx.de>
Date: Wed, 6 Nov 2024 04:35:35 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/20] ACPI: platform_profile: Move sanity check out of
 the mutex
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
 <20241105153316.378-6-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VjG1clnpRTw6AstJNkLk5to2AQ0/fW5t3qDNEdQlRVCfGugIBBp
 XguIwaoZN0+rppOJa6dqj0YLtIbPTTHYBMxmbzytmg+CSThw+0lZ+B1ZkE0eSto53pyAu3d
 1V2g8q4t86yWO5BeRLh+ZU/fpqLLZb7jU4HKNBvpKxdZcyD1hkkNBqf3iFqhZXt46/ywZWx
 QM25L5RyRWX6js9rAFsTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tWsOFBeEygM=;7HsnlI6jS2zbt9WxjoPJpHgWqWa
 3gKOv/3dFbOG+CHH9vH6kakYokU5aEskr622VkdxowGWxkYR8MO9GcSp907CcDJofJYl+pGUy
 u6HW6KNcdTx/U+08d14WTI6qkZl9TwWXMLpvf7ULp19RPR8WDK4AetCuCVi1LEFP+fNPj5zkG
 cwLCXTYpewIiHVoGubeqQncXpVX5EX474+0fCp1vG1U6kqO2tjTJDoRgzynNOpsMkUIT0bVGp
 BiWeR5ONwLNNjQbhTeK+JZnNRwJAiEnOo0Vc/ZUCRyaDkhyAdqPcck4TxciGjvVLsbZg0FAno
 s+mXmtWs7fiXYOhnqgMd/eAD1hdEiIhHxe7/URNbxt6ws2oh0BlSPDxQIus47aU48lxUPbF1P
 hmj7Vih1cMJ0Rbrl77fHbqOkPVs05FGsF2f1UKF0NnZL5Uktsh7YHwDwu0vV/JncVRM0r7P8D
 r3QYZZ8rhd97iZ0pp4AlWbel0H94q5csPGqBoPR56Eo/UqD5V8oVP32cZpej8fw0mVcLugzsb
 zEXxkYfiPIy7fI12nZm3X6N6+yZfkl+Ax/9bMR14iUT+y64dEQPUa5fQtWq13z4T538QAufMm
 AUHyBftOVtLlcIQTff4l9omKJ8rVKNSYIlAdZ58th5Q1rodO5gsLysF87Gohc+ZFxG9M+oSDO
 Wy2DIjcrEcUmaNpWQoG7bIXdDZCr1aKaeI0hqfgt4Y5xDN0kbt4qtgyjXHhYEkqbZVPPxkqoe
 LakubHf+LVglDqLIdLxWqw0lORBMzfUIy5AQVgilc8cKHQ4vJyVE3FCmouHmokeaq72uQkg2q
 +yb2+q8Mc5awLYQtbgDCnqq1ybciwiAC3LjCp+qGc9U8w=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> The sanity check that the platform handler had choices set doesn't
> need the mutex taken.  Move it to earlier in the registration.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index c76b8e3fdcde6..4e8a155589c21 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -179,6 +179,12 @@ int platform_profile_register(struct platform_profi=
le_handler *pprof)
>   {
>   	int err;
>
> +	/* Sanity check the profile handler */
> +	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> +	    !pprof->profile_set || !pprof->profile_get) {
> +		pr_err("platform_profile: handler is invalid\n");
> +		return -EINVAL;
> +	}
>   	if (!pprof->dev) {
>   		pr_err("platform_profile: handler device is not set\n");
>   		return -EINVAL;
> @@ -191,13 +197,6 @@ int platform_profile_register(struct platform_profi=
le_handler *pprof)
>   		return -EEXIST;
>   	}
>
> -	/* Sanity check the profile handler field are set */
> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -		!pprof->profile_set || !pprof->profile_get) {
> -		mutex_unlock(&profile_lock);
> -		return -EINVAL;
> -	}
> -
>   	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
>   	if (err) {
>   		mutex_unlock(&profile_lock);

