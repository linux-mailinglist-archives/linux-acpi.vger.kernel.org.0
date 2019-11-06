Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24308F1AFF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 17:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfKFQSU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 11:18:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:51654 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfKFQSU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 11:18:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:18:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="377098186"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2019 08:18:17 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iSO0e-0005s2-Ea; Wed, 06 Nov 2019 18:18:16 +0200
Date:   Wed, 6 Nov 2019 18:18:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191106161816.GO32742@smile.fi.intel.com>
References: <20191106154715.155596-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106154715.155596-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 04:47:12PM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of my series for Cherry Trail devices to pass the irqchip when
> adding the gpiochip instead of registering it separately. Similar to how
> this is done for Bay Trail devices in Andy's recent series:
> "[RESEND][PATCH v2 0/7] gpiolib: fix GPIO <-> pin mapping registration".
> 
> Note this series depends on that series as well as on the cherryview changes
> currently queued in pinctrl/intel.git/for-next .

LGTM independently on the discussion in patch 3

> 
> Changes in v2:
> - Add kerndoc comments for new chv_pinctrl struct members
> 
> Regards,
> 
> Hans
> 

-- 
With Best Regards,
Andy Shevchenko


