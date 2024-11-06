Return-Path: <linux-acpi+bounces-9381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFAA9BF886
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED501C214C2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572E20CCC4;
	Wed,  6 Nov 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JhD4jIlJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818520C303;
	Wed,  6 Nov 2024 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928751; cv=none; b=tFcvWQstdJAgp6P8M1YaRtgJSdZQR4l6YwoKqPKT0DsGGQ7LzGN3mJ6C9iMr0uTZ0Z1u5rl3svgZMg7EA0IBjAljYStKN8ATcF3g/Q+RBgdK7nlwZUZk+7QEyAZyOiG6pYd8R+D7A/RwtHAQ555EOCbqvU2KrdPwewQUfco+O4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928751; c=relaxed/simple;
	bh=gwhlm0CCnwYi/tqwFOQv659Bi7VoLJYF96hPb74QQoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kocL0LFZJe16EW0pFb0g+NwDOQvs74daEeIDLhIGVeAvyz+1JaodtoX22GW2l3JZsll55qacv2ywegJM2ResqPZ8XXSfL/tVE2phy5lm2K7AHwyfN8ZCJQfGxnTbnMqTNtU6G29uqz4f5YGDgvDzMPbNH073To7yty05jkzkhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JhD4jIlJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730928686; x=1731533486; i=w_armin@gmx.de;
	bh=gwhlm0CCnwYi/tqwFOQv659Bi7VoLJYF96hPb74QQoI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JhD4jIlJSSYBbguusVBxMeuMst0Lo4r7MixN2nq2erM2Yw4E/WvXLWAmbcG9QoBq
	 RpFsnxq91NGGPg/8TuqmnW8B8cFn3OcJf17rJbbXHqUKsLMhDLCxE3rMH9dyqMy2T
	 Q4mOSIhW40mSFmyZ/Eg9sWAQz7ECUVbAVx6EtiR3F2RjyaDLE8WQ26NEMKCxkDELb
	 XiU2MJW7B/Oyza/W/j3x6n0KrHTspWHeglIY308CesKUZOfObMP4t3cAzUyeTaU46
	 QaMub3GcJiubFiUfcwGXi0SFEW0MUi1OgH3HranpYSfolsQ5VVP87GNOR3YTP+ITV
	 nva4MXH9OZO1+lzSAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1tDlyC2SRi-003165; Wed, 06
 Nov 2024 22:31:26 +0100
Message-ID: <ffae13ae-ed92-44a0-ae15-b6b941620c8a@gmx.de>
Date: Wed, 6 Nov 2024 22:31:23 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/20] ACPI: platform_profile: Make sure all profile
 handlers agree on profile
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
 <20241105153316.378-17-mario.limonciello@amd.com>
 <a2bde9c6-6aa3-445b-b27b-2338d78d132d@gmx.de>
 <3cbbecf7-bba4-4a45-97da-ec461609b2f9@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3cbbecf7-bba4-4a45-97da-ec461609b2f9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rdO59OfRmgLFb0o/Ei2QWw43xNjk+/uC3OsbcLVnL5+STiOAsX6
 ptwFPk1YkC4G5gByAxH1OWXd3GlukMXON4v9T3zVxe811NY59ugSFDe+qQBq9A1hUKzFVlp
 05IMIMlBwRpteaQIauIP+uE5LTlNzdcTY+JkFBEbCc7VZ5hDAt/OlclojgGkHanabWTxAqB
 RWhqhdZgVFTM3vSa2xwsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S9DIC7RETd8=;SnmWkfpFKp6edPvDdCtfQ8H33qf
 Z+RqYzn+ARQQWAlCEAvuhRP2q7DdA9y/EAogWBDvTHRYyIBd1BDiWtSH4IZSkRjCieuiPkogM
 StJ8Extc5BFJH0bVD80KayRI+MhJw2SDdJ6EuvWQLoXpLZVdgfcUWldWZ+8SZrwrKArWk1WX+
 P3favAkqeqmv7Kbqwpck4N77mX6+stK0hLydabnf/LyIWDys9SS+SOSGwkup0a65Pr4ofnuY+
 I+DUfgNnLiP9dHaWX3L8SvOVyGTcZwXVQcpbrPl+k+G5ZDGG+HvJ4fPWHHrSdeJAdvx1aWZHb
 R5fL1/oLjaQ2geq6Q6MGd8W/LyRTikpZrELrmH83Z4tYffnVZTMa4rbv9o+c7ZbNZKQ5dRG3t
 YhcaeTIz4ToIXrJxU1QgUN8ylxHckJy5eR5ZDwc1D4aMPcc305aUmMiOlupDbp0R9q4CieOVx
 pQENO49UnhEB6nF3/YJ/XMlQEyAimI712S5/XKIdJtNBzsu2X8jbNQwa2NqNzIs5+m4LjYSRq
 cuxAO7i5/IUeZ/igjzsfUdosBMSaR5vc03tWvFQdFlqJOWdLqZG/GygWpEmhuMAcMkN1Wr4FG
 C2E9GykEzEHmA7K6LibKHG/ROQyCsnaewxKcwxQzVafptVNspH4ig2+eDK7wSWzW/dgIO3408
 y64k9Lfm7wZq/UikJVcoN22NzsYDz9qqO00hzNx/liDgKnz73BNGvwMYUwlIq/T1y8C2xjdAu
 m3uFtp7VwCMBmK7f3biKhpaCTV35vuumQE148yLwmYFTFstjTuVL42RRd81//Kdr45xBxSkDy
 1USXJSFXkToQV0jmz9atQ98jwj4MGGVgF/6DFZI3dgwdk=

Am 06.11.24 um 22:25 schrieb Mario Limonciello:

> On 11/6/2024 14:58, Armin Wolf wrote:
>> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
>>
>>> If for any reason multiple profile handlers don't agree on the profile
>>> return the custom profile.
>>>
>>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c | 84
>>> +++++++++++++++++++++------------
>>> =C2=A0 1 file changed, 53 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index d8c2d195106c2..7861fccc2e58c 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -280,55 +280,77 @@ static ssize_t
>>> platform_profile_choices_show(struct device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return _commmon_choices_show(aggregate,=
 buf);
>>> =C2=A0 }
>>>
>>> -static ssize_t platform_profile_show(struct device *dev,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *att=
r,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> +/**
>>> + * _aggregate_profiles - Aggregate the profiles for legacy sysfs
>>> interface
>>> + * @dev: The device
>>> + * @data: The profile to return
>>> + * Return: 0 on success, -errno on failure
>>> + */
>>> +static int _aggregate_profiles(struct device *dev, void *data)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 enum platform_profile_option profile =3D PLATFORM_=
PROFILE_BALANCED;
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option *profile =3D data;
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option val;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>
>>> -=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>> &profile_lock) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cur_profile)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -ENODEV;
>>> +=C2=A0=C2=A0=C2=A0 err =3D get_class_profile(dev, &val);
>>> +=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D cur_profile->profi=
le_get(cur_profile, &profile);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (*profile !=3D PLATFORM_PROFILE_LAST && *profil=
e !=3D val)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROF=
ILE_CUSTOM;
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D val;
>>>
>>> -=C2=A0=C2=A0=C2=A0 /* Check that profile is valid index */
>>> -=C2=A0=C2=A0=C2=A0 if (WARN_ON((profile < 0) || (profile >=3D
>>> ARRAY_SIZE(profile_names))))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>
>> Please check the returned value from profile_get() first before doing
>> the custom platform
>> profile check.
>
> You might have missed it - that's part of get_class_profile() already.
>
You are right, my bad.

>>
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +/**
>>> + * platform_profile_show - Show the current profile for legacy
>>> sysfs interface
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to write to
>>> + * Return: The number of bytes written
>>> + */
>>> +static ssize_t platform_profile_show(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribut=
e *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option profile =3D PLATFORM_=
PROFILE_LAST;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 err =3D class_for_each_device(&platform_profile_cl=
ass, NULL,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &profile, _aggregate_profile=
s);
>>
>> Missing error handling.
>>
>
> Right, got it.
>
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%s\n", profile_=
names[profile]);
>>> =C2=A0 }
>>>
>>> +/**
>>> + * platform_profile_store - Set the profile for legacy sysfs interfac=
e
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to read from
>>> + * @count: The number of bytes to read
>>> + * Return: The number of bytes read
>>> + */
>>> =C2=A0 static ssize_t platform_profile_store(struct device *dev,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t count)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_at=
tribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf,=
 size_t count)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 int err, i;
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Scan for a matching profile */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D sysfs_match_string(profile_names,=
 buf);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i < 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> -
>>> -=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>> &profile_lock) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cur_profile)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -ENODEV;
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check that platform sup=
ports this profile choice */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(i, cur_profi=
le->choices))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EOPNOTSUPP;
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D cur_profile->profi=
le_set(cur_profile, i);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>> +=C2=A0=C2=A0=C2=A0 if (i =3D=3D PLATFORM_PROFILE_CUSTOM) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Custom profile no=
t supported for legacy sysfs
>>> interface\n");
>>
>> This would allow userspace applications to spam the kernel log. Please
>> just return -EINVAL here
>> and document this special case inside the interface specification.
>>
> OK.
>
>> Thanks,
>> Armin Wolf
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>> -=C2=A0=C2=A0=C2=A0 return count;
>>> +=C2=A0=C2=A0=C2=A0 ret =3D class_for_each_device(&platform_profile_cl=
ass, NULL, &i,
>>> _store_class_profile);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ret ? ret : count;
>>> =C2=A0 }
>>>
>>> =C2=A0 static DEVICE_ATTR_RO(platform_profile_choices);
>
>

