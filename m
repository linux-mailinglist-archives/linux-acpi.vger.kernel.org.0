Return-Path: <linux-acpi+bounces-11389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF5A41AD2
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 11:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935513AF2F9
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645B24E4B1;
	Mon, 24 Feb 2025 10:25:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21523241669;
	Mon, 24 Feb 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392701; cv=none; b=Xs7dJx73FuxmLk6mnDerfYovR+2sEPI890XguJaZKq5blgY0i7zRHj/oBFNQr8KsGjKI9KtxCgJ0J0dFaHlsdpM2i4tkL+gzEXEj8sN4JFHD2AR2JTkLkORRT9CTkQ56jLnFMlTvwpdA02kLrsnZPghLsqO28iTcSb7hb5w9VPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392701; c=relaxed/simple;
	bh=FN8iFgeI6rosvaokiG/UoUpgH0k0DiZJJ6LLcQceCXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wp67eR/7xQTY1/5HVdnu0CSGa85u7ahu0M8pea2wK19WfeYlzHPgV7DfxdyZCgjaBmt9tWm6y4ndEvo/q7YTcpig14wl1Ff/+7zRvYefBR0faIhgbeIya6eZSWv25232ldvlKlVpuUDlDxbMq6Vz1UmnureICsNwC4OBaTEp7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A75D1E7D;
	Mon, 24 Feb 2025 02:25:14 -0800 (PST)
Received: from [10.57.38.222] (unknown [10.57.38.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D51B3F673;
	Mon, 24 Feb 2025 02:24:53 -0800 (PST)
Message-ID: <ecd2190d-09a2-4e7e-a076-08f517fe20de@arm.com>
Date: Mon, 24 Feb 2025 11:24:51 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 3/5] ACPI: CPPC: support updating epp, auto_sel and
 {min|max_perf} from sysfs
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 sashal@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, bbasu@nvidia.com
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211103737.447704-4-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20250211103737.447704-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Sumit,

On 2/11/25 11:37, Sumit Gupta wrote:
> Add support to update the CPC registers used for Autonomous
> Performance Level Selection from acpi_cppc sysfs store nodes.
> Registers supported for updation are:
> - Engergy Performance Preference (EPP): energy_perf
> - Autonomous Selection: auto_sel
> - Maximum Performance: max_perf
> - Minimum Performance: min_perf
> 
> Also, enable show nodes to read of the following CPC registers:
> - Performance Limited: perf_limited
> - Autonomous Activity Window: auto_activity_window
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c | 191 ++++++++++++++++++++++++++++++++++++---
>   include/acpi/cppc_acpi.h |   5 +
>   2 files changed, 183 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index cc2bf958e84f..c60ad66ece85 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c

[...]

>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf, ro);
>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf, ro);
>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf, ro);
> @@ -177,9 +304,16 @@ sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf, ro);
>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf, ro);
>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq, ro);
>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq, ro);
> +sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, auto_sel, rw);
>   
>   sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, reference_perf, ro);
>   sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, wraparound_time, ro);
> +sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, perf_limited, ro);
> +
> +sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, min_perf, rw);
> +sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, max_perf, rw);

IIUC, this means that users can modify the min/max performance levels of the CPU
without having the cpufreq framework notified. Meaning that if a user modifies these
levels, the frequency selection will be done using the initial min/max performance
level.
I think it would be better not allow users to modifies these values directly. Reliying
on existing scaling_min_freq/scaling_max_freq files would be better IMO.

Regards,
Pierre

