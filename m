Return-Path: <linux-acpi+bounces-9455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D09C25CE
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 20:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B48E281421
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B91AA1CD;
	Fri,  8 Nov 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pfLquFoY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA17233D72;
	Fri,  8 Nov 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095149; cv=none; b=gUb4VZwhAwxZCXEoipUTzJTFgfmL6vfuxafhymdmmTWQU9tFfSfW8hkPfVIHzVcOZ+sSy2iHShQ3Ql/N5RyL1y8k9oYT5Z/4SvHwddkxrxqUy9cpsucoRwGWHnZEZpRrkzcml1wf/cN1wPHZ3GYNBUdEKQYGSNVUUuSYlHb6VKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095149; c=relaxed/simple;
	bh=3VAAVHOXBGjYM2CZOnUc49zsY3SSDo4fE0VLAaSkItA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n03CELErtuw3XJ1AvAuk9J/J4cMHHv1sQcHypf4zSdad7jFhSFu8v2KAu8gNq2sVYVSd8Vbh+5wueR8a/NWoUgwQSY83hYFSmtyAz1OFx0IXwZ6Y5z6YuYoqYkZVAgjcaNYaemgsqoSYYJtRgHoF97Df7uEh1GpRNIkh2K1/62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pfLquFoY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731095075; x=1731699875; i=w_armin@gmx.de;
	bh=3VAAVHOXBGjYM2CZOnUc49zsY3SSDo4fE0VLAaSkItA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pfLquFoYvCW6mbqJJriNEPGooSXUVCxcEDbwaogBtWPpJTde1n/DqNBY8fNFeD4z
	 hCKe5NNFkkbrj5uABeEJQ49+pdO1t3i8+CkHPtZn63pJX9wZ/4xgLi9yfNX3jI+ry
	 z6w/YE98LbCZhLm249RhoqxdrCyVrcTnCxucNnl1W4K0ugG2c6Ok8wXbmG7TWuLKp
	 WusM2wfkL1aEAW1P+vzqf/JQsTjRkhWAnhz7bJV5YcA/4fIhrQGl1Vwr9xYdo0ms6
	 2hbWGLq6rbG1IItfEEtCZVi/EBVROGM8KOoX8JIZMamh3kb2E7GdK6tKM2dk4UPg1
	 FVxdiqI8GUQI2Jjwxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1t06yG3Les-007if1; Fri, 08
 Nov 2024 20:44:34 +0100
Message-ID: <ba57628a-91d1-4e7c-8ebc-c5dc9db3d195@gmx.de>
Date: Fri, 8 Nov 2024 20:44:30 +0100
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
 <0ffe9b8b-814e-4b5a-a960-22797e327b4a@gmx.de>
 <22fdc5d1-c082-4e60-a6c9-c67bad295fed@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <22fdc5d1-c082-4e60-a6c9-c67bad295fed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lIEYHbNB4R/fgBEMz2UOAJgojN3PwXPzWR1uK9ND5PpBYPMpgVB
 bkcLlPHTp9AfohwuOAAiIGuaUnjOjHLDeGaAkkB5iZVm8zKkeo3FjJe3aCR9jkWm81nQx/3
 i6T4WDZ+xYTrMWgriQnri6hlIH9cuEc9jICgOUNfz+AKbkkzP7av7rwxLKrWdMhvKxc1p4/
 2o6d8GaDQaUoM7Ykbwa4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qeoBuJIKW5U=;y9E5JNl2n8TCyxG8Z6FgzAbpMRL
 u/9u4ABbGDwqaG0lgSYvNpqd3AnbEbELElX5cfh7o7YDBucQgCazfsRjbOLcfi335/pcuQHvs
 lPDCFkdb1z8MU+rJ4hkpj8U+aD4rpoKLPermXbIwp0e9RNpzBZWtrBAunhqZ5OxiD0tu3LMSY
 hzBUCKg61r3GJnjpJgia4lVyeIXDD93VO67DyTTQpUATEGeGhwN3Ol5yOyQFetdJJd5KpbE+z
 E+L1kwT55JWIIM6LBAA88GEBFsnUGMYP9WIGy+jzq/cF3CifaRNMYucnhcUcOyW00Q8nV0VP5
 yChXo1NZ6bh0hDHvcZb7QW5kssRJ9IbwtI3AHfCNSPi62/yrcPRcvIWMpY+xgWf6XizJ/MbJ9
 KhAxsGqpyV2IvIkSGq0xEIcteljQv4W9uMBw1sWSaRfXvEyM/trRb00gFWnLEEc4ZSxcSLcZC
 Yx+3Fl4hi/NcfXWbXjrUoSW7QYBsAGCrlMpPK7Z9qbK66ughCa3L/TMn7+w8Ij4jPxPoxcEiO
 YfYjZLRFvgwghE1CctQ6pKN9bDxABrRu6rTGfq7eim2pWzJ0wawQ0RGgzdBqDb4hMjiRlwPuN
 RS1LbUgI94gohuNznIqNiL2/Kzrc8dq7+ovYS1bJNZ3gKJF0iIsX2GcIYrvCkiI4zr5mhmhmK
 WwJ4AytNEmWygL53+jfHs6jX+BhaKVed9t9B0++9MnoRMszjaHhJ7Lqo6jj80no+hMOctxgKC
 JAS6RiTHV0oTS1IRHI1vfKCNFU6nZi6Cv7dFgbfYsdCsTd28K1QlaQtbXVyIiFgiCB+hp01dF
 bG8hCw9Kad554td10YnEFLsWhkFuliXTzhcvhGe6OaJPzBJrwOC1vQwxTXMh/TexYDr19fExj
 jC29CJdbKrpkGSLmvI9U3hPGOSoNcanJxg1x+m6gzt5pFvrxv7wovaNmR

Am 08.11.24 um 20:25 schrieb Mario Limonciello:

> On 11/8/2024 12:06, Armin Wolf wrote:
>> Am 07.11.24 um 23:09 schrieb Mario Limonciello:
>>
>>> On 11/7/2024 02:28, Armin Wolf wrote:
>>>> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
>>>>
>>>>> The `choices` file will show all possible choices that a given
>>>>> platform
>>>>> profile handler can support.
>>>>>
>>>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>> v5:
>>>>> =C2=A0 * Fix kdoc
>>>>> =C2=A0 * Add tag
>>>>> =C2=A0 * Fix whitespace
>>>>> =C2=A0 * Adjust mutex use
>>>>> ---
>>>>> =C2=A0 drivers/acpi/platform_profile.c | 65
>>>>> +++++++++++++++++++++++++++++++++
>>>>> =C2=A0 1 file changed, 65 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>>>> platform_profile.c
>>>>> index f605c2bd35c68..5e0bb91c5f451 100644
>>>>> --- a/drivers/acpi/platform_profile.c
>>>>> +++ b/drivers/acpi/platform_profile.c
>>>>> @@ -25,6 +25,46 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D
>>>>> PLATFORM_PROFILE_LAST);
>>>>>
>>>>> =C2=A0 static DEFINE_IDA(platform_profile_ida);
>>>>>
>>>>> +/**
>>>>> + * _commmon_choices_show - Show the available profile choices
>>>>> + * @choices: The available profile choices
>>>>> + * @buf: The buffer to write to
>>>>> + * Return: The number of bytes written
>>>>> + */
>>>>> +static ssize_t _commmon_choices_show(unsigned long choices, char
>>>>> *buf)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 int i, len =3D 0;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, &choices, PLATFORM_PROFILE_L=
AST) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 len +=3D sysfs_emit_at(buf, len, "\n");
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return len;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * _get_class_choices - Get the available profile choices for a
>>>>> class device
>>>>> + * @dev: The class device
>>>>> + * @choices: Pointer to return the available profile choices
>>>>> + * Return: The available profile choices
>>>>> + */
>>>>> +static int _get_class_choices(struct device *dev, unsigned long
>>>>> *choices)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handler;
>>>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&profile_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 handler =3D dev_get_drvdata(dev);
>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, handler->choices, PLATFORM_P=
ROFILE_LAST)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *choices |=3D BIT(i);
>>>>
>>>> Maybe just copying the bitmask would be enough here? In this case we
>>>> could also drop
>>>> this function as well.
>>>
>>> Right now this could work, but choices and the use of it has gone
>>> through great lengths to ensure that once there are too many profiles
>>> it automatically becomes a bigger variable.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0unsigned long choices[BITS_TO_LONGS(PLATFORM_P=
ROFILE_LAST)];
>>>
>>> So I would rather keep this as is.
>>>
>> I think users of this function can do the locking themself and
>> instead use the functions from bitmap.h. Because _get_class_choices()
>> will break once "choices" becomes bigger.
>>
>
> I am thinking it's better to just switch explicitly to an 'unsigned
> long' and add a static check that all profiles fit.=C2=A0 If ever they
> don't fit, the code can be overhauled at that point.
>
> And yes _get_class_choices can go away then, and this is a lot simpler.

Ok.


