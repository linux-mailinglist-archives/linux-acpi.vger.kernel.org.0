Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75B25FBDD
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgIGOM4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 10:12:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:29586 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbgIGOI5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 10:08:57 -0400
IronPort-SDR: qtwwns37usp1CEb0AcIjSgOVgTTY1EAgXlXpHSpw5GXK9yZVdMyOcS/IIkmEpxQ1ib0brF5mlA
 a5SePSPxMXkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="176061444"
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="176061444"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 07:08:35 -0700
IronPort-SDR: IyIJpGb7PSXbGv9nFa3L9iLxdTpINyOkMblbQ1eaJEL8yCHiEA1yOEq+JfOtmTBVxynSnAZUDe
 vS/OhuaQ/YPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="333173796"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 07:08:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFHor-00Ey3d-4e; Mon, 07 Sep 2020 17:08:29 +0300
Date:   Mon, 7 Sep 2020 17:08:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for
 gpio-mockup
Message-ID: <20200907140829.GL1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
 <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com>
 <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
 <20200907122238.GA1849893@kroah.com>
 <CAMpxmJXM=8oGoPSGg8G8XJ4HXJFrAQ2-_EXrz3rf3+ZmCSWB7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXM=8oGoPSGg8G8XJ4HXJFrAQ2-_EXrz3rf3+ZmCSWB7g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 03:49:23PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 7, 2020 at 2:22 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:

...

> > Yes it is.  Or at least until you fix all existing users so that if you
> > do change it, no one notices it happening :)
> >
> 
> Then another question is: do we really want to commit to a stable ABI
> for a module we only use for testing purposes and which doesn't
> interact with any real hardware.
> 
> Rewriting this module without any legacy cruft is tempting though. :)

Another thought spoken loudly: maybe it can be unified with GPIO aggregator
code? In that case it makes sense.

-- 
With Best Regards,
Andy Shevchenko


