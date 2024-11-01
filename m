Return-Path: <linux-acpi+bounces-9214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94C9B88F6
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 02:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8536C283263
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 01:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F122136349;
	Fri,  1 Nov 2024 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="L3fUlF50"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD98134BD;
	Fri,  1 Nov 2024 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426189; cv=none; b=sDn+iAByPaJztBTXtd1+EvB0v6fhA6fteCXoC4raxKAaVHk9VbGHs8r2i5ESYaBMQ+wMv8CmnT25jrYzyExm5uXoQ+tWYQpTJJ0O9A3nS8jdfB6w2Q6NbNw25MlqN+0jfVbAU/QIFDHhiufb68hueZj5JZMWxewUpeJGSEXwdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426189; c=relaxed/simple;
	bh=nJ4Pe+K3BsKDJLNuhG83I1KCqF6cshQClQB6adT703g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyVopkou35Q1s7s1i9vWwRp0uN4H9FNulFCc8AIaqk8Ld5TM/Rp9ukmOfZUKy+34zGYh27RWNFCiuj7r1bG0ydNYUQ2dZLU9X0lFj5FneH4TfuKW2haD/T5yKpx2b2RwKj5y0w8FCQ7MVEowNivfly4MTZpIvmd7cPbCav93m8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=L3fUlF50; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730426102; x=1731030902; i=w_armin@gmx.de;
	bh=nJ4Pe+K3BsKDJLNuhG83I1KCqF6cshQClQB6adT703g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L3fUlF50K5iiGVAlPhng2/iQn5HTk+0b3CgBLyFEidQEvNdfyQKZ1l3ILlFdG9jR
	 0jyfMlB+JtT6/VBjslfsdG1YizbdTLrvXZv5u682EPldjqve3UFBy47HwpkWaiyfh
	 kwvkIX3xzHAXpSvb98/2P8AxSmFH460qS8HjwXQGRIm3pmvaAi96hsfWss1z2ZYFB
	 1l1H6u98DtbQLv792Vb6TBPjuBBZE3m8HHz69koCahA23MosR0831Sej6/4c3nxwd
	 6QU5Z0F7FWPzqo3VRGbCOce+Gv0pcdX41jOn6RDfULYHhF8zecuYTFVsE5KMH01Zz
	 OjmX54myE8n/eZddyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1tnkpt3swO-00wlGP; Fri, 01
 Nov 2024 02:55:02 +0100
Message-ID: <89fe1a59-506b-46c5-be5f-5440ff405abc@gmx.de>
Date: Fri, 1 Nov 2024 02:54:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/22] ACPI: platform_profile: Register class device
 for platform profile handlers
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
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-21-mario.limonciello@amd.com>
 <9fdcfdb4-bbdd-4f6a-9a69-73dceac7b14b@gmx.de>
 <d9a19f6f-59bc-4ed0-8f9f-8a4fca195d80@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <d9a19f6f-59bc-4ed0-8f9f-8a4fca195d80@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2lxWgS8KyrGjGR0firJEskazP1eE4taWGmEHc9c+aw3LFG7fxH6
 IcrtPdhqByST3EO1BokmpbhWJ4yCN0ttKSBCcbgFfZhe2LOEYOf0qaZldB9FP6Gpt2FRDs5
 XAjErh6j6DyYpMB81aL+nvYs3Xu2Q1DNCel7QOItTPOmF8jddGVRkoTaBqhU5SWEYWN1mFf
 9WvlSfnyVXJC7xKfywiVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LE67b9Mh7wI=;mJmIlbo//wt3MCDSUy86QRRwrzB
 1c96ADT+Cn9Iy6M5DkKgo4xTto2gE9wcgh8lTE4EbM3y959/uxHMImb7LUne90duMerAfvUSD
 TxQs9ZImMWAI5o6D6tV0xzfHpx4s1pwMHYhs9zaszL22BcU2luJupChSNtT0cHJ7MacxNhdPj
 evfu5ASHWmjbyoqWoeMVzcgxwA6Zrpl4Kc/h41KdyvCI29IcdBteDdFAr9pXBkMD69DkDNji5
 b0EQ2x5XGq2NTntir21qQUSzSre/XVdNywsbj78VOH1ni4AXQvYI0SN0JyANsBs6baTmcc7yz
 me//ArVNu6Z2VT/5Xo+8mv1OBwzhWHTzwqIjKlwiT6r44eYonw8CUQNPSKJAXQQ4OvKjx4Hlp
 zZ6ztUlhadnP71mhnPgRB+nho4GW6R19yZh8ulOw13hcnewbBodG7u7hxFdG3c8Wz4qAWJ+uc
 rrPF5v2XZIXBwV14RbV5rU/9hWXW7N9bjh1ULwQLx0zWL9oVNbjZq70Dwn6F/D8H9HJsWMS0i
 bY/HidaJ9V/hKNeofEv4wSYK4/AJHrF6ze7rO9TLE5vrsDGsp6aO0BGtx7j+aKkhsTz9FeSuk
 HT5R7dkvPP/6XPaf9Tvqru4Rsg1cIlhLEW8EdPxTpuiRqwGyF5migMYdAHRy8/7RTfBtOmE2d
 7nnySHfTjC1C9f06J2TTgQzuNwauu5AqIti1A8zqZXPd9AOzJ0l0bdzVKvGG4mNxwJsQNxNNA
 MHYRUqbwTkZGXFmfXiAUGMzUnENUQqV1bTpJs5Pcksm+nv/P+zKaVQigiHs0iGo3CR5/yu3Zc
 l1w9UBZYN17duy6+gkugFDax8bOHQBgag3pvVAMLQwjE8=

Am 31.10.24 um 22:54 schrieb Mario Limonciello:

> On 10/31/2024 15:55, Armin Wolf wrote:
>> Am 31.10.24 um 05:09 schrieb Mario Limonciello:
>>
>>> The "platform_profile" class device has the exact same semantics as th=
e
>>> platform profile files in /sys/firmware/acpi/ but it reflects values
>>> only
>>> present for a single platform profile handler.
>>>
>>> The expectation is that legacy userspace can change the profile for al=
l
>>> handlers in /sys/firmware/acpi/platform_profile and can change it for
>>> individual handlers by /sys/class/platform_profile/*.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c=C2=A0 | 93
>>> ++++++++++++++++++++++++++++----
>>> =C2=A0 include/linux/platform_profile.h |=C2=A0 2 +
>>> =C2=A0 2 files changed, 85 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index 9b681884ae324..1cc8182930dde 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -24,13 +24,24 @@ static const char * const profile_names[] =3D {
>>> =C2=A0 };
>>> =C2=A0 static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE=
_LAST);
>>>
>>> +static DEFINE_IDR(platform_profile_minor_idr);
>>> +
>>> +static const struct class platform_profile_class =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "platform-profile",
>>> +};
>>> +
>>> =C2=A0 static bool platform_profile_is_registered(void)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&profile_lock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !list_empty(&platform_profile_ha=
ndler_list);
>>> =C2=A0 }
>>>
>>> -static unsigned long platform_profile_get_choices(void)
>>> +static bool platform_profile_is_class_device(struct device *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return dev && dev->class =3D=3D &platform_profile_=
class;
>>> +}
>>> +
>>> +static unsigned long platform_profile_get_choices(struct device *dev)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handle=
r;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long aggregate =3D 0;
>>> @@ -40,6 +51,9 @@ static unsigned long
>>> platform_profile_get_choices(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(handler, &platform_=
profile_handler_list,
>>> list) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long i=
ndividual =3D 0;
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if called from a class =
attribute then only match that
>>> one */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (platform_profile_is_cl=
ass_device(dev) && handler->dev
>>> !=3D dev->parent)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>>
>> I do not like how the sysfs attributes for the platform-profile class
>> are handled:
>>
>> 1. We should use .dev_groups instead of manually registering the
>> sysfs attributes.
>> 2. Can we name the sysfs attributes for the class a bit differently
>> ("profile_choices" and "profile")
>> =C2=A0=C2=A0=C2=A0 and use separate store/show functions for those?
>
> Sure.
>
>> 3. Why do we still need platform_profile_handler_list?
>
> The main reason for the list is for iteration and checking if it's empty=
.
> I guess class_for_each_device() could serve the same purpose, but this
> patch probably needs to be way earlier in the series then.
>
Maybe we can introduce the class earlier. Basically we could:

1. Extend the public API.
2. Introduce the class infrastructure (but still block multiple handlers).
3. Introduce the ability to register multiple handlers.

This would allow for relying more on the class infrastructure for things l=
ike
device iteration, etc.

Thanks,
Armin Wolf

>>
>> This would allow us to get rid of platform_profile_is_class_device().
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_set_bi=
t(i, handler->choices, PLATFORM_PROFILE_LAST)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 individual |=3D BIT(i);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!aggregate)
>>> @@ -51,7 +65,7 @@ static unsigned long
>>> platform_profile_get_choices(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return aggregate;
>>> =C2=A0 }
>>>
>>> -static int platform_profile_get_active(enum platform_profile_option
>>> *profile)
>>> +static int platform_profile_get_active(struct device *dev, enum
>>> platform_profile_option *profile)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handle=
r;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option active =3D=
 PLATFORM_PROFILE_LAST;
>>> @@ -60,6 +74,8 @@ static int platform_profile_get_active(enum
>>> platform_profile_option *profile)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&profile_lock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(handler, &platform_=
profile_handler_list,
>>> list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (platform_profile_is_cl=
ass_device(dev) && handler->dev
>>> !=3D dev->parent)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D handler=
->profile_get(handler, &val);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pr_err("Failed to get profile for handler %s\n",
>>> handler->name);
>>> @@ -69,6 +85,10 @@ static int platform_profile_get_active(enum
>>> platform_profile_option *profile)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON(val=
 >=3D PLATFORM_PROFILE_LAST))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EINVAL;
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the profiles ar=
e different for class devices then
>>> this must
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * show "custom" to l=
egacy sysfs interface
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (active !=3D=
 val && active !=3D PLATFORM_PROFILE_LAST) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *profile =3D PLATFORM_PROFILE_CUSTOM;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return 0;
>>> @@ -90,7 +110,7 @@ static ssize_t
>>> platform_profile_choices_show(struct device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -E=
RESTARTSYS, &profile_lock)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices =3D platform_profi=
le_get_choices();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices =3D platform_profi=
le_get_choices(dev);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, &choices, PLATFORM_=
PROFILE_LAST) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len =3D=3D =
0)
>>> @@ -113,7 +133,7 @@ static ssize_t platform_profile_show(struct
>>> device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -E=
RESTARTSYS,
>>> &profile_lock) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!platform_p=
rofile_is_registered())
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D platform_profile_g=
et_active(&profile);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D platform_profile_g=
et_active(dev, &profile);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return err;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -138,12 +158,22 @@ static ssize_t platform_profile_store(struct
>>> device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!platform_p=
rofile_is_registered())
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check that all handlers=
 support this profile choice */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices =3D platform_profi=
le_get_choices();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* don't allow setting cus=
tom to legacy sysfs interface */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!platform_profile_is_c=
lass_device(dev) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 i =3D=3D PLATFORM_PROFILE_CUSTOM) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
_warn("Custom profile not supported for legacy sysfs
>>> interface\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check that applicable h=
andlers support this profile
>>> choice */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices =3D platform_profi=
le_get_choices(dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(i=
, &choices))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EOPNOTSUPP;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_e=
ntry(handler,
>>> &platform_profile_handler_list, list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (platform_profile_is_class_device(dev) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 handler->dev !=3D dev->parent)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 err =3D handler->profile_set(handler, i);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (err) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed to set profile for handle=
r %s\n",
>>> handler->name);
>>> @@ -152,6 +182,9 @@ static ssize_t platform_profile_store(struct
>>> device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 list_for_each_entry_continue_reverse(handler,
>>> &platform_profile_handler_list, list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (platform_profile_is_class_device(dev) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handler->dev !=3D dev->paren=
t)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (handler->profile_set(handler,
>>> PLATFORM_PROFILE_BALANCED))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed t=
o revert profile for handler
>>> %s\n",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 handler->name);
>>> @@ -194,11 +227,11 @@ int platform_profile_cycle(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -E=
RESTARTSYS,
>>> &profile_lock) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D platform_profile_g=
et_active(&profile);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D platform_profile_g=
et_active(NULL, &profile);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return err;
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices =3D platform_profi=
le_get_choices();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices =3D platform_profi=
le_get_choices(NULL);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D find_n=
ext_bit_wrap(&choices,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PLAT=
FORM_PROFILE_LAST,
>>> @@ -228,6 +261,7 @@ EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>>
>>> =C2=A0 int platform_profile_register(struct platform_profile_handler *=
pprof)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 bool registered;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Sanity check the profile handler */
>>> @@ -250,14 +284,49 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cur_profile)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EEXIST;
>>>
>>> -=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group(acpi_kobj, &platform_pr=
ofile_group);
>>> +=C2=A0=C2=A0=C2=A0 registered =3D platform_profile_is_registered();
>>> +=C2=A0=C2=A0=C2=A0 if (!registered) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* class for individual ha=
ndlers */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D class_register(&pl=
atform_profile_class);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>
>> Why do we need to unregister the class here? From my point of view,
>> having a empty class if no
>> platform profiles are registered is totally fine.
>
> Hmm, OK.
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* legacy sysfs files */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group=
(acpi_kobj, &platform_profile_group);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to cleanup_class;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* create class interface for individual handler *=
/
>>> +=C2=A0=C2=A0=C2=A0 pprof->minor =3D idr_alloc(&platform_profile_minor=
_idr, pprof, 0,
>>> 0, GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 pprof->class_dev =3D device_create(&platform_profi=
le_class,
>>> pprof- >dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MKDEV(0, pprof->minor)=
, NULL,
>>> "platform-profile- %s",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pprof->name);
>>
>> I would suggest that the name of the class devices should not contain
>> the platform profile name,
>> as this would mean that two platform profile handlers cannot have the
>> same name.
>>
>> Maybe using "platform-profile-<minor>" would be a better solution
>> here? The name can instead be
>> read using an additional sysfs property.
>
> Sure makes sense.
>
>>
>> Thanks,
>> Armin Wolf
>>
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(pprof->class_dev)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR(pprof->cla=
ss_dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup_legacy;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group(&pprof->class_dev->kobj=
,
>>> &platform_profile_group);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup_device;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&pprof->list, &platform_p=
rofile_handler_list);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform=
_profile");
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D pprof;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +cleanup_device:
>>> +=C2=A0=C2=A0=C2=A0 device_destroy(&platform_profile_class, MKDEV(0, p=
prof->minor));
>>> +
>>> +cleanup_legacy:
>>> +=C2=A0=C2=A0=C2=A0 if (!registered)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_remove_group(acpi_ko=
bj, &platform_profile_group);
>>> +cleanup_class:
>>> +=C2=A0=C2=A0=C2=A0 if (!registered)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 class_unregister(&platform=
_profile_class);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return err;
>>> =C2=A0 }
>>> =C2=A0 EXPORT_SYMBOL_GPL(platform_profile_register);
>>>
>>> @@ -270,6 +339,10 @@ int platform_profile_remove(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D NULL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform=
_profile");
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysfs_remove_group(&pprof->class_dev->kobj,
>>> &platform_profile_group);
>>> +=C2=A0=C2=A0=C2=A0 device_destroy(&platform_profile_class, MKDEV(0, p=
prof->minor));
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!platform_profile_is_registered())
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_remove_gr=
oup(acpi_kobj, &platform_profile_group);
>>>
>>> diff --git a/include/linux/platform_profile.h b/include/linux/
>>> platform_profile.h
>>> index da009c8a402c9..764c4812ef759 100644
>>> --- a/include/linux/platform_profile.h
>>> +++ b/include/linux/platform_profile.h
>>> @@ -30,6 +30,8 @@ enum platform_profile_option {
>>> =C2=A0 struct platform_profile_handler {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev;
>>> +=C2=A0=C2=A0=C2=A0 struct device *class_dev;
>>> +=C2=A0=C2=A0=C2=A0 int minor;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long choices[BITS_TO_LONGS(PLA=
TFORM_PROFILE_LAST)];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head list;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*profile_get)(struct platform_prof=
ile_handler *pprof,
>
>

