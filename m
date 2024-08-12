Return-Path: <linux-acpi+bounces-7529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B494EBCB
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7E81C20C9F
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A91741FB;
	Mon, 12 Aug 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P88jVMxm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F0172BD8
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462090; cv=none; b=VPCg+5C710pRU9++LZmOxm/D2V5IZ776P4aEcPkLduF9xUJ1zayjcQGIp3OlRISF4+IbpBAwzR+7ihXmc4q7IF86+aRPfEc4fJ0gYJicEKTGSVfW9arvHWU8JeL1Dx1my+CwDsJ2ujkWwvsF9muG4Vug2mchWZu/sfj2S1LOiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462090; c=relaxed/simple;
	bh=+FVCaJmFVHIOWrwHTarL6v2GmW0bIc3hMuIrRdu8Biw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRjozkwV6QbC3JIAx1jrZJvDQO8MB6wvT3xjpuJC0BloON7pv8d3S4U9EY2QsDKivQvehvSc6L/AjQE68z74v7KFHUs+uqxPV5QeVplOdd0axoyW/67fRI4RSDTm+VtU3j16Il4OJXqZYELEje9j9hl3IS6jRo1ImDPpdNHpMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P88jVMxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723462087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcycq5i3AAs9TGRT9OSPzLW5spjPbr3vR1I5Qbi+a/k=;
	b=P88jVMxmd7IOz78ZgyDyI0cmpcYvVU2v0qKb4dqAkIPIbZ6z7/nx2fV2fZtAY/xDh+OJZn
	od+EPk7LvlHUFAo4Izse1Vs7DLcDCvSdoXtLOOzf/V0I/ZX3PJPQFIkNkCvH619ag+hV81
	fKzTOBfpcsYxhBdryV2kU8aZFz3ncU8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-Ux6mg_GFNNSDIgRunEb1HQ-1; Mon, 12 Aug 2024 07:28:06 -0400
X-MC-Unique: Ux6mg_GFNNSDIgRunEb1HQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52f00bde29dso5936614e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 04:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723462084; x=1724066884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcycq5i3AAs9TGRT9OSPzLW5spjPbr3vR1I5Qbi+a/k=;
        b=aIpiOrd29wGXVVL5nuhjXY7d2nT7JfYJQ0ncSO7eA3UVhSBYokzMTa0sR5GL/trijd
         WH1Mcw21l6TkV2dcDjuYZ/QVGYAM/gq441rF2hL+V2J96gtF0eRR17rpupoKHACUeIHO
         qz3K435s0iOFhFTUYFenuiP0MYf15jMoodKPK0/b5SLCf/fQn5DHMC8YEPVL76i+lPtE
         YC+DlAjC4jNuygJs8F21sVgMbB+R2bmMzcmjXFHdZ5gcHwtmWSMoxxBAqGtHOwcTPIVc
         BT1P7RqBEB8xCLHzM0wfFrswuySfFAArtU2P2UnbozgXBUDKiiuUcuLn8+iHCHwWuYvi
         uFNw==
X-Gm-Message-State: AOJu0Yxb1SVDpWDqbqRIqmHkLoDEcfW2fJ+2U16mrEfFu8l4yQPJ3b3z
	KAa6X+BftSc0RxoQtmfJTf20oWHQlIYOdcpPsDICqscbJvjmT2yTaKXuQPCBaYpVMXNtyrH8HtJ
	YNYcqGVEzy0NguvtFm/UJgmTjGz6QUajPYk7xqSocWXTn9kjFcUuvHBjTnKZ9TNjcJzE=
X-Received: by 2002:a05:6512:3b1e:b0:52e:9921:6dff with SMTP id 2adb3069b0e04-530ee994024mr8755838e87.26.1723462084188;
        Mon, 12 Aug 2024 04:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH08XZBd/kiutDZV2BDWnp7uB714rFuOuqnC/bYHvXnGztje7IEZKpPDad5f4b4bbTt8AQ81Q==
X-Received: by 2002:a05:6512:3b1e:b0:52e:9921:6dff with SMTP id 2adb3069b0e04-530ee994024mr8755817e87.26.1723462083537;
        Mon, 12 Aug 2024 04:28:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb21378dsm225166866b.173.2024.08.12.04.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 04:28:03 -0700 (PDT)
Message-ID: <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com>
Date: Mon, 12 Aug 2024 13:28:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
 <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
 <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/8/24 7:22 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> On Mon, Aug 5, 2024 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 8/5/24 1:28 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 8/1/24 4:28 PM, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 7/29/24 1:15 PM, Hans de Goede wrote:
>>>>> Hi Rafael,
>>>>>
>>>>> There are 2 bug reports:
>>>>>
>>>>> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
>>>>> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
>>>>
>>>> I have filed:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2302253
>>>>
>>>> to track this now and an acpidump of the troublesome LG laptop
>>>> is attached there. I have also requested dmesg output of
>>>> a non working kernel to be attached there.
>>>>
>>>> As a reminder this is the bug where it has been confirmed that
>>>> reverting "EC: Install address space handler at the namespace root"
>>>> helps, with the caveat that there is a Thunderbolt related IRQ
>>>> storm on the ACPI event IRQ after the revert ...
>>>
>>> Ok, so the bugzilla now has 2 different dmesg outputs:
>>>
>>> 1. 6.9.6, this kernel works without problems
>>>
>>> 2. 6.9.12 with the following patch you suggested on top:
>>>
>>> --- a/drivers/acpi/ec.c
>>> +++ b/drivers/acpi/ec.c
>>> @@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
>>>        * At this point, the GPE is not fully initialized, so do not to
>>>        * handle the events.
>>>        */
>>> -     ret = acpi_ec_setup(ec, NULL, true);
>>> +     ret = acpi_ec_setup(ec, NULL, false);
>>>       if (ret) {
>>>               acpi_ec_free(ec);
>>>               return;
>>>
>>> Unfortunately this does not help. dmesg shows some EC _REG errors, which
>>> are now (with the above diff applied) shown just before the
>>> "Boot DSDT EC initialization complete" message, which shows that _REG now
>>> runs from acpi_ec_add() rather then before:
>>>
>>> [    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.FN00._OFF], AE_NOT_FOUND (20230628/psargs-330)
>>> [    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>> [    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>> [    1.007639] ACPI: EC: interrupt unblocked
>>> [    1.007640] ACPI: EC: event unblocked
>>> [    1.007675] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>> [    1.007676] ACPI: EC: GPE=0x6e
>>> [    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initialization complete
>>> [    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transactions and events
>>>
>>> Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, where as the actual
>>> EC (and the only acpi_device on which _REG would get called for the EC Opregion before) is:
>>> \_SB_.PC00.LPCB.LGEC.
>>>
>>> Looking at the DSDT it seems that the H_EC is not used and is leftover from a copy/paste
>>> from some reference design DSDT. Its _REG however does write to the EC before hitting the error
>>> and I think that that write may be causing the issue...
>>>
>>> The H_EC device does have an _STA method and looking closer the troublesome EREG method is
>>> also called from _INI. So I guess that _STA is returning 0 causing _INI to not run and
>>> that is the reason why we are not seeing the same EREG errors with kernel 6.9.6 where _REG is
>>> only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for the entire ACPI device
>>> hierarchy as is done with >= 6.9.7 .
>>>
>>> Maybe we should only call _REG for the EC opregion on present devices (and devices without
>>> a _STA)?
>>>
>>> Also note that both LGEC and H_EC use the same cmd + data ports.
>>>
>>> I'll go and ask the reporter to retrieve the status of both LGEC and H_EC and then see
>>> from there.
>>
>> The reporter has confirmed that of the 2 EC devices ( H_EC / LGEC ) only LGEC returns
>> a _STA of non 0:
>>
>>> Here it is, with kernel 6.9.6:
>>>
>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/path
>>> \_SB_.PC00.LPCB.H_EC
>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/status
>>> 0
>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/path
>>> \_SB_.PC00.LPCB.LGEC
>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/status
>>> 15
>>
>> And taking a second look at the other bug:
>> https://bugzilla.redhat.com/show_bug.cgi?id=2298938
>>
>> That one also has 2 EC ACPI devices and the errors come from calling _REG on the one
>> which is not picked as the boot_ec :
>>
>> jul 19 17:33:41 kernel: ACPI: EC: EC started
>> jul 19 17:33:41 kernel: ACPI: EC: interrupt blocked
>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC.ECMD due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FNCL due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FN00._OFF due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC._REG due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>> jul 19 17:33:41 kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>> jul 19 17:33:41 kernel: ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
>>
>> Note the H_EC vs EC0_ in the errors vs the "Boot DSDT EC used to
>> handle transactions" message.
>>
>> So the issue in both cases seems to be calling _REG on an unused EC acpi_device.
>> Not sure how to best fix this though ...
> 
> I have created an experimental acpi-ec-fixes branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=acpi-ec-fixes
> 
> for this which illustrates my idea (untested so far).

Thank you. I believe that the approach taken here is good and I also
like the code (of the current version) so you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to all 3 patches.

I have started a test Fedora 40 6.10.4 kernel build with the patches from
the acpi-ec-fixes branch added:

https://koji.fedoraproject.org/koji/taskinfo?taskID=121834209

and I have asked the reporters of both bugs:

    2298938 - Multiple ACPI errors resulting in incorrect thermal readings and misleading CPU 
    2302253 - ACPI: EC: LG gram laptop brightness keys stop working with kernel >= 6.9.7

to test this. I expect a good turn around time from the reporter
of bug 2302253. So far the reporter of 2298938 is not really
responsive (holidays?).

Regards,

Hans


