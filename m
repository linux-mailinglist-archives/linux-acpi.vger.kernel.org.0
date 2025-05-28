Return-Path: <linux-acpi+bounces-13918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A30AC7114
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 20:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700EAA22E78
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F29428E57B;
	Wed, 28 May 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kf212wuz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8861D6195;
	Wed, 28 May 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457569; cv=none; b=JxE2RqaVY06sNc2qKw3sKR3CpBlWBXQxoUQyJudn7fsh5vEYQTNPEzHyvqOlVLeCDN9QUrHu+SsG674AS8bFY5RWh+Yz5h6axl6q7/upZw4sSP+jYznSCoVI9JGKZriv77WRhpj0Xd2IcPYxNeh6PWe4IrSItqrPGdEUyn6ufyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457569; c=relaxed/simple;
	bh=CYye3j1lrKBr4+y+Vytan0Y53gu79MOUM2VVYW6GeTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMfycL/ach1p8mHHl/rYjVzyRKiVPc/jTQdbTMUKSwA+72fwkX851oGM6GNwuLlky2Mmk8ZQxNJQQdmP4+d/bbXqdZ4PdReqVUWuVnR6jQb4BE/Os7vwB63KdME8NVnJlo3MaBaMpXJWlSxqD4JakmNFl+SjOu5824cKyXOJQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kf212wuz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748457567; x=1779993567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYye3j1lrKBr4+y+Vytan0Y53gu79MOUM2VVYW6GeTg=;
  b=kf212wuzI3X+RkEAP5FEzfFfi7Z2Syuu0CIPAXnzEHoc3riDEk9RkW7l
   fvAtYow3Jl421Ay/hfYxdRoZwr9LIrpBgQIVVqCEMYjC7/cAGbA9qPnlA
   dJQEr0RLJ5d2M3HHDO3YHBFv/pOrM9DRlQLdZk+Tt8BCZ2yB+62sxS0wW
   qPUORzVZTSGxaVET+LolO2D9IKDKKyT1GSGI/7Wqi2d7F+pY8vHdaBeZJ
   Z5WYaqUHVijBTwnJMnp4nMS/gLw2SgnEune53M20w8GNYYrybPtHg/ALe
   KhTwpQfO9hPalrt+Rj1x4hLYbhLYvFogokQRL70mY2TcMYoJmJt2tTkP5
   g==;
X-CSE-ConnectionGUID: dk/cM37/Q5Sl82/rtKglzw==
X-CSE-MsgGUID: mfowhYBBR66oblC/E3VkqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50651831"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="50651831"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 11:39:08 -0700
X-CSE-ConnectionGUID: eUUEklcUQnOp9uavjz+IfQ==
X-CSE-MsgGUID: gxGbZbAmQ1WKbGCtrvkjYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="143780102"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 11:38:55 -0700
Date: Wed, 28 May 2025 11:38:53 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <aDdYPf-4ru_cC-_D@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-7-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506213814.2365788-7-zaidal@os.amperecomputing.com>

On Tue, May 06, 2025 at 02:38:10PM -0700, Zaid Alali wrote:
> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications[1] enables
> EINJv2 by extending set_error_type_with_address struct.
> 
> Link: https://github.com/tianocore/edk2/issues/9449 [1]
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index ee26df0398fc..60e4f3dc7055 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -50,6 +50,28 @@
>   */
>  static int acpi5;
>  
> +struct syndrome_array {
> +	union {
> +		u8	acpi_id[16];
> +		u8	device_id[16];
> +		u8	pcie_sbdf[16];
> +		u8	vendor_id[16];
> +	} comp_id;
> +	union {
> +		u8	proc_synd[16];
> +		u8	mem_synd[16];
> +		u8	pcie_synd[16];
> +		u8	vendor_synd[16];
> +	} comp_synd;
> +};
> +
> +struct einjv2_extension_struct {
> +	u32 length;
> +	u16 revision;
> +	u16 component_arr_count;
> +	struct syndrome_array component_arr[] __counted_by(component_arr_count);
> +};
> +
>  struct set_error_type_with_address {
>  	u32	type;
>  	u32	vendor_extension;
> @@ -58,6 +80,7 @@ struct set_error_type_with_address {
>  	u64	memory_address;
>  	u64	memory_address_range;
>  	u32	pcie_sbdf;
> +	struct	einjv2_extension_struct einjv2_struct;

I can't make this match up with the ACPI v6.5 spec.  The spec defines
a whole new EINJV2_SET_ERROR_TYPE data structure in table 18.34 that
is NOT just a simple addition of new fields at the end of the existing
SET_ERROR_TYPE_WITH_ADDRESS data structure. E.g. the "flags" are now
in a 3-byte field at offset 5 instead of a 4-byte field at offset 8.
There is a new "length" field that descibes the total size of the
structure including the new flex array of syndrome values at the
end.

Shouldn't this look like this?

struct set_error_type_with_address_v2 {
	u32	type;
	u8	type_code;
	u8	flags[3];
	u32	length;
	u32	severity;
	u64	memory_address;
	u64	memory_address_range;
	u32	syndrome_count;
	struct syndrome_array syndrome syndromes[];
};

>  };
>  enum {
>  	SETWA_FLAGS_APICID = 1,
> -- 
> 2.43.0

-Tony

