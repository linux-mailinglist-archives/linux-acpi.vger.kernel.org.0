Return-Path: <linux-acpi+bounces-9644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE99B9D1923
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2471F2234C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E0E1E282B;
	Mon, 18 Nov 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q/vJ9Gvp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC51208A5;
	Mon, 18 Nov 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959089; cv=none; b=bzl+TNkqvXqiyRDCKbvhhkRskNZhPMrNwlWamxSBUgQ6stb+LTG9Cw9eZl1V1iuF5j0ULzbiN8tXK0v97L9TlzURScCMsMB8ncP5j4OjKPsghlE14v46hNFaAKPScS6cw+i+hlRuAwijIX3f52egV15uJMZn6p4csuBurBJKfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959089; c=relaxed/simple;
	bh=kXrx2tuHXzG6zqKJf/ldwSvhGIKcUrzyYhCdbxq2ib8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV+LEh5yAj9JMrf49LKcC+0TLKP2pw00UlHr2bhE6Z6LIZcrakc88iGXLEJXS9FMj3LIeDmg0qjoE0mYQqRPnl388ptvSV9mtuLdQPefQT/CUsMyAFlsag5OxVQahaNy/BhpzhJKCvaRo+gyDDeqgKbYRmm5u3VZg2zGd/1rmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q/vJ9Gvp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731959010; x=1732563810; i=w_armin@gmx.de;
	bh=tV5hL5D0ROrcZB5RfomNudaieLV1d7R7FhGBk6hvO6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q/vJ9GvpU8pBXov4so1bwmoa52q33F/w0acElUYlMBi49/00PimEEQW6buTIjYr8
	 0ZEdbFv7YgMKzOd/7uzZto32C5QXtNmLBooPWC26GZfL4QxHXbkB/uzv70v894H30
	 fP755MxnYqYQqlHd9Rs3Yoy6BCCpTactkjWZ4Gt+3fzxVWcVueNFLBUXslZW/9iEO
	 KTMgoQTwGiWMjWI/QayCMzVwLyFOyQ/9yIXNgSjXoKGiUS6yigrf9qne65yWQROaR
	 rzcCiJCwZhCl0cD50Rk+B8Zgt6IFYhRxrwta8YJCWiZ6/KesnfUuGRW5xattIQLBl
	 z28C9QaC99hZG1mnHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1tCZgu0w0Q-0031dj; Mon, 18
 Nov 2024 20:43:30 +0100
Message-ID: <29899120-efec-4264-b6a8-0bca4fc1f332@gmx.de>
Date: Mon, 18 Nov 2024 20:43:24 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/22] ACPI: platform_profile: Add name attribute to
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-12-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-12-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VxhxbellbT2uTctR+qh8n4xLhZm4jbqzT7tFkOH2naPB+lY5pgi
 End6yBAiK0Xgif0J/kH9qTi6w7ZWTJUKiRsLY5+GCxqSZlef0TG7cPXRALTQpakNLe0t+Vn
 CeULztMd3ETKHTNoDkeEPA/1EMAEReMLxQ3eQQgDm3L1+MfOF9Smui4dUXCEPwz9gLv/7Xy
 rkTpqs1+VP6ANVCVY5h3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1MOoUObLSLg=;Dg0tW+UOjb+3DL0MMB+aj/1kLV5
 Le1Xa7afWMjyg003l3OUwajkSPwBOxIVEYEsVA2ZyEivHE2uYgKx20dZI21RiFElTRundGvx7
 sS63ZBl51vqHMYb6s69uXlyBSK1WeN4hnVCUx0WaiMxM5MK4kOsJOYP8tYNfktj15yRYL7676
 B9qivFC4iWrDjUnVbmlNXB7aguGblWTmPlChxQnRKh6BMYFmLFzFPRyeGDYYnwZE4smcuwQ5I
 EIiEfQv26gRRXYmyD30HB/buqxHyjY0FbhNDmj0kiY0F3oI0jvB0yd/N9j6y5GhIyTNtWjZLJ
 fBkyeiU9urHTRxAVCkZyxbVTmDMrnEspgeixeva3jH5A0szRBSn07P29SvIAQcB/2pGXAQvqR
 zvZVBunwho18wgiI1AIFPFvpkJDvAh7G59j43BZRBd2fvKr3eAnejCusSvOIN37k+bPI57Uiq
 +vfjmvav82WG32yW2+6dA8apJOazGTZrZNbvZoOCnbewvf61+7PsOzcrjxIFlpL/N+rTqDKpo
 np64yDMk9ML85bJvRUYgeF8ra9hccVDurodQUjmquzj/FIrddgYbCh2AUSEVkExjcYe+4jNOw
 JyeG7nxGED8IPdlGMeNUZOVuoffXnn3QhMYdVxCQpIHKPf7PP47WU14lTteaeyabjBC8+nAj4
 Rhy9jNF3lSPgi+1r9aJQW0bNFEs8lb3ZqEymyOtawJMvEhi/0JGQ238V99nn0efWMdAPpdqjc
 mZhurZt8ypgFPTzOpClv1pl1SANk+2dwzfsmlfbKwvDUYl5GO9gxGKZYQjWjCO4Ik8tIoV8HY
 Drq4hg4C61PfFE8jLlNwDltncaYanGAAS5v9VufRBoBKz0RvNNRZcRvyQHI++IGUdAfHEftAp
 9wxZJCG8HW/ZScKjIywII0WuxXoy+BCenndV5s+St0t828L5QfKY+NOVn

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> The name attribute shows the name of the associated platform profile
> handler.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index ef6af2c655524..4e2eda18f7f5f 100644
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
> +	struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		return sysfs_emit(buf, "%s\n", handler->name);
> +	}
> +	return -ERESTARTSYS;

I still have a bad feeling about the locking inside the class attributes..=
.

Can we assume that no sysfs accesses occur after unregistering the class d=
evice?

Even if this is not the case then the locking fails to protect the platfor=
m_profile_handler here.
If the device is unregistered right after dev_get_drvdata() was called, th=
en we would sill operate
on possibly stale data once we take the profile_lock.

Does someone have any clue how sysfs attributes act during removal?

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

