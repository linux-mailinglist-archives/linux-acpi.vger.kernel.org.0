Return-Path: <linux-acpi+bounces-12403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B527A6C532
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 22:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9F7189ED7E
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E711EC006;
	Fri, 21 Mar 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iRUrWpM/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0A2A1C9;
	Fri, 21 Mar 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592732; cv=none; b=KDIcxK0DvIVsihDCogRfzVBLXhWgXrIwcwQfLcRnkCf+jzMEz9/mALH1JD8WR6Kc11SNFiIHA6K8y7PS8XAi5qAH2HCxJYLpQKvxxbMFsNxFGstpsHg6U00mFeSYOuK+QJeQ5pJquaS8m5miP7FwOR3l0s9vW5MfM0ReOujiWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592732; c=relaxed/simple;
	bh=AiSF0taCPtAbCj/Jo802euiTTy2pybGWqqQuMyKK00Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhbJcK8XleNnZ+kzegdb0QxCpCuyzBBnPEeqpF0KwKKgrpboLsDlSVNP+z/4nf8pkFlqQoh+Jgik/oMaYJdhknZw0BDiD9+Ebp6VwgV0+COkQr4yy4+9q4ksjbhpaoixihvFMyzmX1TQXQ7bmSPDW7+2PTtsxx/8Ca4GkXZ8IrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iRUrWpM/; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742592727; x=1743197527; i=w_armin@gmx.de;
	bh=3e5ug+4xA4zpPk5sovOFRoxjUepViknWU7eJy3SktRY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iRUrWpM/8JMZAgV878aYcmsOoW0QjMSOriIbxXnW0hCHcWC7hc7mQ180Ip+XSPMl
	 IxVHGlmx3fMNwaH5OWSs+c0vnL/aoYv/eoU9QYgHXKIWhVqwArXUEofB+uyD7QY1M
	 f3zl40/W4IAR7fdD9mXnz+wVUJT2C6btcIET5mpj/x7lCwMj+Ymmdzt8F3M30mRHW
	 o7S/koRqWdC+L1X1fFlITNpL4Jssc4PyoLEKd4cCgvo1+YX08/2l/cRGyUTA7YJ5i
	 /LuwhhfP3i4On8CRgHHt7mfVsv06cSk8hpzRvkHbh6RFsLFSCaHBLEviAKzThcU8M
	 NNVVkxW/7rkrjfWLKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1tCkV60m0d-017RCN; Fri, 21
 Mar 2025 22:32:07 +0100
Message-ID: <07e2fb25-625b-441e-86f7-d0d54138c4aa@gmx.de>
Date: Fri, 21 Mar 2025 22:32:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI Error: AE_AML_LOOP_TIMEOUT in \_SB.PCI0.SBUS.RDWD &
 \_SB.PCI0.SBRG.ADP1._PSR
To: Naveen Kumar P <naveenkumar.parna@gmail.com>, linux-acpi@vger.kernel.org,
 rafael@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <CAMciSVUVjLj44LW+3ALB1fJQsUiw_2BQ5tLgpNJH08Xmj=Wr9w@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAMciSVUVjLj44LW+3ALB1fJQsUiw_2BQ5tLgpNJH08Xmj=Wr9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:P/5BBG/1gjEzQ+E7mlrpDnBID5LzOqKzMaIevweO9qcbL0PSLC8
 Z+7QvdOUJm5Us9ONOm6nMHjQ8IoTHf6MDexk3B8YJ/AqiR+U0TMttYtXRSka87KfBciwl/e
 YbVFhbjup0kQolcQnzbYNJIMZp+pQOhPAy+yOMOJzUbXDBY8Ecztp3SVU1GilB+V2p01O9Z
 5pPCT6kOvHfJfTtGBIjzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2jAwyIpRlzU=;06BjuQ5K2n520XRgdWcPXUlxUH7
 isQDA3J0dQOJ1/nq5aO84yiSTTkJZfFfM/SCoFJBE29uUun/Xvi4+kJkwDZ/g4nQsLZMuhdWA
 UBHlIcwL+8uiXlZMoUnqnMVIEn3mMaT826bamgW7jKN36GoMB+j5P5HIvqdfd8N2Spz5jeko/
 qyFRfZcXGKUiTYkBlDGpEWHAK9GvyZW7wGvTia7ANbQAok0njw4/CiNWvWmV59b++mMn2+hAn
 9oUrBjz7nE072Tk3ERDok+xz5xlEULYhoHWV/dbjyrxd9Qd8gMBO4uh4hbRehN78Orwmq59Pp
 Ng1hQP4sy6mGUBgWjuACAZsvD977oP0wFOVB/9SYt/RHUjeiwZX5i3ODdDuIbTPXF97iUia4I
 vzn5R1/4udlaR2erl7leKzbQ18i0mtCuL7vCrRo9SDbLdil5Uw/xIs40H4bXvlSyIU55XjcL5
 cxPBbUp4MEf5qrsKCp3hEskc7KVmjlP1YetUU4zIqPQ64Hnu7zkD2Jffdcyy2ltaiAZ9j7y7i
 VMVAHOP4mbvkz+g7XgeNnNPuRECHUDT/IJxKiDvLP8u6sC03R3w7QjxP4jvPf+MjmcyUeC0hf
 Ref/F/Qyt0xTsVdMs3146hcq7XkaWruwaWSEPkxD5rpB+Isong1+XEp6MaqUw09Tur5FDQ74q
 lwoGMjepjgl45Oh/RqKLALd+KuKAe/z8kEU35ImOAt216ukOC5flf4XEVbV9zPWq8C5zEuphf
 mAwtOVt3XOY/wgu9oRd4q9TKrGZw8UNRRIDA6sRjooVYZSbqMT2v1qSga1eaLwosvmq2AF73N
 8APg9izV8PZpufxMLheNxmovxPNN9YTNn+oN4yUj7Dukur1agJWU39ZNUSj/EahahqaQv0KtG
 jUOaZQufKClh29aYw4Pkt7ZBAgSdTbKlNkK5AThpiZ1+xu1tU4ln5GuvWUQa3lUJqlyExxSVJ
 R/wgW6QPDIho6C+2jxokUU/rL50oIk2XREEA0GAk+xzXRFcwcqCEEll930EXleYvoJfAiZvcd
 iEBmFCvcy3YotvnVjie4/w9yLUccWI0Tsywq3gULm0+H+pFhhWX9dnQZqtb7PdzSuLr1RoGf2
 j3QlttknUJ5kAWbgP7c6HfT6Cv61k87j33KXvq+VooReQXHJkvciyddG4IXx+wfD83cPIE0KC
 YMHFcpLo8phJq70zz0Zyqxu0TiCz/HK87Q0jr84SSv6euuc+iqxAGsVyl/E/ZIVucbfR2prU7
 BEnif76dhgOPkvD2W86/eUn6UjRW6gMwlg7noxtu/nYE4SmDrL4bI/hZkv5Wj2sWf3XiD9u7u
 V7AdCyDjaThkqjkhcQumCIqWiZqyRAvyog/r5WK/uwwaj8QO52ua9TLMPsEG82KcQmdajaU16
 DKtylO5l45VmxISRWQloyhOZ33qQjofIdX7hjFNhLgN/LJeo+89bj2TO4eK/h47EQ9symLr4B
 HkNsXNo0toBF1M/FGB3H551TgFKw=

Am 19.03.25 um 12:29 schrieb Naveen Kumar P:

> Hi all,
>
> I am encountering repeated AE_AML_LOOP_TIMEOUT errors in the ACPI RDWD
> & \_SB.PCI0.SBRG.ADP1._PSR methods. Below are relevant log entries
> from my system running Linux kernel 6.13.0+:
>
> [77998.038653]
>                 Initialized Local Variables for Method [RDWD]:
> [77998.038691]   Local1: 00000000d0fe9fee <Obj>           Integer
> 0000000000000015
> [77998.038862]   Local6: 00000000f41c1645 <Obj>           Integer
> 0000000000000000
> [77998.039031]   Local7: 0000000040665c5c <Obj>           Integer
> 000000000000AA55
>
> [77998.039237] Initialized Arguments for Method [RDWD]:  (2 arguments
> defined for method invocation)
> [77998.039273]   Arg0:   00000000397dc53d <Obj>           Integer
> 0000000000000014
> [77998.039442]   Arg1:   000000001099e334 <Obj>           Integer
> 0000000000000002
>
> [77998.039673] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> [77998.040455] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> [77998.043659] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
> state: AE_AML_LOOP_TIMEOUT
>
> [78028.442980]
>                 Initialized Local Variables for Method [RDWD]:
> [78028.443019]   Local1: 00000000898a9a7e <Obj>           Integer
> 0000000000000017
> [78028.443192]   Local6: 000000000cf0c853 <Obj>           Integer
> 0000000000000000
> [78028.443362]   Local7: 00000000bb4aa65f <Obj>           Integer
> 000000000000AA55
>
> [78028.443569] Initialized Arguments for Method [RDWD]:  (2 arguments
> defined for method invocation)
> [78028.443606]   Arg0:   00000000ef8d445b <Obj>           Integer
> 0000000000000016
> [78028.443775]   Arg1:   000000006cacc887 <Obj>           Integer
> 0000000000000003
>
> [78028.444006] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> [78028.446366] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> [78028.451179] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
> state: AE_AML_LOOP_TIMEOUT
>
> [78032.877472]
>                 Initialized Local Variables for Method [RDWD]:
> [78032.877509]   Local1: 00000000cf6291ae <Obj>           Integer
> 0000000000000017
> [78032.877682]   Local6: 0000000026aa8a7a <Obj>           Integer
> 0000000000000003
> [78032.877851]   Local7: 00000000acfa20e0 <Obj>           Integer
> 000000000000AA55
>
> [78032.878058] Initialized Arguments for Method [RDWD]:  (2 arguments
> defined for method invocation)
> [78032.878094]   Arg0:   00000000a186096f <Obj>           Integer
> 0000000000000016
> [78032.878262]   Arg1:   00000000d0e1eefe <Obj>           Integer
> 0000000000000003
>
> [78032.878492] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> [78032.881011] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> [78032.883061] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
> state: AE_AML_LOOP_TIMEOUT
>
>
> This issue appears randomly, affecting the RDWD method, which is
> likely responsible for reading data from a bus, and consequently
> causing the _PSR method (power state read) to fail.
>
>
> Questions:
> 1. What typically causes AE_AML_LOOP_TIMEOUT errors?

AFAIK this error is caused by a while loop taking too long to finish. I suspect that
the ACPI bytecode tries to wait for a non-responsive hardware device.

> 2. Could these ACPI errors impact PCI device access?
> Since the error originates from _SB.PCI0.SBUS.RDWD, could this failure
> affect PCI device communication or cause failures when accessing PCI
> devices?

I do not think so, the SBUS device is likely just a SMBus controller attached to the PCI bus.

>
> 3. Could this be a firmware/BIOS issue?If so, what tools or steps
> should I use to verify and debug the ACPI tables?

It is either a hardware issue or a BIOS bug. Can you share the output of the "acpidump" utility
provided by the ACPICA project? Many Linux distributions already package ACPICA in their package repositories.

>
> 4. Is there a recommended workaround to mitigate this issue?

You can check if a BIOS update is available for your device.

>
> 4. How can I debug this further?I can enable additional ACPI debugging
> logs or provide dumps of ACPI tables if necessary.

I can take a look at the \_SB.PCI0.SBUS.RDWD method inside the ACPI table dumps
to see where the error is coming from.

Thanks,
Armin Wolf

>
> Any guidance on resolving or further diagnosing this issue would be
> highly appreciated.
>
> Best regards,
> Naveen
>

