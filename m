Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7543ED1EC
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhHPKZp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 06:25:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:50305 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhHPKZp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 06:25:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="279576907"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="279576907"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 03:25:12 -0700
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="675505764"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 03:25:09 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 16 Aug 2021 13:25:07 +0300
Date:   Mon, 16 Aug 2021 13:25:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH regression fix] gpiolib: acpi: Make set-debounce-timeout
 failures non fatal
Message-ID: <YRo9A0sgfKbi94BK@lahna>
References: <20210816093856.12313-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816093856.12313-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 11:38:56AM +0200, Hans de Goede wrote:
> Commit 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> made the gpiolib-acpi code call gpio_set_debounce_timeout() when requesting
> GPIOs.
> 
> This in itself is fine, but it also made gpio_set_debounce_timeout()
> errors fatal, causing the requesting of the GPIO to fail. This is causing
> regressions. E.g. on a HP ElitePad 1000 G2 various _AEI specified GPIO
> ACPI event sources specify a debouncy timeout of 20 ms, but the
> pinctrl-baytrail.c only supports certain fixed values, the closest
> ones being 12 or 14 ms and pinctrl-baytrail.c responds with -EINVAL
> when specified a value which is not one of the fixed values.
> 
> This is causing the acpi_request_own_gpiod() call to fail for 3
> ACPI event sources on the HP ElitePad 1000 G2, which in turn is causing
> e.g. the battery charging vs discharging status to never get updated,
> even though a charger has been plugged-in or unplugged.
> 
> Make gpio_set_debounce_timeout() errors non fatal, warning about the
> failure instead, to fix this regression.
> 
> Note we should probably also fix various pinctrl drivers to just
> pick the first bigger discrete value rather then returning -EINVAL but
> this will need to be done on a per driver basis, where as this fix
> at least gets us back to where things were before and thus restores
> functionality on devices where this was lost due to
> gpio_set_debounce_timeout() errors.
> 
> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
