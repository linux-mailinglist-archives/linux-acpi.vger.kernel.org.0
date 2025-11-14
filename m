Return-Path: <linux-acpi+bounces-18908-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 327EBC5DAD6
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 15:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5A366CE9
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303B8280CE5;
	Fri, 14 Nov 2025 14:34:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86BB1E7C18;
	Fri, 14 Nov 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130884; cv=none; b=mQ5i4j+tMZ1TcW6SQaf7sE0dHezwt7v4FNkCVMK8y8EAIAcMmjCiFzO0FDZRHhe1jh/fqNh9C1rz8fsLEni1kDzr9rvsrX25gJDoYsXTWNMLXNNSNB0HNUHdlI0Ras16UEfIiY5Nn8ynmL0nIZCtqFvyjAQDlxPLkAfw6AR3sCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130884; c=relaxed/simple;
	bh=C6xej7gbgx9rWFTnu4qMbIdd5TzFRa0VFArmEkUk5MQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=obKlKggT3+O29z1L9Lz+Dv8e+WNNTr4UBKNtmf6av0iWeJtKOv5eWUGgnxnL9Ljy6RQ0w5HkRuZvDulYptTN4Tw8KQi2VqYHx8PqFHAqVQVkHt5q0wjfj4t2NkDI9sLLEy2PnEzR+iBlJP1qRlmQt+0dJsr+/qk6l719F9PozDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E79A1063;
	Fri, 14 Nov 2025 06:34:33 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE873F5A1;
	Fri, 14 Nov 2025 06:34:36 -0800 (PST)
Message-ID: <acb7ee15-f0e5-4641-a377-71205e202f15@arm.com>
Date: Fri, 14 Nov 2025 14:34:34 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] arm_mpam: Allow configuration to be applied and
 restored during cpu online
From: Ben Horgan <ben.horgan@arm.com>
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
 <e4521b04-6c3c-418b-8cee-6be43d5ef17f@arm.com>
Content-Language: en-US
In-Reply-To: <e4521b04-6c3c-418b-8cee-6be43d5ef17f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/14/25 10:33, Ben Horgan wrote:
> Hi Jonathan,
> 
> On 11/10/25 17:27, Jonathan Cameron wrote:
>> On Fri, 7 Nov 2025 12:34:40 +0000
>> Ben Horgan <ben.horgan@arm.com> wrote:
>>
>>> From: James Morse <james.morse@arm.com>
>>>
>>> When CPUs come online the MSC's original configuration should be restored.
>>>
>>> Add struct mpam_config to hold the configuration. This has a bitmap of
>>> features that were modified. Once the maximum partid is known, allocate
>>
>> I'm not following 'were modified'.  When?  Sometime in the past?
>> Perhaps "features that have been modified when XXX happens" or
> 
> The intent of the features bitmp is to only update the configuration in
> hardware for the feautures that require it. On reset, this is all
> features, but for a user configuration change this is just the
> difference from what was previously set.

I wasn't quite correct here. The feature bitmap for each component
indicates which features have been changed (by user configuration) to a
value different from their default. These bits aren't unset when the
setting is changed back to the reset value. It can thus be used on power
restoration to restore the user config. I think this is what James meant
by "were modified".

> 
> However, I don't think the difference part is currently working
> correctly; the bitmap always has all the bits set and so any update
> configures everything. I'll look into this.
> 
>>
>> Having read the code I think this is something like "are modified as configuration
>> is read".
>>
>>> a configuration array for each component, and reprogram each RIS
>>> configuration from this.
> Thanks,
> 
> Ben
> 
> 

-- 
Thanks,

Ben


