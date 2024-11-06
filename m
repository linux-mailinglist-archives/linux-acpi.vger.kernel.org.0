Return-Path: <linux-acpi+bounces-9367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A98A9BF697
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF151C22A26
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5B20A5E7;
	Wed,  6 Nov 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PcvHh6zd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A8209F3C;
	Wed,  6 Nov 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921658; cv=none; b=ouBZGK/r/nmwcIh9rjAUu4YjnpOdPfS+I7zPm87gAnXWXfj1degFUx6lLYhqeUH5H9nhkHj6y6mIybG7TKWfSYJhoOfTQ2OtusnySjdjhS+V3VarOpNdYrz/8JQVA0UPSgehfodsM9PcszwOmG7rX3z80J86fKbnQac80/T42t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921658; c=relaxed/simple;
	bh=yZbr6t2r/51VOBGcLdopwAHQuZu8xeGQDcebwLwRMLA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aq+jM3UCQASDEA8FtRw5Z3sYK7OJIz8c1Gfox6K9IWWEN/HmZqA8jVSMSsyfew3Oiyc0j1SBvyou5Ah2+HzUFNW5hjAPpUCpPlsgOxLfrJk85rk5i9ZsVv5HHqFowbRVdrCnu2dRL0laZ1fPPQ1Fi3sqScfoAeq77XmlGUTFRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PcvHh6zd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730921587; x=1731526387; i=w_armin@gmx.de;
	bh=NC+6frFK+YWcDsZjV4UHxiwIbgV1D+/UHxIrix9H8CA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PcvHh6zdFLqnLmnuOQ9L83vDW6UE9Vem9vwgjyyHeF/cMmQcjA+UsIg6GvUZPXPH
	 Dmr3F/PIr7Odl5ixM4Dlz3vx9S6MeBLOcoT+JRL6nvfJ/AZsvqXp5AIk7pmFMzPbN
	 hXoGqd25I/h9qRoAB0WwY1WmLVZIiZzd1nH3WNanoTwhKPJfikLUmWmZmvgrle82a
	 Oy7GL+Mcx/DdhPS5CyFdqsFf5JGLEA2cy6BGOgeKv+LcqZ8qnWk1Jg2PcASCWAO39
	 5bNS6mx12H3ZizOV9cGz7sC9Ej5nnrr5fbICYqLKghCYt8nZFwapNz1wOD20avPJY
	 +8xgDf94qW3riLDq2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1trgso41fI-013QBt; Wed, 06
 Nov 2024 20:33:07 +0100
Message-ID: <cbf90e6e-1522-4235-b1fd-90dc54df35d5@gmx.de>
Date: Wed, 6 Nov 2024 20:33:04 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/20] ACPI: platform_profile: Allow multiple handlers
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-19-mario.limonciello@amd.com>
 <42623eed-1220-4cdf-aa7f-3a9777a3da4b@gmx.de>
Content-Language: en-US
In-Reply-To: <42623eed-1220-4cdf-aa7f-3a9777a3da4b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+XvEJZfJJZZ41PGe1l9dnx9BgPiF4v314WbePpZlv4IS10H+YXe
 AWb+j4McYN61/wQewuiiW1kbROk36eUz+ObL18MUUC7wYsxFz8HQNm87haXu0AXIw4q845y
 PYYZlSUZ8YkmT2qlXkTRbdVvbODBMJ3DEw8qq4LALvjIhf6PHy1eLu5yLD++VVcd12GtUcf
 c+Jia7f+rP+LagQsLNnCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kKo2Zz1k/5w=;Ls+NxHyQ+Qqv4RoCvJ7xVc28oM/
 Wu70OcCldxqkWKFdlK+XlfAyNCC22wmzqpGn6BuJySWbF+QcelQ7CEJzwyCSlHcTvSyfEwJU5
 Ndn4FsarVXVkqR8Yiw1mQuagVJ8BsU7Fu6WdDgy/ekY74rF3DgwGQ5jQxG5AoyUSCNj942btW
 EiyVM1k35X0Vu7wc7wz1CKLRrodF3iLnIpI5uuCIF8PNWOrViCP+AIXTCObo7ln4nQxn6IH9o
 3MveOdGgZxfxwn7VZCH9r7mr4msSzD/JwxMGs1ckQjw77Wt9XSYN3FqWXuc2jkrXKr6QcU85D
 5wApwzrNbPMhD/28mZHUHpF4dhg+icHpk8Uk3lNW0YToQXPGKzRu0M3SE7ihnU0NZH4bXisSU
 oJk0MHkNbSnYxZpOslsLSq3G0oHhtbUmwHFXTV3RH+OIIYC0F/znC11bEmx/dB+xWfoZHPIAl
 0LcGOUpcbXkvHvGLGebM6pf1rdK8o6KR/ENCYGVwjclae0mNdTmbLmt4w0rCeJ8+rnmKfOHHQ
 Fk2Y4VA+/XzkQa5QDxmTHQpqU2N/dJ2gqkBr7ZJuzBeJH5AFG5UHsuIQg46WE8aAh+xiZeIj/
 n208OVDcNyufiAPJhBBmUM+F0GjpzjZ5eaiyHSaygIArjcleThgdd0mlgrirTrLXz5iPUmMa/
 f6/MWvOqsigaqEl9gVShAjJ4B/24zZg+DElrvwLxV4i+nkm6q4tzYjW0gm3pJJk9jlvGK1c4r
 bTiBw/iEyqUTuv29zbw6a/UlnpNP5jMbCrutc+eAGY7vdWULUFF4IL/9vGjbhNc40XFMunYSh
 MAw9n7KqvCvTKIvYusxI0u1QMH6MgoMvc06/9j40lQ1KN0usWBBsFnzDrTMhBONDsrDzvcGVe
 bLjtlbb0sOqmw8V8a52LayIwlfsu3pRwS/UppzgJ7Sk+Bzuv03g29HacF

Am 06.11.24 um 20:21 schrieb Armin Wolf:

> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
>
>> Multiple drivers may attempt to register platform profile handlers,
>> but only one may be registered and the behavior is non-deterministic
>> for which one wins.=C2=A0 It's mostly controlled by probing order.
>>
>> This can be problematic if one driver changes CPU settings and another
>> driver notifies the EC for changing fan curves.
>>
>> Modify the ACPI platform profile handler to let multiple drivers
>> register platform profile handlers and abstract this detail from
>> userspace.
>>
>> To avoid undefined behaviors only offer profiles that are commonly
>> advertised across multiple handlers.
>>
>> If any problems occur when changing profiles for any driver, then rever=
t
>> back to the balanced profile, which is now required.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
I just noticed that the following text might need to be removed:

"If any problems occur when changing profiles for any driver, then revert
  back to the balanced profile, which is now required."

Thanks,
Armin Wolf

>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> =C2=A0 drivers/acpi/platform_profile.c | 12 ++----------
>> =C2=A0 1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c
>> b/drivers/acpi/platform_profile.c
>> index 568485e285061..b9eb25f58a2a2 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -10,7 +10,6 @@
>> =C2=A0 #include <linux/platform_profile.h>
>> =C2=A0 #include <linux/sysfs.h>
>>
>> -static struct platform_profile_handler *cur_profile;
>> =C2=A0 static DEFINE_MUTEX(profile_lock);
>>
>> =C2=A0 static const char * const profile_names[] =3D {
>> @@ -368,8 +367,7 @@ static const struct attribute_group
>> platform_profile_group =3D {
>>
>> =C2=A0 void platform_profile_notify(void)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (!cur_profile)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 guard(mutex)(&profile_lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!class_is_registered(&platform_profi=
le_class))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_=
profile");
>> @@ -428,9 +426,6 @@ int platform_profile_register(struct
>> platform_profile_handler *pprof)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(mutex)(&profile_lock);
>> -=C2=A0=C2=A0=C2=A0 /* We can only have one active profile */
>> -=C2=A0=C2=A0=C2=A0 if (cur_profile)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EEXIST;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!class_is_registered(&platform_profi=
le_class)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* class for ind=
ividual handlers */
>> @@ -451,9 +446,9 @@ int platform_profile_register(struct
>> platform_profile_handler *pprof)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(pprof->class_dev))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(p=
prof->class_dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(pprof->class_dev, pprof)=
;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_=
profile");
>>
>> -=C2=A0=C2=A0=C2=A0 cur_profile =3D pprof;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>
>> =C2=A0 cleanup_class:
>> @@ -467,13 +462,10 @@ int platform_profile_remove(struct
>> platform_profile_handler *pprof)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(mutex)(&profile_lock);
>>
>> -=C2=A0=C2=A0=C2=A0 cur_profile =3D NULL;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_=
profile");
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_destroy(&platform_profile_class, =
MKDEV(0, pprof->minor));
>>
>> -=C2=A0=C2=A0=C2=A0 cur_profile =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 EXPORT_SYMBOL_GPL(platform_profile_remove);
>

