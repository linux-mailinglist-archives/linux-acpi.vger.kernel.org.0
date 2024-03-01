Return-Path: <linux-acpi+bounces-4054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249F86DECE
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 11:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DD01F2311A
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB06EB6C;
	Fri,  1 Mar 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b209a22p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046B6BB2C;
	Fri,  1 Mar 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287352; cv=none; b=CJNhzoOrjFGsdNeohpljnoD70bThOSXUIPmf8uuaT9Lwef39veAZhuTw4qtJz0tzP8Z8+SIO2PJOGIoj/B4sVVkQ/zdAj9GImEVoAUJOpZwXjF23cFKTbUTgiKU4qoCdFAsAQlt4pr7/rc/K4n4tudtYe8Cp4drTuUkCo/4Ohvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287352; c=relaxed/simple;
	bh=OvOYYUCG3c7ssoi05Zx92UGrIZ2K40dKEFbz8G9tN80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9bYtIsKB3JUFOo9+OwiZ0uGhGF4LRe8heC/nTEFRtM1AHrs4ZTxV86DapbMiBSWiR7kpyCSvRzhjpV6GVqgkPOsy6FON+xUXSMWewcNn+rfrmIof8xDNq7MEi1j4tJ9dXa6uzcEIa3QD69xR38KlizbRU4RA0KulFqrvvuPEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b209a22p; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709287347; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=quGYQwGPPF3DG0ZofAGuxpdgXr8KP41ZYuJMaGRU+c8=;
	b=b209a22p+frS3JszGTklJvmQ9vMA62107JwBBOaJ1q67xhS7dOL8PZ5A5Za7lGInfn91IpmcWcG1LIJvZqH9S3CKyqRiFBg8uvu60glzWm7S2Mj0atYjYwRoVMwnsvxkkMJet1bF8Bon9vVKmYkTuYv074eCAnP00t3bqa4zReA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1bSknU_1709287345;
Received: from 30.221.97.202(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0W1bSknU_1709287345)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 18:02:26 +0800
Message-ID: <cdb0f30e-b1d5-49ba-8730-740e9c06c87c@linux.alibaba.com>
Date: Fri, 1 Mar 2024 18:02:26 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cstate: fix mwait hint target cstate calc
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: jacob.jun.pan@linux.intel.com, lenb@kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, shannon.zhao@linux.alibaba.com
References: <64137e23-e374-4129-8e3c-dcd7606364d4@linux.alibaba.com>
 <CAJZ5v0hG7vpWd9-pdeuNZDpDQ13MuwzgPkFnyG7TuQ=DRAMo6Q@mail.gmail.com>
From: He Rongguang <herongguang@linux.alibaba.com>
In-Reply-To: <CAJZ5v0hG7vpWd9-pdeuNZDpDQ13MuwzgPkFnyG7TuQ=DRAMo6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/3/1 1:22, Rafael J. Wysocki 写道:
> On Wed, Feb 28, 2024 at 8:28 AM He Rongguang
> <herongguang@linux.alibaba.com> wrote:
>>
>> According to x86 manual (Intel SDM Vol 2, Table 4-11. MWAIT Hints
>> Register (EAX) and AMD manual Vol 3, MWAIT), mwait hint[7:4] adds 1 is
>> the corresponding cstate, and 0xF means C0, so fix the handling of
>> 0xF -> C0.
>>
>> Intel: "Value of 0 means C1; 1 means C2 and so on
>> Value of 01111B means C0".
>>
>> AMD: "The processor C-state is EAX[7:4]+1, so to request C0 is to place
>> the value F in EAX[7:4] and to request C1 is to place the value 0 in
>> EAX[7:4].".
> 
> Yes, 0x0F is defined to correspond to C0.  However, the value in
> question is never equal to 0x0F in any of the functions modified by
> this patch.
> 
> What's the purpose of the modification, then?
> 

Hi, this is found when I tweak ACPI cstate table qemu presenting to VM.

Usually, ACPI cstate table only contains C1+, but nothing prevents ACPI 
firmware from presenting a cstate (maybe C1+) but using a mwait address 
C0 (i.e., 0xF in ACPI FFH MWAIT hint address). And if this is the case, 
Linux erroneously treat this cstate as C16, while actually this should 
be legal C0 state.

As I think ACPI firmware is out of Linux kernel scope, so I think it’s 
better for Linux kernel to implement here referring to spec, how do you 
think? :)


>> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
>> ---
>>    arch/x86/kernel/acpi/cstate.c | 4 ++--
>>    drivers/idle/intel_idle.c     | 3 ++-
>>    2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>> index 401808b47af3..f3ffd0a3a012 100644
>> --- a/arch/x86/kernel/acpi/cstate.c
>> +++ b/arch/x86/kernel/acpi/cstate.c
>> @@ -131,8 +131,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void
>> *_cx)
>>           cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
>>
>>           /* Check whether this particular cx_type (in CST) is supported
>> or not */
>> -       cstate_type = ((cx->address >> MWAIT_SUBSTATE_SIZE) &
>> -                       MWAIT_CSTATE_MASK) + 1;
>> +       cstate_type = (((cx->address >> MWAIT_SUBSTATE_SIZE) &
>> +                       MWAIT_CSTATE_MASK) + 1) & MWAIT_CSTATE_MASK;
>>           edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
>>           num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index bcf1198e8991..e486027f8b07 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -1934,7 +1934,8 @@ static void __init spr_idle_state_table_update(void)
>>
>>    static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>>    {
>> -       unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
>> +       unsigned int mwait_cstate = (MWAIT_HINT2CSTATE(mwait_hint) + 1) &
>> +                                       MWAIT_CSTATE_MASK;
>>           unsigned int num_substates = (mwait_substates >> mwait_cstate *
>> 4) &
>>                                           MWAIT_SUBSTATE_MASK;
>>
>> --


