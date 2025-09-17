Return-Path: <linux-acpi+bounces-17061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 743BDB7E419
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242EC1C02030
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61A30505F;
	Wed, 17 Sep 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwuD83At"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B972D7DFA
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095944; cv=none; b=kTdLSEr+zHmm/MCNRT+wLq/e04NWMZkYSs8BTzYAZJjoVYjcVUjH6JLdeExOHH9T7ESTe0aqo+/+o6z16Nat4ZyGhxK7PDfdhJ+8KlYNMcccBdevEicLmGNJRA+P/eWIOnqBDnff0Bi83ygCGL1HPBESgOB68PhtGaXm5Aa0Pes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095944; c=relaxed/simple;
	bh=D0gcYyyT0S9LCi3ksg/SIu+dbp2zkrCvzzNrtsaBS0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHV1l3r0XzNXl/u2QL+X84ocmQf8DelTIVJhLWrNL3SWO/ivPAL8FrxSSMHn7OOhEiX3I/mtJ8Zw12LR08W4+DZVLyr43wHiC0+4vhJcc2IFRGGIsGq43Z822MyI9YGP+qZ0zo3GZQZvTvldgADdc48H5YZJGfNK985bysiPkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwuD83At; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758095943; x=1789631943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D0gcYyyT0S9LCi3ksg/SIu+dbp2zkrCvzzNrtsaBS0g=;
  b=PwuD83AtRJcShXybOM/9R/UJdLfvMXEvJTgNTJvAd97xEP50GS3NQnEo
   cL2KrC/uVRIb3cPK/WlmZ3KdiLMVlvIVjRtz5aAsS3QtH4sji40OshWHN
   DKH87wttc+3ByUP3pqDN8P4VnFDUt2nmjcuLTphwPNmEKv3kFiGwCxu4a
   bFsq5rMNAmO+8dG+RK7PfhSahIScYqf9uty494vCX0cnIZfCDQGcBNEJH
   E1PhM+jJ2IQMbTknDNTxIbNw07oIXduKS5xCUZiQcFkTOnaW4RtdlT84j
   LmuG2EjRFz8Vae80E9H6p0a46xtz6X0pExbDb+0TiD+XVBYGfHl6JVQSF
   w==;
X-CSE-ConnectionGUID: xuhxphm4S2K88ijk7Adr6Q==
X-CSE-MsgGUID: BBBP60ptTvyDsLALuwtyJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71497095"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="71497095"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:59:01 -0700
X-CSE-ConnectionGUID: 4Z6Fdnh6R/Kd6pfD0OXPkg==
X-CSE-MsgGUID: b+LIFJFUT0ydsipEhCOr5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="175090595"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:58:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyn44-00000003kJk-1H3N;
	Wed, 17 Sep 2025 10:58:56 +0300
Date: Wed, 17 Sep 2025 10:58:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 03/14] ACPI: property: Return present device nodes only
 on fwnode interface
Message-ID: <aMpqQKhcBNWv5PN9@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:18PM +0300, Sakari Ailus wrote:
> fwnode_graph_get_next_subnode() may return fwnode backed by ACPI device
> nodes and there has been no check these devices are present in the system,
> unlike there has been on fwnode OF backend. In order to provide consistent
> behaviour towards callers, add a check for device presence by introducing
> a new function acpi_get_next_present_subnode(), used as the
> get_next_child_node() fwnode operation that also checks device node
> presence.

...

> +/**
> + * acpi_get_next_present_subnode - Return the next present child node handle for a fwnode
> + * @fwnode: Firmware node to find the next child node for.
> + * @child: Handle to one of the device's child nodes or a null handle.
> + * Like acpi_get_next_subnode, but the device nodes returned by

acpi_get_next_subnode()

> + * acpi_get_next_present_subnode() are guaranteed to be present.
> + */

Kernel-doc validator is not happy: Missing Return section.

> +static struct fwnode_handle *
> +acpi_get_next_present_subnode(const struct fwnode_handle *fwnode,
> +			      struct fwnode_handle *child)
> +{
> +	do {
> +		child = acpi_get_next_subnode(fwnode, child);
> +	} while (is_acpi_device_node(child) &&
> +		 !acpi_device_is_present(to_acpi_device_node(child)));
> +
> +	return child;
> +}

-- 
With Best Regards,
Andy Shevchenko



