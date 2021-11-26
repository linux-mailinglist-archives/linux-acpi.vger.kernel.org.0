Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC145F327
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 18:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhKZRtj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 12:49:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:63632 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhKZRrj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Nov 2021 12:47:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="299101131"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="299101131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 09:43:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="539306483"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 09:43:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mqfFb-00ArOt-Cu;
        Fri, 26 Nov 2021 19:43:07 +0200
Date:   Fri, 26 Nov 2021 19:43:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH v2 1/3] pinctrl: cherryview: Don't use pin/offset 0 to
 mark an interrupt line as unused
Message-ID: <YaEcq2N92rwbUsXx@smile.fi.intel.com>
References: <20211118105650.207638-1-hdegoede@redhat.com>
 <YZY4ZA80QpJQFqOj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZY4ZA80QpJQFqOj@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 01:26:28PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 18, 2021 at 11:56:48AM +0100, Hans de Goede wrote:
> > Offset/pin 0 is a perfectly valid offset, so stop using it to have
> > the special meaning of interrupt line not used in the intr_lines.
> > 
> > Instead introduce a new special INTR_LINE_UNUSED value which is never
> > a valid offset and use that to indicate unused interrupt lines.
> 
> ...
> 
> > +#define INTR_LINE_UNUSED		U32_MAX
> 
> Funny, I have had something similar in my local branch for a few years ;-)
> 
> +#define CHV_INVALID_HWIRQ      ((unsigned int)INVALID_HWIRQ)

I will rename this when applying. I assume there is no objection on doing it.

-- 
With Best Regards,
Andy Shevchenko


