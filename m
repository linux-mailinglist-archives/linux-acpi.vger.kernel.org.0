Return-Path: <linux-acpi+bounces-18863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A1C577A8
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 13:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CC33BA962
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C234F478;
	Thu, 13 Nov 2025 12:41:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838E34DCFE;
	Thu, 13 Nov 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037687; cv=none; b=p4hqVoprkvjeQZgtLqMXdAEzaXDCiapcTNSb1M7DBlwbjkKVb5WZ+R+4QgXDcZBzTidmgBFgYlSnoNtZmOJZ7V1JhW0ATFsnZyFT9yp3Xze0RuaBsB/xZQKIJYd2HRAP+Bb6PE00I/vVcjnSArRZI9mX87fL1229oxROnG6oJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037687; c=relaxed/simple;
	bh=XaTNNB/CqGz+V+OMzj/mIjV+mLYVDACn92ZqVORRSbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGQtwWGpvSRE3rZqCBr6YsDBZ3xf5YJjR/31CnDfvrFvoKlulf3pdhMFqyaf9pndTijPryqI1+Sl8BNoznQ79X6gyczOnvN/SLxfGwvlpxMcM11y5AGpJAYr+JPoV+i0nTzbgeRd4q47eDfelLUNoyB4upBvvsRJxB+jHgOuBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C26B012FC;
	Thu, 13 Nov 2025 04:41:16 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026C73F5A1;
	Thu, 13 Nov 2025 04:41:24 -0800 (PST)
Date: Thu, 13 Nov 2025 12:41:19 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
	zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
	bbasu@nvidia.com
Subject: Re: [PATCH v4 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
Message-ID: <aRXR7yKyG6l1Agfq@arm.com>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-7-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-7-sumitg@nvidia.com>

Hi,

On Wednesday 05 Nov 2025 at 17:08:42 (+0530), Sumit Gupta wrote:
> Add sysfs interfaces for Minimum Performance, Maximum Performance
> and Performance Limited Register in the cppc_cpufreq driver.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 8aed6d94c4cd..6f1f70696000 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -327,6 +327,52 @@ Description:	Energy performance preference
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
> +Date:		December 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance Frequency
> +
> +		Read/write a frequency value in kHz from/to this file. This
> +		file conveys the minimum performance level (as frequency) at
> +		which the platform may run. The frequency value is internally
> +		converted to a performance value and must correspond to a
> +		performance level in the range [Lowest Performance, Highest
> +		Performance], inclusive. The minimum must be less than or equal
> +		to the maximum performance. The performance range can be checked
> +		from nodes:
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf

I think information on highest/lowest performance is irrelevant here. If
the user is expected to provide a frequency value, it should only care
about it being in the range [cpuinfo_min_freq, cpuinfo_max_freq].

I think ideally all of these controls (auto-select, EPP, min, max, etc.)
would have been better placed under
/sys/devices/system/cpu/cpuX/acpi_cppc, but I suppose the intention
was/is to have all performance related controls under cpufreq. But that
means that the user should not be concerned about the underlying CPPC
scale and only use /sys/devices/system/cpu/cpuX/acpi_cppc for
information purposes.

Thanks,
Ionela.

> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
> +Date:		December 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Maximum Performance Frequency
> +
> +		Read/write a frequency value in kHz from/to this file. This
> +		file conveys the maximum performance level (as frequency) at
> +		which the platform may run. The frequency value is internally
> +		converted to a performance value and must correspond to a
> +		performance level in the range [Lowest Performance, Highest
> +		Performance], inclusive. The performance range can be checked
> +		from nodes:
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
> +Date:		December 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Performance Limited
> +
> +		Read/write a 32 bits value from/to this file. This file indicates
> +		to OSPM that an unpredictable event has limited processor
> +		performance, and the delivered performance may be less than
> +		desired/minimum performance.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
>  
>  What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>  Date:		August 2008
> -- 
> 2.34.1
> 

