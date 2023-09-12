Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FE79D4B7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 17:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjILPXC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjILPXC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 11:23:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D8C10DC
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694532178; x=1726068178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZ/ZAwG25e92we8EIS8gvzN/EWbWAh9ZxR7aQd0ZuFk=;
  b=goK/qiUMydxmSrfp8gI4GRInucMMaXHuencojIin1mWn1FGP5xatQyeO
   i2ss7fEL5ddlZAn2aLCXyox5m8T9IzJ+Ul39WclxSiTKkQT8M7IOAxQ6u
   5a69l5ZpQSfveREornWQH2X+FWdh9FanSa7cm6rqoavjQhHaL9t5rHVJv
   SnaRLd6A0LV0ZpLxokYieCK7Gj4BpV+xLJ1Qj28fqQViAZuYHLvnzRF7d
   GlE3EoIDAVsURpJmdUmb63fSxaTLqDJKBV0usO3XTJ1XBgIKXaC/ak32d
   So5yTdR8T9wWh3gRlLNprTI3noSthM079Kjd1UO9h/DFtpHYJ6+R14eCy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464780019"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464780019"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773071577"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="773071577"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:22:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg5E5-008cK2-0r;
        Tue, 12 Sep 2023 18:22:53 +0300
Date:   Tue, 12 Sep 2023 18:22:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ken Xue <Ken.Xue@amd.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, cwhuang@linux.org.tw
Subject: Re: [PATCH V3] acpi: trigger wakeup key event from power button
Message-ID: <ZQCCTA9YblEHgKT8@smile.fi.intel.com>
References: <20230912131605.734829-1-Ken.Xue@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912131605.734829-1-Ken.Xue@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 12, 2023 at 09:16:06PM +0800, Ken Xue wrote:
> Andorid can wakeup from various wakeup sources,
> but only several wakeup sources can wake up screen
> with right events(POWER, WAKEUP) from input device.


You still have a room for 10+ characters on each line in the above paragraph.
Why not use them?

> Regarding pressing acpi power button, it can resume system and
> ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS
> are set in pm1a_sts, but kernel does not report any key
> event to user space during resume by default.
> 
> So, trigger wakeup key event to user space during resume
> from power button.
> 
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>

...

> +void acpi_power_button_wakeup(struct acpi_device *dev)
> +{
> +	struct acpi_button *button = acpi_driver_data(dev);
> +	struct input_dev *input;

> +	if (button->type == ACPI_BUTTON_TYPE_POWER) {

It seems you missed the suggestion and I haven't heard an objection on written
the above as

	if (button->type != ACPI_BUTTON_TYPE_POWER)
		return;

> +		input = button->input;
> +		input_report_key(input, KEY_WAKEUP, 1);
> +		input_sync(input);
> +		input_report_key(input, KEY_WAKEUP, 0);
> +		input_sync(input);
> +	}
> +}

...

>  #include <linux/syscore_ops.h>
>  #include <asm/io.h>
>  #include <trace/events/power.h>
> +#include <acpi/button.h>

While at it, I would add a blank line here to distinguish groups of header
inclusions.

  #include <linux/syscore_ops.h>
  #include <asm/io.h>
  #include <trace/events/power.h>

  #include <acpi/button.h>

Or even

  #include <linux/syscore_ops.h>

  #include <asm/io.h>

  #include <trace/events/power.h>

  #include <acpi/button.h>


-- 
With Best Regards,
Andy Shevchenko


