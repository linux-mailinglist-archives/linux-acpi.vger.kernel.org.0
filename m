Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3C32C436
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379489AbhCDALu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:20768 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238662AbhCCLAL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 06:00:11 -0500
IronPort-SDR: fFsNjE3se6JYkLykEnYn4I0lbIdULwwxa6JBsZOeNwZPwJko7peWt8PVZzgK68v6w4emGRCQ4+
 RdXgEaeczGPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="186505399"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="186505399"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:47:50 -0800
IronPort-SDR: iS4RDMSwRDBs32PrXvaiQgDpCOotXPt2HWc60QWTgjHL16H/T3tWXuAyI6ICBBzqM0HMkEtt0N
 0pL7lHZbyqZQ==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445186885"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:47:48 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHO6b-009bhq-MZ; Wed, 03 Mar 2021 11:47:45 +0200
Date:   Wed, 3 Mar 2021 11:47:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shawn Guo <shawn.guo@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <YD9bQXBD+9k3Lf/4@smile.fi.intel.com>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226033919.8871-1-shawn.guo@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 26, 2021 at 11:39:19AM +0800, Shawn Guo wrote:
> Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> not working.  That's because the GpioInt number of TSC2 node in ACPI
> table is simply wrong, and the number even exceeds the maximum GPIO
> lines.  As the touchpad works fine with Windows on the same machine,
> presumably this is something Windows-ism.  Although it's obviously
> a specification violation, believe of that Microsoft will fix this in
> the near future is not really realistic.
> 
> It adds the support of overriding broken GPIO number in ACPI table
> on particular machines, which are matched using DMI info.  Such
> mechanism for fixing up broken firmware and ACPI table is not uncommon
> in kernel.  And hopefully it can be useful for other machines that get
> broken GPIO number coded in ACPI table.


+Cc: Hans.

Hans, would appreciate your opinion on this thread. Maybe I'm mistaken in my
conclusions.

-- 
With Best Regards,
Andy Shevchenko


