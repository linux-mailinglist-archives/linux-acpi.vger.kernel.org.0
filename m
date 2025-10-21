Return-Path: <linux-acpi+bounces-18026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFABF5A42
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BF83A8950
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE12D77F7;
	Tue, 21 Oct 2025 09:51:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA591A8F6D;
	Tue, 21 Oct 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040268; cv=none; b=LXR3d3VEostf3Bw/k+qNPRJqTkfrtAwrBfHrHhIQ2PLOL26z4+a6S7qQL310aVRUuP2M+ruIqEltA2oakhnno12LfGOYrKmM8tlJ29lv+kWS+wCHe96KZHme1sOjIxdqhb6zaZgHxtNsXoEb06QD1DG+MIsLzN2d6KZZg9lOkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040268; c=relaxed/simple;
	bh=NSne+DffPdM7pcG80L9YSSLIMXgzXMO33pUv6CPuLL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwFb42bWLwJuH27HAaKJDT7+2gl2u9yhqdoW+xg25WRq5dWVrJ3ods3+V7K5o+veGN8YWYYEpNYcrKLTAojGuL2xzflnkUe1CoB7+WVHhBgEEJX8X3wozlOR3V9R4zfLfLuoKv776jrnTtqjr9G8ksUyCEFzHku4OhH5UNpB7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B4951007;
	Tue, 21 Oct 2025 02:50:58 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5A433F66E;
	Tue, 21 Oct 2025 02:51:01 -0700 (PDT)
Message-ID: <146ad8f4-ef6c-48cb-aed8-db619c8258a8@arm.com>
Date: Tue, 21 Oct 2025 10:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
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
 <20251017185645.26604-8-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> only be accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until
> the system-wide common values for num_partid and num_pmg have been
> discovered.
> 
> Start with driver probe/remove and mapping the MSC.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Comment in Kconfig about why EXPERT.
>  * Dropped duplicate depends.
>  * Fixed duplicate return statement.
>  * Restructured driver probe to have a do_ function to allow breaks to be
>    return instead...
>  * Removed resctrl.h include, added spinlock.h
>  * Removed stray DT function prototype
>  * Removed stray PCC variables in struct mpam_msc.
>  * Used ccflags not cflags for debug define.
>  * Moved srcu header include to internal.h
>  * Moved mpam_msc_destroy() into this patch.
> 
> Changes since v1:
>  * Avoid selecting driver on other architectrues.
>  * Removed PCC support stub.
>  * Use for_each_available_child_of_node_scoped() and of_property_read_reg()
>  * Clarified a comment.
>  * Stopped using mpam_num_msc as an id,a and made it atomic.
>  * Size of -1 returned from cache_of_calculate_id()
>  * Renamed some struct members.
>  * Made a bunch of pr_err() dev_err_ocne().
>  * Used more cleanup magic.
>  * Inlined a print message.
>  * Fixed error propagation from mpam_dt_parse_resources().
>  * Moved cache accessibility checks earlier.
>  * Change cleanup macro to use IS_ERR_OR_NULL().
> 
> Changes since RFC:
>  * Check for status=broken DT devices.
>  * Moved all the files around.
>  * Made Kconfig symbols depend on EXPERT
> ---
>  arch/arm64/Kconfig              |   1 +
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   1 +
>  drivers/acpi/arm64/mpam.c       |   7 ++
>  drivers/resctrl/Kconfig         |  13 +++
>  drivers/resctrl/Makefile        |   4 +
>  drivers/resctrl/mpam_devices.c  | 190 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |  52 +++++++++
>  include/linux/acpi.h            |   2 +-
>  9 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/resctrl/Kconfig
>  create mode 100644 drivers/resctrl/Makefile
>  create mode 100644 drivers/resctrl/mpam_devices.c
>  create mode 100644 drivers/resctrl/mpam_internal.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c5e66d5d72cd..004d58cfbff8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2025,6 +2025,7 @@ config ARM64_TLB_RANGE
>  
>  config ARM64_MPAM
>  	bool "Enable support for MPAM"
> +	select ARM64_MPAM_DRIVER if EXPERT	# does nothing yet
>  	select ACPI_MPAM if ACPI

If ARM64_MPAM is selected without selecting EXPERT then ACPI_MPAM is
selected but not ACPI_MPAM. When the whole series is applied this
configuration does not build as the mpam acpi code calls mpam_ris_create().

Thanks,

Ben


