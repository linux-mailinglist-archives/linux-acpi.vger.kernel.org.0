Return-Path: <linux-acpi+bounces-16710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22000B54A1A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A6C16A39D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8BD2E173F;
	Fri, 12 Sep 2025 10:42:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3E2472B5;
	Fri, 12 Sep 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673732; cv=none; b=nNYqd8hQZTALljxqnVDlWJPhwp/svQWmqyQy8EN5lyjpTQN2hb8oIEJj51zbwF3+j22awQsOrm4cLSBRvdfdvYE04E855t5s+wAWK2VkdeDu1zbC8S698YxMJRAGxKVRBJCObiL6yiXnwr/dnKpI5Eh9B12PjY2QUYa1DVhB9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673732; c=relaxed/simple;
	bh=otd6QxpT8qFQVUNAzfILUI02V9sOlrSc4wYVCCapfTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8FMeeYnYrmwEn6qfRUFXrTnlbhTQF47mc+7jOVzksTyYBdqZcAVUatN4eFz76q3XOxE1vlggchF8UAKa4diYqvOH76OCUdYt643UHW5s+wBJzGwQT/Zj18WtPoiBadRR9GXcq/ukNvmfr7I2mIe0oNdjLSerkfRDTSPInJue1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 437FA1515;
	Fri, 12 Sep 2025 03:42:02 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505263F66E;
	Fri, 12 Sep 2025 03:42:05 -0700 (PDT)
Message-ID: <13347819-c83d-446b-856e-d7fd8ec742ea@arm.com>
Date: Fri, 12 Sep 2025 11:42:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/29] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
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
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
> Because an MSC can only by accessed from the CPUs in its cpu-affinity
> set we need to be running on one of those CPUs to probe the MSC
> hardware.
> 
> Do this work in the cpuhp callback. Probing the hardware will only
> happen before MPAM is enabled, walk all the MSCs and probe those we can
> reach that haven't already been probed as each CPU's online call is made.
> 
> This adds the low-level MSC register accessors.
> 
> Once all MSCs reported by the firmware have been probed from a CPU in
> their respective cpu-affinity set, the probe-time cpuhp callbacks are
> replaced.  The replacement callbacks will ultimately need to handle
> save/restore of the runtime MSC state across power transitions, but for
> now there is nothing to do in them: so do nothing.
> 
> The architecture's context switch code will be enabled by a static-key,
> this can be set by mpam_enable(), but must be done from process context,
> not a cpuhp callback because both take the cpuhp lock.
> Whenever a new MSC has been probed, the mpam_enable() work is scheduled
> to test if all the MSCs have been probed. If probing fails, mpam_disable()
> is scheduled to unregister the cpuhp callbacks and free memory.
> 
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Removed register bounds check. If the firmware tables are wrong the
>    resulting translation fault should be enough to debug this.
>  * Removed '&' in front of a function pointer.
>  * Pulled mpam_disable() into this patch.
>  * Disable mpam when probing fails to avoid extra work on broken platforms.
>  * Added mpam_disbale_reason as there are now two non-debug reasons for this
>    to happen.

Looks good to me.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


