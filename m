Return-Path: <linux-acpi+bounces-9346-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E849BDDE3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 05:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8681F236DF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B314F9D9;
	Wed,  6 Nov 2024 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VA3X2yH6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D51362;
	Wed,  6 Nov 2024 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730866307; cv=none; b=e8f0Ife9zOxER/xOzFQ9qmPEmoWarAWBnfCzswhyT+WhrY3hyoIoPy1zmpW1ecZpufiDVTiHY+pyTB0/ZRV5EuCpC2I+SMh4qwmWiqxpa9PoMI0YosLqbwtWkzmZ9a1Py4ohICzPRztZ5/eFUWboHeNXc3MmzGDxiSAQqUV9p0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730866307; c=relaxed/simple;
	bh=6YPu+laV3kL4NBdAILOhBmO0hd3sVmscvAhmEbnseBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZqC8sZvzW95o2BduXlT3Ap0Ht6B7UFJBNYUUIhlUNXvNbqHvBxOgbtLmz9BJzqYqeNYnKr1EUzPcWerfBGHz5o07d0CD2j/gzdMN2MR8ZU7J/DH1Z9uHevpyQcnWpZq92B+e92OiYtCbxokTxmUBMahlh9mdj7DY4mkAPV8Ii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VA3X2yH6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730866235; x=1731471035; i=w_armin@gmx.de;
	bh=P90XY2NUw+OCYceZZLJRRm/ynfK6FT0y/3DCDJdVjRI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VA3X2yH6/kxysgwp4PrB0hWgC2BWy6qi/jXpen8JqekbE6tI/M0rH7Zdm6jfgg7y
	 sZ6Zxa08L8cgjJAfQy3FBcKPUmgDAP3pcNieVk5R0R+4gnYL94sdCBxeEzMkx2LIW
	 ftK7tbWwZIKivkdjz4Os78sa7KNow4PaQZTPIgxDiwG36TN/ie8+K9F8TyokTJhsD
	 Dt5dzj6bi7WQDzOHrlfDc1YrAgYz8pi6N7ppljLf4eP0reil+3kEccTwSkJcE+ux/
	 GRiNMb0/JIORw2fpJQ0Xkym1zAnx3+PcUlLjf+DB6JMZfTsWHHc69CBvOAG3zc77e
	 CHqE4wzIvqiOQ7w12Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1tdSOp3Chl-00ZTAy; Wed, 06
 Nov 2024 05:10:34 +0100
Message-ID: <dad36f32-5970-48c2-9ee1-78163958bf02@gmx.de>
Date: Wed, 6 Nov 2024 05:10:31 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/20] ACPI: platform_profile: Add profile attribute
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
 <20241105153316.378-13-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-13-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UIoLoCoMxfrOHXCBbg6f3jcJhJTAg3xcOjE6sneHRY+SBq3V+//
 5s+Y0upNsN1el4bpz6xUBWGa0MpBTxUkJVxzLwxPtxfy2OsX9TfN+yj/MCfpthmTFUQt3uE
 6nsa4ufMjN8Cg+ZxGiNwpHH0bIy1CCMmOx3sDorqG1fbsOBMdTbqyRdsDxqZ8IHiGuFXyhZ
 s5ItUai3ZbjyDG4C2ROoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c6IgiewnwMU=;MChqbM6jrv7UB2F6lD3CAj59QmX
 Ulk0PK4AisBr9psLp2+2zVGQpjUikUjrOayPMotZa4FJlVLr6kADHj9XJt0+d6mxhoysrVIyL
 UQLmpdTBiNJ0WmpMFHuHqfXXwrXzAflRr4WnP+6raB7UprG6uPLQUq/9sVdyLAW+GNmqDCr3j
 aBejgXh6OY1BPYO3L8nBfTkXjpW2RqrwB1ZzQLdUVTaFONbO4OqfyC/QfVdeqtcJp2PZCKRR2
 Quhmdf9Sq7GSuRuTYpcW5SYJBPezOeE/utdI7OFi045nWHlLbDiyuLAG8c0tkLyi12twUutXe
 pOneledG58r8RayzZbwIbgAxd8ytdgt2SA4zHv1fu3+8eCFzLtvrco1CS5DXpRsTfvWN5fd+E
 K7pO8sSQSidE1wB3yYlLlb2xWUVW9/m9OvaxwCxYJwrWE8VSOSpde+HFBTX5qJiC02BBCy+rY
 Yvcf9QLqRh4kotQWPo3UmUY/09bwknO9dMGf3LUIt1IOp2Xgekso0JdJj0haAPKBNN257qX/q
 tH1dx5lu3oNMesCJy5G+A2mQJj6Ths7MIZHdZKut1qeEfBsWb64XAxbcjkhkn3EqoqxYMLMy2
 rayk6NuTf96Wzurp2iE77hGshjdVD7UorMraS2iy4SZs/n1AuHQB3SF7odSSH0PYDr20pLXtn
 nRsUoKWEmd79wixIl01TnVifbMJim8JMYV5Hkn1T1IZH0Kp1D8QKdnBhD0f7zhYBKmA9pU0D6
 P8EzDu9YJKJCeOXdCi65Lfwlx9eTeEqno2Hg8BA+rcAaK/RjoVXE5+D4Hkqf3iOZ61ogabgMt
 LJELTInIWOOiTDUzODHcjBYg==

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> Reading and writing the `profile` sysfs file will use the callbacks for
> the platform profile handler to read or set the given profile.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 118 ++++++++++++++++++++++++++++++++
>   1 file changed, 118 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index e1b6569c4ee70..79083d0bb22e3 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -65,6 +65,78 @@ static int _get_class_choices(struct device *dev, uns=
igned long *choices)
>   	return 0;
>   }
>
> +/**
> + * _store_class_profile - Set the profile for a class device
> + * @dev: The class device
> + * @data: The profile to set
> + */
> +static int _store_class_profile(struct device *dev, void *data)
> +{
> +	enum platform_profile_option profile;
> +	unsigned long choices;
> +	int *i =3D (int *)data;
> +	int err;
> +
> +	err =3D _get_class_choices(dev, &choices);
> +	if (err)
> +		return err;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		struct platform_profile_handler *handler;
> +
> +		if (!test_bit(*i, &choices))
> +			return -EOPNOTSUPP;
> +
> +		handler =3D dev_get_drvdata(dev);
> +		err =3D handler->profile_get(handler, &profile);
> +		if (err)
> +			return err;
> +
> +		err =3D handler->profile_set(handler, *i);
> +		if (err) {
> +			int recover_err;
> +
> +			dev_err(dev, "Failed to set profile: %d\n", err);
> +			recover_err =3D handler->profile_set(handler, profile);
> +			if (recover_err)
> +				dev_err(dev, "Failed to reset profile: %d\n", recover_err);
> +		}

The whole recovery handling seems unnecessary to me. In setting the platfo=
rm profile fails, then
we should just return an error. The platform profile handler will tell us =
the current platform
profile anyway.

> +		sysfs_notify(&handler->class_dev->kobj, NULL, "platform_profile");
> +		kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);

Please avoid sending those events when the platform profile is changed thr=
ough the class sysfs interface.

> +	}
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");

Please avoid sending this event when the platform profile is changed throu=
gh the legacy sysfs interface.

> +	return err ? err : 0;
> +}
> +
> +/**
> + * get_class_profile - Show the current profile for a class device
> + * @dev: The class device
> + * @profile: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int get_class_profile(struct device *dev,
> +			     enum platform_profile_option *profile)
> +{
> +	struct platform_profile_handler *handler;
> +	enum platform_profile_option val;
> +	int err;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		handler =3D dev_get_drvdata(dev);
> +		err =3D handler->profile_get(handler, &val);
> +		if (err) {
> +			pr_err("Failed to get profile for handler %s\n", handler->name);
> +			return err;
> +		}
> +	}
> +
> +	if (WARN_ON(val >=3D PLATFORM_PROFILE_LAST))
> +		return -EINVAL;
> +	*profile =3D val;
> +
> +	return 0;
> +}
>
>   /**
>    * name_show - Show the name of the profile handler
> @@ -102,12 +174,58 @@ static ssize_t choices_show(struct device *dev,
>   	return _commmon_choices_show(choices, buf);
>   }
>
> +/**
> + * profile_show - Show the current profile for a class device
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
> +static ssize_t profile_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
> +	int err;
> +
> +	err =3D get_class_profile(dev, &profile);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%s\n", profile_names[profile]);
> +}
> +
> +/**
> + * profile_store - Set the profile for a class device
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to read from
> + * @count: The number of bytes to read
> + * Return: The number of bytes read
> + */
> +static ssize_t profile_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	int i, ret;
> +
> +	i =3D sysfs_match_string(profile_names, buf);
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	ret =3D _store_class_profile(dev, (void *)(long)&i);

Please just pass &i.

Thanks,
Armin Wolf

> +
> +	return ret ? ret : count;
> +}
>
>   static DEVICE_ATTR_RO(name);
>   static DEVICE_ATTR_RO(choices);
> +static DEVICE_ATTR_RW(profile);
> +
>   static struct attribute *profile_attrs[] =3D {
>   	&dev_attr_name.attr,
>   	&dev_attr_choices.attr,
> +	&dev_attr_profile.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(profile);

