Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1868A4558DB
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 11:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbhKRKWy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 05:22:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:53281 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244554AbhKRKWV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 05:22:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="234103822"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="234103822"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 02:19:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="605108732"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 02:19:17 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 18 Nov 2021 12:19:15 +0200
Date:   Thu, 18 Nov 2021 12:19:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: cherryview: Ignore INT33FF UID 5 ACPI device
Message-ID: <YZYoo/KcP9mSlJjt@lahna>
References: <20211117231614.758362-1-hdegoede@redhat.com>
 <20211117231614.758362-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117231614.758362-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 12:16:14AM +0100, Hans de Goede wrote:
> Many Cherry Trail DSDTs have an extra INT33FF device with UID 5,
> the intel_pinctrl_get_soc_data() call will fail for this extra
> unknown UID, leading to the following error in dmesg:

Yeah, this may be the "DSW" or Deep Sleep Well community that is
typically not available for software to use at all. No idea why they
expose it on some systems.

>  cherryview-pinctrl: probe of INT33FF:04 failed with error -61
> 
> Add a check for this extra UID and return -ENODEV for it to
> silence this false-positive error message.
> 
> Cc: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
