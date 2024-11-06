Return-Path: <linux-acpi+bounces-9341-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A173B9BDDAF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FE51F2455D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C919047A;
	Wed,  6 Nov 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="U79haMIq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2A190477;
	Wed,  6 Nov 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864246; cv=none; b=AaxzgEZVWMXgKEmwxQeyd6hjjgEwP4uGGc8eYyVMuHZF8qA0sq7kQ01l3WfPJ5ZbdiSDq2lHeHU3mOCXXq6UgI/RD41VHDkHyf2hAEp5BhmVXn7sZN/JWt5USc+XXrqzuYAQYVpLC1oeNvXEHx4dGaRGUfIJxnNXu1pSVhgQ6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864246; c=relaxed/simple;
	bh=fVEscBiNx3NYvSYMZAzwz1v9OdfNq3HmnA/CZ7wTgV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImYeoWLx51NWZB12/c8oKxp1451w1Tx8kjN9W1K4HIugfBa6oGKmCW7J26QNdpQNYcL1uI3bRp7jiz+d7VtCDnxp42Vl93I/39ICXz2r3M5tAS9XDwu47DUXZorSE6MFeTFGdagsThU5qiBEOn6iyL2Z/wVua1dV4XrD644DKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=U79haMIq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730864172; x=1731468972; i=w_armin@gmx.de;
	bh=EkiJ8wWxkSExNecsS48AgS+9rEfX9MAhCBoyA9fB7Yw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U79haMIqxx7Xbi8To/ItChYsydSBenBEtOF3aLM68GgYMxskwPc7Rfi/+ttf7MjQ
	 BWB4mPxB51tZW41jvZ60XCL+a0iEn/hSlVkIc9rXZ2N5+4QpWrUOJCo0NcNG6SEni
	 jdiMPOfIROSxv0mApT8MN617aucWCCBAuUOhskVqvgaFbkDz7NQ68OJ830zFtQ7Vm
	 1Sv+dslRxiofhQhzwZmLHC37EEFY1tL3FbtlI/S3oDOYwLQi5Cg7/WEROdViXP/aH
	 AgkZ29ouBRw9821pWbeBRJBtn1LvXG1QpYPmgUzhwebHP6YWEeDkjbD3q28ZzJS3/
	 YSQVrUF5fAtUjvPa/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1thJl90fK7-00nAvd; Wed, 06
 Nov 2024 04:36:12 +0100
Message-ID: <e7834fb2-bafe-4738-be9e-d6ad6a3dd32d@gmx.de>
Date: Wed, 6 Nov 2024 04:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/20] ACPI: platform_profile: Move matching string for
 new profile out of mutex
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
 <20241105153316.378-7-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-7-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WqvOoGMed2X4f5Htt/EKTv0KYNo8TsslzvKOHaTojpvwE6gtJaD
 bYygxda43zJ9SGk9IPrscTXW4zvwCghN/FBTwVC++MUzko5/H8STy6RybuWMLRDymxZ92cB
 i11jIvbruwwfOyLHRbqVPwyL3X3hD/epLyBUVZGA3XCNXZoT3d8jpiVR2likHeH1ClDPrLG
 zpbiMY9A5L4qkvg1qtD3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:woIV+jK18Iw=;0SnLNiythgPLTxS64BYJXXlVgao
 tDnckdavy6g0Y7hvLcJzmrZQ2Qb8EFb1vjIM4qigui4wIN486E0b0cz0UmxJQoeePOJicU1Nu
 QO0FB8Czgp3yjHtdo2oJnT6kH/MEpLDNv77sXy3t2yp3tqDZDjjKVyxYTIAI4ctqw/Eapdvta
 qFlrttPhTkFcmzOSIdvm8DTT1zXohTYFs8voKfma36LfOoHK3ZkqoE0784WqPc7umPO8IDsKV
 PL9EHABlll65B35Mjw+SHw1XtQVU2fWMIEXBNNcf+J9t8sVpePpPeF2m+6pSYtZqct6Ws7m9H
 U5tehNlU7/XN8mYYttmo1wAqhdKmJP8DdTmm8+nOkg9wwl0B6r3sNzXyBn1A8N1EeB3HQYnlB
 +MrkeHf9uiHDsXx83KyVvMsCKK4T7GasP5DAfA8iVlnMM1sPghdjGCen1hxb5AYUc1jF2YYIM
 pm5gF55LUARTbygbeK+5oHhIPEHPCe7A3RABMUOWsLhRFt+nUlAwqYY93cuyWpklmatdgnSpr
 KCPb7s54QpKfHPfjV5Q8u4+NZLTEUtx5BCFtGJS6dNSrU8hcPCAmec8djARCYtTknveqM1PMK
 e6KBHUu3jiI4vxymzxB3/xI40P7yJDy4Pbph86nDcraK8OZjK+lG8fikBf0cO5ThPGZ0taB7x
 I2GVfyvtLPLCvMdo+pV2/I4lOzXI2OTh6ECzrun3Yi05tDH+EHu4JMCdhafSw5NxrbsqaT2vx
 a24C8YCeJEMBrwhJuCXMfOxG/bpP0oYo7oNP9cY/J+3dO5CwWPXswpN4+zLtKZXOax+YgajnC
 xb6BPFhJfExbL8kPpOhAz0nGRV4trmP7Pq8d5pac5kYdA=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> Holding the mutex is not necessary while scanning the string passed into
> platform_profile_store().

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 4e8a155589c21..70e7f1ba68676 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -83,6 +83,11 @@ static ssize_t platform_profile_store(struct device *=
dev,
>   {
>   	int err, i;
>
> +	/* Scan for a matching profile */
> +	i =3D sysfs_match_string(profile_names, buf);
> +	if (i < 0)
> +		return -EINVAL;
> +
>   	err =3D mutex_lock_interruptible(&profile_lock);
>   	if (err)
>   		return err;
> @@ -92,13 +97,6 @@ static ssize_t platform_profile_store(struct device *=
dev,
>   		return -ENODEV;
>   	}
>
> -	/* Scan for a matching profile */
> -	i =3D sysfs_match_string(profile_names, buf);
> -	if (i < 0) {
> -		mutex_unlock(&profile_lock);
> -		return -EINVAL;
> -	}
> -
>   	/* Check that platform supports this profile choice */
>   	if (!test_bit(i, cur_profile->choices)) {
>   		mutex_unlock(&profile_lock);

