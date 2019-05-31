Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82A930C6D
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaKNm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 06:13:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62714 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaKNm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2019 06:13:42 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 950d3e566dff9670; Fri, 31 May 2019 12:13:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Furquan Shaikh <furquan@google.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatja@google.com,
        dlaurie@google.com
Subject: Re: [PATCH] drivers/acpi: Turn off power resources while entering S5
Date:   Fri, 31 May 2019 12:13:39 +0200
Message-ID: <26443804.PuBNBtcb44@kreacher>
In-Reply-To: <20190423233904.195842-1-furquan@google.com>
References: <20190423233904.195842-1-furquan@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, April 24, 2019 1:39:04 AM CEST Furquan Shaikh wrote:
> During boot-up, ACPI bus scan enables all power resources
> so that respective device drivers can talk to their device. This causes acpi
> ref_count for the power resource to be incremented to 1. When system
> suspends (S3/S0ix) or hibernates(S4), DPM is responsible for calling
> power off on all power resources whose ref_count is 1 i.e. no other
> user of this power resource and thus resulting in _OFF routine being
> called for it.
> 
> However, in case of poweroff, DPM is not involved and so the power
> resources are left on when the system is entering S5. This results in
> the violation of power down sequencing for certain devices
> e.g. touchscreen or digitizer I2C devices.

I'm not sure I can follow you here.  Any details?

> In order to ensure that the
> power down sequencing does the right thing, it is necessary for ACPI
> to disable all power resources while preparing for S5.

Well, I would say that this is not just about power resources.  ACPI PM methods should be
invoked for the devices as well, so generally there should be subject to the normal PM
during S5 transitions.

Generally speaking, S5 should follow the code flow of the last phase of hibernation.

> This change updates the function acpi_turn_off_unused_power_resources
> to accept a parameter acpi_system_state, This function turns off power
> resources according to the targeted system ACPI state:
> 1. For S0: Unused power resources are turned off i.e. power resources
> whose ref_count is already 0.
> 2. For S5: ref_count is decremented first to undo the increment
> performed during ACPI bus scan and then power resources with ref_count
> 0 are turned off.
> 3. All other suspend/hibernate states: No action is required since DPM
> takes care of turning off power resources.
> 
> This change should not affect the wake capable devices since:
> 1. If wake capable devices are enabled before this call, their
> refcount should be greater than 1. Thus, they won't be turned off.
> 2. If wake capable devices are not enabled yet when this call is made,
> they would eventually get turned on by call to
> acpi_enable_wakeup_devices.

Quite frankly, this looks like a hack causing a particular platform to behave
as expected, but it very well may not be applicable to other platforms.

> Signed-off-by: Furquan Shaikh <furquan@google.com>
> ---
>  drivers/acpi/power.c | 47 ++++++++++++++++++++++++++++++++++++++------
>  drivers/acpi/sleep.c |  5 ++++-
>  drivers/acpi/sleep.h |  2 +-
>  3 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 665e93ca0b40f..945db762861a3 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -889,10 +889,42 @@ void acpi_resume_power_resources(void)
>  
>  	mutex_unlock(&power_resource_list_lock);
>  }
> +#endif
>  
> -void acpi_turn_off_unused_power_resources(void)
> +/**
> + * acpi_turn_off_power_resources: This function is used to turn off power
> + * resources in provided ACPI system state.
> + *
> + * Behavior differs based on the target system state:
> + * ACPI_STATE_S0: Turn off unused power resources i.e. turn off power resources
> + *                with ref_count zero.
> + * ACPI_STATE_S5: Decrement ref_count first and turn off power resources with
> + *                ref_count zero. This is done to ensure that the ref_count
> + *                incremented during ACPI bus scan is undone and any power
> + *                resources that are not required during S5 are turned off.
> + * ACPI_STATE_Sx: No action required. DPM is responsible for turning off power
> + *                resources while suspending/hibernating.
> + */
> +void acpi_turn_off_power_resources(int acpi_system_state)
>  {
>  	struct acpi_power_resource *resource;
> +	int decrement;
> +
> +	if (acpi_system_state == ACPI_STATE_S0) {
> +		/*
> +		 * In case of ACPI_STATE_S0, turn off only unused power
> +		 * resources. So, no need to decrement ref_count.
> +		 */
> +		decrement = 0;
> +	} else if (acpi_system_state == ACPI_STATE_S5) {
> +		/*
> +		 * In case of ACPI_STATE_S5, ref_count needs to be decremented
> +		 * first before checking if it is okay to power off the
> +		 * resource.
> +		 */
> +		decrement = 1;

Instead of doing this you could add a routing decrementing the recfount for all of
the power resources in the ON state and call that, before the original
acpi_turn_off_unused_power_resources(), in acpi_power_off_prepare().

That said I don't think the approach is valid in general as stated above.

> +	} else
> +		return;
>  
>  	mutex_lock(&power_resource_list_lock);
>  
> @@ -907,10 +939,14 @@ void acpi_turn_off_unused_power_resources(void)
>  			continue;
>  		}
>  
> -		if (state == ACPI_POWER_RESOURCE_STATE_ON
> -		    && !resource->ref_count) {
> -			dev_info(&resource->device.dev, "Turning OFF\n");
> -			__acpi_power_off(resource);
> +		if (state == ACPI_POWER_RESOURCE_STATE_ON) {
> +			if (resource->ref_count)
> +				resource->ref_count -= decrement;
> +
> +			if (!resource->ref_count) {
> +				dev_info(&resource->device.dev, "Turning OFF\n");
> +				__acpi_power_off(resource);
> +			}
>  		}
>  
>  		mutex_unlock(&resource->resource_lock);
> @@ -918,4 +954,3 @@ void acpi_turn_off_unused_power_resources(void)
>  
>  	mutex_unlock(&power_resource_list_lock);
>  }
> -#endif
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff153498..fb6b3ca0eeb91 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -75,6 +75,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
>  	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
>  		acpi_state);
>  	acpi_enable_wakeup_devices(acpi_state);
> +
> +	acpi_turn_off_power_resources(acpi_state);
> +
>  	acpi_enter_sleep_state_prep(acpi_state);
>  	return 0;
>  }
> @@ -524,7 +527,7 @@ static void acpi_pm_start(u32 acpi_state)
>   */
>  static void acpi_pm_end(void)
>  {
> -	acpi_turn_off_unused_power_resources();
> +	acpi_turn_off_power_resources(ACPI_STATE_S0);
>  	acpi_scan_lock_release();
>  	/*
>  	 * This is necessary in case acpi_pm_finish() is not called during a
> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
> index 41675d24a9bc0..a495c91e2bf3b 100644
> --- a/drivers/acpi/sleep.h
> +++ b/drivers/acpi/sleep.h
> @@ -7,7 +7,7 @@ extern struct list_head acpi_wakeup_device_list;
>  extern struct mutex acpi_device_lock;
>  
>  extern void acpi_resume_power_resources(void);
> -extern void acpi_turn_off_unused_power_resources(void);
> +extern void acpi_turn_off_power_resources(int acpi_system_state);
>  
>  static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>  {
> 




