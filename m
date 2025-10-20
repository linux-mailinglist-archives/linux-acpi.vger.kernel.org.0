Return-Path: <linux-acpi+bounces-18011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3BFBF26EF
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 18:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEDF3A9661
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DF289E13;
	Mon, 20 Oct 2025 16:28:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD0F4FA;
	Mon, 20 Oct 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977707; cv=none; b=fvTgpb9twBBKYKEhT24sXR7X/s/En5RqbLoTZcOl6fqGN1TBh1o5D6dhKo9Y4LuS8Kr+OJ+vFFaRY9mGxNFH1NQIFPSwBZJv2WvDfo4hK7d73Tin+qEGf0Mfx0nEIFWsUMS0qWlyKTpIAbrU1z1IH3cUyZNokiXVKIQByDyQk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977707; c=relaxed/simple;
	bh=AOuKbHm4cIrK27uOxuqdzZxdGEgZkIlRzauZRokpYUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWucl+E443Vm1vYyCr3nJROMLTAjvZgzoJ02h9Ma14eJ++H5HO9epdBv8urB+B0LEXNF/x4Ge8pDyESn+26FM+eCr2Vmr/TQ9mcg2uupEY0XtcOdI2zdMAenFTa483+fhCn9cv8oXaL5sY41psHn/PxTeVmZbh5I6EQhOgBDWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A241063;
	Mon, 20 Oct 2025 09:28:13 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49B283F63F;
	Mon, 20 Oct 2025 09:28:16 -0700 (PDT)
Message-ID: <7ac2abe6-7311-4b20-b1fb-566ed7516315@arm.com>
Date: Mon, 20 Oct 2025 17:28:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/29] arm_mpam: Use a static key to indicate when mpam
 is enabled
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-20-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-20-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> Once all the MSC have been probed, the system wide usable number of
> PARTID is known and the configuration arrays can be allocated.
> 
> After this point, checking all the MSC have been probed is pointless,
> and the cpuhp callbacks should restore the configuration, instead of
> just resetting the MSC.
> 
> Add a static key to enable this behaviour. This will also allow MPAM
> to be disabled in response to an error, and the architecture code to
> enable/disable the context switch of the MPAM system registers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>  * Removed the word 'TODO'.
>  * Fixed a typo in the commit message.
> ---
[..]
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index a04b09abd814..d492df9a1735 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -9,6 +9,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/cpumask.h>
>  #include <linux/io.h>
> +#include <linux/jump_label.h>
>  #include <linux/llist.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
> @@ -19,8 +20,16 @@
>  
>  #define MPAM_MSC_MAX_NUM_RIS	16
>  
> +

nit: stray whitespace change

>  struct platform_device;
>  
> +DECLARE_STATIC_KEY_FALSE(mpam_enabled);
> +
> +static inline bool mpam_is_enabled(void)
> +{
> +	return static_branch_likely(&mpam_enabled);
> +}
> +
>  /*
>   * Structures protected by SRCU may not be freed for a surprising amount of
>   * time (especially if perf is running). To ensure the MPAM error interrupt can

-- 
Thanks,

Ben


