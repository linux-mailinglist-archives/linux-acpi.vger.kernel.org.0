Return-Path: <linux-acpi+bounces-16711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59006B54AB7
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784701CC8302
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 11:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB72FF15E;
	Fri, 12 Sep 2025 11:11:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F32E9EC4;
	Fri, 12 Sep 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675472; cv=none; b=FSJdPCZPq0SQjn9AykWsYCk9GUD/yfXCu1gvHRIucVsgfMAMdoYpTM2K71/gKSSbH7e+QP51AUy/eF1PWIwgQNW7v2t6kc8uplbf3rIP0ZWt9XsoEibpTG7T9DKwa/iS61Ixw6z4Nl7X8jmgMXOLM/hL5sbcc11OAq1dRuoQaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675472; c=relaxed/simple;
	bh=WPg1MX5YdeajSnOVG3EHSck6rVJjOHR1MxH29ORiRNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeFdcd5WGpgd9u2Wbn9u8uk5++Fx2SOXiRrWbpoTqWXh1cTba919im8dsT/gvNxFt04dgApLL2LWfD0twQ64mJurbYxJdOV66lxhMTm8BbDTOvfDq0xM/GttjhTxqYZjT+7F+9xpI47I4rOtCzST19OqmzDkoX6PP8g8rrsSk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04BE1515;
	Fri, 12 Sep 2025 04:11:01 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0A353F63F;
	Fri, 12 Sep 2025 04:11:04 -0700 (PDT)
Message-ID: <0382ea8a-8f15-4983-8659-0471f9090012@arm.com>
Date: Fri, 12 Sep 2025 12:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/29] arm_mpam: Probe hardware to find the supported
 partid/pmg values
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
 <20250910204309.20751-12-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-12-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
> CPUs can generate traffic with a range of PARTID and PMG values,
> but each MSC may also have its own maximum size for these fields.
> Before MPAM can be used, the driver needs to probe each RIS on
> each MSC, to find the system-wide smallest value that can be used.
> The limits from requestors (e.g. CPUs) also need taking into account.
> 
> While doing this, RIS entries that firmware didn't describe are created
> under MPAM_CLASS_UNKNOWN.
> 
> While we're here, implement the mpam_register_requestor() call
> for the arch code to register the CPU limits. Future callers of this
> will tell us about the SMMU and ITS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Change to lock ordering now that the list-lock mutex isn't held from
>    the cpuhp call.
>  * Removed irq-unmaksed assert in requestor register.
>  * Changed captialisation in print message.
> ---
>  drivers/resctrl/mpam_devices.c  | 150 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |   6 ++
>  include/linux/arm_mpam.h        |  14 +++
>  3 files changed, 169 insertions(+), 1 deletion(-)

Looks good to me. I think Jonathan's comment on getting rid of the local
variable, 'found', is worthwhile.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


