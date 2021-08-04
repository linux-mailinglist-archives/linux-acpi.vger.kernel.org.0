Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D172C3E0795
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Aug 2021 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhHDS1j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Aug 2021 14:27:39 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38543 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbhHDS1g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2021 14:27:36 -0400
Received: by mail-ot1-f49.google.com with SMTP id g5-20020a9d6b050000b02904f21e977c3eso2495511otp.5;
        Wed, 04 Aug 2021 11:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hazk2yjrmJfy94v5XypD2msNbyP8STncbqMZCCOqXpI=;
        b=ZxEjZFnXnt6kIPH19Ts9Gq1CIf+kWrDLitaD5IyYVZN5m2d93fvKED4RhZf9gt6OP5
         QD+tOUrm8IvY8FuYNJbm7oj3M3zGCHFsulYiACvBPIoZVgdR04mDKppT7OpMRLL17W7K
         y44mD9mURzAlppCbV7ZlaZsip03ezIPR7jzInW+I8OKiIK3FicdWE/81Bb/nPdUhvz99
         uQyzFnfRoBnqQaHeAFXMMzNvpjpofxQJ7tu+M7JdBoWzU9ILEOcuO6bGYgwDv9lRDXdg
         pk6WP4rJspjDaTmARKzqMGaGvzFUeD3IQKJuubUbXcfd231SeRs9qNcaicPKAKyCbMa9
         gg4w==
X-Gm-Message-State: AOAM531/HZNr1WDn7mx+FXmGNqREgnquRidvXhi15ERz1/dNbyhs8HDJ
        QiOLgK4dinHSTldwcSouEGmjkktUe2gP9rcv2vQ=
X-Google-Smtp-Source: ABdhPJznCEmFBJnX99LUG3SXw0QcRfDJTxXpKxasjBLW5NYJV2bK6sDsabfdP+ReVSTxYj7+MdirIzLK+f9itPf0jOs=
X-Received: by 2002:a9d:5c8b:: with SMTP id a11mr815179oti.206.1628101642829;
 Wed, 04 Aug 2021 11:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210803141621.780504-1-bigeasy@linutronix.de> <20210803141621.780504-30-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-30-bigeasy@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 20:27:11 +0200
Message-ID: <CAJZ5v0giKO4y=LG9vWc2h+vHt0xr2EAyhQgd6u51vryihM4msw@mail.gmail.com>
Subject: Re: [PATCH 29/38] ACPI: processor: Replace deprecated CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 3, 2021 at 4:17 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The functions cpu_hotplug_begin, cpu_hotplug_done, get_online_cpus() and
> put_online_cpus() have been deprecated during the CPU hotplug rework. They map
> directly to cpus_write_lock(), cpus_write_unlock, cpus_read_lock() and
> cpus_read_unlock().
>
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/acpi/acpi_pad.c       | 4 ++--
>  drivers/acpi/acpi_processor.c | 8 ++++----
>  drivers/acpi/processor_idle.c | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index df4adeb335b24..f45979aa2d648 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -249,12 +249,12 @@ static void set_power_saving_task_num(unsigned int num)
>
>  static void acpi_pad_idle_cpus(unsigned int num_cpus)
>  {
> -       get_online_cpus();
> +       cpus_read_lock();
>
>         num_cpus = min_t(unsigned int, num_cpus, num_online_cpus());
>         set_power_saving_task_num(num_cpus);
>
> -       put_online_cpus();
> +       cpus_read_unlock();
>  }
>
>  static uint32_t acpi_pad_idle_cpus_num(void)
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 2d5bd2a6ddcef..6737b1cbf6d69 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -182,7 +182,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>                 return -ENODEV;
>
>         cpu_maps_update_begin();
> -       cpu_hotplug_begin();
> +       cpus_write_lock();
>
>         ret = acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
>         if (ret)
> @@ -203,7 +203,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>         pr->flags.need_hotplug_init = 1;
>
>  out:
> -       cpu_hotplug_done();
> +       cpus_write_unlock();
>         cpu_maps_update_done();
>         return ret;
>  }
> @@ -454,13 +454,13 @@ static void acpi_processor_remove(struct acpi_device *device)
>         per_cpu(processors, pr->id) = NULL;
>
>         cpu_maps_update_begin();
> -       cpu_hotplug_begin();
> +       cpus_write_lock();
>
>         /* Remove the CPU. */
>         arch_unregister_cpu(pr->id);
>         acpi_unmap_cpu(pr->id);
>
> -       cpu_hotplug_done();
> +       cpus_write_unlock();
>         cpu_maps_update_done();
>
>         try_offline_node(cpu_to_node(pr->id));
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 095c8aca141eb..f37fba9e5ba0b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1301,7 +1301,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>         if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
>
>                 /* Protect against cpu-hotplug */
> -               get_online_cpus();
> +               cpus_read_lock();
>                 cpuidle_pause_and_lock();
>
>                 /* Disable all cpuidle devices */
> @@ -1330,7 +1330,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>                         }
>                 }
>                 cpuidle_resume_and_unlock();
> -               put_online_cpus();
> +               cpus_read_unlock();
>         }
>
>         return 0;
> --

Applied as 5.15 material, thanks!
