Return-Path: <linux-acpi+bounces-18747-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B92FC48371
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 739194EE5A8
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C762777FE;
	Mon, 10 Nov 2025 16:58:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16927F16C;
	Mon, 10 Nov 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793930; cv=none; b=sA9v7MCcW8d65tMZOHA4sMyiwc3cSXkkar0OAzQOnAkDVxRCrvElANKacCtt+hFQAupSAuTfDYQ8PB1G2W84ac7NPmqBTFJRPjm9M8Tf6bV2x6wB8hpN59MPFodGu03pkJgpYRsgkKYGFtARWpVHTQWne6pyuvv3CZ3setI06Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793930; c=relaxed/simple;
	bh=jDSqj7OfDDuOHrjiACSbhLSgExddbhcVVErPpkIOCQ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Of2PAkjZ2h5MXIg945sa2NV97zhzdJJ/8XTEgj09OOsLxyMq57QwYYiPSEp4eiz6uLb+3DBxYBPGZ6DqQ6U5OutpBrGluxMXnHC+QocTIE9Ix2l6jj2r0Xf5Rz7jG8+pMa7aFDihlLr6u63Jvfv7VDuU+UQ/b5/wtXFf79N/3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4wpr66H6zHnGfQ;
	Tue, 11 Nov 2025 00:58:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 512161402F5;
	Tue, 11 Nov 2025 00:58:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 16:58:42 +0000
Date: Mon, 10 Nov 2025 16:58:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
Message-ID: <20251110165841.00005a74@huawei.com>
In-Reply-To: <20251107123450.664001-11-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-11-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 7 Nov 2025 12:34:27 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
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
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Hi Ben,

A few minor things from a fresh read.
Nothing to prevent a tag though.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> new file mode 100644
> index 000000000000..6c6be133d73a
> --- /dev/null
> +++ b/drivers/resctrl/mpam_devices.c


> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{
> +	struct mpam_msc *msc = platform_get_drvdata(pdev);
> +
> +	if (!msc)
> +		return;

Agree with Gavin on this. If there is a reason this might be NULL
then a comment would avoid the question being raised again. If not
drop the check.

> +
> +	mutex_lock(&mpam_list_lock);
> +	mpam_msc_destroy(msc);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	synchronize_srcu(&mpam_srcu);

Trivial but perhaps a comment on why. I assume this is because the
devm_ cleanup isn't safe until after an RCU grace period?

> +}
> +
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
> +	err = devm_mutex_init(dev, &msc->probe_lock);
> +	if (err)
> +		return ERR_PTR(err);

Trivial but I'd add a blank line here.

> +	err = devm_mutex_init(dev, &msc->part_sel_lock);
> +	if (err)
> +		return ERR_PTR(err);

Trivial but I'd add a blank line here.

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
> +
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		void __iomem *io;
> +
> +		io = devm_platform_get_and_ioremap_resource(pdev, 0,
> +							    &msc_res);
> +		if (IS_ERR(io)) {
> +			dev_err_once(dev, "Failed to map MSC base address\n");
> +			return ERR_CAST(io);
> +		}
> +		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
> +		msc->mapped_hwpage = io;
> +	} else {
> +		return ERR_PTR(-ENOENT);
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

Seems convoluted. Not obvious to me why you can't do early exits on err and
having simpler flow. Maybe something more messy happens in patches after this
series to justify the complex approach.

	if (IS_ERR(msc))
		return PTR_ERR(msc);

	/* Create RIS entries described by firmware */
	err = acpi_mpam_parse_resources(msc, plat_data);
	if (err) {
		mpam_msc_drv_remove(pdev);
		return err;
	}

	if (atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
		pr_info("Discovered all MSC\n");

	return 0;

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

Trivial but I'd drop this blank line to keep the call closely
associated with the error check.

> +	if (fw_num_msc <= 0) {
> +		pr_err("No MSC devices found in firmware\n");
> +		return -EINVAL;
> +	}
> +
> +	return platform_driver_register(&mpam_msc_driver);
> +}
> +subsys_initcall(mpam_msc_driver_init);



