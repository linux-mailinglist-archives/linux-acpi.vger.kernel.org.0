Return-Path: <linux-acpi+bounces-18918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C565C60A99
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Nov 2025 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98929358077
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Nov 2025 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553E30B502;
	Sat, 15 Nov 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tYP9U+02"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68CF27B348;
	Sat, 15 Nov 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763237267; cv=none; b=fUTSjHOhy1LNlGjp5OHy/uGMJmOZlmGwSS2I70B+ez5eZ15QTinc02O9CapMptH52Yk7upWmFx2CYMxFx6LEl8AQHWnnrqrr8uN8p433AwD4vHIxv+4vpTODVcg9Q+oPEcjCXOuwO6rmlU5S+pN1OBUjcbolDHnPShLH7mIXi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763237267; c=relaxed/simple;
	bh=X4gmpbbqjlBmq0FWnZirOdiHnoyNJ96lOxiRI3HC1C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPRw0vfM+H1JpSS6L4NZ99tryGEEJ9NrM2sXfWKPYI3cVUdYp4NekAbuD5NlVSMLGnqVsQmjvW50f+xAnEO5zCnQuvYFuz7f96l75kAnXa/tmpd8vREn0SJ3BojNf2nN69wp8LI7yKszfkHB3pxq0TUNOoNBStRLSvVXUNpw7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tYP9U+02; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763237247; x=1763842047; i=w_armin@gmx.de;
	bh=RaeVW3zq9IhmwHqwYfn0HX7o/6ixtGAHmkl6HkNdVFc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tYP9U+02Qs8IK2oWhxL+bgor6U+jtwWR7MScQiaKj7plr0LnQddpy7eCLp+1EG0N
	 b4wu11qMYk7L9CS2dCPuhCl0Vf3pIDgMUA7Xq5KEghN7Q4UgySKnzfzTV/0I6DewD
	 mplB0Dm6egzeb+7VMHVhOJRqf4LF1VSLfw+/GSMQBg1J5Z5cnPkfeqfiU3j5nFWwP
	 AZWw9gLE4M2Np+MfHcb+qx+HYVH0djGTDmkgS2vBgcJtSVgJZKOQDGG0YgbBNZNRz
	 GPU2XIdGzyGLyABm3nPGScUNiEC+mr0JfeszkS05J1by7xWkZlswE0yDjlwSk5t5W
	 1SlCf4YPq8Mz+96/kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1w4KOc3E76-017Dzg; Sat, 15
 Nov 2025 21:07:26 +0100
Message-ID: <3ba7a573-9343-4ed4-b805-1fb8db8df2c6@gmx.de>
Date: Sat, 15 Nov 2025 21:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] thermal: core: Allow setting the parent device of
 thermal zone/cooling devices
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20251114-thermal-device-v1-0-d8b442aae38b@gmx.de>
 <CAJZ5v0gZ7+i+irhaq2jQpTt++HuVRjqz8==Ov9VmQ9Q1J1TM0w@mail.gmail.com>
 <CAJZ5v0h7vrqMquOgCAiBG1Pe7=mF4XGug6-CUT7=Y5daRDRt6w@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0h7vrqMquOgCAiBG1Pe7=mF4XGug6-CUT7=Y5daRDRt6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fm4QCRyij1XnAj/sEPXzOT37DvnvhNpqYTjzglVMDz+aWXFkgPb
 RO8cTAPJ9jKVTBfPaSRk1dYix9L51rZdNctJjLWbecxcPdvdCngY4bSm/k4rsEbChJ6gLvJ
 sCax50GQVGGRfyFtAHMZmpqUFwFBvD/PdEHgdorDU6dSxQWel8RApIMMfJDu26XQCiYsOU0
 gSqP4TtOqAsMICCNXROAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+b6MOpwubX4=;ibxD5YalB8NjpekTKiJN/MnOgWe
 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
 RmXBcHNoCs+5snWXr6ygPJr38tjT1

Am 14.11.25 um 21:10 schrieb Rafael J. Wysocki:

> CC list trimmed and I'd rather not use such an extensive one if I were y=
ou.
>
> On Fri, Nov 14, 2025 at 1:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
>> On Fri, Nov 14, 2025 at 4:24=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
>>> Drivers registering thermal zone/cooling devices are currently unable
>>> to tell the thermal core what parent device the new thermal zone/
>>> cooling device should have, potentially causing issues with suspend
>>> ordering
>> Do you have any examples of this?
> Especially for thermal zones.

The device core suspends child devices before parent devices in order to a=
void
child devices accessing an already suspended parent device. Since thermal =
zone
and cooling devices have no parent, they could potentially suspended after=
 their
parent.

I said "potentially" because currently the thermal subsystem handles suspe=
nd/resume
using a PM notifier, something that prevents the above problem from occurr=
ing. We
should however eventually migrate to dev_pm_ops for that, so the device co=
re needs
to know about parent-child dependencies between thermal zone/cooling devic=
es and their
respective parent devices.

>>> and making it impossible for user space appications to
>>> associate a given thermal zone device with its parent device.
>>>
>>> This patch series aims to fix this issue by extending the functions
>>> used to register thermal zone/cooling devices to also accept a parent
>>> device pointer. The first six patches convert all functions used for
>>> registering cooling devices, while the functions used for registering
>>> thermal zone devices are converted by the remaining two patches.
>>>
>>> I tested this series on various devices containing (among others):
>>> - ACPI thermal zones
>>> - ACPI processor devices
>>> - PCIe cooling devices
>>> - Intel Wifi card
>>> - Intel powerclamp
>>> - Intel TCC cooling
>>>
>>> I also compile-tested the remaining affected drivers, however i would
>>> still be happy if the relevant maintainers (especially those of the
>>> mellanox ethernet switch driver) could take a quick glance at the
>>> code and verify that i am using the correct device as the parent
>>> device.
>>>
>>> This work is also necessary for extending the ACPI thermal zone driver
>>> to support the _TZD ACPI object in the future.
>> Can you please elaborate a bit here?
>>
>> _TZD is a list of devices that belong to the given thermal zone, so
>> how is it connected to the thermal zone parent?

The ACPI thermal zone driver currently matches cooling devices by accessin=
g their
private drvdata and checking if it is a pointer to the correct ACPI device=
. This
work well enough for ACPI fans and processors, but will likely not work fo=
r other
cooling devices (like batteries). Such cooling devices are supposed to be =
listed
by the _TZD ACPI object, so we need a more generic matching algorithm befo=
re adding
support for said ACPI object.

I as thinking of modifying the ACPI thermal zone driver to instead use the=
 ACPI handle
of the parent device for matching cooling devices. This would solve the pr=
oblem described
above-

>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>> Armin Wolf (8):
>>>        thermal: core: Allow setting the parent device of cooling devic=
es
>>>        thermal: core: Set parent device in thermal_of_cooling_device_r=
egister()
>>>        ACPI: processor: Stop creating "device" sysfs link
>>>        ACPI: fan: Stop creating "device" sysfs link
>>>        ACPI: video: Stop creating "device" sysfs link
>>>        thermal: core: Set parent device in thermal_cooling_device_regi=
ster()
>>>        ACPI: thermal: Stop creating "device" sysfs link
> This will kind of break things because user space may rely on those, may=
 it not?

The driver core will create the "device" sysfs link for us as soon as we p=
opulate the
parent device pointer of the thermal zone/cooling device. So user space ap=
plication
relying on those links should continue to work.

I even tested this on my devices.

>>>        thermal: core: Allow setting the parent device of thermal zone =
devices
> For this last change, you need to define what it means for a thermal
> zone to have a parent device.  In particular, in what way would a
> thermal zone depend on its parent?

1. A thermal zone should be suspended before the parent device is suspende=
d. For this the
    device core needs to know the parent device of a given thermal zone de=
vice.
2. Users space applications can determine the physical device behind a giv=
en thermal zone device
    if we enable the device core to automatically create a "device" sysfs =
link.

Other than that all current thermal zone devices do not depend on the pare=
nt device pointer
(because currently it is always NULL).

>> I can only see the first three patches in the series ATM as per
>>
>> https://lore.kernel.org/linux-pm/20251114-thermal-device-v1-0-d8b442aae=
38b@gmx.de/T/#r605b23f2e27e751d8406e7949dad6f5b5b112067
> That's probably because of the excessive CC list.

Yes, that was my mistake. I will prune the CC list and resend the series. =
Do you think that i should include
all maintainers of the affected drivers or only the subsystem maintainers?

Thanks,
Armin Wolf


