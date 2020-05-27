Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0D1E43F3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbgE0Nik (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 09:38:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:20358 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387682AbgE0Nij (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 May 2020 09:38:39 -0400
IronPort-SDR: 1BPYe+QGgMx3Cs8X75fJtVvlurpNdD0NDS8I4GO4+ip/HzChmM/JTRKLNVyNwTvG78ksu4njJ4
 eHGULXw0JRZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 06:38:38 -0700
IronPort-SDR: 9wiXZQKOKEpsbCVuTvsZnBbLhroxgRwrkByu4IMGDRTpTFSit9r0Xs933YXNcqUgLxeHQwRJby
 hariVD/SN8Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="345534383"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2020 06:38:37 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdwGW-009Ehv-94; Wed, 27 May 2020 16:38:40 +0300
Date:   Wed, 27 May 2020 16:38:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 3/5] gpio: pca953x: Drop unneeded ACPI_PTR()
Message-ID: <20200527133840.GW1634618@smile.fi.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
 <20200520211916.25727-3-andriy.shevchenko@linux.intel.com>
 <20200525175819.GH1634618@smile.fi.intel.com>
 <CAMpxmJW71t5Vy6q+wdRO1dkmZbeDKZcP-_9W=CKXX69A866n8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJW71t5Vy6q+wdRO1dkmZbeDKZcP-_9W=CKXX69A866n8g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 27, 2020 at 03:13:11PM +0200, Bartosz Golaszewski wrote:
> pon., 25 maj 2020 o 19:58 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> napisał(a):
> >
> > On Thu, May 21, 2020 at 12:19:14AM +0300, Andy Shevchenko wrote:
> > > ACPI_PTR() becomes a no-op when !CONFIG_ACPI. This is not needed since
> > > we always have ID table enabled. Moreover, in the mentioned case compiler
> > > will complain about defined but not used variable.
> >
> > Bart, are you going to apply this one, or should I resend it as a part of v2?
> >
> 
> Ugh, I already sent my last PRs to Linus both for v5.7 fixes & v5.8
> updates. I'll let Linus pick it up once he pulls from my tree.

No problem, thanks!

P.S. The patch is pretty much independent and can be applied even before that
(I suppose), but let Linus decide what is better for him.

-- 
With Best Regards,
Andy Shevchenko


