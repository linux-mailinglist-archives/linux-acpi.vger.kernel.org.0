Return-Path: <linux-acpi+bounces-9343-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF829BDDD2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8051F24682
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8058190051;
	Wed,  6 Nov 2024 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Jd5XyXYW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8024B26;
	Wed,  6 Nov 2024 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865278; cv=none; b=ZxwczMQ+A6t3h+kb3L/rP5jaFVMX1zRj5+L6k7nxt441rzB25GBkRbC3G9k5SG8I6l/83jimZLCiJNWIAqC4yxHpE2YkZ3OaPwORIajOKl0575n+RXK7Hj5OFGRZL89tm+9vi80oM1U8bd6wuaUmB9biFF45PihhS2ePJEC8nnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865278; c=relaxed/simple;
	bh=n8W7i1QoNRW0bxithfb76wR1PuFtWiYUYEicPKghLk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpknVqbRm1+OKZgBzHi0GwRME2jI3rynIaCYvSTc+Mo8SV4whm23dTqzYol5DmgVWA48x9DleCpLLoSSN3HxhOHcbeKTDk+hdznMBBD45E2SotWW+YDGnC48gHx2WAbTIQ078MuP9wD4yZxcXv+THtydXUHeQnucvprATVUxhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Jd5XyXYW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730865202; x=1731470002; i=w_armin@gmx.de;
	bh=mYmXa8qY5Wm2rPUzSUp5NHS/VQC49mO6TPZbBU+VG/I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jd5XyXYWUGkAAJ1Q/NDM+zxv+EfHxRUGz56WbL6vqojP3QTPCOchUq+MguPtrTeu
	 SHAvR6HJ6dv87KvHOKHRQjXKo+oHQvUL9X6HrKLYaf8nmFfm2OLbRhbhtXp6AGV61
	 L2MSm+lMW7vux1TGb0ZNJfYP0QJiIFsbXmY84FHUo1PAP9aC5I96eKhIIjg/vbRvh
	 aoWCTXpTwcYzf17E6uCBaCNgH+OjGXauxi1EWs9wnv97EXzvWG73B/pbWyjyAbVTo
	 oD06kcAnfA5aqeAsoY1rcyIuq07zAxMRj40CO1JMhr+FELoAejdVOBMUxkIWkrYN+
	 E16r56Xul9hgCkYcHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1tKomt2GHl-00Kwb1; Wed, 06
 Nov 2024 04:53:22 +0100
Message-ID: <bb054a10-1020-4eb4-a09d-219b71bad5ff@gmx.de>
Date: Wed, 6 Nov 2024 04:53:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/20] ACPI: platform_profile: Create class for ACPI
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-10-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:96wBMdG4pY7dSBD11GeUdbsnlDgixTArRngPQ0LlmgIOzBZVSvx
 OV1F48cy1IoyZ4V5DThYt22HUxB23vZUg8Osr2Hyg3WO1aLgE65wBNdjdzD+F/vgon1Z2Dr
 wBDhfyaeQr+cZxKk7GMUPU1mN1D7L/PzCyoAwW2lzFtU/HgZKbLfSxbSBUTl0F2boraALoF
 NLhRU3+gPdw50zB3872Qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ui2Umdv1rOU=;Wnd6nBAytwVOI0gyO9HcmJvqes8
 pcGKZeFu/LjVU5EhPYDXmVEE2K+/5ChxMmjPH+NnkuatJvnVa+mcnNI0my5mHBOevse7o0T5Y
 ddccJBZHEnyufcHdmFl9E6M00T7jC/Umkisr4Px3SImUA8DXfVbH08U+LJRzLZ4Rn3XbAc0Ig
 Y262H+fwOME3w1DsFzQBUXstdbGMxSnMiTyDMI42Z8NIswPCYbE+5D+FRGEYz+BsG92yLk+zs
 7VLrBF8npHOzdPKq3z14XomneymIgaRXwmWxmDuTo1KJ0/2HVZEJNywb3Ob+G9HSMdaPDpROw
 zwSaJ9BnCc1Bc2kYbHtHbhkg1+BuMWC6huiXsH8yVZ8i5sAahPiV5btWby9zUuHTJB1RWcCpq
 +ju5+jMFNBl7tISP+avnWA++xd1a01aAE6K07jn7hVNHus/974OBFgIKCgKd3OJfhXcvBMRLP
 2pj1la5BRcNXHubPVrY/5/gj/YOp4xqyveG2a5UkFw1h211O81CCUDpo9yZhOit14eH1q6Cbc
 oHbLQp7w5Z3191S2vQWI7ucRcexFb2aPXzecODjG1yNX5kMmPVkwj3/AmNKLClJjZANEaCRIb
 Q/PmAlLoYM5tO68iLWd+eNf/pmuicFWy6M2Icz5U7SSUc8vXjryycxCgNClWjYnGokoNK+szk
 HUj5zfLQk7vtNUZhyOG81Dl8hpIRPcp6bqm90BIn7fPesz2BUlOIt1hu+c+KQJ4Or7nmlWIZC
 Vn9poKWN3ofKnSC4QTgSDD0Z9x8lJLIdGW7ijZSzOxXa3cjMjazvwnTXD8ub0USFdwjlUDuvg
 xg71N2Wmq2uFUrUVy8nVy4FJJJHniivtlxnLoT9/WOA3A=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> When registering a platform profile handler create a class device
> that will allow changing a single platform profile handler.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c  | 42 +++++++++++++++++++++++++++++---
>   include/linux/platform_profile.h |  2 ++
>   2 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index fd1c4e9dccf0a..f8e9dc9a10d54 100644
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
> +static DEFINE_IDR(platform_profile_minor_idr);

Please use a IDA instead, you can take a look at the hwmon subsystem for a=
n example.

> +
> +static const struct class platform_profile_class =3D {
> +	.name =3D "platform-profile",
> +};
> +
>   static ssize_t platform_profile_choices_show(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
> @@ -113,6 +120,8 @@ void platform_profile_notify(void)
>   {
>   	if (!cur_profile)
>   		return;
> +	if (!class_is_registered(&platform_profile_class))
> +		return;
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
> @@ -123,6 +132,9 @@ int platform_profile_cycle(void)
>   	enum platform_profile_option next;
>   	int err;
>
> +	if (!class_is_registered(&platform_profile_class))
> +		return -ENODEV;
> +
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		if (!cur_profile)
>   			return -ENODEV;
> @@ -167,12 +179,33 @@ int platform_profile_register(struct platform_prof=
ile_handler *pprof)
>   	if (cur_profile)
>   		return -EEXIST;
>
> -	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err)
> -		return err;
> +	if (!class_is_registered(&platform_profile_class)) {
> +		/* class for individual handlers */
> +		err =3D class_register(&platform_profile_class);
> +		if (err)
> +			return err;

I think it would be better to register the class during module initializat=
ion. This way userspace
applications can depend on the class directory being present if the driver=
 has been loaded (even if
it might be empty).

> +		/* legacy sysfs files */
> +		err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> +		if (err)
> +			goto cleanup_class;
> +	}
> +
> +	/* create class interface for individual handler */
> +	pprof->minor =3D idr_alloc(&platform_profile_minor_idr, pprof, 0, 0, G=
FP_KERNEL);
> +	pprof->class_dev =3D device_create(&platform_profile_class, pprof->dev=
,
> +					 MKDEV(0, pprof->minor), NULL, "platform-profile-%d",
> +					 pprof->minor);

Please use MKDEV(0, 0), as we have no associated character device.

> +	if (IS_ERR(pprof->class_dev))
> +		return PTR_ERR(pprof->class_dev);

You still need to free "minor" in case of an error.

> +	dev_set_drvdata(pprof->class_dev, pprof);

Please use device_create() for setting the drvdata of the class device.

>
>   	cur_profile =3D pprof;
>   	return 0;
> +
> +cleanup_class:
> +	class_unregister(&platform_profile_class);
> +
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>
> @@ -181,6 +214,9 @@ int platform_profile_remove(struct platform_profile_=
handler *pprof)
>   	guard(mutex)(&profile_lock);
>
>   	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
> +	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));

Using device_unregister() would be more suitable here. Also keep in mind t=
hat "minor" still
needs to be freed. Again drivers/hwmon/hwmon.c could be useful in this reg=
ard.

Thanks,
Armin Wolf

> +
>   	cur_profile =3D NULL;
>   	return 0;
>   }
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index bcaf3aa39160f..f81c3afcb7575 100644
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

