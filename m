Return-Path: <linux-acpi+bounces-20113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB13D09B25
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 13:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 326E3302A3CC
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B735BDB2;
	Fri,  9 Jan 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mJMwrbrs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AD23F417;
	Fri,  9 Jan 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961604; cv=none; b=N5WAruwkMOrnkwtiBvF1QJqMraxKu+/hciRm4d7rZWnly/EgKuRbv+1xpZ+ZsASwQgY5lPlN8Bh5QAIoQfnNIMk/ajb5T/VHqR9qHQ8TxjG99quNrQLWjwSJNiCr6lx56NLUc3CEtMIlfZURBMWBQtyc5W3eWNH8yGlu2O/Pcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961604; c=relaxed/simple;
	bh=v+dVh2PQaibIDIuVFiYECwcPEr+seM9R5dX+ZEV0pEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjNA0TgXlR9/VMDST0tOM9FqXh5MgOoMF+i65av07Ns7L/1cC2RAYYg/XduuMX+8aEU26549Pjgu7OMF2JiBVC5QW+1g8SiqnRDeZ50d4DFSufXQAnty2eo75wqzd9e0wNR2gs5wNF59gK7qxEr9EMZU/jCT5QG72MY8DdnifDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mJMwrbrs; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767961590; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wAkElEqvuK3lcmA0Lcu1Dy1ULv3lH35onFLQZmZ8LH0=;
	b=mJMwrbrsZUmg5Op/Ejep24zR+tggOdzB7yf+Tg/Y5Ahig3SJeJwQPDfavF0x/0mcBBLf6ZZFf+fLcFobFbihn3rJRv0pfbYqrwq6O+Oiopg83LHiz4p0SiAmvWzdb/f0pZv9gauHzUckhuh4hsmDZ0h+nkJrGkUXHeV3MHr4VFc=
Received: from 30.221.148.170(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WwgnTgj_1767961589 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 20:26:29 +0800
Message-ID: <1243a296-f018-42f8-9c07-297862fb0f4a@linux.alibaba.com>
Date: Fri, 9 Jan 2026 20:26:27 +0800
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
 <0038141b-713f-4024-9f8b-e5f748f5a6a9@linux.alibaba.com>
 <20260109103416.GAaWDZqDYoyt3KRAE9@fat_crate.local>
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <20260109103416.GAaWDZqDYoyt3KRAE9@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/9 18:34, Borislav Petkov 写道:
> On Mon, Jan 05, 2026 at 05:12:25PM +0800, Ruidong Tian wrote:
>>> What is a "RAS node"?
>> A RAS node is the hardware interface for error reporting and control,
>> consisting of one or more register sets (a collection of RAS records). It is
>> responsible for error logging and interrupt signaling[0].
> 
> OMG, one more meaning for the word "node". Because we're not ambiguous enough.
> 
> /facepalm
> 
>> A single hardware component can feature multiple RAS nodes. For example, a
>> memory controller is treated as a "RAS device", where each memory channel
>> has its own RAS node. Interrupts generated by these nodes are typically
>> aggregated into a single interrupt line managed at the RAS device level.
> 
> Nomenclaturial tragedy, I'd say.
> 
>> Comparison with x86 MCA:
>>
>> RAS record ≈ MCA bank.
>> RAS node ≈ A set of MCA banks + CMCI on a core.
>>
>> The key difference lies in uncore handling: x86 typically maps uncore errors
>> (like those from a memory controller) into core-based MCA banks. In
>> contrast, ARM requires uncore components to provide their own standalone RAS
>> nodes. When a component requires multiple such nodes, they are grouped and
>> managed as a "RAS device" in AEST driver.
>>
>> [0]: https://developer.arm.com/documentation/ihi0100/latest
> 
> Yah, thanks for explaining.
> 
>>> The ATL is very AMD-specific. What does "conceptually similar" mean exactly?
>> By "conceptually similar," I mean that both ARM and AMD share the same
>> functional requirement: translating between a System Physical Address (SPA)
>> and a device-specific address (like a DRAM address) for RAS purposes.
>>
>> The goal here is not to share the hardware-specific translation logic, but
>> to provide a unified interface (an abstraction layer). The actual
>> implementation of the translation remains entirely architecture-specific.
> 
> And why do we need an arch-overlapping unified interface?
> 
> You can just as well have aest_convert_la_to_spa() and none of that "unifying"
> churn.
> 
You're right, that would be much cleaner. I was trying too hard to keep 
the interface unified across architectures. I'll drop the unified 
interface and use a direct helper instead in next version. Thanks for 
the feedback!

