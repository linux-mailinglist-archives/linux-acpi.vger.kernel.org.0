Return-Path: <linux-acpi+bounces-18013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6CEBF298B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF50F4E5B3D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7255264A92;
	Mon, 20 Oct 2025 17:04:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0219F115;
	Mon, 20 Oct 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979878; cv=none; b=osRIJFZ37ccyhZPi8GqdWway6MyEc6KEf0/JjLEgIW6mUUIGAlxlNk4q5WDRpTXg3Aq/Gkj8MqQHbzevAG7dixQ5wDUeTUkt2BIzHIOHSl+u9dAa9vHWrKhZwD5P0aeyfI8Ty4T1+V9deB/YBIy9obOpzxeg2KfEH3GAuneKYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979878; c=relaxed/simple;
	bh=t4SvdQdtF+gXT4T2MbXED1Pj3P07F+eclBTZIQ/ninU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4pYUeGX2gm+oMGGUqbddhUKfF6M9FaDtQwnletYWELVwK4Aq8jXrFsnQRBkYRmEibh6q4O/MibDKmW9V6tSGm6LBiuGAV0TouV1Il/c4jwBdZ6DgOa2PpMMFmSDZI6SB8kcZBnpFeZRflzuYeVp+vMk40P1kY917Q3Lq1QYRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C22391007;
	Mon, 20 Oct 2025 10:04:27 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B8AF3F66E;
	Mon, 20 Oct 2025 10:04:30 -0700 (PDT)
Message-ID: <9ad95fa5-6f1d-4c31-a6c6-41c1e9cc5c20@arm.com>
Date: Mon, 20 Oct 2025 18:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-21-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> When CPUs come online the MSC's original configuration should be restored.
> 
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate
> a configuration array for each component, and reprogram each RIS
> configuration from this.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>  * Call mpam_init_reset_cfg() on alloated config as 0 is not longer correct.
>  * init_garbage() on each config - the array has to be freed in one go, but
>    otherwise this looks weird.
>  * Use struct initialiser in mpam_init_reset_cfg(),
>  * Moved int err definition.
>  * Removed srcu lock taking based on squinting at the only caller.
>  * Moved config reset to mpam_reset_component_cfg() for re-use in
>    mpam_reset_component_locked(), previous memset() was not enough since zero
>    no longer means reset.
> 
[...]
>  
> +struct reprogram_ris {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_config *cfg;
> +};
> +
> +/* Call with MSC lock held */
> +static int mpam_reprogram_ris(void *_arg)
> +{
> +	u16 partid, partid_max;
> +	struct reprogram_ris *arg = _arg;
> +	struct mpam_msc_ris *ris = arg->ris;
> +	struct mpam_config *cfg = arg->cfg;
> +
> +	if (ris->in_reset_state)
> +		return 0;
> +
> +	spin_lock(&partid_max_lock);
> +	partid_max = mpam_partid_max;
> +	spin_unlock(&partid_max_lock);
> +	for (partid = 0; partid <= partid_max + 1; partid++)

Loop overrun. This was correct in the previous version of the patch and
the same shape of loop is done correctly elsewhere in this version. I
think it would be good to standardise on using either:
partid <= partid_max
or
partid < partid_max + 1
I have a preference for the first as you don't need to think about the
size of the type.

-- 
Thanks,

Ben


