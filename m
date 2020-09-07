Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542A425F9E7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgIGLwS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:52:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:31253 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbgIGLwJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 07:52:09 -0400
IronPort-SDR: hQr39yb3q66Yek1DAlVR9FPRCNPx9kP3gP7DFahOrT8xkjm40+JjVsUngxgYagt0+gZVRFo5SQ
 dRVLbQhCPbqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="145701516"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="145701516"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 04:52:06 -0700
IronPort-SDR: uvr2VwyZ4SxhVRvEAjJl/5Qfroyr0fgq08DkGSizqWWalIL1aBVCwym291h/o+Ug99zXiM+Hvb
 BA0rZVPHxRMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333142853"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 04:52:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFFgl-00EwLw-NM; Mon, 07 Sep 2020 14:51:59 +0300
Date:   Mon, 7 Sep 2020 14:51:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 16/23] gpio: mockup: refactor the module init function
Message-ID: <20200907115159.GZ1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-17-brgl@bgdev.pl>
 <20200904165029.GD1891694@smile.fi.intel.com>
 <CAMRc=MfrYJrkX2RfjXkCLtyzkM8MemTuUgEu_n-E+2mngk9mbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfrYJrkX2RfjXkCLtyzkM8MemTuUgEu_n-E+2mngk9mbA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 01:05:54PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 4, 2020 at 6:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 04, 2020 at 05:45:40PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > This is in preparation for dynamically created chips.
> > >
> > > Let's split out the code that can be reused when creating chips at
> > > run-time. Let's also move the code preparing the device properties into
> > > a separate routine. This has the advantage of simplifying the error
> > > handling.
> >
> > Almost all contents of this patch should go to proposed helper as I mentioned
> > before. Will make this patch quite small and understandable.

> Sorry, I'm not sure what you're referring to.

I meant if you move changes done here to the patch where I complained about
indentation you might have better series. Have you considered that?

-- 
With Best Regards,
Andy Shevchenko


