Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB644F2AE9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2019 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKGJlH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 04:41:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:9027 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfKGJlH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Nov 2019 04:41:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 01:41:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="402685081"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2019 01:41:05 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iSeHo-000271-DM; Thu, 07 Nov 2019 11:41:04 +0200
Date:   Thu, 7 Nov 2019 11:41:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191107094104.GW32742@smile.fi.intel.com>
References: <20191106154715.155596-1-hdegoede@redhat.com>
 <20191106174759.GB2552@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106174759.GB2552@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 07:47:59PM +0200, Mika Westerberg wrote:
> On Wed, Nov 06, 2019 at 04:47:12PM +0100, Hans de Goede wrote:
> > Hi All,
> > 
> > Here is v2 of my series for Cherry Trail devices to pass the irqchip when
> > adding the gpiochip instead of registering it separately. Similar to how
> > this is done for Bay Trail devices in Andy's recent series:
> > "[RESEND][PATCH v2 0/7] gpiolib: fix GPIO <-> pin mapping registration".
> > 
> > Note this series depends on that series as well as on the cherryview changes
> > currently queued in pinctrl/intel.git/for-next .
> > 
> > Changes in v2:
> > - Add kerndoc comments for new chv_pinctrl struct members
> 
> The series looks good to me now. Thanks!
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review-andy branch for better testing coverage, though it's not an
immediate candidate for v5.5 due to dependencies.

-- 
With Best Regards,
Andy Shevchenko


