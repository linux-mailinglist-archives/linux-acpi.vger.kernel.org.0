Return-Path: <linux-acpi+bounces-490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070717BBEC9
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371541C2083E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8EE38F82
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChkBdaEE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D8328CE
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 17:46:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470FB6;
	Fri,  6 Oct 2023 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696614368; x=1728150368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jUeIQL2G9apTjdeNAodowXeret/higzFFRbWbM/OE/Q=;
  b=ChkBdaEENiQvjl7vuwIWhPQwGF3yzCC5t3o9JOGVQAyqZFojCNmDbA5z
   yFNIGy+lylZh9hj88QNwSRQ2TVi6whp/Ti8cUbQ35ZZ6CNHFZ0GCidftu
   yhFCzC6agyCzU3pb4PGqTbBOwsR7vsaSVE16Ood1/be18NznbOgkoj3CY
   DD4R/DtqonN/Z8IG1rumUCvjtRHmYTgp3fLy74Vik3JJDGKkA+TuKp8LV
   +BbdNRMt5zXjFgiw7MTRkbesmMgA/6MtkwxSIQ+wKJVtT0XnFE7JMVGZI
   TjjdRPxNpp4ldLhkXIaLpzh27rh9DDT6drIN3x0GdLCWo1GDI9VOMvPGp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="2400166"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="2400166"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="868418423"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="868418423"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:46:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qooti-00000003OlT-301H;
	Fri, 06 Oct 2023 20:45:58 +0300
Date: Fri, 6 Oct 2023 20:45:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com, lenb@kernel.org,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
Message-ID: <ZSBH1pd2cfk83QZ4@smile.fi.intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006173055.2938160-4-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 08:30:52PM +0300, Michal Wilczynski wrote:
> AC driver uses struct acpi_driver incorrectly to register itself. This
> is wrong as the instances of the ACPI devices are not meant to
> be literal devices, they're supposed to describe ACPI entry of a
> particular device.
> 
> Use platform_driver instead of acpi_driver. In relevant places call
> platform devices instances pdev to make a distinction with ACPI
> devices instances.
> 
> Drop unnecessary casts from acpi_bus_generate_netlink_event() and
> acpi_notifier_call_chain().
> 
> Add a blank line to distinguish pdev API vs local ACPI notify function.

...

>  struct acpi_ac {
>  	struct power_supply *charger;
>  	struct power_supply_desc charger_desc;
> -	struct acpi_device *device;
> +	struct device *dev;
>  	unsigned long long state;
>  	struct notifier_block battery_nb;
>  };

When changing this, also makes sense just to check if the moving a member in
the data structure makes code shorter, but it's not a show stopper.

...

> -	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
> +	status = acpi_evaluate_integer(ACPI_HANDLE(ac->dev), "_PSR", NULL,
>  				       &ac->state);
>  	if (ACPI_FAILURE(status)) {
> -		acpi_handle_info(ac->device->handle,
> +		acpi_handle_info(ACPI_HANDLE(ac->dev),

Can we call ACPI_HANDLE() only once and cache that in a local variable and use
in all places?

...

> -	struct acpi_ac *ac = acpi_driver_data(device);
> +	struct acpi_ac *ac = data;
> +	struct acpi_device *device = ACPI_COMPANION(ac->dev);
>  
>  	switch (event) {
>  	default:

> -		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
> +		acpi_handle_debug(ACPI_HANDLE(ac->dev), "Unsupported event [0x%x]\n",
>  				  event);

Does it makes any sense now? Basically it duplicates the ACPI_COMPANION() call
as Rafael pointed out in previous version discussion.

>  		fallthrough;

-- 
With Best Regards,
Andy Shevchenko



