Return-Path: <linux-acpi+bounces-17528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E518BB5E24
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 05:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF31A4E13FE
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 03:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631271A3154;
	Fri,  3 Oct 2025 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQSj4JOn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0319F111
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759463654; cv=none; b=Evxm3FkjppBbx9iQUvWyB+wdFHjHVC7nl8zp0iZoz51EzrDg51hMBxT+qs6YHIQFdf1Am4kTK6pX/RM/HkxP94yd8WdMeN2pnuvUOuEV08iZWHD1pLF8WItGc9bykLgZL4OcsAEzcD3xlVMiY7lxo9g+yd7+9GtFOnWn0LEsmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759463654; c=relaxed/simple;
	bh=EZ7NfTUUdXyTjkAm+CZQ2pv4s6Ac7oMEMuHb0evI9Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ns5T1h4VIfwsDDXUfXbbGlYCcFOhhhFn6Anw+kmSHY7glA4El1DczWU+KN/o6eu6OdoZuM9LArkCREXMiO/cFqMNDlLzMLdt00MAG4g7ubOyaxziJa0tD9K5yfmKAbulTT7yFDPoy1o9bZUr/yn7ctZxiXL7NBcXkN/eYS/nVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQSj4JOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759463650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqXBGsEvLB/eC0uyHIzRTOrZF87Gi56IDylcMc4Mqyk=;
	b=XQSj4JOnNNbRcsGZa0qtvKguvJEFb9G2/EqTZwJcTSmWB0durlSK5gIjSLrdfVMMN7FgBq
	7/pvGBRUOb+ey3mjlvy4ZNCPp2Y7MvjElJaKdNMUZ+oDYa5is//BbjnYaL4UVHfJvPbnPI
	Ph9uSU7rzPvFiLWoLyhL6joODt1BPNk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-TILpsZZ9NWujPwZj-1mINw-1; Thu, 02 Oct 2025 23:54:08 -0400
X-MC-Unique: TILpsZZ9NWujPwZj-1mINw-1
X-Mimecast-MFC-AGG-ID: TILpsZZ9NWujPwZj-1mINw_1759463648
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5529da7771so1187589a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 20:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759463648; x=1760068448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqXBGsEvLB/eC0uyHIzRTOrZF87Gi56IDylcMc4Mqyk=;
        b=Th45S4k0lkG96lLIWZ2s/Tx0EWtRKFh6xnIluC/Y4l44ku5oTsxeDEfXyWLQt+EAgv
         sVynJZu0M8efnIjJ2NcDvTjjprjS39VlfLkU9Vntm/JzOJkwn7QXLOfQil7l2HAgn29X
         jnPDC+wGyljarT7Lf2sEMIGfn/BjQjEbUn/ntB6pLN2dJ0HuEvaJQBA1P9PDIPTWIEnb
         rwHHtjdbMHyvDDkXIMhsaHnxPPmkDMA3yH9BqD7dhvOgcwlIUyceyDVmNKXo3H8Xt2uP
         Uryp8OiLL8kkwUpeEgKcEU+VjR0SLS+4sofYogHLoDPWKqt5qDr4FrtFdJZPUaUqbx0D
         1rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYwSj4R/hdmtBOv1QOOsj9HFOMPq9E07HF46cgHLeIoiU5vCKdQHyGqg51POgXmRhXIHfnPwfcEKxq@vger.kernel.org
X-Gm-Message-State: AOJu0YzxP1fni2cV0NqNxL6Xj2NBvr5+AnlShwKRw8x+A3KrOtX147Th
	yJXBjHKg4DsPle24OHiyHaKD0QzgJp/nnDfsrxTGjPbciguHAyL+XV0WVj24FRm7+wGQcHxI4qA
	43ExNnnogOrNuTBXA98mEN9ZK8AnpoM9NkhHvbJ1qPkF2jYSRRFNCIPSr3qpJ4mE=
X-Gm-Gg: ASbGncs27sgVo1t/jlyI+LaMlKRDWdiYQ80OkdPWMyq40RhMBcGzsQWujjH6Fst8r22
	xOvj5cJDr3JRatClg6DxUeAu3xXKUfOUvBDtwIsWUo10TnSONnQjiGSDhScVXRU6VjnipmLSD8o
	Wm2VaoHp0UGCrXSexvXL8lSvhxnVrhrqRM8aOLV/gtKfnmCnrlC5CImS9zCe0+A7utNoADmspXS
	gy9d/pBuZKI/ldTiKeOKxj01UUz9tgo3EngRMRK+/pKcztWuv6NWGNcpQlvsXYw8cIWp94Ke/3A
	MgwFzi/KneLsAPAi06BGZXciRnHgKnwhk0FJkYJXx24drc4E5kkokj2U2tgiz+dH7vMv1pahPAO
	qLPOV+3jyvQ==
X-Received: by 2002:a05:6a21:32a8:b0:2fd:a3b:933d with SMTP id adf61e73a8af0-32b6212a95amr2324643637.58.1759463647698;
        Thu, 02 Oct 2025 20:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO1eVNkhxjeEpcrSCvF3IK8zgy7mUiMHjQ5jYBycjzCT0xV0FuBp/gmh5QAf2pAUHLGCkC3w==
X-Received: by 2002:a05:6a21:32a8:b0:2fd:a3b:933d with SMTP id adf61e73a8af0-32b6212a95amr2324606637.58.1759463647199;
        Thu, 02 Oct 2025 20:54:07 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099add290sm3271259a12.6.2025.10.02.20.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 20:54:06 -0700 (PDT)
Message-ID: <29886bb9-bca3-4f26-ae31-a339b8d001f1@redhat.com>
Date: Fri, 3 Oct 2025 13:53:54 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/29] arm_mpam: Add probe/remove for mpam msc driver
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-8-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/11/25 6:42 AM, James Morse wrote:
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> only be accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until
> the system-wide common values for num_partid and num_pmg have been
> discovered.
> 
> Start with driver probe/remove and mapping the MSC.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Avoid selecting driver on other architectrues.
>   * Removed PCC support stub.
>   * Use for_each_available_child_of_node_scoped() and of_property_read_reg()
>   * Clarified a comment.
>   * Stopped using mpam_num_msc as an id,a and made it atomic.
>   * Size of -1 returned from cache_of_calculate_id()
>   * Renamed some struct members.
>   * Made a bunch of pr_err() dev_err_ocne().
>   * Used more cleanup magic.
>   * Inlined a print message.
>   * Fixed error propagation from mpam_dt_parse_resources().
>   * Moved cache accessibility checks earlier.
> 
> Changes since RFC:
>   * Check for status=broken DT devices.
>   * Moved all the files around.
>   * Made Kconfig symbols depend on EXPERT
> ---
>   arch/arm64/Kconfig              |   1 +
>   drivers/Kconfig                 |   2 +
>   drivers/Makefile                |   1 +
>   drivers/resctrl/Kconfig         |  14 +++
>   drivers/resctrl/Makefile        |   4 +
>   drivers/resctrl/mpam_devices.c  | 180 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  65 ++++++++++++
>   7 files changed, 267 insertions(+)
>   create mode 100644 drivers/resctrl/Kconfig
>   create mode 100644 drivers/resctrl/Makefile
>   create mode 100644 drivers/resctrl/mpam_devices.c
>   create mode 100644 drivers/resctrl/mpam_internal.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6487c511bdc6..93e563e1cce4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>   
>   config ARM64_MPAM
>   	bool "Enable support for MPAM"
> +	select ARM64_MPAM_DRIVER if EXPERT
>   	select ACPI_MPAM if ACPI
>   	help
>   	  Memory System Resource Partitioning and Monitoring (MPAM) is an
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 4915a63866b0..3054b50a2f4c 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
>   
>   source "drivers/cdx/Kconfig"
>   
> +source "drivers/resctrl/Kconfig"
> +
>   endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index b5749cf67044..f41cf4eddeba 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -194,5 +194,6 @@ obj-$(CONFIG_HTE)		+= hte/
>   obj-$(CONFIG_DRM_ACCEL)		+= accel/
>   obj-$(CONFIG_CDX_BUS)		+= cdx/
>   obj-$(CONFIG_DPLL)		+= dpll/
> +obj-y				+= resctrl/
>   
>   obj-$(CONFIG_S390)		+= s390/
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> new file mode 100644
> index 000000000000..c30532a3a3a4
> --- /dev/null
> +++ b/drivers/resctrl/Kconfig
> @@ -0,0 +1,14 @@
> +menuconfig ARM64_MPAM_DRIVER
> +	bool "MPAM driver"
> +	depends on ARM64 && ARM64_MPAM && EXPERT
> +	help
> +	  MPAM driver for System IP, e,g. caches and memory controllers.
> +
> +if ARM64_MPAM_DRIVER
> +config ARM64_MPAM_DRIVER_DEBUG
> +	bool "Enable debug messages from the MPAM driver"
> +	depends on ARM64_MPAM_DRIVER
> +	help
> +	  Say yes here to enable debug messages from the MPAM driver.
> +
> +endif
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> new file mode 100644
> index 000000000000..92b48fa20108
> --- /dev/null
> +++ b/drivers/resctrl/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
> +mpam-y						+= mpam_devices.o
> +
> +cflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> new file mode 100644
> index 000000000000..efc4738e3b4d
> --- /dev/null
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +
> +#include "mpam_internal.h"
> +
> +/*
> + * mpam_list_lock protects the SRCU lists when writing. Once the
> + * mpam_enabled key is enabled these lists are read-only,
> + * unless the error interrupt disables the driver.
> + */
> +static DEFINE_MUTEX(mpam_list_lock);
> +static LIST_HEAD(mpam_all_msc);
> +
> +static struct srcu_struct mpam_srcu;
> +
> +/*
> + * Number of MSCs that have been probed. Once all MSC have been probed MPAM
> + * can be enabled.
> + */
> +static atomic_t mpam_num_msc;
> +
> +/*
> + * An MSC can control traffic from a set of CPUs, but may only be accessible
> + * from a (hopefully wider) set of CPUs. The common reason for this is power
> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
> + * corresponding cache may also be powered off. By making accesses from
> + * one of those CPUs, we ensure this isn't the case.
> + */
> +static int update_msc_accessibility(struct mpam_msc *msc)
> +{
> +	u32 affinity_id;
> +	int err;
> +
> +	err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
> +				       &affinity_id);
> +	if (err)
> +		cpumask_copy(&msc->accessibility, cpu_possible_mask);
> +	else
> +		acpi_pptt_get_cpus_from_container(affinity_id,
> +						  &msc->accessibility);
> +
> +	return 0;
> +
> +	return err;
> +}
> +

Double return here and different values have been returned. I think here we
need "return err". In this case, we needn't copy @cpu_possible_mask on error
because the caller mpam_msc_drv_probe() will release the MSC instance.

> +static int fw_num_msc;
> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{
> +	struct mpam_msc *msc = platform_get_drvdata(pdev);
> +
> +	if (!msc)
> +		return;
> +
> +	mutex_lock(&mpam_list_lock);
> +	platform_set_drvdata(pdev, NULL);
> +	list_del_rcu(&msc->all_msc_list);
> +	synchronize_srcu(&mpam_srcu);
> +	mutex_unlock(&mpam_list_lock);
> +}
> +
> +static int mpam_msc_drv_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct mpam_msc *msc;
> +	struct resource *msc_res;
> +	struct device *dev = &pdev->dev;
> +	void *plat_data = pdev->dev.platform_data;
> +
> +	mutex_lock(&mpam_list_lock);
> +	do {
> +		msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
> +		if (!msc) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		mutex_init(&msc->probe_lock);
> +		mutex_init(&msc->part_sel_lock);
> +		mutex_init(&msc->outer_mon_sel_lock);
> +		raw_spin_lock_init(&msc->inner_mon_sel_lock);
> +		msc->id = pdev->id;
> +		msc->pdev = pdev;
> +		INIT_LIST_HEAD_RCU(&msc->all_msc_list);
> +		INIT_LIST_HEAD_RCU(&msc->ris);
> +
> +		err = update_msc_accessibility(msc);
> +		if (err)
> +			break;
> +		if (cpumask_empty(&msc->accessibility)) {
> +			dev_err_once(dev, "MSC is not accessible from any CPU!");
> +			err = -EINVAL;
> +			break;
> +		}
> +

This check (cpumask_empty()) would be part of update_msc_accessibility() since
msc->accessibility is sorted out in that function where it should be validated.

> +		if (device_property_read_u32(&pdev->dev, "pcc-channel",
> +					     &msc->pcc_subspace_id))
> +			msc->iface = MPAM_IFACE_MMIO;
> +		else
> +			msc->iface = MPAM_IFACE_PCC;
> +
> +		if (msc->iface == MPAM_IFACE_MMIO) {
> +			void __iomem *io;
> +
> +			io = devm_platform_get_and_ioremap_resource(pdev, 0,
> +								    &msc_res);
> +			if (IS_ERR(io)) {
> +				dev_err_once(dev, "Failed to map MSC base address\n");
> +				err = PTR_ERR(io);
> +				break;
> +			}
> +			msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
> +			msc->mapped_hwpage = io;
> +		}
> +
> +		list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
> +		platform_set_drvdata(pdev, msc);
> +	} while (0);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	if (!err) {
> +		/* Create RIS entries described by firmware */
> +		err = acpi_mpam_parse_resources(msc, plat_data);
> +	}
> +
> +	if (err && msc)
> +		mpam_msc_drv_remove(pdev);
> +
> +	if (!err && atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
> +		pr_info("Discovered all MSC\n");
> +
> +	return err;
> +}
> +
> +static struct platform_driver mpam_msc_driver = {
> +	.driver = {
> +		.name = "mpam_msc",
> +	},
> +	.probe = mpam_msc_drv_probe,
> +	.remove = mpam_msc_drv_remove,
> +};
> +
> +static int __init mpam_msc_driver_init(void)
> +{
> +	if (!system_supports_mpam())
> +		return -EOPNOTSUPP;
> +
> +	init_srcu_struct(&mpam_srcu);
> +
> +	fw_num_msc = acpi_mpam_count_msc();
> +
> +	if (fw_num_msc <= 0) {
> +		pr_err("No MSC devices found in firmware\n");
> +		return -EINVAL;
> +	}
> +
> +	return platform_driver_register(&mpam_msc_driver);
> +}
> +subsys_initcall(mpam_msc_driver_init);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> new file mode 100644
> index 000000000000..7c63d590fc98
> --- /dev/null
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2025 Arm Ltd.
> +
> +#ifndef MPAM_INTERNAL_H
> +#define MPAM_INTERNAL_H
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cpumask.h>
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/resctrl.h>
> +#include <linux/sizes.h>
> +
> +struct mpam_msc {
> +	/* member of mpam_all_msc */
> +	struct list_head        all_msc_list;
> +
> +	int			id;
> +	struct platform_device *pdev;
> +
> +	/* Not modified after mpam_is_enabled() becomes true */
> +	enum mpam_msc_iface	iface;
> +	u32			pcc_subspace_id;
> +	struct mbox_client	pcc_cl;
> +	struct pcc_mbox_chan	*pcc_chan;
> +	u32			nrdy_usec;
> +	cpumask_t		accessibility;
> +
> +	/*
> +	 * probe_lock is only taken during discovery. After discovery these
> +	 * properties become read-only and the lists are protected by SRCU.
> +	 */
> +	struct mutex		probe_lock;
> +	unsigned long		ris_idxs;
> +	u32			ris_max;
> +
> +	/* mpam_msc_ris of this component */
> +	struct list_head	ris;
> +
> +	/*
> +	 * part_sel_lock protects access to the MSC hardware registers that are
> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
> +	 * by RIS).
> +	 * If needed, take msc->probe_lock first.
> +	 */
> +	struct mutex		part_sel_lock;
> +
> +	/*
> +	 * mon_sel_lock protects access to the MSC hardware registers that are
> +	 * affected by MPAMCFG_MON_SEL.
> +	 * If needed, take msc->probe_lock first.
> +	 */
> +	struct mutex		outer_mon_sel_lock;
> +	raw_spinlock_t		inner_mon_sel_lock;
> +	unsigned long		inner_mon_sel_flags;
> +
> +	void __iomem		*mapped_hwpage;
> +	size_t			mapped_hwpage_sz;
> +};
> +
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
> +				   cpumask_t *affinity);
> +
> +#endif /* MPAM_INTERNAL_H */

Thanks,
Gavin


