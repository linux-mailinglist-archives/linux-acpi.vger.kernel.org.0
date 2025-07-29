Return-Path: <linux-acpi+bounces-15394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A13EB14748
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 06:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213367A9E41
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 04:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EDF2264BE;
	Tue, 29 Jul 2025 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="kH9OoHSk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377ED2AF1C;
	Tue, 29 Jul 2025 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753763391; cv=none; b=SBx/67vIRaN8J1hZ4A+A2ShM8PdDzuwUQPTB8Xc6toGSvOHsvNvYsjwsRCPSM5yJ88FkffTRPDHMaGeE2EHJ2aOlr21n1wbEfqwJiOoXsCOE2h4d9+WThONQitZixEOxDvtTjYc0nt56fqwBJZ4Fg8yDC8ETUosx/00u5W28W/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753763391; c=relaxed/simple;
	bh=I+u/YUUqscAaUp1t2RTa1ns75uBH8iHOpSRDb5//BOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDgAGV90JKVYZwr9IhBf7guZN0S3V7rSF7JS25yJ40ebUeOgNYI3+cNNUM3mpkxQ03dnBZSLkCEvYJUwqBbve72ekjeOXo7dFAFJuYzsyWXJm5X/YdD4BX0XtzkYeHGmkgJ23JnuWAdersc42nLgpG+/+CUvpwYKOrqoStXdCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=kH9OoHSk; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:4419:0:640:5be6:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 07B97C103F;
	Tue, 29 Jul 2025 07:29:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cTQkWhNMVCg0-r669k0oV;
	Tue, 29 Jul 2025 07:29:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1753763379; bh=iFUmRE40v//v5KdBP6CAvHmKPghrFzbvaizMyVYMuwU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=kH9OoHSkr3pG43i/j1u+vPLeZc7mlpxTvZICbo0c9ARNAtLMKv3lOUmEzy8yO+a5M
	 oEAW36lcgro+T+6EUGTwe4oA9mtwdxyn8ar79PXxb10SW7PgFiuMJIcoxnfEWtkTQx
	 b1W9tc8YY488pKJXMJyT7f8jvcGV2LcyQ6nhaoPc=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <4ad3c778-3737-41b5-a1ac-91822f253185@0upti.me>
Date: Tue, 29 Jul 2025 07:29:36 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Ignore ECDT tables with an invalid ID string
To: Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJZ5v0iWS=tHAuauHNHb+N9_GjJTX2-RY01eAS8-sjS_2UZaoA@mail.gmail.com>
 <9323b4ab-f2c2-41ec-be0e-779d327205ca@0upti.me>
 <4e0de0c3-395d-4e70-816c-72a8e75eff8f@gmx.de>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <4e0de0c3-395d-4e70-816c-72a8e75eff8f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-07-29 01:13, Armin Wolf wrote:
>
> Oh no, that sounds horrible 🙁
>
> Can you share the output of "acpidump" once the system is running the latest firmware? If a BIOS update
> does not solve the issue then we could give the ID string check a more leeway so that only empty strings
> are considered invalid.
>

The firmware update did not, in fact, change anything. Here's the entire ECDT:

[000h 0000 004h]                   Signature : "ECDT"    [Embedded Controller Boot Resources Table]
[004h 0004 004h]                Table Length : 00000069
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : 6E
[00Ah 0010 006h]                      Oem ID : "LENOVO"
[010h 0016 008h]                Oem Table ID : "CB-01   "
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "LENO"
[020h 0032 004h]       Asl Compiler Revision : 00000001


[024h 0036 00Ch]     Command/Status Register : [Generic Address Structure]
[024h 0036 001h]                    Space ID : 01 [SystemIO]
[025h 0037 001h]                   Bit Width : 08
[026h 0038 001h]                  Bit Offset : 00
[027h 0039 001h]        Encoded Access Width : 00 [Undefined/Legacy]
[028h 0040 008h]                     Address : 0000000000000066

[030h 0048 00Ch]               Data Register : [Generic Address Structure]
[030h 0048 001h]                    Space ID : 01 [SystemIO]
[031h 0049 001h]                   Bit Width : 08
[032h 0050 001h]                  Bit Offset : 00
[033h 0051 001h]        Encoded Access Width : 00 [Undefined/Legacy]
[034h 0052 008h]                     Address : 0000000000000062

[03Ch 0060 004h]                         UID : 00000000
[040h 0064 001h]                  GPE Number : 6E
[041h 0065 012h]                    Namepath : "_SB.PC00.LPCB.EC0"

Raw Table Data: Length 105 (0x69)

    0000: 45 43 44 54 69 00 00 00 01 6E 4C 45 4E 4F 56 4F  // ECDTi....nLENOVO
    0010: 43 42 2D 30 31 20 20 20 01 00 00 00 4C 45 4E 4F  // CB-01   ....LENO
    0020: 01 00 00 00 01 08 00 00 66 00 00 00 00 00 00 00  // ........f.......
    0030: 01 08 00 00 62 00 00 00 00 00 00 00 00 00 00 00  // ....b...........
    0040: 6E 5F 53 42 2E 50 43 30 30 2E 4C 50 43 42 2E 45  // n_SB.PC00.LPCB.E
    0050: 43 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // C0..............
    0060: 00 00 00 00 00 00 00 00 00                       // .........

It is fully identical on both firmware versions I've seen.


