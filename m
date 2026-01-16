Return-Path: <linux-acpi+bounces-20401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410ED3220B
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 14:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 403863039850
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003E26CE0A;
	Fri, 16 Jan 2026 13:52:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89C27EFEE;
	Fri, 16 Jan 2026 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571563; cv=none; b=QMq7X+uva+4tJfAJo3nlJb3lchU0JuUg23BK3jpoa8RLa3BJ45uM1MnKSj9v4O5saculFPFcFuztM3MrqDMgGAQoCbBEjmdUu0Cz6IrTD4z839l8iMsxyuX6hiKPAshKs6/LaatKNjYfuDZWI4OUJMoTh5znqz3cVsHl2vhrnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571563; c=relaxed/simple;
	bh=ePIBmy4uz5Cl1vlbgFHt/CqUq1vnrvc8+nwgdpWrECo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOibmhK2o6txoiE6nsOTMKLIKUTf2/epIGUSo5dl8vi+UKIYzaKPPixoAwuANmqL2vfd7l+3yhd1g2Gbrz7+0XRVpbGm8v/OoNZYYfJRvP/zuzWEDKEIa3fu3vsZqyYbpi5Ibvz1qzNZx3DmhqUU1Lj+Suzfln0JMJsGL+BSYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 422631515;
	Fri, 16 Jan 2026 05:52:34 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABBA93F632;
	Fri, 16 Jan 2026 05:52:39 -0800 (PST)
Date: Fri, 16 Jan 2026 13:52:37 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI/PPTT: Check total CPU numbers when a CPU can't
 be found in PPTT table
Message-ID: <aWpCpecZr7o0qIw2@bogus>
References: <20260116072943.26322-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116072943.26322-1-feng.tang@linux.alibaba.com>

On Fri, Jan 16, 2026 at 03:29:43PM +0800, Feng Tang wrote:
> There was a bug that kernel printed error message:
> " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)"
> and later on the kernel met issues when building up scheduler domain.
> 
> Debug showed the kernel actually brought up all 8 CPUs successfully
> (MADT and other table worked fine), while the PPTT table was broken
> as it only had 4 CPUs in total.
> 
> Add check for number of CPU of PPTT table against system CPU number,
> and warn if they are not equal, to help debugging similar issues.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
> Changelog:
> 
>   v3
>   * Only check the number of CPUs in PPTT table againt system
>     CPU count when error happens, instead of dump all the CPU/cache
> 	entries (Sudeep/Rafael)
> 
>   v2
>   * rebase againt 6.19 and refine the commit log
> 
>  drivers/acpi/pptt.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..9958c3961001 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -529,6 +529,43 @@ static void acpi_pptt_warn_missing(void)
>  	pr_warn_once("No PPTT table found, CPU and cache topology may be inaccurate\n");
>  }
>  
> +static void pptt_verify_cpu_count(struct acpi_table_header *table_hdr)
> +{
> +	struct acpi_subtable_header *entry;
> +	unsigned long end;
> +	struct acpi_pptt_processor *cpu;
> +	u8 len;
> +	int nr_pptt_cpus = 0;
> +	static bool checked;
> +
> +	if (checked)
> +		return;
> +
> +	end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +				sizeof(struct acpi_table_pptt));
> +
> +	while ((unsigned long)entry + sizeof(struct acpi_pptt_processor) <= end) {
> +		len = entry->length;
> +		if (!len) {
> +			pr_warn("Invalid zero length subtable\n");
> +			return;
> +		}
> +
> +		cpu = (struct acpi_pptt_processor *)entry;
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
> +		if (cpu->header.type == ACPI_PPTT_TYPE_PROCESSOR &&
> +		    (cpu->flags & ACPI_PPTT_ACPI_LEAF_NODE))
> +			nr_pptt_cpus++;
> +	}
> +
> +	if (nr_pptt_cpus != num_possible_cpus())

This is going to be tricky. I recall some config option that sets all
`NR_CPUS` as possible. In short it will break if that is enabled.

> +		pr_warn("The number of CPUs (%d) in PPTT table doesn't match system's CPU count (%d)!\n",
> +			nr_pptt_cpus, num_possible_cpus());
> +
> +	checked = true;
> +}
> +
>  /**
>   * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
>   * @table: Pointer to the head of the PPTT table
> @@ -565,6 +602,9 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>  	}
>  	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
>  		    cpu, acpi_cpu_id);

I was expecting the above log will be improved to just say possible mismatch
with cpu count.

> +
> +	/* Check whether PPTT table's CPU count match with system count */
> +	pptt_verify_cpu_count(table);

Today it is a request to check the CPU count; tomorrow it will be something
else in the PPTT. Where do we draw the line on PPTT validation in the kernel?
These issues ultimately need to be fixed in firmware, and the firmware
should not depend on the kernel to precisely identify what is wrong in
the PPTT tables.

-- 
Regards,
Sudeep

