Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A347E33FA75
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 22:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhCQV0o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 17:26:44 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37331 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231161AbhCQV0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Mar 2021 17:26:36 -0400
Received: from [192.168.0.3] (ip5f5aeabc.dynamic.kabel-deutschland.de [95.90.234.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D5C4020647911;
        Wed, 17 Mar 2021 22:26:33 +0100 (CET)
Subject: Re: [PATCH] ACPI: scan: Turn off unused power resources during
 initialization
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        David Box <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <2527835.vZkJICojNU@kreacher>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <8b35de7b-072f-128c-6a3f-c7da5a1b91b8@molgen.mpg.de>
Date:   Wed, 17 Mar 2021 22:26:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <2527835.vZkJICojNU@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Rafael,


Am 17.03.21 um 17:49 schrieb Rafael J. Wysocki:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that on certain platforms unused ACPI power resources
> that have not been explicitly turned off prevent the platform from
> reaching the lowest power state in suspend-to-idle which leads to
> excessive power draw.
> 
> For this reason, turn all of the unused ACPI power resources off
> at the end of the initial namespace scan for devices in analogy with
> resume from suspend-to-RAM.
> 
> Reported-by: David Box <david.e.box@linux.intel.com>

Thank you for the patch. Could you please add more details to the commit 
message, saying what device this was on, and if there were some 
error/warning messages pointing to the problem?


Kind regards,

Paul


> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/internal.h |    1 +
>   drivers/acpi/scan.c     |    2 ++
>   drivers/acpi/sleep.h    |    1 -
>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -139,6 +139,7 @@ int acpi_device_sleep_wake(struct acpi_d
>   int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
>   int acpi_power_on_resources(struct acpi_device *device, int state);
>   int acpi_power_transition(struct acpi_device *device, int state);
> +void acpi_turn_off_unused_power_resources(void);
>   
>   /* --------------------------------------------------------------------------
>                                 Device Power Management
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2360,6 +2360,8 @@ int __init acpi_scan_init(void)
>   		}
>   	}
>   
> +	acpi_turn_off_unused_power_resources();
> +
>   	acpi_scan_initialized = true;
>   
>    out:
> Index: linux-pm/drivers/acpi/sleep.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.h
> +++ linux-pm/drivers/acpi/sleep.h
> @@ -8,7 +8,6 @@ extern struct list_head acpi_wakeup_devi
>   extern struct mutex acpi_device_lock;
>   
>   extern void acpi_resume_power_resources(void);
> -extern void acpi_turn_off_unused_power_resources(void);
>   
>   static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>   {
