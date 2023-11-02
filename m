Return-Path: <linux-acpi+bounces-1161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F090A7DF521
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046AE1C2091E
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A421BDE0
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBktSUlF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B379EF
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 13:12:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75961D7
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698930754; x=1730466754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d7FZ8CV8tTBJMX1lwMtgcSY2Pj9RjbaALf846FPPVQo=;
  b=ZBktSUlFro0eDhPsbWBNWWHg54Vr6irbIyyziO5AvjH0L6Oi3eF+Y6hY
   hWRECbdMdWq3kc5CLwQAH3heUXGrjmrzOUHWzcGhT2CVDbrvI1APaHPVG
   d5XmnDVO2N2449BfH01VhyfZ2Yot2+dzfGkkjI7IZ+23wEha6MfnF7fSD
   g/ZE0ki66uTaD0WkzYLwipjXDtwd0xeUUV7p4QF7HbXyOdMTGtg6TJpZV
   kit/hHVadKPY33IOHUkQimu8SCvrYdpidpca0x3wDpjRWZY+hUthkjcSV
   L8WB51QSIKU5l8mCdo0By/8EyEPhHeqtQboy0lhwabXC//yp71fZYQ3sC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="455190028"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="455190028"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="764905519"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="764905519"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:12:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qyXUr-0000000Ah4A-3yoS;
	Thu, 02 Nov 2023 15:12:29 +0200
Date: Thu, 2 Nov 2023 15:12:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/3] acpi: property: Let args be NULL in
 __acpi_node_get_property_reference
Message-ID: <ZUOgPZk76fT18F3u@smile.fi.intel.com>
References: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
 <20231102101316.1186215-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102101316.1186215-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 02, 2023 at 12:13:14PM +0200, Sakari Ailus wrote:
> fwnode_get_property_reference_args() may not be called with args argument
> NULL on ACPI, OF already supports this. Add the missing NULL checks and
> document this.
> 
> The purpose is to be able to count the references.

...

> -		args->fwnode = acpi_fwnode_handle(device);
> -		args->nargs = 0;
> +		if (args) {
> +			args->fwnode = acpi_fwnode_handle(device);
> +			args->nargs = 0;
> +		}
>  		return 0;

In swnode case you used

	if (!args)
		return 0;

approach. Why not here? It also makes diff cleaner, no?

-- 
With Best Regards,
Andy Shevchenko



