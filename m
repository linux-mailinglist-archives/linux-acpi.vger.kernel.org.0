Return-Path: <linux-acpi+bounces-13762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBAABA625
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 01:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4151F1BC2E84
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025E1F869E;
	Fri, 16 May 2025 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="F9fQ3QdG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B0A31;
	Fri, 16 May 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436490; cv=none; b=ozB/XJY6ZX0oqsuoP2xjqQ3RMxfS4T6jlzBOJiD7HiEoQyFDTpm1/3okUmAuUATA68/aV48uIiTaQHV6Mv/i7fddreEA/7b2gx6vSHH/RU9nmMrYEbq98NjD+hcS32vNojIiP17NIcnMx9ZOtjcEwxCP/wsZz4i1OsHaSf8kFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436490; c=relaxed/simple;
	bh=/naZ7p4stFk45kxF1mgy+kt7i+8EFoznhA0Owr2TBZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+LAwXcsOpnpzRYemW/TYuG70GhDY4PjZftVaGqahCbRzNRDamEKUgPHyK/e2pUBfWEoRdu6FR5sXbM02jhF3HLdPf/MYeN7aQ71JTWPBiDuf0KFgNIM85noPBTKXLYcTGlGGvCvyNdU2/RQgCtJL3/0o7k5i+DI3bfW4s1i/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=F9fQ3QdG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747436481; x=1748041281; i=w_armin@gmx.de;
	bh=dQsoGmrq1VX8LhkKFYpfAR6yBuZxPrBmH7/USFajCNw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F9fQ3QdG1iADrAS1njwesbh4WHLpoTqPY3cF/KsyMuycJ/hNjlBsBwdDpFsuZ0+d
	 gyhjtRV1H3wQG++c3rH5PzfcrRBNT592McvmFuMaJFEIIB/yV/V/NNKhPF8QHrJJy
	 0yDCbIRWnfplaFcbTJbynT+KiyzoFQmU95YbwZRR7csYdu/G62wJtJS3I7hn+UfOX
	 h10PNMorSeTFclT8fq9yCBvz5C/Gg2Xr1mqb6TDj1u6FdMyjN04wqLW5GWxgpOTpD
	 3+gwbKOZMVLM1MAUU9lCJdtMYpFfjv9Kx5XpHaFw5qtKN6Wkql+z0WVYjDtPf4qY0
	 2x34Rm23geDi1xqDSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1uHzrc0wH3-004RFu; Sat, 17
 May 2025 01:01:21 +0200
Message-ID: <f4fd8852-b1c9-4d85-8d40-c4ab00c14fca@gmx.de>
Date: Sat, 17 May 2025 01:01:20 +0200
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
 <5cec046e-c495-4517-82c8-83ae3cdb63a1@gmx.de>
 <CAJZ5v0iEni2ie-6sCiZBfwugZ--NmJQX6=2EYKXnHwRCfpqUzQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0iEni2ie-6sCiZBfwugZ--NmJQX6=2EYKXnHwRCfpqUzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hgqOeO+wBmz+IMsJE9m614d9ioZHD8NttVzAAJikMiRQXh94Nt6
 NAV4xw6zovrD2/JIUSxGXM0daemQ4MBOtdQ8Kq+gAwDQxc2Wmbi/rk1/26r+G43pDmPZCTH
 E/+opcX7AQCF7j4Qf6155HVmAIXd24QmKa+VpgS4sAwxdpvNUYBxp62t219CXayhT8LdWGg
 o1gNHGDeBfWzy7oE//+eQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qoxt2YrQe7I=;RRC/drA0EiQeinFz1rvrw7JfP02
 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

Am 16.05.25 um 15:59 schrieb Rafael J. Wysocki:

> On Sat, May 3, 2025 at 12:29=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 28.04.25 um 14:34 schrieb Rafael J. Wysocki:
>>
>>> On Mon, Apr 28, 2025 at 2:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>> Am 27.04.25 um 00:52 schrieb Armin Wolf:
>>>>
>>>>> Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:
>>>>>
>>>>>> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de>=
 wrote:
>>>>>>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
>>>>>>>
>>>>>>>> The ACPI specification defines an interface for the operating sys=
tem
>>>>>>>> to change the preferred cooling mode of a given ACPI thermal zone=
.
>>>>>>>> This interface takes the form of a special ACPI control method ca=
lled
>>>>>>>> _SCP (see section 11.4.13 for details) and is already supported b=
y the
>>>>>>>> ACPI thermal driver.
>>>>>>>>
>>>>>>>> However this support as many issues:
>>>>>>>>
>>>>>>>>      - the kernel advertises support for the "3.0 _SCP Extensions=
"
>>>>>>>> yet the
>>>>>>>>        ACPI thermal driver does not support those extensions. Thi=
s may
>>>>>>>>        confuse the ACPI firmware.
>>>>>>>>
>>>>>>>>      - the execution of the _SCP control method happens after the=
 driver
>>>>>>>>        retrieved the trip point values. This conflicts with the A=
CPI
>>>>>>>>        specification:
>>>>>>>>
>>>>>>>>          "OSPM will automatically evaluate _ACx and _PSV objects =
after
>>>>>>>>           executing _SCP."
>>>>>>>>
>>>>>>>>      - the cooling mode is hardcoded to active cooling and cannot=
 be
>>>>>>>>        changed by the user.
>>>>>>>>
>>>>>>>> Those issues are fixed in this patch series. In the end the user
>>>>>>>> will be able to tell the ACPI firmware wether he prefers active o=
r
>>>>>>>> passive cooling. This setting will also be interesting for
>>>>>>>> applications like TLP (https://linrunner.de/tlp/index.html).
>>>>>>>>
>>>>>>>> The whole series was tested on various devices supporting the _SC=
P
>>>>>>>> control method and on a device without the _SCP control method an=
d
>>>>>>>> appears to work flawlessly.
>>>>>>> Any updates on this? I can proof that the new interface for settin=
g
>>>>>>> the cooling mode
>>>>>>> works. Additionally the first two patches fix two issues inside th=
e
>>>>>>> underlying code
>>>>>>> itself, so having them inside the mainline tree would be beneficia=
l
>>>>>>> to users.
>>>>>> Sure.
>>>>>>
>>>>>> I'm going to get to them next week, probably on Monday.
>>>>> Ok, thanks.
>>>>>
>>>>> Armin Wolf
>>>>>
>>>> I am a bit ashamed of myself but i think we need to put this patch se=
ries on hold after all :(.
>>>>
>>>> The reason of this is that i am confused by the ACPI specification re=
garding _SCP:
>>>>
>>>>           11.1.2.1. OSPM Change of Cooling Policy
>>>>
>>>>           When OSPM changes the platform=E2=80=99s cooling policy fro=
m one cooling mode to the other, the following occurs:
>>>>
>>>>           1. OSPM notifies the platform of the new cooling mode by ru=
nning the Set Cooling Policy (_SCP) control method in all thermal zones an=
d invoking the OS-specific Set Cooling Policy interface to all participati=
ng devices in each thermal zone.
>>>>
>>>>           2. Thresholds are updated in the hardware and OSPM is notif=
ied of the change.
>>>>
>>>>           3. OSPM re-evaluates the active and passive cooling tempera=
ture trip points for the zone and all devices in the zone to obtain the ne=
w temperature thresholds.
>>>>
>>>> This section of the ACPI specification tells me that we need to evalu=
ate the _SCP control method of all ACPI thermal zones
>>>> at the same time, yet section 11.4.13. tells me that each _SCP contro=
l methods belongs to the individual thermal zone.
>>>>
>>>> The reason why i am concerned by this is because Windows adheres to s=
ection 11.1.2.1. and only exposes this setting
>>>> as a global tunable. This might cause device manufacturers to depend =
on this behavior and lead to strange things
>>>> should two thermal zones have different _SCP settings.
>>>>
>>>> I will ask the UEFI mailing list which behavior is expected by the AC=
PI specification. Until then i suggest that
>>>> we put this patch series on hold.
>>> Sure, no problem.
>>>
>>> Please resend it when you think it is good to go.
>>>
>>> Thanks!
>> Alright, the UEFI mailing list gave no response, so i am kind of stuck.
>>
>> It seems that many firmware implementation only have a single cooling p=
olicy register which is set by all _SCP control methods inside the whole s=
ystem.
>> The reason for this seems to be that Windows treats this setting as glo=
bal, but the ACPI specification seemingly does not directly mandate this.
>>
>> Do you think we should take the risk and allow users to control each _S=
CP instance manually?
> No, I don't.
>
> Doing things that are not done in Windows with ACPI objects is
> generally asking for trouble unless there is a specific use case and
> there is high confidence that it is actually going to work.
>
> At least to begin with, I wouldn't do it.

Alright, i will go with a single global interface then.

I am already thinking of using the platform profile interface (with perfor=
mance and quiet profiles) instead of a custom
sysfs interface to allow for better integration with tuned/platform-profil=
es-daemon/etc.

I am currently a bit preoccupied so this will take a while.

>> Apart from that the first two patches should be safe, so you can still =
pick them.
> Done.

Thanks :)

Armin Wolf

>> Only the last patch needs some more work.
> OK
>
> Thanks!

