Return-Path: <linux-acpi+bounces-19312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79930C8EBD6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B3194E7A17
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124CB332EB7;
	Thu, 27 Nov 2025 14:25:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DD322A30;
	Thu, 27 Nov 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253537; cv=none; b=hBcBsEorU9EKWMQE3kBK9U/KDiVNxlp/Md7/agdwcKn9/35MIV1us0pQOnlMfCoQy8a94pX/IePIlSYCISUX/QOQFdQpVreTyxbICBZEv7Ayjb5zWNdwQEcGTV2NfzWDhrzhRzxlDHlWQZacT5KPUw/vzbhAILMgZgSo/1ymi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253537; c=relaxed/simple;
	bh=BzW2NJ4OfMgV3Q8lzowk8nYh6djORK6Ufl5SsVly5mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzXo1HpKFwmzjdZrHsV+4U+AYTB7nIKbTW4IE8leIX6s057+h8+/X47WeNWvib60oOF8FUxZ02kpR8CNc/Pswi/xxnemBkcjmn30BXUO9rNrM5NLLZVIIeVVKCck/gZ7WzuSg7zwmTzAlCgIjtuWm7RSw4TfsoeqqYrezbbmEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D755D1063;
	Thu, 27 Nov 2025 06:25:26 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72B153F73B;
	Thu, 27 Nov 2025 06:25:29 -0800 (PST)
Message-ID: <a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com>
Date: Thu, 27 Nov 2025 14:25:28 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, jonathan.cameron@huawei.com,
 kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, peternewman@google.com,
 quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org,
 rohit.mathew@arm.com, scott@os.amperecomputing.com, sdonthineni@nvidia.com,
 sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
 xhao@linux.alibaba.com, reinette.chatre@intel.com
References: <20251119122305.302149-1-ben.horgan@arm.com>
 <877bvfa23i.fsf@stealth>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <877bvfa23i.fsf@stealth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Punit,

On 11/24/25 15:21, Punit Agrawal wrote:
> Hi Ben, James
> 
> Ben Horgan <ben.horgan@arm.com> writes:
> 
>>
>> This series is based on v6.18-rc4, and can be retrieved from: (no v6 version)
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v5
>>
>> The rest of the driver can be found here: (no v6 version)
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc4-v5
>>
>> What is MPAM? Set your time-machine to 2020:
>> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> Although a little late to the party, I've managed to throw together
> enough firmware to describe the MPAM hardware and take this set (more
> specifically mpam/snapshot/v6.18-rc4-v5 branch from James' repository)
> for a spin. Using the branch, the kernel is able to probe the hardware
> and discover the advertised features. Yay! We are in business.

Thanks for giving it a go. :)

> 
> Having said that, there are a few quirks of the platform that run into
> issues with later patches in the branch. The platform has MSCs attached
> to shared L2 caches which are being skipped during later stages of
> initialisation. IIUC, the L2 MSCs' limitations stems from the
> assumptions in the resctrl interface.

What in particualar is being skipped?

> 
> I was wondering if there are any patches available to relax these
> limitations? I can give them a try. Or do these need to be put together
> from the ground up? Any pointers greatly appreciated.

There are some extra things added in the extras branch [1] e.g. cache
maximum usage controls (cmax). However, lots of possible things are
still missing e.g. any monitors on L2. If it doesn't fit with the
topology expected by resctrl then it is unlikely to have been considered
yet.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot%2bextras/v6.18-rc1

Thanks,

Ben


