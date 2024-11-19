Return-Path: <linux-acpi+bounces-9656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E89D25FB
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 13:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CFA280E83
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180121CACC8;
	Tue, 19 Nov 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RzG7Eqzg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D513B780;
	Tue, 19 Nov 2024 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019777; cv=none; b=r99Yqv8Sydf1gerf5ugQdHxwJEHI7odzFrmLTYgVd0H8+A1unHy6kEiy1poEWDCXuLAi9gfIbCqTiRkMknTscGrBIFvk9bH/sjQWyiy5fkY4dv8SLSFqkM1odnMuEVvO/v9SZEai7SAfs6tuSOBgckH45eBGWkm8zWI6469J2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019777; c=relaxed/simple;
	bh=42pVbvRM9/bjgLh5vQiRdHWwVKK7rawwp6Bs5KoqcN0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CYl32itwVTGwD7kLBcAFtFcqIcWezVrNpPtjvWUjjz84JtYaMB/0wTZ6AeNyLocbL/NW8SNpgWWYygZQ6Pu5ZYmJaac7SRUcKc/HyjeJRX8ACrfKMHfaxrq9hDrXEqv7og03hA6p3GqzD7eHmLBFIL/UHvySp9IXWJR0Yx3IV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RzG7Eqzg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732019706; x=1732624506; i=w_armin@gmx.de;
	bh=42pVbvRM9/bjgLh5vQiRdHWwVKK7rawwp6Bs5KoqcN0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RzG7EqzgSy96AUqGjJfvJD2SRmGZuHkREhaIY+nRknEBx54alvOQLM0APn84mYkN
	 23SOqgtYgbudV2gbJcjpgL/OtCWyzNjm0oTsYfjin6VPMwcvu3UPVK9J/mUfY7P7z
	 hDQr8q6fF5v0XPFda2i8L+Dxhq5Ew+0W1hUtNqvoUUvo5wMDg0DmTpUS6FT05p/xo
	 Clt0ySQY97kilIYMwPHTQlASxUdRAFWSI9JOsLv3BkRgsQgucyoPLWQGgy1vvpJJQ
	 zwxo3magO66ex4wLp8XlJZuBcfeilTWlvwk0WWuwmmJjoRpKVmfMiaGogh1xeQR6p
	 wQn11k4hqmyIhuWrLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.87.225] ([141.76.181.126]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1tRkV40XJk-00VSZh; Tue, 19
 Nov 2024 13:35:06 +0100
Message-ID: <b5b942fd-9c64-48a0-9c3d-64d841994299@gmx.de>
Date: Tue, 19 Nov 2024 13:35:00 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/22] ACPI: platform_profile: Create class for ACPI
 platform profile
From: Armin Wolf <W_Armin@gmx.de>
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
 <88f8571c-a8d3-4dda-a56c-74df6ca49af2@gmx.de>
Content-Language: en-US
In-Reply-To: <88f8571c-a8d3-4dda-a56c-74df6ca49af2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GC9bBfi3JuTV7lQhVTlpSMqeRPtH2/ER7ZPnjfMNpHwZy5GtU+w
 QZtJ1uUgGR4U7nBgzccU6If4Cv8CrCcfmxvqe29wysD6oESqxnw87IHRfydHsu5ZhYmSnTQ
 3vaoMrmc0zEZykVzuYw2RNh4e8km93dwMDHciED4+bPxEUVqkI0/hjz9/ZbPN3rNBCPnzit
 x6i1/xklQSY1y2yjtmNQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QI76JElnipI=;32FqBcmlUDm1OZ3f2PgpQJuA/o0
 ghCgTnoCqp15S5oYFpcJ8w7o9UlhFzTly0OWckgziJCdERI9+zWQ32R4TZaJNDI0gUot59wJQ
 C3qiLL9qd5NvrfyQ9tmUgLR7RMMurVwUX/vYdO60Q0xKELHvTrGRNMNM3p93FGeAYocUO6Fj/
 IVgk8MjYLUu/INVxtFu/d+Qb4Wkj3sq+phG00ArVJS6f6JZTR2oAjKD7JKg/owJxK93ICkgQO
 qkDpQbOoamxGC5LXMBmnfwygvdYrAY4ws0TQhb2Hk2mj0iPw33iRvAwM8MgqB4hzxYyP1xSvc
 WoQEHBioUwvOvZy6i3mbvUrZ04LlCXXZUmGqdTTwcxGTFEJr690yCCB8oAs56xlqUoMQl6JuW
 S7+ZmPV/VjnskI87AItj7FnfTQb7u61XiCcyxVHu2pDw2PwT5+zL1Bypz5GbFB/pBtxkqjig/
 kAmUcnR8lj8/lAonamuB7OXZX33ZlvW6Oz/+N9ZCnethUfncgm3msH9mF8C83ukfN+xbyR573
 T52fg/E4c7J2afwIIYB5AHKNn/wakdRGCBj7dOlErKghwwIvnyOc7/LZHomwMimcnSzXLBgGO
 69W32fMwk2cmqA6OQqUb4grOyNegskH6WcoFgJeGVN2sGKQViRwvjc+6fM+NeH7r8v8M4JzAx
 syjFAeDUawgJDLIwNIqflb5zNkGgHAhD83X/4YPoCjXavDWWkpxPl5P1rU7nYVUhwpffEh8Sf
 EwG54WdfJx9+TdGrkr+W16MM+3+vRrzwt7JX2ww/2qxSIjY0oHL1gK9jPusDO4DJ5+VXo6AOL
 5e7qPR6vipN2rgjv7Viz1aNXbRQB2qrK8KWQJoVd07iiMLpFtYRAIDLtGs/vdVhplBbj1ySyL
 EDKEeaes5DRNen/eY9CGiYEQj0CAgjruz/BLNWti7L0frqu2KragnUxof

Am 17.11.24 um 20:11 schrieb Armin Wolf:

> Am 09.11.24 um 05:41 schrieb Mario Limonciello:
>
>> When registering a platform profile handler create a class device
>> that will allow changing a single platform profile handler.
>>
>> The class and sysfs group are no longer needed when the platform profil=
e
>> core is a module and unloaded, so remove them at that time as well.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v6:
>> =C2=A0 * Catch failures in ida_alloc
>> =C2=A0 * Use 4th argument of device_create instead of dev_set_drvdata()
>> =C2=A0 * Squash unregister patch
>> =C2=A0 * Add module init callback
>> =C2=A0 * Move class creation to module init
>> =C2=A0 * Update visibility based on group presence
>> =C2=A0 * Add back parent device
>> v5:
>> =C2=A0 * Use ida instead of idr
>> =C2=A0 * Use device_unregister instead of device_destroy()
>> =C2=A0 * MKDEV (0, 0)
>> ---
>> =C2=A0 drivers/acpi/platform_profile.c=C2=A0 | 88 +++++++++++++++++++++=
+++++++++--
>> =C2=A0 include/linux/platform_profile.h |=C2=A0 2 +
>> =C2=A0 2 files changed, 85 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c
>> b/drivers/acpi/platform_profile.c
>> index 32affb75e782d..ef6af2c655524 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -5,6 +5,7 @@
>> =C2=A0 #include <linux/acpi.h>
>> =C2=A0 #include <linux/bits.h>
>> =C2=A0 #include <linux/init.h>
>> +#include <linux/kdev_t.h>
>> =C2=A0 #include <linux/mutex.h>
>> =C2=A0 #include <linux/platform_profile.h>
>> =C2=A0 #include <linux/sysfs.h>
>> @@ -22,6 +23,12 @@ static const char * const profile_names[] =3D {
>> =C2=A0 };
>> =C2=A0 static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_=
LAST);
>>
>> +static DEFINE_IDA(platform_profile_ida);
>> +
>> +static const struct class platform_profile_class =3D {
>> +=C2=A0=C2=A0=C2=A0 .name =3D "platform-profile",
>> +};
>> +
>> =C2=A0 static ssize_t platform_profile_choices_show(struct device *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_at=
tribute *attr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>> @@ -105,8 +112,25 @@ static struct attribute
>> *platform_profile_attrs[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>> =C2=A0 };
>>
>> +static int profile_class_registered(struct device *dev, const void
>> *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return 1;
>> +}
>> +
>> +static umode_t profile_class_is_visible(struct kobject *kobj, struct
>> attribute *attr, int idx)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (!class_find_device(&platform_profile_class, NUL=
L, NULL,
>> profile_class_registered))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 if (attr =3D=3D &dev_attr_platform_profile_choices.=
attr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0444;
>> +=C2=A0=C2=A0=C2=A0 if (attr =3D=3D &dev_attr_platform_profile.attr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0644;
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static const struct attribute_group platform_profile_group =3D {
>> -=C2=A0=C2=A0=C2=A0 .attrs =3D platform_profile_attrs
>> +=C2=A0=C2=A0=C2=A0 .attrs =3D platform_profile_attrs,
>> +=C2=A0=C2=A0=C2=A0 .is_visible =3D profile_class_is_visible,
>> =C2=A0 };
>>
>> =C2=A0 void platform_profile_notify(struct platform_profile_handler *pp=
rof)
>> @@ -123,6 +147,9 @@ int platform_profile_cycle(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option next;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>
>> +=C2=A0=C2=A0=C2=A0 if (!class_is_registered(&platform_profile_class))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>
> This check is pointless since the platform profile class will always
> be registered during module initialization.
> Please remove it.
>
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ER=
ESTARTSYS,
>> &profile_lock) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cur_profile=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>> @@ -164,25 +191,76 @@ int platform_profile_register(struct
>> platform_profile_handler *pprof)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cur_profile)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EEXIST;
>>
>> -=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group(acpi_kobj, &platform_pro=
file_group);
>> -=C2=A0=C2=A0=C2=A0 if (err)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0=C2=A0 /* create class interface for individual handler */
>> +=C2=A0=C2=A0=C2=A0 pprof->minor =3D ida_alloc(&platform_profile_ida, G=
FP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (pprof->minor < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pprof->minor;
>> +=C2=A0=C2=A0=C2=A0 pprof->class_dev =3D device_create(&platform_profil=
e_class,
>> pprof->dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MKDEV(0, 0), pprof, "p=
latform-profile-%d",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pprof->minor);
>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(pprof->class_dev)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR(pprof->clas=
s_dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup_ida;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D pprof;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D sysfs_update_group(acpi_kobj, &platform_pro=
file_group);
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup_cur;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +cleanup_cur:
>> +=C2=A0=C2=A0=C2=A0 cur_profile =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 device_unregister(pprof->class_dev);
>> +
>> +cleanup_ida:
>> +=C2=A0=C2=A0=C2=A0 ida_free(&platform_profile_ida, pprof->minor);
>> +
>> +=C2=A0=C2=A0=C2=A0 return err;
>> =C2=A0 }
>> =C2=A0 EXPORT_SYMBOL_GPL(platform_profile_register);
>>
>> =C2=A0 int platform_profile_remove(struct platform_profile_handler *ppr=
of)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 int id;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(mutex)(&profile_lock);
>>
>> -=C2=A0=C2=A0=C2=A0 sysfs_remove_group(acpi_kobj, &platform_profile_gro=
up);
>> +=C2=A0=C2=A0=C2=A0 id =3D pprof->minor;
>> +=C2=A0=C2=A0=C2=A0 device_unregister(pprof->class_dev);
>> +=C2=A0=C2=A0=C2=A0 ida_free(&platform_profile_ida, id);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 sysfs_update_group(acpi_kobj, &platform_profile_gro=
up);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 EXPORT_SYMBOL_GPL(platform_profile_remove);
>>
>> +static int __init platform_profile_init(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D class_register(&platform_profile_class);
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group(acpi_kobj, &platform_pro=
file_group);
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 class_unregister(&platform_=
profile_class);
>> +
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +}
>
> Please use a blank line after function/struct/union/enum declarations.
>
> Apart from those minor issues the patch looks quite nice, so with
> those issues being fixed:
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
>> +static void __exit platform_profile_exit(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 class_unregister(&platform_profile_class);
>> +=C2=A0=C2=A0=C2=A0 sysfs_remove_group(acpi_kobj, &platform_profile_gro=
up);

I just noticed that the legacy sysfs group needs to be removed before the =
class, otherwise
there might be a short time window during module exit where the legacy sys=
fs interface might
try to use the already unregistered class.

Thanks,
Armin Wolf

>> +}
>> +module_init(platform_profile_init);
>> +module_exit(platform_profile_exit);
>> +
>> =C2=A0 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
>> =C2=A0 MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
>> =C2=A0 MODULE_LICENSE("GPL");
>> diff --git a/include/linux/platform_profile.h
>> b/include/linux/platform_profile.h
>> index 8ec0b8da56db5..a888fd085c513 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -29,6 +29,8 @@ enum platform_profile_option {
>> =C2=A0 struct platform_profile_handler {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev;
>> +=C2=A0=C2=A0=C2=A0 struct device *class_dev;
>> +=C2=A0=C2=A0=C2=A0 int minor;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long choices[BITS_TO_LONGS(PLAT=
FORM_PROFILE_LAST)];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*profile_get)(struct platform_profi=
le_handler *pprof,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option *profile);
>

