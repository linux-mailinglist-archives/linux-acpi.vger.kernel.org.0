Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9985F17E8
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfKFOGA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 09:06:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:42060 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfKFOGA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 09:06:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 06:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="212779551"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2019 06:05:57 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Nov 2019 16:05:56 +0200
Date:   Wed, 6 Nov 2019 16:05:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191106140556.GX2552@lahna.fi.intel.com>
References: <20191106120956.119958-1-hdegoede@redhat.com>
 <20191106120956.119958-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106120956.119958-4-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 01:09:56PM +0100, Hans de Goede wrote:
> We need to convert all old gpio irqchips to pass the irqchip
> setup along when adding the gpio_chip. For more info see
> drivers/gpio/TODO.
> 
> For chained irqchips this is a pretty straight-forward conversion.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 41 +++++++++++-----------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index 38b359db6013..1f9751ae0ed0 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -166,6 +166,7 @@ struct chv_pinctrl {
>  	struct irq_chip irqchip;
>  	void __iomem *regs;
>  	bool need_valid_mask;
> +	unsigned int irq;

Same here.
