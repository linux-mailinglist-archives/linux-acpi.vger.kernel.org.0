Return-Path: <linux-acpi+bounces-17580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 020E2BB7D71
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB7FD4EE8BC
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56922DBF75;
	Fri,  3 Oct 2025 18:04:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625DC2C21DB;
	Fri,  3 Oct 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514676; cv=none; b=MgAKkmPKAqoocPSk6/MUBlN6t0rwVjdOTT/XShXcsdAEFZZFpq6qWc+oU83Zv24Z7Ky151qrt0BefybaFyve5JYLBymVEK/wF4LkeDm79RC73RWzJ7Ay/Kc0bwUuSiNMgCJLMtjxyhyU8ncW5wpSkmOFVSAFlehu2Q1d2Uli7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514676; c=relaxed/simple;
	bh=iycIE/C71XdC8Q733mqJrOT3IAKDZgNSULKSF6Rk3TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TksFL+0WA5zDXTJl26DJTvrJpAgjXAvUCgIFu+iFrWxl5NkqpPRMKc6DsG8mxDJRPpwAu4vyB4BUK/EgnlQNyRuLjqJUJ5TSEXYvD+ahiNMfNp9zPgTsSI97wnS1K9cFC5FtSMMUhSTOiqe8G3Giv5wibDr6c/e+8wiMHC7c9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B84E81655;
	Fri,  3 Oct 2025 11:04:26 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA1303F5A1;
	Fri,  3 Oct 2025 11:04:29 -0700 (PDT)
Message-ID: <312531db-9293-4db1-b97a-2437105c3ccb@arm.com>
Date: Fri, 3 Oct 2025 19:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-21-james.morse@arm.com>
 <3359b947-6adb-4d77-97e1-5abb0b9d2a4e@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <3359b947-6adb-4d77-97e1-5abb0b9d2a4e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 25/09/2025 07:53, Fenghua Yu wrote:
> On 9/10/25 13:43, James Morse wrote:
>> When CPUs come online the MSC's original configuration should be restored.
>>
>> Add struct mpam_config to hold the configuration. This has a bitmap of
>> features that were modified. Once the maximum partid is known, allocate
>> a configuration array for each component, and reprogram each RIS
>> configuration from this.


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index ec1db5f8b05c..7fd149109c75 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>> @@ -922,6 +991,40 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>>       }
>>   }
>>   +static void mpam_reprogram_msc(struct mpam_msc *msc)
>> +{
>> +    u16 partid;
>> +    bool reset;
>> +    struct mpam_config *cfg;
>> +    struct mpam_msc_ris *ris;
>> +
>> +    /*
>> +     * No lock for mpam_partid_max as partid_max_published has been
>> +     * set by mpam_enabled(), so the values can no longer change.
>> +     */
>> +    mpam_assert_partid_sizes_fixed();
>> +
>> +    guard(srcu)(&mpam_srcu);

> mpam_srcu is locked in caller mpam_cpu_online(). It's unnecessary to call guard(srcu)
> (&mpam_srcu) here again for simpler logic and less overhead.

It's not simpler - as now the requirements for the innards of mpam_reprogram_msc() have to
spill out to the callers.
I also contest that its less overhead - this is used on the cpuhp path, I'd suspect the
'cost' can't even be measured.

The good news is at the end of the day this thing only has that one caller, so I'll change
this one ...


Thanks,

James



