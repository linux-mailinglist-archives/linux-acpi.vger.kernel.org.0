Return-Path: <linux-acpi+bounces-1133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904EC7DDF75
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C4BB20EED
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7A10A2C
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwrlbnv8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCE7475
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 09:51:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C302DDA
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698832300; x=1730368300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWC4gma32IHGIkSuWTmsP1I7MGCRUmxf49rvIvyduAY=;
  b=jwrlbnv8f3puF1KwJ0uD5i6tHlNNDAG4kcTynxFcjRGVqzjmeVuyBTNT
   +TqQvOOyuq8ztb/AYe+/pNF9pexgtm7LfEYpnC1fzWWhiFTwpudIbgGfw
   JWfFqZCgm9KxZaPWPrxHSuqav81EcfEyHkRtVBLiCQpbCXejv8wyAhgdB
   TQFy+AuA3VKnSQUHiirL48809b8RL1V5JsV5lr0eEDFNTyr+EcIPVfPWv
   L5BCYgR/dXIHPAPxHwQf+FXpiiXMcfzDm93lheAzzqgMkUWDBoNEc0FeX
   pXQeTKvLRovxqR2wbzrCokP9OOsN37QQjPGCw99LUTOhmQv8dUTPzvP4Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="419584922"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="419584922"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760889574"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="760889574"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:51:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qy7st-0000000APct-2LqI;
	Wed, 01 Nov 2023 11:51:35 +0200
Date: Wed, 1 Nov 2023 11:51:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] Make fwnode_property_get_reference_args accept NULL
 args
Message-ID: <ZUIfp43KYDvpdife@smile.fi.intel.com>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 01, 2023 at 11:07:34AM +0200, Sakari Ailus wrote:
> Hi all,
> 
> The of_parse_phandle_with_args() accepts NULL args but
> fwnode_property_get_reference_args() does not currently, in its ACPI or
> software node implementations. Fix this.

The last sentence assumes Fixes tag(s) which I can't see.

-- 
With Best Regards,
Andy Shevchenko



