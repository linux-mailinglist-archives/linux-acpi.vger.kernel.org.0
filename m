Return-Path: <linux-acpi+bounces-17422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CCBAA34D
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0164B171D28
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD6222585;
	Mon, 29 Sep 2025 17:44:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27012222AF;
	Mon, 29 Sep 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167865; cv=none; b=JKwskMl7hUcbWsRs0yEY+lIOvEwolP3h9tICCrSdRpnspIEbxhDk4+jnZ92UQIASMGLesg5zM68GnkYulSF5bqG0YL5DGcu8xmdyou8gDXuwWqZ/EjSuJWWw775al9hbRLMrz5ZFhAdAzyWpEbRvEWDPxdt7idW0CnA9t4DOP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167865; c=relaxed/simple;
	bh=oLEs3M/HoMQmClNW65g0NyCg7T9r85p1Tp75aPNj8EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdwVhwd+/Wvhw8rEO1/W3HoodIp4h6ObUiLa+9Au7efP+TiDMTubCphwP166sJDfT344+FJF83oQSsLf/UPOAx4gREJoynsobt5BCoiA738FcTSOroSUMHgI7T+FMUDaZ3nzqRY+C9iv7JwB4aVhST8WgO+egqFuYtVmVQoB9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDB2F1758;
	Mon, 29 Sep 2025 10:44:13 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC47F3F59E;
	Mon, 29 Sep 2025 10:44:16 -0700 (PDT)
Message-ID: <59fbb8d9-5df6-4269-aa81-147618450644@arm.com>
Date: Mon, 29 Sep 2025 18:44:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/29] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Lecopzer Chen <lecopzerc@nvidia.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-11-james.morse@arm.com>
 <13347819-c83d-446b-856e-d7fd8ec742ea@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <13347819-c83d-446b-856e-d7fd8ec742ea@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 12/09/2025 11:42, Ben Horgan wrote:
> On 9/10/25 21:42, James Morse wrote:
>> Because an MSC can only by accessed from the CPUs in its cpu-affinity
>> set we need to be running on one of those CPUs to probe the MSC
>> hardware.
>>
>> Do this work in the cpuhp callback. Probing the hardware will only
>> happen before MPAM is enabled, walk all the MSCs and probe those we can
>> reach that haven't already been probed as each CPU's online call is made.
>>
>> This adds the low-level MSC register accessors.
>>
>> Once all MSCs reported by the firmware have been probed from a CPU in
>> their respective cpu-affinity set, the probe-time cpuhp callbacks are
>> replaced.  The replacement callbacks will ultimately need to handle
>> save/restore of the runtime MSC state across power transitions, but for
>> now there is nothing to do in them: so do nothing.
>>
>> The architecture's context switch code will be enabled by a static-key,
>> this can be set by mpam_enable(), but must be done from process context,
>> not a cpuhp callback because both take the cpuhp lock.
>> Whenever a new MSC has been probed, the mpam_enable() work is scheduled
>> to test if all the MSCs have been probed. If probing fails, mpam_disable()
>> is scheduled to unregister the cpuhp callbacks and free memory.
>>
>> CC: Lecopzer Chen <lecopzerc@nvidia.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>> Changes since v1:
>>  * Removed register bounds check. If the firmware tables are wrong the
>>    resulting translation fault should be enough to debug this.
>>  * Removed '&' in front of a function pointer.
>>  * Pulled mpam_disable() into this patch.
>>  * Disable mpam when probing fails to avoid extra work on broken platforms.
>>  * Added mpam_disbale_reason as there are now two non-debug reasons for this
>>    to happen.
> 
> Looks good to me.
> 
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>


Thanks!

James

