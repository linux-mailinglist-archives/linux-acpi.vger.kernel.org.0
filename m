Return-Path: <linux-acpi+bounces-16740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C5B55293
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0237D1CC7CA9
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69719882B;
	Fri, 12 Sep 2025 15:00:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70F828373;
	Fri, 12 Sep 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689238; cv=none; b=EgOfid13kMnbqKoMD/7h/7sc/+UrWr/PonTw0MgrGyf3z9odzfo+V/MI7l+I2zD5ncbgSXnRphquFPi5br5PucOI8gwI/SsEZpuHJcBczJIOmTmHFfZcfavPqLb3aXpwtsjphSSiHX5hLxKSYvwlXR4DL5CnZV1DkWwEOTnnmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689238; c=relaxed/simple;
	bh=QYX6DEPnALv8VrhjqMcHzjidP6B9lzW1oyW/6+vMXPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoRn98GPhG++Eg4Fvg5Vba0EDBuQUpEMwrYo+WhaSDD9ZYOHOakIPLUG/BQySBJPP94qrFZ3RNR7tPDhFENtKlZNSMDK2atWqPnTl1iHIO2GKR208/mxpYBqjI5sKliIzj4ZfY0mcIESStTXIuYxTwN3WFGT88pbW8al/KUZVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E5C16A3;
	Fri, 12 Sep 2025 08:00:28 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01D03F694;
	Fri, 12 Sep 2025 08:00:31 -0700 (PDT)
Message-ID: <5eb4b7f0-37eb-47c9-a955-ed9db17fa1e5@arm.com>
Date: Fri, 12 Sep 2025 16:00:30 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-21-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:43, James Morse wrote:
> When CPUs come online the MSC's original configuration should be restored.
> 
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate
> a configuration array for each component, and reprogram each RIS
> configuration from this.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Switched entry_rcu to srcu versions.
> 
> Changes since RFC:
>  * Added a comment about the ordering around max_partid.
>  * Allocate configurations after interrupts are registered to reduce churn.
>  * Added mpam_assert_partid_sizes_fixed();
>  * Make reset use an all-ones instead of zero config.
> ---
>  drivers/resctrl/mpam_devices.c  | 269 +++++++++++++++++++++++++++++---
>  drivers/resctrl/mpam_internal.h |  29 +++-
>  2 files changed, 271 insertions(+), 27 deletions(-)
> 

Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Thanks,

Ben


