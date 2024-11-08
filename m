Return-Path: <linux-acpi+bounces-9450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709E9C2492
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 19:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238411C28000
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE9233D75;
	Fri,  8 Nov 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Qhg2afYl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87B233D6A;
	Fri,  8 Nov 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088948; cv=none; b=uSIE804ZGdpaP94OU6Tme5FeL1FcH4ClIcBTbFsqF1RooXra72J4IFlOtOyG/Pbu/wTUGZG4jLaNNbBLeuPCMdaKQS+yNJ6CRhCJ3FeuuEGUcdjNOxNBcHGUxZlHIpd57YJXHnXNSlJxqLs2X7IvtIw+8jsAhgprAVnTXNYWMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088948; c=relaxed/simple;
	bh=SVqZ1X8HVCMzQQKZjQtXJX2fjS2vCniOVfAXvWwjdCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pllrqqn2S00BhFy/esX0VUpeTq/gtVMxNn2r8ZfiyJSVqlZbwlkz453vpHgMO0LS5Y1gi9VcCgCHZsbOX2rVF9ZqNTGsg0Zzbwpnpnapqx4qQZIxi7yDbVvk+xbcmTn3g/HfZLQTWC1QpShuWglSnSKB9sKi3+iM2D79wYFnKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Qhg2afYl; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731088825; x=1731693625; i=w_armin@gmx.de;
	bh=SVqZ1X8HVCMzQQKZjQtXJX2fjS2vCniOVfAXvWwjdCM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Qhg2afYlJNFS2COGc1xYYsj1S7cc8BNnoARqs7pEY6ynvEvNhirbrP7MD8uCuvel
	 UZ7EWlMUiqCBvdV2XxEgvV1G0+cK9goijMTDUknzZxFmuI3PVI9ToO/qY9K8haIDP
	 VnFMtasRKJcvLA8C/PfCWrxUX3ucybAOY7Z0dtd/1Ccp4zQsaaXyXTEgn3Cb/vfNJ
	 OTJ9Vc67D9L97gA7/vN8X7RXh/yOQL9QAuisd0EGP+/pDTQMhcMg9/p0tL1xVri2e
	 IlIZKnkxUxFHmRbAgc6kWtADjZpPpKX2Oz7054+myEp4ru6D3uDJHXSxlBOFsLQot
	 VIXXkIqy/ptzUGO4Mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1tuaHH41bT-00scQ0; Fri, 08
 Nov 2024 19:00:25 +0100
Message-ID: <7a08bb90-84b3-4536-81f1-8542a11dbff3@gmx.de>
Date: Fri, 8 Nov 2024 19:00:21 +0100
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
 <f5967c2f-1a33-4f5d-bae7-1864d931301c@gmx.de>
 <3618b0df-460e-4647-ac12-8063542f40e5@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3618b0df-460e-4647-ac12-8063542f40e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9h5p1rcMH+bda/iPdtZAZBe97AF/VGoybaei0D6LquWC5zP1b+
 yUxFqCQXVkJg/E59SCCVhOQIVkSXnoa6YtUUHaHSn+YSY/OePvbm6ANEFn49TEWcQsjn0PK
 LeqvmHr6+IDLZl5MBJXQiBj2H42iRi1qL9OcKUL7immgFJSou0D9A37kVPCYr9TACPzXPAZ
 a/x5Opm4Nprk7SpXsSaKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ROV88I4esuw=;CYzyHR8rCgiqH5w7YkmdOrC0bSj
 drrclBv+gY0I1IO3PYnYFDDm2pDPkoXzjgHTUyKqahkopsa/+dTAV9fDqA8FNqrj3mGW03WC5
 ZwtkhZLjyxmGzFt97rC97j3ctNG9RZE/NZhMnE4sZQT152/Irk5niR5jTCsS1q/fHBCY/q7pp
 2MsQS8fDp/aNaNEM9DB9CuoovIXogzsMFuaLqC4UQG1oRoSIX388ATDhWcVkMs4sBcQRnUzUX
 j9hbFYijcbrScStPjoexPXuRS48EgpRe2Dn8AeSl8uUVdw3KRxlMQV+dObZrGRzKxpWVUGDTY
 uxLsRkZJTAS985vc39KK0mgkBDycNi41+EeIFr4/5JxpnHvnoWuVMdXa+g/Ky5uLRlXCdBkUg
 kdU/ohJKw/Wg5RmQA8GdF40dF/mYn4ITr7HRdd3MvCeC+RUvlhTz/XJJegernuF9SccN/a8E5
 lk+BY4raM7AHPOD+V7NkDCRASmp1AkM9WDHQcz0NDWRGbpk6KQSLWg4a2e6x1iVuQp+9iKP6C
 L5R3Bkcm3CaAflcommUigfV/Y+dbxFke+aI95qjVt+VTBng+wYqqdLuLaw/vIUBNzeMNF98zh
 O2bZlDQVw9zuHs0EA+pssWCbHSmWmORhAicgroDdBJQ01Oi6sP0xy9NNwKdvLpacgs7862HVY
 +pPb04nBJO7XTmhlyMT0T8zsvqN5vnHz/vyRZ0tsMooyTTWMkQ55whpD8Dio8fF+bYbZ4c6Pg
 WJkM9nmpe9Wl/h4eG03H9SriKoONcHRY3EExvwVDwkgqsmfgdrhwa4UAGuJDp+ZTRy+tSZHC7
 BTqmhcTDsuSS2/NhktweKzKGc7GCN8EWuPCXh5F62gDj8=

Am 07.11.24 um 22:41 schrieb Mario Limonciello:

> On 11/7/2024 02:34, Armin Wolf wrote:
>> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
>>
>>> Reading and writing the `profile` sysfs file will use the callbacks fo=
r
>>> the platform profile handler to read or set the given profile.
>>>
>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v5:
>>> =C2=A0 * Drop recovery flow
>>> =C2=A0 * Don't get profile before setting (not needed)
>>> =C2=A0 * Simplify casting for call to _store_class_profile()
>>> =C2=A0 * Only notify legacy interface of changes
>>> =C2=A0 * Adjust mutex use
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c | 110
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 1 file changed, 110 insertions(+)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index 5e0bb91c5f451..35e0e8f666072 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -65,6 +65,62 @@ static int _get_class_choices(struct device *dev,
>>> unsigned long *choices)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> +/**
>>> + * _store_class_profile - Set the profile for a class device
>>> + * @dev: The class device
>>> + * @data: The profile to set
>>> + */
>>> +static int _store_class_profile(struct device *dev, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handler;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long choices;
>>> +=C2=A0=C2=A0=C2=A0 int *i =3D (int *)data;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 err =3D _get_class_choices(dev, &choices);
>>> +=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&profile_lock);
>>> +=C2=A0=C2=A0=C2=A0 if (!test_bit(*i, &choices))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 handler =3D dev_get_drvdata(dev);
>>> +=C2=A0=C2=A0=C2=A0 err =3D handler->profile_set(handler, *i);
>>> +=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return err ? err : 0;
>>
>> Please just return 0 here.
>>
>>> +}
>>> +
>>> +/**
>>> + * get_class_profile - Show the current profile for a class device
>>> + * @dev: The class device
>>> + * @profile: The profile to return
>>> + * Return: 0 on success, -errno on failure
>>> + */
>>> +static int get_class_profile(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option *profile)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handler;
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option val;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&profile_lock);
>>> +=C2=A0=C2=A0=C2=A0 handler =3D dev_get_drvdata(dev);
>>> +=C2=A0=C2=A0=C2=A0 err =3D handler->profile_get(handler, &val);
>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed to get prof=
ile for handler %s\n",
>>> handler->name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON(val >=3D PLATFORM_PROFILE_LAST))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 *profile =3D val;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> =C2=A0 /**
>>> =C2=A0=C2=A0 * name_show - Show the name of the profile handler
>>> =C2=A0=C2=A0 * @dev: The device
>>> @@ -106,12 +162,66 @@ static ssize_t choices_show(struct device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return _commmon_choices_show(choices, b=
uf);
>>> =C2=A0 }
>>>
>>> +/**
>>> + * profile_show - Show the current profile for a class device
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to write to
>>> + * Return: The number of bytes written
>>> + */
>>> +static ssize_t profile_show(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option profile =3D PLATFORM_=
PROFILE_LAST;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>> &profile_lock) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D get_class_profile(=
dev, &profile);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%s\n", profile_names[profi=
le]);
>>
>> AFAIK we do not need to take the mutex here, since querying the
>> current platform profile
>> should not change any state.
>
> I think it's still needed, in case someone attempts to unload the driver
> at the same time as it's being read.=C2=A0 It's not static information
> because it needs to use the function pointer into the driver to get it.
>
> This will protect from that occurring.
>
> That's the same reason I was thinking name needed protection too.
>
I see, good point.

Thanks,
Armin Wolf

>>
>> Thanks,
>> Armin Wolf
>>
>>> +}
>>> +
>>> +/**
>>> + * profile_store - Set the profile for a class device
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to read from
>>> + * @count: The number of bytes to read
>>> + * Return: The number of bytes read
>>> + */
>>> +static ssize_t profile_store(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t count)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int i, ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 i =3D sysfs_match_string(profile_names, buf);
>>> +=C2=A0=C2=A0=C2=A0 if (i < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>> &profile_lock) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D _store_class_profi=
le(dev, &i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return count;
>>> +}
>>> +
>>> =C2=A0 static DEVICE_ATTR_RO(name);
>>> =C2=A0 static DEVICE_ATTR_RO(choices);
>>> +static DEVICE_ATTR_RW(profile);
>>>
>>> =C2=A0 static struct attribute *profile_attrs[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_name.attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_choices.attr,
>>> +=C2=A0=C2=A0=C2=A0 &dev_attr_profile.attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>>> =C2=A0 };
>>> =C2=A0 ATTRIBUTE_GROUPS(profile);
>

