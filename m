Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A546D3BB9
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJKI5W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 04:57:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61918 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJKI5W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 04:57:22 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id f9a138447a090384; Fri, 11 Oct 2019 10:57:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Drake <drake@endlessm.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessm.com
Subject: Re: [PATCH] ACPI: EC: add support for hardware-reduced systems
Date:   Fri, 11 Oct 2019 10:57:17 +0200
Message-ID: <2998970.A31yCv94R0@kreacher>
In-Reply-To: <20190904063443.17119-1-drake@endlessm.com>
References: <20190904063443.17119-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sorry for the delay.

On Wednesday, September 4, 2019 8:34:43 AM CEST Daniel Drake wrote:
> As defined in the ACPI spec section 12.11, ACPI hardware-reduced
> platforms define the EC SCI interrupt as a GpioInt in the _CRS object.
> 
> This replaces the previous way of using a GPE for this interrupt;
> GPE blocks are not available on reduced hardware platforms.
> 
> Add support for handling this interrupt as an EC event source, and
> avoid GPE usage on reduced hardware platforms.
> 
> This enables the use of several media keys (e.g. screen brightness
> up/down) on Asus UX434DA.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Just as a matter of clarity, I would like the changes to be split into the
rename of EC_FLAGS_GPE_MASKED (without functional impact) and the rest.

> ---
>  drivers/acpi/ec.c       | 81 +++++++++++++++++++++++++++++++----------
>  drivers/acpi/internal.h |  1 +
>  2 files changed, 63 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index c33756ed3304..37bbec89be82 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -99,7 +99,7 @@ enum {
>  	EC_FLAGS_EVT_HANDLER_INSTALLED, /* _Qxx handlers installed */
>  	EC_FLAGS_STARTED,		/* Driver is started */
>  	EC_FLAGS_STOPPED,		/* Driver is stopped */
> -	EC_FLAGS_GPE_MASKED,		/* GPE masked */
> +	EC_FLAGS_EVENTS_MASKED,		/* GPE or IRQ masked */
>  };
>  
>  #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
> @@ -414,20 +414,26 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
>  		wake_up(&ec->wait);
>  }
>  
> -static void acpi_ec_mask_gpe(struct acpi_ec *ec)
> +static void acpi_ec_mask_events(struct acpi_ec *ec)
>  {
> -	if (!test_bit(EC_FLAGS_GPE_MASKED, &ec->flags)) {
> -		acpi_ec_disable_gpe(ec, false);
> +	if (!test_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags)) {
> +		if (ec->irq >= 0)
> +			disable_irq_nosync(ec->irq);
> +		else
> +			acpi_ec_disable_gpe(ec, false);

So IMO it would be better to change the gpe data type to int and initialize it
to -1.

Then, you can do

if (ec->gpe >= 0)
        acpi_ec_disable_gpe(ec, false);
else
        disable_irq_nosync(ec->irq);

and also check gpe in some other places like acpi_ec_suspend/resume_noirq().

And fail the initialization when you cannot get neither the GPE number nor
the interrupt.

>  		ec_dbg_drv("Polling enabled");
> -		set_bit(EC_FLAGS_GPE_MASKED, &ec->flags);
> +		set_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags);
>  	}
>  }
>  
> -static void acpi_ec_unmask_gpe(struct acpi_ec *ec)
> +static void acpi_ec_unmask_events(struct acpi_ec *ec)
>  {
> -	if (test_bit(EC_FLAGS_GPE_MASKED, &ec->flags)) {
> -		clear_bit(EC_FLAGS_GPE_MASKED, &ec->flags);
> -		acpi_ec_enable_gpe(ec, false);
> +	if (test_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags)) {
> +		clear_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags);
> +		if (ec->irq >= 0)
> +			enable_irq(ec->irq);
> +		else
> +			acpi_ec_enable_gpe(ec, false);
>  		ec_dbg_drv("Polling disabled");
>  	}
>  }
> @@ -453,7 +459,7 @@ static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
>  
>  static void acpi_ec_submit_query(struct acpi_ec *ec)
>  {
> -	acpi_ec_mask_gpe(ec);
> +	acpi_ec_mask_events(ec);
>  	if (!acpi_ec_event_enabled(ec))
>  		return;
>  	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
> @@ -469,7 +475,7 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
>  	if (test_and_clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
>  		ec_dbg_evt("Command(%s) unblocked",
>  			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
> -	acpi_ec_unmask_gpe(ec);
> +	acpi_ec_unmask_events(ec);
>  }
>  
>  static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
> @@ -647,7 +653,8 @@ static void advance_transaction(struct acpi_ec *ec)
>  	 * ensure a hardware STS 0->1 change after this clearing can always
>  	 * trigger a GPE interrupt.
>  	 */
> -	acpi_ec_clear_gpe(ec);
> +	if (ec->irq < 0)
> +		acpi_ec_clear_gpe(ec);
>  	status = acpi_ec_read_status(ec);
>  	t = ec->curr;
>  	/*
> @@ -716,7 +723,7 @@ static void advance_transaction(struct acpi_ec *ec)
>  				++t->irq_count;
>  			/* Allow triggering on 0 threshold */
>  			if (t->irq_count == ec_storm_threshold)
> -				acpi_ec_mask_gpe(ec);
> +				acpi_ec_mask_events(ec);
>  		}
>  	}
>  out:
> @@ -814,7 +821,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
>  
>  	spin_lock_irqsave(&ec->lock, tmp);
>  	if (t->irq_count == ec_storm_threshold)
> -		acpi_ec_unmask_gpe(ec);
> +		acpi_ec_unmask_events(ec);
>  	ec_dbg_req("Command(%s) stopped", acpi_ec_cmd_string(t->command));
>  	ec->curr = NULL;
>  	/* Disable GPE for command processing (IBF=0/OBF=1) */
> @@ -1292,18 +1299,32 @@ static void acpi_ec_event_handler(struct work_struct *work)
>  	acpi_ec_check_event(ec);
>  }
>  
> -static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
> -	u32 gpe_number, void *data)
> +static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
>  {
>  	unsigned long flags;
> -	struct acpi_ec *ec = data;
>  
>  	spin_lock_irqsave(&ec->lock, flags);
>  	advance_transaction(ec);
>  	spin_unlock_irqrestore(&ec->lock, flags);
> +}
> +
> +static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
> +	u32 gpe_number, void *data)
> +{
> +	struct acpi_ec *ec = data;
> +
> +	acpi_ec_handle_interrupt(ec);

You can pass data here without using the extra local var.

>  	return ACPI_INTERRUPT_HANDLED;
>  }
>  
> +static irqreturn_t acpi_ec_irq_handler(int irq, void *data)
> +{
> +	struct acpi_ec *ec = data;
> +
> +	acpi_ec_handle_interrupt(ec);
> +	return IRQ_HANDLED;
> +}
> +
>  /* --------------------------------------------------------------------------
>   *                           Address Space Management
>   * -------------------------------------------------------------------------- */
> @@ -1376,6 +1397,7 @@ static struct acpi_ec *acpi_ec_alloc(void)
>  	ec->timestamp = jiffies;
>  	ec->busy_polling = true;
>  	ec->polling_guard = 0;
> +	ec->irq = -1;
>  	return ec;
>  }
>  
> @@ -1419,7 +1441,7 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>  		 * EC.
>  		 */
>  		ec->gpe = boot_ec->gpe;
> -	} else {
> +	} else if (!acpi_gbl_reduced_hardware) {

I'm not sure if this check is necessary.

if _GPE is not present, you can assume hardware-reduced and look for the GPIO
IRQ.

>  		/* Get GPE bit assignment (EC events). */
>  		/* TODO: Add support for _GPE returning a package */
>  		status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
> @@ -1480,7 +1502,8 @@ static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
>  				    NULL, ec, NULL);
>  		set_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags);

I would rename this to EC_FLAGS_QUERY_METHODS_INSTALLED ->

>  	}
> -	if (!test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {

and this to EC_FLAGS_EVTENT_HANDLER_INSTALLED ->>

> +	if (!acpi_gbl_reduced_hardware &&
> +	    !test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {

and I would use it to check if there is an "event" (either GPE or IRQ) handler
registered already.

>  		status = acpi_install_gpe_raw_handler(NULL, ec->gpe,
>  					  ACPI_GPE_EDGE_TRIGGERED,
>  					  &acpi_ec_gpe_handler, ec);

And there's some code below which I believe you kind of need for the IRQ case
too.

> @@ -1493,6 +1516,12 @@ static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
>  				acpi_ec_enable_gpe(ec, true);
>  		}
>  	}
> +	if (ec->irq >= 0) {
> +		int ret = request_irq(ec->irq, acpi_ec_irq_handler,
> +				      IRQF_SHARED, "ACPI EC", ec);
> +		if (ret)
> +			return ret;
> +	}

I would move this to the "_HANDLER_INSTALLED" block above.

>  	/* EC is fully operational, allow queries */
>  	acpi_ec_enable_event(ec);
>  
> @@ -1521,6 +1550,8 @@ static void ec_remove_handlers(struct acpi_ec *ec)
>  	 */
>  	acpi_ec_stop(ec, false);
>  
> +	if (ec->irq >= 0)
> +		free_irq(ec->irq, ec);
>  	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
>  		if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
>  					&acpi_ec_gpe_handler)))
> @@ -1611,6 +1642,18 @@ static int acpi_ec_add(struct acpi_device *device)
>  			acpi_ec_free(ec);
>  			ec = boot_ec;
>  		}
> +
> +		/*
> +		 * Reduced hartware platforms use a GpioInt specified in
> +		 * _CRS.
> +		 */
> +		if (acpi_gbl_reduced_hardware) {
> +			ret = acpi_dev_gpio_irq_get(device, 0);
> +			if (ret == -EPROBE_DEFER)
> +				goto err_alloc;
> +
> +			ec->irq = ret;
> +		}

And this should go to where you request the IRQ.  There's no reason for it
to be here AFAICS.

>  	}
>  
>  	ret = acpi_ec_setup(ec, true);
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f4c2fe6be4f2..34c2c85e667e 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -166,6 +166,7 @@ static inline void acpi_early_processor_osc(void) {}
>  struct acpi_ec {
>  	acpi_handle handle;
>  	u32 gpe;
> +	int irq;
>  	unsigned long command_addr;
>  	unsigned long data_addr;
>  	bool global_lock;
> 




