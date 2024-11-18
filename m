Return-Path: <linux-acpi+bounces-9648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47749D1A1D
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 22:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9078282B0F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564751E5739;
	Mon, 18 Nov 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Zx9GsvLE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF081E0E0D;
	Mon, 18 Nov 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963998; cv=none; b=IV2VsKogkpGGyV+a9g7QWiZUg0bDo/HxWi5Kv0ScguTwiAKlZNCE/sGkiy7ijOKLFxW3oFpwXCUVZleDkTQV8y4NKqEa2fX1tGF4JKXTcAtwRwSTABJE/oKefC90ijI1dyMPtxpnpVpFrnYY3rnrqYvG61PtQ7UC6+XdTSxI2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963998; c=relaxed/simple;
	bh=VMpSpxTh1rjF9OETalGtIZer5YwrqGwAQQcuh02CKb8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bz5lPKZQmmBmMcNmTt6qF+yeVN07a84KrTEgGqLGWcwuZt9Rcl3BLtwAZdlsKv4pJd9wLb6JISjLU+X+ciFwPU97gfM9Ne2eSMxyjRBtqhRfh/xOP1M8QTaAPAfecrC+dnJ5CcjnuODEP4fyRDMymln2E9JDDQhwQHW3ZI9GArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Zx9GsvLE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731963914; x=1732568714; i=w_armin@gmx.de;
	bh=VMpSpxTh1rjF9OETalGtIZer5YwrqGwAQQcuh02CKb8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zx9GsvLEqkNRuAUYTGUHFnpYPuP5dijUlE5cSuXZsSmSKDUb1+Yiwoxpe8XzvVn8
	 eU8fwEOcpXp1yU25EeAc+Mp8WrruJr/dIXOPu1zUVAfbgevAqutc/zOJtXhcm6Ji2
	 lnBvpTzSN771m1X0RptWINRRIwwumsZ2stor13XxrpkoZGNYOrErZRcbixGQegHlj
	 sEY0dh5Hwct1/qWjoqKQZbl0WaCKbIKhI98Sh3bDVv3tacDEtMvWnTiFzx6SQaTRr
	 Df+UWfC3J0Oih9Ir7HZr1wsyY3TKIM6qGcNz6gusFRvgW6ZgdT7yhd/ChdlUJt+/n
	 eZicFkNRDXVGwYN9Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1tXbK31VLp-00nhG8; Mon, 18
 Nov 2024 22:05:14 +0100
Message-ID: <c05d3199-03e3-4e60-a1a1-19e36150f3e3@gmx.de>
Date: Mon, 18 Nov 2024 22:05:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] Add support for binding ACPI platform profile to
 multiple drivers
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <7d06c91a-bf89-4880-b640-1fce38d51036@gmx.de>
Content-Language: en-US
In-Reply-To: <7d06c91a-bf89-4880-b640-1fce38d51036@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xoNGxhYF660ENn6icr8X5bH8Jk+CCpBpGPk8fnZFcGbEcB61Ruw
 SEfmxA6seeJVRKy9qUpIZPeQs+EiKaFc0FuRMneNrsHP+Q7ijFyX3k8kwooxRc1D4l4Eq9d
 io1rEr0byVvogM0aw3EdBYCTH+ZEdZZS/oVwVDw7K/MPkVRzkh88VQ1r3FKENqfPtZ5c8og
 keb2Jmyc9m2i4JpijozMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nMqnwR/4YBk=;4I2b5Iv7AUngtckLhitFHo5JbgV
 EFAV7fbilvha6Rf9aNYLWMGxVuaITSJAnYAZdXHg2fcPgbjt4UNw7AdEsZnWxk3W9pIBfWwax
 FXYp95cRMwfCoiWcIKnmtF1/q7huQ06p3SvkZB8fhQi14XvN/MU1qg9DHrz2B3AdWskxqNDW0
 Z+JcIouKsuWGH4oShfGPn53hOx1RSMKIO6qdCx9DdH3F66NO3aodfF8PXNffMICRZmCEQhUBC
 jEd3w7vbhj3yf0DwUEoopZkTjvRRw53HgRPbTAlRCX0s2pCxsRpKLQ6Z7E7W2RezZIpdGVMRE
 NGAIiS/sQSgMN3WWJJBWULSDstUIaZtuV+ibJvS11nQuVXUfFHwxbVujBRCPnZhbiyqQjTB9F
 on9pBCM1r64vgehj9S8VZYtKTGfETBUN+VSTQibwXw4S0HKcAK0vZXBYA1j+0pGcxi2vZrluS
 Vjpsql/iPDGq53gnRupHGSu4llwZZksXhIvI6Fak2JSWx0FBLEbebRDyF41478tixepgxHERd
 xPheLXwBAvHj90dmBDEfzp7GGCw0bAsugO68MwH8aHorEIkQwUCz0niRclhWiPBDIvUbCwppa
 8Nt1zE2pLjrrjJ37tJ7ppXUj58tBvyDclDGk29K3RKD1ZIWCpiGXOTdxVVesTvABtU2qR/TUd
 arwyFqiowz0Xj/FwhhdZUJPuKtMP0cp3Deex+fsOaOJYbg1F1Ku2pUmycdWDZiONhPAWegLG6
 cp0ZAJSYhe34kFIRBmsU315XKptIgkoq88Nv/pv4LOXHeI7umIQOoLp0Gq7lT3sa0J32ragET
 9zxifggQVySfmmlEhax/Zq4o46ea6d4QCBFIvD3aTePwQTna8TL0MoHI/yt5DHHTLVhtwt7yH
 quC+6aMR8DNnL36JebYYK18Y+LYh9bWs9V/G8J6Qu3HWgLTKkCgbGzem7

Am 14.11.24 um 22:57 schrieb Armin Wolf:

> Am 09.11.24 um 05:41 schrieb Mario Limonciello:
>
>> Currently there are a number of ASUS products on the market that
>> happen to
>> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
>> profile provided by asus-wmi.
>>
>> The ACPI platform profile support created by amd-pmf on these ASUS
>> products is "Function 9" which is specifically for "BIOS or EC
>> notification" of power slider position. This feature is actively used
>> by some designs such as Framework 13 and Framework 16.
>>
>> On these ASUS designs we keep on quirking more and more of them to turn
>> off this notification so that asus-wmi can bind.
>>
>> This however isn't how Windows works.=C2=A0 "Multiple" things are notif=
ied
>> for
>> the power slider position. This series adjusts Linux to behave
>> similarly.
>>
>> Multiple drivers can now register an ACPI platform profile and will
>> react
>> to set requests.
>>
>> To avoid chaos, only positions that are common to both drivers are
>> accepted when the legacy /sys/firmware/acpi/platform_profile interface
>> is used.
>>
>> This series also adds a new concept of a "custom" profile.=C2=A0 This a=
llows
>> userspace to discover that there are multiple driver handlers that are
>> configured differently.
>>
>> This series also allows dropping all of the PMF quirks from amd-pmf.
>
> Sorry for taking a bit long to respond, i am currently quite busy. I
> will try to review this series
> in the coming days.
>
> Thanks,
> Armin Wolf
>
So far the patch series looks quite good, but a single issue remains: the =
locking around the class attributes.
Maybe someone with some knowledge about sysfs can help us here.

Also can you please rebase the patch series onto the current for-net branc=
h? This would solve a merge conflict
inside the asus-wmi driver.

Thanks,
Armin WOlf

>> ---
>> v6:
>> =C2=A0 * Add patch dev patch but don't make mandatory
>> =C2=A0 * See other patches changelogs for individualized changes
>>
>> Mario Limonciello (22):
>> =C2=A0=C2=A0 ACPI: platform-profile: Add a name member to handlers
>> =C2=A0=C2=A0 platform/x86/dell: dell-pc: Create platform device
>> =C2=A0=C2=A0 ACPI: platform_profile: Add device pointer into platform p=
rofile
>> =C2=A0=C2=A0=C2=A0=C2=A0 handler
>> =C2=A0=C2=A0 ACPI: platform_profile: Add platform handler argument to
>> =C2=A0=C2=A0=C2=A0=C2=A0 platform_profile_remove()
>> =C2=A0=C2=A0 ACPI: platform_profile: Pass the profile handler into
>> =C2=A0=C2=A0=C2=A0=C2=A0 platform_profile_notify()
>> =C2=A0=C2=A0 ACPI: platform_profile: Move sanity check out of the mutex
>> =C2=A0=C2=A0 ACPI: platform_profile: Move matching string for new profi=
le out of
>> =C2=A0=C2=A0=C2=A0=C2=A0 mutex
>> =C2=A0=C2=A0 ACPI: platform_profile: Use guard(mutex) for register/unre=
gister
>> =C2=A0=C2=A0 ACPI: platform_profile: Use `scoped_cond_guard`
>> =C2=A0=C2=A0 ACPI: platform_profile: Create class for ACPI platform pro=
file
>> =C2=A0=C2=A0 ACPI: platform_profile: Add name attribute to class interf=
ace
>> =C2=A0=C2=A0 ACPI: platform_profile: Add choices attribute for class in=
terface
>> =C2=A0=C2=A0 ACPI: platform_profile: Add profile attribute for class in=
terface
>> =C2=A0=C2=A0 ACPI: platform_profile: Notify change events on register a=
nd
>> =C2=A0=C2=A0=C2=A0=C2=A0 unregister
>> =C2=A0=C2=A0 ACPI: platform_profile: Only show profiles common for all =
handlers
>> =C2=A0=C2=A0 ACPI: platform_profile: Add concept of a "custom" profile
>> =C2=A0=C2=A0 ACPI: platform_profile: Make sure all profile handlers agr=
ee on
>> =C2=A0=C2=A0=C2=A0=C2=A0 profile
>> =C2=A0=C2=A0 ACPI: platform_profile: Check all profile handler to calcu=
late next
>> =C2=A0=C2=A0 ACPI: platform_profile: Notify class device from
>> =C2=A0=C2=A0=C2=A0=C2=A0 platform_profile_notify()
>> =C2=A0=C2=A0 ACPI: platform_profile: Allow multiple handlers
>> =C2=A0=C2=A0 platform/x86/amd: pmf: Drop all quirks
>> =C2=A0=C2=A0 Documentation: Add documentation about class interface for=
 platform
>> =C2=A0=C2=A0=C2=A0=C2=A0 profiles
>>
>> =C2=A0 .../ABI/testing/sysfs-platform_profile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
>> =C2=A0 .../userspace-api/sysfs-platform_profile.rst=C2=A0 |=C2=A0 28 +
>> =C2=A0 drivers/acpi/platform_profile.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 537 ++++++++++++++--=
--
>> =C2=A0 .../surface/surface_platform_profile.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>> =C2=A0 drivers/platform/x86/acer-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-
>> =C2=A0 drivers/platform/x86/amd/pmf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 drivers/platform/x86/amd/pmf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>> =C2=A0 drivers/platform/x86/amd/pmf/pmf-quirks.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 66 ---
>> =C2=A0 drivers/platform/x86/amd/pmf/pmf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>> =C2=A0 drivers/platform/x86/amd/pmf/sps.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 drivers/platform/x86/asus-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
>> =C2=A0 drivers/platform/x86/dell/alienware-wmi.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 8 +-
>> =C2=A0 drivers/platform/x86/dell/dell-pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 36 +-
>> =C2=A0 drivers/platform/x86/hp/hp-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>> =C2=A0 drivers/platform/x86/ideapad-laptop.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
>> =C2=A0 .../platform/x86/inspur_platform_profile.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 7 +-
>> =C2=A0 drivers/platform/x86/thinkpad_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +-
>> =C2=A0 include/linux/platform_profile.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
>> =C2=A0 18 files changed, 553 insertions(+), 213 deletions(-)
>> =C2=A0 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>
>>
>> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
>

