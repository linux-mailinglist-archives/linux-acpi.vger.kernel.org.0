Return-Path: <linux-acpi+bounces-7281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B956947A5A
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 13:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823A01F21E14
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37452154BE4;
	Mon,  5 Aug 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U68WF+9y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D814F9F7
	for <linux-acpi@vger.kernel.org>; Mon,  5 Aug 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857291; cv=none; b=S5s1R7uCKQfuaei6R2GoIFZAkWrtsZvoAXSls8CZFmkc2b3cumEhEBLYs/fPPP6NrRTWCw35QlvnJGL3xItvnCwmWn5SeSh5GxCVPWcm2QHB8pUBsLryNYkX0x29lpiDKpW0mh4VPS3OblWj+YG0R8V40jPl0AR0s8Uk1tx7DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857291; c=relaxed/simple;
	bh=f8IKBB1WvRXcKYpauGwa13NXjJo7uhM3OZl0wnv2O0o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D7nFpt4Zph+2uHozhMBJGoAaAlHrt0Y/uea5uvqu60xIjeTH1UFVVKKXXG8qWZvVGDdCrKc7zLi75AqgVGTe9CTQ47TsGmMGaGnqARJ345g5wUUSCid2bxcxxtJq2RtUHP7TlptwwKoIHRcOeDQYD8/lHCaSm1PtgemmsjcjRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U68WF+9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722857288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TszH4j0AY8EjJzCBEcEsOg/rJD9bXxbKfYQ6OjNkvLA=;
	b=U68WF+9yRBet6Dvw1lm9znSadt/RmTq1WowbZJGzFHyygeWrMjnpFaJ3S9z9k0EcKaj2Hd
	Qje5VIPrnzDvyKHt6kR33ZVsk73nghk1vH5JtlEqP4JjpIyeJpAmow4xAlRiYFVnV8qQiO
	Asu6+O4jZlB52h6WXi5xotthl0iuATQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-XITHH1_uOQmrwWaQV2lkkg-1; Mon, 05 Aug 2024 07:28:07 -0400
X-MC-Unique: XITHH1_uOQmrwWaQV2lkkg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7aa3181bc2so873814566b.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Aug 2024 04:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857285; x=1723462085;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TszH4j0AY8EjJzCBEcEsOg/rJD9bXxbKfYQ6OjNkvLA=;
        b=KLEdgeQdFLVBypGSp+eWQSQMPyWln77yyq6/s02JRnEFhRHrR4DtkVnMsoAsrTgrlk
         1KyNYllq5q+efcrtDnm+GpQY2NGcWz4sZreiyybhQ3CjLLqTj3/MMyEgb/Q1sFMC24mF
         a/ml2Z7rsbfNeRTTCtNbwxu41mHDVjH09xFYjg/Yt12I5SKoWq5HebRcLTWS/nEToZiR
         fOEf0clgFlnA623iJcAXyP2ES7P/WOo6tOjD2l8RAdv8h+874eL4CyBA/P2MexK1guVn
         GbQakbTO4HbNaEHVTxugOoqrlwzKcP0bt4jFRSNXj0HEGGEtQScy9JiihxKEryPpJXhr
         shdw==
X-Gm-Message-State: AOJu0YzqMM+EsAI8MG97XXbp6QRsr0DFL9TkfEvvLX25YW1L9/eMFvfk
	TPgQ4aaOlCPaRuSjQpFEZ65hXOas9MtY/i4z+2z+XlGZpfNPK8rtlNC+XLAhkZ63M/uRBcN81V9
	vH8Pz4mMtOioKVezPQiDVzfJ3wrsHFvk44siN/xdx03k8H05rBYEKhbofENvp+9tCjbI=
X-Received: by 2002:a17:907:841:b0:a7a:aa35:4091 with SMTP id a640c23a62f3a-a7dc504a619mr851472266b.25.1722857285400;
        Mon, 05 Aug 2024 04:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNlE11E+zzWMZx2hAzSbuRGCi6qJlOYFcZQxwB0dzztq4WpfbZ37ucCmeAyTSOC+oW14JuFQ==
X-Received: by 2002:a17:907:841:b0:a7a:aa35:4091 with SMTP id a640c23a62f3a-a7dc504a619mr851469766b.25.1722857284820;
        Mon, 05 Aug 2024 04:28:04 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4dd32sm443287266b.120.2024.08.05.04.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 04:28:04 -0700 (PDT)
Message-ID: <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
Date: Mon, 5 Aug 2024 13:28:03 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
Content-Language: en-US
In-Reply-To: <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/1/24 4:28 PM, Hans de Goede wrote:
> Hi,
> 
> On 7/29/24 1:15 PM, Hans de Goede wrote:
>> Hi Rafael,
>>
>> There are 2 bug reports:
>>
>> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
>> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
> 
> I have filed:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2302253
> 
> to track this now and an acpidump of the troublesome LG laptop
> is attached there. I have also requested dmesg output of
> a non working kernel to be attached there.
> 
> As a reminder this is the bug where it has been confirmed that
> reverting "EC: Install address space handler at the namespace root"
> helps, with the caveat that there is a Thunderbolt related IRQ
> storm on the ACPI event IRQ after the revert ...

Ok, so the bugzilla now has 2 different dmesg outputs:

1. 6.9.6, this kernel works without problems

2. 6.9.12 with the following patch you suggested on top:

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_ec_setup(ec, NULL, true);
+	ret = acpi_ec_setup(ec, NULL, false);
 	if (ret) {
 		acpi_ec_free(ec);
 		return;

Unfortunately this does not help. dmesg shows some EC _REG errors, which
are now (with the above diff applied) shown just before the
"Boot DSDT EC initialization complete" message, which shows that _REG now
runs from acpi_ec_add() rather then before:

[    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.FN00._OFF], AE_NOT_FOUND (20230628/psargs-330)
[    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
[    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
[    1.007639] ACPI: EC: interrupt unblocked
[    1.007640] ACPI: EC: event unblocked
[    1.007675] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.007676] ACPI: EC: GPE=0x6e
[    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initialization complete
[    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transactions and events

Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, where as the actual
EC (and the only acpi_device on which _REG would get called for the EC Opregion before) is:
\_SB_.PC00.LPCB.LGEC.

Looking at the DSDT it seems that the H_EC is not used and is leftover from a copy/paste
from some reference design DSDT. Its _REG however does write to the EC before hitting the error
and I think that that write may be causing the issue...

The H_EC device does have an _STA method and looking closer the troublesome EREG method is
also called from _INI. So I guess that _STA is returning 0 causing _INI to not run and
that is the reason why we are not seeing the same EREG errors with kernel 6.9.6 where _REG is
only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for the entire ACPI device
hierarchy as is done with >= 6.9.7 .

Maybe we should only call _REG for the EC opregion on present devices (and devices without
a _STA)?

Also note that both LGEC and H_EC use the same cmd + data ports.

I'll go and ask the reporter to retreive the status of both LGEC and H_EC and then see
from there.

Regards,

Hans



