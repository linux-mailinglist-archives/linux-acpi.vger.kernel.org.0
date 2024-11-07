Return-Path: <linux-acpi+bounces-9411-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063909C0017
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC38283302
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489A1D9A48;
	Thu,  7 Nov 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HUfajbAM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40151D7985;
	Thu,  7 Nov 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968543; cv=none; b=ZnsFZ6xGSLE0ujFU7f7F+SKjiy95FwpXWmZhoQYzXMBHsPPgVE/ANMsU1dSHHy67H1rnP6A5GZZrWDuh3mtCqk35WZ3apqqk3Pl2c6eBHjOFco6rhwPd1TR6QTMb8bFNbQ6ZZFDKvAQRYXj/Jmf+zpbkJSgTu9MztkSUkXTP2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968543; c=relaxed/simple;
	bh=Z5KLkTLHm01/5YkrCANL88BChYJrB2n2yk28VszbLX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J77/2bFWeQsvAoJg81BdljRVWdqNHZssDox+0ITI6UcQ1horQYdzOteZGPTkdo0a8grMR3/A3XhQJPBNukpu7pqBZzRC0q2wwnEsCh7upM07xxHakqphz/Kir5YwWoL334OB7dpqH8A8b95xDTb1Su05UEM+7jCZDE7/xpwl1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HUfajbAM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730968469; x=1731573269; i=w_armin@gmx.de;
	bh=vnDMbe2/92vk/ssj3bfhjF1Ml+JXamQQax1g3Zj2Fmo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HUfajbAMtMozeAqfrhtu3ctDpxgCJAQX9D8N0Gw/uWgZmVbBZUHMYG+MZ2NZIoQx
	 gpiqPGGZ5dzUXfgg0EIdK/lprpwc2tTq6/aiqG9qVURqH/bnsq7E071BTGdNuCor3
	 jAknxAz7wtBAm7DGAV7cRgMD+USO/ZHdp/EerCylpG2378hik2t/PXnmpRCTdz+Bk
	 0cG+Zs/wXh32wcAY2uEP4JLAnJ5uaXtcZe9BbP8lusBfKLusooIN7yn9YoM961Ox6
	 e3OI4DHh8E8HYd7JGqTB1+3qcMybf1lftR5cJ2bEL5H/8yKCs+kmB0pIXWOb49O9e
	 RTkfAoydLEnHuAQxiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1t53xf1fZS-00GHjJ; Thu, 07
 Nov 2024 09:34:29 +0100
Message-ID: <f5967c2f-1a33-4f5d-bae7-1864d931301c@gmx.de>
Date: Thu, 7 Nov 2024 09:34:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/20] ACPI: platform_profile: Add profile attribute
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-13-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-13-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BjCGjiYR5zzoxg6BLJSYLlZA+jn+PAdhOESkFbaECJQXXtxaPhL
 fO/XBRgpxAzRWgJ3xwbkCaspwJtht3zMnE5p9NxjGQ4oTUSFR8NG5CMxcvRGjWJaI3HJGOu
 cxBuzZT/en+JyjlieYd0lAntLl5KYwgRZR2n9Z9bLK8L+GsWXBIb5PrzJJRDiSXdzFGaTc9
 2JIzuBE2KuHt4HoS3SLIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rwWtd53/qec=;QQiZISZi4cTZdAu4dr1rEgUgBRy
 DqU5pym4S0wCsbTVr8ubkjavCfXxKnKLvuf/uLQLzSGCFyytjDgCprvU1KYlICyil2SCallY4
 OgLwOSgxf7iWMM+YXsOUaO2aAgCkAja0+5BprFJz7oJz4bynD5CMEUi2B51NnKX+P+7zjD+g0
 JIer19lxBCgrDkYNMPD70rG5juepy0nkfXCX1OQAzoNqjgODuWTTVHmRQTM3fWDrInyL6Y/mn
 sIwuZBZkWuhv+HB2Uh1yqpF0DPOtb5ToWlUtI1aSZELzAnLRBI9GdioCutNiJ8lOSxlUIBVa7
 9CcX6o5x3OmVyT8XUSGYpF5961yajCaZORVhG4xd4R3jftY00btNnhnyU7aR9MVjSV8ZQA2oX
 xk/BBYMVzATwnU6osB9zuczPxgbI3h6KMK7WKQLeGakpkGhgoHmM//yUqpTMxm1yXwxrR90zt
 lqkkav08m5W2CHbhAxPR2LTfi9aV28aumAy/GMxuDLFOFQApgsdrOzqX6HkrSUfY2SQ8KNrsP
 w3i+F5G42jv8PPxpiaPD8rfcu1VvCa/p7TF9iZzir+rNCtO2p36eYXo9y0oYIjKJZsvwiGEQN
 XAHnTlTvgGGVLrJgY7Nz1rxH8UN81B2OmMgpyFVaNRnyedgnN239n0ELUaDI63kRiJYRY38ke
 BKr8hCdUiShxwH1KdZzJDqjiBcpN35uze81VRqmVC5SAGkIKxYAs1zCGvq0mf/MEV9gT9VPjb
 dQCjZWcn27eFeBbaX9oH3GmC5Ug+vfC34rG+s+jXkt/s5P/0+CzUBFtOKxpHQ4aJq1CzXiiF2
 iogoigWK6S1Y59GT/17XanTxGxilRroKQ72lohH7p6h/FDTZU80WaHYrCyWalJrBkqFGzJDf+
 MqKZfK+fjZKp6sJhPcj4/L10B2KBRFCv/ACoc6QA82VA88DKlFoO7vNW/

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

> Reading and writing the `profile` sysfs file will use the callbacks for
> the platform profile handler to read or set the given profile.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Drop recovery flow
>   * Don't get profile before setting (not needed)
>   * Simplify casting for call to _store_class_profile()
>   * Only notify legacy interface of changes
>   * Adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 110 ++++++++++++++++++++++++++++++++
>   1 file changed, 110 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 5e0bb91c5f451..35e0e8f666072 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -65,6 +65,62 @@ static int _get_class_choices(struct device *dev, uns=
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
> +	struct platform_profile_handler *handler;
> +	unsigned long choices;
> +	int *i =3D (int *)data;
> +	int err;
> +
> +	err =3D _get_class_choices(dev, &choices);
> +	if (err)
> +		return err;
> +
> +	lockdep_assert_held(&profile_lock);
> +	if (!test_bit(*i, &choices))
> +		return -EOPNOTSUPP;
> +
> +	handler =3D dev_get_drvdata(dev);
> +	err =3D handler->profile_set(handler, *i);
> +	if (err)
> +		return err;
> +
> +	return err ? err : 0;

Please just return 0 here.

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
> +	lockdep_assert_held(&profile_lock);
> +	handler =3D dev_get_drvdata(dev);
> +	err =3D handler->profile_get(handler, &val);
> +	if (err) {
> +		pr_err("Failed to get profile for handler %s\n", handler->name);
> +		return err;
> +	}
> +
> +	if (WARN_ON(val >=3D PLATFORM_PROFILE_LAST))
> +		return -EINVAL;
> +	*profile =3D val;
> +
> +	return 0;
> +}
> +
>   /**
>    * name_show - Show the name of the profile handler
>    * @dev: The device
> @@ -106,12 +162,66 @@ static ssize_t choices_show(struct device *dev,
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
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		err =3D get_class_profile(dev, &profile);
> +		if (err)
> +			return err;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", profile_names[profile]);

AFAIK we do not need to take the mutex here, since querying the current pl=
atform profile
should not change any state.

Thanks,
Armin Wolf

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
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		ret =3D _store_class_profile(dev, &i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +	return count;
> +}
> +
>   static DEVICE_ATTR_RO(name);
>   static DEVICE_ATTR_RO(choices);
> +static DEVICE_ATTR_RW(profile);
>
>   static struct attribute *profile_attrs[] =3D {
>   	&dev_attr_name.attr,
>   	&dev_attr_choices.attr,
> +	&dev_attr_profile.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(profile);

