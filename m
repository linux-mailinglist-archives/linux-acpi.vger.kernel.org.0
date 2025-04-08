Return-Path: <linux-acpi+bounces-12838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A8A7F80D
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0065818885B1
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508302627EA;
	Tue,  8 Apr 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yp4ZVFaS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49320B7EF;
	Tue,  8 Apr 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101447; cv=none; b=UbMDXEBc8X0JLNkCQf/RqtkB6/3c6TbUe5oJW/mYGxepkDfRBdf4JVAXWD7tjc6JN0/0VLWISjN2NJ+7Meltz9SMmNqCPEMuH+btfkmoFR8wW17DnpvO/8Tgjux6j6juo//+3z2hDQWBVGnaXTs66qiJduKZUunaYsUBtzUJhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101447; c=relaxed/simple;
	bh=SvXSy4Bwc8FNM6LghY0/XjdUPptV5lIp/P0jRiL6ISQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKMsTCGD+6X+PizKMr5Y2vBrzyrJJZfTaDvNiI7p195AKefeRlO83cW611sXvt6WO1Sv8gSXCT3D9I/UalDZki4Shjt/IKr5/mGU+v6q6pvKpknvNNMMMOae2X7SFsO4mJrzD8BSNa9Q46JTxwmMLSHEk++wjTbF0aMIgPBKIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yp4ZVFaS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744101446; x=1775637446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvXSy4Bwc8FNM6LghY0/XjdUPptV5lIp/P0jRiL6ISQ=;
  b=Yp4ZVFaSQpqGEYLu8ekNDOaaYlTNkOUuohFUTNz4WNThBtGYMcJNzLDG
   z0pCHK/o+7DF24wbNb3q0g71QPrkKIhybJ6ZSRWnbpg5OlTmnf4O+f4Gn
   1dtn8j2HtXO/BFj1uRp9ovKFLsH5f9fqx2zSBvBVYWnceEId/km4Ehk0u
   d2VrptegYZSNj4mBiQGsSx9t5cOSOIMYin0VxF5oEY40D1y8p4OVaLI8O
   cTIpmDrMRuy+dYVboG6Ijgo+glsHxHAHJSHhin59rtE2jXkdS6ftbIfw3
   Gocb120mGJGSyVj8TlpyD3cp1OJ8q4tGsUmexIXQI65eMVTT7KLtScnyL
   Q==;
X-CSE-ConnectionGUID: gvtAdtUSTJymApEX919Tug==
X-CSE-MsgGUID: pqcemKqCRvmcZ353Ayq4Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="67994266"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="67994266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:37:25 -0700
X-CSE-ConnectionGUID: jpTNmXQaT9+L7DNYwIqmJw==
X-CSE-MsgGUID: ikIri5WYRNCpI9WfHswheQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="128533582"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:37:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u24SN-0000000ALAx-1TUY;
	Tue, 08 Apr 2025 11:37:19 +0300
Date: Tue, 8 Apr 2025 11:37:19 +0300
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
Subject: Re: [PATCH 1/2] device property: Add optional nargs_prop for
 get_reference_args
Message-ID: <Z_TgP0epJ3cJzlUt@smile.fi.intel.com>
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407223714.2287202-2-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 06:37:13PM -0400, Sean Anderson wrote:
> get_reference_args does not permit falling back to nargs when nargs_prop
> is missing. This makes it difficult to support older devicetrees where
> nargs_prop may not be present. Add support for this by converting nargs
> to a signed value. Where before nargs was ignored if nargs_prop was
> passed, now nargs is only ignored if it is strictly negative. When it is
> positive, nargs represents the fallback cells to use if nargs_prop is
> absent.

And what is the case to support old DTs on most likely outdated hardware?

...

>  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
> -				 nargs, index, args);
> +				 nargs_prop ? -1 : nargs, index, args);

>  	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
> -				  nargs, index, args);
> +				  nargs_prop ? -1 : nargs, index, args);

I don't understand why it's needed here. The nargs_prop is passed to the callee.

...

> -				 unsigned int nargs, unsigned int index,
> +				 int nargs, unsigned int index,

As per above.

...

>  		error = property_entry_read_int_array(ref->node->properties,
>  						      nargs_prop, sizeof(u32),
>  						      &nargs_prop_val, 1);
> -		if (error)

> +

Stray blank line.

> +		if (error == -EINVAL) {

Why do we need an explicit error code check? This is fragile. Just check the
parameter before calling the above.

> +			if (nargs < 0)
> +				return error;
> +		} else if (error) {
>  			return error;
> -
> -		nargs = nargs_prop_val;
> +		} else {
> +			nargs = nargs_prop_val;
> +		}

...

>  of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
>  			     const char *prop, const char *nargs_prop,
> -			     unsigned int nargs, unsigned int index,
> +			     int nargs, unsigned int index,
>  			     struct fwnode_reference_args *args)

Same comments as per above.

-- 
With Best Regards,
Andy Shevchenko



