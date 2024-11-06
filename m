Return-Path: <linux-acpi+bounces-9376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF49BF842
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666B51C22B38
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A320C489;
	Wed,  6 Nov 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KRPz24c6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669A14F9D9;
	Wed,  6 Nov 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926770; cv=none; b=ZmzNpvr3AlzLYem6SWUuQgpGNJY44qO1YwSxwYCeUCVf5jC3cr8n5axUvf9uuxrI7WV2VuADMMA4BLPp9P1fJzTBD1qzGe3JXAK+IRMfR8jcbprcY4rpxeJWCi7uSAMuNYO9W5V5OZjiEWxZolPg8aYTX61XMoiwjVNgeLQqZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926770; c=relaxed/simple;
	bh=XLCDMd7ciz35QR/ham/cIEWPwfp1Kdq9Agnq2FNhYBg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ofpb7KDs8S7WbU0RipMGqsh6vOI8q14jt8DkKEyxdRqfP953Wmbp08kcXeEEn6JUQWXfmMlmaSM9aD7+RQZ9flwy9vzdLoo0Vd94c+hP+CHjS9zHfJuE8xEaWxpwrAX93fCPT23t0oB568xJNddZ1xWFxjr2d+ZnpWaQraN7nOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KRPz24c6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730926697; x=1731531497; i=w_armin@gmx.de;
	bh=f64O5SeeguIhDFFVO43b0ng+qApTOFN/1RVAqsvMJ0c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KRPz24c6wLzcAoRocrZ0Xq7XLQgQKpoAX2Cq1lvfOc1mv0Kz2wsK4ouiECCPHoor
	 Xrq8hJx6tcukzFs9kIPQHWn9Y0VolLptDpG2g9U/IUjVJlckVNtRE+3Z/x5Eykdfj
	 +LW+eS7Cmbrrnn9Nmw4lftuz8jgwQ6EnJIOltNAeFkN7BeWUKreJjlpN6DO6g2yi1
	 oxGH+I7YiNIDddOrpPXX8GSUguQ5/v7CuJquwQvcNoCiRgTHRaZLUUtVGTr/y4dOe
	 yvJ7Na7ARaQTfHuJVi48CSJcUfc2ACDTbx75q8/YXMP0tIyR5+LQn9EMC5cMwUvXc
	 hiXKmKymaYUyQcKkyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1tboj03iPO-00ZM5a; Wed, 06
 Nov 2024 21:58:16 +0100
Message-ID: <a2bde9c6-6aa3-445b-b27b-2338d78d132d@gmx.de>
Date: Wed, 6 Nov 2024 21:58:09 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4 16/20] ACPI: platform_profile: Make sure all profile
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-17-mario.limonciello@amd.com>
Content-Language: en-US
In-Reply-To: <20241105153316.378-17-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnrJjE2v6RW09QLQlmqJMIZuysujbEAw61s3H6+dvbxToEL1eNs
 pCOm693I/KRnk26JlqV5HfKOVPETI9Tb2yEL6MND0gPBfQiu/f9cQBaEhTme2Lwn1u5XeV7
 FJzOZaNXc5j5yWXhZiBMqp4mCSqR7m7RwUKqQWljxU09bCFKBX7gKgsoYo2aZEMZNuNTqHl
 ZL1A4ECV/wG8aT2/AXEFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4luOdEoGEfg=;WuN8fjlZkJqvUYmedeaVPL8go9J
 fUaHvnZJC5aJfLwyIyv5jpZuEsYI+4/6dvjPt+KUYRiFvXIvtc/u2sp2Pzuh9Dj3fml4/eCM8
 uD/jYovHNu9yDTisU2uWoHVsoD5Xzu0l1jTM4HXA4ItCCoERY08dZ+CKAzOdYNDcnkbKl8SQ/
 KkEQmTyRg73h+Q41W97J9VmuQdB+hTxFhwJGjuA15bzQruq2ECLN/jCEn68XV5euOQUGPUEU5
 OmaWP8gXObqCbHTsOcgNSBGXf9/3K2H6eP92XXYR9p/BK4vZ1L6bu0AjbvyygXt214ygntDv3
 dYnRayBY3DdgVwBOJuoViR2bNzpOJEHlTnoDePdyKl9MoLZyKUAqXM2ZALMIbacJo0BHdFSQ3
 3T68NrUOJ90/ajXtKafqmQl2Enr8ZDyXOwZqt4J7lK2I5DO5vCPYpgp91x/nUN1twKDH0o1WE
 tJGObYarXqnHugJ1qG/A8mmgXFUcfvLZ7o+0WV9yIuQEwv1/T8FSAJlG84CTDNRO9WUdyRaa6
 dJ8qCO1R3zm3t+y90ZXsdGSz0a05BUf3Ak2karjfKhGnldEfsgk55DjLxg120++GcFJSK1pf3
 YXsKQ/j4fmcG+Gl/Yyw9bP8Qhb3JoydnPTAl1xORk4EaHe56nCdIzWqT2VdxpebaBtkjBjCe9
 WTGoTmHITS8AdgUMR0S6fUyg8jugsptfXT4Sx7cVy3uELW9p6PzJSMwnAph6PR98oTWlpwKL8
 l1PsWq5s8BzbGJaz9tJew52vIH6CtG7trFisNkYNs4ybSPm26FUJgLfE+iDG+38SxqSYnLIMW
 DkEbIhqKsMuBRT+RT0+oWhJKSJBIeTzwkhulfBEFwFZLji1/jfLS5wdTrfomVgnPe+lY8nQRl
 CzvKwnni7Uee9u451UghRT87xLR1I8mIbd9V6t8TfTpblq8pHV0m4HjwK

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> If for any reason multiple profile handlers don't agree on the profile
> return the custom profile.
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 84 +++++++++++++++++++++------------
>   1 file changed, 53 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index d8c2d195106c2..7861fccc2e58c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -280,55 +280,77 @@ static ssize_t platform_profile_choices_show(struc=
t device *dev,
>   	return _commmon_choices_show(aggregate, buf);
>   }
>
> -static ssize_t platform_profile_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> +/**
> + * _aggregate_profiles - Aggregate the profiles for legacy sysfs interf=
ace
> + * @dev: The device
> + * @data: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int _aggregate_profiles(struct device *dev, void *data)
>   {
> -	enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
> +	enum platform_profile_option *profile =3D data;
> +	enum platform_profile_option val;
>   	int err;
>
> -	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> +	err =3D get_class_profile(dev, &val);
> +	if (err)
> +		return err;
>
> -		err =3D cur_profile->profile_get(cur_profile, &profile);
> -		if (err)
> -			return err;
> -	}
> +	if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D val)
> +		*profile =3D PLATFORM_PROFILE_CUSTOM;
> +	else
> +		*profile =3D val;
>
> -	/* Check that profile is valid index */
> -	if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names)))=
)
> -		return -EIO;

Please check the returned value from profile_get() first before doing
the custom platform
profile check.

> +	return 0;
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
> +static ssize_t platform_profile_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
> +	int err;
> +
> +	err =3D class_for_each_device(&platform_profile_class, NULL,
> +				    &profile, _aggregate_profiles);

Missing error handling.

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
> +	int ret;
> +	int i;
>
>   	/* Scan for a matching profile */
>   	i =3D sysfs_match_string(profile_names, buf);
>   	if (i < 0)
>   		return -EINVAL;
> -
> -	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -
> -		/* Check that platform supports this profile choice */
> -		if (!test_bit(i, cur_profile->choices))
> -			return -EOPNOTSUPP;
> -
> -		err =3D cur_profile->profile_set(cur_profile, i);
> -		if (err)
> -			return err;
> +	if (i =3D=3D PLATFORM_PROFILE_CUSTOM) {
> +		pr_warn("Custom profile not supported for legacy sysfs interface\n");

This would allow userspace applications to spam the kernel log. Please
just return -EINVAL here
and document this special case inside the interface specification.

Thanks,
Armin Wolf

> +		return -EINVAL;
>   	}
>
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -	return count;
> +	ret =3D class_for_each_device(&platform_profile_class, NULL, &i, _stor=
e_class_profile);
> +
> +	return ret ? ret : count;
>   }
>
>   static DEVICE_ATTR_RO(platform_profile_choices);

