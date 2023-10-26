Return-Path: <linux-acpi+bounces-1017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB07D82B7
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6D91C20E96
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197542DF90
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5my4YhY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BF2D782
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 12:22:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D42F1AA;
	Thu, 26 Oct 2023 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698322949; x=1729858949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XhkCuEPgG658NDvItUy3K7Wo+EY9Pgf5oTkmj458HrQ=;
  b=n5my4YhYQT1qtaRDwqOl9sU9UcDxlpPY0XYQDaP+ZoF+0Ax1VUB+WVbD
   /T5ui7N7ty+fu3oe8Msr2zynkP/BtbFDcKI0j5fwcGY6WvF2FLyLpoAEU
   Be1XiMcw7lVPb/c0lgZZxUdaWU+3KnE+bw6s8DW8bt3h722JmVg75FivP
   1NxdvaskaDtQ8bd1s3BviAm8fTe2PUcPBgn4CWkeRT9hMvnuSBRShJLrX
   tOseAaEb+gh1pxP+ztGCcJMooxJBCjNTClzJJyCj3faS03JUUTSDxwegL
   7ersEEo7/RtiyboT/HBxNPnM2AK4Aqs3qpHE4tWOyOqDehdTdRiXuBNyE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390391620"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="390391620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902883942"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="902883942"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:20:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qvzNY-00000008qpQ-1OYO;
	Thu, 26 Oct 2023 15:22:24 +0300
Date: Thu, 26 Oct 2023 15:22:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com, lenb@kernel.org
Subject: Re: [PATCH v1 3/6] ACPI: acpi_video: Remove unnecessary driver_data
 clear
Message-ID: <ZTpaAMfDcwaZYO7S@smile.fi.intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
 <20231025111806.2416524-4-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025111806.2416524-4-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 25, 2023 at 02:18:03PM +0300, Michal Wilczynski wrote:
> Commit
> 0d16710146a1 ("ACPI: bus: Set driver_data to NULL every time .add() fails")

It's fine to wrap it here, it's just a restriction in the tag block that one
tag == one line. Also I believe the form "The commit" sounds more English :-)
as reader knows exact commit we are talking about.

> introduced clearing driver_data every time probe fails, so it's not
> necessary to clear it in the probe() callback.

> Remove NULL assignment to driver_data in error path in
> acpi_video_bus_add().

This can be one line.

-- 
With Best Regards,
Andy Shevchenko



