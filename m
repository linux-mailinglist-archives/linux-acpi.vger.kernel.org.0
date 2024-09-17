Return-Path: <linux-acpi+bounces-8322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA67397B54A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 23:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094861C21767
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C1188A2D;
	Tue, 17 Sep 2024 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruhr-uni-bochum.de header.i=@ruhr-uni-bochum.de header.b="VKi3FhCh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out2.mail.ruhr-uni-bochum.de (out2.mail.ruhr-uni-bochum.de [134.147.42.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC31531C5
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.147.42.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608984; cv=none; b=pSiN/GREACzZ0plxumSayGo2KOPuMPGnU0Z95T813LGQJL0KWAxT9y11qExiqDrks7DPfuW/Rr+rskFek5lNk+mMMRIQV6MGCF8uJzaeJREd9+hJUOPKhNqwPmuu5j9Hz5KPNrMzuuoBhVVgR7ujvaLmv8K9qh3wywPByd9YulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608984; c=relaxed/simple;
	bh=clVlcB30eH68jBncjnorQbI9F5b+j5NaCc/NnkIcOtI=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=r+fVtZ33OZGOn2NVsTSZWEuubx2vnLKQea91BH4E7G47dE2O/UHJ+ci7TtahgP+FDG2hcrNu3UO3Xit39jffzUVjT7cmCt+FaYXPcP4SVGHW6Mnco2+DwvI4a4X/HL3UMRn7zu8FyMPVvRrC4MWodw61KleTGk2D9dZyq8E0QyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruhr-uni-bochum.de; spf=pass smtp.mailfrom=ruhr-uni-bochum.de; dkim=pass (1024-bit key) header.d=ruhr-uni-bochum.de header.i=@ruhr-uni-bochum.de header.b=VKi3FhCh; arc=none smtp.client-ip=134.147.42.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruhr-uni-bochum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruhr-uni-bochum.de
Received: from mx2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by out2.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 4X7ZcX5Jr7z8T8r
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ruhr-uni-bochum.de;
	s=mail-2017; t=1726608444;
	bh=clVlcB30eH68jBncjnorQbI9F5b+j5NaCc/NnkIcOtI=;
	h=Date:From:To:Subject:From;
	b=VKi3FhChP5HUYIwqRrqd1FjEeDKOgVGbB0lR7pK9K+iZlW4jFUsuuSVVghjpFDWLE
	 MDYxzyLwwRsnEbVsA+QDnF9zI4a2bW6TSUgaRV/rxxMnngUk30e5uC6SSr4SthApFS
	 pVyH7XBHANwOoFVhL0dM/7a7h8tEn6bMIs8nJpBg=
Received: from out2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by mx2.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 4X7ZcX4blXz8T8q
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:27:24 +0200 (CEST)
X-RUB-Notes: Internal origin=134.147.42.236
X-Envelope-Sender: <David.Renz@ruhr-uni-bochum.de>
Received: from mail2.mail.ruhr-uni-bochum.de (mail2.mail.ruhr-uni-bochum.de [134.147.42.236])
	by out2.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTPS id 4X7ZcX2xDYz8T8K
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:27:24 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mx2.mail.ruhr-uni-bochum.de
Received: from webmail1.mail.ruhr-uni-bochum.de (webmail1.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2aea])
	by mail2.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 4X7ZcX19WZzDgyl
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:27:24 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.2.1 at mail2.mail.ruhr-uni-bochum.de
Received: from 2a00:6020:409a:2f00:3ad5:7aff:fea6:38f9
 by webmail1.mail.ruhr-uni-bochum.de
 with HTTP (HTTP/1.1 POST); Tue, 17 Sep 2024 23:27:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 23:27:24 +0200
From: David Renz <David.Renz@ruhr-uni-bochum.de>
To: linux-acpi@vger.kernel.org
Subject: ACPI issues on HP laptop: 3 critical failures and 5 high failures
User-Agent: RUB Webmail/1.6.8 via Mozilla/5.0 (X11; Linux x86_64; rv:130.0)
 Gecko/20100101 Firefox/130.0
Message-ID: <5720ca99e4dbdfdb3580a96342b11ac3@ruhr-uni-bochum.de>
X-Sender: David.Renz@ruhr-uni-bochum.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I bought my HP laptop about 2 or 3 years ago and never flashed any ACPI 
tables by myself. When I was still using Windows besided Windows, I 
flashed the official HP BIOS update which covers the ACPI tables as well 
I think. However, the abovementioned issues with the ACPI code weren't 
affected at all by performing a BIOS update.

When I let FWTS perform all its tests, I get this result:

Critical failures: 3
  klog: CRITICAL Kernel message: [    1.884417][  T426] ACPI BIOS Error 
(bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.Z009], AE_NOT_FOUND 
(20230628/psargs-330)
  klog: CRITICAL Kernel message: [    1.884457][  T426] ACPI Error: 
Aborting method \_SB.UBTC.M318 due to previous error (AE_NOT_FOUND) 
(20230628/psparse-531)
  klog: CRITICAL Kernel message: [    1.884484][  T426] ACPI Error: 
Aborting method \_SB.UBTC._DSM due to previous error (AE_NOT_FOUND) 
(20230628/psparse-531)

High failures: 5
  klog: HIGH Kernel message: [    0.283459][    T1] ACPI Error: 
AE_ALREADY_EXISTS, During name lookup/catalog (20230628/psobject-221)
  uniqueid: \_SB_.I2CD.TPD0._CID/_UID conflict with 
\_SB_.I2CA.TPNL._CID/_UID
  ivrs: IVRS must have subtable with Type 1..4, got 0 instead
  ivrs: IVRS Flags Bits [7..6] must be zero, got 0xb0 instead
  ivrs: IVRS IOMMU Attribute Bits [12..0] must be zero, got 0x00040200 
instead


I dumped, extracted and disassembled all my ACPI tables, since I wanted 
to know where these functions can be found, although I don't know much 
about AMI unfortunately.

_SB.UBTC.M318 and _SB.PCI0.SBRG.EC0.Z009 are in ssdt5.dsl.
_SB.UBTC._DSM can't be found in any disassembled table, but there is a 
Method (_DSM, 4, Serialized), which is also in ssdt5.dsl.

Gentoo also reported ACPI errors/bugs in its dmesg and since it's not 
just a test suite like FWTS it showed some more stuff, which might be 
interesting:

[    0.277540] ACPI BIOS Error (bug): Failure creating named object 
[\_SB.PCI0.SBRG.EC0._Q50], AE_ALREADY_EXISTS (20230628/dswload2-326)
[    0.277555] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog 
(20230628/psobject-220)
[    0.277563] ACPI: Skipping parse of AML opcode: OpcodeName 
unavailable (0x0014)
[    0.277941] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.280325] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.282502] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.282936] ACPI: EC: EC started
[    0.282940] ACPI: EC: interrupt blocked
[    0.284881] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.284887] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle 
transactions

I'm well aware of the fact that all of you developers put endless effort 
in all this which will be very time-consuming, so of course I'd 
understand it if you don't feel like explaining ACPI stuff in your free 
time... But I would really appreciate it, if someone could explain me 
what "Boot DSDT EC used to handle transactions" concretely imply? I'm 
really curious about this, since _SB.PCI0.SBRG.EC0.Z009 caused the 
critical failure.

I don't know much about AML, but I program in C/C++ and Assembler, so if 
anyone feels like doing so, please explain it on a programmer's level.

As I can see in ssdt5.dsl _SB_.PCI0.SBRG.EC0_.Z009 is defined as a 
MutexObj in line 25 and then is relevant for the conditional block in 
Method M318 which starts in line 452.

Is it really normal that there are so many errors in the ACPI code? I 
mean especially if klog reports them as CRITICAL they shouldn't be just 
ignored, isn't?

If a BIOS update doesn't fix ACPI errors, then would it be possible to 
fix them manually, compile the code and then write them to the tables?

I uploaded my disassembled ssdt5.dsl to pastebin.com:
https://pastebin.com/hBUL4qif

However, I wanted to share my dsdt.dsl with you as well as some of the 
mentioned methods/symbols can be found there are as well, maybe shedding 
some light on an issue with them. So I decided to upload the whole 
folder containing my HP laptop's dumped, extracted and disassembled ACPI 
tables on my GDrive:
https://drive.google.com/drive/folders/11FSdWRMoFE-cmzBfecdSvO8CfRkCCbro?usp=drive_link


Kind regards and thanks in advance

David

