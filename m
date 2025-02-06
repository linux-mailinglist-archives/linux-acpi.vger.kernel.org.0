Return-Path: <linux-acpi+bounces-10907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D2EA2A32D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 09:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D03A0F7D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0862248BE;
	Thu,  6 Feb 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tf6ckVjw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25103155744;
	Thu,  6 Feb 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830775; cv=none; b=UEqtr3twATtRh4c/RzmleO/FpDo4Z9MhMvgmz/T64m2eav9BXYUgJ/uomMZxiXsiFUU8diiHuIkOiYTyyATMI/Qo5ftBB0+TXYf45ZlNS3krLLAiiHSL01qnRuJL9Lg3oqdk15RBJGa5Mv9uJ99RUE2KK3HeB/DF733yaQPRGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830775; c=relaxed/simple;
	bh=AyE3Z5NlOjWborPY298k0nXNb5eqXu/KhJXY+cmdEcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QT0sU7/WEBrILBkJJZzpSsR6If6/zrc5yS0+OZcoMh7nHdxDfUvZdwRMlCtvm2zbE5bQSp3s/+OseZNfBOV/hZ5FQ8DfrFSp6bIvVFQb7IrUPqIcwOdRsbGWOLYfA2rAf8QGyJVEfJ4xXtzhthi2FfPikyNLHAuhyUjdcYHMqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tf6ckVjw; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738830761; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0BqqKAzOWHgDzWNdQzpAnY6sjrKtNnPhZcsxkkDrOrs=;
	b=Tf6ckVjwx/dG1+fs/bDPv1Hi4OHDFfUwK/WAKdauX8ovDOrKMVFSDc/VKRo0Kc9O1IvYdFyKZbFBil0q/YkMWa1HMjRg+SvOXkjmjzB5HUrOPWpwNbqUDyvNWh/K4zJcbjJFtP/n+TTfgOM4Y+5TVQSbU4AjhIEufcMv74oDF+0=
Received: from 30.221.131.52(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WOvgwhh_1738830758 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 16:32:39 +0800
Message-ID: <2f52ecf5-27ab-49c3-b7df-d1a43e403a3f@linux.alibaba.com>
Date: Thu, 6 Feb 2025 16:32:37 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ACPI/RAS/AEST: Initial AEST driver
To: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "rafael@kernel.org"
 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
 "tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>
Cc: Tyler Baicar <baicar@os.amperecomputing.com>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
 <20250115084228.107573-2-tianruidong@linux.alibaba.com>
 <TYCPR01MB9617ACDCBA0A2D306789A314E51B2@TYCPR01MB9617.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <TYCPR01MB9617ACDCBA0A2D306789A314E51B2@TYCPR01MB9617.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Hello, some comments below.

Thank you for your comments! I really appreciate it.

> 
>> Subject: [PATCH v3 1/5] ACPI/RAS/AEST: Initial AEST driver
>>
>> Add support for parsing the ARM Error Source Table and basic handling of
>> errors reported through both memory mapped and system register interfaces.
>>
>> Assume system register interfaces are only registered with private
>> peripheral interrupts (PPIs); otherwise there is no guarantee the
>> core handling the error is the core which took the error and has the
>> syndrome info in its system registers.
>>
>> In kernel-first mode, all configuration is controlled by kernel, include
>> CE ce_threshold and interrupt enable/disable.
>>
>> All detected errors will be processed as follow:
>>    - CE, DE: use a workqueue to log this hare errors.
>>    - UER, UEO: log it and call memory_failun workquee.
>>    - UC, UEU: panic in irq context.
>>
>> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
>> ---
>>   MAINTAINERS                  |  10 +
>>   arch/arm64/include/asm/ras.h |  95 ++++
>>   drivers/acpi/arm64/Kconfig   |  11 +
>>   drivers/acpi/arm64/Makefile  |   1 +
>>   drivers/acpi/arm64/aest.c    | 335 ++++++++++++
>>   drivers/acpi/arm64/init.c    |   2 +
>>   drivers/acpi/arm64/init.h    |   1 +
>>   drivers/ras/Kconfig          |   1 +
>>   drivers/ras/Makefile         |   1 +
>>   drivers/ras/aest/Kconfig     |  17 +
>>   drivers/ras/aest/Makefile    |   5 +
>>   drivers/ras/aest/aest-core.c | 976 +++++++++++++++++++++++++++++++++++
>>   drivers/ras/aest/aest.h      | 323 ++++++++++++
>>   include/linux/acpi_aest.h    |  68 +++
>>   include/linux/cpuhotplug.h   |   1 +
>>   include/linux/ras.h          |   8 +
>>   16 files changed, 1855 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/ras.h
>>   create mode 100644 drivers/acpi/arm64/aest.c
>>   create mode 100644 drivers/ras/aest/Kconfig
>>   create mode 100644 drivers/ras/aest/Makefile
>>   create mode 100644 drivers/ras/aest/aest-core.c
>>   create mode 100644 drivers/ras/aest/aest.h
>>   create mode 100644 include/linux/acpi_aest.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 637ddd44245f..d757f9339627 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -330,6 +330,16 @@ S:	Maintained
>>   F:	drivers/acpi/arm64
>>   F:	include/linux/acpi_iort.h
>>
>> +ACPI AEST
>> +M:	Ruidong Tian <tianruidond@linux.alibaba.com>
>> +L:	linux-acpi@vger.kernel.org
>> +L:	linux-arm-kernel@lists.infradead.org
>> +S:	Supported
>> +F:	arch/arm64/include/asm/ras.h
>> +F:	drivers/acpi/arm64/aest.c
>> +F:	drivers/ras/aest/
>> +F:	include/linux/acpi_aest.h
>> +
>>   ACPI FOR RISC-V (ACPI/riscv)
>>   M:	Sunil V L <sunilvl@ventanamicro.com>
>>   L:	linux-acpi@vger.kernel.org
>> diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
>> new file mode 100644
>> index 000000000000..7676add8a0ed
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/ras.h
>> @@ -0,0 +1,95 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_RAS_H
>> +#define __ASM_RAS_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/bits.h>
>> +
>> +/* ERR<n>FR */
>> +#define ERR_FR_CE                      GENMASK_ULL(54, 53)
>> +#define ERR_FR_RP                      BIT(15)
>> +#define ERR_FR_CEC                     GENMASK_ULL(14, 12)
>> +
>> +#define ERR_FR_RP_SINGLE_COUNTER       0
>> +#define ERR_FR_RP_DOUBLE_COUNTER       1
>> +
>> +#define ERR_FR_CEC_0B_COUNTER          0
>> +#define ERR_FR_CEC_8B_COUNTER          BIT(1)
>> +#define ERR_FR_CEC_16B_COUNTER         BIT(2)
>> +
>> +/* ERR<n>STATUS */
>> +#define ERR_STATUS_AV		BIT(31)
>> +#define ERR_STATUS_V		BIT(30)
>> +#define ERR_STATUS_UE		BIT(29)
>> +#define ERR_STATUS_ER		BIT(28)
>> +#define ERR_STATUS_OF		BIT(27)
>> +#define ERR_STATUS_MV		BIT(26)
>> +#define ERR_STATUS_CE		(BIT(25) | BIT(24))
>> +#define ERR_STATUS_DE		BIT(23)
>> +#define ERR_STATUS_PN		BIT(22)
>> +#define ERR_STATUS_UET		(BIT(21) | BIT(20))
>> +#define ERR_STATUS_CI		BIT(19)
>> +#define ERR_STATUS_IERR		GENMASK_ULL(15, 8)
>> +#define ERR_STATUS_SERR		GENMASK_ULL(7, 0)
>> +
>> +/* Theses bits are	 write-one-to-clear */
>> +#define ERR_STATUS_W1TC		(ERR_STATUS_AV | ERR_STATUS_V | ERR_STATUS_UE | \
>> +				ERR_STATUS_ER | ERR_STATUS_OF | ERR_STATUS_MV | \
>> +				ERR_STATUS_CE | ERR_STATUS_DE | ERR_STATUS_PN | \
>> +				ERR_STATUS_UET | ERR_STATUS_CI)
>> +
>> +#define ERR_STATUS_UET_UC	0
>> +#define ERR_STATUS_UET_UEU	1
>> +#define ERR_STATUS_UET_UEO	2
>> +#define ERR_STATUS_UET_UER	3
>> +
>> +/* ERR<n>CTLR */
>> +#define ERR_CTLR_CFI		BIT(8)
>> +#define ERR_CTLR_FI		BIT(3)
>> +#define ERR_CTLR_UI		BIT(2)
>> +
>> +/* ERR<n>ADDR */
>> +#define ERR_ADDR_AI		BIT(61)
>> +#define ERR_ADDR_PADDR		GENMASK_ULL(55, 0)
>> +
>> +/* ERR<n>MISC0 */
>> +
>> +/* ERR<n>FR.CEC == 0b010, ERR<n>FR.RP == 0  */
>> +#define ERR_MISC0_8B_OF		BIT(39)
>> +#define ERR_MISC0_8B_CEC	GENMASK_ULL(38, 32)
>> +
>> +/* ERR<n>FR.CEC == 0b100, ERR<n>FR.RP == 0  */
>> +#define ERR_MISC0_16B_OF	BIT(47)
>> +#define ERR_MISC0_16B_CEC	GENMASK_ULL(46, 32)
>> +
>> +#define ERR_MISC0_CEC_SHIFT	31
>> +
>> +#define ERR_8B_CEC_MAX		(ERR_MISC0_8B_CEC >> ERR_MISC0_CEC_SHIFT)
>> +#define ERR_16B_CEC_MAX		(ERR_MISC0_16B_CEC >> ERR_MISC0_CEC_SHIFT)
>> +
>> +/* ERR<n>FR.CEC == 0b100, ERR<n>FR.RP == 1  */
>> +#define ERR_MISC0_16B_OFO	BIT(63)
>> +#define ERR_MISC0_16B_CECO	GENMASK_ULL(62, 48)
>> +#define ERR_MISC0_16B_OFR	BIT(47)
>> +#define ERR_MISC0_16B_CECR	GENMASK_ULL(46, 32)
>> +
>> +/* ERRDEVARCH */
>> +#define ERRDEVARCH_REV		GENMASK(19, 16)
>> +
>> +enum ras_ce_threshold {
>> +	RAS_CE_THRESHOLD_0B,
>> +	RAS_CE_THRESHOLD_8B,
>> +	RAS_CE_THRESHOLD_16B,
>> +	RAS_CE_THRESHOLD_32B,
>> +	UNKNOWN,
>> +};
>> +
>> +struct ras_ext_regs {
>> +	u64 err_fr;
>> +	u64 err_ctlr;
>> +	u64 err_status;
>> +	u64 err_addr;
>> +	u64 err_misc[4];
>> +};
>> +
>> +#endif	/* __ASM_RAS_H */
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> index b3ed6212244c..c8eb6de95733 100644
>> --- a/drivers/acpi/arm64/Kconfig
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -21,3 +21,14 @@ config ACPI_AGDI
>>
>>   config ACPI_APMT
>>   	bool
>> +
>> +config ACPI_AEST
>> +	bool "ARM Error Source Table Support"
>> +	depends on ARM64_RAS_EXTN
>> +
>> +	help
>> +	  The Arm Error Source Table (AEST) provides details on ACPI
>> +	  extensions that enable kernel-first handling of errors in a
>> +	  system that supports the Armv8 RAS extensions.
>> +
>> +	  If set, the kernel will report and log hardware errors.
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> index 05ecde9eaabe..8e240b281fd1 100644
>> --- a/drivers/acpi/arm64/Makefile
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -6,5 +6,6 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>>   obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
>>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
>> +obj-$(CONFIG_ACPI_AEST) 	+= aest.o
>>   obj-y				+= dma.o init.o
>>   obj-y				+= thermal_cpufreq.o
>> diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
>> new file mode 100644
>> index 000000000000..6dba9c23e04e
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/aest.c
>> @@ -0,0 +1,335 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ARM Error Source Table Support
>> + *
>> + * Copyright (c) 2024, Alibaba Group.
>> + */
>> +
>> +#include <linux/xarray.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/acpi_aest.h>
>> +
>> +#include "init.h"
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "ACPI AEST: " fmt
>> +
>> +static struct xarray *aest_array;
>> +
>> +static void __init aest_init_interface(struct acpi_aest_hdr *hdr,
>> +				       struct acpi_aest_node *node)
>> +{
>> +	struct acpi_aest_node_interface_header *interface;
>> +
>> +	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface_header, hdr,
>> +				 hdr->node_interface_offset);
>> +
>> +	node->type = hdr->type;
>> +	node->interface_hdr = interface;
>> +
>> +	switch (interface->group_format) {
>> +	case ACPI_AEST_NODE_GROUP_FORMAT_4K: {
>> +		struct acpi_aest_node_interface_4k *interface_4k =
>> +			(struct acpi_aest_node_interface_4k *)(interface + 1);
>> +
>> +		node->common = &interface_4k->common;
>> +		node->record_implemented =
>> +			(unsigned long *)&interface_4k->error_record_implemented;
>> +		node->status_reporting =
>> +			(unsigned long *)&interface_4k->error_status_reporting;
>> +		node->addressing_mode =
>> +			(unsigned long *)&interface_4k->addressing_mode;
>> +		break;
>> +	}
>> +	case ACPI_AEST_NODE_GROUP_FORMAT_16K: {
>> +		struct acpi_aest_node_interface_16k *interface_16k =
>> +			(struct acpi_aest_node_interface_16k *)(interface + 1);
>> +
>> +		node->common = &interface_16k->common;
>> +		node->record_implemented =
>> +			(unsigned long *)interface_16k->error_record_implemented;
>> +		node->status_reporting =
>> +			(unsigned long *)interface_16k->error_status_reporting;
>> +		node->addressing_mode =
>> +			(unsigned long *)interface_16k->addressing_mode;
>> +		break;
>> +	}
>> +	case ACPI_AEST_NODE_GROUP_FORMAT_64K: {
>> +		struct acpi_aest_node_interface_64k *interface_64k =
>> +			(struct acpi_aest_node_interface_64k *)(interface + 1);
>> +
>> +		node->common = &interface_64k->common;
>> +		node->record_implemented =
>> +			(unsigned long *)interface_64k->error_record_implemented;
>> +		node->status_reporting =
>> +			(unsigned long *)interface_64k->error_status_reporting;
>> +		node->addressing_mode =
>> +			(unsigned long *)interface_64k->addressing_mode;
>> +		break;
>> +	}
>> +	default:
>> +		pr_err("invalid group format: %d\n", interface->group_format);
>> +	}
>> +
>> +	node->interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt_v2,
>> +					hdr, hdr->node_interrupt_offset);
>> +
>> +	node->interrupt_count = hdr->node_interrupt_count;
>> +}
>> +
>> +static int __init acpi_aest_init_node_common(struct acpi_aest_hdr *aest_hdr,
>> +					struct acpi_aest_node *node)
>> +{
>> +	int ret;
>> +	struct aest_hnode *hnode;
>> +	u64 error_device_id;
>> +
>> +	aest_init_interface(aest_hdr, node);
>> +
>> +	error_device_id = node->common->error_node_device;
> 
> I think I see a problem with this.
>  From the spec[1], I understand that error node device is optional and
> error node device field is only valid when error node device valid flag is set.
> 
> [1] https://developer.arm.com/documentation/den0085/latest/
> 
> Previous versions work well for the system without error node device (i.e. system
> without ARMHE000 definition in DSDT) but this version doesn't.
> Do we need to rely on information from error node device here when
> a system has them? I thought AEST table has necessary information in all case and
> want to know why this version use different approach from v2.

Q: Do we need to rely on information from error node device here when
a system has them?
A: DSDT error device node may include certain ACPI methods, such as 
address translation for DDRC. Intel has implemented this approach by 
using an ACPI method to translate DIMM addresses into system physical 
addresses [0].

[0]: 
https://lore.kernel.org/all/20181015202620.23610-1-tony.luck@intel.com/T/#u

Reson for use different approach in v3
--------------------------------------------

In v3, an abstraction layer named AEST device was introduced on top of 
the AEST node. The main reasons are as follows:
1. Some AEST nodes share interrupts, and the AEST device is viewed as 
the owner of the interrupt to register interrupt functions.
2. Abstracting the contents of ACPI tables into platform devices is a 
common practice in ARM, like MPAM[1] an IORT, and I just follow it.

Which approach do you think is better, v2 or v3?

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.12-rc1&id=8c26b06d7b811d397e672fd3b0d7c10d4965d97a

> 
> Also, I wonder if there will be a system that only some nodes have valid flag.

My plan is to create an AEST platform device regardless of whether the 
node is valid. In the next version, I will set the error_device_id to a 
globally incrementing ID instead of directly assigning it the value of 
error_node_device.

> 
>> +
>> +	hnode = xa_load(aest_array, error_device_id);
>> +	if (!hnode) {
>> +		hnode = kmalloc(sizeof(*hnode), GFP_KERNEL);
>> +		if (!hnode) {
>> +			ret = -ENOMEM;
>> +			goto free;
>> +		}
>> +		INIT_LIST_HEAD(&hnode->list);
>> +		hnode->uid = error_device_id;
>> +		hnode->count = 0;
>> +		hnode->type = node->type;
>> +		xa_store(aest_array, error_device_id, hnode, GFP_KERNEL);
>> +	}
>> +
>> +	list_add_tail(&node->list, &hnode->list);
>> +	hnode->count++;
>> +
>> +	return 0;
>> +
>> +free:
>> +	kfree(node);
>> +	return ret;
>> +}
>> +
>> +static int __init
>> +acpi_aest_init_node_default(struct acpi_aest_hdr *aest_hdr)
>> +{
>> +	struct acpi_aest_node *node;
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return -ENOMEM;
>> +
>> +	node->spec_pointer = ACPI_ADD_PTR(void, aest_hdr,
>> +					aest_hdr->node_specific_offset);
>> +
>> +	return acpi_aest_init_node_common(aest_hdr, node);
>> +}
>> +
>> +static int __init
>> +acpi_aest_init_processor_node(struct acpi_aest_hdr *aest_hdr)
>> +{
>> +	struct acpi_aest_node *node;
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return -ENOMEM;
>> +
>> +	node->spec_pointer = ACPI_ADD_PTR(void, aest_hdr,
>> +					aest_hdr->node_specific_offset);
>> +
>> +	node->processor_spec_pointer = ACPI_ADD_PTR(void, node->spec_pointer,
>> +					sizeof(struct acpi_aest_processor));
>> +
>> +	return acpi_aest_init_node_common(aest_hdr, node);
>> +}
>> +
>> +static int __init acpi_aest_init_node(struct acpi_aest_hdr *header)
>> +{
>> +	switch (header->type) {
>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>> +		return acpi_aest_init_processor_node(header);
>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>> +	case ACPI_AEST_GIC_ERROR_NODE:
>> +	case ACPI_AEST_PCIE_ERROR_NODE:
>> +	case ACPI_AEST_PROXY_ERROR_NODE:
>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>> +		return acpi_aest_init_node_default(header);
>> +	default:
>> +		pr_err("acpi table header type is invalid: %d\n", header->type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init acpi_aest_init_nodes(struct acpi_table_header *aest_table)
>> +{
>> +	struct acpi_aest_hdr *aest_node, *aest_end;
>> +	struct acpi_table_aest *aest;
>> +	int rc;
>> +
>> +	aest = (struct acpi_table_aest *)aest_table;
>> +	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
>> +				 sizeof(struct acpi_table_header));
>> +	aest_end = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
>> +				aest_table->length);
>> +
>> +	while (aest_node < aest_end) {
>> +		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
>> +			pr_warn(FW_WARN "AEST node pointer overflow, bad table.\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		rc = acpi_aest_init_node(aest_node);
>> +		if (rc)
>> +			return rc;
>> +
>> +		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
>> +					 aest_node->length);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +acpi_aest_parse_irqs(struct platform_device *pdev, struct acpi_aest_node *anode,
>> +				struct resource *res, int *res_idx, int irqs[2])
>> +{
>> +	int i;
>> +	struct acpi_aest_node_interrupt_v2 *interrupt;
>> +	int trigger, irq;
>> +
>> +	for (i = 0; i < anode->interrupt_count; i++) {
>> +		interrupt = &anode->interrupt[i];
>> +		if (irqs[interrupt->type])
>> +			continue;
>> +
>> +		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
>> +			ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>> +
>> +		irq = acpi_register_gsi(&pdev->dev, interrupt->gsiv, trigger,
>> +						ACPI_ACTIVE_HIGH);
>> +		if (irq <= 0) {
>> +			pr_err("failed to map AEST GSI %d\n", interrupt->gsiv);
>> +			return irq;
>> +		}
>> +
>> +		res[*res_idx].start = irq;
>> +		res[*res_idx].end = irq;
>> +		res[*res_idx].flags = IORESOURCE_IRQ;
>> +		res[*res_idx].name = interrupt->type ? "eri" : "fhi";
>> +
>> +		(*res_idx)++;
>> +
>> +		irqs[interrupt->type] = irq;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init acpi_aest_alloc_pdev(void)
>> +{
>> +	int ret, j, size;
>> +	struct aest_hnode *ahnode = NULL;
>> +	unsigned long i;
>> +	struct platform_device *pdev;
>> +	struct acpi_device *companion;
>> +	struct acpi_aest_node *anode;
>> +	char uid[16];
>> +	struct resource *res;
>> +
>> +	xa_for_each(aest_array, i, ahnode) {
>> +		int irq[2] = { 0 };
>> +
>> +		res = kcalloc(ahnode->count + 2, sizeof(*res), GFP_KERNEL);
> 
> Why is +2 needed?

Each aest platform device have max 2 irq resources, one for Error 
Recovery Interrupt and one for  Fault Handling Interrupt. I will add a 
macro here next version.

> 
>> +		if (!res) {
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		pdev = platform_device_alloc("AEST", i);
>> +		if (IS_ERR(pdev)) {
>> +			ret = PTR_ERR(pdev);
>> +			break;
>> +		}
>> +
>> +		ret = snprintf(uid, sizeof(uid), "%u", (u32)i);
>> +		companion = acpi_dev_get_first_match_dev("ARMHE000", uid, -1);
>> +		if (companion)
>> +			ACPI_COMPANION_SET(&pdev->dev, companion);
>> +
>> +		j = 0;
>> +		list_for_each_entry(anode, &ahnode->list, list) {
>> +			if (anode->interface_hdr->type !=
>> +					ACPI_AEST_NODE_SYSTEM_REGISTER) {
>> +				res[j].name = "AEST:RECORD";
>> +				res[j].start = anode->interface_hdr->address;
>> +				size = anode->interface_hdr->error_record_count *
>> +						sizeof(struct ras_ext_regs);
>> +				res[j].end = res[j].start + size;
>> +				res[j].flags = IORESOURCE_MEM;
> 
> Will these fields be overwritten in below acpi_aest_parse_irqs()?

Yes, it is a bug, i will fix it next version.

> 
>> +			}
>> +
>> +			ret = acpi_aest_parse_irqs(pdev, anode, res, &j, irq);
>> +			if (ret) {
>> +				platform_device_put(pdev);
>> +				break;
>> +			}
>> +		}
>> +
>> +		ret = platform_device_add_resources(pdev, res, j);
>> +		if (ret)
>> +			break;
>> +
>> +		ret = platform_device_add_data(pdev, &ahnode, sizeof(ahnode));
>> +		if (ret)
>> +			break;
>> +
>> +		ret = platform_device_add(pdev);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	kfree(res);
>> +	if (ret)
>> +		platform_device_put(pdev);
>> +
>> +	return ret;
>> +}
>> +
>> +void __init acpi_aest_init(void)
>> +{
>> +	acpi_status status;
>> +	int ret;
>> +	struct acpi_table_header *aest_table;
>> +
>> +	status = acpi_get_table(ACPI_SIG_AEST, 0, &aest_table);
>> +	if (ACPI_FAILURE(status)) {
>> +		if (status != AE_NOT_FOUND) {
>> +			const char *msg = acpi_format_exception(status);
>> +
>> +			pr_err("Failed to get table, %s\n", msg);
>> +		}
>> +
>> +		return;
>> +	}
>> +
>> +	aest_array = kzalloc(sizeof(struct xarray), GFP_KERNEL);
>> +	xa_init(aest_array);
>> +
>> +	ret = acpi_aest_init_nodes(aest_table);
>> +	if (ret) {
>> +		pr_err("Failed init aest node %d\n", ret);
>> +		goto out;
>> +	}
>> +
>> +	ret = acpi_aest_alloc_pdev();
>> +	if (ret)
>> +		pr_err("Failed alloc pdev %d\n", ret);
>> +
>> +out:
>> +	acpi_put_table(aest_table);
>> +}
>> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
>> index 7a47d8095a7d..b0c768923831 100644
>> --- a/drivers/acpi/arm64/init.c
>> +++ b/drivers/acpi/arm64/init.c
>> @@ -12,4 +12,6 @@ void __init acpi_arch_init(void)
>>   		acpi_iort_init();
>>   	if (IS_ENABLED(CONFIG_ARM_AMBA))
>>   		acpi_amba_init();
>> +	if (IS_ENABLED(CONFIG_ACPI_AEST))
>> +		acpi_aest_init();
>>   }
>> diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
>> index dcc277977194..3902d1676068 100644
>> --- a/drivers/acpi/arm64/init.h
>> +++ b/drivers/acpi/arm64/init.h
>> @@ -5,3 +5,4 @@ void __init acpi_agdi_init(void);
>>   void __init acpi_apmt_init(void);
>>   void __init acpi_iort_init(void);
>>   void __init acpi_amba_init(void);
>> +void __init acpi_aest_init(void);
>> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
>> index fc4f4bb94a4c..61a2a05d9c94 100644
>> --- a/drivers/ras/Kconfig
>> +++ b/drivers/ras/Kconfig
>> @@ -33,6 +33,7 @@ if RAS
>>
>>   source "arch/x86/ras/Kconfig"
>>   source "drivers/ras/amd/atl/Kconfig"
>> +source "drivers/ras/aest/Kconfig"
>>
>>   config RAS_FMPM
>>   	tristate "FRU Memory Poison Manager"
>> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
>> index 11f95d59d397..72411ee9deaf 100644
>> --- a/drivers/ras/Makefile
>> +++ b/drivers/ras/Makefile
>> @@ -5,3 +5,4 @@ obj-$(CONFIG_RAS_CEC)	+= cec.o
>>
>>   obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
>>   obj-y			+= amd/atl/
>> +obj-y 			+= aest/
>> diff --git a/drivers/ras/aest/Kconfig b/drivers/ras/aest/Kconfig
>> new file mode 100644
>> index 000000000000..6d436d911bea
>> --- /dev/null
>> +++ b/drivers/ras/aest/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# ARM Error Source Table Support
>> +#
>> +# Copyright (c) 2024, Alibaba Group.
>> +#
>> +
>> +config AEST
>> +	tristate "ARM AEST Driver"
>> +	depends on ACPI_AEST && RAS
>> +
>> +	help
>> +	  The Arm Error Source Table (AEST) provides details on ACPI
>> +	  extensions that enable kernel-first handling of errors in a
>> +	  system that supports the Armv8 RAS extensions.
>> +
>> +	  If set, the kernel will report and log hardware errors.
>> diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
>> new file mode 100644
>> index 000000000000..a6ba7e36fb43
>> --- /dev/null
>> +++ b/drivers/ras/aest/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +obj-$(CONFIG_AEST) 	+= aest.o
>> +
>> +aest-y		:= aest-core.o
>> diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
>> new file mode 100644
>> index 000000000000..060a1eedee0a
>> --- /dev/null
>> +++ b/drivers/ras/aest/aest-core.c
>> @@ -0,0 +1,976 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ARM Error Source Table Support
>> + *
>> + * Copyright (c) 2021-2024, Alibaba Group.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/panic.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/xarray.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/ras.h>
>> +
>> +#include "aest.h"
>> +
>> +DEFINE_PER_CPU(struct aest_device, percpu_adev);
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "AEST: " fmt
>> +
>> +/*
>> + * This memory pool is only to be used to save AEST node in AEST irq context.
>> + * There can be 500 AEST node at most.
>> + */
>> +#define AEST_NODE_ALLOCED_MAX	500
>> +
>> +#define AEST_LOG_PREFIX_BUFFER	64
>> +
>> +BLOCKING_NOTIFIER_HEAD(aest_decoder_chain);
>> +
>> +static void aest_print(struct aest_event *event)
>> +{
>> +	static atomic_t seqno = { 0 };
>> +	unsigned int curr_seqno;
>> +	char pfx_seq[AEST_LOG_PREFIX_BUFFER];
>> +	int index;
>> +	struct ras_ext_regs *regs;
>> +
>> +	curr_seqno = atomic_inc_return(&seqno);
>> +	snprintf(pfx_seq, sizeof(pfx_seq), "{%u}" HW_ERR, curr_seqno);
>> +	pr_info("%sHardware error from AEST %s\n", pfx_seq, event->node_name);
>> +
>> +	switch (event->type) {
>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>> +		pr_err("%s Error from CPU%d\n", pfx_seq, event->id0);
>> +		break;
>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>> +		pr_err("%s Error from memory at SRAT proximity domain %#x\n",
>> +			pfx_seq, event->id0);
>> +		break;
>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>> +		pr_err("%s Error from SMMU IORT node %#x subcomponent %#x\n",
>> +			pfx_seq, event->id0, event->id1);
>> +		break;
>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>> +		pr_err("%s Error from vendor hid %8.8s uid %#x\n",
>> +			pfx_seq, event->hid, event->id1);
>> +		break;
>> +	case ACPI_AEST_GIC_ERROR_NODE:
>> +		pr_err("%s Error from GIC type %#x instance %#x\n",
>> +			pfx_seq, event->id0, event->id1);
>> +		break;
>> +	default:
>> +		pr_err("%s Unknown AEST node type\n", pfx_seq);
>> +		return;
>> +	}
>> +
>> +	index = event->index;
>> +	regs = &event->regs;
>> +
>> +	pr_err("%s  ERR%dFR: 0x%llx\n", pfx_seq, index, regs->err_fr);
>> +	pr_err("%s  ERR%dCTRL: 0x%llx\n", pfx_seq, index, regs->err_ctlr);
>> +	pr_err("%s  ERR%dSTATUS: 0x%llx\n", pfx_seq, index, regs->err_status);
>> +	if (regs->err_status & ERR_STATUS_AV)
>> +		pr_err("%s  ERR%dADDR: 0x%llx\n", pfx_seq, index,
>> +						regs->err_addr);
>> +
>> +	if (regs->err_status & ERR_STATUS_MV) {
>> +		pr_err("%s  ERR%dMISC0: 0x%llx\n", pfx_seq, index,
>> +						regs->err_misc[0]);
>> +		pr_err("%s  ERR%dMISC1: 0x%llx\n", pfx_seq, index,
>> +						regs->err_misc[1]);
>> +		pr_err("%s  ERR%dMISC2: 0x%llx\n", pfx_seq, index,
>> +						regs->err_misc[2]);
>> +		pr_err("%s  ERR%dMISC3: 0x%llx\n", pfx_seq, index,
>> +						regs->err_misc[3]);
>> +	}
>> +}
>> +
>> +static void aest_handle_memory_failure(u64 addr)
>> +{
>> +	unsigned long pfn;
>> +
>> +	pfn = PHYS_PFN(addr);
>> +
>> +	if (!pfn_valid(pfn)) {
>> +		pr_warn(HW_ERR "Invalid physical address: %#llx\n", addr);
>> +		return;
>> +	}
>> +
>> +#ifdef CONFIG_MEMORY_FAILURE
>> +	memory_failure(pfn, 0);
>> +#endif
>> +}
>> +
>> +static void init_aest_event(struct aest_event *event, struct aest_record *record,
>> +					struct ras_ext_regs *regs)
>> +{
>> +	struct aest_node *node = record->node;
>> +	struct acpi_aest_node *info = node->info;
>> +
>> +	event->type = node->type;
>> +	event->node_name = node->name;
>> +	switch (node->type) {
>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>> +		if (info->processor->flags & (ACPI_AEST_PROC_FLAG_SHARED |
>> +						ACPI_AEST_PROC_FLAG_GLOBAL))
>> +			event->id0 = smp_processor_id();
> 
> In "else" case, acpi processor id will be set for id0. So, how about use
> get_acpi_id_for_cpu(smp_processor_id()) here for consistency?

Acpi processor id may be confused to user, i will use 
get_cpu_for_acpi_id(info->processor->processor_id) in "else" case.

> 
>> +		else
>> +			event->id0 = info->processor->processor_id;
>> +
>> +		event->id1 = info->processor->resource_type;
>> +		break;
>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>> +		event->id0 = info->memory->srat_proximity_domain;
>> +		break;
>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>> +		event->id0 = info->smmu->iort_node_reference;
>> +		event->id1 = info->smmu->subcomponent_reference;
>> +		break;
>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>> +		event->id0 = 0;
>> +		event->id1 = info->vendor->acpi_uid;
>> +		event->hid = info->vendor->acpi_hid;
>> +		break;
>> +	case ACPI_AEST_GIC_ERROR_NODE:
>> +		event->id0 = info->gic->interface_type;
>> +		event->id1 = info->gic->instance_id;
>> +		break;
>> +	default:
>> +		event->id0 = 0;
>> +		event->id1 = 0;
>> +	}
>> +
>> +	memcpy(&event->regs, regs, sizeof(*regs));
>> +	event->index = record->index;
>> +	event->addressing_mode = record->addressing_mode;
>> +}
>> +
>> +static int
>> +aest_node_gen_pool_add(struct aest_device *adev, struct aest_record *record,
>> +					struct ras_ext_regs *regs)
>> +{
>> +	struct aest_event *event;
>> +
>> +	if (!adev->pool)
>> +		return -EINVAL;
>> +
>> +	event = (void *)gen_pool_alloc(adev->pool, sizeof(*event));
>> +	if (!event)
>> +		return -ENOMEM;
>> +
>> +	init_aest_event(event, record, regs);
>> +	llist_add(&event->llnode, &adev->event_list);
>> +
>> +	return 0;
>> +}
>> +
>> +static void aest_log(struct aest_record *record, struct ras_ext_regs *regs)
>> +{
>> +	struct aest_device *adev = record->node->adev;
>> +
>> +	if (!aest_node_gen_pool_add(adev, record, regs))
>> +		schedule_work(&adev->aest_work);
>> +}
>> +
>> +void aest_register_decode_chain(struct notifier_block *nb)
>> +{
>> +	blocking_notifier_chain_register(&aest_decoder_chain, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(aest_register_decode_chain);
>> +
>> +void aest_unregister_decode_chain(struct notifier_block *nb)
>> +{
>> +	blocking_notifier_chain_unregister(&aest_decoder_chain, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(aest_unregister_decode_chain);
>> +
>> +static void aest_node_pool_process(struct work_struct *work)
>> +{
>> +	struct llist_node *head;
>> +	struct aest_event *event;
>> +	struct aest_device *adev = container_of(work, struct aest_device,
>> +							aest_work);
>> +	u64 status, addr;
>> +
>> +	head = llist_del_all(&adev->event_list);
>> +	if (!head)
>> +		return;
>> +
>> +	head = llist_reverse_order(head);
>> +	llist_for_each_entry(event, head, llnode) {
>> +		aest_print(event);
>> +
>> +		/* TODO: translate Logical Addresses to System Physical Addresses */
>> +		if (event->addressing_mode == AEST_ADDREESS_LA ||
>> +			(event->regs.err_addr & ERR_ADDR_AI)) {
>> +			pr_notice("Can not translate LA to SPA\n");
>> +			addr = 0;
>> +		} else
>> +			addr = event->regs.err_addr & (1UL << CONFIG_ARM64_PA_BITS);
>> +
>> +		status = event->regs.err_status;
>> +		if (addr && ((status & ERR_STATUS_UE) || (status & ERR_STATUS_DE)))
>> +			aest_handle_memory_failure(addr);
>> +
>> +		blocking_notifier_call_chain(&aest_decoder_chain, 0, event);
>> +		gen_pool_free(adev->pool, (unsigned long)event,
>> +				sizeof(*event));
>> +	}
>> +}
>> +
>> +static int aest_node_pool_init(struct aest_device *adev)
>> +{
>> +	unsigned long addr, size;
>> +
>> +	size = ilog2(sizeof(struct aest_event));
>> +	adev->pool = devm_gen_pool_create(adev->dev, size, -1,
>> +						dev_name(adev->dev));
>> +	if (!adev->pool)
>> +		return -ENOMEM;
>> +
>> +	size = PAGE_ALIGN(size * AEST_NODE_ALLOCED_MAX);
>> +	addr = (unsigned long)devm_kzalloc(adev->dev, size, GFP_KERNEL);
>> +	if (!addr)
>> +		return -ENOMEM;
>> +
>> +	return gen_pool_add(adev->pool, addr, size, -1);
>> +
>> +	return 0;
>> +}
>> +
>> +static void aest_panic(struct aest_record *record, struct ras_ext_regs *regs, char *msg)
>> +{
>> +	struct aest_event event = { 0 };
>> +
>> +	init_aest_event(&event, record, regs);
>> +
>> +	aest_print(&event);
>> +
>> +	panic(msg);
>> +}
>> +
>> +static void aest_proc_record(struct aest_record *record, void *data)
>> +{
>> +	struct ras_ext_regs regs = {0};
>> +	int *count = data;
>> +
>> +	regs.err_status = record_read(record, ERXSTATUS);
>> +	if (!(regs.err_status & ERR_STATUS_V))
>> +		return;
>> +
>> +	(*count)++;
>> +
>> +	if (regs.err_status & ERR_STATUS_AV)
>> +		regs.err_addr = record_read(record, ERXADDR);
>> +
>> +	regs.err_fr = record->fr;
>> +	regs.err_ctlr = record_read(record, ERXCTLR);
>> +
>> +	if (regs.err_status & ERR_STATUS_MV) {
>> +		regs.err_misc[0] = record_read(record, ERXMISC0);
>> +		regs.err_misc[1] = record_read(record, ERXMISC1);
>> +		if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
>> +			regs.err_misc[2] = record_read(record, ERXMISC2);
>> +			regs.err_misc[3] = record_read(record, ERXMISC3);
>> +		}
>> +
>> +		if (record->node->info->interface_hdr->flags &
>> +			AEST_XFACE_FLAG_CLEAR_MISC) {
>> +			record_write(record, ERXMISC0, 0);
>> +			record_write(record, ERXMISC1, 0);
>> +			if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
>> +				record_write(record, ERXMISC2, 0);
>> +				record_write(record, ERXMISC3, 0);
>> +			}
>> +		/* ce count is 0 if record do not support ce */
>> +		} else if (record->ce.count > 0)
>> +			record_write(record, ERXMISC0, record->ce.reg_val);
>> +	}
>> +
>> +	/* panic if unrecoverable and uncontainable error encountered */
>> +	if ((regs.err_status & ERR_STATUS_UE) &&
>> +		(regs.err_status & ERR_STATUS_UET) > ERR_STATUS_UET_UEU)
>> +		aest_panic(record, &regs, "AEST: unrecoverable error encountered");
> 
> I think we need to use FIELD_GET to get correct value.
> 	u64 ue = FIELD_GET(ERR_STATUS_UET, regs.err_status);
> 	if ((regs.err_status & ERR_STATUS_UE) &&
>   		(ue == ERR_STATUS_UET_UC || ue == ERR_STATUS_UET_UEU))
> 

OK, i will update next version.

>> +
>> +	aest_log(record, &regs);
>> +
>> +	/* Write-one-to-clear the bits we've seen */
>> +	regs.err_status &= ERR_STATUS_W1TC;
>> +
>> +	/* Multi bit filed need to write all-ones to clear. */
>> +	if (regs.err_status & ERR_STATUS_CE)
>> +		regs.err_status |= ERR_STATUS_CE;
>> +
>> +	/* Multi bit filed need to write all-ones to clear. */
>> +	if (regs.err_status & ERR_STATUS_UET)
>> +		regs.err_status |= ERR_STATUS_UET;
>> +
>> +	record_write(record, ERXSTATUS, regs.err_status);
>> +}
>> +
>> +static void
>> +aest_node_foreach_record(void (*func)(struct aest_record *, void *),
>> +				struct aest_node *node, void *data,
>> +				unsigned long *bitmap)
>> +{
>> +	int i;
>> +
>> +	for_each_clear_bit(i, bitmap, node->record_count) {
>> +		aest_select_record(node, i);
>> +
>> +		func(&node->records[i], data);
>> +
>> +		aest_sync(node);
>> +	}
>> +}
>> +
>> +static int aest_proc(struct aest_node *node)
>> +{
>> +	int count = 0, i, j, size = node->record_count;
>> +	u64 err_group = 0;
>> +
>> +	aest_node_dbg(node, "Poll bit %*pb\n", size, node->record_implemented);
>> +	aest_node_foreach_record(aest_proc_record, node, &count,
>> +						node->record_implemented);
>> +
>> +	if (!node->errgsr)
>> +		return count;
>> +
>> +	aest_node_dbg(node, "Report bit %*pb\n", size, node->status_reporting);
>> +	for (i = 0; i < BITS_TO_U64(size); i++) {
>> +		err_group = readq_relaxed((void *)node->errgsr + i * 8);
>> +		aest_node_dbg(node, "errgsr[%d]: 0x%llx\n", i, err_group);
>> +
>> +		for_each_set_bit(j, (unsigned long *)&err_group,
>> +						BITS_PER_TYPE(u64)) {
>> +			/*
>> +			 * Error group base is only valid in Memory Map node,
>> +			 * so driver do not need to write select register and
>> +			 * sync.
>> +			 */
>> +			if (test_bit(i * BITS_PER_TYPE(u64) + j, node->status_reporting))
>> +				continue;
>> +			aest_proc_record(&node->records[j], &count);
>> +		}
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static irqreturn_t aest_irq_func(int irq, void *input)
>> +{
>> +	struct aest_device *adev = input;
>> +	int i;
>> +
>> +	for (i = 0; i < adev->node_cnt; i++)
>> +		aest_proc(&adev->nodes[i]);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void aest_enable_irq(struct aest_record *record)
>> +{
>> +	u64 err_ctlr;
>> +	struct aest_device *adev = record->node->adev;
>> +
>> +	err_ctlr = record_read(record, ERXCTLR);
>> +
>> +	if (adev->irq[ACPI_AEST_NODE_FAULT_HANDLING])
>> +		err_ctlr |= (ERR_CTLR_FI | ERR_CTLR_CFI);
>> +	if (adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY])
>> +		err_ctlr |= ERR_CTLR_UI;
>> +
>> +	record_write(record, ERXCTLR, err_ctlr);
>> +}
>> +
>> +static void aest_config_irq(struct aest_node *node)
>> +{
>> +	int i;
>> +	struct acpi_aest_node_interrupt_v2 *interrupt;
>> +
>> +	if (!node->irq_config)
>> +		return;
>> +
>> +	for (i = 0; i < node->info->interrupt_count; i++) {
>> +		interrupt = &node->info->interrupt[i];
>> +
>> +		if (interrupt->type == ACPI_AEST_NODE_FAULT_HANDLING)
>> +			writeq_relaxed(interrupt->gsiv, node->irq_config);
>> +
>> +		if (interrupt->type == ACPI_AEST_NODE_ERROR_RECOVERY)
>> +			writeq_relaxed(interrupt->gsiv, node->irq_config + 8);
>> +
>> +		aest_node_dbg(node, "config irq type %d gsiv %d at %llx",
>> +				interrupt->type, interrupt->gsiv,
>> +				(u64)node->irq_config);
>> +	}
>> +}
>> +
>> +static enum ras_ce_threshold aest_get_ce_threshold(struct aest_record *record)
>> +{
>> +	u64 err_fr, err_fr_cec, err_fr_rp = -1;
>> +
>> +	err_fr = record->fr;
>> +	err_fr_cec = FIELD_GET(ERR_FR_CEC, err_fr);
>> +	err_fr_rp = FIELD_GET(ERR_FR_RP, err_fr);
>> +
>> +	if (err_fr_cec == ERR_FR_CEC_0B_COUNTER)
>> +		return RAS_CE_THRESHOLD_0B;
>> +	else if (err_fr_rp == ERR_FR_RP_DOUBLE_COUNTER)
>> +		return RAS_CE_THRESHOLD_32B;
>> +	else if (err_fr_cec == ERR_FR_CEC_8B_COUNTER)
>> +		return RAS_CE_THRESHOLD_8B;
>> +	else if (err_fr_cec == ERR_FR_CEC_16B_COUNTER)
>> +		return RAS_CE_THRESHOLD_16B;
>> +	else
>> +		return UNKNOWN;
>> +
>> +}
>> +
>> +static const struct ce_threshold_info ce_info[] = {
>> +	[RAS_CE_THRESHOLD_0B] = { 0 },
>> +	[RAS_CE_THRESHOLD_8B] = {
>> +		.max_count = ERR_8B_CEC_MAX,
>> +		.mask = ERR_MISC0_8B_CEC,
>> +		.shift = ERR_MISC0_CEC_SHIFT,
>> +	},
>> +	[RAS_CE_THRESHOLD_16B] = {
>> +		.max_count = ERR_16B_CEC_MAX,
>> +		.mask = ERR_MISC0_16B_CEC,
>> +		.shift = ERR_MISC0_CEC_SHIFT,
>> +	},
>> +	//TODO: Support 32B CEC threshold.
>> +	[RAS_CE_THRESHOLD_32B] = { 0 },
>> +};
>> +
>> +static void aest_set_ce_threshold(struct aest_record *record)
>> +{
>> +	u64 err_misc0, ce_count;
>> +	struct ce_threshold *ce = &record->ce;
>> +	const struct ce_threshold_info *info;
>> +
>> +	record->threshold_type  = aest_get_ce_threshold(record);
>> +
>> +	switch (record->threshold_type) {
>> +	case RAS_CE_THRESHOLD_0B:
>> +		aest_record_dbg(record, "do not support CE threshold!\n");
>> +		return;
>> +	case RAS_CE_THRESHOLD_8B:
>> +		aest_record_dbg(record, "support 8 bit CE threshold!\n");
>> +		break;
>> +	case RAS_CE_THRESHOLD_16B:
>> +		aest_record_dbg(record, "support 16 bit CE threshold!\n");
>> +		break;
>> +	case RAS_CE_THRESHOLD_32B:
>> +		aest_record_dbg(record, "not support 32 bit CE threshold!\n");
>> +		break;
>> +	default:
>> +		aest_record_dbg(record, "Unknown misc0 ce threshold!\n");
>> +	}
>> +
>> +	err_misc0 = record_read(record, ERXMISC0);
>> +	info = &ce_info[record->threshold_type];
>> +	ce->info = info;
>> +	ce_count = (err_misc0 & info->mask) >> info->shift;
>> +	if (ce_count) {
>> +		ce->count = ce_count;
>> +		ce->threshold = info->max_count - ce_count + 1;
>> +		ce->reg_val = err_misc0;
>> +		aest_record_dbg(record, "CE threshold is %llx, controlled by FW",
>> +							ce->threshold);
>> +		return;
>> +	}
>> +
>> +	// Default CE threshold is 1.
>> +	ce->count = info->max_count;
>> +	ce->threshold = DEFAULT_CE_THRESHOLD;
>> +	ce->reg_val = err_misc0 | info->mask;
>> +
>> +	record_write(record, ERXMISC0, ce->reg_val);
>> +	aest_record_dbg(record, "CE threshold is %llx, controlled by Kernel",
>> +							ce->threshold);
>> +}
>> +
>> +static int aest_register_irq(struct aest_device *adev)
>> +{
>> +	int i, irq, ret;
>> +	char *irq_desc;
>> +
>> +	irq_desc = devm_kasprintf(adev->dev, GFP_KERNEL, "%s.%s.",
>> +				  dev_driver_string(adev->dev),
>> +				  dev_name(adev->dev));
>> +	if (!irq_desc)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < MAX_GSI_PER_NODE; i++) {
>> +		irq = adev->irq[i];
>> +
>> +		if (!irq)
>> +			continue;
>> +
>> +		if (irq_is_percpu_devid(irq)) {
>> +			ret = request_percpu_irq(irq, aest_irq_func,
>> +							irq_desc,
>> +							adev->adev_oncore);
>> +			if (ret)
>> +				goto free;
>> +		} else {
>> +			ret = devm_request_irq(adev->dev, irq, aest_irq_func,
>> +					0, irq_desc, adev);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +	return 0;
>> +
>> +free:
>> +	for (; i >= 0; i--) {
>> +		irq = adev->irq[i];
>> +
>> +		if (irq_is_percpu_devid(irq))
>> +			free_percpu_irq(irq, adev->adev_oncore);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int
>> +aest_init_record(struct aest_record *record, int i, struct aest_node *node)
>> +{
>> +	struct device *dev = node->adev->dev;
>> +
>> +	record->name = devm_kasprintf(dev, GFP_KERNEL, "record%d", i);
>> +	if (!record->name)
>> +		return -ENOMEM;
>> +
>> +	if (node->base)
>> +		record->regs_base = node->base + sizeof(struct ras_ext_regs) * i;
>> +
>> +	record->access = &aest_access[node->info->interface_hdr->type];
>> +	record->addressing_mode = test_bit(i, node->info->addressing_mode);
>> +	record->index = i;
>> +	record->node = node;
>> +	record->fr = record_read(record, ERXFR);
>> +
>> +	return 0;
>> +}
>> +
>> +static void aest_online_record(struct aest_record *record, void *data)
>> +{
>> +	if (record->fr & ERR_FR_CE)
>> +		aest_set_ce_threshold(record);
>> +
>> +	aest_enable_irq(record);
>> +}
>> +
>> +static void aest_online_oncore_node(struct aest_node *node)
>> +{
>> +	int count;
>> +
>> +	count = aest_proc(node);
>> +	aest_node_dbg(node, "Find %d error on CPU%d before AEST probe\n",
>> +						count, smp_processor_id());
>> +
>> +	aest_node_foreach_record(aest_online_record, node, NULL,
>> +						node->record_implemented);
>> +
>> +	aest_node_foreach_record(aest_online_record, node, NULL,
>> +						node->status_reporting);
>> +}
>> +
>> +static void aest_online_oncore_dev(void *data)
>> +{
>> +	int fhi_irq, eri_irq, i;
>> +	struct aest_device *adev = this_cpu_ptr(data);
>> +
>> +	for (i = 0; i < adev->node_cnt; i++)
>> +		aest_online_oncore_node(&adev->nodes[i]);
>> +
>> +	fhi_irq = adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
>> +	if (fhi_irq > 0)
>> +		enable_percpu_irq(fhi_irq, IRQ_TYPE_NONE);
>> +	eri_irq = adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
>> +	if (eri_irq > 0)
>> +		enable_percpu_irq(eri_irq, IRQ_TYPE_NONE);
>> +}
>> +
>> +static void aest_offline_oncore_dev(void *data)
>> +{
>> +	int fhi_irq, eri_irq;
>> +	struct aest_device *adev = this_cpu_ptr(data);
>> +
>> +	fhi_irq = adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
>> +	if (fhi_irq > 0)
>> +		disable_percpu_irq(fhi_irq);
>> +	eri_irq = adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
>> +	if (eri_irq > 0)
>> +		disable_percpu_irq(eri_irq);
>> +}
>> +
>> +static void aest_online_dev(struct aest_device *adev)
>> +{
>> +	int count, i;
>> +	struct aest_node *node;
>> +
>> +	for (i = 0; i < adev->node_cnt; i++) {
>> +		node = &adev->nodes[i];
>> +
>> +		if (!node->name)
>> +			continue;
>> +
>> +		count = aest_proc(node);
>> +		aest_node_dbg(node, "Find %d error before AEST probe\n", count);
>> +
>> +		aest_config_irq(node);
>> +
>> +		aest_node_foreach_record(aest_online_record, node, NULL,
>> +						node->record_implemented);
>> +		aest_node_foreach_record(aest_online_record, node, NULL,
>> +						node->status_reporting);
>> +	}
>> +}
>> +
>> +static int aest_starting_cpu(unsigned int cpu)
>> +{
>> +	pr_debug("CPU%d starting\n", cpu);
>> +	aest_online_oncore_dev(&percpu_adev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int aest_dying_cpu(unsigned int cpu)
>> +{
>> +	pr_debug("CPU%d dying\n", cpu);
>> +	aest_offline_oncore_dev(&percpu_adev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void aest_device_remove(struct platform_device *pdev)
>> +{
>> +	struct aest_device *adev = platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	if (adev->type != ACPI_AEST_PROCESSOR_ERROR_NODE)
>> +		return;
>> +
>> +	on_each_cpu(aest_offline_oncore_dev, adev->adev_oncore, 1);
>> +
>> +	for (i = 0; i < MAX_GSI_PER_NODE; i++) {
>> +		if (adev->irq[i])
>> +			free_percpu_irq(adev->irq[i], adev->adev_oncore);
>> +	}
>> +}
>> +
>> +
>> +static int get_aest_node_ver(struct aest_node *node)
>> +{
>> +	u64 reg;
>> +	void *devarch_base;
>> +
>> +	if (node->type == ACPI_AEST_GIC_ERROR_NODE) {
>> +		devarch_base = ioremap(node->info->interface_hdr->address +
>> +						GIC_ERRDEVARCH, PAGE_SIZE);
>> +		if (!devarch_base)
>> +			return 0;
>> +
>> +		reg = readl_relaxed(devarch_base);
>> +		iounmap(devarch_base);
>> +
>> +		return FIELD_GET(ERRDEVARCH_REV, reg);
>> +	}
>> +
>> +	return FIELD_GET(ID_AA64PFR0_EL1_RAS_MASK, read_cpuid(ID_AA64PFR0_EL1));
>> +}
>> +
>> +static char *alloc_aest_node_name(struct aest_node *node)
>> +{
>> +	char *name;
>> +
>> +	switch (node->type) {
>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>> +		name = devm_kasprintf(node->adev->dev, GFP_KERNEL, "%s.%d",
>> +			aest_node_name[node->type],
>> +			node->info->processor->processor_id);
>> +		break;
>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>> +	case ACPI_AEST_GIC_ERROR_NODE:
>> +	case ACPI_AEST_PCIE_ERROR_NODE:
>> +	case ACPI_AEST_PROXY_ERROR_NODE:
>> +		name = devm_kasprintf(node->adev->dev, GFP_KERNEL, "%s.%llx",
>> +			aest_node_name[node->type],
>> +			node->info->interface_hdr->address);
>> +		break;
>> +	default:
>> +		name = devm_kasprintf(node->adev->dev, GFP_KERNEL, "Unknown");
>> +	}
>> +
>> +	return name;
>> +}
>> +
>> +static int
>> +aest_node_set_errgsr(struct aest_device *adev, struct aest_node *node)
>> +{
>> +	struct acpi_aest_node *anode = node->info;
>> +	u64 errgsr_base = anode->common->error_group_register_base;
>> +
>> +	if (anode->interface_hdr->type != ACPI_AEST_NODE_MEMORY_MAPPED)
>> +		return 0;
>> +
>> +	if (!node->base)
>> +		return 0;
>> +
>> +	if (!(anode->interface_hdr->flags & AEST_XFACE_FLAG_ERROR_GROUP)) {
>> +		node->errgsr = node->base + ERXGROUP;
>> +		return 0;
>> +	}
>> +
>> +	if (!errgsr_base)
>> +		return -EINVAL;
>> +
>> +	node->errgsr = devm_ioremap(adev->dev, errgsr_base, PAGE_SIZE);
>> +	if (!node->errgsr)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +static int aest_init_node(struct aest_device *adev, struct aest_node *node,
>> +					struct acpi_aest_node *anode)
>> +{
>> +	int i, ret;
>> +	u64 address, size, flags;
>> +
>> +	node->adev = adev;
>> +	node->info = anode;
>> +	node->type = anode->type;
>> +	node->version = get_aest_node_ver(node);
>> +	node->name = alloc_aest_node_name(node);
>> +	if (!node->name)
>> +		return -ENOMEM;
>> +	node->record_implemented = anode->record_implemented;
>> +	node->status_reporting = anode->status_reporting;
>> +
>> +	address = anode->interface_hdr->address;
>> +	size = anode->interface_hdr->error_record_count *
>> +						sizeof(struct ras_ext_regs);
>> +	if (address) {
>> +		node->base = devm_ioremap(adev->dev, address, size);
>> +		if (!node->base)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	flags = anode->interface_hdr->flags;
>> +	address = node->info->common->fault_inject_register_base;
>> +	if ((flags & AEST_XFACE_FLAG_FAULT_INJECT) && address) {
>> +		node->inj = devm_ioremap(adev->dev, address, PAGE_SIZE);
>> +		if (!node->inj)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	address = node->info->common->interrupt_config_register_base;
>> +	if ((flags & AEST_XFACE_FLAG_FAULT_INJECT) && address) {
>> +		node->irq_config = devm_ioremap(adev->dev, address, PAGE_SIZE);
>> +		if (!node->irq_config)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	ret = aest_node_set_errgsr(adev, node);
>> +	if (ret)
>> +		return ret;
>> +
>> +	node->record_count = anode->interface_hdr->error_record_count;
>> +	node->records = devm_kcalloc(adev->dev, node->record_count,
>> +				sizeof(struct aest_record), GFP_KERNEL);
>> +	if (!node->records)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < node->record_count; i++) {
>> +		ret = aest_init_record(&node->records[i], i, node);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	aest_node_dbg(node, "%d records, base: %llx, errgsr: %llx\n",
>> +			node->record_count, (u64)node->base, (u64)node->errgsr);
>> +	return 0;
>> +}
>> +
>> +static int
>> +aest_init_nodes(struct aest_device *adev, struct aest_hnode *ahnode)
>> +{
>> +	struct acpi_aest_node *anode;
>> +	struct aest_node *node;
>> +	int ret, i = 0;
>> +
>> +	adev->node_cnt = ahnode->count;
>> +	adev->nodes = devm_kcalloc(adev->dev, adev->node_cnt,
>> +					sizeof(struct aest_node), GFP_KERNEL);
>> +	if (!adev->nodes)
>> +		return -ENOMEM;
>> +
>> +	list_for_each_entry(anode, &ahnode->list, list) {
>> +		adev->type = anode->type;
>> +
>> +		node = &adev->nodes[i++];
>> +		ret = aest_init_node(adev, node, anode);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __setup_ppi(struct aest_device *adev)
>> +{
>> +	int cpu, i;
>> +	struct aest_device *oncore_adev;
>> +	struct aest_node *oncore_node;
>> +	size_t size;
>> +
>> +	adev->adev_oncore = &percpu_adev;
>> +	for_each_possible_cpu(cpu) {
>> +		oncore_adev = per_cpu_ptr(&percpu_adev, cpu);
>> +		memcpy(oncore_adev, adev, sizeof(struct aest_device));
>> +
>> +		oncore_adev->nodes = devm_kcalloc(adev->dev,
>> +						oncore_adev->node_cnt,
>> +						sizeof(struct aest_node),
>> +						GFP_KERNEL);
>> +		if (!oncore_adev->nodes)
>> +			return -ENOMEM;
>> +
>> +		size = adev->node_cnt * sizeof(struct aest_node);
>> +		memcpy(oncore_adev->nodes, adev->nodes, size);
>> +		for (i = 0; i < oncore_adev->node_cnt; i++) {
>> +			oncore_node = &oncore_adev->nodes[i];
>> +			oncore_node->records = devm_kcalloc(adev->dev,
>> +					oncore_node->record_count,
>> +					sizeof(struct aest_record), GFP_KERNEL);
>> +			if (!oncore_node->records)
>> +				return -ENOMEM;
>> +
>> +			size = oncore_node->record_count *
>> +						sizeof(struct aest_record);
>> +			memcpy(oncore_node->records, adev->nodes[i].records,
>> +									size);
>> +		}
>> +
>> +		aest_dev_dbg(adev, "Init device on CPU%d.\n", cpu);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int aest_setup_irq(struct platform_device *pdev, struct aest_device *adev)
>> +{
>> +	int fhi_irq, eri_irq;
>> +
>> +	fhi_irq = platform_get_irq_byname_optional(pdev, "fhi");
>> +	if (fhi_irq > 0)
>> +		adev->irq[0] = fhi_irq;
>> +
>> +	eri_irq = platform_get_irq_byname_optional(pdev, "eri");
>> +	if (eri_irq > 0)
>> +		adev->irq[1] = eri_irq;
>> +
>> +	/* Allocate and initialise the percpu device pointer for PPI */
>> +	if (irq_is_percpu(fhi_irq) || irq_is_percpu(eri_irq))
>> +		return __setup_ppi(adev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int aest_device_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct aest_device *adev;
>> +	struct aest_hnode *ahnode;
>> +
>> +	ahnode = *((struct aest_hnode **)pdev->dev.platform_data);
>> +	if (!ahnode)
>> +		return -ENODEV;
>> +
>> +	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
>> +	if (!adev)
>> +		return -ENOMEM;
>> +
>> +	adev->dev = &pdev->dev;
>> +	INIT_WORK(&adev->aest_work, aest_node_pool_process);
>> +	ret = aest_node_pool_init(adev);
>> +	if (ret) {
>> +		aest_dev_err(adev, "Failed init aest node pool.\n");
>> +		return ret;
>> +	}
>> +	init_llist_head(&adev->event_list);
>> +	adev->uid = ahnode->uid;
>> +	aest_set_name(adev, ahnode);
>> +
>> +	ret = aest_init_nodes(adev, ahnode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = aest_setup_irq(pdev, adev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = aest_register_irq(adev);
>> +	if (ret) {
>> +		aest_dev_err(adev, "register irq failed\n");
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, adev);
>> +
>> +	if (aest_dev_is_oncore(adev))
>> +		ret = cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
>> +				"drivers/acpi/arm64/aest:starting",
>> +				aest_starting_cpu, aest_dying_cpu);
>> +	else
>> +		aest_online_dev(adev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	aest_dev_dbg(adev, "Node cnt: %x, uid: %x, irq: %d, %d\n",
>> +			adev->node_cnt, adev->uid, adev->irq[0], adev->irq[1]);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id acpi_aest_ids[] = {
>> +	{"ARMHE000", 0},
>> +	{}
>> +};
> 
> My understanding is that platform device with name "AEST" is
> created in acpi_aest_alloc_pdev and then the name will be used
> to bind this driver for the dev. So, do we need ACPI HID definition
> here? Using name should work well for both systems with or without
> ARMHE000. Or, am I missing something?
> 
> I have not yet finish to look all parts and will look them and
> other patches too.
> 
> Best Regards,
> Tomohiro Misono

You are right, i will delete these code next version.

Best Regards,
Ruidong

> 
>> +
>> +static struct platform_driver aest_driver = {
>> +	.driver	= {
>> +		.name	= "AEST",
>> +		.acpi_match_table = acpi_aest_ids,
>> +	},
>> +	.probe	= aest_device_probe,
>> +	.remove = aest_device_remove,
>> +};
>> +
>> +static int __init aest_init(void)
>> +{
>> +	return platform_driver_register(&aest_driver);
>> +}
>> +module_init(aest_init);
>> +
>> +static void __exit aest_exit(void)
>> +{
>> +	platform_driver_unregister(&aest_driver);
>> +}
>> +module_exit(aest_exit);
>> +
>> +MODULE_DESCRIPTION("ARM AEST Driver");
>> +MODULE_AUTHOR("Ruidong Tian <tianruidong@linux.alibaba.com>");
>> +MODULE_LICENSE("GPL");
>> +
>> diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
>> new file mode 100644
>> index 000000000000..04005aad3617
>> --- /dev/null
>> +++ b/drivers/ras/aest/aest.h
>> @@ -0,0 +1,323 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * ARM Error Source Table Support
>> + *
>> + * Copyright (c) 2021-2024, Alibaba Group.
>> + */
>> +
>> +#include <linux/acpi_aest.h>
>> +#include <asm/ras.h>
>> +
>> +#define MAX_GSI_PER_NODE 2
>> +#define AEST_MAX_PPI 3
>> +#define DEFAULT_CE_THRESHOLD 1
>> +
>> +#define record_read(record, offset) \
>> +	record->access->read(record->regs_base, offset)
>> +#define record_write(record, offset, val) \
>> +	record->access->write(record->regs_base, offset, val)
>> +
>> +#define aest_dev_err(__adev, format, ...)	\
>> +	dev_err((__adev)->dev, format, ##__VA_ARGS__)
>> +#define aest_dev_info(__adev, format, ...)	\
>> +	dev_info((__adev)->dev, format, ##__VA_ARGS__)
>> +#define aest_dev_dbg(__adev, format, ...)	\
>> +	dev_dbg((__adev)->dev, format, ##__VA_ARGS__)
>> +
>> +#define aest_node_err(__node, format, ...)	\
>> +	dev_err((__node)->adev->dev, "%s: " format, (__node)->name, ##__VA_ARGS__)
>> +#define aest_node_info(__node, format, ...)	\
>> +	dev_info((__node)->adev->dev, "%s: " format, (__node)->name, ##__VA_ARGS__)
>> +#define aest_node_dbg(__node, format, ...)	\
>> +	dev_dbg((__node)->adev->dev, "%s: " format, (__node)->name, ##__VA_ARGS__)
>> +
>> +#define aest_record_err(__record, format, ...)	\
>> +	dev_err((__record)->node->adev->dev, "%s: %s: " format, \
>> +		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
>> +#define aest_record_info(__record, format, ...)	\
>> +	dev_info((__record)->node->adev->dev, "%s: %s: " format, \
>> +		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
>> +#define aest_record_dbg(__record, format, ...)	\
>> +	dev_dbg((__record)->node->adev->dev, "%s: %s: " format, \
>> +		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
>> +
>> +#define ERXFR			0x0
>> +#define ERXCTLR			0x8
>> +#define ERXSTATUS		0x10
>> +#define ERXADDR			0x18
>> +#define ERXMISC0		0x20
>> +#define ERXMISC1		0x28
>> +#define ERXMISC2		0x30
>> +#define ERXMISC3		0x38
>> +
>> +#define ERXGROUP		0xE00
>> +#define GIC_ERRDEVARCH		0xFFBC
>> +
>> +extern struct xarray *aest_array;
>> +
>> +struct aest_event {
>> +	struct llist_node llnode;
>> +	char *node_name;
>> +	u32 type;
>> +	/*
>> +	 * Different nodes have different meanings:
>> +	 *   - Processor node	: processor number.
>> +	 *   - Memory node	: SRAT proximity domain.
>> +	 *   - SMMU node	: IORT proximity domain.
>> +	 *   - GIC node		: interface type.
>> +	 */
>> +	u32 id0;
>> +	/*
>> +	 * Different nodes have different meanings:
>> +	 *   - Processor node	: processor resource type.
>> +	 *   - Memory node	: Non.
>> +	 *   - SMMU node	: subcomponent reference.
>> +	 *   - Vendor node	: Unique ID.
>> +	 *   - GIC node		: instance identifier.
>> +	 */
>> +	u32 id1;
>> +	char *hid;		// Vendor node	: hardware ID.
>> +	u32 index;
>> +	u64 ce_threshold;
>> +	int addressing_mode;
>> +	struct ras_ext_regs regs;
>> +
>> +	void *vendor_data;
>> +	size_t vendor_data_size;
>> +};
>> +
>> +struct aest_access {
>> +	u64 (*read)(void *base, u32 offset);
>> +	void (*write)(void *base, u32 offset, u64 val);
>> +};
>> +
>> +struct ce_threshold_info {
>> +	const u64			max_count;
>> +	const u64			mask;
>> +	const u64			shift;
>> +};
>> +
>> +struct ce_threshold {
>> +	const struct ce_threshold_info	*info;
>> +	u64				count;
>> +	u64				threshold;
>> +	u64				reg_val;
>> +};
>> +
>> +struct aest_record {
>> +	char				*name;
>> +	int				index;
>> +	void __iomem			*regs_base;
>> +
>> +	/*
>> +	 * This bit specifies the addressing mode  to populate the ERR_ADDR
>> +	 * register:
>> +	 *   0b: Error record reports System Physical Addresses (SPA) in
>> +	 *       the ERR_ADDR register.
>> +	 *   1b: Error record reports error node-specific Logical Addresses(LA)
>> +	 *       in the ERR_ADD register. OS must use other means to translate
>> +	 *       the reported LA into SPA
>> +	 */
>> +	int				addressing_mode;
>> +	u64				fr;
>> +	struct aest_node		*node;
>> +
>> +	struct dentry			*debugfs;
>> +	struct ce_threshold		ce;
>> +	enum ras_ce_threshold		threshold_type;
>> +	const struct aest_access	*access;
>> +
>> +	void				*vendor_data;
>> +	size_t				vendor_data_size;
>> +};
>> +
>> +struct aest_node {
>> +	char				*name;
>> +	u8				type;
>> +	void				*errgsr;
>> +	void				*inj;
>> +	void				*irq_config;
>> +	void				*base;
>> +
>> +	/*
>> +	 * This bitmap indicates which of the error records within this error
>> +	 * node must be polled for error status.
>> +	 * Bit[n] of this field pertains to error record corresponding to
>> +	 * index n in this error group.
>> +	 * Bit[n] = 0b: Error record at index n needs to be polled.
>> +	 * Bit[n] = 1b: Error record at index n do not needs to be polled.
>> +	 */
>> +	unsigned long			*record_implemented;
>> +	/*
>> +	 * This bitmap indicates which of the error records within this error
>> +	 * node support error status reporting using ERRGSR register.
>> +	 * Bit[n] of this field pertains to error record corresponding to
>> +	 * index n in this error group.
>> +	 * Bit[n] = 0b: Error record at index n supports error status reporting
>> +	 *              through ERRGSR.S.
>> +	 * Bit[n] = 1b: Error record at index n does not support error reporting
>> +	 *              through the ERRGSR.S bit If this error record is
>> +	 *              implemented, then it must be polled explicitly for
>> +	 *              error events.
>> +	 */
>> +	unsigned long			*status_reporting;
>> +	int				version;
>> +
>> +	struct aest_device		*adev;
>> +	struct acpi_aest_node		*info;
>> +	struct dentry			*debugfs;
>> +
>> +	int				record_count;
>> +	struct aest_record		*records;
>> +
>> +	struct aest_node __percpu	*oncore_node;
>> +};
>> +
>> +struct aest_device {
>> +	struct device			*dev;
>> +	u32				type;
>> +	int				node_cnt;
>> +	struct aest_node		*nodes;
>> +
>> +	struct work_struct		aest_work;
>> +	struct gen_pool			*pool;
>> +	struct llist_head		event_list;
>> +
>> +	int				irq[MAX_GSI_PER_NODE];
>> +	u32				uid;
>> +	struct aest_device __percpu	*adev_oncore;
>> +
>> +	struct dentry			*debugfs;
>> +};
>> +
>> +struct aest_node_context {
>> +	struct aest_node		*node;
>> +	unsigned long			*bitmap;
>> +	void				(*func)(struct aest_record *record,
>> +							void *data);
>> +	void				*data;
>> +	int				ret;
>> +};
>> +
>> +#define CASE_READ(res, x)						\
>> +	case (x): {							\
>> +		res = read_sysreg_s(SYS_##x##_EL1);			\
>> +		break;							\
>> +	}
>> +
>> +#define CASE_WRITE(val, x)						\
>> +	case (x): {							\
>> +		write_sysreg_s((val), SYS_##x##_EL1);			\
>> +		break;							\
>> +	}
>> +
>> +static inline u64 aest_sysreg_read(void *__unused, u32 offset)
>> +{
>> +	u64 res;
>> +
>> +	switch (offset) {
>> +	CASE_READ(res, ERXFR)
>> +	CASE_READ(res, ERXCTLR)
>> +	CASE_READ(res, ERXSTATUS)
>> +	CASE_READ(res, ERXADDR)
>> +	CASE_READ(res, ERXMISC0)
>> +	CASE_READ(res, ERXMISC1)
>> +	CASE_READ(res, ERXMISC2)
>> +	CASE_READ(res, ERXMISC3)
>> +	default :
>> +		res = 0;
>> +	}
>> +	return res;
>> +}
>> +
>> +static inline void aest_sysreg_write(void *base, u32 offset, u64 val)
>> +{
>> +	switch (offset) {
>> +	CASE_WRITE(val, ERXFR)
>> +	CASE_WRITE(val, ERXCTLR)
>> +	CASE_WRITE(val, ERXSTATUS)
>> +	CASE_WRITE(val, ERXADDR)
>> +	CASE_WRITE(val, ERXMISC0)
>> +	CASE_WRITE(val, ERXMISC1)
>> +	CASE_WRITE(val, ERXMISC2)
>> +	CASE_WRITE(val, ERXMISC3)
>> +	default :
>> +		return;
>> +	}
>> +}
>> +
>> +static inline u64 aest_iomem_read(void *base, u32 offset)
>> +{
>> +	return readq_relaxed(base + offset);
>> +	return 0;
>> +}
>> +
>> +static inline void aest_iomem_write(void *base, u32 offset, u64 val)
>> +{
>> +	writeq_relaxed(val, base + offset);
>> +}
>> +
>> +/* access type is decided by AEST interface type. */
>> +static const struct aest_access aest_access[] = {
>> +	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
>> +		.read = aest_sysreg_read,
>> +		.write = aest_sysreg_write,
>> +	},
>> +
>> +	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
>> +		.read = aest_iomem_read,
>> +		.write = aest_iomem_write,
>> +	},
>> +	[ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED] = {
>> +		.read = aest_iomem_read,
>> +		.write = aest_iomem_write,
>> +	},
>> +	{ }
>> +};
>> +
>> +static inline bool aest_dev_is_oncore(struct aest_device *adev)
>> +{
>> +	return adev->type == ACPI_AEST_PROCESSOR_ERROR_NODE;
>> +}
>> +
>> +/*
>> + * Each PE may has multi error record, you must selects an error
>> + * record to be accessed through the Error Record System
>> + * registers.
>> + */
>> +static inline void aest_select_record(struct aest_node *node, int index)
>> +{
>> +	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
>> +		write_sysreg_s(index, SYS_ERRSELR_EL1);
>> +		isb();
>> +	}
>> +}
>> +
>> +/* Ensure all writes has taken effect. */
>> +static inline void aest_sync(struct aest_node *node)
>> +{
>> +	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE)
>> +		isb();
>> +}
>> +
>> +static const char * const aest_node_name[] = {
>> +	[ACPI_AEST_PROCESSOR_ERROR_NODE] = "processor",
>> +	[ACPI_AEST_MEMORY_ERROR_NODE] = "memory",
>> +	[ACPI_AEST_SMMU_ERROR_NODE] = "smmu",
>> +	[ACPI_AEST_VENDOR_ERROR_NODE] = "vendor",
>> +	[ACPI_AEST_GIC_ERROR_NODE] = "gic",
>> +	[ACPI_AEST_PCIE_ERROR_NODE] = "pcie",
>> +	[ACPI_AEST_PROXY_ERROR_NODE] = "proxy",
>> +};
>> +
>> +static inline int
>> +aest_set_name(struct aest_device *adev, struct aest_hnode *ahnode)
>> +{
>> +	adev->dev->init_name = devm_kasprintf(adev->dev, GFP_KERNEL,
>> +					"%s%d", aest_node_name[ahnode->type],
>> +						adev->uid);
>> +	if (!adev->dev->init_name)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
>> new file mode 100644
>> index 000000000000..1c2191791504
>> --- /dev/null
>> +++ b/include/linux/acpi_aest.h
>> @@ -0,0 +1,68 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ACPI_AEST_H__
>> +#define __ACPI_AEST_H__
>> +
>> +#include <linux/acpi.h>
>> +#include <asm/ras.h>
>> +
>> +/* AEST component */
>> +#define ACPI_AEST_PROC_FLAG_GLOBAL	(1<<0)
>> +#define ACPI_AEST_PROC_FLAG_SHARED	(1<<1)
>> +
>> +#define AEST_ADDREESS_SPA	0
>> +#define AEST_ADDREESS_LA	1
>> +
>> +/* AEST interrupt */
>> +#define AEST_INTERRUPT_MODE		BIT(0)
>> +#define AEST_INTERRUPT_FHI_MODE		BIT(1)
>> +
>> +#define AEST_INTERRUPT_FHI_UE_SUPPORT		BIT(0)
>> +#define AEST_INTERRUPT_FHI_UE_NO_SUPPORT		BIT(1)
>> +
>> +#define AEST_MAX_INTERRUPT_PER_NODE 3
>> +
>> +/* AEST interface */
>> +
>> +#define AEST_XFACE_FLAG_SHARED		(1<<0)
>> +#define AEST_XFACE_FLAG_CLEAR_MISC	(1<<1)
>> +#define AEST_XFACE_FLAG_ERROR_DEVICE	(1<<2)
>> +#define AEST_XFACE_FLAG_AFFINITY	(1<<3)
>> +#define AEST_XFACE_FLAG_ERROR_GROUP	(1<<4)
>> +#define AEST_XFACE_FLAG_FAULT_INJECT	(1<<5)
>> +#define AEST_XFACE_FLAG_INT_CONFIG	(1<<6)
>> +
>> +struct aest_hnode {
>> +	struct list_head list;
>> +	int count;
>> +	u32 uid;
>> +	int type;
>> +};
>> +
>> +struct acpi_aest_node {
>> +	struct list_head list;
>> +	int type;
>> +	struct acpi_aest_node_interface_header *interface_hdr;
>> +	unsigned long *record_implemented;
>> +	unsigned long *status_reporting;
>> +	unsigned long *addressing_mode;
>> +	struct acpi_aest_node_interface_common *common;
>> +	union {
>> +		struct acpi_aest_processor *processor;
>> +		struct acpi_aest_memory *memory;
>> +		struct acpi_aest_smmu *smmu;
>> +		struct acpi_aest_vendor_v2 *vendor;
>> +		struct acpi_aest_gic *gic;
>> +		struct acpi_aest_pcie *pcie;
>> +		struct acpi_aest_proxy *proxy;
>> +		void *spec_pointer;
>> +	};
>> +	union {
>> +		struct acpi_aest_processor_cache *cache;
>> +		struct acpi_aest_processor_tlb *tlb;
>> +		struct acpi_aest_processor_generic *generic;
>> +		void *processor_spec_pointer;
>> +	};
>> +	struct acpi_aest_node_interrupt_v2 *interrupt;
>> +	int interrupt_count;
>> +};
>> +#endif /* __ACPI_IORT_H__ */
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index a04b73c40173..acf0e3957fdd 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -179,6 +179,7 @@ enum cpuhp_state {
>>   	CPUHP_AP_CSKY_TIMER_STARTING,
>>   	CPUHP_AP_TI_GP_TIMER_STARTING,
>>   	CPUHP_AP_HYPERV_TIMER_STARTING,
>> +	CPUHP_AP_ARM_AEST_STARTING,
>>   	/* Must be the last timer callback */
>>   	CPUHP_AP_DUMMY_TIMER_STARTING,
>>   	CPUHP_AP_ARM_XEN_STARTING,
>> diff --git a/include/linux/ras.h b/include/linux/ras.h
>> index a64182bc72ad..1c777af6a1af 100644
>> --- a/include/linux/ras.h
>> +++ b/include/linux/ras.h
>> @@ -53,4 +53,12 @@ static inline unsigned long
>>   amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
>>   #endif /* CONFIG_AMD_ATL */
>>
>> +#if IS_ENABLED(CONFIG_AEST)
>> +void aest_register_decode_chain(struct notifier_block *nb);
>> +void aest_unregister_decode_chain(struct notifier_block *nb);
>> +#else
>> +static inline void aest_register_decode_chain(struct notifier_block *nb) {}
>> +static inline void aest_unregister_decode_chain(struct notifier_block *nb) {}
>> +#endif /* CONFIG_AEST */
>> +
>>   #endif /* __RAS_H__ */
>> --
>> 2.33.1
>>

