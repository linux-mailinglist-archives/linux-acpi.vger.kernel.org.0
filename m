Return-Path: <linux-acpi+bounces-16000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8CCB32CAC
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Aug 2025 02:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA5318935AC
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Aug 2025 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD97CA5A;
	Sun, 24 Aug 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="13TqfuMa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A319A;
	Sun, 24 Aug 2025 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755994092; cv=none; b=On5gLs5t45pO8ABmIyYMTjqCHUmhKorIeSAQsXSBDtZsIppO9+AocU/XhjNj2hvWO/0BrktIIyw8C+7l4ukTYv0rF9y/p12VbAIhbqJISgwxfNuaEgsZbb1mYIH5u60Od+2yyVOG8xL3HAHdBr1d9Oh75zFcIcTo2xzda4bXi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755994092; c=relaxed/simple;
	bh=L9aGCyqYIqfiE/709OdRQZek+aVPISbBSeqD8LeS+PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3TdV2ZP5iwM/4vW7A6CTxcrntEEIaebXQmx9Yx7Iziqr8c9Cz1I8PTS/5oryRWuhyrbhtXTG78Egf0CEn4aofE+sMslChI5ivSUjrL5I2VezYOvZhSgRf+5BnDsCENl6+Bs5zyfsdyMIi/DjtY4cyWx5GsqLNa/1ieygS5f0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=13TqfuMa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MyBjjN2I/3jlsDrVJT+yGV+wBVpUEwoIMa9ewpZMCMg=; b=13TqfuMa5/zhkRt1zTNt8DhjeH
	d7iQITJGOl0IJWojBPtm6GzoTnyNr5cmPKHVCauU0ACUxyJbiv36OckcHHWc/10jTi61ty7ZZZ9PC
	pvP6X9nmj/dtb7/tZa4OdA/gsr3beaKLMxsy9xtG+XBTU5hRv23DYpvCL0dxpAUc4wtzEgOM2icI4
	6RrgjZfEH9POix9PWwuL+QPjurX3mP0jng2c+Bzs0v2N9Z7t2EWvMzemOJS2X8miZYcY8P5NV6m2W
	pBbIhMmbQplHRrd4Ndt+2hgmAV+71wRxWZ15Ninr6FcrkiiAwe0y3fGmACK5TT5D538ALyoiuSuFG
	jSAPqudQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upyHD-00000005U69-0Xmu;
	Sun, 24 Aug 2025 00:08:03 +0000
Message-ID: <769e0ce4-1f96-4de5-a8a9-48166d6e3a91@infradead.org>
Date: Sat, 23 Aug 2025 17:08:01 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-7-sumitg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250823200121.1320197-7-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/23/25 1:01 PM, Sumit Gupta wrote:
> Add sysfs interfaces for Minimum Performance, Maximum Performance
> and Performance Limited Register in the cppc_cpufreq driver.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index ab8cd337f43a..4bce0dbc48c9 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -327,6 +327,49 @@ Description:	Energy performance preference
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:           /sys/devices/system/cpu/cpuX/cpufreq/min_perf
> +Date:           Aug 2025
> +Contact:        linux-pm@vger.kernel.org
> +Description:    Minimum Performance

Preferably these 4 lines above use tab(s) after the ':' for indentation
instead of spaces. (in 3 places, i.e., each sysfs file entry).

> +
> +		Read/write a 32 bits value from/to this file. This file
> +		conveys the minimum performance level at which the platform
> +		may run. Minimum performance may be set to any performance
> +		value in the range [Lowest Performance, Highest Performance],
> +		inclusive but must be set to a value that is less than or
> +		equal to that specified by the Maximum Performance Register.
> +
> +		Writing to this file only has meaning when Autonomous Selection
> +		is enabled.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:           /sys/devices/system/cpu/cpuX/cpufreq/max_perf
> +Date:           Aug 2025
> +Contact:        linux-pm@vger.kernel.org
> +Description:    Minimum Performance
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
> +What:           /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
> +Date:           Aug 2025
> +Contact:        linux-pm@vger.kernel.org
> +Description:    Minimum Performance
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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

