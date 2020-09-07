Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00AC25F9EE
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgIGLxe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:53:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:10615 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbgIGLvC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 07:51:02 -0400
IronPort-SDR: JZM6zfsSeRKmug3yNkG5B4Mpyh6AE9rKmcjbe2FeI2rvNQJoPpMUkT9/+vh10ZQR2PZ4Trsu3Z
 rO9FsS9e43dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="155489468"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="155489468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 04:50:58 -0700
IronPort-SDR: HQST3gf+o0GnEsydi+Z6/lIeh000nTt0LDNLWrhjgijJEO+/HaecyyeofJGt75liq7l3IMXzpo
 s/U8DrdrAMWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333142540"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 04:50:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFFff-00EwLE-P3; Mon, 07 Sep 2020 14:50:51 +0300
Date:   Mon, 7 Sep 2020 14:50:51 +0300
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
Subject: Re: [PATCH 15/23] gpio: mockup: use dynamic device IDs
Message-ID: <20200907115051.GY1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-16-brgl@bgdev.pl>
 <20200904164917.GC1891694@smile.fi.intel.com>
 <CAMRc=MeG8xuB0GNbMLi6+QZTphSN==77Hsw1fjVNU_+Z=Ky2qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeG8xuB0GNbMLi6+QZTphSN==77Hsw1fjVNU_+Z=Ky2qQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 01:04:29PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 4, 2020 at 6:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 04, 2020 at 05:45:39PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > We're currently creating chips at module init time only so using a
> > > static index for dummy devices is fine. We want to support dynamically
> > > created chips however so we need to switch to dynamic device IDs.
> >
> > It misses ida_destroy().
> 
> No, we always call ida_free() for separate IDs when removing devices
> and we remove all devices at module exit so no need to call
> ida_destroy().

Perhaps couple of words about this in the commit message?

-- 
With Best Regards,
Andy Shevchenko


