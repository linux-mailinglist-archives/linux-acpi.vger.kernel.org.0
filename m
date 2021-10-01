Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03B841F246
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhJAQnj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 12:43:39 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44912 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhJAQnj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 12:43:39 -0400
Received: by mail-ot1-f47.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso12221289otb.11
        for <linux-acpi@vger.kernel.org>; Fri, 01 Oct 2021 09:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SViyDs+j4CEaRpiMC5djOcVRzaRxaVkhTpjpAv7p+ok=;
        b=nwNlZ+/4BvWgirhM3H5kka0mIslD2+lvjgGR74A5Yacl26En53G64SZ+8JznmCIBoi
         7iVprBWrYP0mNg6TdVrIx30A2RqRVwri8Ga8aaI8HH3RLe9LbdjaNDoUutIlOPkXkP6H
         kl6GJHvApzVFTakc8C9IADHrQpEclevRrPYALWYzQfUeiSisdcYHwpuOUg11AP/6z4zT
         5lECYwYLhRR6+Z3GVhXpQmd9fIPDc5G8q7RJHLMe32lJLPa3WiUz47piguntvaN0KjRC
         hZimAnmj4JZtz6GGqgq8y8g/sfYZ9BezYoSIa3D8fCpc65KBkJ37Nt7vfWf4A//UDXK+
         X9eQ==
X-Gm-Message-State: AOAM5303DvxRt7R6ExwddKJW9L70+/DxVHUVsV1uO7MYbGoLMYeOVtkD
        UOMhwVRzStMv7OVdUMq3+0baSOjC4TmQEnEVhizaWFyh
X-Google-Smtp-Source: ABdhPJw5vnySds/TOTS6TBKELkeqN85nhkIlXG4mZX6B8dBtX5sm9mP+zyFcLewePmCw8k7LSS9+zoEabzKzww8LEr8=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr11418486otr.301.1633106514590;
 Fri, 01 Oct 2021 09:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211001161854.19802-1-mario.limonciello@amd.com>
In-Reply-To: <20211001161854.19802-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Oct 2021 18:41:43 +0200
Message-ID: <CAJZ5v0ipP6YCrw+ypyTX9b_O-93Y=RY8PKNp=ojfZe0qP=Hh7w@mail.gmail.com>
Subject: Re: [RFC] acpi/x86: s2idle: Use constraints to enforce behavior
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 1, 2021 at 6:19 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Currently s2idle constraints are only verified when pm_debug_messages
> is set.

Very much intentionally.

> Although useful for debugging, it does have a tendency to paper
> over some underlying issues.

What do you mean "paper over"?  It is not expected to do anything
except for providing information.

> Of particular note, I found a case that a system that has two physical
> SATA controllers that share the same ACPI Power Resource.  When a drive is
> connected to one of the controllers then it will bind with PCI devices with
> the ahci driver and form a relationship with the firmware node and physical
> node.  During s2idle I see that the constraints are met for this device as
> it's transitioned into the appropriate state. However the second ACPI node
> doesn't have any relationship with a physical node and so it stays in "D0":

So the debug information is actually useful.

>
> ```
> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
> ACPI: PM: Power resource [P0SA] still in use
> acpi device:2a: Power state changed to D3cold
> ```
>
> Due to the refcounting used on the shared power resource putting the
> device with a physical node into D3 doesn't result in the _OFF method
> being called.
>
> To help this problem, make the following changes to the constraint
> checking:
> 1) Make constraint checking compulsory

That would break things AFAICS due to false-positives resulting from it.

The rule of thumb is to check the constraints only if you don't get
the expected state.

> but gate the output on pm_debug_messages
> 2) As part of constraint checking verify if the ACPI device has a physical
> node or not.
> 3) If a device doesn't have a physical node, but does have a requirement
> set the power state for the device to allow shared resources to transition.

This fixes your particular issue, but is it generally safe?

Also, I think that this needs to be taken care of during system
initialization rather than here.  Device objects without physical
nodes that prevent power resources from being turned off are generally
not useful at all and they prevent the SoC from getting into
lower-power states through active-state power management as well.

> After making this change, here is what the flow looks like:
> ```
> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
> ACPI: PM: Power resource [P0SA] still in use
> acpi device:2a: Power state changed to Dcold
> <snip>
> ACPI: \_SB_.PCI0.GP18.SAT1: LPI: Device is not physically present - forcing transition from D0 to D3cold
> ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
> ACPI: PM: Power resource [P0SA] turned off
> acpi device:2c: Power state changed to D3cold
> ```
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index bd92b549fd5a..fbfac40733eb 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -304,14 +304,25 @@ static void lpi_check_constraints(void)
>                         acpi_power_state_string(adev->power.state));
>
>                 if (!adev->flags.power_manageable) {
> -                       acpi_handle_info(handle, "LPI: Device not power manageable\n");
> +                       if (pm_debug_messages_on)
> +                               acpi_handle_info(handle, "LPI: Device not power manageable\n");
>                         lpi_constraints_table[i].handle = NULL;
>                         continue;
>                 }
>
> -               if (adev->power.state < lpi_constraints_table[i].min_dstate)
> -                       acpi_handle_info(handle,
> -                               "LPI: Constraint not met; min power state:%s current power state:%s\n",
> +               if (adev->power.state >= lpi_constraints_table[i].min_dstate)
> +                       continue;
> +               /* make sure that anything with shared resources isn't blocked */
> +               if (!acpi_get_first_physical_node(adev)) {
> +                       if (pm_debug_messages_on)
> +                               acpi_handle_info(handle, "LPI: Device is not physically present - forcing transition from %s to %s\n",
> +                                               acpi_power_state_string(adev->power.state),
> +                                               acpi_power_state_string(ACPI_STATE_D3_COLD));
> +                       acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +                       continue;
> +               }
> +               if (pm_debug_messages_on)
> +                       acpi_handle_info(handle, "LPI: Constraint not met; min power state:%s current power state:%s\n",
>                                 acpi_power_state_string(lpi_constraints_table[i].min_dstate),
>                                 acpi_power_state_string(adev->power.state));
>         }
> @@ -446,8 +457,7 @@ int acpi_s2idle_prepare_late(void)
>         if (!lps0_device_handle || sleep_no_lps0)
>                 return 0;
>
> -       if (pm_debug_messages_on)
> -               lpi_check_constraints();
> +       lpi_check_constraints();
>
>         /* Screen off */
>         if (lps0_dsm_func_mask > 0)
> --
> 2.25.1
>
