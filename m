Return-Path: <linux-acpi+bounces-18119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D81BFDF38
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 21:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C9A3A7CAC
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150C34EEF6;
	Wed, 22 Oct 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEyT5Lhy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD88244693;
	Wed, 22 Oct 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159598; cv=none; b=sG32XxoRsdGXiJe1x+g0Fo3O8dz1lTHI7ADHTVj1heFrIbAzjHDhxh5+6zhy3Na6gdz+ACHYi2ZtgwWj41dzk/CfYW5MmSRM1YCPhJ3GaTPOVItquX6Da8iiRZmtUcVK3qLhyqXksRcVPP3tNajGkJPv/BkbV01TRd11iBLRav0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159598; c=relaxed/simple;
	bh=MinJ1GkLy+Eime5i9wQsvq/rKJ8XV5DdSawYauX9FEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJuLplet5N5g/6wPiUiikhB47lmTLIvpLABzt1ZHBbru9LhcR6tJUFV34Bnhxe4A05uNOpZAWXtQgfmW+deaABpX7uhBeleTEh0VjC8s4JsvtElVRRwgpQV+Wlw3u6m7/FA6ZCn5DmkXA3wvyPzVV9ogtLMC/RZcaAdJu88Aftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEyT5Lhy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761159596; x=1792695596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MinJ1GkLy+Eime5i9wQsvq/rKJ8XV5DdSawYauX9FEw=;
  b=kEyT5Lhyc2e5KqSjSQ13j9hzOqq97iKqRfms01u8bycDcHA1dz3BIAdl
   d7cou0zHDfEkOxFundtOvMpVCl+K8NfFSSbjxW5rDvNjAeNUVH6jbm9of
   ER7nnmUvsb8rDa+lU4tU8SIGT0JO9oTfY3LU3HUrvBxLAsz+DrRoTRaEm
   NKVgZHBAIO6NqEFkPhMJjx9gWcRfVjDCVY1rKm5HS/kiIQkmPg4g3bIff
   xpzzEjnza13XtUaIemjASLi9y+Lzd61v5jo4vU5auay7bCsMP3WxyaTmM
   Tng52m0a+/sce1+4BvIJjbJWdpDB1pQ8zrejhs1TPKnr2M7I6mGls7HUU
   A==;
X-CSE-ConnectionGUID: knb/JTX/QrqvazRB8WU68g==
X-CSE-MsgGUID: g4Wh8iZ5TzCwk+Xmm3CAwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73988876"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="73988876"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 11:59:55 -0700
X-CSE-ConnectionGUID: D+qrq3KYRamGQEPF8aVIbg==
X-CSE-MsgGUID: JUqagp/tTm67t7nD5iqU0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="184342022"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.83])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 11:59:52 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBe3p-00000001lqD-3K7M;
	Wed, 22 Oct 2025 21:59:49 +0300
Date: Wed, 22 Oct 2025 21:59:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 3/9] software node: allow referencing firmware nodes
Message-ID: <aPkppRTFKFxqAxKp@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 22, 2025 at 03:41:02PM +0200, Bartosz Golaszewski wrote:
> 
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).
> 
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: use a union of different

Still union?

> pointers in struct software_node_ref_args and add an enum indicating
> what kind of reference given instance of it is. Rework the helper macros
> and deprecate the existing ones whose names don't indicate the reference
> type.

> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.

...

> -	refnode = software_node_fwnode(ref->node);

> -	if (!refnode)
> -		return -ENOENT;

Why is this being dropped?

> +	if (ref->swnode)
> +		refnode = software_node_fwnode(ref->swnode);
> +	else if (ref->fwnode)
> +		refnode = ref->fwnode;
> +	else
> +		return -EINVAL;
>  

...

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

I do not see a point of making these three instead of two direct ones.
But I have no strong objection either.

-- 
With Best Regards,
Andy Shevchenko



