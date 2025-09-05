Return-Path: <linux-acpi+bounces-16422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1CB45E5F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C929317C617
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5AE306B12;
	Fri,  5 Sep 2025 16:40:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612D2FB0A2;
	Fri,  5 Sep 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090416; cv=none; b=NoI58GLZ4LhjGm/9Mt448DCD5izN4SBAABYPnL3WPzGFhx3GQ/1b5fM1+oW/RpvfU7gCbzbuq6ln65BmhuLMH0z3mvhKK/WIeTg+rFm21E9KZD/5qrCeH5oA8P1rT3xOATh1tBnUzdd407Xw8mcxXzJWhv1MJF6P8Y4YdqPgKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090416; c=relaxed/simple;
	bh=DSlWZfq+GTaT2HBFBElFZUNxl3V/B62KVMzTdbqD38g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIWBu403TZxXhmIglwYoRCyxlvfYtg6sbFDf+pmEQfK79uk0h7dtzEeCQtUoBT6RO0ClhnHW3iZjakeYYQeGBYiZG1Ar341SWsbL/lQwrve7r7MehsCCa5ZJfVovkU2y0U8slb+H7Sgxb4OI8/Zn6wLoiDiVZh8i4tKZYtfHUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1970152B;
	Fri,  5 Sep 2025 09:40:05 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6442A3F63F;
	Fri,  5 Sep 2025 09:40:08 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:40:05 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lecopzer Chen <lecopzerc@nvidia.com>
Subject: Re: [PATCH 14/33] arm_mpam: Add cpuhp callbacks to probe MSC hardware
Message-ID: <aLsSZWUlbrEzbx6O@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-15-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-15-james.morse@arm.com>

Hi James,

On Fri, Aug 22, 2025 at 03:29:55PM +0000, James Morse wrote:
> Because an MSC can only by accessed from the CPUs in its cpu-affinity
> set we need to be running on one of those CPUs to probe the MSC
> hardware.
> 
> Do this work in the cpuhp callback. Probing the hardware will only
> happen before MPAM is enabled, walk all the MSCs and probe those we can
> reach that haven't already been probed.

It may be worth mentioning that the low-level MSC register accessors
are added by this patch.

> Later once MPAM is enabled, this cpuhp callback will be replaced by
> one that avoids the global list.

I misread this is as meaning "later in the patch series" and got
confused.

Perhaps, something like the following? (though this got a bit verbose)

--8<--

Once all MSCs reported by the firmware have been probed from a CPU in
their respective cpu-affinity set, the probe-time cpuhp callbacks are
replaced.  The replacement callbacks will ultimately need to handle
save/restore of the runtime MSC state across power transitions, but for
now there is nothing to do in them: so do nothing.

-->8--

> Enabling a static key will also take the cpuhp lock, so can't be done

What static key?

None in this patch that I can see.

> from the cpuhp callback. Whenever a new MSC has been probed schedule
> work to test if all the MSCs have now been probed.
> 
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 144 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |   8 +-
>  2 files changed, 147 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c

[...]

> @@ -511,9 +539,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,

[...]

> +static int mpam_cpu_online(unsigned int cpu)
>  {
> -	pr_err("Discovered all MSC\n");

I guess this disappears later?

If we print anything, it feels like it should be in the
mpam_enable_once() path, otherwise it looks like dmesg is going to get
spammed on every hotplug.  I might have missed something, here.

> +	return 0;
> +}
> +
> +/* Before mpam is enabled, try to probe new MSC */
> +static int mpam_discovery_cpu_online(unsigned int cpu)
> +{
> +	int err = 0;
> +	struct mpam_msc *msc;
> +	bool new_device_probed = false;
> +
> +	mutex_lock(&mpam_list_lock);

I take it nothing breaks if we sleep here?

Pending cpuhp callbacks for this CPU look to be blocked while we sleep,
at the very least.

Since this only happens during the probing phase, maybe that's not such
a big deal.

Is it likely that some late CPUs might be left offline indefinitely?

If so, we might end up doing futile work here forever.


> +	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +			continue;
> +
> +		mutex_lock(&msc->probe_lock);
> +		if (!msc->probed)
> +			err = mpam_msc_hw_probe(msc);
> +		mutex_unlock(&msc->probe_lock);
> +
> +		if (!err)
> +			new_device_probed = true;
> +		else
> +			break; // mpam_broken

What's the effect of returning a non-zero value to the CPU hotplug
callback dispatcher here?

Do we want to tear anything down if MPAM is unusable?

> +	}
> +	mutex_unlock(&mpam_list_lock);
> +
> +	if (new_device_probed && !err)
> +		schedule_work(&mpam_enable_work);
> +
> +	return err;
> +}
> +
> +static int mpam_cpu_offline(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
> +					  int (*offline)(unsigned int offline))
> +{
> +	mutex_lock(&mpam_cpuhp_state_lock);
> +	if (mpam_cpuhp_state) {
> +		cpuhp_remove_state(mpam_cpuhp_state);
> +		mpam_cpuhp_state = 0;
> +	}
> +
> +	mpam_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mpam:online",
> +					     online, offline);
> +	if (mpam_cpuhp_state <= 0) {
> +		pr_err("Failed to register cpuhp callbacks");

Should an error code be returned to the caller if this fails?

> +		mpam_cpuhp_state = 0;
> +	}
> +	mutex_unlock(&mpam_cpuhp_state_lock);
>  }
>  
>  static int mpam_dt_count_msc(void)
> @@ -772,7 +875,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!err && fw_num_msc == mpam_num_msc)
> -		mpam_discovery_complete();
> +		mpam_register_cpuhp_callbacks(&mpam_discovery_cpu_online, NULL);

Abandon probing the MSC if this fails?

(However, the next phase of probing hangs off CPU hotplug, so it just
won't happen if the callbacks can't be registered -- but it looks like
MPAM may be left in a half-probed state.  I'm not entirely convinced
that this matters if the MPAM driver is not unloadable anyway...)

Nit: redundant &

(You don't have it in the similar call in mpam_enable_once().)


>  
>  	if (err && msc)
>  		mpam_msc_drv_remove(pdev);
> @@ -795,6 +898,41 @@ static struct platform_driver mpam_msc_driver = {
>  	.remove = mpam_msc_drv_remove,
>  };
>  
> +static void mpam_enable_once(void)
> +{
> +	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);

Should it be fatal if this fails?

> +
> +	pr_info("MPAM enabled\n");
> +}
> +
> +/*
> + * Enable mpam once all devices have been probed.
> + * Scheduled by mpam_discovery_cpu_online() once all devices have been created.
> + * Also scheduled when new devices are probed when new CPUs come online.
> + */
> +void mpam_enable(struct work_struct *work)
> +{
> +	static atomic_t once;

Nit: possibly unnecessary atomic_t?  This is slow-path code, and we
already have to take mpam_list_lock.  Harmless, though.

> +	struct mpam_msc *msc;
> +	bool all_devices_probed = true;
> +
> +	/* Have we probed all the hw devices? */
> +	mutex_lock(&mpam_list_lock);
> +	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
> +		mutex_lock(&msc->probe_lock);
> +		if (!msc->probed)
> +			all_devices_probed = false;
> +		mutex_unlock(&msc->probe_lock);
> +
> +		if (!all_devices_probed)
> +			break;

WARN()?

We counted the MSCs in via the mpam_discovery_cpu_online(), so I think
we shouldn't get in here if some failed to probe?

> +	}
> +	mutex_unlock(&mpam_list_lock);
> +
> +	if (all_devices_probed && !atomic_fetch_inc(&once))
> +		mpam_enable_once();
> +}

[...]

Cheers
---Dave

