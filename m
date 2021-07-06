Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4773BDB7C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jul 2021 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhGFQiC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jul 2021 12:38:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:3146 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhGFQiC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Jul 2021 12:38:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="196432237"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="196432237"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:35:15 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="427644221"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:35:13 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m0o2O-009UkV-Qc; Tue, 06 Jul 2021 19:35:08 +0300
Date:   Tue, 6 Jul 2021 19:35:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ACPI / PMIC: XPower: optimize MIPI PMIQ sequence
 I2C-bus accesses
Message-ID: <YOSGPC5p5guALYUJ@smile.fi.intel.com>
References: <20210706160923.20273-1-hdegoede@redhat.com>
 <20210706160923.20273-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706160923.20273-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 06, 2021 at 06:09:23PM +0200, Hans de Goede wrote:
> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
> the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
> before it may use the bus and while the kernel holds the semaphore the CPU
> and GPU power-states must not be changed otherwise the system will freeze.
> 
> This is a complex process, which is quite expensive. This is all done by
> iosf_mbi_block_punit_i2c_access(). To ensure that no unguarded I2C-bus
> accesses happen, iosf_mbi_block_punit_i2c_access() gets called by the
> I2C-bus-driver for every I2C transfer. Because this is so expensive it
> is allowed to call iosf_mbi_block_punit_i2c_access() in a nested
> fashion, so that higher-level code which does multiple I2C-transfers can
> call it once for a group of transfers, turning the calls done by the
> I2C-bus-driver into no-ops.
> 
> The default exec_mipi_pmic_seq_element implementation from
> drivers/acpi/pmic/intel_pmic.c does a regmap_update_bits() call and
> the involved registers are typically marked as volatile in the regmap,
> so this leads to 2 I2C-bus accesses.
> 
> Add a XPower AXP288 specific implementation of exec_mipi_pmic_seq_element
> which calls iosf_mbi_block_punit_i2c_access() calls before the
> regmap_update_bits() call to avoid having to do the whole expensive
> acquire P-Unit semaphore dance twice.

...

The idea for the further improvement

> +	if (i2c_address != 0x34) {
> +		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
> +		       __func__, i2c_address, reg_address, value, mask);
> +		return -ENXIO;
> +	}

We have this in intel_pmic.c. Can we reorganize the code the way we will have
this check solely in the intel_pmic.c?

-- 
With Best Regards,
Andy Shevchenko


