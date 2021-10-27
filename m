Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE22B43D0D3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbhJ0ShZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 14:37:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:26323 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243586AbhJ0ShT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 14:37:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="210997697"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="210997697"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 10:36:04 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="665080147"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 10:36:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfmpy-001Wys-H8;
        Wed, 27 Oct 2021 20:35:42 +0300
Date:   Wed, 27 Oct 2021 20:35:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: glue: Use acpi_device_adr() in
 acpi_find_child_device()
Message-ID: <YXmN7tnG6fddKhTJ@smile.fi.intel.com>
References: <11862679.O9o76ZdvQC@kreacher>
 <YXmJjlY6+oFy4siX@smile.fi.intel.com>
 <CAJZ5v0j43dhVcbsKyJ8BZjeBbXHNFG-Vtv-UtsJwFBYP4usNFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j43dhVcbsKyJ8BZjeBbXHNFG-Vtv-UtsJwFBYP4usNFQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 07:23:43PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 27, 2021 at 7:17 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Oct 27, 2021 at 06:59:06PM +0200, Rafael J. Wysocki wrote:

...

> See acpi_set_pnp_ids().
> 
> adev->pnp.bus_addres is the address value and
> adev->pnp.type.bus_address is a flag that is set to 1 when _ADR is
> valid.
> 
> > IIUC _ADR == 0 is a valid value and children may have it like this.
> 
> That's true.
> 
> > I believe this change will break the working things (first comes to my mind
> > is drivers/mfd/intel_quark_i2c_gpio.c).
> 
> I don't think so.

With your explanation I see where my logic is wrong. Thanks!

-- 
With Best Regards,
Andy Shevchenko


