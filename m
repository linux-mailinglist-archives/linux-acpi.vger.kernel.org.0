Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A494558D8
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 11:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244858AbhKRKVi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 05:21:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:25334 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244451AbhKRKUz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 05:20:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="232877346"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="232877346"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 02:13:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="593721979"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 02:13:35 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 18 Nov 2021 12:13:33 +0200
Date:   Thu, 18 Nov 2021 12:13:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: cherryview: Don't use pin/offset 0 to mark
 an interrupt-line as unused
Message-ID: <YZYnTbubff1trHkv@lahna>
References: <20211117231614.758362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117231614.758362-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

Few minor comments below.

On Thu, Nov 18, 2021 at 12:16:12AM +0100, Hans de Goede wrote:
> offset/pin 0 is a perfectly valid offset, so stop using it to have

Offset/pin (with capital O).

> the special meaning of interrupt-line not used in the intr_lines.

interrupt line

> Instead introduce a new special INTR_LINE_UNUSED value which is never
> a valid offset and use that to indicate unused interrupt-lines.

interrupt lines

> Cc: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index 980099028cf8..a46f9e5a4748 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -73,6 +73,8 @@ struct intel_pad_context {
>  	u32 padctrl1;
>  };
>  
> +#define INTR_LINE_UNUSED		U32_MAX
> +
>  /**
>   * struct intel_community_context - community context for Cherryview
>   * @intr_lines: Mapping between 16 HW interrupt wires and GPIO offset (in GPIO number space)
> @@ -812,7 +814,7 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
>  		/* Reset the interrupt mapping */
>  		for (i = 0; i < ARRAY_SIZE(cctx->intr_lines); i++) {
>  			if (cctx->intr_lines[i] == offset) {
> -				cctx->intr_lines[i] = 0;
> +				cctx->intr_lines[i] = INTR_LINE_UNUSED;
>  				break;
>  			}
>  		}
> @@ -1319,7 +1321,7 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
>  		else
>  			handler = handle_edge_irq;
>  
> -		if (!cctx->intr_lines[intsel]) {
> +		if (cctx->intr_lines[intsel] == INTR_LINE_UNUSED) {
>  			irq_set_handler_locked(d, handler);
>  			cctx->intr_lines[intsel] = pin;
>  		}
> @@ -1412,6 +1414,12 @@ static void chv_gpio_irq_handler(struct irq_desc *desc)
>  		unsigned int offset;
>  
>  		offset = cctx->intr_lines[intr_line];
> +		if (offset == INTR_LINE_UNUSED) {
> +			dev_err(pctrl->dev, "Interrupt on unused interrupt line %u\n",

Let's be consistent with the logging so no capital letter here =>
"interrupt on .."

> +				intr_line);
> +			continue;
> +		}
> +
>  		generic_handle_domain_irq(gc->irq.domain, offset);
>  	}
>  
> @@ -1620,9 +1628,10 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
>  	struct intel_community *community;
>  	struct device *dev = &pdev->dev;
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct intel_community_context *cctx;
>  	struct intel_pinctrl *pctrl;
>  	acpi_status status;
> -	int ret, irq;
> +	int i, ret, irq;
>  
>  	soc_data = intel_pinctrl_get_soc_data(pdev);
>  	if (IS_ERR(soc_data))
> @@ -1663,6 +1672,10 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
>  	if (!pctrl->context.communities)
>  		return -ENOMEM;
>  
> +	cctx = &pctrl->context.communities[0];
> +	for (i = 0; i < ARRAY_SIZE(cctx->intr_lines); i++)
> +		cctx->intr_lines[i] = INTR_LINE_UNUSED;
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> -- 
> 2.31.1
