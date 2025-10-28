Return-Path: <linux-acpi+bounces-18292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048AC15AFF
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDAC1883E99
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB343446BA;
	Tue, 28 Oct 2025 16:01:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C6345739;
	Tue, 28 Oct 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667315; cv=none; b=jH5YbtBiYiLVQwHyOnE+W6lqFqIvNBAIk+EkkP8os8sDicLyH5QE/HUghkK+SahZBb6v61YvewVb3KxrhEqLwUiQNkxyYz7CQrZqatjyx6qXQPGZRc4tPbvGwwaYAJP4oTeinPoQ1FSUYp3PgrxClHL5ZXChdvvZIb4xIm6Zupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667315; c=relaxed/simple;
	bh=mkuXtx/SaDIkPn12CmnBubCR1rFT4XbZg3oz3XQqaIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3krEVufo4Prx+Ce5ZsAO5F0V5gtiC8ZsnwEQQIR8iqsLiiarwtYq1UB2uFgtwAonWJtFfWWpUXE/oUZqjLHIh3ic3FQ+UDbGIkSldZtdCDi8XAcUeIInutfbVzyWOu0jJOryeFwWw2ik8xW+eUEkJXm0fw361jSS4HEH1hoR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F4E168F;
	Tue, 28 Oct 2025 09:01:44 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BECC53F63F;
	Tue, 28 Oct 2025 09:01:47 -0700 (PDT)
Message-ID: <56f7f2df-fd94-48c8-aaa0-97a71b3108cf@arm.com>
Date: Tue, 28 Oct 2025 16:01:46 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1] arm64/mpam: Fix MBWU monitor
 overflow handling
To: Zeng Heng <zengheng4@huawei.com>, james.morse@arm.com
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
 xhao@linux.alibaba.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251022133913.629859-1-zengheng4@huawei.com>
 <8e22c81e-5e78-41e0-a81e-0f9826e5edf0@arm.com>
 <1c037f72-485a-567b-bf8f-489255330de8@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <1c037f72-485a-567b-bf8f-489255330de8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Zeng,

On 10/25/25 10:01, Zeng Heng wrote:
> Hi Ben,
> 
> On 2025/10/23 0:17, Ben Horgan wrote:
> 
>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>> ---
>>>   drivers/resctrl/mpam_devices.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/
>>> mpam_devices.c
>>> index 0dd048279e02..06f3ec9887d2 100644
>>> --- a/drivers/resctrl/mpam_devices.c
>>> +++ b/drivers/resctrl/mpam_devices.c
>>> @@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
>>>       clean_msmon_ctl_val(&cur_ctl);
>>>       gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>>>       config_mismatch = cur_flt != flt_val ||
>>> -              cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>>> +             (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
>>> +             (ctl_val | MSMON_CFG_x_CTL_EN);
>>
>> This only considers 31 bit counters. I would expect any change here to
>> consider all lengths of counter.
> 
> Sorry, regardless of whether the counter is 32-bit or 64-bit, the
> config_mismatch logic should be handled the same way here. Am I
> wrong?

Yes, they should be handled the same way. However, the overflow status
bit for long counters is MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L.

I now see that the existing code in the series has this covered.
Both the overflow bits are masked out in clean_msmon_ctl_val(). No need
for any additional masking.

> 
> Best Regards,
> Zeng Heng
> 
> 

Thanks,

Ben


