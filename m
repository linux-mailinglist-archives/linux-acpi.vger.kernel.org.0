Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707F4450377
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Nov 2021 12:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhKOLeY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Nov 2021 06:34:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:39072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhKOLeJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Nov 2021 06:34:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="319633908"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="319633908"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:31:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="471875949"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:31:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmaCV-0072io-NO;
        Mon, 15 Nov 2021 13:31:03 +0200
Date:   Mon, 15 Nov 2021 13:31:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib: acpi: Remove never used
 devm_acpi_dev_remove_driver_gpios()
Message-ID: <YZJE9++7NI3NnAk/@smile.fi.intel.com>
References: <20211110134743.4300-1-andriy.shevchenko@linux.intel.com>
 <YYv5JdEqyG7T9vfH@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYv5JdEqyG7T9vfH@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2021 at 06:53:57PM +0200, Mika Westerberg wrote:
> On Wed, Nov 10, 2021 at 03:47:42PM +0200, Andy Shevchenko wrote:
> > Remove never used devm_acpi_dev_remove_driver_gpios().
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


