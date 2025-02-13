Return-Path: <linux-acpi+bounces-11151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10259A3467C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 16:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8523F16B6EC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0FF13D8A4;
	Thu, 13 Feb 2025 15:20:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC88826B0BC;
	Thu, 13 Feb 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460002; cv=none; b=NzT6E21eGc9e/b0YgVBX1EqdemFN33wW5l8LAcUHTgRikZAF3rzGPNL/Cdms36KGVnebx74n3ZeMM0i3FYaN+jGe6LqRfgE51M0rEONMBNS8pDrfiLVIyT8+qsXpU1dyXEBsKLR7SF2p/E5fcuipGAiddCVETsFo9aeoVyBM0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460002; c=relaxed/simple;
	bh=N2ef7JANwra75iIw3ldGvYambNz6khJkPVb6/xb2kYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD45HfnwPbwmfARFF+M4VkbjZxp/rgUgRrD5mTMdaqw71WZT2T4VPhFxlwMj623l+qwPr1c2vekkgGZZIvnDOE6tpru9ZMAfOXze1sRuKayQFUWaDclgHj5MD6ulxwOtvOrJOv+Ocj+mJiVGSaOEEjgDOLEvOhh+dNctWjGySFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC37E113E;
	Thu, 13 Feb 2025 07:20:20 -0800 (PST)
Received: from [172.20.10.14] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E5C33F58B;
	Thu, 13 Feb 2025 07:19:59 -0800 (PST)
Message-ID: <e142afd2-38ec-4640-b9be-cb414bccc807@arm.com>
Date: Thu, 13 Feb 2025 09:19:58 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jens Wiklander <jens.wiklander@linaro.org>, Rob Herring <robh@kernel.org>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
 <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
 <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/12/25 11:31 PM, Sumit Garg wrote:
> + Rob
> 
> On Thu, 13 Feb 2025 at 03:25, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>
>>
>>
>> On 2/12/25 1:39 AM, Sumit Garg wrote:
>>> On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>>>
>>>> Hi Sumit,
>>>>
>>>> On 2/11/25 12:45 AM, Sumit Garg wrote:
>>>>> + Jens
>>>>>
>>>>> Hi Stuart,
>>>>>
>>>>> On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>>>>>
>>>>>> These patches add support for the CRB FF-A start method defined
>>>>>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
>>>>>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
>>>>>> (https://developer.arm.com/documentation/den0138/latest/)
>>>>>
>>>>> Nice to have a specification standardizing interface to TPM
>>>>> managed/implemented by the firmware. Care to add corresponding kernel
>>>>> documentation under Documentation/security/tpm/.
>>>>
>>>> Yes, I can add some documentation there.
>>>>
>>>>> BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
>>>>> possibilities for an abstraction layer on top of communication channel
>>>>> based on either FF-A or TEE or platform bus?
>>>>
>>>> I think the CRB and OP-TEE based messaging approaches for interacting
>>>> with a TZ-based TPM are fundamentally different and I don't see how
>>>> to harmonize them through some abstraction.
>>>>
>>>> The OP-TEE TPM protocol copies the TPM command into a temp shared memory
>>>> buffer and sends a message to the TPM referencing that buffer.
>>>>
>>>> The CRB uses a permanently shared memory carve-out that in addition
>>>> to the command/response data has other fields for locality control,
>>>> command control, status, TPM idle, etc. The only 'message' needed is
>>>> something to signal 'start'.  Any OS that is FF-A aware and has a
>>>> CRB driver can simply add a new start method, which is what this
>>>> patch series does.
>>>
>>> Okay, I see how the CRB driver is closely tied to the ACPI based
>>> systems.
>>
>> The CRB driver is currently probed based on ACPI, but it fundamentally
>> doesn't have to be.  If there was a DT binding for CRB-based
>> TPMs the different start methods would be defined there and the
>> CRB driver could support that.
>>
> 
> Can't we rather enable the CRB driver itself probed based on FF-A bus
> and rather dynamically discover the shared memory buffer via FF-A
> instead? AFAIU, FF-A provides you with a discovery framework for
> firmware bits.

Yes, you could do this. But, then the TPM CRB drivers in all the
ACPI-based OSes (Linux, Windows) and hypervisors need to be
taught this new method of discovery. Adding new start methods is
reasonably straightforward, but changing the basic discovery
mechanism is a much bigger change.

> But if we still want to overload ACPI or DT with the
> discoverable firmware bits then it seems like an overkill here.

I think it would make sense to do ACPI based discovery or FF-A
based discovery, but doing both I think would be overkill.  For
ease of OS integration ACPI is the way to go.  And, potentially
device tree in the future.

Thanks,
Stuart

