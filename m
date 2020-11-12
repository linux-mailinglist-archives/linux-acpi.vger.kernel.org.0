Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C82B06C2
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 14:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgKLNju (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 08:39:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:21955 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgKLNjr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:47 -0500
IronPort-SDR: 0pNDn6g3bqqKonmKNeMLVLye2nJs0ZXMBKxZk3yfR0K7KCBkXFI48yW7knkckDC9FBsG2BwaL/
 LXGpmtaqhLHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="149580860"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="149580860"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 05:39:42 -0800
IronPort-SDR: GaFFR2JxaI4lUiRiuzhvZWzH9LrOtYwlzOcmH4Sw2Ie8JsNwmYDMUgn7Zco+Xq6WMrDLlWRprA
 pNr/JPPP8KrA==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="532170505"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 05:39:40 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kdCqA-006DOY-Di; Thu, 12 Nov 2020 15:40:42 +0200
Date:   Thu, 12 Nov 2020 15:40:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Documentation: ACPI: explain how to use
 gpio-line-names
Message-ID: <20201112134042.GB4077@smile.fi.intel.com>
References: <20201112131545.62628-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112131545.62628-1-f.suligoi@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 02:15:45PM +0100, Flavio Suligoi wrote:
> The "gpio-line-names" declaration is not fully
> documented, so can be useful to add some important
> information and one more example.
> 
> This commit also fixes a trivial spelling mistake.

For the future contributions:

No need to resend each time you got a tag. Maintainers usually take them all at
once when applying (esp. taking into account plenty of scripts which help to do
this automatically).

Also, no need to resend so often. Give a chance to others to review (minimum
resend time is 24h)

-- 
With Best Regards,
Andy Shevchenko


