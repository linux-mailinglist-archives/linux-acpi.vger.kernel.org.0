Return-Path: <linux-acpi+bounces-13118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F63A93E9F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 22:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC27A188E42F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81822D4F0;
	Fri, 18 Apr 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYtYIM3O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCA214201;
	Fri, 18 Apr 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006519; cv=none; b=aj2/8Iw2SCMlnKD3pBK2P4NCEUopeqriJQu6UPR/9v2xoCdTcDriFj3ZTu6EH6wiEgKOQHbi4/aY8gvtQdujBRK7VEEE3MvcZm5JaEDsZvhhyD8Nch8X3wa6lLAS/CtHZGabNlYz4fs47MS8aSwb5j9NB+0WyqlTSiIBgcP4MQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006519; c=relaxed/simple;
	bh=93RId6gvCAH9LqMoj2hJRIzDkVjLDqEJNe6M0bivI58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvxSQ6KHgO/2olHGQOht621hb3hkG4q5bmCqvXYiHML/zZecuotFha2gFzC5T2loSXdqhaysP4JEmGJeVSZ4Wffy/S+wdkfJnP81sxjWZF47LXbzSwR6PVuHqSRYTqohgG0tUogdPXX0Wnu6Xiomh/+A8jGS8AGwUMINVRMEZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYtYIM3O; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745006517; x=1776542517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=93RId6gvCAH9LqMoj2hJRIzDkVjLDqEJNe6M0bivI58=;
  b=HYtYIM3OB5J9f7ssI/oOarf+ytoHO17udWkAYPkUeJWZASyJZISWVx7t
   I6EHSAUc1UKPfSNqbzbhc6tlgdu0YkyJTRTX0JJ7OKRae1uuqHj6YeJ48
   8kUGh6Iv+ahJv3ro0Iq7kfUzMydI9RvmJvo+y6qq6HT5MZ7dc/bqzsDbo
   iwuLt0zrwfiWXN2AQx1wyo3piMjx4j/TTpulsAYrGjfQATSgG7kR2CnRz
   vAjkauPH4Q3OxVZY5JkepwOITFV/PWZlVuombOR3KAbhQ/0mzhspud2L/
   uXnnfWypkGNJ6cCC1+rAnKHbCiSZbN4yS0ioJ1zTllc5FlwaPggI9uLQR
   g==;
X-CSE-ConnectionGUID: tU0ssg5MSNWUpBUOcibxvA==
X-CSE-MsgGUID: Tw5CoJaeREqOnMRNr7kVBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46529978"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46529978"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 13:01:57 -0700
X-CSE-ConnectionGUID: gOAZJprsRySI9aELy6xrew==
X-CSE-MsgGUID: EWPXciOlQoSkbII4NGuOxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="132177498"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 13:01:56 -0700
Date: Fri, 18 Apr 2025 13:01:55 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v6 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <aAKvs2cDLu_mVGdr@agluck-desk3>
References: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
 <20250417220019.27898-9-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417220019.27898-9-zaidal@os.amperecomputing.com>

On Thu, Apr 17, 2025 at 03:00:18PM -0700, Zaid Alali wrote:
> +			if (is_V2) {
> +				int count = 0, bytes_read, pos = 0, nr_parsed = 0, str_len;
> +				unsigned int comp, synd;

I've been staring at the ACPI spec to try and figure out how many bits
are needed for comp and sync. The example in section 18.6.7 "Error
Injection Version 2 Operation" has this in step 6:

Component Syndrome Array [0] = { 00000000000000000000000000000004 , 000000000000000000000000A5A5A5A5 }

Which really looks like 128-bit values!

So are "unsigned int" adequate? Even "u64" looks like it would fall short.

> +				struct syndrome_array *component_arr;
> +
> +				component_arr = v5param->einjv2_struct.component_arr;
> +				str_len = strlen(user_input);
> +
> +				while ((nr_parsed = sscanf(user_input + pos, "%x %x\n%n", &comp,

Parsing user input with sscanf() is a bit fragile.  Take a look at
rdtgroup_schemata_write() which uses:

	while ((tok = strsep(&buf, "\n")) != NULL) {

to split input into lines, and then strim() and strsep() to break
up items within a line.

> +					&synd, &bytes_read))) {
> +					pos += bytes_read;
> +
> +					if (nr_parsed != 2) {
> +						kfree(v5param);
> +						goto err_out;
> +					}
> +					if (count >= nr_components) {
> +						kfree(v5param);
> +						goto err_out;
> +					}
> +
> +					switch (type) {
> +					case EINJV2_PROCESSOR_ERROR:
> +						component_arr[count].comp_id.acpi_id = comp;
> +						component_arr[count].comp_synd.proc_synd = synd;
> +						break;
> +					case EINJV2_MEMORY_ERROR:
> +						component_arr[count].comp_id.device_id = comp;
> +						component_arr[count].comp_synd.mem_synd = synd;
> +						break;
> +					case EINJV2_PCIE_ERROR:
> +						component_arr[count].comp_id.pcie_sbdf = comp;
> +						component_arr[count].comp_synd.pcie_synd = synd;
> +						break;
> +					}
> +					count++;
> +					if (pos >= str_len)
> +						break;
> +				}
> +				v5param->einjv2_struct.component_arr_count = count;
> +
> +				/* clear buffer after user input for next injection */
> +				memset(user_input, 0, COMP_ARR_SIZE);
> +			} else {

-Tony

