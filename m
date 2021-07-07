Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8C3BE94A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jul 2021 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhGGOGv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Jul 2021 10:06:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:25776 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbhGGOGv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jul 2021 10:06:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="273151089"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="273151089"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 07:04:11 -0700
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="449577469"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 07:04:09 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m189k-009pTO-CE; Wed, 07 Jul 2021 17:04:04 +0300
Date:   Wed, 7 Jul 2021 17:04:04 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ACPI / PMIC: XPower: optimize MIPI PMIQ sequence
 I2C-bus accesses
Message-ID: <YOW0VL+jiEyNRhob@smile.fi.intel.com>
References: <20210706160923.20273-1-hdegoede@redhat.com>
 <20210706160923.20273-2-hdegoede@redhat.com>
 <YOSGPC5p5guALYUJ@smile.fi.intel.com>
 <7f13b049-d2a2-1720-2d82-a10770c49fb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f13b049-d2a2-1720-2d82-a10770c49fb0@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 06, 2021 at 08:27:55PM +0200, Hans de Goede wrote:
> On 7/6/21 6:35 PM, Andy Shevchenko wrote:
> > On Tue, Jul 06, 2021 at 06:09:23PM +0200, Hans de Goede wrote:

...

> > The idea for the further improvement
> > 
> >> +	if (i2c_address != 0x34) {
> >> +		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
> >> +		       __func__, i2c_address, reg_address, value, mask);
> >> +		return -ENXIO;
> >> +	}
> > 
> > We have this in intel_pmic.c. Can we reorganize the code the way we will have
> > this check solely in the intel_pmic.c?
> 
> No, the drivers/acpi/pmic/intel_pmic_chtwc.c implementation accepts multiple
> i2c addresses because the whiskey cove has multiple register banks split
> over different i2c-addressses.

I think it's still possible (by modifying the field to be an array of accepted
addresses). Anyway, it's matter outside of this patch series and we have time
to think about it.

-- 
With Best Regards,
Andy Shevchenko


