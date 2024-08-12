Return-Path: <linux-acpi+bounces-7531-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD7D94EBE0
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 13:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A06C2821E6
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82690175D3F;
	Mon, 12 Aug 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib10ZNXA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7908175D2A
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462450; cv=none; b=ZBHfIpAiElMzvBZklYIrJ1xvdOpR3geRRL5Lk9JdTbSp7gG3HEeicy1dm3ZV6ZwzAbBIQWViKQBShCXjYAWCVJkGfZcjZClgMfdU5MOWkhrklV9BSJg0Mc6puVMLJza5RIRQQxqDWwQdhYpcr8KUfzp8bGJnfQ4VW+Cc3KL0QO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462450; c=relaxed/simple;
	bh=Awlw8YPBjW7yPfIYbCCr0kAYcxzQnltqq8x9+I3MBkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YX4LoBLrxUWUhV05QRGT58Q9i+Q7bCfpOyoKB+P9Z4Ot8HNUyJXFwdHQNQYa2aTW1Vnt77z/ocvEsVBSxDqpzyp4e/MnA0UjbHtLhpVMMG4/KH1GTGYwOR6JKB5WjCqn/G9FFiLrpf6i8b8YhYxSXiQieVOL5YEmd+yJQd8jMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib10ZNXA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723462447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkxsgKQR/7oRITowVYPVxjOCi5yJe8oX0v1GsisC88k=;
	b=ib10ZNXAEDebA56nnPBNCwqE5dFzMUdOo7m0fFhswu9UNrBYK3wCeau4JZtXXE6GKHQtIg
	LzVCu76DLv7647KKhCES2dopXV9kBG1cpb3blAAW991z6tG1/K5z6mXuuzjjcwpXv7aEsq
	OgD2pk8e/MIoobpI0i2H8n/lOJngJE0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-xf3zRKazPUqc5Io4k14OeA-1; Mon, 12 Aug 2024 07:34:06 -0400
X-MC-Unique: xf3zRKazPUqc5Io4k14OeA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bb90be4d87so3342610a12.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 04:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723462445; x=1724067245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkxsgKQR/7oRITowVYPVxjOCi5yJe8oX0v1GsisC88k=;
        b=Ug+keKpor/G4FPzGJHCDKd1jeovNlAIweeCzkRHLZ7zrWu34H8X4m+8Ydwn3wu6t+O
         PUOA4+ElKF7uU9mKNsoMLc0UGxfmu3CGwQ+C/tzG5jgUn9vHMCKgQ10W6c96unyd/X6x
         Y1Atr8fmkKf2UuzIr1EIWfQE1Vy1rn2DX19v+pHjodN4iTeKAlJgF5GoY+AQx2c93Pk1
         4y90LtlhS+W7TmgHWLXdZ6H9ksmK+t4xvk6bHk5vl7f+LpOr9eyJPrc73vvVJN2AAcq6
         XYWrzQcnN5Eo0glPckv5LsTdRXz2yBexCL3scL4On4Fiz5L++FDM/oJUBanm3qzbCkp7
         q7tA==
X-Gm-Message-State: AOJu0YyoT2nXOGH+4SoHDN9A2s9FhiwZbBE5rvSvwurobd6bZBZDcDl1
	4xN4ska1J73Kfbjok3jONpTvYYM59pwrglnh4zK/FKNhQnDiyryWCGx1aDTsOgDBaV6AbKtvtYD
	0EX98fBMU5C+WGv0bnyb2OcR5tx86Q2vIT83p4IqBdBtrnDXGR9YwWHxze1k=
X-Received: by 2002:a05:6402:1910:b0:57d:10db:488e with SMTP id 4fb4d7f45d1cf-5bd0a6116e1mr5925293a12.30.1723462444751;
        Mon, 12 Aug 2024 04:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8b8SuLHknRscIBnZmoT0rdprB0gFXr4l/MGnuLDjukPxc8DCCwPAbgOqcpbX4Oiw/pkctYg==
X-Received: by 2002:a05:6402:1910:b0:57d:10db:488e with SMTP id 4fb4d7f45d1cf-5bd0a6116e1mr5925270a12.30.1723462444182;
        Mon, 12 Aug 2024 04:34:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a6020d8sm2024108a12.88.2024.08.12.04.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 04:34:03 -0700 (PDT)
Message-ID: <09074f20-b941-4764-9517-f157b1f6ffd3@redhat.com>
Date: Mon, 12 Aug 2024 13:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: Armin Wolf <W_Armin@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
 <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
 <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
 <CAJZ5v0gAdAYvx=qwmQd9_tUc-d=LJW5KDzLns2eDDn=ZtCQCMw@mail.gmail.com>
 <4dea0fef-d9f9-416a-b554-cc46ee6c2197@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4dea0fef-d9f9-416a-b554-cc46ee6c2197@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/9/24 8:02 PM, Armin Wolf wrote:
> Am 09.08.24 um 15:17 schrieb Rafael J. Wysocki:
> 
>> On Thu, Aug 8, 2024 at 7:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> Hi,
>>>
>>> On Mon, Aug 5, 2024 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 8/5/24 1:28 PM, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 8/1/24 4:28 PM, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 7/29/24 1:15 PM, Hans de Goede wrote:
>>>>>>> Hi Rafael,
>>>>>>>
>>>>>>> There are 2 bug reports:
>>>>>>>
>>>>>>> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
>>>>>>> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
>>>>>> I have filed:
>>>>>>
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2302253
>>>>>>
>>>>>> to track this now and an acpidump of the troublesome LG laptop
>>>>>> is attached there. I have also requested dmesg output of
>>>>>> a non working kernel to be attached there.
>>>>>>
>>>>>> As a reminder this is the bug where it has been confirmed that
>>>>>> reverting "EC: Install address space handler at the namespace root"
>>>>>> helps, with the caveat that there is a Thunderbolt related IRQ
>>>>>> storm on the ACPI event IRQ after the revert ...
>>>>> Ok, so the bugzilla now has 2 different dmesg outputs:
>>>>>
>>>>> 1. 6.9.6, this kernel works without problems
>>>>>
>>>>> 2. 6.9.12 with the following patch you suggested on top:
>>>>>
>>>>> --- a/drivers/acpi/ec.c
>>>>> +++ b/drivers/acpi/ec.c
>>>>> @@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
>>>>>         * At this point, the GPE is not fully initialized, so do not to
>>>>>         * handle the events.
>>>>>         */
>>>>> -     ret = acpi_ec_setup(ec, NULL, true);
>>>>> +     ret = acpi_ec_setup(ec, NULL, false);
>>>>>        if (ret) {
>>>>>                acpi_ec_free(ec);
>>>>>                return;
>>>>>
>>>>> Unfortunately this does not help. dmesg shows some EC _REG errors, which
>>>>> are now (with the above diff applied) shown just before the
>>>>> "Boot DSDT EC initialization complete" message, which shows that _REG now
>>>>> runs from acpi_ec_add() rather then before:
>>>>>
>>>>> [    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.FN00._OFF], AE_NOT_FOUND (20230628/psargs-330)
>>>>> [    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>>>> [    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>>>> [    1.007639] ACPI: EC: interrupt unblocked
>>>>> [    1.007640] ACPI: EC: event unblocked
>>>>> [    1.007675] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>>>> [    1.007676] ACPI: EC: GPE=0x6e
>>>>> [    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initialization complete
>>>>> [    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transactions and events
>>>>>
>>>>> Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, where as the actual
>>>>> EC (and the only acpi_device on which _REG would get called for the EC Opregion before) is:
>>>>> \_SB_.PC00.LPCB.LGEC.
>>>>>
>>>>> Looking at the DSDT it seems that the H_EC is not used and is leftover from a copy/paste
>>>>> from some reference design DSDT. Its _REG however does write to the EC before hitting the error
>>>>> and I think that that write may be causing the issue...
>>>>>
>>>>> The H_EC device does have an _STA method and looking closer the troublesome EREG method is
>>>>> also called from _INI. So I guess that _STA is returning 0 causing _INI to not run and
>>>>> that is the reason why we are not seeing the same EREG errors with kernel 6.9.6 where _REG is
>>>>> only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for the entire ACPI device
>>>>> hierarchy as is done with >= 6.9.7 .
>>>>>
>>>>> Maybe we should only call _REG for the EC opregion on present devices (and devices without
>>>>> a _STA)?
>>>>>
>>>>> Also note that both LGEC and H_EC use the same cmd + data ports.
>>>>>
>>>>> I'll go and ask the reporter to retrieve the status of both LGEC and H_EC and then see
>>>>> from there.
>>>> The reporter has confirmed that of the 2 EC devices ( H_EC / LGEC ) only LGEC returns
>>>> a _STA of non 0:
>>>>
>>>>> Here it is, with kernel 6.9.6:
>>>>>
>>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/path
>>>>> \_SB_.PC00.LPCB.H_EC
>>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/status
>>>>> 0
>>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/path
>>>>> \_SB_.PC00.LPCB.LGEC
>>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/status
>>>>> 15
>>>> And taking a second look at the other bug:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2298938
>>>>
>>>> That one also has 2 EC ACPI devices and the errors come from calling _REG on the one
>>>> which is not picked as the boot_ec :
>>>>
>>>> jul 19 17:33:41 kernel: ACPI: EC: EC started
>>>> jul 19 17:33:41 kernel: ACPI: EC: interrupt blocked
>>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC.ECMD due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FNCL due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FN00._OFF due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC._REG due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>>> jul 19 17:33:41 kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>>> jul 19 17:33:41 kernel: ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
>>>>
>>>> Note the H_EC vs EC0_ in the errors vs the "Boot DSDT EC used to
>>>> handle transactions" message.
>>>>
>>>> So the issue in both cases seems to be calling _REG on an unused EC acpi_device.
>>>> Not sure how to best fix this though ...
>>> I have created an experimental acpi-ec-fixes branch:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=acpi-ec-fixes
>>>
>>> for this which illustrates my idea (untested so far).
>> This has just been updated to actually register the EC _REG for all
>> devices (which would have been skipped for the majority of them due to
>> the previous location of the relevant function call).
> 
> Hi,
> 
> i will ask the reporter https://bugzilla.kernel.org/show_bug.cgi?id=219075 to try out your patches.
> His LG Gram seems to be affected by this problem (it has two overlapping EC devices ...).

Ah another reporter with an LG Gram, this Fedora bug:

https://bugzilla.redhat.com/show_bug.cgi?id=2302253

is also about a LG Gram. And shows the same:

[    0.239044] ACPI: EC: EC started
[    0.239045] ACPI: EC: interrupt blocked
[    0.239787] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.FN00._OFF], AE_NOT_FOUND (20240322/psargs-330)
[    0.239794] fbcon: Taking over console
[    0.239800] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG due to previous error (AE_NOT_FOUND) (20240322/psparse-
[    0.239805] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG due to previous error (AE_NOT_FOUND) (20240322/psparse-
[    0.239820] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.239822] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC used to handle transactions

errors in their dmesg with regressed kernels.

So this seems to be the same issue.

Regards,

Hans




> 
> Thanks,
> Armin Wolf
> 
>>> The underlying observation is that _REG only needs to be evaluated for
>>> EC operation regions located in the scopes of ACPI device objects
>>> representing valid devices, so it is better to do it for each of these
>>> objects individually in acpi_bus_attach().
>>>
>>> For the EC itself, it is better to do what was done before the
>>> $subject commit, so evaluate _REG for the EC operation regions in the
>>> EC scope (including the "orphan" _REG).
>>>
>>> Accordingly, commit 0e6b6dedf168 ("Revert "ACPI: EC: Evaluate orphan
>>> _REG under EC device") is reverted, acpi_execute_reg_methods() is
>>> modified to take an additional depth argument and it is called for
>>> each device object representing a valid device with that argument
>>> equal to 1.
> 


