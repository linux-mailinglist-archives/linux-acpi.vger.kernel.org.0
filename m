Return-Path: <linux-acpi+bounces-9451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B2B9C24A7
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1531F218C9
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD92233D8F;
	Fri,  8 Nov 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="V04qsCof"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29165233D80;
	Fri,  8 Nov 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089280; cv=none; b=r2VM6MeskUgEngxacCxkQcc6+UYW3GGzqUxi9Du0McEVCWoN2CrCHuGuOlCTYXxpafBy/JcTYflJhND6MljTMdbZM/KsKVlzmQZiZxJxc2MIWmv5whdz+ewPhGnj1hIyF8MQ5IhYTmquX8Zay36LLPTI++G4uDzSg97rxtwL6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089280; c=relaxed/simple;
	bh=9Fy8f6wTEancl/b7oGAdJU6XSqQhdH/xQ/IEUwsnIoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCj8WvkoJlAkNJGK4VKPEBuQzj4MeeBCJFLxYhfDfRhhNAQvC+jvlJNPSrnqmDcUrIFvjOLY9zLxM01FZ4PTKY2l7HRlWl/LK2dGT0XRK1d59cYyR3SJMKO5aL+DzIKdM0FWM5r1csVc4dOMy18p4Bd9H/WM93kUBWA0gk8g8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=V04qsCof; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731089212; x=1731694012; i=w_armin@gmx.de;
	bh=9Fy8f6wTEancl/b7oGAdJU6XSqQhdH/xQ/IEUwsnIoM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V04qsCofJfMI/JEhWoQNoPqw9IE7mQFmHaF7b7c49b7yiRMRwHdqDgfasTLNO8eh
	 xJjfsw0VAR4CTFj3kCFk72OYkuwzyNHyOTWSqCDYQEfojhHnRq7+ockjVD4cCjlSz
	 BE1iaLzv3VTw6mUyx3KOdOUwmzmFXDLi/eoahpNTnYnhMTBwZvOS8wlRMrQOlPirz
	 BAaPrEbhV94K58NjBI80Qs68LcYD2vnMA0qAMEjR7KI76qoOAOt+m3nbi7t18zpWw
	 Cl1zAgQOuee67HJ58PfnTkXBy9EYIHpfHCzamXwmduZWtIHyMadZDkbn6cy8frqpQ
	 MjLGqNzDYOY2wjyRTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1tH8tb3iJo-00U5PY; Fri, 08
 Nov 2024 19:06:52 +0100
Message-ID: <0ffe9b8b-814e-4b5a-a960-22797e327b4a@gmx.de>
Date: Fri, 8 Nov 2024 19:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] ACPI: platform_profile: Add choices attribute
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
 <20241107060254.17615-12-mario.limonciello@amd.com>
 <7e302f04-cb4d-4ecd-b1a1-4b89f09e692b@gmx.de>
 <9dd1709c-de87-4aa3-aa33-8a520a305545@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <9dd1709c-de87-4aa3-aa33-8a520a305545@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i6KkzGhtCShDZYq1bTXadJhCYusk/tewsN/WYepNcmbXkHhtFj2
 Pdst82mAqSHgDvhJAjTV+Mya6nXqEek8GqQk8c7P/jFSQXmkTo9YSwETLx1oFLPt82k/C+g
 Mu7XtPdvPb8zA0QOaDaJRGgQBt6By2s2SKA8acGWC0g0QU9JfFLvSkG/eFz3v1XpBpJ5XhS
 yYdUeJzYwLh8AR2SkJ1Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7F1LpOvsouI=;Wo/jQ98kjZ3U1U8zk8Ce57H/Sva
 iyFWl/mQO+j/jlHZzPwMx/i5j0+P8qWWK7U6a7pbTomIGNKcgBsIJEZhzvSNjD2bl8zrh+ukV
 iruavtwEV6KmR+w3tvee41Opdk7m/xZdqihb15hqmKrd5Rll+GrkBA57mWo8JjiKABLOT8J47
 EV9K1iVuGXeKjVVZQsnbCwQs0p2X+a0IZ2xWxycpRo0M8MKB7rSN1d+qlT8zjOG+Tmr53TVr0
 1cVr48X0oJD8Iy0c7c62NIojCKKanwaWjBKBlBESyhwToTvIpPnu1mUogD+Y71N/y1FZhNNqu
 IWcQSZFHulYKd/69UBCSD9HffZBRa49IpLe2g0n+mqGXdW+sa3CIchkKxZU5AFtfodzjmP0IU
 FW84X/fvXwcLQiFpPvBTSWf09xLjq9nhltpwtUcWn81GN345GrLH+14TrQGhmWkBRFNDD6LgK
 GRRJd908BF3m4oncsQXNsXw9Mm4Sw41V5fr9UaCSUR4CSnaCkF9y7PGYQEk5MIfP32h/GYcuC
 vIe83h5obhtecRHlCaWIgx337OBdw+XBENQH945zzPZ6pwmt9vr+5Xr5hr1KSxAUoOhcelL+6
 NkeS/jwagLhMopEvmp/ZOrAASrizEy6ial4mdS8ErppYo3bplQX7LolPcc5/2cd2o5O5y7bM1
 +tCL9BpGy6zvTEeE5TdkpDmQ8yw6s0Ka6syNKg9N8o+21Wc/e7a6bqLoG17i550+/m04j9Jz1
 UfkrzplgQCQ24gAWDZ1PFboaurLUL3ugfhPEgB+NAXRp0CJ7fg9CkFWsMS0NqP/iBmMXWjRnM
 BxDjj/RvDdZPSKNebxMpw+iryTqKHIHh68ql/k9qsaaifY34jiLhmJAgNZs5EgyxZ74L8ydIy
 RrIP+KTnyiYP94n5Wq0WZ6W2ptTqC5t9YQrnKVlYVL5YlDLE7nB2v90B/

Am 07.11.24 um 23:09 schrieb Mario Limonciello:

> On 11/7/2024 02:28, Armin Wolf wrote:
>> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
>>
>>> The `choices` file will show all possible choices that a given platfor=
m
>>> profile handler can support.
>>>
>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v5:
>>> =C2=A0 * Fix kdoc
>>> =C2=A0 * Add tag
>>> =C2=A0 * Fix whitespace
>>> =C2=A0 * Adjust mutex use
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c | 65
>>> +++++++++++++++++++++++++++++++++
>>> =C2=A0 1 file changed, 65 insertions(+)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index f605c2bd35c68..5e0bb91c5f451 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -25,6 +25,46 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D
>>> PLATFORM_PROFILE_LAST);
>>>
>>> =C2=A0 static DEFINE_IDA(platform_profile_ida);
>>>
>>> +/**
>>> + * _commmon_choices_show - Show the available profile choices
>>> + * @choices: The available profile choices
>>> + * @buf: The buffer to write to
>>> + * Return: The number of bytes written
>>> + */
>>> +static ssize_t _commmon_choices_show(unsigned long choices, char *buf=
)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int i, len =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAS=
T) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le=
n +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le=
n +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 len +=3D sysfs_emit_at(buf, len, "\n");
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return len;
>>> +}
>>> +
>>> +/**
>>> + * _get_class_choices - Get the available profile choices for a
>>> class device
>>> + * @dev: The class device
>>> + * @choices: Pointer to return the available profile choices
>>> + * Return: The available profile choices
>>> + */
>>> +static int _get_class_choices(struct device *dev, unsigned long
>>> *choices)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handler;
>>> +=C2=A0=C2=A0=C2=A0 int i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&profile_lock);
>>> +=C2=A0=C2=A0=C2=A0 handler =3D dev_get_drvdata(dev);
>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, handler->choices, PLATFORM_PRO=
FILE_LAST)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *choices |=3D BIT(i);
>>
>> Maybe just copying the bitmask would be enough here? In this case we
>> could also drop
>> this function as well.
>
> Right now this could work, but choices and the use of it has gone
> through great lengths to ensure that once there are too many profiles
> it automatically becomes a bigger variable.
>
> =C2=A0=C2=A0=C2=A0=C2=A0unsigned long choices[BITS_TO_LONGS(PLATFORM_PRO=
FILE_LAST)];
>
> So I would rather keep this as is.
>
I think users of this function can do the locking themself and instead use=
 the functions from bitmap.h. Because _get_class_choices() will break once=
 "choices" becomes bigger.

Thanks,
Armin Wolf

>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> =C2=A0 /**
>>> =C2=A0=C2=A0 * name_show - Show the name of the profile handler
>>> =C2=A0=C2=A0 * @dev: The device
>>> @@ -44,9 +84,34 @@ static ssize_t name_show(struct device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ERESTARTSYS;
>>> =C2=A0 }
>>>
>>> +/**
>>> + * choices_show - Show the available profile choices
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to write to
>>> + */
>>> +static ssize_t choices_show(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned long choices =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>> &profile_lock) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D _get_class_choices=
(dev, &choices);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Please directly use the choices field here, no need for a mutex since
>> the choices are static
>> across the lifetime of the platform profile.
>
> But similarly to my other message, the class could be unregistered and
> this needs to be protected.
>
>>
>> Thanks,
>> Armin Wolf
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return _commmon_choices_show(choices, buf);
>>> +}
>>> +
>>> =C2=A0 static DEVICE_ATTR_RO(name);
>>> +static DEVICE_ATTR_RO(choices);
>>> +
>>> =C2=A0 static struct attribute *profile_attrs[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_name.attr,
>>> +=C2=A0=C2=A0=C2=A0 &dev_attr_choices.attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>>> =C2=A0 };
>>> =C2=A0 ATTRIBUTE_GROUPS(profile);
>

