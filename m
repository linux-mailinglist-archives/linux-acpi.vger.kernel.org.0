Return-Path: <linux-acpi+bounces-18191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7A2C06EC7
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF4D189D6BB
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960B32548F;
	Fri, 24 Oct 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnidcWJf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07E3093D3;
	Fri, 24 Oct 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319053; cv=none; b=bQeA8G9d6Dmha2cvJmE5Mq+x8WPzByjSN2+RHGCfeW8+k3CsEhjay4H2hn6RiPmTxH9cr16NrbjfMCm43n5zjNcCL6WVxFfj98BzLUJt9pQQqPHkZ8Ce3oWnK7pxP6lQrDbzPhBeuQbHPjysZKtptbZfXHlunNUBk7g1o3pnYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319053; c=relaxed/simple;
	bh=RNj00qgzBnBj+fWK9DQNur4wUMvK1F1KP/Ib1c7V6fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSPcveR0H1MfDVBKv9msNk8D2M0QP8k8k/3rLXWyGTnOMuu518KcnYespCuH5r/SX/gX7uUIbvrUHPSg5k7zXj0IhpHt3cZAMVsfhSwYYio1WaeGLE6tKTPqzp5FOiRgJIur4Dl2gPCkSZHXQJKNodypDnHSCnrgmfXMqPAlF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnidcWJf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761319051; x=1792855051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RNj00qgzBnBj+fWK9DQNur4wUMvK1F1KP/Ib1c7V6fQ=;
  b=fnidcWJfpjH8xqg6sXlOjorweRSGj1Kxj9dhvrIqBI5I5VnohhwJVDhK
   hyHc/EJ+B+fc6hyGFuhjPXBM2FVTOUxrBTOhtoO4jA7LM1aDF5eyrnHpY
   BPYmOT6+Rj4kF3UOcyDmIw3XlY5fGqagmx2llUk8hpHUKb6dRaoO4t8HJ
   DKAmHezskJdtrj6fgFYGjNwjZ2jkde34qBsSjyGrvNy9VBPKD+silwhfv
   xX0UGASPgjl0xi/eZrvzkHivBvI95UUM+gKM96/KU84Wv5qQEAIkSLr8d
   4uBJ+OBCjO4L6IylMBLH5y/cnUwFeixT6X2CBXRqaoZGntDz38/AuyzH7
   w==;
X-CSE-ConnectionGUID: wfjd4SPVSueCATyrx9f5AA==
X-CSE-MsgGUID: VkQoLETwSkWLtdFcqMLCoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73790716"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="73790716"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 08:17:30 -0700
X-CSE-ConnectionGUID: UlODLOwjQkyrdeMABv4F1A==
X-CSE-MsgGUID: OVoN73+USM+HxLAtG1WNFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="184828576"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.134])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 08:17:27 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9CF5B120A92;
	Fri, 24 Oct 2025 18:17:23 +0300 (EEST)
Date: Fri, 24 Oct 2025 18:17:23 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 3/9] software node: allow referencing firmware nodes
Message-ID: <aPuYg0ws8Q2sp7Wv@kekkonen.localdomain>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
 <20251022-reset-gpios-swnodes-v2-3-69088530291b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-reset-gpios-swnodes-v2-3-69088530291b@linaro.org>

Hi Bartosz,

On Wed, Oct 22, 2025 at 03:41:02PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).

That's not entirely true: you can add a software node as a secondary to an
existing OF or ACPI fwnode. This has not been used widely and it's not very
convenient to set up.

Additional properties in ACPI or OF nodes will still need the secondary
node, after these patches.

> 
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: use a union of different
> pointers in struct software_node_ref_args and add an enum indicating
> what kind of reference given instance of it is. Rework the helper macros
> and deprecate the existing ones whose names don't indicate the reference
> type.
> 
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/base/swnode.c    | 14 ++++++++++----
>  include/linux/property.h | 40 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index b7c3926b67be72671ba4e4c442b3acca80688cf7..d08b914c07691336540cdf1dfbd77a697e7b4521 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -535,9 +535,12 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  	ref_array = prop->pointer;
>  	ref = &ref_array[index];
>  
> -	refnode = software_node_fwnode(ref->node);
> -	if (!refnode)
> -		return -ENOENT;
> +	if (ref->swnode)
> +		refnode = software_node_fwnode(ref->swnode);
> +	else if (ref->fwnode)
> +		refnode = ref->fwnode;
> +	else
> +		return -EINVAL;
>  
>  	if (nargs_prop) {
>  		error = fwnode_property_read_u32(refnode, nargs_prop,
> @@ -634,7 +637,10 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
>  
>  	ref = prop->pointer;
>  
> -	return software_node_get(software_node_fwnode(ref[0].node));
> +	if (!ref->swnode)
> +		return NULL;
> +
> +	return software_node_get(software_node_fwnode(ref[0].swnode));
>  }
>  
>  static struct fwnode_handle *
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 50b26589dd70d1756f3b8644255c24a011e2617c..52e784a3dfd4c93cee8b35e1cef5e0600639ecc5 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -355,23 +355,37 @@ struct software_node;
>  
>  /**
>   * struct software_node_ref_args - Reference property with additional arguments
> - * @node: Reference to a software node
> + * @swnode: Reference to a software node
> + * @fwnode: Alternative reference to a firmware node handle
>   * @nargs: Number of elements in @args array
>   * @args: Integer arguments
>   */
>  struct software_node_ref_args {
> -	const struct software_node *node;
> +	const struct software_node *swnode;
> +	struct fwnode_handle *fwnode;
>  	unsigned int nargs;
>  	u64 args[NR_FWNODE_REFERENCE_ARGS];
>  };
>  
> -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
> +#define __SOFTWARE_NODE_REF(_ref, _type, _node, ...)		\
>  (const struct software_node_ref_args) {				\
> -	.node = _ref_,						\
> +	._node = _ref,						\
>  	.nargs = COUNT_ARGS(__VA_ARGS__),			\
>  	.args = { __VA_ARGS__ },				\
>  }
>  
> +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)			\
> +	__SOFTWARE_NODE_REF(_ref, SOFTWARE_NODE_REF_SWNODE,	\
> +			    swnode, __VA_ARGS__)
> +
> +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)			\
> +	__SOFTWARE_NODE_REF(_ref, SOFTWARE_NODE_REF_FWNODE,	\
> +			    fwnode, __VA_ARGS__)
> +
> +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> +#define SOFTWARE_NODE_REFERENCE(_ref, ...)			\
> +	SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
> +
>  /**
>   * struct property_entry - "Built-in" device property representation.
>   * @name: Name of the property.
> @@ -463,14 +477,26 @@ struct property_entry {
>  #define PROPERTY_ENTRY_STRING(_name_, _val_)				\
>  	__PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
>  
> -#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
> +#define __PROPERTY_ENTRY_REF(_type, _name, _ref, ...)			\
>  (struct property_entry) {						\
> -	.name = _name_,							\
> +	.name = _name,							\
>  	.length = sizeof(struct software_node_ref_args),		\
>  	.type = DEV_PROP_REF,						\
> -	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
> +	{ .pointer = &_type(_ref, ##__VA_ARGS__), },			\
>  }
>  
> +#define PROPERTY_ENTRY_REF_SWNODE(_name, _ref, ...)			\
> +	__PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_SWNODE,			\
> +			     _name, _ref, __VA_ARGS__)
> +
> +#define PROPERTY_ENTRY_REF_FWNODE(_name, _ref, ...)			\
> +	__PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_FWNODE,			\
> +			    _name, _ref, __VA_ARGS__)
> +
> +/* DEPRECATED, use PROPERTY_ENTRY_REF_SWNODE() instead. */
> +#define PROPERTY_ENTRY_REF(_name, _ref, ...)				\
> +	PROPERTY_ENTRY_REF_SWNODE(_name, _ref, __VA_ARGS__)
> +
>  #define PROPERTY_ENTRY_BOOL(_name_)		\
>  (struct property_entry) {			\
>  	.name = _name_,				\
> 

-- 
Regards,

Sakari Ailus

