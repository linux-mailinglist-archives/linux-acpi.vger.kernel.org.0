Return-Path: <linux-acpi+bounces-9654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767EF9D25C1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 13:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB1D1F23DC1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11821CCB58;
	Tue, 19 Nov 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rx+Cs55J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041E1CCB2E;
	Tue, 19 Nov 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019282; cv=none; b=VuTSfpR4DtwSVUuecH0qMldMyFVmcgb8EaX0zAFCqjOdt4MutvtuJqjrrtrLgYNk/AuVBOWN1kQ6Jm3/tFCBtHPBPD4r6+dFxrbQqijRjrQZFQT+qyDcEpOuuj6zSMMHwv+HSuOr+i8EvNX59Dnf2IKEeiSKQfi9r0RKNOqWbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019282; c=relaxed/simple;
	bh=wiDAwSEDccIo/pEeBb3tVGh0uk5CwdsPNV+ewEfeEAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFDWXH0gS2AQn3iGccb1tx4uG2+dnsYQiefBO9gf8yyG7osjdOLp1tLXTPcQO0XRk+Z88OZvRp1UqEA1vC1XXSw+qC+zk+Fv0RBQWDvn1TwNS0eIggv239WvCjCnLCEoU5L4V29XehOGV+uxtjD4EjJyPg2e5uTwSiCdtpcdkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rx+Cs55J; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732019210; x=1732624010; i=w_armin@gmx.de;
	bh=wiDAwSEDccIo/pEeBb3tVGh0uk5CwdsPNV+ewEfeEAs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rx+Cs55JnDdz6MxRfxfdmrSOsw18cgtq57V5n95Ms6RzDcx7CjgxAybZTkw7F87X
	 rWv3+L87qEb/iBxvoUDSU6Ki1sQuhVZ+juKAB5YKcJIms4t2/xtuQ+NLq/RNRZac1
	 4aMXhZEmyBsC1W7V6IxXjWk2FprH3WvWUtOhPzf5JquS+hvMOaEuG23iGwfdvHLFT
	 wr37qinFUdjhIxxWdf9gFATtdDRv52tH6iEjORLoyWSjs3DEunQ5eGQRPxSDjsd1y
	 Kx2Kh2g9Hu3EoG+VsBrXyt50Ez2vghtzen4pJ2v6wo2gbsqi4ogce05B2TEZTXMfU
	 NoGXe6KsEnlqXIz97Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.87.225] ([141.76.181.126]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1tSIdT3uQw-00UuBG; Tue, 19
 Nov 2024 13:26:50 +0100
Message-ID: <77c76379-672b-4367-8491-6ba9bbc1da1a@gmx.de>
Date: Tue, 19 Nov 2024 13:26:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/22] ACPI: platform_profile: Add name attribute to
 class interface
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
 <6b7d2f80-0dde-4f07-b889-fa2cb99f5c88@gmx.de>
 <0ba333c7-6e13-41b1-82ea-588da0161e5e@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <0ba333c7-6e13-41b1-82ea-588da0161e5e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5O2kimKnJheUXsYxNj4SLiDGOnrmTFQ9UPQkQ95al4ipDZIFzew
 J+X4NhzZKNUFXUYxO99IRDd6dJbhnHjxEaszcRb+IO4TqaFkBiBk6IWv3zeadOlBrc5Vzal
 +xbK8GzELRpWiQ2BvWstnNGLdtcPJwaCWysYjRO7Sy4lmp9aEfVyyLvMtLUgIYFHGPdYSNU
 lw+8ZL5bGxIRSBsX4ojuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z46DBAFBHgA=;ZBf33EscqHkMxG89Op4s7QQFBl5
 V4UihANMVZpe3UNdCxrKv/3EYHeCbDGdFb20mqZV2RGJbeUL9F4cBeF9yzBzF3rk+dj+bDoUL
 C3UTlDANngMLmwDNu0S5r6xxzX6pZCyFfmad7SrLJJVv/MmLBdq6vKpVuppkwcdbg6xuEuROF
 8F/P0cAo15c85p9HpNY3Q5vhVCf4yvSWX1pqL5tC7Zp246uonyCkIg+t3snIpbA3XyANrFgz/
 atpN0bUG/Vm+s6QbMQgpvg4OehW+FYAfB2COB/uQaZfVUuXRCv3C3E83RV+YBCAFpmfEdJYtd
 ScwfbHrPrKwyMqsxrui7CiTst/w+Ux976TWwabP8hKNGOZmIUeuKaK0KkWZtoarqcPKiNkTSY
 CoKdgu2Z8c1d+QvZtEKqYDsCEGbTzofEMdpVE7ICQoYR5+8CrApdlzG0jy/K4NfYny5LYoHCc
 Wxy/oVEl8hWXjll/Y5eh/CununpjuLESKzJRt5rTOY3fUrRoi9l0PVF/Lnxdnx0eJxcs2Xv+I
 rsfplcezfu/9ahgR/XHzGsTjbPRRK7TjZi5Si8sHhUu4IywJ5mBt+4aIhgcb4NBaATyaXH7pe
 658/jQaaWACXmWG7cbb/gmvwZo2fOmy6C4adsD/8uOAmov+cfCV2QXtvWHUqDQMicxl3wYQbC
 AMQ9BjYkgObQ/I7zuScfSfIfMB0NFRHfPZiFY3/BSPyvZ+8TEnJsrR8CQGuvtZEl3KaHIS7KQ
 wCtLy9A/M6ag5rWv8TAz6SBRFaavzS8tgK99UFvCiN0a8+eQ/nxp1CskPH86/KxF2svtMEQWM
 1IMAfOImLZROAVqWwNCFwDs6Itc3bDzMPZXL6k3QUqUDmUC+41Ui5Qiz/ZR73KoCQpzCx+9BW
 gqIaR498JZLCmIM4iDVsc8qFEUTXcAnWBmTshtmDdYjSF3Gt73csa3p4Y

Am 19.11.24 um 05:09 schrieb Mario Limonciello:

> On 11/18/2024 18:28, Armin Wolf wrote:
>> Am 18.11.24 um 20:43 schrieb Armin Wolf:
>>
>>> Am 09.11.24 um 05:41 schrieb Mario Limonciello:
>>>
>>>> The name attribute shows the name of the associated platform profile
>>>> handler.
>>>>
>>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> =C2=A0 drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++=
++
>>>> =C2=A0 1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c
>>>> b/drivers/acpi/platform_profile.c
>>>> index ef6af2c655524..4e2eda18f7f5f 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -25,8 +25,35 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D
>>>> PLATFORM_PROFILE_LAST);
>>>>
>>>> =C2=A0 static DEFINE_IDA(platform_profile_ida);
>>>>
>>>> +/**
>>>> + * name_show - Show the name of the profile handler
>>>> + * @dev: The device
>>>> + * @attr: The attribute
>>>> + * @buf: The buffer to write to
>>>> + * Return: The number of bytes written
>>>> + */
>>>> +static ssize_t name_show(struct device *dev,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct device_attribute *attr,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 char *buf)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handler =3D dev_=
get_drvdata(dev);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS=
,
>>>> &profile_lock) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%=
s\n", handler->name);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 return -ERESTARTSYS;
>>>
>>> I still have a bad feeling about the locking inside the class
>>> attributes...
>>>
>>> Can we assume that no sysfs accesses occur after unregistering the
>>> class device?
>>>
>>> Even if this is not the case then the locking fails to protect the
>>> platform_profile_handler here.
>>> If the device is unregistered right after dev_get_drvdata() was
>>> called, then we would sill operate
>>> on possibly stale data once we take the profile_lock.
>>>
>>> Does someone have any clue how sysfs attributes act during removal?
>>>
>> I think i found the answer to my questions inside this patch series:
>> https://lore.kernel.org/linux-kernel/1390951311-15325-1-git-send-email-
>> tj@kernel.org
>>
>> It says that:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernfs / sysfs implement the "sever" sema=
ntic for userland
>> accesses.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0When a node is removed, no further userla=
nd operations are
>> allowed and
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the in-flight ones are drained before rem=
oval is finished. This
>> makes
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0policing post-mortem userland accesses tr=
ivial for its users.
>>
>> In this case taking the profile_lock when reading/writing class
>> attributes seems to be unnecessary.
>> Please remove the unnecessary locking inside the class attributes.
>>
>
> Before I respin a v7, let's make sure we're agreed on which things
> need locking and which don't.
>
> Functions that check if a lock is held:
> _store_class_profile()
> _notify_class_profile()
> get_class_profile()
> _aggregate_choices()
>
> Functions that take a lock:
> name_show()
> choices_show()
> profile_show()
> profile_store()
> platform_profile_choices_show()
> platform_profile_show()
> platform_profile_store()
> platform_profile_cycle()
> platform_profile_register()
> platform_profile_remove()
>
> Functions that don't take or check for a lock (these are intermediary
> and things they call check for one):
> _aggregate_profiles()
> _store_and_notify()
>
> Are you suggesting that basically these 4 can drop taking the lock?
> name_show()
> choices_show()
> profile_show()
> profile_store()
>
> I think the show() ones I can get behind, but I'm worried about
> profile_store(), particularly as it pertains to the other callers of
> _store_class_profile() because it's incongruent how the other callers
> would use it then.
>
> Can we perhaps just drop it for the 3 class attribute show() ones?

I think so, i also remembered that profile_store() needs to keep taking th=
e lock in case platform_profile_cycle() is currently
running.

Can you also remove the second call to dev_get_drvdata() in _store_class_p=
rofile()?

Thanks,
Armin Wolf

>
> LMK.
>
>
>

