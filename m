Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368321356BF
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2020 11:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgAIKVE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jan 2020 05:21:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:56730 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgAIKVD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jan 2020 05:21:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 02:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="272076267"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2020 02:21:00 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipUw0-0006bc-PX; Thu, 09 Jan 2020 12:21:00 +0200
Date:   Thu, 9 Jan 2020 12:21:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: baytrail: Replace WARN with dev_info_once
 when setting direct-irq pin to output
Message-ID: <20200109102100.GK32742@smile.fi.intel.com>
References: <20200101145243.15912-1-hdegoede@redhat.com>
 <20200108174745.GG32742@smile.fi.intel.com>
 <f1ace666-1c57-0688-9737-d3ab2f5a1073@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ace666-1c57-0688-9737-d3ab2f5a1073@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 09, 2020 at 10:05:47AM +0100, Hans de Goede wrote:
> On 08-01-2020 18:47, Andy Shevchenko wrote:
> > On Wed, Jan 01, 2020 at 03:52:43PM +0100, Hans de Goede wrote:

...

> > >   		/*
> > >   		 * Before making any direction modifications, do a check if gpio
> > >   		 * is set for direct IRQ.  On baytrail, setting GPIO to output
> > >   		 * does not make sense, so let's at least warn the caller before
> > 
> > ...if it's a warning, perhaps do a warning instead of info?
> > Otherwise, we probably need to change a comment here.
> 
> I went with info on purpose since this will trigger on all BYT devices with
> a Goodix touchscreens of which we have quite a few, so my vote goes to maybe
> the comment. Note that although the log level is info (because it is somewhat
> expected to happen), the content of the log msg is still warning-ish.
> 
> I guess we could replace "let's at least warn the caller before" with
> "let's at least let the caller know before"

What about simple 'warn -> inform' ?
(I can update myself)

> > >   		 * they shoot themselves in the foot.
> > >   		 */
> > > -		WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
> > > -		     "Potential Error: Setting GPIO with direct_irq_en to output");
> > > +		dev_info_once(vg->dev, "Potential Error: Setting GPIO with direct_irq_en to output");

-- 
With Best Regards,
Andy Shevchenko


