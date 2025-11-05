Return-Path: <linux-acpi+bounces-18574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72846C3966C
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 08:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB693BABF5
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29042E0B68;
	Thu,  6 Nov 2025 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCe0husl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2852DF6F5;
	Thu,  6 Nov 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414118; cv=none; b=cHtmo0cvBd1BBta7kXS1FVOoo842DnNUD8BFbxkPAPVLgHTpcEw7TIrqWy2eh/cG4dZQ+4OviUvvM9gSDU6E1DBTp56ZSo7oTOS2DSOX3ksEtoa2IY/ri7rlqRk+Er/ZQFoHjYtL+iA9QMnn47IgKpSmDSXSEEz4jIYFPNBuvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414118; c=relaxed/simple;
	bh=1wTrCw7tH2niQnnjbLnl1ZIXBSWyC/o4xO/RZgOwT9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcUDOOQFtuPmlsb1N49pE1/KXGhyKAjm8547xDe1ky2KgNF6By0pd5CoPfWBceitToD/SfxuazSn6bDqgxGbga/EZ1NDFa5YAixzxvIWyPBvUm/gGqZsT1+ht38yekOjOAgCHnS+OvdIP0umpTR6lLOQDU9qPIocp4FMWfEvfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCe0husl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762414117; x=1793950117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wTrCw7tH2niQnnjbLnl1ZIXBSWyC/o4xO/RZgOwT9Q=;
  b=fCe0huslffM3ABkqPVSCxVrB7skYiFgevz3swToEDhT97Ck6b55q/62q
   xN4vRkXAQeAgUeFPHsesQ3F8GpeS6sqkyMXf/Qp2iCanmFSwM1U5JOrhB
   GtbfsBlPvkIwQr7Ur6rlAkTceHqliYymYmfkcmVmWTTJXXi2CIvy/eEpq
   cKscMov5np1q4uZ1qCRXjJWGIB9xDsQ4YHQu4GThCxeyWuHxvGKuQGFYP
   NwFZFyL03ttA4zl0/7rNHdio08PGTI3OidoATisSyw+Nb6Zj1oAOLUaD6
   Bpv5NwX7JMrYUEYYEf8jVjsbdKQAJ66JqTw+MK7r0rf4rxU2tccphuCpq
   g==;
X-CSE-ConnectionGUID: fgDu94gcS4eH9mGFb22/1g==
X-CSE-MsgGUID: ayk0iFZpScmH0XgLm/OePQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="63747901"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="63747901"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:28:36 -0800
X-CSE-ConnectionGUID: fZ57IoJRQkaBLs/kz5cTvQ==
X-CSE-MsgGUID: cWySKE1OQGO2fBzdQv5eaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="191965191"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.151])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:28:32 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C5BB811F983;
	Wed, 05 Nov 2025 22:54:31 +0200 (EET)
Date: Wed, 5 Nov 2025 22:54:31 +0200
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
Subject: Re: [PATCH v5 3/8] software node: allow referencing firmware nodes
Message-ID: <aQu5hxGGrdPC7VOB@kekkonen.localdomain>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
 <20251105-reset-gpios-swnodes-v5-3-1f67499a8287@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-reset-gpios-swnodes-v5-3-1f67499a8287@linaro.org>

Hi Bartosz,

Thanks for the update.

On Wed, Nov 05, 2025 at 09:47:34AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).
> 
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: add a second pointer to
> struct software_node_ref_args of type struct fwnode_handle. The core
> swnode code will first check the swnode pointer and if it's NULL, it
> will assume the fwnode pointer should be set.
> 
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

But see below...

> ---
>  drivers/base/swnode.c    | 24 ++++++++++++++++++++++--
>  include/linux/property.h | 13 ++++++++++---
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 6b1ee75a908fbf272f29dbe65529ce69ce03a021..44710339255ffba1766f5984b2898a5fb4436557 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -535,7 +535,24 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  	ref_array = prop->pointer;
>  	ref = &ref_array[index];
>  
> -	refnode = software_node_fwnode(ref->node);
> +	/*
> +	 * A software node can reference other software nodes or firmware
> +	 * nodes (which are the abstraction layer sitting on top of them).
> +	 * This is done to ensure we can create references to static software
> +	 * nodes before they're registered with the firmware node framework.
> +	 * At the time the reference is being resolved, we expect the swnodes
> +	 * in question to already have been registered and to be backed by
> +	 * a firmware node. This is why we use the fwnode API below to read the
> +	 * relevant properties and bump the reference count.
> +	 */
> +
> +	if (ref->swnode)
> +		refnode = software_node_fwnode(ref->swnode);
> +	else if (ref->fwnode)
> +		refnode = ref->fwnode;
> +	else
> +		return -EINVAL;
> +
>  	if (!refnode)
>  		return -ENOENT;
>  
> @@ -633,7 +650,10 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
>  
>  	ref = prop->pointer;
>  
> -	return software_node_get(software_node_fwnode(ref[0].node));
> +	if (!ref->swnode)
> +		return NULL;
> +
> +	return software_node_get(software_node_fwnode(ref[0].swnode));

This could be:

	return software_node_get(software_node_fwnode(ref->swnode));

>  }
>  
>  static struct fwnode_handle *
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 50b26589dd70d1756f3b8644255c24a011e2617c..272bfbdea7bf4ab1143159fa49fc29dcdde0ef9d 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -355,19 +355,26 @@ struct software_node;
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
>  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
>  (const struct software_node_ref_args) {				\
> -	.node = _ref_,						\
> +	.swnode = _Generic(_ref_,				\
> +			   const struct software_node *: _ref_,	\
> +			   default: NULL),			\
> +	.fwnode = _Generic(_ref_,				\
> +			   struct fwnode_handle *: _ref_,	\
> +			   default: NULL),			\
>  	.nargs = COUNT_ARGS(__VA_ARGS__),			\
>  	.args = { __VA_ARGS__ },				\
>  }
> 

-- 
Kind regards,

Sakari Ailus

