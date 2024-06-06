Return-Path: <linux-acpi+bounces-6232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543188FF176
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DF71F20F20
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0019308A;
	Thu,  6 Jun 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4yAHgot"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04213C690;
	Thu,  6 Jun 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689559; cv=none; b=IoxMvn2+iNy5lRttPFAfM9opFpmzqCJKFo1QGQqCZQIywTnqBhUJ85rP2/w8doCtJ3GHOVLAKCxE0WuT6CceVw0LxadmU4tfHSYYKIsweE2cxRHGMSQ+M94iq+EQ2z7y9qZ7Pr6qIzpeoXvQIbL3aszBWwrI/00mvE6ayHKhbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689559; c=relaxed/simple;
	bh=iqq/X15Hld5HWTihI8ZbQsjQV9XWsw2ETmVkWvF4SBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK+gIE4s+he+j5hm7vpxTPez0bZh0Zi7Uhy3eMx6BVWE0nbV3wVp6+w2FtCPNAjqINIZ+tVPuTuuaJO769xTUfzs+2g0yL4PdzN+Mz0wejOZcgp60ULTgQcyG7Uo+fu9m6okXEA4gXOIfPt1z4LTA7WbZDri5bMRStzNIueeHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4yAHgot; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717689558; x=1749225558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iqq/X15Hld5HWTihI8ZbQsjQV9XWsw2ETmVkWvF4SBE=;
  b=A4yAHgotXyBwEpNFeFVx0eR3GvBn1gNWcyLvh5uamepWgWyGWbxipxu9
   b468H87Ji2IS7wexhZC5w6bF6dqEHTRzIf3I4c/PPNa+7PAH+kV30OI8h
   Vgp0Z14OuHxchbSV53QlTRE+6Fi3ylddyyyNzptLZ54ldVXTlZ56dD1es
   FxkDT/Mj0ZP1RhZlV5cbU8GviGi1nqa5q2QqwLcpx0iYCrrnutKHfLLbC
   3pO7ajLGHLlmgZpci7HhAbPQ1HupoN1E4ozimZsIaXL1UVwGPlIJaz/Ma
   IHwnOA70Ge3AwElAiFmfRSdz0E0aBYaAWqdX1vdOLHMw3ujhdAvQDHfZP
   g==;
X-CSE-ConnectionGUID: 44p6bXD1TTGqmbL2Mg9OcQ==
X-CSE-MsgGUID: fZ2DJJzBRmqBg2VVfLANzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="31866612"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="31866612"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 08:59:17 -0700
X-CSE-ConnectionGUID: l3igcPGLRcOTpGBJDCR8HQ==
X-CSE-MsgGUID: ilwo1/p1R5epsYFiM7/Mvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42472612"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 08:59:17 -0700
Message-ID: <7ad9261c-115b-451d-9b93-832f98124116@intel.com>
Date: Thu, 6 Jun 2024 08:59:15 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi,hmat: Use ACCESS_COORDINATE_CPU when appropriate
To: Huang Ying <ying.huang@intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Bharata B Rao <bharata@amd.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <20240606022845.189710-1-ying.huang@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240606022845.189710-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 7:28 PM, Huang Ying wrote:
> To improve the readability of the code via replacing the magic number
> "1" with ACCESS_COORDINATE_CPU when appropriate.  No functionality
> change.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Thanks for this. Looks like I missed a few.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/acpi/numa/hmat.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c8ccc91ebe6..febd9e51350b 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -408,7 +408,7 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
>  	if (target && target->processor_pxm == init_pxm) {
>  		hmat_update_target_access(target, type, value,
>  					  ACCESS_COORDINATE_LOCAL);
> -		/* If the node has a CPU, update access 1 */
> +		/* If the node has a CPU, update access ACCESS_COORDINATE_CPU */
>  		if (node_state(pxm_to_node(init_pxm), N_CPU))
>  			hmat_update_target_access(target, type, value,
>  						  ACCESS_COORDINATE_CPU);
> @@ -948,7 +948,7 @@ static int hmat_set_default_dram_perf(void)
>  		target = find_mem_target(pxm);
>  		if (!target)
>  			continue;
> -		attrs = &target->coord[1];
> +		attrs = &target->coord[ACCESS_COORDINATE_CPU];
>  		rc = mt_set_default_dram_perf(nid, attrs, "ACPI HMAT");
>  		if (rc)
>  			return rc;
> @@ -975,7 +975,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
>  	hmat_update_target_attrs(target, p_nodes, ACCESS_COORDINATE_CPU);
>  	mutex_unlock(&target_lock);
>  
> -	perf = &target->coord[1];
> +	perf = &target->coord[ACCESS_COORDINATE_CPU];
>  
>  	if (mt_perf_to_adistance(perf, adist))
>  		return NOTIFY_OK;

