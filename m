Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89045F17E6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfKFOFD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 09:05:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:60226 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfKFOFD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 09:05:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 06:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="212779387"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2019 06:05:00 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Nov 2019 16:04:59 +0200
Date:   Wed, 6 Nov 2019 16:04:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] pinctrl: cherryview: Split out irq hw-init into a
 separate helper function
Message-ID: <20191106140459.GW2552@lahna.fi.intel.com>
References: <20191106120956.119958-1-hdegoede@redhat.com>
 <20191106120956.119958-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106120956.119958-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 01:09:54PM +0100, Hans de Goede wrote:
> Split out irq hw-init into a separate chv_gpio_irq_init_hw() function.
> This is a preparation patch for passing the irqchip when adding the
> gpiochip.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 57 +++++++++++++---------
>  1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index dff2a81250b6..c5a44be1e904 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -165,6 +165,7 @@ struct chv_pinctrl {
>  	struct gpio_chip chip;
>  	struct irq_chip irqchip;
>  	void __iomem *regs;
> +	bool need_valid_mask;

Please add kernel-doc about this one.

Otherwise looks good.
