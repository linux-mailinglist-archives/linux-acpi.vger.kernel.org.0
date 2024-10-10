Return-Path: <linux-acpi+bounces-8685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36128998A28
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EDE1F25711
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F41CBEB1;
	Thu, 10 Oct 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BObHiyHH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F491FAC32;
	Thu, 10 Oct 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570763; cv=none; b=lus25h1Ij7jvBvygOoB8KC4b2383eiLsdhss8R262ldfq2tG0MI8mzXNbPoXt6FAyVX8fPd/6fKccYxHIrqEzdcdXQLDZLxvhx7jXXltXKEzFrE5+VBCcEhMouIQcNnQCYEfqpK+z4Tiw6SAzxvigtPWGVRGEU/Z8peI42MFTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570763; c=relaxed/simple;
	bh=PUa5xpnOe7r4w/uXxujoW922mrbPGMhmHsNxJk2HOoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVYh3+yhlrfyvf9WqW8pD1ORhIFiaMpSTPzZNGCdw135iZ0kHa9uvOoP6DdmZpOmo+bPujQ8fHSIP5N9yRZH7IYh4L36RAkhnXQPdxcvLfpAtOJX92Vfxeir2TrZ7yQGjXX5hODU4cALT/ACC1ULpW6WwFm0SH0CTZXvaGocnic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BObHiyHH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570762; x=1760106762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PUa5xpnOe7r4w/uXxujoW922mrbPGMhmHsNxJk2HOoo=;
  b=BObHiyHHo/WHjRoFuO5QU5oZE1o+MdxssNxheKqoOVYoid8PvP3GmjcU
   rLVshne7QClO6TPkQD71dNBFOmiRigWmucHBpeXGL787nX/eIy63WYJaU
   3Y4mpqD4qxyPm0RA5MzRwxKFybEt/4ThU8PVwGQJNcHxCxssyFtV+k10U
   wjfuWPFs3ihP1r66dDhXepd0l/Cn/FIf34VxfvJDdkt+Yw/bbhEVfRSdU
   bEMr4FvvYyMPzQCVK8jw0OvtCbZkAozVeO4Zk9vBfx7q5HSBBG4X2kZez
   XK3CZJHRUcWotI1MbI2a3TEDntaJPHEE/EWos7T2pwjcFKYfe1Jd+xXsz
   w==;
X-CSE-ConnectionGUID: BqV9qnM6T8+9Yml/3NA3eg==
X-CSE-MsgGUID: WQar9AcaQcutPKnD/3Y0bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28019320"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28019320"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:42 -0700
X-CSE-ConnectionGUID: uLlhrg0USj+KYOXoxaK2+A==
X-CSE-MsgGUID: iQhptouGTNi6u6fhrQxo2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="80605892"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syuDS-00000001YzO-41qd;
	Thu, 10 Oct 2024 17:32:34 +0300
Date: Thu, 10 Oct 2024 17:32:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] device property: Introduce
 fwnode_for_each_available_child_node_scoped()
Message-ID: <ZwflgnQe6l9iTfeP@smile.fi.intel.com>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-1-cfd7758cd176@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-1-cfd7758cd176@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 08, 2024 at 06:10:27PM +0200, Javier Carrasco wrote:
> Introduce the scoped variant of the
> fwnode_for_each_available_child_node() to automatically decrement the
> child's refcount when it goes out of scope, removing the need for
> explicit calls to fwnode_handle_put().

...

> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	       \
> +	for (struct fwnode_handle *child __free(fwnode_handle) =	       \
> +		fwnode_get_next_available_child_node(fwnode, NULL); child;     \
> +	     child = fwnode_get_next_available_child_node(fwnode, child))

I like the wrapping you have done here.
Can you align the device_for_each_child_node_scoped() to follow your variant?

(probably in an additional patch)

For this one
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



