Return-Path: <linux-acpi+bounces-18008-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CDBF22E8
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 848F434DCF0
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAC526F2BB;
	Mon, 20 Oct 2025 15:45:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E9C26CE07;
	Mon, 20 Oct 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975102; cv=none; b=aJAO4N+xkysv/sYTHGTdjWM+3SJezK9a+2n9e7yD8s1bM5sRoiIo+JJvfaxvfv7cvMRSpGZjM6tA4McC+W7CocE1CL9V9vE276Dj7ApvZECRL7IVskxeN2pCqH7s80aHOnePdbdkFuo1k5dWro5dqfrJQx1RHkw7KMc66sNWhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975102; c=relaxed/simple;
	bh=voD0On4zBw2oN5+HZfXccXNNIrl1M1fB5bmFjN9Eipk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbcsXut1Zsq7yTJm88NqO8bC1gBDQq6na2PUsHJI6xL18GQuNfQqTHBkFsNUtqaBoAMKv/hqNXnKsziXCjK+NyFTNRv23Y0Aoyt94ffRs7OWIZBsogRT/Y3KJzrDkKn/6EzNxxnuRrDNVmyhg3lqcNH2PHPyrsj2OFa+71EIsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E8C1063;
	Mon, 20 Oct 2025 08:44:51 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E4B3F66E;
	Mon, 20 Oct 2025 08:44:54 -0700 (PDT)
Message-ID: <40dd0187-230b-470c-a875-c324df1dedce@arm.com>
Date: Mon, 20 Oct 2025 16:44:53 +0100
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
[snip]
> +static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	u32 tmp;
> +	struct mpam_msc *msc;
> +	struct resource *msc_res;
> +	struct device *dev = &pdev->dev;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
> +	if (!msc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&msc->probe_lock);
> +	mutex_init(&msc->part_sel_lock);
> +	msc->id = pdev->id;
> +	msc->pdev = pdev;
> +	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
> +	INIT_LIST_HEAD_RCU(&msc->ris);
> +
> +	err = update_msc_accessibility(msc);
> +	if (err)
> +		return ERR_PTR(err);
> +	if (cpumask_empty(&msc->accessibility)) {
> +		dev_err_once(dev, "MSC is not accessible from any CPU!");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
> +		msc->iface = MPAM_IFACE_MMIO;
> +	else
> +		msc->iface = MPAM_IFACE_PCC;

As there is no PCC support in this series should this return
ERR_PTR(-ENOTSUPP) when the firmware doesn't advertise a MMIO interface?

> +
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		void __iomem *io;
> +
> +		io = devm_platform_get_and_ioremap_resource(pdev, 0,
> +							    &msc_res);
> +		if (IS_ERR(io)) {
> +			dev_err_once(dev, "Failed to map MSC base address\n");
> +			return (void *)io;
> +		}
> +		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
> +		msc->mapped_hwpage = io;
> +	}
> +
> +	list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
> +	platform_set_drvdata(pdev, msc);
> +
> +	return msc;
> +}
> +
> +static int mpam_msc_drv_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct mpam_msc *msc = NULL;
> +	void *plat_data = pdev->dev.platform_data;
> +
> +	mutex_lock(&mpam_list_lock);
> +	msc = do_mpam_msc_drv_probe(pdev);
> +	mutex_unlock(&mpam_list_lock);
> +	if (!IS_ERR(msc)) {
> +		/* Create RIS entries described by firmware */
> +		err = acpi_mpam_parse_resources(msc, plat_data);
> +		if (err)
> +			mpam_msc_drv_remove(pdev);
> +	} else {
> +		err = PTR_ERR(msc);
> +	}
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
-- 
Thanks,

Ben


