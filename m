Return-Path: <linux-acpi+bounces-9453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C49C24B3
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 19:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F83281F3B
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC2194C75;
	Fri,  8 Nov 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="oChClnbi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A070199385;
	Fri,  8 Nov 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089707; cv=none; b=lTApllVTmZhPn1EiheRtEPhBDb1RivZV+G/MFX1E1Uk2pD/QbV+dDv/4GeTBHL2V8MEH+DQn0gVol3crpeCydQJr+YWssifOECMwoon2By0OBBMPbnDL6b3tulcQrB3nOPXWD0Z/m7yVVfU8JG08OVHat3dkwFFT0juQaXgU2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089707; c=relaxed/simple;
	bh=8rtzwJu/kJY9rYTx+7yTtQQljUGAGzlP84nCEJes/+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4UJJ5I7AFrzn7rXfiNFHmAgw6AsMAn43GCPWBYpqdFje1iOaA9uibmH0s+3veVjsrSGvMQ+TG276NXerHLWn2CeRPf508+QQY73F1LrWUgz8axg1LAAlvm0ivqrHn0bTN8Q2ec3bu4d3KADrpIRlQDxhWd0o1gJfwa8Tl7fYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=oChClnbi; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731089637; x=1731694437; i=w_armin@gmx.de;
	bh=8rtzwJu/kJY9rYTx+7yTtQQljUGAGzlP84nCEJes/+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oChClnbiDiSzn5nyu7OsvxUVKh5CPsHQro5O+86LnlCKFZuH38e3mxqrq3HOp3WJ
	 2s753g9P/Xh1zYxoXGGUuKm2MqyddTLZuRObmRcssmVhWEfA6zldWJR7QO1kwwENZ
	 IOb/nCIndd5f3Pyug2FgplMh6jqJvJSx6C5wM6Rm1FimHSBn80BnQuInahJnx5jII
	 X+wi7XeGgpzYfodzUTghWc8kewDTaEKmZlB9eFwQT5Kt+OL5wPUWgSeoLgqmi7RnA
	 BgnwpYVcq2UfXPc+PtQTbMD77IfRzz1iAtEYrYCLUAjmQ9pGGjBl1EliK/g+s0JBv
	 lJjZFIt7tVeT/ULs6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1tua3v420F-00scmX; Fri, 08
 Nov 2024 19:13:57 +0100
Message-ID: <5c6f5c8a-09d6-4e6f-bb72-95ad47dee076@gmx.de>
Date: Fri, 8 Nov 2024 19:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Add support for binding ACPI platform profile to
 multiple drivers
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
 <d08d40f5-5482-4e7f-99b4-a5d9e403b828@gmx.de>
 <fde868fa-d664-42bd-b6d4-6c3f2928f1cc@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <fde868fa-d664-42bd-b6d4-6c3f2928f1cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l6Zj3lfjMg+Df4gIPaiNibkfRgSwoxl9Ubn9vIXXR4ZGoY9eXZ9
 HujvpW2jL8GQ188A2qR/NQQX5hKbCLCXyll/ldrFJTgt1lNJkXpkCM/XEQ5ZyRfI94gu8iY
 +kgC+Y6VgVyj3Mx2LSTjl9I35VZoeUZ1DY2glaMKbkO/dDDXnDrvcsZCgVArPgDeyB0art2
 2uTfikoXvB3nl8D9GfjAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bUhSlcX4s8o=;3q+n1tq3O9Gg9cXak9K7ijvCcwR
 8Anv4kBO95l3F81HlAvNiVo+q21rc52xCp+6u9ikSDB2O5FpgV6LNq01pWH21OIC6szFIOQVP
 ziJSfwGA0rMMCTx2UtCyoEDNyFTA4QrkSyhbviqaAkGDx0WFpVR1jLSAmSQIY9RCfr6cZe7Tl
 wx7ikRPSY9SxNO52RoDzUwjoNRkTaQNRRsQmkoqjLFhjJX/Jb6WF4aMFNb7PCWhi5kJ9aIzCW
 Mjb2IwJrPsS1tCvQnYQyMbNSzeTbJJgeNYTlPGr9ss6hV1qcINPWek8sF3fY1Rcq/BM+f1yX9
 kP7LYez1lEERapjnQZYQ0+pq3yp1cjiV0z5vzrFmkgpVRXLNMnCPANbZNF1EJSa8NpkEJjDnt
 SWWjh3ulawaKnz6n/i3A4K5O6zaHNFFrHwG+2fzsS+frxBtNEvYoCkS16o1v/0JdUEpxRBg9v
 VWTsDbV/OUiyZWxvuKwUVNgS3Xf00I3NcDdpdCz+za56efg2fJb5nunj9+HvRTU76S2qjIiBA
 BdUbLSI1C0iHxLRxvT8QOWSXTJmZBls3X25ALW79OWHTUqidBSbMn0ENbOBZIpFBoz0jN1VS+
 Ya7mvs1wIx2oD/FlHcoaqJ2aXPB7xSxEsO2xHQiTokx3D+zGzu0SLtT1aHdvOMPJiZPmGsIOn
 M9lq0B+ineNi3vCT+m6bCr7506EbrSsRnAbe0Y0ExkrzxN3KMLjPt79OanFgHraCaE0J4T3Pk
 Fn/aODg0rFMW3UHDhrpkUJS6em2R4PsJ7pPwsXcXE1o0iiE/SFJWhGD4JXVL/F1YGczMnJJUg
 J5JLw45dsyDsoHcjtcp4QLmw==

Am 07.11.24 um 22:45 schrieb Mario Limonciello:

> On 11/7/2024 03:06, Armin Wolf wrote:
>> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
>>
>>> Currently there are a number of ASUS products on the market that
>>> happen to
>>> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
>>> profile provided by asus-wmi.
>>>
>>> The ACPI platform profile support created by amd-pmf on these ASUS
>>> products is "Function 9" which is specifically for "BIOS or EC
>>> notification" of power slider position. This feature is actively used
>>> by some designs such as Framework 13 and Framework 16.
>>>
>>> On these ASUS designs we keep on quirking more and more of them to tur=
n
>>> off this notification so that asus-wmi can bind.
>>>
>>> This however isn't how Windows works.=C2=A0 "Multiple" things are
>>> notified for
>>> the power slider position. This series adjusts Linux to behave
>>> similarly.
>>>
>>> Multiple drivers can now register an ACPI platform profile and will
>>> react
>>> to set requests.
>>>
>>> To avoid chaos, only positions that are common to both drivers are
>>> accepted when the legacy /sys/firmware/acpi/platform_profile interface
>>> is used.
>>>
>>> This series also adds a new concept of a "custom" profile. This allows
>>> userspace to discover that there are multiple driver handlers that are
>>> configured differently.
>>>
>>> This series also allows dropping all of the PMF quirks from amd-pmf.
>>
>> Thank you for this patch series. The overall design seems good to me,
>> but i think
>> you forgot to extend platform_profile_notify().
>
> What did you have in mind?=C2=A0 platform_profile_notify() is called fro=
m
> drivers and just used to notify the legacy sysfs in the event of a
> change.
>
> Were you thinking it also needs to notify the class device perhaps?
>
If platform_profile_notify() only notifies the legacy sysfs interface, the=
n userspace applications are forced to continue using the legacy sysfs int=
erface
for receiving notifications.

Thanks,
Armin Wolf

>>
>> Thanks,
>> Armin Wolf
>>
>>> ---
>>> v5:
>>> =C2=A0 * Adjust mutex handling
>>> =C2=A0 * Add missing error handling
>>> =C2=A0 * Drop dev member
>>> =C2=A0 * Add cleanup handling for module unload
>>> =C2=A0 * Fix crash on accessing legacy files after all drivers unloade=
d
>>>
>>> Mario Limonciello (20):
>>> =C2=A0=C2=A0 ACPI: platform-profile: Add a name member to handlers
>>> =C2=A0=C2=A0 platform/x86/dell: dell-pc: Create platform device
>>> =C2=A0=C2=A0 ACPI: platform_profile: Add platform handler argument to
>>> =C2=A0=C2=A0=C2=A0=C2=A0 platform_profile_remove()
>>> =C2=A0=C2=A0 ACPI: platform_profile: Move sanity check out of the mute=
x
>>> =C2=A0=C2=A0 ACPI: platform_profile: Move matching string for new prof=
ile out of
>>> =C2=A0=C2=A0=C2=A0=C2=A0 mutex
>>> =C2=A0=C2=A0 ACPI: platform_profile: Use guard(mutex) for register/unr=
egister
>>> =C2=A0=C2=A0 ACPI: platform_profile: Use `scoped_cond_guard`
>>> =C2=A0=C2=A0 ACPI: platform_profile: Create class for ACPI platform pr=
ofile
>>> =C2=A0=C2=A0 ACPI: platform_profile: Unregister class and sysfs group =
on module
>>> =C2=A0=C2=A0=C2=A0=C2=A0 unload
>>> =C2=A0=C2=A0 ACPI: platform_profile: Add name attribute to class inter=
face
>>> =C2=A0=C2=A0 ACPI: platform_profile: Add choices attribute for class i=
nterface
>>> =C2=A0=C2=A0 ACPI: platform_profile: Add profile attribute for class i=
nterface
>>> =C2=A0=C2=A0 ACPI: platform_profile: Notify change events on register =
and
>>> =C2=A0=C2=A0=C2=A0=C2=A0 unregister
>>> =C2=A0=C2=A0 ACPI: platform_profile: Only show profiles common for all=
 handlers
>>> =C2=A0=C2=A0 ACPI: platform_profile: Add concept of a "custom" profile
>>> =C2=A0=C2=A0 ACPI: platform_profile: Make sure all profile handlers ag=
ree on
>>> =C2=A0=C2=A0=C2=A0=C2=A0 profile
>>> =C2=A0=C2=A0 ACPI: platform_profile: Check all profile handler to calc=
ulate next
>>> =C2=A0=C2=A0 ACPI: platform_profile: Allow multiple handlers
>>> =C2=A0=C2=A0 platform/x86/amd: pmf: Drop all quirks
>>> =C2=A0=C2=A0 Documentation: Add documentation about class interface fo=
r platform
>>> =C2=A0=C2=A0=C2=A0=C2=A0 profiles
>>>
>>> =C2=A0 .../ABI/testing/sysfs-platform_profile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
>>> =C2=A0 .../userspace-api/sysfs-platform_profile.rst=C2=A0 |=C2=A0 28 +
>>> =C2=A0 drivers/acpi/platform_profile.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 494
>>> ++++++++++++++----
>>> =C2=A0 .../surface/surface_platform_profile.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
>>> =C2=A0 drivers/platform/x86/acer-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
>>> =C2=A0 drivers/platform/x86/amd/pmf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 drivers/platform/x86/amd/pmf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>> =C2=A0 drivers/platform/x86/amd/pmf/pmf-quirks.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 66 ---
>>> =C2=A0 drivers/platform/x86/amd/pmf/pmf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>>> =C2=A0 drivers/platform/x86/amd/pmf/sps.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>> =C2=A0 drivers/platform/x86/asus-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
>>> =C2=A0 drivers/platform/x86/dell/alienware-wmi.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 3 +-
>>> =C2=A0 drivers/platform/x86/dell/dell-pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 35 +-
>>> =C2=A0 drivers/platform/x86/hp/hp-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>> =C2=A0 drivers/platform/x86/ideapad-laptop.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>> =C2=A0 .../platform/x86/inspur_platform_profile.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +-
>>> =C2=A0 drivers/platform/x86/thinkpad_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>> =C2=A0 include/linux/platform_profile.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
>>> =C2=A0 18 files changed, 488 insertions(+), 190 deletions(-)
>>> =C2=A0 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>>
>>>
>>> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
>
>

