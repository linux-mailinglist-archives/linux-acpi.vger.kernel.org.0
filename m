Return-Path: <linux-acpi+bounces-1918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB427FDD29
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 17:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F2628254B
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53470210E2
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DllLsTbC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D74BD6E;
	Wed, 29 Nov 2023 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701269529; x=1732805529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iBvOUeV8GInwE1URST0+LDM0euJ0nkLB2pW7xGvI54M=;
  b=DllLsTbCDGzsiRjyGLwYTZ/fsdnOC6DIkSEgvSDLNDjvDoyi2JmkZMir
   vJd/ltvdRjonJ07scRO1YChX/VdC8jHpT/sUzHJ/JeMazw1J0+U7eG3c3
   VQB6y58UXlTIDjmh8YYHF0/mMdcqOehgIihDIYkQZp7GigZabjI2kawHW
   5rfVXI2N2Sk2fGLTVvz94HZ9a1rNJBENX+9OjUm5Wzof1Fae4uD8ETuy9
   VS2jHlT6eoOSi7pNhMeMQLpNABI1jmh02R7ysrxujhztUiCxOKz2xKeg4
   Dszk9f8HjHfUp1Fdd3JtQ+T0MKhQikf1Tj/gPnCm1sg9ShYZ1ivcv2imJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6386724"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="6386724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942347393"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="942347393"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:48:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r8Lrx-00000000Svm-1uUE;
	Wed, 29 Nov 2023 16:48:53 +0200
Date: Wed, 29 Nov 2023 16:48:53 +0200
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
Subject: Re: [PATCH v1 2/4] ACPI: OSL: Rearrange workqueue selection in
 acpi_os_execute()
Message-ID: <ZWdPVSf4DTzliQ_L@smile.fi.intel.com>
References: <3281896.aeNJFYEL58@kreacher>
 <2267180.iZASKD2KPV@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2267180.iZASKD2KPV@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 29, 2023 at 02:48:22PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the 3-branch if () statement used for selecting the target
> workqueue in acpi_os_execute() with a switch () one that is more
> suitable for this purpose and carry out the work item initialization
> before it to avoid code duplication.
> 
> No intentional functional impact.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



