Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDBC3370A2
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Mar 2021 11:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhCKK5F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Mar 2021 05:57:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:12909 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232349AbhCKK4y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Mar 2021 05:56:54 -0500
IronPort-SDR: dyFnvM5/RCqe6Ojvj0BoaplBtttKoriBjQp9Nf4YmctSwH5L3r+QIBa9EP2kIkKfTf2LS3aqtv
 0Aa4hCTzSNOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188746727"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="188746727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 02:56:53 -0800
IronPort-SDR: w1koGQl49zidT8+B5C2zg7sqXrdTN5ZtvAQkKV451pyGewyHi9U2zvOgfCt+l6ayWpdFNll3TO
 sXRyENlWn37Q==
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="386977414"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 02:56:50 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lKIzn-00BYkk-Db; Thu, 11 Mar 2021 12:56:47 +0200
Date:   Thu, 11 Mar 2021 12:56:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/5] irqdomain: Introduce irq_domain_create_simple()
 API
Message-ID: <YEn3b4fVolkcrWXq@smile.fi.intel.com>
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
 <20210304201253.14652-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdbA+Q24JV3Uct2dHtGfBb1AaF4uHwCbzcrOFAxoGQ4wXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbA+Q24JV3Uct2dHtGfBb1AaF4uHwCbzcrOFAxoGQ4wXQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 11, 2021 at 12:15:29AM +0100, Linus Walleij wrote:
> On Thu, Mar 4, 2021 at 9:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Linus Walleij pointed out that ird_domain_add_simple() gained
> > additional functionality and can't be anymore replaced with
> > a simple conditional. In preparation to upgrade GPIO library
> > to use fwnode, introduce irq_domain_create_simple() API which is
> > functional equivalent to the existing irq_domain_add_simple(),
> > but takes a pointer to the struct fwnode_handle as a parameter.
> >
> > While at it, amend documentation to mention irq_domain_create_*()
> > functions where it makes sense.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks! It's v6 now :-)

-- 
With Best Regards,
Andy Shevchenko


