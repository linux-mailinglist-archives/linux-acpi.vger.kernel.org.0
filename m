Return-Path: <linux-acpi+bounces-7330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D65948411
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 23:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436151F2195D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864EE16C6AB;
	Mon,  5 Aug 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPNMW4Wp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC613C90F;
	Mon,  5 Aug 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892920; cv=none; b=eboWkwI1HE5ajQL3F61NSvawNau6liBJNk1lg28UO33wjjte/RISvlEwAm44tGw8yDEB2l1FTA4Z+yYLLiFkYHI9r9ruF6ESDAlj7oGh1mCC+DVS7hrYeVDkQ/bLJ+Ygw3XkI8CKKY8K9FRZMD9rPjhYTwjoGSGBu5JSQcKkCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892920; c=relaxed/simple;
	bh=pdDwVx0SrBv9fI/ED8pF9vvZBPQg58jos493b7/rXlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx8AP5mCvHA85jb7WnMTGpi5TlPLmlVT8x/auoBnH43acbfGV0uEFXMHXDFvOK3GsHJNCCgnDZtW1NE0ICXfqoJf3Tgwy4uQktdODD7YntjV8O6n5/QytHULQh9tQGrNIlwcw90bG9n+v+xpeZ9UtLUaHCdFwJBedR/XG4/wEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPNMW4Wp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722892918; x=1754428918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pdDwVx0SrBv9fI/ED8pF9vvZBPQg58jos493b7/rXlk=;
  b=PPNMW4WpLzzAjLW/i4WOmfbR6/dDs0BHMShm2HlZtM/1Rbeb3PMFSgvx
   Ug3hXBLn9GVufiMdPy1hUFmhMxE1ZZH5qXoVypn9LH2u64cawzIr2kAQa
   A9f7wBeW0+cbjT4wWl5/okmLFidZ/yVbVKV4mBM2DEwIjSz7T4ul4xI8Z
   CDiT6VjPqXiehEbLulOgSjQdQEUIKq4sclrX6dJZH6eQLyrJVQZe2hCxD
   C3wkKMlXxZsmxTqKialGp/Mt+w1MWgJ05o4la++U39+nHODqhLgoJrUiz
   F3w9Zb1PgzeBr6FD4aS1oHvKCQnlO+mvGoZ279o9yhdo6W6B5FzoBVNiO
   w==;
X-CSE-ConnectionGUID: Bd+uK6FPSfG2qouVjquScQ==
X-CSE-MsgGUID: Pfk6U7yGR1CP04jOTtWeYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21004375"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="21004375"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 14:21:57 -0700
X-CSE-ConnectionGUID: J+G+E7ZORWWBYKLcXODpcQ==
X-CSE-MsgGUID: g7bPm9ThSTKNBR9V1eXsGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="56501977"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 14:21:53 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9D60F11F965;
	Tue,  6 Aug 2024 00:21:49 +0300 (EEST)
Date: Mon, 5 Aug 2024 21:21:49 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 1/4] device property: document
 device_for_each_child_node macro
Message-ID: <ZrFCbVdFIvgX-iXq@kekkonen.localdomain>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
 <20240805-device_for_each_child_node-available-v3-1-48243a4aa5c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805-device_for_each_child_node-available-v3-1-48243a4aa5c0@gmail.com>

Hi Javier,

Thanks for the patch.

On Mon, Aug 05, 2024 at 04:49:44PM +0200, Javier Carrasco wrote:
> There have been some misconceptions about this macro, which iterates
> over available child nodes from different backends.
> 
> As that is not obvious by its name, some users have opted for the
> `fwnode_for_each_available_child_node()` macro instead.
> That requires an unnecessary, explicit access to the fwnode member
> of the device structure.
> 
> Passing the device to `device_for_each_child_node()` is shorter,
> reflects more clearly the nature of the child nodes, and renders the
> same result.
> 
> In general, `fwnode_for_each_available_child_node()` should be used
> whenever the parent node of the children to iterate over is a firmware
> node, and not the device itself.
> 
> Document the `device_for_each_child node(dev, child)` macro to clarify
> its functionality.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  include/linux/property.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 61fc20e5f81f..da8f1208de38 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -171,6 +171,16 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child);
>  
> +/**
> + * device_for_each_child_node - iterate over available child nodes of a device
> + * @dev: Pointer to the struct device
> + * @child: Pointer to an available child node in each loop iteration
> + *
> + * Unavailable nodes are skipped i.e. this macro is implicitly _available_.

Is it?

I think this was brought up previously but I understand there's an
available check on OF but not on ACPI, so on OF the availability-agnostic
and availability-aware variants are the same.

Both in OF and ACPI a node that's been marked not available simply isn't
there so as far as I understand, the semantics are the same. There's a
difference though: in OF every node can be tested for availability whereas
on ACPI only device nodes can (there are data nodes, too, for which the
availability test is always false as it's pointless to test them in the
first place).

So overall I guess the code is mostly ok be but the caller does need to be
careful with the differences.

> + * The reference to the child node must be dropped on early exits.
> + * See fwnode_handle_put().
> + * For a scoped version of this macro, use device_for_each_child_node_scoped().
> + */
>  #define device_for_each_child_node(dev, child)				\
>  	for (child = device_get_next_child_node(dev, NULL); child;	\
>  	     child = device_get_next_child_node(dev, child))
> 

-- 
Kind regards,

Sakari Ailus

