Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99945A0F7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 12:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhKWLLo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 06:11:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:50088 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhKWLLn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 06:11:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321233595"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="321233595"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 03:08:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="497247798"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 03:08:32 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 23 Nov 2021 13:08:30 +0200
Date:   Tue, 23 Nov 2021 13:08:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: baytrail: Set IRQCHIP_SET_TYPE_MASKED flag on
 the irqchip
Message-ID: <YZzLrsS/zNlH3Zk4@lahna>
References: <20211122220423.11256-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122220423.11256-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 22, 2021 at 11:04:23PM +0100, Hans de Goede wrote:
> The byt_irq_type function ends with the IRQ masked, this means that calls
> to irq_set_irq_type() while the IRQ is enabled end up masking it, which
> is wrong. Add the IRQCHIP_SET_TYPE_MASKED flag to fix this.
> 
> This will make the IRQ core call mask() + unmask() on the IRQ around
> a set_type() call when the IRQ is enabled at the type of the call.
> 
> Note in practice irq_set_irq_type() getting called while the IRQ is enabled
> almost never happens. I hit this with a buggy DSDT where a wrongly active
> (_STA returns 0xf) I2C ACPI devices point to an IRQ already in use by an
> _AEI handler, leading to the irq_set_irq_type() call in
> acpi_dev_gpio_irq_get_by() getting called while the IRQ is enabled.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
