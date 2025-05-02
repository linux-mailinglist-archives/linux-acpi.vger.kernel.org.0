Return-Path: <linux-acpi+bounces-13425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3CCAA7C2B
	for <lists+linux-acpi@lfdr.de>; Sat,  3 May 2025 00:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EE53AC2A2
	for <lists+linux-acpi@lfdr.de>; Fri,  2 May 2025 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58450219EA5;
	Fri,  2 May 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cjD5Za7V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CD1E32D5;
	Fri,  2 May 2025 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746224997; cv=none; b=pXRE4cO6hQ4mWIlwbdgaJnhZv3vjL2GbqeBkzzDnSocklJpHSi3Nvvgtfy+zt/H520sKhgpKiuVdtktWm8U34HjbQTaIz8c8K8lgIhvyh+SMoSn4pMFvb26iZuzDMitQ5ZY/ZSwpGWwg+BYrKb6cw+zZLzY6918lozjStZwVFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746224997; c=relaxed/simple;
	bh=12slEHSSydirYvv1zO5VNqnzmBNqIh+tj6oaFB5Imfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap7DOYC2hciTacqywOcUD/kCkV2f6owUOGqua1mY8PlQnmXYadVWqbXmS9zzZz6ADUCPjUuP05egKBxmydr4tS5jXQ230tPi6RwU7HrlzUE5nm6VZcxyW9L+SAonotcE8rnoBIOlwUWVqtaFjbuIvqLejULQFQPUVceSuOs7LeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cjD5Za7V; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746224984; x=1746829784; i=w_armin@gmx.de;
	bh=XOY5mknf5eww30NwncIbeluV8XJxpGodV7W3OS8gW6o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cjD5Za7V8M+lejD0s3VxYEQhHItuFx1snseRX4JLJoxRwOV4XUtQ8qBYVuvIx0PP
	 bOsO+dSkPbn2qTcxQh384NkKUMT1of1MljUr5W02LIqZPbUNGH2rE28yjKI5QMDn9
	 9PpXFR5x9xu7d3QWUCDD4a3TDJBOQyw7Fti9vPkmIGJEcSbjAz05W4Ugzvz5PiE8F
	 2NDB0Qiy3Lfb/25Vqp86pexBKgFu3WbeApPN+KJgIzCm6e6e5NjSf/VZi67nznt3f
	 lvLqphBJXL2ESYY2ra5k2wGTmhRrhdkp+wPbAEkedsglQWZGkBj/v+85exoN/j+F+
	 3pEAwOU/glrhN6z5zQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1ukaYV0qqR-00bfTI; Sat, 03
 May 2025 00:29:44 +0200
Message-ID: <5cec046e-c495-4517-82c8-83ae3cdb63a1@gmx.de>
Date: Sat, 3 May 2025 00:29:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control
 method
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250410165456.4173-1-W_Armin@gmx.de>
 <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
 <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
 <90cba8fa-e6a9-4dab-a4ea-fa96d570a870@gmx.de>
 <c8127d88-194a-4a23-b22e-040e2c6b3e9b@gmx.de>
 <CAJZ5v0icUnepOwb87k44nAt1ZwfHp_BqSBzS-TrQWJ_4E3Ls=g@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0icUnepOwb87k44nAt1ZwfHp_BqSBzS-TrQWJ_4E3Ls=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S0g7n5IwUOhVBiDy+0LwI6pj2YBzt7DthiJi91tpzvSwhAzyRlG
 Qz+jHjyTWythb57tH2PqCVwToFGsMLDmRdBFs5z9qbVLFbSjtSMPwFiaOXjfr1xRAkR2VZj
 ZV3GkSvhAcvp/UjqN/4svAq9QB2Aiu3+Y8SfNO/AcsrOZ/Xh9P9yLEH8QAvmHXY7hiu+Ef6
 07fxnOkQk4c6YiJeGwUiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NP8dYZINHec=;UQEVBJICDfb59P6qPzwxSFDOPtf
 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

Am 28.04.25 um 14:34 schrieb Rafael J. Wysocki:

> On Mon, Apr 28, 2025 at 2:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 27.04.25 um 00:52 schrieb Armin Wolf:
>>
>>> Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:
>>>
>>>> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> w=
rote:
>>>>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
>>>>>
>>>>>> The ACPI specification defines an interface for the operating syste=
m
>>>>>> to change the preferred cooling mode of a given ACPI thermal zone.
>>>>>> This interface takes the form of a special ACPI control method call=
ed
>>>>>> _SCP (see section 11.4.13 for details) and is already supported by =
the
>>>>>> ACPI thermal driver.
>>>>>>
>>>>>> However this support as many issues:
>>>>>>
>>>>>>     - the kernel advertises support for the "3.0 _SCP Extensions"
>>>>>> yet the
>>>>>>       ACPI thermal driver does not support those extensions. This m=
ay
>>>>>>       confuse the ACPI firmware.
>>>>>>
>>>>>>     - the execution of the _SCP control method happens after the dr=
iver
>>>>>>       retrieved the trip point values. This conflicts with the ACPI
>>>>>>       specification:
>>>>>>
>>>>>>         "OSPM will automatically evaluate _ACx and _PSV objects aft=
er
>>>>>>          executing _SCP."
>>>>>>
>>>>>>     - the cooling mode is hardcoded to active cooling and cannot be
>>>>>>       changed by the user.
>>>>>>
>>>>>> Those issues are fixed in this patch series. In the end the user
>>>>>> will be able to tell the ACPI firmware wether he prefers active or
>>>>>> passive cooling. This setting will also be interesting for
>>>>>> applications like TLP (https://linrunner.de/tlp/index.html).
>>>>>>
>>>>>> The whole series was tested on various devices supporting the _SCP
>>>>>> control method and on a device without the _SCP control method and
>>>>>> appears to work flawlessly.
>>>>> Any updates on this? I can proof that the new interface for setting
>>>>> the cooling mode
>>>>> works. Additionally the first two patches fix two issues inside the
>>>>> underlying code
>>>>> itself, so having them inside the mainline tree would be beneficial
>>>>> to users.
>>>> Sure.
>>>>
>>>> I'm going to get to them next week, probably on Monday.
>>> Ok, thanks.
>>>
>>> Armin Wolf
>>>
>> I am a bit ashamed of myself but i think we need to put this patch seri=
es on hold after all :(.
>>
>> The reason of this is that i am confused by the ACPI specification rega=
rding _SCP:
>>
>>          11.1.2.1. OSPM Change of Cooling Policy
>>
>>          When OSPM changes the platform=E2=80=99s cooling policy from o=
ne cooling mode to the other, the following occurs:
>>
>>          1. OSPM notifies the platform of the new cooling mode by runni=
ng the Set Cooling Policy (_SCP) control method in all thermal zones and i=
nvoking the OS-specific Set Cooling Policy interface to all participating =
devices in each thermal zone.
>>
>>          2. Thresholds are updated in the hardware and OSPM is notified=
 of the change.
>>
>>          3. OSPM re-evaluates the active and passive cooling temperatur=
e trip points for the zone and all devices in the zone to obtain the new t=
emperature thresholds.
>>
>> This section of the ACPI specification tells me that we need to evaluat=
e the _SCP control method of all ACPI thermal zones
>> at the same time, yet section 11.4.13. tells me that each _SCP control =
methods belongs to the individual thermal zone.
>>
>> The reason why i am concerned by this is because Windows adheres to sec=
tion 11.1.2.1. and only exposes this setting
>> as a global tunable. This might cause device manufacturers to depend on=
 this behavior and lead to strange things
>> should two thermal zones have different _SCP settings.
>>
>> I will ask the UEFI mailing list which behavior is expected by the ACPI=
 specification. Until then i suggest that
>> we put this patch series on hold.
> Sure, no problem.
>
> Please resend it when you think it is good to go.
>
> Thanks!

Alright, the UEFI mailing list gave no response, so i am kind of stuck.

It seems that many firmware implementation only have a single cooling poli=
cy register which is set by all _SCP control methods inside the whole syst=
em.
The reason for this seems to be that Windows threats this setting as globa=
l, but the ACPI specification seemingly does not directly mandate this.

Do you thing we should take the risk and allow users to control each _SCP =
instance manually?

Apart from that the first two patches should be safe, so you can still pic=
k them. Only the last patch needs some more work.

Thanks,
Armin Wolf


