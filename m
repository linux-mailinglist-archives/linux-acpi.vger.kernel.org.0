Return-Path: <linux-acpi+bounces-12839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D0A7F81C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0203B5564
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A012E263C7F;
	Tue,  8 Apr 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKNVUcvX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AED263C66;
	Tue,  8 Apr 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101599; cv=none; b=W5Sy3uaz0tez8n4RTglQr04Cypcax0aHtsR4/ohxrqTtKYy0A8r2Mb90THMMtg+U+nzL88VCG6jxNqoRCK42oygba+OjDoCCsphQ/RysC8TUPcPJGPpEgO2Ce+VMhS4SyhnraWH9oHPArBVtNNGYD8Vkyn0rKwG3RpsINpBo2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101599; c=relaxed/simple;
	bh=0aRhZnIGzwaXLS5Ml3ai/p3rxeIHVt4WKLAD37dt1/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/Oj6nUbUgK3tHeq71OyN1aa4eGz0t3103bZSPl2HpuTLaCXce2l1mJBkUJhGbavo/2eRTGw9t64Jo6YQvLbm5tli2VPEi3xkmBaJKo4Wp7gwQkyC4sT8857aHPedwAHsg4i6EO5WPezC5PIug2/aEI6SLsyxvZ/p9WC8c8PnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKNVUcvX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744101598; x=1775637598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0aRhZnIGzwaXLS5Ml3ai/p3rxeIHVt4WKLAD37dt1/M=;
  b=oKNVUcvXmxBvaWRNS+0GfNRA4SnQ6ZMGBBciPyDwcULZ0BMEsx+l3TLQ
   93MP6gDMMwmiZ+GgonQOSmPuIS2AvblGPRwH4Ic+30yNzPv+cxbxa4MtO
   4XLVxzhrciNSggqsac1S8b8qnX8rXKkEgFjeWbV0rZyPOTxQ4+7JtvzIP
   lL82gU3jwLbHkXLaHYcsB99eDXPuUSAMHkXoNpX72Fs731jmUQeEpUe+g
   phkY9PzV7ljrl9Mme593HOSe4yMgCPQEXZ6aN/YZYmOW8UveNacahCdR3
   6CKbIqIqOe5rYdsa2vMvEBKfRHMccJ8XgsbwNdNQ4bLMW1RHJhtqaHCq7
   w==;
X-CSE-ConnectionGUID: 6naiTEcGQ7aWWttRkuZ9Hw==
X-CSE-MsgGUID: Hg0kFTDSToe7QUCUF3g41A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56500840"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="56500840"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:39:57 -0700
X-CSE-ConnectionGUID: hY8JypWbQSu6ixE23mTUeQ==
X-CSE-MsgGUID: Oj3xl1cETFy6kBPtrhVMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="165430564"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:39:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u24Uo-0000000ALDC-35pE;
	Tue, 08 Apr 2025 11:39:50 +0300
Date: Tue, 8 Apr 2025 11:39:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] device property: Add
 fwnode_property_get_reference_optional_args
Message-ID: <Z_Tg1v0rlrnjs0mt@smile.fi.intel.com>
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407223714.2287202-3-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 06:37:14PM -0400, Sean Anderson wrote:
> Add a fwnode variant of of_parse_phandle_with_optional_args to allow
> nargs_prop to be absent from the referenced node. This improves
> compatibility for references where the devicetree might not always have
> nargs_prop.

...

> +/**
> + * fwnode_property_get_reference_optional_args() - Find a reference with optional arguments
> + * @fwnode:	Firmware node where to look for the reference
> + * @prop:	The name of the property
> + * @nargs_prop:	The name of the property telling the number of

Use space instead of TAB as it's already too long to make it aligned with the
rest.

> + *		arguments in the referred node.
> + * @index:	Index of the reference, from zero onwards.
> + * @args:	Result structure with reference and integer arguments.
> + *		May be NULL.
> + *
> + * Obtain a reference based on a named property in an fwnode, with
> + * integer arguments. If @nargs_prop is absent from the referenced node, then
> + * number of arguments is be assumed to be 0.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * @args->fwnode pointer.
> + *
> + * Return: %0 on success
> + *	    %-ENOENT when the index is out of bounds, the index has an empty
> + *		     reference or the property was not found
> + *	    %-EINVAL on parse error
> + */
> +int fwnode_property_get_reference_optional_args(const struct fwnode_handle *fwnode,
> +						const char *prop,
> +						const char *nargs_prop,
> +						unsigned int index,
> +						struct fwnode_reference_args *args)
> +{
> +	int ret;

> +	if (IS_ERR_OR_NULL(fwnode))
> +		return -ENOENT;

This is incorrect most likely, see below.

> +	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
> +				 0, index, args);
> +	if (ret == 0)
> +		return ret;
> +
> +	if (IS_ERR_OR_NULL(fwnode->secondary))
> +		return ret;

Here no such error code shadowing, and TBH I do not like the shadowing without
real need.

> +	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
> +				  0, index, args);
> +}

-- 
With Best Regards,
Andy Shevchenko



