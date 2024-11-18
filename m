Return-Path: <linux-acpi+bounces-9646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579669D1954
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF7B2487E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043AB1E7C07;
	Mon, 18 Nov 2024 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iJPkdCh8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE21E767D;
	Mon, 18 Nov 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959563; cv=none; b=N8XJeIgeMi1vt5920pUcC0OrFKOK6thvW98ZkW+sAr3+DawrC+bBOZzFDBUgFZcrhDj9HO/4zYu8Rb4kfR1TBqiMhNOIAd2PfIsDZedHqEcvWKO5ScBogj5+p01Whbl+ZMHTVylfwhZR8Dr+nhtZ4JIAT6Gji9nAjdSri9W3L9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959563; c=relaxed/simple;
	bh=uZv+0wubX/s23E9dXOZuR76u0vkQGIX/X7/ZTBUZC14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqspYd1r9nGF5HEYQhgYxB+nwHBgxaOYcjqOVLv/R0mMkFvEDVw8XZQf6pDr5gQ9ZYbaVrro5gwQ5/cpjpx8R/fT1kxgRt1NpAA6pmM7SZuzKgKSEv6/Rr6RAlWlIGcMEXnF61kU/OdtNU88M0hMsL2FqeMVgiOlPeD2n7p4YI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iJPkdCh8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731959492; x=1732564292; i=w_armin@gmx.de;
	bh=B+J9E4Cbrs54WzKEoN7I2zMVCHs4mmNTJUbpk/uywjQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iJPkdCh8fZH1nR+L0TzP8nK/zeyZCQFi3iFV8pRG/Qjq+6n4LXLntHyGRG9mxNjw
	 O9KSl9b12MQ8H7n8Q2IajGEO30KLTzOX2ykwuGIPUD1I8CiayIkFAaq/h9hqDr0bH
	 bq+DM0CWeA4cxZbSgLXXCGs61+KwyMgsJji69sn120uLg+dF0Q47L8CH7o7ny84m2
	 ny033nCKDpnTQrfIhl1Tk/GnGhEy/7D+MJvi8YBdaRAibkyNJjcKuCpX/HzeTMNNR
	 KOzNMLY426Bt+Ur7r4FzPqW4pSFzqgF8MOQZy2nLZ6JOuwcTyvcA6Vw6q/FKxlJam
	 GyORuUHFwiWv5zXjSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1tsbWs2xrt-00zqsF; Mon, 18
 Nov 2024 20:51:31 +0100
Message-ID: <2ba6f23b-8efd-4b57-bf38-96fc3639ce09@gmx.de>
Date: Mon, 18 Nov 2024 20:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/22] ACPI: platform_profile: Make sure all profile
 handlers agree on profile
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
 <20241109044151.29804-18-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-18-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6KiPWyZ0QcsPf5S+JrxYr556nVcjBBJsuROnL+WKDKlUUKObA7H
 2XUvbB0ampStgqgnI7T4uJGrZz+xzgGxIH6j1b6IDUeCbkiEOn8WQP0oYnJkaBzwreJNh8V
 5GLKtNfMfQg1U89IUv/vcczYNuIW38axz2jtZLk2txizU5xsRufNQCreaNCBc9Hf0pUnmTo
 SFmbIyEGVqefeTm7+tALw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0fFtZEycOj4=;9/jy/Rw2nf+7L7n/xqyZSCFebsZ
 x6DkFOSYQ4KXopdVJgELh7+4TzjeVeIwMo8uVrfJ2m2cTYIf/wSr3j4bXsPRXQbwYCPG7Dgxn
 kZ98udDpP/cNAgZKrTeacdGY/UBqsvmGMmkPBO+hONglEWiZdHvNVU0EbNyPXQbWECnY/6mZj
 rr6wKNBvO8cE/d0nmTdQ3w5b1jX6Ipk8b/CoQExOTBWOQlK1CcsRmQ1jnO9mOJ9hG8J6zAljq
 QtCHUUw+5oFLNgu/Z94H4Z4QBWD6HFbL+M80G227+MqvgO6V/RIUKxmcxHVY7o/hfAyALzF4u
 1VGVP8Qgg3PyByTrAsL0tFvCoq4LCDnicy2ZOFlj1B+k9qkEqNyHDpmiWJiz29vgFpxO6gfV6
 qJthFuyC5fR8uyfpNRTpINi+gcQW1x3DXFj6bWbn/AZOsU3oqtmtFOGf0vS3CL1kwAWYIyq1n
 A4Xmi66ZBHium2AeXxEncGgilsSKm0L8LwdKaoY5+Zf/m+AtOsgQqkj4gYk9wmxzGhIhGeTD1
 Kz5ss/+NDgA3HoapaEi7Cn5x+nu/gDsQHpf+bMBZcIWDysirQwHbfZ+fONLlN7ArlYBeCllE7
 QQaab1vSi3vhf/1z0YzQnu36OY/ZHieaiuvKWTaoesAItqRu394lfkKJTdGlXhAaEcpB3V9mC
 10ynbQL9fHjSNLB8XVs1MhE/rqjj7FPjN+AsObK4JFFulsFyc0VhWYW7uivgD1IV9kq/Hp1LQ
 Azz/bGd+v3Rc7P/aZ84DZzETkILJhBsho3ejyZ9pTl0wvOkpSasUYuXSg2Ruwmlbqm9+flmKQ
 7u0zcIaB/DNidZTW9gzowJ95+IZsXVII8qAjfNk7oZRAl5ngCXBo9uHvHCO19U7BDxxCxIUvQ
 6qTCCdsMNdXiogSA7k1SGacBX8hWVQYF001Wfc4iaWJZJaaoK9n2IAb+D

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> If for any reason multiple profile handlers don't agree on the profile
> return the custom profile.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6:
>   * Fix logic error with PLATFORM_PROFILE_CUSTOM
> v5:
>   * Notify class profile of change to legacy interface
>   * Don't show warning when writing custom string, document in last patc=
h
>     instead.
>   * Adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 120 ++++++++++++++++++++++++++------
>   1 file changed, 97 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 089ac73b3ec97..2676f4a13689e 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -71,6 +71,22 @@ static int _store_class_profile(struct device *dev, v=
oid *data)
>   	return 0;
>   }
>
> +/**
> + * _notify_class_profile - Notify the class device of a profile change
> + * @dev: The class device
> + * @data: Unused
> + */
> +static int _notify_class_profile(struct device *dev, void *data)
> +{
> +	struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +	lockdep_assert_held(&profile_lock);
> +	sysfs_notify(&handler->class_dev->kobj, NULL, "profile");
> +	kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
> +
> +	return 0;
> +}
> +
>   /**
>    * get_class_profile - Show the current profile for a class device
>    * @dev: The class device
> @@ -257,51 +273,109 @@ static ssize_t platform_profile_choices_show(stru=
ct device *dev,
>   	return _commmon_choices_show(aggregate, buf);
>   }
>
> +/**
> + * _aggregate_profiles - Aggregate the profiles for legacy sysfs interf=
ace
> + * @dev: The device
> + * @data: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int _aggregate_profiles(struct device *dev, void *data)
> +{
> +	enum platform_profile_option *profile =3D data;
> +	enum platform_profile_option val;
> +	int err;
> +
> +	err =3D get_class_profile(dev, &val);
> +	if (err)
> +		return err;
> +
> +	if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D val)
> +		*profile =3D PLATFORM_PROFILE_CUSTOM;
> +	else
> +		*profile =3D val;
> +
> +	return 0;
> +}
> +

Please don't use multiple blank lines. With that fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +
> +/**
> + * _store_and_notify - Atomically store and notify a class from legacy =
sysfs interface
> + * @dev: The device
> + * @data: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int _store_and_notify(struct device *dev, void *data)
> +{
> +	enum platform_profile_option *profile =3D data;
> +	int err;
> +
> +	err =3D _store_class_profile(dev, profile);
> +	if (err)
> +		return err;
> +	return _notify_class_profile(dev, NULL);
> +}
> +
> +/**
> + * platform_profile_show - Show the current profile for legacy sysfs in=
terface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
>   static ssize_t platform_profile_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> +				     struct device_attribute *attr,
> +				     char *buf)
>   {
> -	enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
> +	enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
>   	int err;
>
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -
> -		err =3D cur_profile->profile_get(cur_profile, &profile);
> +		err =3D class_for_each_device(&platform_profile_class, NULL,
> +					    &profile, _aggregate_profiles);
>   		if (err)
>   			return err;
>   	}
>
> -	/* Check that profile is valid index */
> -	if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names)))=
)
> -		return -EIO;
> +	/* no profile handler registered any more */
> +	if (profile =3D=3D PLATFORM_PROFILE_LAST)
> +		return -EINVAL;
>
>   	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>   }
>
> +/**
> + * platform_profile_store - Set the profile for legacy sysfs interface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to read from
> + * @count: The number of bytes to read
> + * Return: The number of bytes read
> + */
>   static ssize_t platform_profile_store(struct device *dev,
> -			    struct device_attribute *attr,
> -			    const char *buf, size_t count)
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
>   {
> -	int err, i;
> +	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	int ret;
> +	int i;
>
>   	/* Scan for a matching profile */
>   	i =3D sysfs_match_string(profile_names, buf);
> -	if (i < 0)
> +	if (i < 0 || i =3D=3D PLATFORM_PROFILE_CUSTOM)
>   		return -EINVAL;
> -
> +	set_bit(PLATFORM_PROFILE_LAST, choices);
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -
> -		/* Check that platform supports this profile choice */
> -		if (!test_bit(i, cur_profile->choices))
> +		ret =3D class_for_each_device(&platform_profile_class, NULL,
> +					    choices, _aggregate_choices);
> +		if (ret)
> +			return ret;
> +		if (!test_bit(i, choices))
>   			return -EOPNOTSUPP;
>
> -		err =3D cur_profile->profile_set(cur_profile, i);
> -		if (err)
> -			return err;
> +		ret =3D class_for_each_device(&platform_profile_class, NULL, &i,
> +					    _store_and_notify);
> +		if (ret)
> +			return ret;
>   	}
>
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");

