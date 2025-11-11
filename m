Return-Path: <linux-acpi+bounces-18780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F4C4F4D3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 18:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 339F94E83CE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE112848A2;
	Tue, 11 Nov 2025 17:45:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AA0280329;
	Tue, 11 Nov 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883144; cv=none; b=WD5mirH8H08dG/VFaP8l900s04vD6wtNdgcViZZWbI6BKGycBnNZP3LrggUGWFXJjsLNFB4zdxIG6kdZPv+hLLsXG9bRyGPV0lkoQp1wMDb2keVntE8B+duCeoLwQIwUFpwqGehy1MOtPL/rOiX1wPDakJ5IMUMsOKdJKIH/Wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883144; c=relaxed/simple;
	bh=337GK2VBuQER80HrR8VLp/BBTkzZ42YWnJrE1tKersU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDZk8KF2coMx+goYTCndQbX7nWGTytJY6B6esO7A2zC79MNbU9/UBrbVwq2M4FQ3WHbp33yjukH8u31ZQPkefiDm3qtxi2RardWBOBzGA53WDGVUWMzycFhRPpG5hWC/7tqZstV9tt9/KqW+zo1h27Y76Z2Rcf0pnCLPGo6KIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28353497;
	Tue, 11 Nov 2025 09:45:34 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4536B3F5A1;
	Tue, 11 Nov 2025 09:45:37 -0800 (PST)
Message-ID: <ee02c9fb-721d-4fb8-a2e7-d7a291972a8c@arm.com>
Date: Tue, 11 Nov 2025 17:45:35 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-24-ben.horgan@arm.com>
 <20251110172724.00005675@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251110172724.00005675@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/10/25 17:27, Jonathan Cameron wrote:
> On Fri, 7 Nov 2025 12:34:40 +0000
> Ben Horgan <ben.horgan@arm.com> wrote:
> 
>> From: James Morse <james.morse@arm.com>
>>
>> When CPUs come online the MSC's original configuration should be restored.
>>
>> Add struct mpam_config to hold the configuration. This has a bitmap of
>> features that were modified. Once the maximum partid is known, allocate
> 
> I'm not following 'were modified'.  When?  Sometime in the past?
> Perhaps "features that have been modified when XXX happens" or
> 
> Having read the code I think this is something like "are modified as configuration
> is read".
> 
>> a configuration array for each component, and reprogram each RIS
>> configuration from this.
>>
>> CC: Dave Martin <Dave.Martin@arm.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Cc: Shaopeng Tan (Fujitsu) tan.shaopeng@fujitsu.com
>> Cc: Peter Newman peternewman@google.com
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> Changes since v3:
>> Drop tags
>> Fix component reset, otherwise cpbm wrong and controls not set.
>> Add a cfg_lock to guard configuration of an msc
> 
> The use of bitmap_set() for things that aren't unsigned long (arrays) is a bad
> idea. Much better to use GENMASK() to fill those.
> 
>> ---
>>  drivers/resctrl/mpam_devices.c  | 268 ++++++++++++++++++++++++++++++--
>>  drivers/resctrl/mpam_internal.h |  27 ++++
>>  2 files changed, 280 insertions(+), 15 deletions(-)

> Why manipulate a u32 with bitmap_set() with a horrible pretend it's an unsigned long cast.
> Instead just do:
> 		comp->cfg[i].cpbm = GENMASK(cprops->cpbm_wd, 0);
> Which is indeed what bitmap_set will do internally due to an optimization for small bitmaps
> but lets avoid that making one integer pretend to be another of a different length.
> 
> 
>> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_pbm, 0, cprops->mbw_pbm_bits);
>> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_max, 16 - cprops->bwa_wd, cprops->bwa_wd);
>> +	}
>> +}
> 

It is a bit nasty. I was trying to keep the concept of setting n bits and avoid 
considering explicitly what happens when n is zero.

These bitmap_set() can become:

if (cprops->cpbm_wd)
	comp->cfg[i].cpbm = GENMASK(cprops->cpbm_wd - 1, 0);
if (cprops->mbw_pbm_bits)
	comp->cfg[i].mbw_pbm = GENMASK(cprops->mbw_pbm_bits - 1, 0);
if (cprops->bwa_wd)
	comp->cfg[i].mbw_max = GENMASK(15, 16 - cprops->bwa_wd);

 
Thanks,

Ben


