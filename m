Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BFD10705F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfKVKnZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 05:43:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:47785 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbfKVKnZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 05:43:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 02:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="216341366"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Nov 2019 02:43:20 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Nov 2019 12:43:20 +0200
Date:   Fri, 22 Nov 2019 12:43:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 2/2] gpio: sch: Hook into ACPI SCI handler to catch
 GPIO edge events
Message-ID: <20191122104319.GC11621@lahna.fi.intel.com>
References: <cover.1574277614.git.jan.kiszka@siemens.com>
 <bf556de14a3d093072e50b6a6cf3c64bd62b1730.1574277614.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf556de14a3d093072e50b6a6cf3c64bd62b1730.1574277614.git.jan.kiszka@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 20, 2019 at 08:20:14PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The ACPI description on the Quark platform does not provide the required
> information to do establish generic handling. Therefore, we need to hook
> from the driver directly into SCI handler of the ACPI subsystem in order
> to catch and report GPIO-related events.
> 
> Validated on the Quark-based IOT2000 platform.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Below one minor stylistic comment.

> ---
>  drivers/gpio/gpio-sch.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
> index 6a9c5500800c..75c95da145d8 100644
> --- a/drivers/gpio/gpio-sch.c
> +++ b/drivers/gpio/gpio-sch.c
> @@ -155,6 +155,31 @@ static const struct gpio_chip sch_gpio_chip = {
>  	.to_irq			= sch_gpio_to_irq,
>  };
>  
> +static u32 sch_sci_handler(void *context)
> +{
> +	struct sch_gpio *sch = context;
> +	unsigned long core_status, resume_status;
> +	unsigned int resume_gpios, offset;
> +
> +	core_status = inl(sch->iobase + GTS);
> +	resume_status = inl(sch->iobase + GTS + 0x20);
> +
> +	if (core_status == 0 && resume_status == 0)

You can also write this like

	if (!core_status &&& !resume_status)

> +		return ACPI_INTERRUPT_NOT_HANDLED;
> +
> +	for_each_set_bit(offset, &core_status, sch->resume_base)
> +		generic_handle_irq(sch->irq_base + offset);
> +
> +	resume_gpios = sch->chip.ngpio - sch->resume_base;
> +	for_each_set_bit(offset, &resume_status, resume_gpios)
> +		generic_handle_irq(sch->irq_base + sch->resume_base + offset);
> +
> +	outl(core_status, sch->iobase + GTS);
> +	outl(resume_status, sch->iobase + GTS + 0x20);
> +
> +	return ACPI_INTERRUPT_HANDLED;
> +}
> +
>  static int sch_irq_type(struct irq_data *d, unsigned int type)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> @@ -215,6 +240,7 @@ static int sch_gpio_probe(struct platform_device *pdev)
>  	struct irq_chip_type *ct;
>  	struct sch_gpio *sch;
>  	struct resource *res;
> +	acpi_status status;
>  	int irq_base, ret;
>  
>  	sch = devm_kzalloc(&pdev->dev, sizeof(*sch), GFP_KERNEL);
> @@ -303,6 +329,10 @@ static int sch_gpio_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	status = acpi_install_sci_handler(sch_sci_handler, sch);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
> -- 
> 2.16.4
