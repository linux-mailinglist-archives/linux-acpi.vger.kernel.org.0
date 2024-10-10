Return-Path: <linux-acpi+bounces-8686-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAB3998A36
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 16:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E9A287B00
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EF1FEFA4;
	Thu, 10 Oct 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeAYFUkx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F31FCC6F;
	Thu, 10 Oct 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570805; cv=none; b=amz6v3Yi2eHWiSO+15n9H9EUACQzXUUyleYchsiXgNP+6CX0uTuWoPdkRga+iQrTCDm/UmM1jb2mCBYwcpqayTnbLBbaU9Fp2VQKa+b0938U4aLT5TLBsG+loy+gArZhR+eW1xFbLngC/6q6lBhSWuE3ppuWBsLAozcGa8ix+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570805; c=relaxed/simple;
	bh=CxL6g3JY2Xoa93BGBObmJQDdxg5XHRQxPNG1FbbK6Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Spb+9EQFfGKAaMfohOLAJbhZe6VtSnCwWi2LDS90y/qaxnENdBpxHjRBQiM0YSW48WDLMaXKB2IiH5Zl32ofJX09NUYNq6ArAVVieWF0lR1bfrdSX9udOBixne05rWJlnr786pevJZdfZLUUFw/ljpsG+zuDaHM8OJ4H0FauPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeAYFUkx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570804; x=1760106804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxL6g3JY2Xoa93BGBObmJQDdxg5XHRQxPNG1FbbK6Ys=;
  b=NeAYFUkxJMtEIfd4raWaefxWaqjIjfgSOpGordnayhx7y+dNzo+tBpcA
   Uxbqo/xStwQgqw5a5utTuWlgN6XHkmXoHsH4Mqov4cOTZpdVHbxTLgHcu
   5WATtXb1IGOk9w0yaN/AAm0R3kpHrSGRFswikPxtHk/zDnkeudH4rqLjx
   YLpEjq3wDPxdgRM1KXHm3yWDQTQdh/o0J+ljHTHfZ9LSfJsP2n+FzBgfw
   3UL8fM9V+nFuf6hHrgMtGfXDFBHkiVdljIcSbGNUo/GowXdhT9AtvdoEe
   EPpP4O1QkKRvCW6uzbiCj2+w4VsJc+NygtGb34zUJB1BRMwulju9OncCw
   Q==;
X-CSE-ConnectionGUID: oh/hFt7RSnS3E8tK7pThyQ==
X-CSE-MsgGUID: TGH8TzcDSkCGhqTIa5j7kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45411194"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="45411194"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:33:23 -0700
X-CSE-ConnectionGUID: tvlE8FWcT1ytnWXFMPh6Lw==
X-CSE-MsgGUID: 22OpjrGaRJGVytHnQQUlnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81131870"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:33:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syuE8-00000001Z0C-2Fir;
	Thu, 10 Oct 2024 17:33:16 +0300
Date: Thu, 10 Oct 2024 17:33:16 +0300
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
Subject: Re: [PATCH net-next 3/3] net: dsa: mv88e6xxx: leds: fix leds refcount
Message-ID: <ZwflrDCm7qWVH0N3@smile.fi.intel.com>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-3-cfd7758cd176@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-3-cfd7758cd176@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 08, 2024 at 06:10:29PM +0200, Javier Carrasco wrote:
> The 'leds' fwnode_handle is initialized by calling
> fwnode_get_named_child_node(), which requires an explicit call to
> fwnode_handle_put() when the node is not required anymore.
> 
> Instead of adding the missing call, and considering that this driver was
> recently introduced, use the automatic clenaup mechanism to release the
> node when it goes out of scope.

...

> -	leds = fwnode_get_named_child_node(p->fwnode, "leds");
> +	struct fwnode_handle *leds __free(fwnode_handle) =
> +		fwnode_get_named_child_node(p->fwnode, "leds");

Can it be const?

-- 
With Best Regards,
Andy Shevchenko



