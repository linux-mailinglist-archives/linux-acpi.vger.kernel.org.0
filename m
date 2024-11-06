Return-Path: <linux-acpi+bounces-9345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303CA9BDDDE
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 05:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13102846EA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27F7FBA2;
	Wed,  6 Nov 2024 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="r9kHJmhN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07A1362;
	Wed,  6 Nov 2024 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865671; cv=none; b=YVJ+ScuvMomIw75Ymp1P3zkbE3kA+/OEkDRXaX7iPllNS6MpKUyZpQFM2+blhjRSx1GSXlJJLTYOMCQ30UZzFXFd9bIaBdjFHVi689QbR8EfyfauSVKBq80TC8Uou6VvWrk+wr/4Uo59+UURJnVoWNURFiPNymCwWdAAHztlplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865671; c=relaxed/simple;
	bh=ykHSkhanqUA68PwK4xOi6mE3bFrG6IuldaqT1U4YaDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CakG2rmMI010EWGZMPxn9wPGudP3nozfMH2zs62XAl1ieI+FYgsrF/iI5/7VAwAqfWzpxDCQ2smVVkzZOJJezyFE94YEHpnVQ4y6MvfOJeP7I+UPjLqfErqLRj2vJqye/TcrJMjH1vWXoGT35Teg7SxdrgKkyFxpwTwx7kfVoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=r9kHJmhN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730865604; x=1731470404; i=w_armin@gmx.de;
	bh=sSu5xj8EPzGmkuISpEXh9bDDRmYd24ewIYle0BJWLI8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r9kHJmhNEpZZs6TqfuRG/3ZwKhnZsUMgmNJOfBkY2OhdQw0dg8oK+Ak3dNkUVb24
	 fGOasUQJGN+gmPzHdba7no+4mxVTZrMoyosQSEMaOPFWra861iK1oqbNv2RvBGALZ
	 TrgDCykEO9L3e8bijSX8m6l4cwqgoxjd5om2zL3oy6E8WnoGxsB+o+jdqSVjYCY2F
	 7mYjvAzvewpDNx3yM0Ro6NfmNueFK2QCgKNoab6ZLP3SjbY5417lo+2oOD37iO31b
	 GnvUF62qHLGTzPyoxRJucG5j2r5fyL0F0RKZGEDE0kBE34N4V/olRPdSIWSP01/n8
	 VTqCHQQMDJ8Kn2qdOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1tXNmd2oGN-00cfHs; Wed, 06
 Nov 2024 05:00:04 +0100
Message-ID: <cdb7523b-f37a-4b20-a1ab-8656dde40e61@gmx.de>
Date: Wed, 6 Nov 2024 05:00:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/20] ACPI: platform_profile: Add choices attribute
 for class interface
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
 <20241105153316.378-12-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-12-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2wlgp7nTc1JQE0GDdRM9ndeGK6gJ1x1dIN1fiqP7DW7BX3j2A1
 XhqKrHCqDLe6N6DsVVQmTJjEfhxBWIiTZb+o6mFjzKdVYMA6vcYVg/7Muhlbp5/GDbwTYYY
 hpZ4PwFWqovN63OnNW3O3Ga1sRzKP4KEMB7ZT+IH2q008n23dDmf/2B8J3Lqj04VuPxxD86
 hmG0gSYE2rtXoUqBoMAhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:voOlv8cLmEU=;enAmOGYuvkLuTiOD4KVbjDTl0tQ
 GRjPiWgmqnnED1W09jgefVGEY++coFTQa1n4MDrXmGD+PkzBeAJXG4kCz3Qsh+5wwfMobgQzY
 l7iRSWDg5Mf+rozz6Vi404F8Je87bB/z7rF1+MiZAg70bfFk/uaKNJUuGMv+jRP4zOCAut5bu
 Kq2c9yOLHALUSufS2eCJGDkY2DLdgi5itf9axMRKgBgeB6u4nB5fBsWMmYoK7o1CsSG0/Om8a
 AMIqG4rnMLKdsdi8pPs6UeqmiQnhDt0etUORFP83LGtMXCZIFXzr05Dcs89LuBSbcMMY3hYim
 8tlI43s4dCL7/J/W/GL7sKYMVu/bbsaiBkm8b7U+pSBnqrHtAZilVTeBm0A/jm8O1t58m2chg
 thcGY99Kh7d7VlideVND7jSieIQ9R13ylQ87E8CndlPQcglgJ/jx6yBE1F0fsjs6zMsu/csSp
 3akn50ojbKqJ+GFtB7cuJqZ2hrsoD6vSnaut88NPd2DOwkcdSSMQu0jDc7vcHvVE/16RXMq6W
 TAIVDLaDQye1nR8OgkX5oL3sd93vgZjRr3i8BZKy0Q/yrafLodfZENBRUpczM1aDfesJYizPD
 kAApRlSuqw3Xl9IEjkg7jxHwispp85RZ9P1mL4bKSOSpcoRdbXpkmG8UUOfanKMXHSgipKqy3
 DRwjfEI1QD9NpPueBwWemx1CxnNBFsFeACLF+DMD9VRCyc1biQOcTv9AVoYU11osH1LX3DzN0
 fo+l8QF/CdZYdNjn4Ff2qIfUZZprBY5+OrdYr8bII1GyYcK/Y8gjsbsx817ZonBbhMqSUZVb2
 NGgJ5CYuohhPyIYdSIwoUG8WW4WRChCoXnhU01E66dALE=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> The `choices` file will show all possible choices that a given platform
> profile handler can support.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 63 +++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 986bd636be226..e1b6569c4ee70 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,6 +25,47 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFO=
RM_PROFILE_LAST);
>
>   static DEFINE_IDR(platform_profile_minor_idr);
>
> +/**
> + * _commmon_choices_show - Show the available profile choices
> + * @choices: The available profile choices
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
> +static ssize_t _commmon_choices_show(unsigned long choices, char *buf)
> +{
> +	int i, len =3D 0;
> +
> +	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
> +		if (len =3D=3D 0)
> +			len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +		else
> +			len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +	}
> +	len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +/**
> + * _get_class_choices - Get the available profile choices for a class d=
evice
> + * @dev: The class device
> + * Return: The available profile choices
> + */
> +static int _get_class_choices(struct device *dev, unsigned long *choice=
s)
> +{
> +	struct platform_profile_handler *handler;
> +	int i;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		handler =3D dev_get_drvdata(dev);
> +		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
> +			*choices |=3D BIT(i);
> +	}
> +
> +	return 0;
> +}
> +
> +

Please don't use multiple blank lines.

Other than that:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>   /**
>    * name_show - Show the name of the profile handler
>    * @dev: The device
> @@ -41,10 +82,32 @@ static ssize_t name_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", handler->name);
>   }
>
> +/**
> + * choices_show - Show the available profile choices
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + */
> +static ssize_t choices_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	unsigned long choices =3D 0;
> +	int err;
> +
> +	err =3D _get_class_choices(dev, &choices);
> +	if (err)
> +		return err;
> +
> +	return _commmon_choices_show(choices, buf);
> +}
> +
>
>   static DEVICE_ATTR_RO(name);
> +static DEVICE_ATTR_RO(choices);
>   static struct attribute *profile_attrs[] =3D {
>   	&dev_attr_name.attr,
> +	&dev_attr_choices.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(profile);

