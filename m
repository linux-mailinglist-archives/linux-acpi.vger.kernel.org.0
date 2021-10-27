Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590E843CF8D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbhJ0RUG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 13:20:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:53092 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243208AbhJ0RUF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 13:20:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230165116"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="230165116"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 10:17:23 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="447303572"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 10:17:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfmXu-001Wgp-U1;
        Wed, 27 Oct 2021 20:17:02 +0300
Date:   Wed, 27 Oct 2021 20:17:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: glue: Use acpi_device_adr() in
 acpi_find_child_device()
Message-ID: <YXmJjlY6+oFy4siX@smile.fi.intel.com>
References: <11862679.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11862679.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 06:59:06PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of evaluating _ADR in acpi_find_child_device(), use the
> observation that it has already been evaluated and the value returned
> by it has been stored in the pnp.type.bus_address field of the ACPI
> device object at hand.

...

> +		acpi_bus_address addr = acpi_device_adr(adev);
>  		int score;
>  
> -		status = acpi_evaluate_integer(adev->handle, METHOD_NAME__ADR,
> -					       NULL, &addr);
> -		if (ACPI_FAILURE(status) || addr != address)
> +		if (!adev->pnp.type.bus_address || addr != address)
>  			continue;

I'm not sure I understand the new check, i.e. !adev->pnp.type.bus_address.
IIUC _ADR == 0 is a valid value and children may have it like this.

I believe this change will break the working things (first comes to my mind
is drivers/mfd/intel_quark_i2c_gpio.c).

-- 
With Best Regards,
Andy Shevchenko


