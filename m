Return-Path: <linux-acpi+bounces-18438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4789C2AD87
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7D61893887
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E22F9D89;
	Mon,  3 Nov 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIJHQk+2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39B2F9987;
	Mon,  3 Nov 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163370; cv=none; b=K1Ao9nvWntEzafhQ7imXKmS2tlwoojWAu3HzybEHhqG9iptfdpd3g+aNLeSsbadqrraoZoqRGjs5k3V2d6+yPBf1i2vbtbOjJPrisu1aTvMy5dimiUDcLndqpKM/jFjvsLy/mN+57mt617q2TL+QX8X/no2b3/BNlQ8SepCpQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163370; c=relaxed/simple;
	bh=vG9zLhPDW7K8NUwgsTT8uAJdai2F1EJGuKPUTSsmIKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBTSqo3XXMaauMuNOVv9oSAzugGPCk6E9VEJBETFZqv3fhlgTrnwy8pz0OCbONo5M7LUGMMFFSWFxfamKmzoBCEUq0PF4+Wg30W8f49rLd6r7hQFlwSrIud3o82Vchkw3NW3m9ifC0RxWVpN3HK9LkillpWI28zb1LiioAvDKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIJHQk+2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762163369; x=1793699369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vG9zLhPDW7K8NUwgsTT8uAJdai2F1EJGuKPUTSsmIKw=;
  b=YIJHQk+2reSsxGGjbnReVqEeBPfZoySArGrqFvLQ8c40KLRcCMnFXnMp
   hgwhTAkKDgnAmkhyhWB4ghOHTn6pULbWV2FY5pdqSLcd8LsLy8tLBZWdD
   uIwjMLMT3+VkULf1VDZG7mJyXVogArvEKG9rtDUMuKdBpXXqR0yt/xBuN
   5EVr76RqYhgj7zbg/DKSuRcnvBpzjgX98+8Cj3hfpkeostyfSGilWGTbm
   6tQXfHD/S12A45YjuAkuv6Fi/TT88uqzYKvddcrcRwwELdW86JT83bxCY
   bCTtdaCegOCJ0KJzEhoevFG0AmKX6/YzcY8D9PbJAJYcB8k73qANcWcye
   g==;
X-CSE-ConnectionGUID: 0MDWZg4xRjOeuUYciw0yXw==
X-CSE-MsgGUID: 35N/gOrPQ06oEaIDJTkNSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="66847762"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="66847762"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:49:28 -0800
X-CSE-ConnectionGUID: mjEiHSGESqy9XFXxvVzC2g==
X-CSE-MsgGUID: TNSndF7CTfWQmydTJLdHrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="217649008"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:49:26 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFrBg-000000056xO-1dpX;
	Mon, 03 Nov 2025 11:49:20 +0200
Date: Mon, 3 Nov 2025 11:49:19 +0200
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
Subject: Re: [PATCH v4 03/10] software node: allow referencing firmware nodes
Message-ID: <aQh6n2XuI0oayg2g@smile.fi.intel.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:35:23AM +0100, Bartosz Golaszewski wrote:
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
> will assume the fwnode pointer should be set. Rework the helper macros
> and deprecate the existing ones whose names don't indicate the reference
> type.
> 
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.

...

> +	/*
> +	 * A software node can reference other software nodes or firmware
> +	 * nodes (which are the abstraction layer sitting on top of them).
> +	 * This is done to ensure we can create references to static software
> +	 * nodes before they're registered with the firmware node framework.
> +	 * At the time the reference is being resolved, we expect the swnodes
> +	 * in question to already have been registered and to be backed by
> +	 * a firmware node. This is why we use the fwnode API below to read the

A nit-pick (since anyway it requires a new version): move 'the' to the next
line to make them more equal in the length.

> +	 * relevant properties and bump the reference count.
> +	 */

...

> -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
> +#define __SOFTWARE_NODE_REF(_ref, ...)				\

No, NAK. The renaming of the parameters is not related to this change _at all_.
Why do you change established style here? Did I miss your answer to my question
in the previous rounds?

>  (const struct software_node_ref_args) {				\
> -	.node = _ref_,						\
> +	.swnode = _Generic(_ref,				\
> +			   const struct software_node *: _ref,	\
> +			   default: NULL),			\
> +	.fwnode = _Generic(_ref,				\
> +			   struct fwnode_handle *: _ref,	\
> +			   default: NULL),			\
>  	.nargs = COUNT_ARGS(__VA_ARGS__),			\
>  	.args = { __VA_ARGS__ },				\
>  }

...

> +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)			\
> +	__SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> +
> +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)			\
> +	__SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> +
> +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> +#define SOFTWARE_NODE_REFERENCE(_ref, ...)			\
> +	SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)

Now, useless.

...


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

Do we need this now? I assume that _Generic() takes case of this.

...

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

Seems like useless churn.

-- 
With Best Regards,
Andy Shevchenko



