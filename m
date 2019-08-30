Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1085A3D92
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 20:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfH3SRE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 14:17:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:7946 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3SRD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 14:17:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 11:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="382093729"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2019 11:17:00 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3lSF-0002tl-7k; Fri, 30 Aug 2019 21:16:59 +0300
Date:   Fri, 30 Aug 2019 21:16:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Cai <peter@typeblog.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] touchscreen: goodix: define GPIO mapping for GPD P2
 Max
Message-ID: <20190830181659.GO2680@smile.fi.intel.com>
References: <20190830000024.20384-1-peter@typeblog.net>
 <20190830000024.20384-2-peter@typeblog.net>
 <20190830115505.GX2680@smile.fi.intel.com>
 <CA+Zf_0etfu7282TQ4wYE8tOrhh2Je4aV4Dz5tgC_wt7=FMAidA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Zf_0etfu7282TQ4wYE8tOrhh2Je4aV4Dz5tgC_wt7=FMAidA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 11:15:27PM +0800, Peter Cai wrote:
> On Fri, Aug 30, 2019, 7:55 PM Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:

> > I guess most of these #ifdef:s makes code less readable for exchange of
> saving
> few bytes in the module footprint.
> 
> Well since they can only be used when ACPI is supported

> (devm_acpi_dev_add_driver_gpios does not exist without ACPI defined, thus
> the last guard must exist),

This is not correct.

> if they were not guarded then we would be left
> with a bunch of unused variables warnings when building without ACPI which
> doesn't seem good.

Good / no-good is only matter of few dozens of bytes here and there to be saved.

> Should we use __maybe_unused here instead of #ifdef guards?

No, it won't make sense, because the structures will be part of
_add_driver_gpio() call, due to which compiler likely can't recognize unused
structures. However, you may try with warnings enabled `make W=1`.

> > Comma at the end?
> 
> I was trying to follow the style of this driver but it doesn't seem to be
> really consistent within itself. Another dmi_system_id definition in the
> same file mixed both styles so I was kind of confused.

I see. So, this is for Dmitry's preferences.

-- 
With Best Regards,
Andy Shevchenko


