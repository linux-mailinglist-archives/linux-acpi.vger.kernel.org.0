Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6003EA650
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhHLOQI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 10:16:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:19856 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhHLOQH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 10:16:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="195628583"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="195628583"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 07:15:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="507750091"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 07:15:40 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mEBUc-008fGr-0L; Thu, 12 Aug 2021 17:15:34 +0300
Date:   Thu, 12 Aug 2021 17:15:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linux GPIO <linux-gpio@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     David Thompson <davthompson@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Liming Sun <limings@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver
Message-ID: <YRUtBr2rVNNfFdGF@smile.fi.intel.com>
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRUskkALrPLa2cSf@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc: Hans (on FYI basis)

On Thu, Aug 12, 2021 at 05:13:38PM +0300, Andy Shevchenko wrote:
> Hi!
> 
> From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
> Recently the drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
> caught my eye.
> 
> Looking into the code I see that it looks like misunderstanding of how ACPI
> works with GPIOs. First of all, I would like to inform that this code has
> been properly reviewed neither by GPIO nor by ACPI maintainers. Second, before
> going it to the real conclusions (and potential revert of this), I would like
> to see the real ACPI tables for this and some explanations from the authors of
> the driver about GPIO usage here (from hw and sw perspectives).
> 
> It makes sense to discuss ASAP, otherwise I would really want to revert it.

-- 
With Best Regards,
Andy Shevchenko


