Return-Path: <linux-acpi+bounces-17893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34173BEB475
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DFDC5041A5
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9429332EB8;
	Fri, 17 Oct 2025 18:51:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00E32E13C;
	Fri, 17 Oct 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727114; cv=none; b=qFXDhIVUfSSL4njOWMfQ07HC00sTwO7ZxmRx+cuyP+JkDgyY5DQ7OaxBgaEx/E86sfRTelD50f2PsDep1b3UXVhlAWMPbDVdM0dpg/Ud1Ib5d0Rp16YyJv0+CV8oGLt4DtCbT4mE+R/vCIKt4Ig+pbVAXeZgao0OLOzsvV1t4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727114; c=relaxed/simple;
	bh=V8cBoV1plZ4laGZz0cYeKzLHihO78szIeYj0YyjbCuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNle8mjjYmCLTaJPuSUd8oFrWeyPf1PLwc+yx6H0079aYK9RYzcFKq8zBc6iU9BzsfOg2pAim3uDNOXChQW9+J5AJZR92dAYsEyDLvQpmSCR1NJnXTFk1KVakRrp1QazP6N2WUFTDoWn8w59Zj8wIpq36e0jSi3JI7bCFDMNJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985FF1515;
	Fri, 17 Oct 2025 11:51:44 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD31D3F66E;
	Fri, 17 Oct 2025 11:51:36 -0700 (PDT)
Message-ID: <f2c77f14-c10a-4074-9cdb-5d725f140983@arm.com>
Date: Fri, 17 Oct 2025 19:51:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
To: Gavin Shan <gshan@redhat.com>, linux-kernel@vger.kernel.org,
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
 <29886bb9-bca3-4f26-ae31-a339b8d001f1@redhat.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <29886bb9-bca3-4f26-ae31-a339b8d001f1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 03/10/2025 04:53, Gavin Shan wrote:
> Hi James,
> 
> On 9/11/25 6:42 AM, James Morse wrote:
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> new file mode 100644
>> index 000000000000..efc4738e3b4d
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_devices.c

>> +/*
>> + * An MSC can control traffic from a set of CPUs, but may only be accessible
>> + * from a (hopefully wider) set of CPUs. The common reason for this is power
>> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
>> + * corresponding cache may also be powered off. By making accesses from
>> + * one of those CPUs, we ensure this isn't the case.
>> + */
>> +static int update_msc_accessibility(struct mpam_msc *msc)
>> +{
>> +    u32 affinity_id;
>> +    int err;
>> +
>> +    err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
>> +                       &affinity_id);
>> +    if (err)
>> +        cpumask_copy(&msc->accessibility, cpu_possible_mask);
>> +    else
>> +        acpi_pptt_get_cpus_from_container(affinity_id,
>> +                          &msc->accessibility);
>> +
>> +    return 0;
>> +
>> +    return err;
>> +}
>> +
> 
> Double return here and different values have been returned. I think here we
> need "return err". In this case, we needn't copy @cpu_possible_mask on error
> because the caller mpam_msc_drv_probe() will release the MSC instance.

This was the botched removal of the DT support. I'm surprised the compiler is so
forgiving. (already pointed out and already fixed)


>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +    int err;
>> +    struct mpam_msc *msc;
>> +    struct resource *msc_res;
>> +    struct device *dev = &pdev->dev;
>> +    void *plat_data = pdev->dev.platform_data;
>> +
>> +    mutex_lock(&mpam_list_lock);
>> +    do {
>> +        msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +        if (!msc) {
>> +            err = -ENOMEM;
>> +            break;
>> +        }
>> +
>> +        mutex_init(&msc->probe_lock);
>> +        mutex_init(&msc->part_sel_lock);
>> +        mutex_init(&msc->outer_mon_sel_lock);
>> +        raw_spin_lock_init(&msc->inner_mon_sel_lock);
>> +        msc->id = pdev->id;
>> +        msc->pdev = pdev;
>> +        INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>> +        INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +        err = update_msc_accessibility(msc);
>> +        if (err)
>> +            break;
>> +        if (cpumask_empty(&msc->accessibility)) {
>> +            dev_err_once(dev, "MSC is not accessible from any CPU!");
>> +            err = -EINVAL;
>> +            break;
>> +        }
>> +
> 
> This check (cpumask_empty()) would be part of update_msc_accessibility() since
> msc->accessibility is sorted out in that function where it should be validated.


Could be - but isn't. This is because with the DT support in update_msc_accessibility()
that function is more complex, and its simpler to get the caller to check things like
this.

Even if no-one ever gets DT support upstream, I don't think this matters.


>> +        if (device_property_read_u32(&pdev->dev, "pcc-channel",
>> +                         &msc->pcc_subspace_id))
>> +            msc->iface = MPAM_IFACE_MMIO;
>> +        else
>> +            msc->iface = MPAM_IFACE_PCC;
>> +
>> +        if (msc->iface == MPAM_IFACE_MMIO) {
>> +            void __iomem *io;
>> +
>> +            io = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +                                    &msc_res);
>> +            if (IS_ERR(io)) {
>> +                dev_err_once(dev, "Failed to map MSC base address\n");
>> +                err = PTR_ERR(io);
>> +                break;
>> +            }
>> +            msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>> +            msc->mapped_hwpage = io;
>> +        }
>> +
>> +        list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
>> +        platform_set_drvdata(pdev, msc);
>> +    } while (0);
>> +    mutex_unlock(&mpam_list_lock);
>> +
>> +    if (!err) {
>> +        /* Create RIS entries described by firmware */
>> +        err = acpi_mpam_parse_resources(msc, plat_data);
>> +    }
>> +
>> +    if (err && msc)
>> +        mpam_msc_drv_remove(pdev);
>> +
>> +    if (!err && atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
>> +        pr_info("Discovered all MSC\n");
>> +
>> +    return err;
>> +}


Thanks,

James

