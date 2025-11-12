Return-Path: <linux-acpi+bounces-18812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDAAC5376F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51DC6507F43
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEC33FE33;
	Wed, 12 Nov 2025 16:05:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65527E7EC;
	Wed, 12 Nov 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963549; cv=none; b=TmL8zmRQ/gJ+3bGqjiBZK0dROnEHs/bqHNXDF0HzRTnh7Tk+1A26y6Sjao58V9WgRYc5BC+gcBTnOa+4ST58fk/hlS0ZclLOaDIehdy2y5mTF8/1QfpwnbSGcQwiAhWnzpXCn0E/wEO4j6vn0CHrWjKvuDrgZMAPFGV9gH+XgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963549; c=relaxed/simple;
	bh=K+/c8uCgTek1O3oZ8H4m0tzhea9uEHk0lzxGvXnkchM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbJg+faPr87AdCrwr3qSRhxO6ChTK0JukquJUotqBX1TAXSYIqj1MBDLM+q1em/bCltfE7SHkbhp8lrIBLrE8fjaCktG+IUmf99015/a3KkBg+V1+PS4EsOB8/OyXNl1IRj5CIEtmSJlNN38zhJgjj58DkIQd78TEMlmvANIGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D762B;
	Wed, 12 Nov 2025 08:05:38 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647CF3F63F;
	Wed, 12 Nov 2025 08:05:41 -0800 (PST)
Message-ID: <2189df41-ca50-4e10-a65c-4c297f9dc63b@arm.com>
Date: Wed, 12 Nov 2025 16:05:40 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-11-ben.horgan@arm.com>
 <20251110165841.00005a74@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251110165841.00005a74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/10/25 16:58, Jonathan Cameron wrote:
> On Fri, 7 Nov 2025 12:34:27 +0000
> Ben Horgan <ben.horgan@arm.com> wrote:
> 
>> From: James Morse <james.morse@arm.com>
>>
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.
>>
>> CC: Carl Worth <carl@os.amperecomputing.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> 
> Hi Ben,
> 
> A few minor things from a fresh read.
> Nothing to prevent a tag though.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!

> 
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> new file mode 100644
>> index 000000000000..6c6be133d73a
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_devices.c
> 
> 
>> +
>> +static void mpam_msc_drv_remove(struct platform_device *pdev)
>> +{
>> +	struct mpam_msc *msc = platform_get_drvdata(pdev);
>> +
>> +	if (!msc)
>> +		return;
> 
> Agree with Gavin on this. If there is a reason this might be NULL
> then a comment would avoid the question being raised again. If not
> drop the check.

Dropped.

> 
>> +
>> +	mutex_lock(&mpam_list_lock);
>> +	mpam_msc_destroy(msc);
>> +	mutex_unlock(&mpam_list_lock);
>> +
>> +	synchronize_srcu(&mpam_srcu);
> 
> Trivial but perhaps a comment on why. I assume this is because the
> devm_ cleanup isn't safe until after an RCU grace period?

This becomes clearer in the next patch where it is moved into
mpam_free_garbage() so I'll leave this bare.

> 
>> +}
>> +
>> +static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +	int err;
>> +	u32 tmp;
>> +	struct mpam_msc *msc;
>> +	struct resource *msc_res;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +	if (!msc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	err = devm_mutex_init(dev, &msc->probe_lock);
>> +	if (err)
>> +		return ERR_PTR(err);
> 
> Trivial but I'd add a blank line here.

done

> 
>> +	err = devm_mutex_init(dev, &msc->part_sel_lock);
>> +	if (err)
>> +		return ERR_PTR(err);
> 
> Trivial but I'd add a blank line here.

done

> 
>> +	msc->id = pdev->id;
>> +	msc->pdev = pdev;
>> +	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>> +	INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +	err = update_msc_accessibility(msc);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +	if (cpumask_empty(&msc->accessibility)) {
>> +		dev_err_once(dev, "MSC is not accessible from any CPU!");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
>> +		msc->iface = MPAM_IFACE_MMIO;
>> +	else
>> +		msc->iface = MPAM_IFACE_PCC;
>> +
>> +	if (msc->iface == MPAM_IFACE_MMIO) {
>> +		void __iomem *io;
>> +
>> +		io = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +							    &msc_res);
>> +		if (IS_ERR(io)) {
>> +			dev_err_once(dev, "Failed to map MSC base address\n");
>> +			return ERR_CAST(io);
>> +		}
>> +		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>> +		msc->mapped_hwpage = io;
>> +	} else {
>> +		return ERR_PTR(-ENOENT);
>> +	}
>> +
>> +	list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
>> +	platform_set_drvdata(pdev, msc);
>> +
>> +	return msc;
>> +}
>> +
>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +	int err;
>> +	struct mpam_msc *msc = NULL;
>> +	void *plat_data = pdev->dev.platform_data;
>> +
>> +	mutex_lock(&mpam_list_lock);
>> +	msc = do_mpam_msc_drv_probe(pdev);
>> +	mutex_unlock(&mpam_list_lock);
>> +	if (!IS_ERR(msc)) {
>> +		/* Create RIS entries described by firmware */
>> +		err = acpi_mpam_parse_resources(msc, plat_data);
>> +		if (err)
>> +			mpam_msc_drv_remove(pdev);
>> +	} else {
>> +		err = PTR_ERR(msc);
>> +	}
> 
> Seems convoluted. Not obvious to me why you can't do early exits on err and
> having simpler flow. Maybe something more messy happens in patches after this
> series to justify the complex approach.
> 
> 	if (IS_ERR(msc))
> 		return PTR_ERR(msc);
> 
> 	/* Create RIS entries described by firmware */
> 	err = acpi_mpam_parse_resources(msc, plat_data);
> 	if (err) {
> 		mpam_msc_drv_remove(pdev);
> 		return err;
> 	}
> 
> 	if (atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
> 		pr_info("Discovered all MSC\n");
> 
> 	return 0;

It's still like this at the end of the current mpam snapshot branch so
I'll simplify based on your suggestion.

> 
>> +
>> +	if (!err && atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
>> +		pr_info("Discovered all MSC\n");
>> +
>> +	return err;
>> +}
>> +
>> +static struct platform_driver mpam_msc_driver = {
>> +	.driver = {
>> +		.name = "mpam_msc",
>> +	},
>> +	.probe = mpam_msc_drv_probe,
>> +	.remove = mpam_msc_drv_remove,
>> +};
>> +
>> +static int __init mpam_msc_driver_init(void)
>> +{
>> +	if (!system_supports_mpam())
>> +		return -EOPNOTSUPP;
>> +
>> +	init_srcu_struct(&mpam_srcu);
>> +
>> +	fw_num_msc = acpi_mpam_count_msc();
>> +
> 
> Trivial but I'd drop this blank line to keep the call closely
> associated with the error check.

done

> 
>> +	if (fw_num_msc <= 0) {
>> +		pr_err("No MSC devices found in firmware\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return platform_driver_register(&mpam_msc_driver);
>> +}
>> +subsys_initcall(mpam_msc_driver_init);
> 
> 

Thanks,

Ben


