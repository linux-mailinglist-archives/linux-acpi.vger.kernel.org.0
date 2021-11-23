Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0738845A3FD
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhKWNmx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 08:42:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:56846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236743AbhKWNmw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 08:42:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="295829029"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="295829029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:39:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="457055772"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:39:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mpW1J-009n6t-4z;
        Tue, 23 Nov 2021 15:39:37 +0200
Date:   Tue, 23 Nov 2021 15:39:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: baytrail: Set IRQCHIP_SET_TYPE_MASKED flag on
 the irqchip
Message-ID: <YZzvGCnMYTUh++SC@smile.fi.intel.com>
References: <20211122220423.11256-1-hdegoede@redhat.com>
 <YZzLrsS/zNlH3Zk4@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZzLrsS/zNlH3Zk4@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 01:08:30PM +0200, Mika Westerberg wrote:
> On Mon, Nov 22, 2021 at 11:04:23PM +0100, Hans de Goede wrote:
> > The byt_irq_type function ends with the IRQ masked, this means that calls
> > to irq_set_irq_type() while the IRQ is enabled end up masking it, which
> > is wrong. Add the IRQCHIP_SET_TYPE_MASKED flag to fix this.
> > 
> > This will make the IRQ core call mask() + unmask() on the IRQ around
> > a set_type() call when the IRQ is enabled at the type of the call.
> > 
> > Note in practice irq_set_irq_type() getting called while the IRQ is enabled
> > almost never happens. I hit this with a buggy DSDT where a wrongly active
> > (_STA returns 0xf) I2C ACPI devices point to an IRQ already in use by an
> > _AEI handler, leading to the irq_set_irq_type() call in
> > acpi_dev_gpio_irq_get_by() getting called while the IRQ is enabled.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


