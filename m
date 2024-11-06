Return-Path: <linux-acpi+bounces-9377-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C19BF845
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639C5B2358B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924A920CCE6;
	Wed,  6 Nov 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qp8eh+VZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5D20CCD2;
	Wed,  6 Nov 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926774; cv=none; b=s4s0/J4eeqSbj6t3vsleokOxdHIQqwzDtD/YPa8bSSoeOGtffWzTlQl/1A0iP714S+ip+UNggqEx4woA1/YImYLp/v+pVELXSFFA4rW2+pULMrY7atAXHHmS6BO0Bn5q8/8MQNJZ0qemvSJ5+/VLvoQzhexir4kXvxE5aZLeVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926774; c=relaxed/simple;
	bh=LxWHqQIC4YcjFMZSkIcr52HBHxSAHeDib3RUyYnyJws=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eUJQr2Tw8DMykY+KlgmpZ6cSqGM4tx+c86CtMn2rcCzZHEQaHX1zNUMzGSW+cEaW5OMomGu8PfIOIRP/RcvkrBgg1akYk/3muN5Hkv79Pezgjs8tW3IST7LLNFzJghPG8UJ3/FrxIl3LUkDxboMHzVR2jbdUbe4Sh6ITOzenQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qp8eh+VZ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730926704; x=1731531504; i=w_armin@gmx.de;
	bh=LxWHqQIC4YcjFMZSkIcr52HBHxSAHeDib3RUyYnyJws=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qp8eh+VZ/fxS/nD2yQq5eGWa91EBTJvEALS9CK2d6Tl2tqD0Abd9PpF8lC31K2OM
	 2v8yWVmX3qjWFcGAfeji0dGHtAaEpMTQO5ewvqC4glccETOonCEkqdB81Fzti5Dj8
	 biUeTWZTFbtQPkpl6vbQhiwUwayC+47uxGbA01yKCn7Q/q7hhC53OH77qauIVUVAT
	 ynCzT8uGCjZFhOLMSADBtXI0/Y21Crw2qgwuX5+iFvTrzEgdhcivq0v03HBUB4zlW
	 XA5DmzsBk4hiiG9iMSLu92tvPrS85nKAXKuARjcUTwps5ma4izLKcdQt0Pw3YNOV3
	 jZ9ZEcW74OP4puVhkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1tvpTh0GZx-0126VB; Wed, 06
 Nov 2024 21:58:24 +0100
Message-ID: <8ac7f4b6-525f-4394-a4e7-36640359ea17@gmx.de>
Date: Wed, 6 Nov 2024 21:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4 13/20] ACPI: platform_profile: Notify change events on
 register and unregister
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
 <20241105153316.378-14-mario.limonciello@amd.com>
 <5ad884fc-886e-4924-8c5b-e537846fda60@gmx.de>
 <31247970-55b7-4952-a802-a0e2069c1c6d@amd.com>
Content-Language: en-US
In-Reply-To: <31247970-55b7-4952-a802-a0e2069c1c6d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MW1jLqbc+XfNsUPh78G53KPUoZda+GYvXdJhJQEuhJwwDcl3kpT
 nzQYjKFjs/IzYIUNQAJZIUO8jfT5vZzT+U5EZH4y224Xn9Y/JjSbJT2gopzD9yq3t+i2klB
 ohdWFnvd28+Kj5KCXzzpWUU7frFsp/Vd4igpH3AT8NzcE7c2DgveWYOCuWrzwjQU6vtPTyA
 Sp0ckMPrWY20OxnZRLswg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BBiBAj5dk1c=;/FAq4W9s7jlLyd/IgJ9gogGD2VI
 DzH/uO0DVGoHVDjZR+zYbGm6uV/OiZYY9qH+zyEfHosufinHRRpF/ORj+NvxwMjrrDWCgr/kr
 CYSGtmTev6HtgY/nOHYzrzasEA3MiB/Jldoa6GwndYt5LGT2ZmNglDinrB0pJ8MdAAbkXcWGd
 CXUn3TDjKCgSb7bS0a1bjuhrAgH+4FDh5XJeVXUBFf6OauSMWVYHvHkxZC68C0USbaLf7gOnY
 EGRqFDZABvR3d7N3RvcPCjefJGLpErToL8VosYSwfDi6QDExbBF8g8zrydqv8EtgMuC9eHQ1f
 ZFjd1LnL4g0zYpEJZquy4PsZ9j7qPbp8lxhVCPCGOY61XviuPU1L7eUWFA+oGDVU3svqkznr4
 2lYe6BWbtr66VeLvCRoCOOO5lcjFnJWghk//JZu5VELDbf/UwKqYX91a8Mfd2wdKemo1LDx63
 9GzmsxQcajve3krVnFJcTg0hAXPakb+QR4mJt6xq+le/qm9pQXJ2X8KiPiHVrrG48WrYJpIFD
 wevKVoJ2ljrGvqoJ/6EaK6bPBMNochfTAs+kf3RBrJbgZ0MKhdunvs3/ptqkS+pRumV9+RAPa
 hl9pytOJD1Qoyazis/Tovj92b9KiisLN0mrMM072J1AbiQZ7sZFUMQcsqH+QrsW28bemRl6jx
 ASffGetX0GwqwOXHn6pdHm+36pRAaZqcMx0e7BRw52eI81N24mkPkx8jWAhqtU/7YdemzsqHJ
 y32BrMK+5LfwVD+JgnQvB3o6G8uJLCKTOjYVDSUSNX+n53g6KC/t1celC0ipIYo+GR4J10ed+
 D1MvimHx+dQ3CSqPhVV9ZknGFEX0b1rW/bsqYt01YhVHI=

Am 06.11.24 um 20:44 schrieb Mario Limonciello:

> On 11/6/2024 13:40, Armin Wolf wrote:
>> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
>>
>>> As multiple platform profile handlers may come and go, send a
>>> notification
>>> to userspace each time that a platform profile handler is registered o=
r
>>> unregistered.
>>>
>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c | 5 ++++-
>>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index 79083d0bb22e3..c9917daf683cb 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -404,6 +404,7 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(pprof->class_dev))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(=
pprof->class_dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(pprof->class_dev, pprof=
);
>>> +=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D pprof;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> @@ -419,7 +420,9 @@ int platform_profile_remove(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(mutex)(&profile_lock);
>>>
>>> -=C2=A0=C2=A0=C2=A0 sysfs_remove_group(acpi_kobj, &platform_profile_gr=
oup);
>>
>> When do we remove platform_profile_group now?
>>
>
> When incorporating your other feedback I noticed this was still there
> and it will be removed for the next revision.
>
> The idea will be as soon as a class registers the legacy interface is
> created and will stay for the lifetime of the boot.
>
> If all drivers are unloaded it will return -EINVAL until a new driver
> is loaded.

And what happens when the platform profile core itself is unloaded?

Thanks,
Armin Wolf

>
>> Thanks,
>> Armin Wolf
>>
>>> +=C2=A0=C2=A0=C2=A0 cur_profile =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_destroy(&platform_profile_class,=
 MKDEV(0, pprof->minor));
>>>
>
>

