Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD18D18525
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 08:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEIGML (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 02:12:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45913 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIGMK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 May 2019 02:12:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id u3so999867oic.12
        for <linux-acpi@vger.kernel.org>; Wed, 08 May 2019 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+8FULLffFx7fYiQWZzicW549K/RiT8LNAYFVRsp9uI=;
        b=gfgkk5oZUTqBetQJ1TO2YA+AncASlOUi39E1dmeJ5RDB4mVXfUdq85hI0MNduiP9ce
         2i5KFtiJrkml3dUdXV1SXvGeGqb5/fZuf3sTRr003bUh3+qsmdLG9Eo9R/tr4m0Be+1f
         53te+tTTJPMuRe+D459apCxOOdAunZ0itZNNdB/Q/haRNVRybWCVNQ8WBlTYhcGW1ybq
         Psnqc7utsHleE5rhER7+4fOaV7y3y2jKsdsRZQLk/KdT6mpejWyCfkEnVvfKSh/+lXKx
         gk5P/jqFz2rpvezDXC2I0OEn6218DvqDAdMhgoxu9/tdkVPPrvhv84grSBeYxpqxX9Hi
         9/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+8FULLffFx7fYiQWZzicW549K/RiT8LNAYFVRsp9uI=;
        b=l9R1bPSq8TECRrNhJA22pTF8K0pnDV+kMJfNGljCmDJIhiAh3Q5CCbD4aEWyTwpES+
         CEmSQxc/+11zZjESqpLjy0ePBEWWmxay7W5RDeN9RPAEJeOPr8x1TheMXsmKAtWobiyX
         Igv//oEYeGH7MI3HwQx18RR1DxKtukar+Gk+HmQYEG0loBCfNNeRSQ5BfiJYVwpFHCWv
         9kjXKCR/JMaohN5OW/I5qBXsX540vkB6Jkl5iq0ZHjA1Vhd5SPQ7+d56vIj7uxUzSgop
         tX0AYQGr2g3gu1XwcOErRmnzDPbnqB3K8Aaa9QPR8oM3oGSA1zOImhGVJI39jUKbY5hC
         hYTQ==
X-Gm-Message-State: APjAAAV960YeCFt12agOavFrTwgS9DORcwGfALTB96lQqNGRDxZIqw/H
        dSPRLn1820MbnRz+iC2OpQTLVPZFaG2MlSz4EVpkbA==
X-Google-Smtp-Source: APXvYqwSzRk255YY1C+R1hKUV1ccGvW7nQS5fdqp0fsRSSL9pVF18LpVg2cPnymxZyYOnqQGeEKfhezPyo2yqMKTTXo=
X-Received: by 2002:aca:aa43:: with SMTP id t64mr436047oie.12.1557382329361;
 Wed, 08 May 2019 23:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190423233904.195842-1-furquan@google.com>
In-Reply-To: <20190423233904.195842-1-furquan@google.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 8 May 2019 23:11:57 -0700
Message-ID: <CAEGmHFEf4RTn5mrQ4pn+WPz=WnD5id9joEdGQnu==ibx+r1L8g@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Turn off power resources while entering S5
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Todd Broch <tbroch@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 23, 2019 at 4:39 PM Furquan Shaikh <furquan@google.com> wrote:
>
> During boot-up, ACPI bus scan enables all power resources so that
> respective device drivers can talk to their device. This causes acpi
> ref_count for the power resource to be incremented to 1. When system
> suspends (S3/S0ix) or hibernates(S4), DPM is responsible for calling
> power off on all power resources whose ref_count is 1 i.e. no other
> user of this power resource and thus resulting in _OFF routine being
> called for it.
>
> However, in case of poweroff, DPM is not involved and so the power
> resources are left on when the system is entering S5. This results in
> the violation of power down sequencing for certain devices
> e.g. touchscreen or digitizer I2C devices. In order to ensure that the
> power down sequencing does the right thing, it is necessary for ACPI
> to disable all power resources while preparing for S5.
>
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
>
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
>         mutex_unlock(&power_resource_list_lock);
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
>         struct acpi_power_resource *resource;
> +       int decrement;
> +
> +       if (acpi_system_state == ACPI_STATE_S0) {
> +               /*
> +                * In case of ACPI_STATE_S0, turn off only unused power
> +                * resources. So, no need to decrement ref_count.
> +                */
> +               decrement = 0;
> +       } else if (acpi_system_state == ACPI_STATE_S5) {
> +               /*
> +                * In case of ACPI_STATE_S5, ref_count needs to be decremented
> +                * first before checking if it is okay to power off the
> +                * resource.
> +                */
> +               decrement = 1;
> +       } else
> +               return;
>
>         mutex_lock(&power_resource_list_lock);
>
> @@ -907,10 +939,14 @@ void acpi_turn_off_unused_power_resources(void)
>                         continue;
>                 }
>
> -               if (state == ACPI_POWER_RESOURCE_STATE_ON
> -                   && !resource->ref_count) {
> -                       dev_info(&resource->device.dev, "Turning OFF\n");
> -                       __acpi_power_off(resource);
> +               if (state == ACPI_POWER_RESOURCE_STATE_ON) {
> +                       if (resource->ref_count)
> +                               resource->ref_count -= decrement;
> +
> +                       if (!resource->ref_count) {
> +                               dev_info(&resource->device.dev, "Turning OFF\n");
> +                               __acpi_power_off(resource);
> +                       }
>                 }
>
>                 mutex_unlock(&resource->resource_lock);
> @@ -918,4 +954,3 @@ void acpi_turn_off_unused_power_resources(void)
>
>         mutex_unlock(&power_resource_list_lock);
>  }
> -#endif
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff153498..fb6b3ca0eeb91 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -75,6 +75,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
>         printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
>                 acpi_state);
>         acpi_enable_wakeup_devices(acpi_state);
> +
> +       acpi_turn_off_power_resources(acpi_state);
> +
>         acpi_enter_sleep_state_prep(acpi_state);
>         return 0;
>  }
> @@ -524,7 +527,7 @@ static void acpi_pm_start(u32 acpi_state)
>   */
>  static void acpi_pm_end(void)
>  {
> -       acpi_turn_off_unused_power_resources();
> +       acpi_turn_off_power_resources(ACPI_STATE_S0);
>         acpi_scan_lock_release();
>         /*
>          * This is necessary in case acpi_pm_finish() is not called during a
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
> --
> 2.21.0.593.g511ec345e18-goog
>

Hi Rafael,

Gentle ping. Just checking if you got a chance to look at this one. It
is actually causing problems in one of our devices since power off
sequencing is not honored when entering S5.

Thanks,
Furquan
