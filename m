Return-Path: <linux-acpi+bounces-15395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DB4B14768
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 07:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298651AA1605
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 05:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331C22F386;
	Tue, 29 Jul 2025 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="erJ6NFEe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF044A02;
	Tue, 29 Jul 2025 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765484; cv=none; b=o3ZNWoZx+azNapvkYWIUphTLNxlzaPGo1GLRMgshOrE20XnHd3/Iji5Jgemt8CYTqEUwzcXYHxoirFrQFCR5S5fjmNmlJvdAHIynbidIYMxQzSMzNzjSFbe008iDbnMx97E5pSykvDUW02f1yhescLxOxS/UNpoKNsQjyGvVH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765484; c=relaxed/simple;
	bh=0yJ/z1mGoa31nGODjkVPs56WhbOWTbOZRygBno0yF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kER6mOjq3lrCrqm/j8gGq1ZTN9j2vO/o5Job9OjRQqqYcUSNgeFqBQYILzPw6xf5VKvUKAJz0ByjHTvUq1Pg6UJCH2LDnzcrtqi5IL3ij3g3PCSnctEePZN2H6xgTyUyXyTBOTVveXtEBL+RKlAJKLfr+vGKaDXunUzLZlG9+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=erJ6NFEe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753765479; x=1754370279; i=w_armin@gmx.de;
	bh=RUIPzxbFNVoWw19BwGwEWsGWKbwmAJ3BollIG06mtBk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=erJ6NFEemWpadusGP38KrVP0FhLtLB5P3wPmSY9QU8rd3Eojbz+Wxb4dy65tnfiQ
	 O853LSypYGW4B7/tvdGOSpRH/zrGF4nzE/077OYDYRD+pvJUwIhFZrJrYlvhPJRaP
	 TQt3sXXQZGK+U3MyKGox87HJDZCQ7Ovp9a/f37RiCsDGAyvaRPLVCN5Z6vZpDMxbX
	 rV8LT8/sdbD45Ic85qzc/YfvHLD0OR4NSfAqHY3UClKZROfE4zK56GZLO3CbYkyGo
	 NHWwT+M3FW0tQo7lc60Tnj8av+bU7G9gCIQaNkPiGnrQYpMgEEexFI5eNkoxKRrDL
	 pdB/jtSVzF8NijWnDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1uwVTR0mMs-00PHdS; Tue, 29
 Jul 2025 07:04:39 +0200
Message-ID: <503e471c-be4e-4678-9f9d-c2294b426d2e@gmx.de>
Date: Tue, 29 Jul 2025 07:04:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Ignore ECDT tables with an invalid ID string
To: Ilya K <me@0upti.me>, rafael@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJZ5v0iWS=tHAuauHNHb+N9_GjJTX2-RY01eAS8-sjS_2UZaoA@mail.gmail.com>
 <9323b4ab-f2c2-41ec-be0e-779d327205ca@0upti.me>
 <4e0de0c3-395d-4e70-816c-72a8e75eff8f@gmx.de>
 <4ad3c778-3737-41b5-a1ac-91822f253185@0upti.me>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4ad3c778-3737-41b5-a1ac-91822f253185@0upti.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x0rOAUqI9H0x0N5rt+PkqgiVKNgsKHyPmTJvaxht2vhooZl1isQ
 QSi2rUV0aLx+cNGg9GgRzkVS9nVeZ//jF8fVZqUuuuZIPAuZLKO5b7xIch0LzflzE+0OfkM
 owHY3pc/EsRKp5IPVodWkAjGWtpm31ZNhj/HB48U72v47MVzSgoh0bwAGQsDCpIMJHbRobR
 +8II1nsC8lFgwF7LhE2nA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pQ8jnQ9NP/Y=;705EXbdsMbWBpcK5UuFRiQZPMgT
 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
 fYalTJS+2PjYo2lz1lD1bNQhMqQLayF4=

Am 29.07.25 um 06:29 schrieb Ilya K:

>
> On 2025-07-29 01:13, Armin Wolf wrote:
>> Oh no, that sounds horrible =F0=9F=99=81
>>
>> Can you share the output of "acpidump" once the system is running the l=
atest firmware? If a BIOS update
>> does not solve the issue then we could give the ID string check a more =
leeway so that only empty strings
>> are considered invalid.
>>
> The firmware update did not, in fact, change anything. Here's the entire=
 ECDT:
>
> [000h 0000 004h]                   Signature : "ECDT"    [Embedded Contr=
oller Boot Resources Table]
> [004h 0004 004h]                Table Length : 00000069
> [008h 0008 001h]                    Revision : 01
> [009h 0009 001h]                    Checksum : 6E
> [00Ah 0010 006h]                      Oem ID : "LENOVO"
> [010h 0016 008h]                Oem Table ID : "CB-01   "
> [018h 0024 004h]                Oem Revision : 00000001
> [01Ch 0028 004h]             Asl Compiler ID : "LENO"
> [020h 0032 004h]       Asl Compiler Revision : 00000001
>
>
> [024h 0036 00Ch]     Command/Status Register : [Generic Address Structur=
e]
> [024h 0036 001h]                    Space ID : 01 [SystemIO]
> [025h 0037 001h]                   Bit Width : 08
> [026h 0038 001h]                  Bit Offset : 00
> [027h 0039 001h]        Encoded Access Width : 00 [Undefined/Legacy]
> [028h 0040 008h]                     Address : 0000000000000066
>
> [030h 0048 00Ch]               Data Register : [Generic Address Structur=
e]
> [030h 0048 001h]                    Space ID : 01 [SystemIO]
> [031h 0049 001h]                   Bit Width : 08
> [032h 0050 001h]                  Bit Offset : 00
> [033h 0051 001h]        Encoded Access Width : 00 [Undefined/Legacy]
> [034h 0052 008h]                     Address : 0000000000000062
>
> [03Ch 0060 004h]                         UID : 00000000
> [040h 0064 001h]                  GPE Number : 6E
> [041h 0065 012h]                    Namepath : "_SB.PC00.LPCB.EC0"
>
> Raw Table Data: Length 105 (0x69)
>
>      0000: 45 43 44 54 69 00 00 00 01 6E 4C 45 4E 4F 56 4F  // ECDTi....=
nLENOVO
>      0010: 43 42 2D 30 31 20 20 20 01 00 00 00 4C 45 4E 4F  // CB-01   .=
...LENO
>      0020: 01 00 00 00 01 08 00 00 66 00 00 00 00 00 00 00  // ........f=
.......
>      0030: 01 08 00 00 62 00 00 00 00 00 00 00 00 00 00 00  // ....b....=
.......
>      0040: 6E 5F 53 42 2E 50 43 30 30 2E 4C 50 43 42 2E 45  // n_SB.PC00=
.LPCB.E
>      0050: 43 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // C0.......=
.......
>      0060: 00 00 00 00 00 00 00 00 00                       // .........
>
> It is fully identical on both firmware versions I've seen.
>
Alright, seems that we have to give the ID string a bit more leeway. I wil=
l prepare a patch for this.

Thanks,
Armin Wolf


