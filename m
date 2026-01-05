Return-Path: <linux-acpi+bounces-19946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C3FCF2ACC
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 10:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A083014AFC
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41732B999;
	Mon,  5 Jan 2026 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hn9Kn018"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128E313E24;
	Mon,  5 Jan 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604360; cv=none; b=RBmVEl+kVQmBrD/kXPjc/aE5O0E9JXjV3VyQMchwJmP0EVeNn4TZWIn7/qPPXrp3Iq5XL1SJRpxaN3XorkE/YF0vTeabzlj4PPaXT8NnwDWpzCfU0fzeMMtriBwiDZGNdJYInGcEUmD9xKle0iyJ5tNMUsk0TZi8CBnFZisFSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604360; c=relaxed/simple;
	bh=CkBNa+9hqD7O5Xe9dswQNyu9XStZljoBcgTviQdL7IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7L3i9IcmbZvKY5aR8BOVTMfZIUvuTCdMkgn5Kh6wCS7mWUtFDImLvvrxoqIjGVe9Qm3lBtH/NnpfAVErBuCoAPbuL6t7ugHAhfgyuJxtHgQ4zKCD7nwFnvs3y3u0ZGY2XwA8swTG+zw6fn3r4Rix7junvbOKLLzlGttIUYjWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hn9Kn018; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767604346; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7D+DpBQQtzNoK+sZqLLvdqEmAcXBK/tZuJsT5yOLvcc=;
	b=Hn9Kn018xrJbky8u1WuAk0zVL/sdNlw2zOTrukCGvNEzFGNiIVMt4NWc4i3d+xHdyl8UJo8M59r/EPDQTNaq60ZaAOLFl0YNoqJztJf9bjHZ9+gIjR+Gh1QBNuZY7LeHB9+1ZKWq5hbggFjQazEpxBLocauF5bkqBax6oYEGu48=
Received: from 30.221.133.192(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WwM6sCt_1767604345 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 05 Jan 2026 17:12:26 +0800
Message-ID: <0038141b-713f-4024-9f8b-e5f748f5a6a9@linux.alibaba.com>
Date: Mon, 5 Jan 2026 17:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] ARM Error Source Table V2 Support
To: Borislav Petkov <bp@alien8.de>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
 guohanjun@huawei.com, sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rafael@kernel.org, lenb@kernel.org,
 tony.luck@intel.com, yazen.ghannam@amd.com, misono.tomohiro@fujitsu.com,
 fengwei_yin@linux.alibaba.com
References: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
 <20251230202211.GAaVQ0cx8o-CqzGU2O@fat_crate.local>
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <20251230202211.GAaVQ0cx8o-CqzGU2O@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the review and the comments.

在 2025/12/31 04:22, Borislav Petkov 写道:
> Some high-level notes first:
> 
> On Tue, Dec 30, 2025 at 05:09:28PM +0800, Ruidong Tian wrote:
>> This series introduces support for the ARM Error Source Table (AEST), aligning
>> with version 2.0 of ACPI for Armv8 RAS Extensions [0].
> 
> I'd like to hear from ARM folks what the strategy for this thing is...
That's a good point. I've CC'ed the ARM maintainers for their input.
> 
>> AEST provides a critical mechanism for hardware to directly notify the
>> operating system kernel about RAS errors via interrupts, a concept known as
>> Kernel-first error handling. Compared to firmware-first error handling
>> (e.g., GHES), AEST offers a more lightweight approach. This efficiency allows
>> the OS to potentially report every Corrected Error (CE), enabling upper-layer
>> applications to leverage CE information for error prediction[1][2].
>>
>> This series is based on Tyler Baicar's preliminary patches [3], which have not
>> yet been sent to the mailing list as v2.
> 
> I guess I'll wait for those first.
I tried to follow up with Tyler about his patches back in 2022[0] but 
got no reply. Since he no longer seems active on the Linux mailing list, 
I decided to pick this up and post this series myself to avoid this work 
being stalled.

[0]: 
https://lore.kernel.org/all/b365db02-b28c-1b22-2e87-c011cef848e2@linux.alibaba.com/
> 
>> AEST Driver Architecture
>> ========================
>>
>> The AEST driver is structured into three primary components:
>>    - AEST device: Responsible for handling interrupts, managing the lifecycle
>>                   of AEST nodes, and processing error records.
>>    - AEST node: Corresponds directly to a RAS node in the hardware
> 
> What is a "RAS node"?
A RAS node is the hardware interface for error reporting and control, 
consisting of one or more register sets (a collection of RAS records). 
It is responsible for error logging and interrupt signaling[0].

A single hardware component can feature multiple RAS nodes. For example, 
a memory controller is treated as a "RAS device", where each memory 
channel has its own RAS node. Interrupts generated by these nodes are 
typically aggregated into a single interrupt line managed at the RAS 
device level.

Comparison with x86 MCA:

RAS record ≈ MCA bank.
RAS node ≈ A set of MCA banks + CMCI on a core.

The key difference lies in uncore handling: x86 typically maps uncore 
errors (like those from a memory controller) into core-based MCA banks. 
In contrast, ARM requires uncore components to provide their own 
standalone RAS nodes. When a component requires multiple such nodes, 
they are grouped and managed as a "RAS device" in AEST driver.

[0]: https://developer.arm.com/documentation/ihi0100/latest
> 
>>    - AEST record: Represents a set of RAS registers associated with a specific
>>                   error source.
> 
> ...
> 
>> Address Translation
>> ===================
>>
>> As described in section 2.2 [0], error addresses reported by AEST records
>> may be "node-specific Logical Addresses" rather than the "System Physical
>> Addresses" (SPA) used by the kernel. Therefore, the driver needs to translate
>> these Logical Addresses (LA) to SPA. This translation mechanism is conceptually
>> similar to AMD's Address Translation Logic (ATL) [4], leading patch 0014 to
>> introduce a common translation function for both AMD and ARM architectures.
> 
> Say what now?
> 
> The ATL is very AMD-specific. What does "conceptually similar" mean exactly?
By "conceptually similar," I mean that both ARM and AMD share the same 
functional requirement: translating between a System Physical Address 
(SPA) and a device-specific address (like a DRAM address) for RAS purposes.

The goal here is not to share the hardware-specific translation logic, 
but to provide a unified interface (an abstraction layer). The actual 
implementation of the translation remains entirely architecture-specific.
> What happens if we have to change the ATL and break your use case in the
> process?
Since the implementations are decoupled, changes to the internals of 
AMD's ATL will not break the ARM use case. ARM would have its own 
backend implementation. They only share a common top-level API or 
wrapper to allow generic RAS/EDAC code to invoke the translation.
> 
> What exact functionality from the ATL do you really need here?
> 
> Thx.
> 


