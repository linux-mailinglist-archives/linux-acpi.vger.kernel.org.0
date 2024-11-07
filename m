Return-Path: <linux-acpi+bounces-9409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F09BFFE5
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90D81F230DA
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D71D63F1;
	Thu,  7 Nov 2024 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RUmvNlzs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E617DE36;
	Thu,  7 Nov 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967861; cv=none; b=KBsxMt4sjykVWpRH9TR9tJTPzNc4CoZhFVwkHCRxCFRyJxFdQBtrQ/fmyTfJDPsCqYR3N77rjPzh4rd1ssEdoWse/1K4QqwueXdV0vqwxaXB06nOIjSD2hE6TCg8LVHN+fJVMXGScXK5MONpr/zNIQhLRLU5vxmvsDjn7gV3rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967861; c=relaxed/simple;
	bh=uMvNaA/ePlBmRXjZMdlU5oo0/xFpHrVPTwkuIOutlWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjtQdulOUZZCoWyZAh+v9D82LM0Y7ziVVgSAL/4C5Srk0pqBRUb8RXKyjiDGijSzJ/e/gtrdm78cvzsK2yKyX+DXgeU9FFtO45pRAmyHhSx4DLj/DLNGm7emxTidOK3baUhCS2/B8mTtcusD8eFwgbxXDsMIFZSfIUN+I+d+wGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RUmvNlzs; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730967791; x=1731572591; i=w_armin@gmx.de;
	bh=ZEG/MbdQS87cskKIaGEnuiEp/Ez4BntccyTa0UvzKdw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RUmvNlzsixhavxnXL9AZKC7weLiV2B9xe7FgJlVG7ViJQd4CukhAuewICPa/OH4+
	 xR8M/5BoUxKNitxUPbHO9sQKkjTvCpSdA7w+uugO1KcwBX8jM6HdVT8gTBFZk4/ed
	 sY4hI59ZE+pgiaEeeC9M0Ht3NOd7wBeA1ClEM1g3lKLaaaWxAufz24PfmEb8eCB/A
	 c64O+7gY5OCOkiVxN6HXEnB/nRy61qF1ecs1lQJou0j0S8oUKQOLrJSVctffvB4NO
	 Q7j5sKZjS8bAxpCdgOhE46JoXjxk30nIHX1bISOXgBey2s9e3Of6hsqtEoAGeBI/H
	 8YSdAeMjibZQ2ChK5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1t085e3KzY-004nMH; Thu, 07
 Nov 2024 09:23:10 +0100
Message-ID: <d4281684-9055-4106-b357-79a0f415e129@gmx.de>
Date: Thu, 7 Nov 2024 09:23:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/20] ACPI: platform_profile: Add name attribute to
 class interface
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
 <20241107060254.17615-11-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Du+KHovG/eG7wzqIxlLkfpDlOjiCIg12lEitfgXBiurN+POORWC
 4G9B9ncLUeCwo8K2HAuZ7mOkUu+jYAAvIe5Du4RaOQTgjE4j1Z1wl/sYKQVlTthZc+1rgy/
 4HKa+kO3cY2mEFA7vf+5jvFh37S8LOH/pQEuQZnX/hs0sBxQwLQ0qQYYxaWF77nS9jdYqHJ
 YPE23NJStayhtTy0soFmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sz2qMhspmKQ=;tcF3AysUmLjblsDeFPRwO5GlhGc
 xhvEeP50z9YnpQz4pqW2HdOGw7hc5wdbBrRx9y+gadqnsEswQ18EfvcQWf+Ee7Y7WIlHeqJ8f
 atFqg688PdorCvzrQrNbfJU4CeKxjdUU5P/45REF3aLoYWNG1ZMQEj2PA6IQMWFf4rQPJubYr
 w1MV6P6y8EFIxC4G7uBxGNOsR1tDMQy+ICD9PvuDD3cysKf+Um4tDFniPcwGfOa1pvabBe0Xu
 /G257cHYKaXxxwclxCruJTAGJZq+iLb+tMdaOmYSIAHeHXpS5aCtC/0g8jPw5Jhe6bhLDPuyQ
 qGomldrgOnfEPE9ydqN8QKuG+QEm1Agb7DxEf039dwQNn1GVnVTAS0ZAlvXwlEI1deECq0U1P
 cBNAGnsBqlfp54WCB3nnEcZ/7WNej/Ja77mQCkAUeH5HkBX+v6KPIzXjx+YAxgq7dN9ocnSy3
 pd9Efbni4rRoXuPWT0lqScMNvyePpTg2+qrdxzE99uXFF2EUhHb9v+A8m5c2wEA5V2oQwoeSe
 o4NmZh901eZI1wlpcSDJxZfzBH6EH62gtvOMMQusVOCaB2gPv/xvVqNkBX5hOcX9CGpeq/cJ7
 5SPKeAx+IvReUuPc5s1hAiYe9DkOiTHjWA+uzYigd/URUnQ33isYu62u8zUj84XslNl70TU5L
 dpppUgBwDTwFvHnzUU7/4kxTgDjvjvLtCAADrk6OwhzU6pjDclAxZ+8VTWbaFNBN1U9DA2ixu
 DYI08QQhgXbZ4eA21oWFb9+89JZPjEUEXd/v9kil6FMzTwl9aaGS2xLOBeOVhBf+v7IVBOMyG
 KIKcBrlIgzdJE8XlZdUnAioJrbofUyB45rBffMz/7i8Lw=

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

> The name attribute shows the name of the associated platform profile
> handler.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Drop newline
>   * Add mutex for sysfs access
> ---
>   drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 9caf070f77f6a..f605c2bd35c68 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,8 +25,35 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFO=
RM_PROFILE_LAST);
>
>   static DEFINE_IDA(platform_profile_ida);
>
> +/**
> + * name_show - Show the name of the profile handler
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr,
> +			 char *buf)
> +{
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +		return sysfs_emit(buf, "%s\n", handler->name);
> +	}
> +	return -ERESTARTSYS;

Is the mutex really necessary here? The name remains static across the lif=
etime of the platform profile.

Thanks,
Armin Wolf

> +}
> +
> +static DEVICE_ATTR_RO(name);
> +static struct attribute *profile_attrs[] =3D {
> +	&dev_attr_name.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(profile);
> +
>   static const struct class platform_profile_class =3D {
>   	.name =3D "platform-profile",
> +	.dev_groups =3D profile_groups,
>   };
>
>   static ssize_t platform_profile_choices_show(struct device *dev,

