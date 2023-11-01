Return-Path: <linux-acpi+bounces-1134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 270097DDF77
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0381F21990
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3DD11193
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSeDm8kM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388FD26B
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 09:52:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A936DA
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698832371; x=1730368371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNYT+HUqkH65sNtbZp7zoplbjthe4coDJ5B2nBzdElo=;
  b=iSeDm8kM88Zs9BrGHx4n7wRGxd7vZ9QgLSwUlNgJnIepFZfNUHmreuz7
   RPGCeKrIXFlIztmzwqZkNZ4gKjssyVt32sP1OEcRQVA8KdVv2rzQFFLQH
   sLzahRM1CPi3kvWJ8gs9/FOGsLefOrQevfhZS+CSJ3KjlCmxj5CGZOrYX
   q4F3KvsSEVtxqp0MzGHysCgkzSBEk6po4y4L46fj+2si40DWZnCFp2Hr2
   8h/tWp02AYFc64rBV8W3zGHNJNF/gzJsyfMnYeT2gvDCQN0/xXBpiOvJq
   t4GTJ/1CqpsBshaeBAMYxzkxVRL1/U82Al/E8JzIONXT+MJ9Fydk9D88k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="419585131"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="419585131"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760890050"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="760890050"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:52:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qy7u2-0000000APeP-1t6v;
	Wed, 01 Nov 2023 11:52:46 +0200
Date: Wed, 1 Nov 2023 11:52:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] acpi: property: Let args be NULL in
 __acpi_node_get_property_reference
Message-ID: <ZUIf7iyxVRdpgg94@smile.fi.intel.com>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
 <20231101090737.1148303-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101090737.1148303-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 01, 2023 at 11:07:35AM +0200, Sakari Ailus wrote:
> fwnode_get_property_reference() may not be called with args argument NULL
> on ACPI, OF already supports this. Add the missing NULL checks and
> document this.
> 
> The purpose is to be able to count the references.

...

> + * @args: Location to store the returned reference with optional arguments (may
> + *	  be NULL)

I would wrap it as

 * @args: Location to store the returned reference with optional arguments
 *	  (may be NULL)

-- 
With Best Regards,
Andy Shevchenko



