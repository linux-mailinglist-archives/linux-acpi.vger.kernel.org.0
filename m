Return-Path: <linux-acpi+bounces-9651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C809D1C86
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 01:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C34B22D28
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF1F4437C;
	Tue, 19 Nov 2024 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="M1I4DaxS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FE17C8D;
	Tue, 19 Nov 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976169; cv=none; b=In1Yhnrl7rC1jlZzWsbPrTg4ldtyt+fD+ZvxJeialm7bu5YpOg0kJLE6jtxZdUexi7c+gPkq6iEA2AhS68DXsN9Zh9vWyrx1LxX8JZ9VtJXoBYhZYxo6KeVzzGvxPCHGCF5wcy8PAdM77GjtUUoorC2Y9C2aipKlCzbCW/odhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976169; c=relaxed/simple;
	bh=Z8DqmcWjt1zrD0CYXeSpSjfpqvmdRKZWzMK9PjvpSrM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CO4F0Rj4H+IUzaunb7uzUB+hXkEqh2DsW4wFFYvKMxyCQyppGD09QFe2IEE1NFTgeapfVRHyv80zUWKbd2cTNjAdyFMjM14PBzw37G6x/C6TcplfQILz6QeC7o3CV9sQSDPTwLKlrL/lh4eYOFyERRzD2B3jfXkyvM4KU/Xiz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=M1I4DaxS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731976096; x=1732580896; i=w_armin@gmx.de;
	bh=5hVcqyFvTu5vatuyXRiaENgjDo70JIP3TxdDakNOEoY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M1I4DaxSnoCLq+cE/xr8pqVX7z8CJWeB8M1Lr5yZSm7/R1FS0vCWaGThSO8zFcoz
	 GaMsive8zHBMQQtbFvs/BUs0eXEQ6UvWC/sLZoNOXntABtY8cCc5AZI3P1y6sNILs
	 x5MeR6RQV0BGLU5xQx4/KnAZZBPQW73CLpf1y5PiszCBZj0MIrH2zboFcHQ0kSTLL
	 93bqLzYfeD15BIoxos1shW+uxZpdP5z7Y150+LhPVb18gQD5BEhmrTzcr3Rr3n+t1
	 ZcsftcDhrBSA5TRhImTR/zjovRQVZ/AC3EtHjiDcBEll6FJQkySjdYuvvaBuoDjuY
	 X4kq6RS1Sreq6y0SYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1txi8f3jgM-00zraz; Tue, 19
 Nov 2024 01:28:16 +0100
Message-ID: <6b7d2f80-0dde-4f07-b889-fa2cb99f5c88@gmx.de>
Date: Tue, 19 Nov 2024 01:28:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/22] ACPI: platform_profile: Add name attribute to
 class interface
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
 <20241109044151.29804-12-mario.limonciello@amd.com>
 <29899120-efec-4264-b6a8-0bca4fc1f332@gmx.de>
Content-Language: en-US
In-Reply-To: <29899120-efec-4264-b6a8-0bca4fc1f332@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bSMGx/uh1q7vg+W2/okqjuLaAoxzMkFQA4fCWCTTEXdCq3uQYq5
 4hcp/iGW1shsODj7zQga6ANI8rRrYgDYH7N/GKa14LI6/PzIcxe9X5GFgHc/Ze5UzJMKvgx
 pYYRDNP/NF+gljOQ5Hc0/M5cly70I6mod49AJjRZ6MEQlo5GiB7mV8pJvigN6w1+S+0EyvX
 4RtbCRDd+SsikqtSTu55Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:anLUiQlL/Pg=;9BVvn4ZIFw1ZS8IzZF3GfZQok8R
 N6gwacx8GN6z3hVhPIwhUAy2M9cLQRqKZalSIz/NVD2aVlaJpl+uqJdf9okZXVdH427FptXxm
 ZzpXlEdBtWtFjro5PF8ymRsP0rZl5STKSojyQMG1eMkCS0KfSBII5SOmJzp+Gqfp+530oYNil
 JYkKQvzW9zN66SAdH3vcBPXisnUI9zCRcQTEpc6llgXAhBfWlXokoRTIIL4tbglIRXegkfCbn
 kI/O/CeXMLo09ybu26mVBUbEewqhtv/rJp9gsTiBb7Vw6GA4u+yawRWQ4eNgu0rXdC+lTh1qR
 Or8hd+ynwapM7N4gjj4tJjpjD8FDVV4LQsq7+sCbFjhK32DOYXo/pWZ4QhtopeEEc5zrVhTDW
 5IxAc70BHE8boGDHpSc+UiY3D4gkRS+lF0UuPp5j6E1CDI2dQOZv6g4a2Ia6vKAbn8kppM/K1
 rHdZ+5tNCqEbn2fRgXn8fC3sEeyXiYEwKXoRXW4SglxbvfCUngP7ag4E43h5ULsG0kI79jEnp
 WW3//jyyDG1x4uqQEu2e3jjcaq5XS/v7ZmTw+XKuM2WZpIbVt8nGsveWNrXLkfL9p5vhcARyp
 rGrCc8O4Jnlqs9shJCTdocC07gye6h9E95l8aMs3yjWBW6XfdnlXbz9Yw5+6jGY9j8Co71oCa
 AASpTc5IWHg6/Xu7JRohn+A/VyxgB/gGHss/4yUqPLZJZ4NzGX2BvF8ZwhOrOvFKde2ejpm90
 eo4HtmF9tF0ilX37xJOXWdbUOAPHhUbvu6eVd1uOwJOJh3Qj/dpAebVwXghJXdzNUGfH6NnW/
 Itel1fvVSRzB2nGFfdD+rSbIKKYL/tcj0X11p6Qi/UaYssgxJIpaMLBc5Iaa5BSZ8kn8L+TXw
 9xmzEjdxMhTFVhxxHqOzjRAAHeKBCwNlrtP65H1Ww8HxpzBOoccxQpdM9

Am 18.11.24 um 20:43 schrieb Armin Wolf:

> Am 09.11.24 um 05:41 schrieb Mario Limonciello:
>
>> The name attribute shows the name of the associated platform profile
>> handler.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> =C2=A0 drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/acpi/platform_profile.c
>> b/drivers/acpi/platform_profile.c
>> index ef6af2c655524..4e2eda18f7f5f 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -25,8 +25,35 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D
>> PLATFORM_PROFILE_LAST);
>>
>> =C2=A0 static DEFINE_IDA(platform_profile_ida);
>>
>> +/**
>> + * name_show - Show the name of the profile handler
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to write to
>> + * Return: The number of bytes written
>> + */
>> +static ssize_t name_show(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct device_attribute *attr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 char *buf)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handler =3D dev_ge=
t_drvdata(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS, =
&profile_lock) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%s\=
n", handler->name);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return -ERESTARTSYS;
>
> I still have a bad feeling about the locking inside the class
> attributes...
>
> Can we assume that no sysfs accesses occur after unregistering the
> class device?
>
> Even if this is not the case then the locking fails to protect the
> platform_profile_handler here.
> If the device is unregistered right after dev_get_drvdata() was
> called, then we would sill operate
> on possibly stale data once we take the profile_lock.
>
> Does someone have any clue how sysfs attributes act during removal?
>
I think i found the answer to my questions inside this patch series:
https://lore.kernel.org/linux-kernel/1390951311-15325-1-git-send-email-tj@=
kernel.org

It says that:

	kernfs / sysfs implement the "sever" semantic for userland accesses.
	When a node is removed, no further userland operations are allowed and
	the in-flight ones are drained before removal is finished.  This makes
	policing post-mortem userland accesses trivial for its users.

In this case taking the profile_lock when reading/writing class attributes=
 seems to be unnecessary.
Please remove the unnecessary locking inside the class attributes.

Thanks,
Armin Wolf

> Thanks,
> Armin Wolf
>
>> +}
>> +
>> +static DEVICE_ATTR_RO(name);
>> +static struct attribute *profile_attrs[] =3D {
>> +=C2=A0=C2=A0=C2=A0 &dev_attr_name.attr,
>> +=C2=A0=C2=A0=C2=A0 NULL
>> +};
>> +ATTRIBUTE_GROUPS(profile);
>> +
>> =C2=A0 static const struct class platform_profile_class =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "platform-profile",
>> +=C2=A0=C2=A0=C2=A0 .dev_groups =3D profile_groups,
>> =C2=A0 };
>>
>> =C2=A0 static ssize_t platform_profile_choices_show(struct device *dev,
>

