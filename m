Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D25A45F3A0
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhKZSWv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 13:22:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:26695 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhKZSUu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Nov 2021 13:20:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="296502898"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="296502898"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 10:13:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="592877053"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 10:13:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mqfj4-00As4x-6B;
        Fri, 26 Nov 2021 20:13:34 +0200
Date:   Fri, 26 Nov 2021 20:13:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH v2 1/3] pinctrl: cherryview: Don't use pin/offset 0 to
 mark an interrupt line as unused
Message-ID: <YaEjzZDsTdzzlVLZ@smile.fi.intel.com>
References: <20211118105650.207638-1-hdegoede@redhat.com>
 <YZY1h8DGkqyoh2aQ@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZY1h8DGkqyoh2aQ@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 01:14:15PM +0200, Mika Westerberg wrote:
> On Thu, Nov 18, 2021 at 11:56:48AM +0100, Hans de Goede wrote:
> > Offset/pin 0 is a perfectly valid offset, so stop using it to have
> > the special meaning of interrupt line not used in the intr_lines.
> > 
> > Instead introduce a new special INTR_LINE_UNUSED value which is never
> > a valid offset and use that to indicate unused interrupt lines.
> > 
> > Cc: Yauhen Kharuzhy <jekhor@gmail.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


