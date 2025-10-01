Return-Path: <linux-acpi+bounces-17485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA15BB1501
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 19:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9761926401
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC862D238D;
	Wed,  1 Oct 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEP+VV+4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA926D4C2;
	Wed,  1 Oct 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338223; cv=none; b=I+P1c3EmG9J4CenT+j0vl7iudgaLUWMl2+nzzt4Z9wGjPsB0J6VgrwqsQ+iB4rQTTkJZZRXGQtrIQfD4NU86iPTcN7n5hDuGahu796RBH+xnvvWkjevwQweLhZZkBKdUGnKfrj0TnQ3YVwyVJOwXaSntfusXDnpw8V2VQU/yheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338223; c=relaxed/simple;
	bh=nPII5ruhsWVBCkggNl2oDGdpF0mKUlLC73uy3QpGtkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuDn+dnme3u0beFvW6K/3k8CliRR0/GIgzJvfMPpEzXPMa3XoOILLNj94tQvEOHei3IZtfF72cic2kuO55YMqI22of5lCJZ36KfqXPYSTC6A2kHUDZxSDoUkjAUL99ftnX+pwQ8bB4rhr4UOXtf/d/9w2KFjLOhNzrvuBGnIeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEP+VV+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77717C4CEF1;
	Wed,  1 Oct 2025 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759338223;
	bh=nPII5ruhsWVBCkggNl2oDGdpF0mKUlLC73uy3QpGtkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kEP+VV+4TBzxm4OMZWFfSsc5CVuBWXvI9fszuNkZ4BUB4cpzcrvW7u9noZImnFhzE
	 5tK+GRgMhGPaZRRIOn3g3LZIQuN0BJNQhNV+5d/Le+YMpkcrnsgR9ZmT9J+vhiqbbt
	 IElVkRbmV3YBN1OMdqVRp+CFif1P+MSkcGlHJFT6i/0T2RUo1vw9P/EuiZWdp6EVaq
	 Kir6WP0GMSLWmfI4zRmIHazGov/akYoLj/pPnspKLur3zutc9sRuemk8A0NEIq4Biu
	 vbIdJlzZr+ZvltidQ68yTmf/ZcQeeupD5xxaCYF2zuW8fjpwG74xTygboA09+ZaZ50
	 bC0G+AzzjGVcg==
Message-ID: <dbee61be-4e1c-4f58-ae20-32447b6767fd@kernel.org>
Date: Wed, 1 Oct 2025 12:03:40 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: linux-doc@vger.kernel.org, corbet@lwn.net,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 pierre.gondois@arm.com, zhenglifeng1@huawei.com, ray.huang@amd.com,
 gautham.shenoy@amd.com, perry.yuan@amd.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-7-sumitg@nvidia.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251001150104.1275188-7-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+linux-doc

On 10/1/25 10:01 AM, Sumit Gupta wrote:
> Add sysfs interfaces for Minimum Performance, Maximum Performance
> and Performance Limited Register in the cppc_cpufreq driver.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index ab8cd337f43a..82141b45d58c 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -327,6 +327,49 @@ Description:	Energy performance preference
>   
>   		This file is only present if the cppc-cpufreq driver is in use.
>   
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
> +Date:		September 2025

These dates will need to push out since this isn't 6.17 material.

That being said I have a general question to linux-doc.

Why is this is date based?  I would expect a date is meaningless to 
anyone reads this documentation.  People who want to know if an 
interface is available would normally look at their kernel version to tell.

So wouldn't it make more sense for this field to be something like:

Version: 6.19

> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance
> +
> +		Read/write a 32 bits value from/to this file. This file
> +		conveys the minimum performance level at which the platform
> +		may run. Minimum performance may be set to any performance
> +		value in the range [Lowest Performance, Highest Performance],

How will a user discover the lowest -> highest range?

IE I think you should document how to lookup those caps too.

> +		inclusive but must be set to a value that is less than or
> +		equal to that specified by the Maximum Performance Register.
> +
> +		Writing to this file only has meaning when Autonomous Selection
> +		is enabled.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
> +Date:		September 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance
> +
> +		Read/write a 32 bits value from/to this file. This file conveys
> +		the maximum performance level at which the platform may run.
> +		Maximum performance may be set to any performance value in the
> +		range [Lowest Performance, Highest Performance], inclusive.
> +
> +		Writing to this file only has meaning when Autonomous Selection is
> +		enabled.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
> +Date:		September 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance
> +
> +		Read/write a 32 bits value from/to this file. This file indicates
> +		to OSPM that an unpredictable event has limited processor
> +		performance, and the delivered performance may be less than
> +		desired/minimum performance.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
>   
>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>   Date:		August 2008


