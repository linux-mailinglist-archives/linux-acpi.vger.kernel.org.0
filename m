Return-Path: <linux-acpi+bounces-9619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FD9D0563
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69931F219B5
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F581DAC80;
	Sun, 17 Nov 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="e2cu+iqp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81191DA631;
	Sun, 17 Nov 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870780; cv=none; b=BN5RuL8+p9AlFItg9q1tfVKhg6XAold5/yZ74qeO/7hFwRPQ6aSyHb6YK5ZVdFd29d01zMCWihAwp09T+QhCwWdrgS3JYRbuC5L5xJwMD7Ti8kHI727R/Hg09XGD5lerVlsLfNR5UiO6ugMA4BB9/Re0ECVZlZ5kr80VnZRr70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870780; c=relaxed/simple;
	bh=Y4N7t1EfZ3MaRCXJJIBZ/TUwT0q4D+3Xt4LyI4Jo9No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0mUcc1WTtLnFbZhQhwdvR+7Y6orZsfZltzD3rdVPoIGY9xru1OnPMcBxcMRR4mOWTDxx7NWoyVCQ/2fnNTJiErWW9oGesuTJu3+T0e/laFwQTJK7ecfDfXw0T2sqBsq9gTQGWx2U36oNHduthBcZoo1hGMsXNxLm/jsBFbppkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=e2cu+iqp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731870694; x=1732475494; i=w_armin@gmx.de;
	bh=71WMjWGhKcTAVDj0+8UsTMVl6YoF26oHy4zZuaVwg1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=e2cu+iqpsFclwHiQy5Pyx+IQ3TAhYqyO1hQACViMimeB7uTSMJgGMGE/8HydHZZR
	 7Pm6CX5a270T8UBE1R7Uqv4b0ae1nqpvhSdq/v5rUKqm9T2qEs/Lo598oERTy4mj3
	 36ickL4uy6hLFvkmWUzGSLqQ1hoWJYtTEV9DyRjfgR7M2hfOawbvZ+mC+yYCo/zxn
	 E7XNLHDCFu3cI+vfqCilPKhHd3yKZeaN7Yghq/5NJS8vXl2e3ciT4woUdc3HmdAM7
	 PvSG57kD6yfNpFT8lSao+pmURdY3qVjqn4qMD8paa6fExJt9wHXJU4ZDD5dOTWNtA
	 wBih+2fiSwdRAE7tjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1twqnG3aUV-00vylG; Sun, 17
 Nov 2024 20:11:34 +0100
Message-ID: <88f8571c-a8d3-4dda-a56c-74df6ca49af2@gmx.de>
Date: Sun, 17 Nov 2024 20:11:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/22] ACPI: platform_profile: Create class for ACPI
 platform profile
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
 <20241109044151.29804-11-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9GenvAZY0kftYUUUOwwaVDgBTZSOzJcGSAbo+nwt6KgFu3QHcXg
 iBJPrpZgg2dhtPRhcxHVYk0JGcM7dwDblhThRTP50o6wxY8TUDHw/1sIs8Vv+vKbkXRGxMA
 GwfjUMqDcTKx0LD+igG9JzQPHem6Kamc14s3Os3Wd9uDqe3cCy59qjL7faapEYlqdwH+Mph
 amOxtA8ewiIg/ZVRPvk+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N4JoaJ7DV48=;n7hrb/1tBt9t/CmtAUv47pfDcsp
 mtpQibLc+KbUJTY35Lwq0hnNKvMMMiYkO5Wg9F2phWXQVu5fgFNZ0Uk1T0289u8ynfJiM+NOw
 QBWIKeMPVt91LT1E7iwUHh+vxk+bL2C5TJSkEgRiYySgAiHJlkY7xWWe0WdUxECWC7g9qYQDb
 HpsZbu+mgfiW/LjvaWZ9AP33exEFFUYdaB0mBhnX9BsNCAWNnY8d1UthALUdu+b+UHCZHKAr8
 BfWPh+RlRGMk5p8KbeYExKKU1JEVdsy/KgIUmAiiiGPqEmdoo2rA3u74fFe810GOvAo8z42/R
 h16pjl7B33s/7CugY25EiCpbjC+Ceq1WOYW/7nCkRB/ERj/kKb3nWcXHodLI+1A0503WXZHsX
 o3g0Liiya3VZsT4B6U7U3w1vDgPQvZyUH0ohrpUG4T/CpCuHWggm6FQHp7LlDT0GJ825y0atT
 ZhA9waaqWj2EtmnjKiORpvJloIK0eWCytsAKc1q8fVt1fzgAmhDEcIYKOYFsqefXmyVIaE6gx
 BH6UzttKM5NuTWngHfqe1A5oErlQtAVbEqbWr2fQtp7ZcgVfGJ73xAp70KsepABH97gE3SuQh
 OyHHmRTgWgZK/w1ZL+G17/a3gzY6fBChKphpx0v4+QYiegZobLXbs6d6885HL36FSTscN0D9j
 EpRhqsD7sEog6vi2MpeffaOWTOy+uG4GXXAhXQFTc0PuwXaikCxt1bOmMoB0mpASEEcSlIJsM
 SpsE1jV3x7Wz5SnzEzB2OSIiSVbzMata8u6vGGO4CI8ClyL2TBE6SzoNZEKDq9GLMcD1fLhsT
 sAizDhVwD5O51aiH7hslLiJZ87w2+DYxML9mBadtdI0fFpVSy4pTbCoNYbxiTzWAkBqtXVIsx
 XW4voUTv75PtUfinuJT27bbzIVCcb2/RTMmt/JvcpcC0EPQnPN3X/z/NT

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> When registering a platform profile handler create a class device
> that will allow changing a single platform profile handler.
>
> The class and sysfs group are no longer needed when the platform profile
> core is a module and unloaded, so remove them at that time as well.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6:
>   * Catch failures in ida_alloc
>   * Use 4th argument of device_create instead of dev_set_drvdata()
>   * Squash unregister patch
>   * Add module init callback
>   * Move class creation to module init
>   * Update visibility based on group presence
>   * Add back parent device
> v5:
>   * Use ida instead of idr
>   * Use device_unregister instead of device_destroy()
>   * MKDEV (0, 0)
> ---
>   drivers/acpi/platform_profile.c  | 88 ++++++++++++++++++++++++++++++--
>   include/linux/platform_profile.h |  2 +
>   2 files changed, 85 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 32affb75e782d..ef6af2c655524 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -5,6 +5,7 @@
>   #include <linux/acpi.h>
>   #include <linux/bits.h>
>   #include <linux/init.h>
> +#include <linux/kdev_t.h>
>   #include <linux/mutex.h>
>   #include <linux/platform_profile.h>
>   #include <linux/sysfs.h>
> @@ -22,6 +23,12 @@ static const char * const profile_names[] =3D {
>   };
>   static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
>
> +static DEFINE_IDA(platform_profile_ida);
> +
> +static const struct class platform_profile_class =3D {
> +	.name =3D "platform-profile",
> +};
> +
>   static ssize_t platform_profile_choices_show(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
> @@ -105,8 +112,25 @@ static struct attribute *platform_profile_attrs[] =
=3D {
>   	NULL
>   };
>
> +static int profile_class_registered(struct device *dev, const void *dat=
a)
> +{
> +	return 1;
> +}
> +
> +static umode_t profile_class_is_visible(struct kobject *kobj, struct at=
tribute *attr, int idx)
> +{
> +	if (!class_find_device(&platform_profile_class, NULL, NULL, profile_cl=
ass_registered))
> +		return 0;
> +	if (attr =3D=3D &dev_attr_platform_profile_choices.attr)
> +		return 0444;
> +	if (attr =3D=3D &dev_attr_platform_profile.attr)
> +		return 0644;
> +	return 0;
> +}
> +
>   static const struct attribute_group platform_profile_group =3D {
> -	.attrs =3D platform_profile_attrs
> +	.attrs =3D platform_profile_attrs,
> +	.is_visible =3D profile_class_is_visible,
>   };
>
>   void platform_profile_notify(struct platform_profile_handler *pprof)
> @@ -123,6 +147,9 @@ int platform_profile_cycle(void)
>   	enum platform_profile_option next;
>   	int err;
>
> +	if (!class_is_registered(&platform_profile_class))
> +		return -ENODEV;

This check is pointless since the platform profile class will always be re=
gistered during module initialization.
Please remove it.

> +
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		if (!cur_profile)
>   			return -ENODEV;
> @@ -164,25 +191,76 @@ int platform_profile_register(struct platform_prof=
ile_handler *pprof)
>   	if (cur_profile)
>   		return -EEXIST;
>
> -	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err)
> -		return err;
> +	/* create class interface for individual handler */
> +	pprof->minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> +	if (pprof->minor < 0)
> +		return pprof->minor;
> +	pprof->class_dev =3D device_create(&platform_profile_class, pprof->dev=
,
> +					 MKDEV(0, 0), pprof, "platform-profile-%d",
> +					 pprof->minor);
> +	if (IS_ERR(pprof->class_dev)) {
> +		err =3D PTR_ERR(pprof->class_dev);
> +		goto cleanup_ida;
> +	}
>
>   	cur_profile =3D pprof;
> +
> +	err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
> +	if (err)
> +		goto cleanup_cur;
> +
>   	return 0;
> +
> +cleanup_cur:
> +	cur_profile =3D NULL;
> +	device_unregister(pprof->class_dev);
> +
> +cleanup_ida:
> +	ida_free(&platform_profile_ida, pprof->minor);
> +
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>
>   int platform_profile_remove(struct platform_profile_handler *pprof)
>   {
> +	int id;
>   	guard(mutex)(&profile_lock);
>
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	id =3D pprof->minor;
> +	device_unregister(pprof->class_dev);
> +	ida_free(&platform_profile_ida, id);
> +
>   	cur_profile =3D NULL;
> +
> +	sysfs_update_group(acpi_kobj, &platform_profile_group);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_remove);
>
> +static int __init platform_profile_init(void)
> +{
> +	int err;
> +
> +	err =3D class_register(&platform_profile_class);
> +	if (err)
> +		return err;
> +
> +	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> +	if (err)
> +		class_unregister(&platform_profile_class);
> +
> +	return err;
> +}

Please use a blank line after function/struct/union/enum declarations.

Apart from those minor issues the patch looks quite nice, so with those is=
sues being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +static void __exit platform_profile_exit(void)
> +{
> +	class_unregister(&platform_profile_class);
> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +}
> +module_init(platform_profile_init);
> +module_exit(platform_profile_exit);
> +
>   MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
>   MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
>   MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index 8ec0b8da56db5..a888fd085c513 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -29,6 +29,8 @@ enum platform_profile_option {
>   struct platform_profile_handler {
>   	const char *name;
>   	struct device *dev;
> +	struct device *class_dev;
> +	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	int (*profile_get)(struct platform_profile_handler *pprof,
>   				enum platform_profile_option *profile);

