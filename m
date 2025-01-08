Return-Path: <linux-acpi+bounces-10430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0616A0577F
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 10:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427AF1887010
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849571F76B9;
	Wed,  8 Jan 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTrTYRXe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946971F76C2;
	Wed,  8 Jan 2025 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330161; cv=none; b=KGLCkgZlYo5dl2kP6ebBCFxEQ0cGTZJfNWAS7KVvyiKksOx8xtabDegZOELYDCQ8G79vWpy5u23xnzfuZEGAMuyysjyZfdhGvr3/aZEGYlRE6PfRkhF+SHbO3zw3ntO60HlGxmTHpAM9SGfsQ9cla8+OCldEi3AYACWArWBtiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330161; c=relaxed/simple;
	bh=IZ+iP2nsjXJoqis1nS8rDf7as5EAhzqeumMQiQXrAuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7x55cZ6vHNzxkXLaD25PJcOatGfaz8312c/TmUliLpeKu0isWFgHhsoHGwM3lk5EdxOtnH6XH+z65siLtaZwkOc3TTkgdVfjugJlEWd1bOUwDYo/Zex3Mpqx+fkXzrG7a5w6vAwAbMPsjMo3z+iQ23vPZnthKE2NYek/5DSNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTrTYRXe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736330158; x=1767866158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IZ+iP2nsjXJoqis1nS8rDf7as5EAhzqeumMQiQXrAuQ=;
  b=CTrTYRXelmjEe+OiJY9lujG6NwCWmQOt24Eo+jjZgu+93sj+HOQlf3m2
   Vr4qhvP27f/Nd0XAwWvd4xG7byGYf6aWc37qGQ8/XNkHTliQKEUXq2syg
   +mG+XYxCWEsVDfI9uP8KHc3cwUaWdfLpvoYd7DWdgw8j0YwFJz/oCQco3
   CQ8TyRq2RR92MBBmJ1gdtFE+lYaBE3/4hrqlwqi3AlVh8KGO11naxmOs8
   C4lEsAYWezyU21a04uxdFfn5sOCbMT0L7Cx1Fe3B6AzQHzICYYH4sY/Zu
   Zozczel9eq6d07a9c23M/SEOrMIbJZZNZ5VgvEmzEr/LxIVhEUQM0/qoy
   g==;
X-CSE-ConnectionGUID: L5GQXTxpQsqhBOZaxVZlZw==
X-CSE-MsgGUID: CZswxysfRFy4PlHTFVEPww==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="53962465"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="53962465"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 01:55:58 -0800
X-CSE-ConnectionGUID: WcqJwRQDRKKlpnhlvZ0PiA==
X-CSE-MsgGUID: WJcSKjWaTL62HONckQyVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="107916886"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 01:55:53 -0800
Date: Wed, 8 Jan 2025 17:55:40 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com, Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk, arnd@arndb.de, ira.weiny@intel.com,
	dave.jiang@intel.com, sthanneeru.opensrc@micron.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <Z35LnJIdGgct+8jm@ly-workstation>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
 <20241205211854.43215-10-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205211854.43215-10-zaidal@os.amperecomputing.com>

On Thu, Dec 05, 2024 at 01:18:54PM -0800, Zaid Alali wrote:
> Add documentation for the updated ACPI specs for EINJv2(1)(2)
> 
> (1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
> (2)https://bugzilla.tianocore.org/attachment.cgi?id=1446
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 41 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index c52b9da08fa9..b1c0464f6002 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -59,6 +59,9 @@ The following files belong to it:
>    0x00000200        Platform Correctable
>    0x00000400        Platform Uncorrectable non-fatal
>    0x00000800        Platform Uncorrectable fatal
> +  V2_0x00000001     EINJV2 Processor Error
> +  V2_0x00000002     EINJV2 Memory Error
> +  V2_0x00000004     EINJV2 PCI Express Error
>    ================  ===================================
>  
>    The format of the file contents are as above, except present are only
> @@ -85,9 +88,11 @@ The following files belong to it:
>      Bit 0
>        Processor APIC field valid (see param3 below).
>      Bit 1
> -      Memory address and mask valid (param1 and param2).
> +      Memory address and range valid (param1 and param2).
>      Bit 2
>        PCIe (seg,bus,dev,fn) valid (see param4 below).
> +    Bit 3
> +      EINJv2 extension structure is valid
>  
>    If set to zero, legacy behavior is mimicked where the type of
>    injection specifies just one bit set, and param1 is multiplexed.
> @@ -110,6 +115,7 @@ The following files belong to it:
>    Used when the 0x1 bit is set in "flags" to specify the APIC id
>  
>  - param4
> +
>    Used when the 0x4 bit is set in "flags" to specify target PCIe device
>  
>  - notrigger
> @@ -122,6 +128,18 @@ The following files belong to it:
>    this actually works depends on what operations the BIOS actually
>    includes in the trigger phase.
>  
> +- einjv2_component_count
> +
> +  The value from this file is used to set the "Component Array Count"
> +  field of EINJv2 Extension Structure.
> +
> +- einjv2_component_array
> +
> +  The contents of this file are used to set the "Component Array" field
> +  of the EINJv2 Extension Structure. The expected format is hex values
> +  for component id and syndrome separated by space, and multiple
> +  components are separated by new line.
> +
>  CXL error types are supported from ACPI 6.5 onwards (given a CXL port
>  is present). The EINJ user interface for CXL error types is at
>  <debugfs mount point>/cxl. The following files belong to it:
> @@ -139,7 +157,6 @@ is present). The EINJ user interface for CXL error types is at
>    under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
>    must use this file.
>  
> -
>  BIOS versions based on the ACPI 4.0 specification have limited options
>  in controlling where the errors are injected. Your BIOS may support an
>  extension (enabled with the param_extension=1 module parameter, or boot
> @@ -194,6 +211,26 @@ An error injection example::
>    # echo 0x8 > error_type			# Choose correctable memory error
>    # echo 1 > error_inject			# Inject now
>  
> +An EINJv2 error injection example::
> +
> +  # cd /sys/kernel/debug/apei/einj
> +  # cat available_error_type			# See which errors can be injected
> +  0x00000002	Processor Uncorrectable non-fatal
> +  0x00000008	Memory Correctable
> +  0x00000010	Memory Uncorrectable non-fatal
> +  0x00000001	EINJV2 Processor Error
> +  0x00000002	EINJV2 Memory Error
> +
> +  # echo 0x12345000 > param1			# Set memory address for injection
> +  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
> +  # comp_arr="0x1 0x2				# Fill in the component array
> +    >0x1 0x4
> +    >0x2 0x4"
> +  # echo "$comp_arr" > einjv2_component_array
> +  # echo 0x2 > error_type			# Choose EINJv2 memory error

Missing the V2_ prefix here.

Regards,
Yi Lai

> +  # echo 0xa > flags				# set flags to indicate EINJv2
> +  # echo 1 > error_inject			# Inject now
> +
>  You should see something like this in dmesg::
>  
>    [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
> -- 
> 2.34.1
> 

