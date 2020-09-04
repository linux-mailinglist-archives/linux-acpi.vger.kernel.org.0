Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3417425E12C
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgIDRuU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:50:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:41087 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIDRuT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 13:50:19 -0400
IronPort-SDR: g2vacdf31DB5acntTP6bOrOu35EcANSuBLaa5iwSv4E22vCFqrEQ+zY/QO/T14X7/XHRs59I37
 N7WwibWRG+pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="158783300"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="158783300"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 10:50:18 -0700
IronPort-SDR: hcXSRX41dWUGTxs8i5As2mr+dBKKUomX86v2vQ9Dn/9kpE4dyXHpxsf29txWTcSM+0lHp2qYIx
 yc0EwN5Vk/bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332243811"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 10:50:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEFqo-00EL2k-2J; Fri, 04 Sep 2020 20:50:14 +0300
Date:   Fri, 4 Sep 2020 20:50:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: cherryview: Preserve
 CHV_PADCTRL1_INVRXTX_TXDATA flag on GPIOs
Message-ID: <20200904175014.GJ1891694@smile.fi.intel.com>
References: <20200904172141.180363-1-hdegoede@redhat.com>
 <20200904174456.GI1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904174456.GI1891694@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 08:44:56PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 04, 2020 at 07:21:41PM +0200, Hans de Goede wrote:

...

> > Note that chv_pinmux_set_mux() does still unconditionally clear the
> > flag, so this only affects GPIO usage.
> 
> Makes sense!
> I'll wait for Mika tag, while pushing to my review and testing queue, thanks!

Hmm... JFYI:
Applying: pinctrl: cherryview: Preserve CHV_PADCTRL1_INVRXTX_TXDATA flag on GPIOs
Context reduced to (2/2) to apply fragment at 770

I applied it with -C1 because of above.

-- 
With Best Regards,
Andy Shevchenko


