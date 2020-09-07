Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2620F25F6F9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgIGJ7k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 05:59:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:30001 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgIGJ7j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 05:59:39 -0400
IronPort-SDR: foubVbAqkP05TGdQaekpmIYVCcp6m81RT+xcKjUpnW5nF2iqwAgnb7wiwP4TeNWNqgV9s+IRuT
 JuA4K7dIhwHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="219538074"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="219538074"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 02:59:38 -0700
IronPort-SDR: aLMRKzYrvfO0QWscFyb0B9MNzsINj/RtYJEerktDLEXmYIYAh8QRTm2YNGmcHboOoZg2ydMi32
 X/Hqwfthpkdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333117121"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 02:59:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFDvw-00Euk6-Fp; Mon, 07 Sep 2020 12:59:32 +0300
Date:   Mon, 7 Sep 2020 12:59:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for
 gpio-mockup
Message-ID: <20200907095932.GU1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:

...

> > +GPIO Testing Driver
> > +===================
> > +
> > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > +chips for testing purposes. There are two ways of configuring the chips exposed
> > +by the module. The lines can be accessed using the standard GPIO character
> > +device interface as well as manipulated using the dedicated debugfs directory
> > +structure.
> 
> Could configfs be used for this instead of debugfs?
> debugfs is ad hoc.

Actually sounds like a good idea.

-- 
With Best Regards,
Andy Shevchenko


