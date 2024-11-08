Return-Path: <linux-acpi+bounces-9449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455C9C23EB
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 18:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94831F21B85
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49883231CB2;
	Fri,  8 Nov 2024 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qYkRcYTF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743222B3AD;
	Fri,  8 Nov 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087375; cv=none; b=fkTs1Hly3TuROLJHL72ykV8Yq+jx5dxTiF8L42jjvQNbndORwWkPy6sBNTqGB+ySXqxLdEaWxR3Cot5JHoNcNAWH4+qd6tTI1L3FyR0GWp4AvKhOveOV4Oza71eN/CUtKih4BfV4+I1kY00fGO6WIZZeMU/jNJVTGPrb1QiBU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087375; c=relaxed/simple;
	bh=8OJq7HGD9qwWprJsJNrfBtO5OY2CfqkAFAanuuCmDr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGqWUmjtQ1nNLlUDKXCNbM5nsZ4mnwMCbzqtNcTi4xPvBqqMvHjgm+d1UjLaNCKTmlFoTPXX9dZWHr29YdOVzMstc9I8tzkBvcUlKntbpjEXkO5Izv++Fc8YRfd7PfqdM3vTUviLOCPVcjXUXTtSizCP4UG1vq4jClWtWld9Wjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qYkRcYTF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731087298; x=1731692098; i=w_armin@gmx.de;
	bh=8OJq7HGD9qwWprJsJNrfBtO5OY2CfqkAFAanuuCmDr4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qYkRcYTFgroAyxnw4KKajQSR+3mjvjz3rJwnrY65wQ21Cw45R+5wuRP/T2HrR3sQ
	 /Ku/u122z23fDtizdTUHECXM/k/hdVTLLtf3VDbVVy1FuqDG4rwPhyZbUluNfDYHu
	 +bzqRtBirLScpSYxFPVO2/fhFmClby00RZIZuXfqAQZwCzA6NWW7i7AmtvKxY8Vx8
	 SdpD3qWGiL/AFD6hD3x7kCqz7Kp+1y8BrbUGC8JiIFP/RoaxGy84s32ThgXpjStwk
	 4TTXIlwiJ4WrDQ1SDhA6ajGSxt01ZIMlJWoLxd6xkrlI65RydRqkIZ68uvmYgGsmO
	 oNxyYARZTxk8nA7u8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1tG1O609kW-00QmZV; Fri, 08
 Nov 2024 18:34:58 +0100
Message-ID: <b334d8b9-64ea-4808-a51f-45ee8da2aae0@gmx.de>
Date: Fri, 8 Nov 2024 18:34:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/20] ACPI: platform_profile: Create class for ACPI
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-9-mario.limonciello@amd.com>
 <84a647ba-50ec-4d60-b4be-758ff50335bd@gmx.de>
 <67f147a9-9c4c-4923-95fb-6186f8b51d77@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <67f147a9-9c4c-4923-95fb-6186f8b51d77@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3D9m/5wKJr1h25IK/pB102QSnMzneqQEtTNMzpt6NdPjm5haZ4m
 ydN8I+g+EDzSDpy21kfQkOxo1B+Qow9M3ZPu7INOogId5uzbnPJQemQssJ3hgpLPcTPr4Vm
 jKl4r4PNPh/EG4scmsJsprCSTpmdmErCnR9OTMxEdLpI+zFKhNa/BDxj2uE3vja0/0P/h/o
 Yqp8Kjb+c2hf+PhK4L8Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:phirCFRhYfw=;CYFd7KQAdtW1Fmrfct+VDvFYvwY
 Sn0SxFfp7/zaxy/6UIgNsqrVqaXEsZDvnrMB7ImnVfXqj08ETsMyKft+z1ieC1gdbSdmxz5cJ
 FNup97UT4h0wl+uOMQsguoE81I1YrZmbX729XOgd004remm2QDNMdUThBKnapoo4nmoJm75F8
 3yOU26+uWv84bAc0mnJVBnXKCsCWSHjTPUb/Mym9WtGfsiekm5UdqO6Bs0Z1rZpUwSXguvL2P
 sWnvJB+dov0/dZgfMPSmewF6+EAZr1JtyZIrXvfBqW2RTAJogDP2WQcnnFJyGjhoF1ZTQTeos
 mjEdpl3EbHS6TnGaWBly7nfZMi0AYCgx9Rx58VnVzNAfn5am8bwlRzJHBu5Yf1SbZwNTPytKg
 PsTatuTyTCygfwOAsqKB91P41JwUAhHAo+wit59mADdMwUrK9mVxOcV13aEL785AthOxwkVvI
 uhIuHCxLWkcYW85wN5yzLE4hx35v/bT38m8H8w2djmoJpFSlMrO2XL9UV5QGyEcpQpz6+OQSv
 l5Tc+e6pjNurC7RNsSAVA8XvAzzquqX+/dxr5+VPyRjX5Bhvaur9EGR70cGIvGqyVhNcjPT4I
 BzokPhSH7WGpCzrD9O8KnF9YR6AQr0tcaMvcyHy2klXLtVKwqzwhrSnb0ID66eN+0OkWUUoAZ
 +j8UKcjvazBVa4u4jtzDVf81Ufg75B8pDGK1BcxN+Ur0yHyf1aw5gPPg9VjMRGSutoQr2oLun
 6R7y1MmqrSUwQ52Y/obv65t/709Pe4Q6Qxa9ioWgfyM8cL3J/bKvpGiMk4Xwce/zi++crW0qc
 7t/G6AvFC/hy2pJGGofYWRmja6rmMO0EjnZPw31dJuNzhEAlvg+zpAb8RahL0i93p1ulKrsTq
 8Y4V2SMBrHA/qyxr+5sf7Z6c4S6Km9Fr8Kra6puslM5LB3fpRm7xUfj2U

Am 07.11.24 um 22:09 schrieb Mario Limonciello:

> On 11/7/2024 02:16, Armin Wolf wrote:
>> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
>>
>>> When registering a platform profile handler create a class device
>>> that will allow changing a single platform profile handler.
>>>
>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v5:
>>> =C2=A0 * Use ida instead of idr
>>> =C2=A0 * Use device_unregister instead of device_destroy()
>>> =C2=A0 * MKDEV (0, 0)
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c=C2=A0 | 50
>>> +++++++++++++++++++++++++++++---
>>> =C2=A0 include/linux/platform_profile.h |=C2=A0 2 ++
>>> =C2=A0 2 files changed, 48 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index 0450bdae7c88b..652034b71ee9b 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -5,6 +5,7 @@
>>> =C2=A0 #include <linux/acpi.h>
>>> =C2=A0 #include <linux/bits.h>
>>> =C2=A0 #include <linux/init.h>
>>> +#include <linux/kdev_t.h>
>>> =C2=A0 #include <linux/mutex.h>
>>> =C2=A0 #include <linux/platform_profile.h>
>>> =C2=A0 #include <linux/sysfs.h>
>>> @@ -22,6 +23,12 @@ static const char * const profile_names[] =3D {
>>> =C2=A0 };
>>> =C2=A0 static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE=
_LAST);
>>>
>>> +static DEFINE_IDA(platform_profile_ida);
>>> +
>>> +static const struct class platform_profile_class =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "platform-profile",
>>> +};
>>> +
>>> =C2=A0 static ssize_t platform_profile_choices_show(struct device *dev=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_at=
tribute *attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> @@ -113,6 +120,8 @@ void platform_profile_notify(void)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cur_profile)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 if (!class_is_registered(&platform_profile_class))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform=
_profile");
>>> =C2=A0 }
>>> =C2=A0 EXPORT_SYMBOL_GPL(platform_profile_notify);
>>> @@ -123,6 +132,9 @@ int platform_profile_cycle(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option next;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (!class_is_registered(&platform_profile_class))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -E=
RESTARTSYS,
>>> &profile_lock) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cur_profil=
e)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>>> @@ -163,20 +175,50 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cur_profile)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EEXIST;
>>>
>>> -=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group(acpi_kobj, &platform_pr=
ofile_group);
>>> -=C2=A0=C2=A0=C2=A0 if (err)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +=C2=A0=C2=A0=C2=A0 if (!class_is_registered(&platform_profile_class))=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* class for individual ha=
ndlers */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D class_register(&pl=
atform_profile_class);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* legacy sysfs files */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group=
(acpi_kobj, &platform_profile_group);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to cleanup_class;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* create class interface for individual handler *=
/
>>> +=C2=A0=C2=A0=C2=A0 pprof->minor =3D ida_alloc(&platform_profile_ida, =
GFP_KERNEL);
>>
>> Missing error handling.
>
> Ack.
>
>>
>>> +=C2=A0=C2=A0=C2=A0 pprof->class_dev =3D device_create(&platform_profi=
le_class, NULL,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MKDEV(0, 0), NULL, "pl=
atform-profile-%d",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pprof->minor);
>>
>> Two things:
>>
>> 1. Please allow drivers to pass in their struct device so the
>> resulting class device
>> has a parent device. This would allow userspace applications to
>> determine which device
>> handles which platform profile device. This parameter is optional and
>> can be NULL.
>>
>
> I previously did this indirectly by letting them set it in the
> "struct platform_profile_handler *pprof" and then used that value.
>
> You had said that wasn't necessary so I dropped that patch.=C2=A0 I woul=
d
> rather go back to including that then having another argument to
> platform_profile_register().
>
I meant that requiring "dev" to be set is not necessary. Having a "dev" fi=
eld inside struct platform_profile_handler is fine.

Thanks,
Armin Wolf

>> 2. Please use the fourth argument of device_create() instead of
>> dev_set_drvdata().
>
> OK.
>
>>
>> Thanks,
>> Armin Wolf
>>
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(pprof->class_dev)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR(pprof->cla=
ss_dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup_ida;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 dev_set_drvdata(pprof->class_dev, pprof);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D pprof;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +cleanup_ida:
>>> +=C2=A0=C2=A0=C2=A0 ida_free(&platform_profile_ida, pprof->minor);
>>> +
>>> +cleanup_class:
>>> +=C2=A0=C2=A0=C2=A0 class_unregister(&platform_profile_class);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return err;
>>> =C2=A0 }
>>> =C2=A0 EXPORT_SYMBOL_GPL(platform_profile_register);
>>>
>>> =C2=A0 int platform_profile_remove(struct platform_profile_handler *pp=
rof)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 int id;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(mutex)(&profile_lock);
>>>
>>> -=C2=A0=C2=A0=C2=A0 sysfs_remove_group(acpi_kobj, &platform_profile_gr=
oup);
>>> +=C2=A0=C2=A0=C2=A0 id =3D pprof->minor;
>>> +=C2=A0=C2=A0=C2=A0 device_unregister(pprof->class_dev);
>>> +=C2=A0=C2=A0=C2=A0 ida_free(&platform_profile_ida, id);
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> diff --git a/include/linux/platform_profile.h b/include/linux/
>>> platform_profile.h
>>> index 58279b76d740e..d92a035e6ba6a 100644
>>> --- a/include/linux/platform_profile.h
>>> +++ b/include/linux/platform_profile.h
>>> @@ -28,6 +28,8 @@ enum platform_profile_option {
>>>
>>> =C2=A0 struct platform_profile_handler {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
>>> +=C2=A0=C2=A0=C2=A0 struct device *class_dev;
>>> +=C2=A0=C2=A0=C2=A0 int minor;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long choices[BITS_TO_LONGS(PLA=
TFORM_PROFILE_LAST)];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*profile_get)(struct platform_prof=
ile_handler *pprof,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option *profile);
>

