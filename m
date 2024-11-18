Return-Path: <linux-acpi+bounces-9645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DAE9D192F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 20:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A79B2147C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6771E5709;
	Mon, 18 Nov 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="IiBq7uFW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694E54652;
	Mon, 18 Nov 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959292; cv=none; b=dq8ZSlJHNHRr2f4vWI/XnItNxb/17pu6PMKozNZUv5vIE6rIkluwCgmIBSkt23qV7SYZT4vsdMp7v9a9Kl22X66paR67IqNdNfxKBSqE1XsKjQHZpGMrQOch1mFchbhvqRTazaxla4MYVBGtJj4+Bx97bbQ0ZgJtm/gj7QIbq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959292; c=relaxed/simple;
	bh=I5EKQ6IoPl+6sAbwtKOqULMwEsmGDM/QiBbDmX6/Q5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eq0pKDfe8o2TY8jhx9RvfrezrYHrm26GsjodQORbii9P8qhPwqNjg90jFrZhltmtSTYmHs96wGjVQLTi4ze3k4FOQQt+xylpW+O/w9O8Q7HfKbJqo+Fqk0nl3BALpWO4cjeL6819Usz6GtSuEAbBHh4pTYxbJ/lWtUq53EvJ/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=IiBq7uFW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731959210; x=1732564010; i=w_armin@gmx.de;
	bh=YklYbPj7UASZ6h+Lqunttl3PHWwy72kXfoaSd+gemrk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IiBq7uFWID3EiLX9c4D/MEGro3sQcI7eR1gJOvDKY/DApH92jVe2W4lHI4F9hSKn
	 f3DjYx0DHnq0sAxBLiEuAZv+XVtx6YTl3dBY8OW8wJ/RwkQiga/wXbdJlkFo7kng+
	 kGt7/4IT/gKpdUvX/0oTtPn4z/3euKElsjC12nWiVe/d9IZ9ZZ+yE3/eDHh3u4QJA
	 vbKXVxJ2dGaktGKvsq5zsBViq0b+SUWLfZeO0ICfOlcL8lJl2tQU7oDxMryZTgyGe
	 xIpKrTqVtOzoexygpc3FECEt2UENT12SVSaya2sF16IYPfRF3jkIGePzoSFxFrJdv
	 dWmshpod1by1bwX8jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1tFOuA0JwW-00VCta; Mon, 18
 Nov 2024 20:46:50 +0100
Message-ID: <1db4d806-4c83-47d9-9d88-24f0c1d99506@gmx.de>
Date: Mon, 18 Nov 2024 20:46:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/22] ACPI: platform_profile: Only show profiles
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-16-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-16-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JAPUl7oydNusLNQfXiwon2BFWGySPwk5wxjy1Rr+kqyopdO7/bV
 nlj2nO19e+dcRz0p1856jKBhtW93Qv2nk/z2w1+s3GurQISGEAxKL2FKHw8KlPfU7Wiuked
 633fXMHcPMbKqYNPwBR7eiDD9h2q1Pf4JRmdNlOT7C0oIGY3bVSOLf7bKyxFvoPGuQF+BX+
 wz3dZs7MiEKrdqLzCwoUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2TDNtXok3B0=;O+Tv6ET/P/PsSeVPXUzj/RvZzTU
 sFA8c75nkMPWDykNpTzQey4DwH7CvPewtgJclFXWdFVGy0rhRXRdeeEs24i0PbSAVKY/u+fxS
 6Tm6xwQt6Zk4ptoLc3NayxedGxUWxpPfM2JhsfwhrFY00juaCA2CyQ0C5H8R9BGljzr8qBjVS
 2ej3t+c+r5ozfrhtkcJnMCDJ60tzfKPzV9az9R+k8YIfsCwpn+L/hCIzt+kdCnfFnORn7BuXW
 hqc4PlfsweDAGXgbuXQWiaweITvIn1vnEAxPYEKzS8c1z70dtUn7CpHRVhKHaB94lxLZquzfx
 3S8IF5DXI+MPE/ZFA9Elp04oVda0zFjm3737zc2F7wpPd3jIDIWm+jJMiweYpIwsFiPEgNqhK
 G+ET0r9BCd5H5xZ3hQihmUX1GoGUiORjLqvYHZCy2amn8W7e4YwaiF8goVjw3Y10pR2Sm/pbJ
 N4ZMTRIWPVfKEBTuTtQHZUsM2KT43usNIOPfoZhCxuA182g0sHv0iFC34yL53fy2iv/HJTPIl
 QpCfHMx24Hsz1c/VrTlFjTkqz7x8X61C17L5Pw8JPxRutq5GPdkMtJms+G4qsWYSVkLz/nRBi
 8g9YrJZuOS5p8m70alZtHO23bnni+a+pGRnXtQTqSL4+oOEaVohHdMoKpGB9+11MZRp9piG6V
 1NH0kPY+W8TF5n/ZTf/FPfahv+xd/05VWVljmgpNX0BR3tKRtpgvzFR+5676C4iyfLiQL73il
 E04vMncsX3zokvYIqdApKLSz7s3YM2Xtq4kcB6hl1cMkcYMKsbvPW+TQtVQETEx5tDVqcTPeT
 dUQB6fYxvWMvqJPYJULoK/yTFXzlEfEFf7hOeqNw03Xn0qaQY4V7xNSCF+drtuMFpPkKdmsCy
 dIRw+SWxMeHctiRottwXDrrkaV1mKBFGaj9IHZgXWhLxXHzSzG7Ff3gJx

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> If multiple platform profile handlers have been registered, don't allow
> switching to profiles unique to only one handler.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 56 ++++++++++++++++++++++++---------
>   1 file changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index c4d451782ff18..c4e2c75116988 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -206,26 +206,54 @@ static const struct class platform_profile_class =
=3D {
>   	.dev_groups =3D profile_groups,
>   };
>
> +/**
> + * _aggregate_choices - Aggregate the available profile choices
> + * @dev: The device
> + * @data: The available profile choices
> + * Return: 0 on success, -errno on failure
> + */
> +static int _aggregate_choices(struct device *dev, void *data)
> +{
> +	struct platform_profile_handler *handler;
> +	unsigned long *aggregate =3D data;
> +
> +	lockdep_assert_held(&profile_lock);
> +	handler =3D dev_get_drvdata(dev);
> +	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> +		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> +	else
> +		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_L=
AST);
> +
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
>   static ssize_t platform_profile_choices_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> +					     struct device_attribute *attr,
> +					     char *buf)
>   {
> -	int len =3D 0;
> -	int i;
> +	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	int err;
>
> +	set_bit(PLATFORM_PROFILE_LAST, aggregate);
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> -			if (len =3D=3D 0)
> -				len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> -			else
> -				len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> -		}
> +		err =3D class_for_each_device(&platform_profile_class, NULL,
> +					    aggregate, _aggregate_choices);
> +		if (err)
> +			return err;
>   	}
> -	len +=3D sysfs_emit_at(buf, len, "\n");
>
> -	return len;
> +	/* no profile handler registered any more */
> +	if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
> +		return -EINVAL;
> +
> +	return _commmon_choices_show(aggregate, buf);
>   }
>
>   static ssize_t platform_profile_show(struct device *dev,

