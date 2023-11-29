Return-Path: <linux-acpi+bounces-1916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B676C7FD97C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426FBB20C6C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42FD32C7A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmPAib3I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20FAF;
	Wed, 29 Nov 2023 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701267045; x=1732803045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQal9aMivxpFDhH6E/QqJF0j6TwRxcsMoHWT7iUi6lE=;
  b=JmPAib3IS4BO+8P9Q2Uy2ddreTeBR3rGJp+DAJzIvB2ufw1e0NDxhErv
   clN0f3gwMglpkCeBgz8+NdSU1xeCKCdvM+mSiBCZmQLHj0rUYk8WrV/fl
   wxnbLDwV7d+ue0DUIbRL9c2owG8gZL61X86M+jZ2OJ9B14Sm6gXFRGWR3
   JX4YOReJrkqNWX38O+5+6fDBCiAzWXL8X1OEXIOUfb+L1ccWBVdgNZRSe
   /IQ3r2st6Lmxaaw7XcLkMLk1OVeCNTvobZN7XXSoEVs7jakdHviQTbhE3
   bQ8zyq9M81hugbcIQ4T2nXLMS2/Eg9MZg2N6EV8Tzj5fYW/bjML8UPsQP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="479368531"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="479368531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="762327083"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="762327083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:10:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r8LGu-00000000SPr-3ztj;
	Wed, 29 Nov 2023 16:10:36 +0200
Date: Wed, 29 Nov 2023 16:10:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 1/4] ACPI: OSL: Rework error handling in
 acpi_os_execute()
Message-ID: <ZWdGXAFdLhZVKPmW@smile.fi.intel.com>
References: <3281896.aeNJFYEL58@kreacher>
 <8321623.T7Z3S40VBb@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8321623.T7Z3S40VBb@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 29, 2023 at 02:46:51PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reduce the number of checks and goto labels related to error handling
> in acpi_os_execute() and drop the status local variable, which turns
> out to be redundant, from it.
> 
> No intentional functional impact.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



