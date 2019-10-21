Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4EDED72
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfJUNXs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 09:23:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:24504 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfJUNXr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Oct 2019 09:23:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 06:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="196106820"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2019 06:23:45 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iMXez-00052V-6L; Mon, 21 Oct 2019 16:23:45 +0300
Date:   Mon, 21 Oct 2019 16:23:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Print pin number on
 acpi_gpiochip_alloc_event errors
Message-ID: <20191021132345.GT32742@smile.fi.intel.com>
References: <20191018195208.94405-1-hdegoede@redhat.com>
 <20191021091124.GK32742@smile.fi.intel.com>
 <f3294033-8105-8c26-a8e2-3ced55276fdb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3294033-8105-8c26-a8e2-3ced55276fdb@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 21, 2019 at 02:52:13PM +0200, Hans de Goede wrote:
> On 21-10-2019 11:11, Andy Shevchenko wrote:
> > On Fri, Oct 18, 2019 at 09:52:08PM +0200, Hans de Goede wrote:
> > > Print pin number on acpi_gpiochip_alloc_event errors, to help debugging
> > > these.
> > 
> > I'm not sure which one is better decimal or hex, perhaps Mika can help me, in any case
> 
> They are listed as hex in the dis-assembled DSTD.

Oh, now I noticed the potential issue. The pin can be 16-bit, you pring here
only for the case when we have evname. Maybe do something similar in these
messages? Print event name for pin inside byte range and value otherwise?

-- 
With Best Regards,
Andy Shevchenko


