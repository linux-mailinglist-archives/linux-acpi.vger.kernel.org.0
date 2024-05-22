Return-Path: <linux-acpi+bounces-5938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC48CC05D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 13:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06B31C21823
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F28287D;
	Wed, 22 May 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEhmjH5f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5357F7FD;
	Wed, 22 May 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377864; cv=none; b=N1b5mVhgf7ozRSR72ML6KtxtBkNJU7Gps2rlPAvSIYnrNJQJOpePw23RL159SIx8+7Vy1az4dKdxy941sGOVVt9LhwjOiPXPx2zTZl8GMtW0VJBTOGNs/E6Y0r5M3WpYFYDH9l6VLZYGxok1fqtZW362tGbZpv7ofLI1LgwdYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377864; c=relaxed/simple;
	bh=ncAhPReHQsINppuuHQJkanT4redij6dVT742FCMChbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfClAPe0CPdmYSBZVACJcGUyh244JGQRAvl3KbR0znPH3Uc4m1cW6uah61evpHsrz/n0MJm8+N9eHX4tp3qR2Cc7Y3GVmqruTf8K9Z7v8oM/B2pMnjp0qbgUE31z/PLV1BMSI9y9IuICvauk4KbLthRY1ViS2FWmDd/bvgQdxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEhmjH5f; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716377863; x=1747913863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ncAhPReHQsINppuuHQJkanT4redij6dVT742FCMChbE=;
  b=QEhmjH5fvx6tz/NdjFlLd+xVHBZr5o+3qO6BdBQz9cZ7ZSm2IbsZtZyd
   0j/QqQanCJGWvHLx7GiZuEQ50X5zoG39QRxaZSDFjb9L+PiEEkror0H7I
   Zuk3ZXP473XTqbZwVyH33kId/gMSw9WXeKoRvcvwRbZTgURZXu1DDkxPE
   WPVg+5HLrDmh7kzyonoDgg65T+L5wNz5QkbjP/UrfA4eczJ2bZFLcIqaM
   e3oCRXX/m+EUmxfaMK3rZgEesl7cc+sonFT0+gNLN4odW8X5333ykcC2p
   GURYGs4bexH47qPOXMP/7Lw7zSR6Zw8JTRndDnnfAetV2gcwgxEZGgpgP
   w==;
X-CSE-ConnectionGUID: O0RureqgTnCmiXV+CWQSfg==
X-CSE-MsgGUID: HHzPlGtkTuKRS14vD9wuWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16450460"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16450460"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:37:42 -0700
X-CSE-ConnectionGUID: uXLZJLUITt2/WzQ36eXdfA==
X-CSE-MsgGUID: O5as8n//Qre+NXSX2RI5UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37842814"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:37:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9kHn-00000009xQt-44Tc;
	Wed, 22 May 2024 14:37:35 +0300
Date: Wed, 22 May 2024 14:37:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ltc2992) use
 fwnode_for_each_available_child_node_scoped()
Message-ID: <Zk3Y_5B8lR0wHpD8@smile.fi.intel.com>
References: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
 <20240522-fwnode_for_each_available_child_node_scoped-v1-2-1188b0da12dc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-fwnode_for_each_available_child_node_scoped-v1-2-1188b0da12dc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 11:18:08AM +0200, Javier Carrasco wrote:
> The error path from a zero value of the "shunt-resistor-micro-ohms"
> property does not decrement the refcount of the child node.
> 
> Instead of adding the missing fwnode_handle_put(), a safer fix for
> future modifications is using the _scoped version of the macro,
> which removes the need for fwnode_handle_put() in all error paths.

Not sure if the fix for easier backporting is better, up to Guenter and Greg.
If the above is the case, you will need

1) backportable fix;
2) the patch 1 as of this series;
3) conversion patch.

> The macro defines the child node internally, which removes the need for
> the current child node declaration as well.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
in case it will go the current way.

-- 
With Best Regards,
Andy Shevchenko



