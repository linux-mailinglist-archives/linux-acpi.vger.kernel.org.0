Return-Path: <linux-acpi+bounces-11100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71977A32781
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 14:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E6B3A2087
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE4205AAC;
	Wed, 12 Feb 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ILcHCdWG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FC27181F;
	Wed, 12 Feb 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368161; cv=none; b=tPkLogdyKqlXRMEzaaBgf5gujSyzTwK9jzr/ivXGWUuRc3AfC/VNaEBVt8t2K3l5g3vBf7NhXJ0ea3fY7Rzr/wbSkeB73c3Iu/MVOzN+rxm7APOdHYTKAqMHJQimG/ZRGs97Uwa0xrhFbVVhGKWaYOTz2Z3hzvIvcKWiV4GtWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368161; c=relaxed/simple;
	bh=/B/xi3LaZYvoWrGCLPj6CpEy8QypJsnq4YtTQw+WgJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHOxfXU7fHeh27rp3xGkxnnAtRGcOb6a9f6Pjl1eFYEzs65E1krrI02fgjnNfQR3o9atlYcNUV2NvM5Hgd9j3tHYuO6nkUVHkEfFN8QmsxYfuL/YunexUk2MEasdnF5xag69kWX7ZN5BMASCSIxeQ3CMJ+tTSAF55ebk96bXARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ILcHCdWG; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739368153; x=1739972953; i=w_armin@gmx.de;
	bh=/B/xi3LaZYvoWrGCLPj6CpEy8QypJsnq4YtTQw+WgJ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ILcHCdWGNQRUSg21CBtdBmKtgBvZsAgu5EPnH+ooyz+5x3mzyEV6+NOZj865Op+0
	 QGDGFBbLc28Q4B/V+StldOILSSu2xHBC/9RTVsgNvFUvauVRgxKm01xdgsLvJ0qq+
	 A80Nl3T6pN2FBM0g0w51xO8dMcGEJlKnVxWf+aKBjAqhmcvReoC8orB6FPbFTdLcd
	 74w8/L2FAYVYhRrI0QtoXFTBav2b3t1B878YLE4eBkvLDi+1bHZ0J5RH1zJQulZrm
	 5HbdQ2A3EpXSVOyKHBsIC1NgxbyP7NCTT6nkFUisN6fJLXsn5G6rzkN1YTeURMz4n
	 +0SdJy0tB3jIjPwaSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.35.117] ([141.76.8.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf4S-1t0aZW41mU-00omPr; Wed, 12
 Feb 2025 14:49:13 +0100
Message-ID: <dcbcbee9-7f1b-43ea-90ee-f863f4c6687f@gmx.de>
Date: Wed, 12 Feb 2025 14:49:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ACPI: battery: Wake system on AC plug or unplug in
 over s2idle
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250208162210.3929473-1-superm1@kernel.org>
 <20250208162210.3929473-5-superm1@kernel.org>
 <CAJZ5v0j4+8nqQRtcAihpVgOHWUPE54nTWienCpFk1U7easVPnA@mail.gmail.com>
 <4e6cc95f-90dd-4f55-bb53-50de7d280d62@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4e6cc95f-90dd-4f55-bb53-50de7d280d62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CzaeWy7RA3QeapXGD7el1M6ukWWJ/Hc7oxrl6pUlj6/RUlz+QSb
 LJ8Q+bEIKak1DAQ6DK66XzjaAqEnGSrtX1VGRKFKLiuqoS7n377aL0dX97RViDyupGqdz4b
 63IZKeo+OpGMP50hYNOAa2/oe8wiWuPK2P6U52+BP4oY/xOtV/7uIm3PpCAMSEq0pMz1+W2
 aaDWeZmTSuz+U2/e+5/0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DrIybK6OUBQ=;lpvaBAO5gyRkUJ7YeeCxM6s8rzH
 ZaYfiCUQOMmxGgfkID1MKp4voPfNMEo4keFYYUGzmyGPdFnlfJvLECzwGSi+4HQxIzDF+qVyR
 EZ1shm/NeuF9ktLqOpTaUOuuGH4l+6OVX2peP8jxLbGMu+gv9z/fCOaCoxUG5p8HdYndxAtoq
 eBfP95BBAor5hVuxZ5GFeM7ehZeoHc8YJjPDxnUMQzS4B7OwHEOc45zHrxq6eIpoT3zvESU8J
 dqBBBPGRDKtasMXOrSikbEmpuIFZrUB89Z0DLfP6i58aHghl5xMZIHomE1t32X94B9cxAIf7j
 gqVxyAC7jXaQug250zCocR+kf+ph1Wr9Ry2MT6AT/GupCzqUW3bvdepdO99AjdD0/UR6NR4MQ
 zqsDsG3YDG96c5Na9ER9F3llgVm28xoUQU5lBiSA1bYSmw2y30GAWruATU/5twt4KdPZ7bJiT
 Ix/jiocb3lc/KzjDv5e7ftBbnRAMQG1uxinR9pTCoHywsKPKtOh8uMMyIqYAhNrg5jHjsrzLK
 LAK+uHIarrVQMlFMtihksRKCS1g25T9KwELYZ3Nrhwqjbs7cEQUKQwehSyGG4H0qFDAmnoiHM
 NNX+1+uKoL3t3ZhBzZqqWCFKiZOxlgDDe6Jx4ttv+4ypH4Wa4Mh8qmXxGrXYAg5LYiCkibi5f
 BM2Tk8G4ffzf8lYk1RG6Zg997tGn9lfsDRWprEpyGrMtGB/MEkf19yeB4jxRImtmKnts+WVhJ
 emnxsA0yamR3Tr6CpC9HrMvetANHr06jiJm+U9f470UBjXp0tVDrWdPypRg8VJr8p7rmQCjOQ
 wncF4xz4yumE4uT+2aY1DfoQTbms0IWuDXevk3Mw9PmkHbPiaPoZom0H8wSaZYb59skVynswM
 yUfzPADzTwrjIcx68r2oA4prPP5aTwmwZ9T7M7uBdTPovDLn1loCMraG5gkm5/NY1506iW2+U
 ubbzlb+JGnWyxLODjgRmPv+8vz19SqUf7wIbG1DbcWUKcq69P+SyME2GydBZttsJau9KF4JwI
 iTkwvJjwDUZPTXCNxCstEJkwXaiFBtDOFJyaEAjorgP7o9muJ7sxFZ9irHPXh5kgfcZgTligW
 ViTl9517FSpM3nFfPEhTRNZJ/IDgdQNXe5fFjTzl/zeMyKZTtPzp0r+4sYcEqRqe+vSzPuav9
 siWqUfW2dC7EPszHf7mRLBtVpszxSNOeDPcLKFSsiMQnUA5i78njPk4CdhjPQEB9+WAmbUhM4
 JIqLAJPAHvx6v0Gi1ng/unbHGyUsucArljs8d/z+yMgc6vFaMm2MNPUxqdxgjDef8ARDKYniv
 2heno85V3Jy5HNyKABAmw83zOFcVJqMEc7ysxkiwR7fET+cnZ8pJ4Rruso9/piqhIyzCekp6j
 defUKJCC7I/gmOCu7YLsVqdUH3FhmBO/r817BgHz9WSA1JvScE8HFpcOXSovVRIWRIGPY8Hj8
 dVaHqRaWSADUmxbjmV9m3QVK0rmU=

Am 09.02.25 um 14:14 schrieb Mario Limonciello:

>
>
> On 2/8/25 11:59, Rafael J. Wysocki wrote:
>> On Sat, Feb 8, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org>
>> wrote:
>>>
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> On Windows the OS will wake up when plugged or unplugged from AC
>>> adapter.
>>> Depending upon whether the system was plugged in or unplugged will
>>> determine whether the "display turns on".=C2=A0 If there is no user ac=
tivity
>>> for some time then it goes back to sleep.
>>>
>>> In Linux plugging or unplugging an adapter will wake the SoC from HW
>>> sleep but then the Linux kernel puts it right back into HW sleep
>>> immediately unless there is another interrupt active (such as a PME or
>>> GPIO).
>>>
>>> To get closer to the Windows behavior, record the state of the battery
>>> when going into suspend and compare it when updating battery status
>>> during the s2idle loop. If it's changed, wake the system.
>>>
>>> This can be restored to previous behavior by disabling the ACPI batter=
y
>>> device `power/wakeup` sysfs file.
>>
>> Why is this desirable?
>>
>> What if the AC is connected to a suspended laptop when the lid is
>> still closed?=C2=A0 Is it really a good idea to resume it then?
>
> Yes; that's the exact situation I wanted this to work.=C2=A0 I have a do=
ck
> connected to some monitors, power supply, keyboard, and mouse.=C2=A0 I w=
ant
> the machine to wake up when it's connected to the dock but still closed.
>
> That's how Windows works at least.
>
>>
>> Frankly, I'd prefer the existing behavior to be still the default.
>
> Since this is hooking into the existing wakeups that can happen for
> battery I guess that there isn't a good way to configure one but not
> the other.
>
> Would it be better to do something similar in the ACPI power supply
> device?

Hi,

i believe that handling the wakeup inside the ACPI power supply device wou=
ld make more sense, because the current patch will also cause the machine =
to wake up
if the battery has finished charging. This behavior would be quite counter=
intuitive.

Thanks,
Armin Wolf

>
>>
>>> Link:
>>> https://learn.microsoft.com/en-us/windows-hardware/design/device-exper=
iences/modern-standby-wake-sources#environmental-context-changes-1
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> =C2=A0 drivers/acpi/battery.c | 8 ++++++++
>>> =C2=A0 1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>>> index 72c8a509695e6..91f79927cc720 100644
>>> --- a/drivers/acpi/battery.c
>>> +++ b/drivers/acpi/battery.c
>>> @@ -125,6 +125,7 @@ struct acpi_battery {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int state;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int power_unit;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int capacity_suspend;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int suspend_state;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> =C2=A0 };
>>>
>>> @@ -1012,6 +1013,12 @@ static inline bool
>>> acpi_battery_should_wake(struct acpi_battery *battery)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (battery->state !=3D battery-=
>suspend_state) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pm_pr_dbg("Waking due to battery state changed from
>>> 0x%x to 0x%x",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 battery->suspend_state, battery->state);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0 }
>>>
>>> @@ -1313,6 +1320,7 @@ static int acpi_battery_suspend(struct device
>>> *dev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 battery->capacity_sus=
pend =3D battery->capacity_now;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 battery->suspend_state =3D batte=
ry->state;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> --
>>> 2.43.0
>>>
>>>
>
>

