Return-Path: <linux-acpi+bounces-16425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0589EB46298
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B026CA61ACB
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A580278779;
	Fri,  5 Sep 2025 18:48:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A484277017;
	Fri,  5 Sep 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098122; cv=none; b=KXWGcs4MNJrLK0xRfzOnDND9/I+ocfQ88gUHeUII8Sx8YjDPYjKfRwd7lILcu8fbf1THNZ7GZFAfADGOHLKAF6GpwhOqls+R2EKwocMVAkSQYJa5M7DNdfDqT19yE1QmKGx8F4Gc7STU0aAh2MWfIn8UzHFUuyFHvvIlHkI1ils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098122; c=relaxed/simple;
	bh=7UqTyz8zP8i8yfRiTBv/BTxviF7lQMms4rKZ92n/Ydc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tvs1WT3iUbf8cItcHbFEMQ+KdbP9H0vTsNqgBxjvSmFCZ+6UckiBsdvEJmQM5xmgKdM/g7AwTdDznbaXV2+cSo515xyE+AQyGOgG1mNdui5jP+0wfMTYAhPx5FE9UldiYQ95NNYOsu4tcQ3oqcuHptHzowxhjNtG3lWRs3q4tmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17137152B;
	Fri,  5 Sep 2025 11:48:31 -0700 (PDT)
Received: from [10.1.197.69] (unknown [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C6113F63F;
	Fri,  5 Sep 2025 11:48:33 -0700 (PDT)
Message-ID: <c129a5ca-066b-4a78-a1fe-be474b592022@arm.com>
Date: Fri, 5 Sep 2025 19:48:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-11-james.morse@arm.com>
 <120b4049-a28d-40ad-9def-c901e12c7a68@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <120b4049-a28d-40ad-9def-c901e12c7a68@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 27/08/2025 14:03, Ben Horgan wrote:
> On 8/22/25 16:29, James Morse wrote:
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> new file mode 100644
>> index 000000000000..a0d9a699a6e7
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -0,0 +1,336 @@

>> +static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_node *np,
>> +				  u32 ris_idx)
>> +{
>> +	int err = 0;
>> +	u32 level = 0;
>> +	unsigned long cache_id;
>> +	struct device_node *cache;
>> +
>> +	do {
>> +		if (of_device_is_compatible(np, "arm,mpam-cache")) {
>> +			cache = of_parse_phandle(np, "arm,mpam-device", 0);
>> +			if (!cache) {
>> +				pr_err("Failed to read phandle\n");
>> +				break;
>> +			}
> This looks like this allows "arm,mpam-cache" and "arm,mpam-device" to be
> used on an msc node when there are no ris children. This usage could be
> reasonable but doesn't match the schema in the previous patch. Should
> this usage be rejected or the schema extended?

The DT/ACPI stuff is only going to describe the things that make sense at a high level,
e.g. the controls for the L3. There may be other controls for stuff that doesn't make
sense in the hardware - these get discovered, grouped as 'unknown' and left alone.

Another angle on this is where there is an MSC that the OS will never make use of, but
needs to know about to find the system wide minimum value. (there is a comment about
this in the ACPI spec...)

I don't think its a problem if the magic dt-binding machinery is overly restrictive, that
is about validating DTB files...


>> +		} else if (of_device_is_compatible(np->parent, "cache")) {
>> +			cache = of_node_get(np->parent);
>> +		} else {
>> +			/* For now, only caches are supported */
>> +			cache = NULL;
>> +			break;
>> +		}
>> +
>> +		err = of_property_read_u32(cache, "cache-level", &level);
>> +		if (err) {
>> +			pr_err("Failed to read cache-level\n");
>> +			break;
>> +		}
>> +
>> +		cache_id = cache_of_calculate_id(cache);
>> +		if (cache_id == ~0UL) {
>> +			err = -ENOENT;
>> +			break;
>> +		}
>> +
>> +		err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
>> +				      cache_id);
>> +	} while (0);
>> +	of_node_put(cache);
>> +
>> +	return err;
>> +}

>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +	int err;
>> +	struct mpam_msc *msc;
>> +	struct resource *msc_res;
>> +	void *plat_data = pdev->dev.platform_data;
>> +
>> +	mutex_lock(&mpam_list_lock);
>> +	do {
>> +		msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +		if (!msc) {
>> +			err = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		mutex_init(&msc->probe_lock);
>> +		mutex_init(&msc->part_sel_lock);
>> +		mutex_init(&msc->outer_mon_sel_lock);
>> +		raw_spin_lock_init(&msc->inner_mon_sel_lock);
>> +		msc->id = mpam_num_msc++;
>> +		msc->pdev = pdev;
>> +		INIT_LIST_HEAD_RCU(&msc->glbl_list);
>> +		INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +		err = update_msc_accessibility(msc);
>> +		if (err)
>> +			break;
>> +		if (cpumask_empty(&msc->accessibility)) {
>> +			pr_err_once("msc:%u is not accessible from any CPU!",
>> +				    msc->id);
>> +			err = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		if (device_property_read_u32(&pdev->dev, "pcc-channel",
>> +					     &msc->pcc_subspace_id))
>> +			msc->iface = MPAM_IFACE_MMIO;
>> +		else
>> +			msc->iface = MPAM_IFACE_PCC;
>> +
>> +		if (msc->iface == MPAM_IFACE_MMIO) {
>> +			void __iomem *io;
>> +
>> +			io = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +								    &msc_res);
>> +			if (IS_ERR(io)) {
>> +				pr_err("Failed to map MSC base address\n");
>> +				err = PTR_ERR(io);
>> +				break;
>> +			}
>> +			msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>> +			msc->mapped_hwpage = io;
>> +		} else if (msc->iface == MPAM_IFACE_PCC) {
>> +			msc->pcc_cl.dev = &pdev->dev;
>> +			msc->pcc_cl.rx_callback = mpam_pcc_rx_callback;
>> +			msc->pcc_cl.tx_block = false;
>> +			msc->pcc_cl.tx_tout = 1000; /* 1s */
>> +			msc->pcc_cl.knows_txdone = false;
>> +
>> +			msc->pcc_chan = pcc_mbox_request_channel(&msc->pcc_cl,
>> +								 msc->pcc_subspace_id);
>> +			if (IS_ERR(msc->pcc_chan)) {
>> +				pr_err("Failed to request MSC PCC channel\n");
>> +				err = PTR_ERR(msc->pcc_chan);
>> +				break;
>> +			}
> I don't see pcc support added in this series. Should we fail the probe
> if this interface is specified?

I've got patches from Andre P to support it on DT - but the platforms that need it keeping
popping in and out of existence. I'll pull these bits out - they were intended to check
the ACPI table wasn't totally rotten...


> (If keeping, there is a missing pcc_mbox_free_channel() on the error path.)

When pcc_mbox_request_channel() fails? It already called mbox_free_channel() itself.


>> +		}
>> +
>> +		list_add_rcu(&msc->glbl_list, &mpam_all_msc);
>> +		platform_set_drvdata(pdev, msc);
>> +	} while (0);
>> +	mutex_unlock(&mpam_list_lock);
>> +
>> +	if (!err) {
>> +		/* Create RIS entries described by firmware */
>> +		if (!acpi_disabled)
>> +			err = acpi_mpam_parse_resources(msc, plat_data);
>> +		else
>> +			err = mpam_dt_parse_resources(msc, plat_data);
>> +	}
>> +
>> +	if (!err && fw_num_msc == mpam_num_msc)
>> +		mpam_discovery_complete();
>> +
>> +	if (err && msc)
>> +		mpam_msc_drv_remove(pdev);
>> +
>> +	return err;
>> +}

>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> new file mode 100644
>> index 000000000000..07e0f240eaca
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -0,0 +1,62 @@

>> +struct mpam_msc {
>> +	/* member of mpam_all_msc */
>> +	struct list_head        glbl_list;
>> +
>> +	int			id;
>> +	struct platform_device *pdev;
>> +
>> +	/* Not modified after mpam_is_enabled() becomes true */
>> +	enum mpam_msc_iface	iface;
>> +	u32			pcc_subspace_id;
>> +	struct mbox_client	pcc_cl;
>> +	struct pcc_mbox_chan	*pcc_chan;
>> +	u32			nrdy_usec;
>> +	cpumask_t		accessibility;
>> +
>> +	/*
>> +	 * probe_lock is only take during discovery. After discovery these
> nit: s/take/taken/

Fixed,

>> +	 * properties become read-only and the lists are protected by SRCU.
>> +	 */
>> +	struct mutex		probe_lock;
>> +	unsigned long		ris_idxs[128 / BITS_PER_LONG];
>> +	u32			ris_max;
>> +
>> +	/* mpam_msc_ris of this component */
>> +	struct list_head	ris;
>> +
>> +	/*
>> +	 * part_sel_lock protects access to the MSC hardware registers that are
>> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
>> +	 * by RIS).
>> +	 * If needed, take msc->lock first.
>> +	 */
>> +	struct mutex		part_sel_lock;
>> +
>> +	/*
>> +	 * mon_sel_lock protects access to the MSC hardware registers that are
>> +	 * affeted by MPAMCFG_MON_SEL.
> nit: s/affeted/affected/
Fixed,


>> +	 * If needed, take msc->lock first.
>> +	 */
>> +	struct mutex		outer_mon_sel_lock;
>> +	raw_spinlock_t		inner_mon_sel_lock;
>> +	unsigned long		inner_mon_sel_flags;
>> +
>> +	void __iomem		*mapped_hwpage;
>> +	size_t			mapped_hwpage_sz;
>> +};
>> +
>> +#endif /* MPAM_INTERNAL_H */

Thanks,

James

