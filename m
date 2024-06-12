Return-Path: <linux-acpi+bounces-6322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73A905215
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713AA1F28863
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F3A16F286;
	Wed, 12 Jun 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZFt9XpP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6410152DF1;
	Wed, 12 Jun 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194068; cv=none; b=ocvORP4ZxueUu0In5LBSCopbMayzOzLf4bumgC4a63ccEmyHJBZb/KcTTNSausrxoFs9u1LjUDzx/ShePRCR6yaQapCOxfoiODWVYbaeizOC8AmEZvE1NYLg/ZMNSKX7+L6iYstKBgJsmlK8MBjZgsyy30978q+YpOrAP1y0sXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194068; c=relaxed/simple;
	bh=0pa55INIotkhQ7WBXfCLov8s4bc0ru2M2EqMpB+0ass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2BV8ZmiHwktmJCf6pDlbhNGA0UJskf+bID6wp0FzsjZy/OYCb5dhaUIh5aGBFnnW0TM/onetZngaveByeAVAFXMmqLtYsThzstyrhN+2IHIIA66ACwUXqfa0JWwdQ801EF5LkyVi4/xunY2DnXmpTIu94c81DvZiqb7QzZCA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZFt9XpP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718194067; x=1749730067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0pa55INIotkhQ7WBXfCLov8s4bc0ru2M2EqMpB+0ass=;
  b=cZFt9XpPmjwTtWUeKCgHCj+XDQpGHOXzmSGMZbedg4QFtKhUmU5mulyH
   fUX9XrS/B8n0bA+4CPWNeJmmL/zSNNFwMNFDHFUSNxjO2QXBogBnFNAzT
   ttgokYr6/U2KfGDvKeI1PyjzYdya9M5FByNA7Xilsr5rBR81Q4CaKdgZB
   wfJC732v4O7b3BJgO/GwE/all5VxEZ65N7GTK7im48Efnx2eGnHVhPN+I
   bzVRls2gB8y5wGyxA5jPOjzBby4anOFFr4TR/M86ZZ/M4dP+zGKGJ+V5U
   TixGhSyzN0j9jU+ya+ieNxaLuZsfBzhWGSG097l+VSGLJSH9GQjX+QVkE
   A==;
X-CSE-ConnectionGUID: U6JaQCjBQZ+X2FJUghmbTA==
X-CSE-MsgGUID: 8iYd19HmTv2T/cMt8IkGsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11100"; a="40359854"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40359854"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:07:46 -0700
X-CSE-ConnectionGUID: f8JrlDn3Sc+nofqt1CEfog==
X-CSE-MsgGUID: jWCaZ3lITzK1t6Wa88hptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="44335857"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:07:45 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A5AC811FA94;
	Wed, 12 Jun 2024 15:07:42 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:07:42 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all
 Dell Tiger, Alder and Raptor Lake models
Message-ID: <ZmmPjt2cCz-z7B1q@kekkonen.localdomain>
References: <20240612104220.22219-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612104220.22219-1-hdegoede@redhat.com>

Hi Hans,

Thanks for the set.

On Wed, Jun 12, 2024 at 12:42:20PM +0200, Hans de Goede wrote:
> It seems that all Dell laptops with IPU6 camera or the Tiger Lake,

"Seems that"? I don't argue against though as I have little information on
this, in fact only two systems.

> Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
> information.
> 
> Instead of adding a lot of DMI quirks for this, check for these CPU
> generations and disable ACPI MIPI DISCO support on all Dell laptops
> with these CPU generations.

Is there still a need to include linux/dmi.h?

> 
> Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from _CRS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/internal.h       |  4 ++++
>  drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
>  2 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 2a0e9fc7b74c..601b670356e5 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
>  void acpi_mipi_scan_crs_csi2(void);
>  void acpi_mipi_init_crs_csi2_swnodes(void);
>  void acpi_mipi_crs_csi2_cleanup(void);
> +#ifdef CONFIG_X86
>  bool acpi_graph_ignore_port(acpi_handle handle);
> +#else
> +static inline bool acpi_graph_ignore_port(acpi_handle handle) { return false; }
> +#endif
>  
>  #endif /* _ACPI_INTERNAL_H_ */
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> index d05413a0672a..0ab13751f0db 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
>  		acpi_mipi_del_crs_csi2(csi2);
>  }
>  
> -static const struct dmi_system_id dmi_ignore_port_nodes[] = {
> -	{
> -		.matches = {
> -			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),

I believe the patch adding XPS 9320 has been merged so reverting that first
might help backporting. Or maybe it's only in Rafael's testing/for-next
branches and so can be dropped easily?

> -		},
> -	},
> -	{ }
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +
> +/* CPU matches for Dell generations with broken ACPI MIPI DISCO info */
> +static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] = {
> +	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> +	{}
>  };
>  
>  static const char *strnext(const char *s1, const char *s2)
> @@ -761,7 +767,10 @@ bool acpi_graph_ignore_port(acpi_handle handle)
>  	static bool dmi_tested, ignore_port;
>  
>  	if (!dmi_tested) {
> -		ignore_port = dmi_first_match(dmi_ignore_port_nodes);
> +		if (dmi_name_in_vendors("Dell Inc.") &&
> +		    x86_match_cpu(dell_broken_mipi_disco_cpu_gens))
> +			ignore_port = true;
> +
>  		dmi_tested = true;
>  	}
>  
> @@ -794,3 +803,4 @@ bool acpi_graph_ignore_port(acpi_handle handle)
>  	kfree(orig_path);
>  	return false;
>  }
> +#endif

-- 
Kind regards,

Sakari Ailus

