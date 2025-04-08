Return-Path: <linux-acpi+bounces-12841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A0A7F91E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 11:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26047A64B9
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0D264A98;
	Tue,  8 Apr 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwrYfUHx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97961263C6B;
	Tue,  8 Apr 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103675; cv=none; b=UMC0Nt8yU3vynGT1WCu2CZ9eji2n6XK3McT9vf6BeeJVCFrVT/wmp3QdDCFEcPsyiZFNi04Xboummvx+/UNRajiWGQMjtL0dis7saEw7Opl4cF5uzD3BtdK/Gkfg7rlnA1yvsZ83pqRQQL86+lB/rCBU+OXeFlVxI5TQwyd2pmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103675; c=relaxed/simple;
	bh=gvibY0b3Sa3/VZFUImm9G5mH7JVGsXUzNoeyoJHUoeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1axJl4GogdCsIzgTdZQJG6h75lp9XkEIFLzU/cjRpv1Y66HTgX/68vOwSF8wTJWAV8Nfbzca5rnShD3JCHJcXReGjlUDrUNKTdaaJ4vk3giYSHmVYEekMmMdzN2X07cBVg5f9jTrTfhNmGXtdgIOotctriuYJc4MErNxCki2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwrYfUHx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744103674; x=1775639674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gvibY0b3Sa3/VZFUImm9G5mH7JVGsXUzNoeyoJHUoeQ=;
  b=YwrYfUHx5uiAUdslsD48+lCHPus2uEXejalouYZc50cjxP0oco2afexl
   3PViUneGXV0d3e01xQENebfth2LikWY0u5Lz2ErJNWM52W23UpyujN2Vz
   snx1U2FNEdrJ4hL3f+9k+nRsEhiJWtPhtW3ZncFWCNk39xn995nbefP4/
   QFDXYuVsnEK4boTFIn0gO7uc4CcFuFsFnoT0Lq8cnGIDJ3yBYvAGXbEpe
   PMD2g5DqmdjFS8qRQlAmC6QeAgHW591urnLRU7dNwrpnyT2RTGpcKC9Xa
   etPmseZH0ldwlBUOkKc+Oa/Owte+c7iZzfrc8mvqh7xyI3JWrThAEREpO
   Q==;
X-CSE-ConnectionGUID: /JJln5ejRCyFHZ0YXTLMRg==
X-CSE-MsgGUID: t6uqto/YQ9CE7htne065dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="55709144"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="55709144"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 02:14:33 -0700
X-CSE-ConnectionGUID: V1kGg9uZQr6ITUYd6/pVBw==
X-CSE-MsgGUID: xbQBXVPZSSq7Zifz9uAIUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="151398279"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 02:14:29 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EB9E411FB1F;
	Tue,  8 Apr 2025 12:14:26 +0300 (EEST)
Date: Tue, 8 Apr 2025 09:14:26 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: Add optional nargs_prop for
 get_reference_args
Message-ID: <Z_To8p6xD7aLrEVk@kekkonen.localdomain>
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

Hi Sean,

On Mon, Apr 07, 2025 at 06:37:13PM -0400, Sean Anderson wrote:
> get_reference_args does not permit falling back to nargs when nargs_prop
> is missing. This makes it difficult to support older devicetrees where
> nargs_prop may not be present. Add support for this by converting nargs
> to a signed value. Where before nargs was ignored if nargs_prop was
> passed, now nargs is only ignored if it is strictly negative. When it is
> positive, nargs represents the fallback cells to use if nargs_prop is
> absent.

If you don't know either the argument count or have a property that tells
it, there's no way to differentiate phandles from arguments. I'd say such
DTS are broken. Where do they exist?

At the very least this needs to be documented as a workaround and moved to
the OF framework. I wouldn't add such a workaround to swnodes either, the
bugs should be fixed instead.

> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/base/property.c |  4 ++--
>  drivers/base/swnode.c   | 13 +++++++++----
>  drivers/of/property.c   | 10 +++-------
>  include/linux/fwnode.h  |  2 +-
>  4 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c1392743df9c..049f8a6088a1 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -606,7 +606,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  		return -ENOENT;
>  
>  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
> -				 nargs, index, args);
> +				 nargs_prop ? -1 : nargs, index, args);
>  	if (ret == 0)
>  		return ret;
>  
> @@ -614,7 +614,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  		return ret;
>  
>  	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
> -				  nargs, index, args);
> +				  nargs_prop ? -1 : nargs, index, args);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
>  
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index b1726a3515f6..11af2001478f 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -503,7 +503,7 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
>  static int
>  software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  				 const char *propname, const char *nargs_prop,
> -				 unsigned int nargs, unsigned int index,
> +				 int nargs, unsigned int index,
>  				 struct fwnode_reference_args *args)
>  {
>  	struct swnode *swnode = to_swnode(fwnode);
> @@ -543,10 +543,15 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  		error = property_entry_read_int_array(ref->node->properties,
>  						      nargs_prop, sizeof(u32),
>  						      &nargs_prop_val, 1);
> -		if (error)
> +
> +		if (error == -EINVAL) {
> +			if (nargs < 0)
> +				return error;
> +		} else if (error) {
>  			return error;
> -
> -		nargs = nargs_prop_val;
> +		} else {
> +			nargs = nargs_prop_val;
> +		}
>  	}
>  
>  	if (nargs > NR_FWNODE_REFERENCE_ARGS)
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index c1feb631e383..c41190e47111 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1116,19 +1116,15 @@ of_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  static int
>  of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
>  			     const char *prop, const char *nargs_prop,
> -			     unsigned int nargs, unsigned int index,
> +			     int nargs, unsigned int index,
>  			     struct fwnode_reference_args *args)
>  {
>  	struct of_phandle_args of_args;
>  	unsigned int i;
>  	int ret;
>  
> -	if (nargs_prop)
> -		ret = of_parse_phandle_with_args(to_of_node(fwnode), prop,
> -						 nargs_prop, index, &of_args);
> -	else
> -		ret = of_parse_phandle_with_fixed_args(to_of_node(fwnode), prop,
> -						       nargs, index, &of_args);
> +	ret = __of_parse_phandle_with_args(to_of_node(fwnode), prop, nargs_prop,
> +					   nargs, index, &of_args);
>  	if (ret < 0)
>  		return ret;
>  	if (!args) {
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 6fa0a268d538..69fe44c68f8c 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -163,7 +163,7 @@ struct fwnode_operations {
>  				const char *name);
>  	int (*get_reference_args)(const struct fwnode_handle *fwnode,
>  				  const char *prop, const char *nargs_prop,
> -				  unsigned int nargs, unsigned int index,
> +				  int nargs, unsigned int index,
>  				  struct fwnode_reference_args *args);
>  	struct fwnode_handle *
>  	(*graph_get_next_endpoint)(const struct fwnode_handle *fwnode,

-- 
Regards,

Sakari Ailus

