Return-Path: <linux-acpi+bounces-8684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C919989E8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7464028B6E5
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3071D041A;
	Thu, 10 Oct 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExBlpLfp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B31CBE92;
	Thu, 10 Oct 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570652; cv=none; b=sn6icexVpLVSf0ALvGeKUMXQjdQK2aW67AFzlxokd5io3YEJElIB/s2d8U7k4qVH4K1ahN6RiiHHoq6VgKHC0o/059VrLw60xXIbXlDWjOISLw/2rCzicW9WH7qaqRZ0aFuLYqjmEdhHSrNZj+tFzdvFyfbNJqzZkjjoXCctdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570652; c=relaxed/simple;
	bh=ki1ge6uJ2MUXjDdkEh1JCuz/uTFqNmn8J3n+kLuQJ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1lMFYEJ7g8ZZgh4uFj4o3EvKFIM4xoO8AMB2YZaaHjxNDBIUAVbMiOoBmuYkXz8GGC/J4HNnGExhQUEq7gyiyfOBYObE7mKbz6lPvlEi0c7n9awwaMdQgEWEEXGQ78Tm3br6TVkJgDHDIHfdkhCwfDRrDKPbQrTvI3HEuNhXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExBlpLfp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570651; x=1760106651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ki1ge6uJ2MUXjDdkEh1JCuz/uTFqNmn8J3n+kLuQJ6k=;
  b=ExBlpLfppGdc2dcSes4bDZSqN4Vx0jfyqZas5DxL+HRpdnhmekjzh9hU
   5Dm71kSkzCBnbEwcZbwa7/Zd011R1qelCWj3eV3e4aXenb6TW9SaUj6T0
   jYEP9j+JIBwRzv0+CsU1oJsx0jtoq9DHq0bEeu0fQbazIwEcVrWjtlVyt
   NdvJiEQYfttNtTf2abNPaZMylm3ukPgbBkuXAR/SOzaMqyrVXuGU3EIEM
   DTeV60qcrp4408e+xi99a185Da3NHxkbw5E3sE7bWR7ckt+M9zj0/w7EE
   SJ+o7olQ5GtxgTFQeqov+wXIBV1b8EZV82tTEh996Sv5fHeYAPQsiBA9L
   Q==;
X-CSE-ConnectionGUID: VEEFJzpdTwGCQ9q/keNgBw==
X-CSE-MsgGUID: VTgzpJiPSqChLznQLO0ixg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45410740"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="45410740"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:30:50 -0700
X-CSE-ConnectionGUID: hs40WszXRa6Z5D2Z/cwumA==
X-CSE-MsgGUID: k4ACoV6ZTZ2MyWo9ckE43A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76607191"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:30:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syuBe-00000001YxS-2nFN;
	Thu, 10 Oct 2024 17:30:42 +0300
Date: Thu, 10 Oct 2024 17:30:42 +0300
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
Subject: Re: [PATCH net-next 2/3] net: dsa: mv88e6xxx: leds: fix led refcount
 in error path
Message-ID: <ZwflEqdeQ43Wgn2K@smile.fi.intel.com>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-2-cfd7758cd176@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-2-cfd7758cd176@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 08, 2024 at 06:10:28PM +0200, Javier Carrasco wrote:
> The 'led' fwnode_handle within fwnode_for_each_child_node() must be
> released upon early exits by means of an explicit call to
> fwnode_handle_put(), which in this case is missing.
> 
> Instead of adding the missing call, and considering that this driver was
> recently introduced, use a scoped variant of the loop to automatically
> decrement the child's refcount when it goes out of scope.
> 
> Note that the _avaialable_ version of the loop has been used, as there
> is no apparent reason to walk over unavailable nodes.

...

> -	struct fwnode_handle *led = NULL, *leds = NULL;
> +	struct fwnode_handle *leds = NULL;

Can it be const now?

-- 
With Best Regards,
Andy Shevchenko



