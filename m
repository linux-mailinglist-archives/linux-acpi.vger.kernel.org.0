Return-Path: <linux-acpi+bounces-12408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36CA6D153
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Mar 2025 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89033B079A
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Mar 2025 21:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B319DF61;
	Sun, 23 Mar 2025 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pHeq/+0S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4A136E;
	Sun, 23 Mar 2025 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742766938; cv=none; b=tFRDjBYYT5gM7Fm2vOwRqWWbhkXn6NZ2mPUk44/dwXka/iPJvWPYp00E5Xqo28SlrXVCDoUcl5KHxiRhrmGdsf/erTe37Wqix+1LZEn2AsoSJCd35cnSmZsYzTf4NY5amEws0guJar1GemlcfRxZlLZ40vEmR1DrkwtqfASWzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742766938; c=relaxed/simple;
	bh=DTiojvoK00X0i2qY6Ki/T1WTIfwmgBhLwBIIHN5cyyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtgLlEB6lFBTfI9cgW0Xu/x8ORdp4sbUQU3EaqbbxyfxqN0R2ovBl6J08VCXw9UrhRxmyw5EVLC3ig1J+ugyTxkdBSwYLZz7FB+s7ffvhrYdNG8HISoJZfD3kHb+K53FbQvL9gGohV75MHiJ3lj65lr2hi48iadNxzq49VrOJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pHeq/+0S; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742766934; x=1743371734; i=w_armin@gmx.de;
	bh=PluvpDCEQUmy2BvtAVsSBFPrJJlY6pecVV1eEMYdE1c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pHeq/+0SVxDDGqZEoEEvBh9qhFH+iz9XIxAI/M5xkCXzryxyvknqEn9xx54xKXRs
	 akxLJerqEHYCZZeEIeSzL7cSBEQMLvt11HXs6pT7gRZ2Zwb7e2JOv7C3+6KIK/FAQ
	 Jb6DqEowEyl9KkH2cIDpYhUAtLI8ecCmSRGzJjzXPdazR22Ojp/1H7aQy1xfP1TWZ
	 8RRyxf1HIDohY2HBFYQh9R2I+6oFhK+Ql7IFHZRwUKHBoNy3zveagYcrplNUHQ8Sv
	 9TNOPARkMPhw8IPICoMnaHbaOXXGTUMuWF3PoJwJUic+KV/iOoA7d7JP1EkZtqaKr
	 snfysV3RTXGEySX5cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1tS6Lf3Kt8-00dUO3; Sun, 23
 Mar 2025 22:55:33 +0100
Message-ID: <d713393c-5d08-4b7f-8d5a-1a65f6f29f59@gmx.de>
Date: Sun, 23 Mar 2025 22:55:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI Error: AE_AML_LOOP_TIMEOUT in \_SB.PCI0.SBUS.RDWD &
 \_SB.PCI0.SBRG.ADP1._PSR
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org
References: <CAMciSVUVjLj44LW+3ALB1fJQsUiw_2BQ5tLgpNJH08Xmj=Wr9w@mail.gmail.com>
 <07e2fb25-625b-441e-86f7-d0d54138c4aa@gmx.de>
 <CAMciSVUwy2cB4=hdX7Qki4Uc3maYdyrWa9t=_c9Uth=Pzh-KAg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAMciSVUwy2cB4=hdX7Qki4Uc3maYdyrWa9t=_c9Uth=Pzh-KAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z7cJg2l6rHftx/bP/J1EfC6wfh7I9scuvDrKBaT9wee2JQt/oF9
 ut5SF5Leigm300ZHRM0Qo/sYFaGPrz6zRpuqGJ63pIOhUSAIyqchbbCFgfILB7Jmok0FI5z
 fKrRxHJHQDPw1eqJivonFmdldCbKg4IVzczIlvb5mS+kzsZdzfG5zMojhb2SIBfwkxD5NA8
 U3naTKWU0b3bsCbOR4PQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DMugJy7C3iA=;ynQgPLSLXqMDINpXvR2XGalqMu+
 RFUQKUMnOSe6nTXeLN0/aXLvlviAsN7quWCAVaGdmvcFMvAX/ZuDmrptnVfFH1FnK6B25QhvR
 hTQDFFO5fJ5WQf1WrbuRjjyQrc7y99CU/gm0Ccq9u2tUgx9botc+jNAbtv87UivScZpMiVG2o
 UrzHQDIEE5tcNpSi9DAJnyJtGffH7Z2TOB2Sd9lTYIDZfrKt2pBGwWbknaLmon+W/xApQkYvb
 fvyybHeL5B0HmWVJWpwQh4BIAjYylio1ocbuPvc62arS7ilrjB7B1TCAkcrTy+u3rKS9hebH7
 rFfr+O96rYRDdwibk0BCt42IQvN6gNnPtYD0lYlYDALqjfwglcPvtb/rF/VJUuyOSbdOVqK5a
 TjqCQPrDS4zOlfkcMgC4CVacLnPTJK9CGwuEtEFScH5YBUl59yIUIlVJbgtfhdiVoUy6UiTFB
 3ppphgERQwtGP0Xuu6l0FfDA/AA/RxitQPVCauHt35PWccY/T7+lKLjOj/pRupWxYgiUz6GMc
 tFY9pdxao3jHQGuHc04ER1cd6bqJDTZqrFimlVvRXgNFnM6aRMiuNj4Juj1CLxhLBaQ2o5nLx
 AcKviKGi4G9+vVEfwqMGu/WBuinE1kTO1dFvSNN/drdEOsjQIMagDW/EdMejrKU4jKshJ38DW
 wmfahQbDSWF0HnhIQNAFoPlwJAztyqjnXb7Ub8WHLEyZbJeD/RWg2EV2HjhQNGWorfaQLf0Ed
 Yuvm7KyTTqWmqp2APBNTgQUA+LtBZRUuGRO0pmN+DRnT8st0NUC+R4jiUsqiEA75DHiZYcieQ
 N8dD2z7JRUpw3KHAIP0W/+w8GVxgRSpvsWWUu/gqoCZ+NCtcC1U76HTuEm4T3af86kcTB4dkC
 3oXNcfxVURwaJHEUUG7EAcZ46ruG7JKw9QqWtJxLlXS8ZtnNxo3v1cA9THpc+vbZQ76I1rDk3
 dexawdZCBWx8kpcTOVe9IoBS8A9cfM5EE3YLBMdrJowTJz4eqpZbBVIhQ2PhzcuCDhIue30mj
 vvzCoPHkCFN3H+ewkzRmdMCxuLBfg5CWJLjSSn+SzRICZHBmMuGQFzzEHlIkyyDO94vJmmGIo
 W1g/OShdNETmeEgpUJI5Gm8EcgNKsLmJrva66fGFEyB8eL7CK4SHMSrhIXiH8a/amOIelhW6I
 tBdo9IvZIwGSxwm/lM621TxZI2zsrRElarB5TL+WhXnj7SXMsXG6iL/Kmt716V+0eXHk0n+7O
 cOkRYXcj2JA2CflP2oBp/+CNAtq2tgy2eoPy4R4pwWdo8e77UdWSQWJIVcsWId72CTi6ycJUx
 ZssjpmMh8ErBLGs+6rpbe7LODy8TGODih0Di0IP2m24BJCmLX6HiAdVxOE9rGOZs42oRkY1tk
 i5W4ELhKTlLd2RFkwlVxswLPckMIAAXn6zYbshtUriZCkBXyg8Md7eR2ikFSN3IBTPkfAVUh/
 E2lvlWqDa/xteNektCmKQPr+oV8w=

Am 22.03.25 um 16:40 schrieb Naveen Kumar P:

> On Sat, Mar 22, 2025 at 3:02=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 19.03.25 um 12:29 schrieb Naveen Kumar P:
>>
>>> Hi all,
>>>
>>> I am encountering repeated AE_AML_LOOP_TIMEOUT errors in the ACPI RDWD
>>> & \_SB.PCI0.SBRG.ADP1._PSR methods. Below are relevant log entries
>>> from my system running Linux kernel 6.13.0+:
>>>
>>> [77998.038653]
>>>                  Initialized Local Variables for Method [RDWD]:
>>> [77998.038691]   Local1: 00000000d0fe9fee <Obj>           Integer
>>> 0000000000000015
>>> [77998.038862]   Local6: 00000000f41c1645 <Obj>           Integer
>>> 0000000000000000
>>> [77998.039031]   Local7: 0000000040665c5c <Obj>           Integer
>>> 000000000000AA55
>>>
>>> [77998.039237] Initialized Arguments for Method [RDWD]:  (2 arguments
>>> defined for method invocation)
>>> [77998.039273]   Arg0:   00000000397dc53d <Obj>           Integer
>>> 0000000000000014
>>> [77998.039442]   Arg1:   000000001099e334 <Obj>           Integer
>>> 0000000000000002
>>>
>>> [77998.039673] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
>>> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
>>> [77998.040455] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
>>> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
>>> [77998.043659] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
>>> state: AE_AML_LOOP_TIMEOUT
>>>
>>> [78028.442980]
>>>                  Initialized Local Variables for Method [RDWD]:
>>> [78028.443019]   Local1: 00000000898a9a7e <Obj>           Integer
>>> 0000000000000017
>>> [78028.443192]   Local6: 000000000cf0c853 <Obj>           Integer
>>> 0000000000000000
>>> [78028.443362]   Local7: 00000000bb4aa65f <Obj>           Integer
>>> 000000000000AA55
>>>
>>> [78028.443569] Initialized Arguments for Method [RDWD]:  (2 arguments
>>> defined for method invocation)
>>> [78028.443606]   Arg0:   00000000ef8d445b <Obj>           Integer
>>> 0000000000000016
>>> [78028.443775]   Arg1:   000000006cacc887 <Obj>           Integer
>>> 0000000000000003
>>>
>>> [78028.444006] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
>>> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
>>> [78028.446366] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
>>> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
>>> [78028.451179] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
>>> state: AE_AML_LOOP_TIMEOUT
>>>
>>> [78032.877472]
>>>                  Initialized Local Variables for Method [RDWD]:
>>> [78032.877509]   Local1: 00000000cf6291ae <Obj>           Integer
>>> 0000000000000017
>>> [78032.877682]   Local6: 0000000026aa8a7a <Obj>           Integer
>>> 0000000000000003
>>> [78032.877851]   Local7: 00000000acfa20e0 <Obj>           Integer
>>> 000000000000AA55
>>>
>>> [78032.878058] Initialized Arguments for Method [RDWD]:  (2 arguments
>>> defined for method invocation)
>>> [78032.878094]   Arg0:   00000000a186096f <Obj>           Integer
>>> 0000000000000016
>>> [78032.878262]   Arg1:   00000000d0e1eefe <Obj>           Integer
>>> 0000000000000003
>>>
>>> [78032.878492] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
>>> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
>>> [78032.881011] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
>>> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
>>> [78032.883061] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
>>> state: AE_AML_LOOP_TIMEOUT
>>>
>>>
>>> This issue appears randomly, affecting the RDWD method, which is
>>> likely responsible for reading data from a bus, and consequently
>>> causing the _PSR method (power state read) to fail.
>>>
>>>
>>> Questions:
>>> 1. What typically causes AE_AML_LOOP_TIMEOUT errors?
>> AFAIK this error is caused by a while loop taking too long to finish. I=
 suspect that
>> the ACPI bytecode tries to wait for a non-responsive hardware device.
>>
>>> 2. Could these ACPI errors impact PCI device access?
>>> Since the error originates from _SB.PCI0.SBUS.RDWD, could this failure
>>> affect PCI device communication or cause failures when accessing PCI
>>> devices?
>> I do not think so, the SBUS device is likely just a SMBus controller at=
tached to the PCI bus.
>>
>>> 3. Could this be a firmware/BIOS issue?If so, what tools or steps
>>> should I use to verify and debug the ACPI tables?
>> It is either a hardware issue or a BIOS bug. Can you share the output o=
f the "acpidump" utility
>> provided by the ACPICA project? Many Linux distributions already packag=
e ACPICA in their package repositories.
> I have attached the acpi.tar.gz file as requested. This archive
> contains the output from the "acpidump" utility. Below is a list of
> the files included in the archive:
>
> ls -ltr acpi
> total 760
> -rw-rw-r-- 1 murphy murphy 205609 Mar 19 18:30 acpi_tables.txt
> -rw-r--r-- 1 root   root       60 Mar 19 18:31 mcfg.dat
> -rw-r--r-- 1 root   root      132 Mar 19 18:31 apic.dat
> -rw-r--r-- 1 root   root      656 Mar 19 18:31 ssdt2.dat
> -rw-r--r-- 1 root   root       66 Mar 19 18:31 uefi.dat
> -rw-r--r-- 1 root   root    36402 Mar 19 18:31 dsdt.dat
> -rw-r--r-- 1 root   root      260 Mar 19 18:31 lpit.dat
> -rw-r--r-- 1 root   root      378 Mar 19 18:31 ssdt3.dat
> -rw-r--r-- 1 root   root      268 Mar 19 18:31 facp.dat
> -rw-r--r-- 1 root   root       68 Mar 19 18:31 fpdt.dat
> -rw-r--r-- 1 root   root     1891 Mar 19 18:31 ssdt1.dat
> -rw-r--r-- 1 root   root      332 Mar 19 18:31 csrt.dat
> -rw-r--r-- 1 root   root       56 Mar 19 18:31 hpet.dat
> -rw-r--r-- 1 root   root       64 Mar 19 18:31 facs.dat
> -rw-r--r-- 1 root   root      890 Mar 19 18:31 ssdt4.dat
> -rw-r--r-- 1 root   root      141 Mar 19 18:31 ssdt7.dat
> -rw-r--r-- 1 root   root     1075 Mar 19 18:31 ssdt5.dat
> -rw-r--r-- 1 root   root      351 Mar 19 18:31 ssdt6.dat
> -rw-rw-r-- 1 murphy murphy   5919 Mar 19 18:31 apic.dsl
> -rw-rw-r-- 1 murphy murphy   8131 Mar 19 18:31 csrt.dsl
> -rw-rw-r-- 1 murphy murphy 337832 Mar 19 18:31 dsdt.dsl
> -rw-rw-r-- 1 murphy murphy  10103 Mar 19 18:31 facp.dsl
> -rw-rw-r-- 1 murphy murphy   1368 Mar 19 18:31 facs.dsl
> -rw-rw-r-- 1 murphy murphy   1802 Mar 19 18:31 fpdt.dsl
> -rw-rw-r-- 1 murphy murphy   1863 Mar 19 18:31 hpet.dsl
> -rw-rw-r-- 1 murphy murphy   7523 Mar 19 18:31 lpit.dsl
> -rw-rw-r-- 1 murphy murphy   1524 Mar 19 18:31 mcfg.dsl
> -rw-rw-r-- 1 murphy murphy   9996 Mar 19 18:31 ssdt1.dsl
> -rw-rw-r-- 1 murphy murphy   7692 Mar 19 18:31 ssdt2.dsl
> -rw-rw-r-- 1 murphy murphy   4296 Mar 19 18:31 ssdt3.dsl
> -rw-rw-r-- 1 murphy murphy   8290 Mar 19 18:31 ssdt4.dsl
> -rw-rw-r-- 1 murphy murphy  16968 Mar 19 18:31 ssdt5.dsl
> -rw-rw-r-- 1 murphy murphy   2843 Mar 19 18:31 ssdt6.dsl
> -rw-rw-r-- 1 murphy murphy   1337 Mar 19 18:31 ssdt7.dsl
> -rw-rw-r-- 1 murphy murphy   1383 Mar 19 18:31 uefi.dsl
>
>
> Please let me know if you need any further details or additional
> information to assist in debugging the ACPI tables.
>
> Thank you for your help.

Alright, it seems that the ACPI bytecode is trying to access the charger u=
sing the smbus interface.
For some reason this takes over 30 seconds which causes the ACPI interpret=
er to throw this error.

Can you check how long it normally takes to read the "online" sysfs attrib=
ute of the charger located
under "/sys/class/power_supply/ADP1"?

Also please share the output of "lspci -v".

Thanks,
Armin Wolf

>>> 4. Is there a recommended workaround to mitigate this issue?
>> You can check if a BIOS update is available for your device.
>>
>>> 4. How can I debug this further?I can enable additional ACPI debugging
>>> logs or provide dumps of ACPI tables if necessary.
>> I can take a look at the \_SB.PCI0.SBUS.RDWD method inside the ACPI tab=
le dumps
>> to see where the error is coming from.
>>
>> Thanks,
>> Armin Wolf
>>
>>> Any guidance on resolving or further diagnosing this issue would be
>>> highly appreciated.
>>>
>>> Best regards,
>>> Naveen
>>>

