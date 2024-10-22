Return-Path: <linux-acpi+bounces-8925-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97EC9AB998
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 00:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56030B22B82
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 22:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35C1CDA25;
	Tue, 22 Oct 2024 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJmQVHIK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C71CCEFA;
	Tue, 22 Oct 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637094; cv=none; b=bLkfzkV4E21cHo3jCmEAMFaiiSrcwL08vkqx0IcCOHXAKjhAQuLPhMExZ27TWYiVymBwPp2ArQKFJYPA+M1Ucu5mMCCRuEeMc08u6VTTTWtlfWFK3KjStNvL53cUjw3pC2ArqOe2O27bhxB2dduWUUcuZt/rnYRqJv1F7fqBHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637094; c=relaxed/simple;
	bh=40AJEEku2/+aledTHQy8tBcThqJuXsMNlt4ia9XyEKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcQmR0ibYyUxLCFweCKtEWvsFbuSartg0Ua5h28EWZOee4YJ8miQSEeoBKyelQuynEFSb7jC+D3AurpjbzFCgt9yEyKUXUF84JzDeNUHZbr7IZAHNu5ZDN13g5ZyoaiEM99aKOFRbD1l/QZEIdfsGkayaPc3DjPS9x9AcJ+nCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJmQVHIK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729637092; x=1761173092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40AJEEku2/+aledTHQy8tBcThqJuXsMNlt4ia9XyEKo=;
  b=lJmQVHIKoGQ1GlcGR6Cy2P/5lYd7cKNAiQjitCjRYeVnW+YRWLD/Tj1j
   QPeGtxCq0740vBsYni2KCT8lel2UL2gpi0vnq5Ah2KLprOPyZAWGsaNZ2
   hD0QKrcPlGXhC3d/wqsdCHQIXH/rkFUD5NL2eCFS/NoKUkii15ETisGrJ
   j/Zc2do1o6X9DrvbL1wz0Lcd5VppkJcup/YRjpyj64/Qawm9v7qCHapjP
   wQzK9UfQogKN+/GPPnRDWF50/ka9D0dM0iwFjr0C/zsuLFZM4AEaLCchm
   qYGwcZJulTezN2OeNgtOxBU0ap0Wmdpz2tIeRGBNwqkUj90UkmA4mpxYB
   g==;
X-CSE-ConnectionGUID: sn07C0/yREyOAk+eBh2vkw==
X-CSE-MsgGUID: bG+M5C7PRyKPtq8QHIocpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40322732"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40322732"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:44:51 -0700
X-CSE-ConnectionGUID: QzqXchzhQCq6Z41KSkJ8Sw==
X-CSE-MsgGUID: e0GRUKgeR1OjLNfDzfV7JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84604092"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:44:48 -0700
Date: Tue, 22 Oct 2024 15:44:47 -0700
From: Tony Luck <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 8/8] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <Zxgq33pNuWBvadet@agluck-desk3.sc.intel.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
 <20241022213429.1561784-9-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213429.1561784-9-zaidal@os.amperecomputing.com>

On Tue, Oct 22, 2024 at 02:34:29PM -0700, Zaid Alali wrote:
> Add documentation for the updated ACPI specs for EINJv2(1)(2)
> 
> (1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
> (2)https://bugzilla.tianocore.org/attachment.cgi?id=1446
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 46 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index c52b9da08fa9..3ad092111035 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -61,6 +61,14 @@ The following files belong to it:
>    0x00000800        Platform Uncorrectable fatal
>    ================  ===================================
>  
> +  ================  ===================================
> +  Error Type Value      Error Description
> +  ================  ===================================

This shows up in the html output as a separate table with the
same headers. Why not concatenate this to the existing table?

The example of EINJv2 shows these extra lines just appearing
right after the v1 lines.

> +  0x00000001        EINJV2 Processor Error
> +  0x00000002        EINJV2 Memory Error
> +  0x00000004        EINJV2 PCI Express Error
> +  ================  ===================================
> +
>    The format of the file contents are as above, except present are only
>    the available error types.
>  
> @@ -85,9 +93,11 @@ The following files belong to it:
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
> @@ -110,6 +120,7 @@ The following files belong to it:
>    Used when the 0x1 bit is set in "flags" to specify the APIC id
>  
>  - param4
> +
>    Used when the 0x4 bit is set in "flags" to specify target PCIe device
>  
>  - notrigger
> @@ -122,6 +133,18 @@ The following files belong to it:
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
> @@ -139,7 +162,6 @@ is present). The EINJ user interface for CXL error types is at
>    under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
>    must use this file.
>  
> -
>  BIOS versions based on the ACPI 4.0 specification have limited options
>  in controlling where the errors are injected. Your BIOS may support an
>  extension (enabled with the param_extension=1 module parameter, or boot
> @@ -194,6 +216,26 @@ An error injection example::
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

This seems confusing to me. Is 0x00000002 the code for a V1 processor
uncorrectable, or a V2 memory error? It seems that the "error_type" file
is interpreted differently depending on what is written to the "flags"
file.

> +
> +  # echo 0x12345000 > param1			# Set memory address for injection
> +  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
> +  # comp_arr="0x1 0x2				# Fill in the component array
> +    >0x1 0x4
> +    >0x2 0x4"

Default $PS2 prompt in bash doesn't have leading spaces before the ">".
So this example looks unnatural to me.

> +  # echo "$comp_arr" > einjv2_component_array
> +  # echo 0x2 > error_type			# Choose EINJv2 memory error
> +  # echo 0xa > flags				# set flags to indicate EINJv2
> +  # echo 1 > error_inject			# Inject now
> +
>  You should see something like this in dmesg::
>  
>    [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
> -- 
> 2.34.1

-Tony

