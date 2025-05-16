Return-Path: <linux-acpi+bounces-13761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A52ABA615
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 00:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB147503D38
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D623505D;
	Fri, 16 May 2025 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="C33PTffM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F301E521E;
	Fri, 16 May 2025 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435883; cv=none; b=pnGe/iQN/aj9+NWn+Y/LFSYvhXExpVEWWhO6lneJ59+tN+MjsmvwplUy/Q2vwWrkOUeZWRinAuStoT9UqlD2LVpmfyMhMWu8vlHXvMn5PHdbj2A/MftEblDFS59ABRmZkOwne35gXvKy+hCoz8jKBGB3tpZAmRAlpE7cnzkMoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435883; c=relaxed/simple;
	bh=0IKKAUUmcya6bwPTCS8kI9goyASN2Frt/6FkiXbQZgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4ON1Lxn90PDpJiBNweC1blBtZCbNMhiadPfMGS51cou7N2U/qt2qGJEPl7HygdBNm5loqS7v4/YroLt6X9JVPJdaageVPbWy9AsFzk91bCxknWHNNunx4oEFZ+C5Nv7DsF+3MtGbGcgdVzyOIv83aQYIx2Y1iowrqmnKN7y3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=C33PTffM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747435867; x=1748040667; i=w_armin@gmx.de;
	bh=qWplb7A8mjRl0/2WWE3bpC00qyUVu1xoZ2TClD60CEw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C33PTffMP8/zDzw+0KKoda9Hysi0cVTE2TolifH0Ws9pRNyGuQPC7+eNploL7d+u
	 ylVW/WJjIjnKrfvhRfDgMEyhC2k8TIGcitdMvRUo6lI747XsknuZcVMB1Kz2EQkq0
	 mAP8KjAOUPOEm/exCVU/g5F4cuCrw6Id18HmhtC74vbJHDgkhrrvfLGnS4hKLayX/
	 Yh0AUiCwxNuhfbtmiGSuipXlWbYmfvQONtYnVvyjFW0PR0vv5ObBvGAp9z6thXFHm
	 bq6V9uQ8JLWDCuKLrm1On7pC8pJ+/dN0k5vOXIBYRDklR5OkjufOWq5HX0GO7Sygd
	 N793xTBNKY+pZZDxyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1ulL6r06NK-00fKsz; Sat, 17
 May 2025 00:51:07 +0200
Message-ID: <12f63757-d61a-4edf-afaa-e3964d16d91b@gmx.de>
Date: Sat, 17 May 2025 00:51:05 +0200
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
 <CAJZ5v0grVpm8MUGYRRhC6VTRRQxvCEmzRJm27F83vJ4a-Wwjhg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0grVpm8MUGYRRhC6VTRRQxvCEmzRJm27F83vJ4a-Wwjhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UtQck8ky/D604YTIzDI3h9zRvr6bv32gktTR6Y4bSaryxZ6v9PH
 fn2mZXA4M433GuJnaSmbuGGooXzlpTaR6B1s8YgsYPpuZEfxrx2iFEyfCw/BX98yqgPXfSt
 Jh4AD/XNwy6BGbGD76fgZxHLhuUHKQMRkBgONcBnrS6b8ZH0rmgmgogF4TotGolL9pzrIOI
 RUZMtR4RXHornUzdtwDaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WhbJ+KcsHb4=;72T/4ni9bVd8MMsyOqO+a+SE8ul
 +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

Am 16.05.25 um 18:56 schrieb Rafael J. Wysocki:

> On Fri, May 16, 2025 at 3:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
>> On Sat, May 3, 2025 at 12:29=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
>>> Am 28.04.25 um 14:34 schrieb Rafael J. Wysocki:
>>>
>>>> On Mon, Apr 28, 2025 at 2:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
>>>>> Am 27.04.25 um 00:52 schrieb Armin Wolf:
>>>>>
>>>>>> Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:
>>>>>>
>>>>>>> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de=
> wrote:
>>>>>>>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
>>>>>>>>
>>>>>>>>> The ACPI specification defines an interface for the operating sy=
stem
>>>>>>>>> to change the preferred cooling mode of a given ACPI thermal zon=
e.
>>>>>>>>> This interface takes the form of a special ACPI control method c=
alled
>>>>>>>>> _SCP (see section 11.4.13 for details) and is already supported =
by the
>>>>>>>>> ACPI thermal driver.
>>>>>>>>>
>>>>>>>>> However this support as many issues:
>>>>>>>>>
>>>>>>>>>      - the kernel advertises support for the "3.0 _SCP Extension=
s"
>>>>>>>>> yet the
>>>>>>>>>        ACPI thermal driver does not support those extensions. Th=
is may
>>>>>>>>>        confuse the ACPI firmware.
>>>>>>>>>
>>>>>>>>>      - the execution of the _SCP control method happens after th=
e driver
>>>>>>>>>        retrieved the trip point values. This conflicts with the =
ACPI
>>>>>>>>>        specification:
>>>>>>>>>
>>>>>>>>>          "OSPM will automatically evaluate _ACx and _PSV objects=
 after
>>>>>>>>>           executing _SCP."
>>>>>>>>>
>>>>>>>>>      - the cooling mode is hardcoded to active cooling and canno=
t be
>>>>>>>>>        changed by the user.
>>>>>>>>>
>>>>>>>>> Those issues are fixed in this patch series. In the end the user
>>>>>>>>> will be able to tell the ACPI firmware wether he prefers active =
or
>>>>>>>>> passive cooling. This setting will also be interesting for
>>>>>>>>> applications like TLP (https://linrunner.de/tlp/index.html).
>>>>>>>>>
>>>>>>>>> The whole series was tested on various devices supporting the _S=
CP
>>>>>>>>> control method and on a device without the _SCP control method a=
nd
>>>>>>>>> appears to work flawlessly.
>>>>>>>> Any updates on this? I can proof that the new interface for setti=
ng
>>>>>>>> the cooling mode
>>>>>>>> works. Additionally the first two patches fix two issues inside t=
he
>>>>>>>> underlying code
>>>>>>>> itself, so having them inside the mainline tree would be benefici=
al
>>>>>>>> to users.
>>>>>>> Sure.
>>>>>>>
>>>>>>> I'm going to get to them next week, probably on Monday.
>>>>>> Ok, thanks.
>>>>>>
>>>>>> Armin Wolf
>>>>>>
>>>>> I am a bit ashamed of myself but i think we need to put this patch s=
eries on hold after all :(.
>>>>>
>>>>> The reason of this is that i am confused by the ACPI specification r=
egarding _SCP:
>>>>>
>>>>>           11.1.2.1. OSPM Change of Cooling Policy
>>>>>
>>>>>           When OSPM changes the platform=E2=80=99s cooling policy fr=
om one cooling mode to the other, the following occurs:
>>>>>
>>>>>           1. OSPM notifies the platform of the new cooling mode by r=
unning the Set Cooling Policy (_SCP) control method in all thermal zones a=
nd invoking the OS-specific Set Cooling Policy interface to all participat=
ing devices in each thermal zone.
>>>>>
>>>>>           2. Thresholds are updated in the hardware and OSPM is noti=
fied of the change.
>>>>>
>>>>>           3. OSPM re-evaluates the active and passive cooling temper=
ature trip points for the zone and all devices in the zone to obtain the n=
ew temperature thresholds.
>>>>>
>>>>> This section of the ACPI specification tells me that we need to eval=
uate the _SCP control method of all ACPI thermal zones
>>>>> at the same time, yet section 11.4.13. tells me that each _SCP contr=
ol methods belongs to the individual thermal zone.
> It just says "This object may exist under a thermal zone or a device"
> so I don't see any contradiction.  Section 11.4.13 says where it is
> located and Section 11.1.2.1 says when to evaluate it.
>
> However, Section 11.4.13 also says "OSPM will automatically evaluate
> _ACx and _PSV objects after executing _SCP" which is not arranged for
> in your patch [3/3] IIUC.
>
> Thanks!

This is incorrect, i do call acpi_thermal_trips_update() after setting _SC=
P in cooling_mode_store().

Thanks,
Armin Wolf


