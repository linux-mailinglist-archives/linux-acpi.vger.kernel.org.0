Return-Path: <linux-acpi+bounces-9378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23759BF84E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 22:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925D0282AE5
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF081D6DB7;
	Wed,  6 Nov 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N/qmiQ18"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B95B1FB;
	Wed,  6 Nov 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927110; cv=none; b=L72j2BbIl/cKIfqH8+wGBwbEsLZrOdA3k+gSZ5N7K5hpymNRhs60IDkE8iewKiy9agS7yqRfEFazCAkknUHeOWDisk+C4C5bq1Z6nkoMr8zbc23B5jOr3NSRzn/4f4n6OcXzHFJkmTYl7EvX3QnNVReL+xGp+oWRuNfqz70zY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927110; c=relaxed/simple;
	bh=Ek/fPj5nMwmPNoaJtANmKTUXZ88Yvl97h8DjPn1tPB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZSol0ZOSQAc+VfWe+r3JwWiv4ORVMzqJHMT3F78inSgxIPlFY7bB1I6iXjHGc2Y0OXQgquRrZxT6s6z74MCJYS5uvtEPmx/SehBfNi4YO/Caz8olCZCuf7svJNT7f3digpjcmRG6hu/zXiGwF5PHu/IFeOgwy2dZT2qeA3SSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N/qmiQ18; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730927044; x=1731531844; i=w_armin@gmx.de;
	bh=Ek/fPj5nMwmPNoaJtANmKTUXZ88Yvl97h8DjPn1tPB8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N/qmiQ18A9EkkwgYOeYMyeD4J1tsx2007bdzqyuFM22t7gDKh699gn7a0w3qRhGD
	 GESsHRBqgPGZVGUAKW5WVxEZOdqTah28hGlqm74FSrxB2+M3oFU6K4nbFF1L0kW9e
	 yXbw1x874xypxesqcAufpAd5xeQjrfRIp07GCPbo9RJFLxXr9PaSZSTmEZB+jhNYS
	 PK/+8IRR7KQMGFmZJvEdPjSYLFti97Gf0dUEVOWU48FNTKaPAN3FSbhCD/BeILhbQ
	 jTPQR4inI79Y1OmgBH3XiGmVGEBWRX9vNRG+nLWbzknh7euaqGiUgV+ReRoIY10f6
	 nsxuzJSxcbNz/ysuJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1tf60k0JPm-00fLlA; Wed, 06
 Nov 2024 22:04:04 +0100
Message-ID: <1f3c4bca-9a41-47e8-ab1b-48e80760bee3@gmx.de>
Date: Wed, 6 Nov 2024 22:04:02 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/20] Add support for binding ACPI platform profile to
 multiple drivers
To: Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <26a494ee-d929-4aee-9c2e-d184e0efb842@app.fastmail.com>
 <4462f1d4-4f10-493c-b7ba-8f8d618a8fd7@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4462f1d4-4f10-493c-b7ba-8f8d618a8fd7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sx1c0VfmTsHSi1uJOn/rST/UX9GZnUEDbwmweqyaZJTgDghARxb
 UuytNJ9tUW6qGGo+GtfUMaKQDYOGoaI1tRZBNKxPvFfsJuj0VwnKMG7lW21G8QlY9hGse/k
 v8Gg/qhd7SlsiaBbe3hWo3+GTiOsaypA64lCyRU706OEBMCqgc6dTballly6TE9TEvnpXbS
 +6z8N0rwtyKZox5mURYSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4G9SF6161V8=;/49ABQHs6ErJifGFuHHfTuIhScT
 HdyPKLcf8J7IKPxc46Q/ctqvned7RERl+VI6Sm9sqjZd9D9RK6KbK/RnCCUk2kDnVKH+Frmdc
 CjXLCUR7SP9cxfsVhazDfNrIUFLuxs80MsetNbTELffXCxCQYIZviS6v26ZTIxfcIcj50BB3A
 9IeQoC9mQiBrta+0DpndkvLH7MRd5sUuPm7x6iDvZTcyBYC1wBYBrxOIHYJ3oYeE331XgELsh
 giMWEW6cIdSx9C7rXyKRNzKYAE+EeBFRaj8MkhOVXL9UsyBgZugpzDAcFF7CfndPr59fP0USR
 0YSvLpj9Le0lYD4AwXF4+omWvR1mFk0pJeLiIsLgQltz3g5JX9+Arw0IKVtsHNYj1yGDYqjzQ
 rkvykeL7QtSR+bzF2fxNaILyxdButzCfx69Ns2INoTM690dF90DRcUZmBpj4mEEb2sP+vB3ct
 2pXYFt9XpKYQqH7xm4qWN3IoiAo9EYb7omTSvsqchEDnzF+ia3Lk5Q+GqDTmTBzIXmQIT0nXy
 OsVTqyr7fXmT/H61cXDvq0IaexaL/J3EBeX/94kkqFT19fyyDwEJi0Vkl/kuYIR/Yq20O/sDW
 88Q6Pq28BG/P2HMMa8WOE+S5ph0HVSdpVtj2al88eL06rHKjDsB+Iwhv6whaYOqnHRQ8Ej8S5
 Hqa9LtdXwiqCI/DDGu3iu/SALR59hZr7z03SxWJYpLKiYWY3daMitYMX9R5UA91p9dppuD9Lk
 tN92KHCRY6Sy3D6tWqO1jh6TdXn9UWHVxMa0NyEojf3vf3dnxAovQ1IR2M+A1MsU9kCkNTz7M
 MeZPYsDfFosS2pjc5BDnS+fN1wgaBYl3WPoJci57JKKi0=

Am 06.11.24 um 02:11 schrieb Mario Limonciello:

> On 11/5/2024 16:47, Mark Pearson wrote:
>> Hi Mario,
>>
>> On Tue, Nov 5, 2024, at 10:32 AM, Mario Limonciello wrote:
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
>>>
>>> v4:
>>> =C2=A0 * Drop the list; iterate classes
>>> =C2=A0 * Drop patches that didn't make sense without list
>>> =C2=A0 * Cover alienware-wmi as well (recently merged to
>>> platform-x86/for-next)
>>> =C2=A0 * Drop requirement for balanced
>>> =C2=A0 * Rename platform-profile class members to 'profile', 'options'=
,
>>> 'name'
>>> =C2=A0 * Drop the name in /sys/class/platform-profile and just use ida
>>> value.
>>> =C2=A0=C2=A0=C2=A0 IE platform-profile-0
>>>
>>> Mario Limonciello (20):
>>> =C2=A0=C2=A0 ACPI: platform-profile: Add a name member to handlers
>>> =C2=A0=C2=A0 platform/x86/dell: dell-pc: Create platform device
>>> =C2=A0=C2=A0 ACPI: platform_profile: Add device pointer into platform =
profile
>>> =C2=A0=C2=A0=C2=A0=C2=A0 handler
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
>>> =C2=A0 .../userspace-api/sysfs-platform_profile.rst=C2=A0 |=C2=A0 28 +=
+
>>> =C2=A0 drivers/acpi/platform_profile.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 446
>>> ++++++++++++++----
>>> =C2=A0 .../surface/surface_platform_profile.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>> =C2=A0 drivers/platform/x86/acer-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
>>> =C2=A0 drivers/platform/x86/amd/pmf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 drivers/platform/x86/amd/pmf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>> =C2=A0 drivers/platform/x86/amd/pmf/pmf-quirks.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 66 ---
>>> =C2=A0 drivers/platform/x86/amd/pmf/pmf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>>> =C2=A0 drivers/platform/x86/amd/pmf/sps.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>> =C2=A0 drivers/platform/x86/asus-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
>>> =C2=A0 drivers/platform/x86/dell/alienware-wmi.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 8 +-
>>> =C2=A0 drivers/platform/x86/dell/dell-pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 39 +-
>>> =C2=A0 drivers/platform/x86/hp/hp-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>> =C2=A0 drivers/platform/x86/ideapad-laptop.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>> =C2=A0 .../platform/x86/inspur_platform_profile.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 7 +-
>>> =C2=A0 drivers/platform/x86/thinkpad_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>> =C2=A0 include/linux/platform_profile.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
>>> =C2=A0 17 files changed, 456 insertions(+), 195 deletions(-)
>>> =C2=A0 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>>
>>>
>>> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
>>> --
>>> 2.43.0
>>
>> For the series - I tried it out on my T14s G6 AMD, and it all looks
>> to be working nicely and as expected.
>> The thinkpad-acpi and amd-pmf classes show up. I can tweak them
>> individually and 'custom' shows up under firmware/acpi/platform_profile=
.
>> I tried various combo's and didn't see any issues.
>> If you have any recommendations of things to try let me know.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>
>> Mark
>
> Thanks for testing!=C2=A0 The fact that Lenovo and ASUS are both doing t=
his
> with recent laptops makes it all the stronger of a case to do it
> rather than let them race for who gets the coveted platform profile slot=
.
>
> If you've already tried mixing and matching combinations that's all I
> was going to suggest.
>
> I'll wait for Armin's review and then I'll respin with the tags and
> small things you and Ilpo found.
>
Looking forward to the next iteration.

Thanks,
Armin Wolf

> BTW if I missed any important feedback of yours from v3 please let me
> know.=C2=A0 It was a lot of overhaul to switch to this way of doing thin=
gs
> and a lot of it didn't make sense anymore.
>

