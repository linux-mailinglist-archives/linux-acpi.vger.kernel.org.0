Return-Path: <linux-acpi+bounces-7543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA85950041
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF3B23D2F
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF8143889;
	Tue, 13 Aug 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doGiiuno"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C614A086
	for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538771; cv=none; b=TiHL922mmaQ5ZoFD9q58rreWqTwoIV1kublk2gfNnKwFDt8RPRJYvTlJfhDbRhbd20BCC8aZf3IK5OxdPq8NysN81a1Gb85avER5EC9SUj/yCZpnn/xod2oNO1IVZOgNz58VZnD1V8/1NZhCIh059cmzbvLg/LoMber/lCEyJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538771; c=relaxed/simple;
	bh=JPuq1+yB5yPvOm8O5F7tdm2UjcyMq3y9042g7oRTYpg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IuAjjJj0+6OaQThDB6fhx9oFbl67Ugg1Zn7U9VoUuOmKc1we14o/+LQI9VZO7gH9wIb0frLmgi7TsdZ8cMS3qhJLjkvAi21NzCMzLiRnn2Xce7IjksHl8UocbBz78Q9bgCgz6AkDs/88snR524ptbTxqU4o59PuTdJATYcXRpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doGiiuno; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723538768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXSbhG9F2gedklgPwrpHbOiav1xlkW0kCqjp6KUkdQg=;
	b=doGiiuno/W9ZRsPoXwBBeHILf/S/VFtLmCkKBllfkeoKBBT9iiU8ZApZQCBEsNHCYie0wf
	ZLW5Mx2SWrJVNZu/HH9Kn53JRNSL9nVWAJ+cfO9AXV81xOcgxm4E6XG32vnhiuitJSUmd+
	Ip1+Am/Nqx+NM9/U94vFDrnEEM3OTwc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-nc0BO2AkNhmD_8Flw53mOQ-1; Tue, 13 Aug 2024 04:46:06 -0400
X-MC-Unique: nc0BO2AkNhmD_8Flw53mOQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77f0eca75bso449329966b.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 01:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723538755; x=1724143555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXSbhG9F2gedklgPwrpHbOiav1xlkW0kCqjp6KUkdQg=;
        b=qnfxx8Pqq7yLh/UYL6m/bGQtg52uF6AgsJYckPYBrXIvpBIQkBt3i7y3Zh4olptHRZ
         XCTD9hC+BJBUsFnkXF47nL9ggKoMaFnkyL9VBjovXBRaeJy3x1gZFhzk7CM1p+BnsbaK
         DkOD+qOFii+eSVh4xLRaEz6kAvahVnSKt0XSeCuYzCcDODeCYOskY3KLqpe4RxsyFdub
         2JjnI7rClHvMLjn1Df4s1cQdg+mvFiwxbtKLVMGNqNcUU+1g58mTYvYfesFNNCJBFLKY
         CF+xCncyZWLQdyvCNrE4frAMXsvSNr5yJTjMebUevtlWWOmfpdBdj5XI1QkjWRCXYuEz
         uLQw==
X-Gm-Message-State: AOJu0YzocqHCLCBRQIWS7PeFp3DrgpfhrFgao0iB2QsEPVn38a2yet73
	RdAVSJIpA/DBHtoR4eGlKaiTCBcG4tikX6yIxSkZI2lksu2q6r+Nqz66HDNf0JG369a9HjL1dmM
	t5GZ2eRAHjU3H1qzdWzKcGKsGUCoTx2qF62cIOtOPo6cwupeE0zsN+L8ui/4u/N/4Axk=
X-Received: by 2002:a17:907:1c26:b0:a6f:6126:18aa with SMTP id a640c23a62f3a-a80ed2d5a41mr193487566b.67.1723538755181;
        Tue, 13 Aug 2024 01:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkIXEFazKZ2e7IrtoO9eTsIR4non/nX+CtH37dZvGgn/MqKpsMzOuV8IadVro6wAiFPJPIHg==
X-Received: by 2002:a17:907:1c26:b0:a6f:6126:18aa with SMTP id a640c23a62f3a-a80ed2d5a41mr193485966b.67.1723538754603;
        Tue, 13 Aug 2024 01:45:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e31bsm49992266b.152.2024.08.13.01.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 01:45:53 -0700 (PDT)
Message-ID: <d7ea226a-24b1-42e9-80d7-039729d93d34@redhat.com>
Date: Tue, 13 Aug 2024 10:45:52 +0200
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
 <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
 <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
 <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/12/24 1:28 PM, Hans de Goede wrote:
> Hi,
> 
> On 8/8/24 7:22 PM, Rafael J. Wysocki wrote:
>> Hi,
>>
>> On Mon, Aug 5, 2024 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 8/5/24 1:28 PM, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 8/1/24 4:28 PM, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 7/29/24 1:15 PM, Hans de Goede wrote:
>>>>>> Hi Rafael,
>>>>>>
>>>>>> There are 2 bug reports:
>>>>>>
>>>>>> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
>>>>>> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
>>>>>
>>>>> I have filed:
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2302253
>>>>>
>>>>> to track this now and an acpidump of the troublesome LG laptop
>>>>> is attached there. I have also requested dmesg output of
>>>>> a non working kernel to be attached there.
>>>>>
>>>>> As a reminder this is the bug where it has been confirmed that
>>>>> reverting "EC: Install address space handler at the namespace root"
>>>>> helps, with the caveat that there is a Thunderbolt related IRQ
>>>>> storm on the ACPI event IRQ after the revert ...
>>>>
>>>> Ok, so the bugzilla now has 2 different dmesg outputs:
>>>>
>>>> 1. 6.9.6, this kernel works without problems
>>>>
>>>> 2. 6.9.12 with the following patch you suggested on top:
>>>>
>>>> --- a/drivers/acpi/ec.c
>>>> +++ b/drivers/acpi/ec.c
>>>> @@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
>>>>        * At this point, the GPE is not fully initialized, so do not to
>>>>        * handle the events.
>>>>        */
>>>> -     ret = acpi_ec_setup(ec, NULL, true);
>>>> +     ret = acpi_ec_setup(ec, NULL, false);
>>>>       if (ret) {
>>>>               acpi_ec_free(ec);
>>>>               return;
>>>>
>>>> Unfortunately this does not help. dmesg shows some EC _REG errors, which
>>>> are now (with the above diff applied) shown just before the
>>>> "Boot DSDT EC initialization complete" message, which shows that _REG now
>>>> runs from acpi_ec_add() rather then before:
>>>>
>>>> [    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.FN00._OFF], AE_NOT_FOUND (20230628/psargs-330)
>>>> [    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>>> [    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>>> [    1.007639] ACPI: EC: interrupt unblocked
>>>> [    1.007640] ACPI: EC: event unblocked
>>>> [    1.007675] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>>> [    1.007676] ACPI: EC: GPE=0x6e
>>>> [    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initialization complete
>>>> [    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transactions and events
>>>>
>>>> Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, where as the actual
>>>> EC (and the only acpi_device on which _REG would get called for the EC Opregion before) is:
>>>> \_SB_.PC00.LPCB.LGEC.
>>>>
>>>> Looking at the DSDT it seems that the H_EC is not used and is leftover from a copy/paste
>>>> from some reference design DSDT. Its _REG however does write to the EC before hitting the error
>>>> and I think that that write may be causing the issue...
>>>>
>>>> The H_EC device does have an _STA method and looking closer the troublesome EREG method is
>>>> also called from _INI. So I guess that _STA is returning 0 causing _INI to not run and
>>>> that is the reason why we are not seeing the same EREG errors with kernel 6.9.6 where _REG is
>>>> only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for the entire ACPI device
>>>> hierarchy as is done with >= 6.9.7 .
>>>>
>>>> Maybe we should only call _REG for the EC opregion on present devices (and devices without
>>>> a _STA)?
>>>>
>>>> Also note that both LGEC and H_EC use the same cmd + data ports.
>>>>
>>>> I'll go and ask the reporter to retrieve the status of both LGEC and H_EC and then see
>>>> from there.
>>>
>>> The reporter has confirmed that of the 2 EC devices ( H_EC / LGEC ) only LGEC returns
>>> a _STA of non 0:
>>>
>>>> Here it is, with kernel 6.9.6:
>>>>
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/path
>>>> \_SB_.PC00.LPCB.H_EC
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/status
>>>> 0
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/path
>>>> \_SB_.PC00.LPCB.LGEC
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/status
>>>> 15
>>>
>>> And taking a second look at the other bug:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2298938
>>>
>>> That one also has 2 EC ACPI devices and the errors come from calling _REG on the one
>>> which is not picked as the boot_ec :
>>>
>>> jul 19 17:33:41 kernel: ACPI: EC: EC started
>>> jul 19 17:33:41 kernel: ACPI: EC: interrupt blocked
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC.ECMD due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FNCL due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FN00._OFF due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC._REG due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>> jul 19 17:33:41 kernel: ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
>>>
>>> Note the H_EC vs EC0_ in the errors vs the "Boot DSDT EC used to
>>> handle transactions" message.
>>>
>>> So the issue in both cases seems to be calling _REG on an unused EC acpi_device.
>>> Not sure how to best fix this though ...
>>
>> I have created an experimental acpi-ec-fixes branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=acpi-ec-fixes
>>
>> for this which illustrates my idea (untested so far).
> 
> Thank you. I believe that the approach taken here is good and I also
> like the code (of the current version) so you may add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> to all 3 patches.
> 
> I have started a test Fedora 40 6.10.4 kernel build with the patches from
> the acpi-ec-fixes branch added:
> 
> https://koji.fedoraproject.org/koji/taskinfo?taskID=121834209
> 
> and I have asked the reporters of both bugs:
> 
>     2298938 - Multiple ACPI errors resulting in incorrect thermal readings and misleading CPU 
>     2302253 - ACPI: EC: LG gram laptop brightness keys stop working with kernel >= 6.9.7
> 
> to test this. I expect a good turn around time from the reporter
> of bug 2302253. So far the reporter of 2298938 is not really
> responsive (holidays?).

The reporter of 2302253 has reported that the patches from:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=acpi-ec-fixes

resolve the issue; and as mentioned before the reporter of 2298938
is not responsive atm. So I believe that with it confirmed that this
at least fixes the issues on the LG Gram laptops (1) these patches are
ready to be merged now.

Regards,

Hans



1) And based on dmesg with a regressed kernel likely / hopefully also
the issue from RH bugzilla 2298938.


