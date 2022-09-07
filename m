Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8882B5B0E1A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Sep 2022 22:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiIGU0z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 7 Sep 2022 16:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGU0y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Sep 2022 16:26:54 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337CBFE97
        for <linux-acpi@vger.kernel.org>; Wed,  7 Sep 2022 13:26:51 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3457bc84d53so61576977b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Sep 2022 13:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yA3+StCym4idXa8cG6Malox2oj6cl9PWq+XLp6mhiGs=;
        b=JqFVOs99DpkqtuakhdUeNUQXcB9OXDib7RVtvnARaAm+RY3ggwSTx73/ipW6haBn7x
         9xD1P2NJgtmVDGkv43qeSUCoLFwq7Pvs+fgPTavavzZvTwcE/utcJbq+o87YKauWuicd
         ckvzbzpA7QVWAmSOu+Ue9RaCyJFbFoTSbLiU5MbmTuIT9jNXRbNfCXXOWlxfyFPXldm/
         fE4zApEHMpGnmhJvD7cngJqbX3Mum0OAdZgnYy/mT8CJCYR+ZDCR6OEhRb8AiMbskERB
         qyt/95ZRBdiII9d59X95ywkm6CzPGGC5V9W1LxZyNZx92w15zgJT8AXDF5iGKJny2/qF
         rekQ==
X-Gm-Message-State: ACgBeo3Axx/C3V+I/pCSOMOknfvai/n0QZt8h7NHGsFkM3LnegQB2/df
        VXLKABi/cexHmTDH0uULCBc2CgLZURDIlEr7HYE=
X-Google-Smtp-Source: AA6agR4Qcwjy4hhDaUZN9CYS4cgcnoGtDgbyxHDAX9AxFvok4eylogLM7l9HejSeNi92ig8i3NDM8kYhd3kmCzQKGwg=
X-Received: by 2002:a0d:da83:0:b0:329:9c04:fe6d with SMTP id
 c125-20020a0dda83000000b003299c04fe6dmr4668181ywe.196.1662582411022; Wed, 07
 Sep 2022 13:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <de1cf16c-54cb-316b-3fcb-2520e6bb152f@semihalf.com>
In-Reply-To: <de1cf16c-54cb-316b-3fcb-2520e6bb152f@semihalf.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Sep 2022 22:26:39 +0200
Message-ID: <CAJZ5v0hY05BzG=fL78BzyvxeJDZT+5D_ZeyCALt2+0JUDvHnew@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Wait for ACPI IRQ to be processed before disable GPE
To:     =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mm@semihalf.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 7, 2022 at 7:31 AM Marek Maślanka <mm@semihalf.com> wrote:
>
> On the wake-up, the ACPI GPE that are marked as a wakeup source are
> turned off. Before turning off, the kernel waits for the currently
> processing IRQ to finish and assumes that this is an ACPI interrupt that
> triggered wake-up. In the case the first interrupt after wake-up is not
> an ACPI interrupt, this might cause the ACPI GPE not to be processed
> because it will be disabled.
>
> The patch makes sure that an ACPI interrupt is processed before
> disabling GPE that are wakeup sources.
>
> This patch fix the issue that is seen on low-end Chromebooks with two
> cores CPU when HPET IRQ is triggered while resuming the device and is
> processed before the ACPI GPE interrupt on the same CPU core.
>
> Signed-off-by: Marek Maslanka <mm@semihalf.com>
> ---
>  drivers/acpi/internal.h |  2 ++
>  drivers/acpi/osl.c      | 18 ++++++++++++++++++
>  drivers/acpi/sleep.c    |  6 ++++++
>  include/linux/acpi.h    |  2 ++
>  4 files changed, 28 insertions(+)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 219c02df9a08..e4df1bf2963b 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -251,6 +251,8 @@ static inline bool force_storage_d3(void)
>  }
>  #endif
>
> +extern bool acpi_resume_gpe_irq_handled;
> +
>  /*--------------------------------------------------------------------------
>                                 Device properties
>    -------------------------------------------------------------------------- */
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3269a888fb7a..ea587ac4c68a 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -42,6 +42,8 @@
>  #define _COMPONENT             ACPI_OS_SERVICES
>  ACPI_MODULE_NAME("osl");
>
> +#define ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS 500

This is a relatively large number.  Doesn't anything smaller work?

> +
>  struct acpi_os_dpc {
>         acpi_osd_exec_callback function;
>         void *context;
> @@ -69,6 +71,8 @@ static struct workqueue_struct *kacpi_hotplug_wq;
>  static bool acpi_os_initialized;
>  unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
>  bool acpi_permanent_mmap = false;
> +bool acpi_resume_gpe_irq_handled;
> +static DECLARE_WAIT_QUEUE_HEAD(acpi_irq_after_suspend_wait);
>
>  /*
>   * This list of permanent mappings is for memory that may be accessed from
> @@ -549,6 +553,10 @@ static irqreturn_t acpi_irq(int irq, void *dev_id)
>         handled = (*acpi_irq_handler) (acpi_irq_context);
>
>         if (handled) {
> +               if (acpi_s2idle_wakeup()) {
> +                       acpi_resume_gpe_irq_handled = true;
> +                       wake_up(&acpi_irq_after_suspend_wait);
> +               }
>                 acpi_irq_handled++;
>                 return IRQ_HANDLED;
>         } else {
> @@ -1768,3 +1776,13 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
>                                                reg_a_value, reg_b_value);
>         return status;
>  }
> +
> +int acpi_wait_for_resume_gpe_irq(void)
> +{
> +       int wait_ms = msecs_to_jiffies(ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS);
> +       int timeout = wait_event_timeout(acpi_irq_after_suspend_wait,
> +                                        acpi_resume_gpe_irq_handled,
> +                                        wait_ms);
> +       return timeout;

So this will wait for the full timeout if there are no ACPI events to
process, right?

Isn't it a bit excessive?

Moreover, what if there is an ACPI event right after the wait has completed?

> +}
> +EXPORT_SYMBOL(acpi_wait_for_resume_gpe_irq);
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index ad4b2987b3d6..6ddf28067687 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -721,6 +721,7 @@ int acpi_s2idle_prepare(void)
>         acpi_os_wait_events_complete();
>
>         s2idle_wakeup = true;
> +       acpi_resume_gpe_irq_handled = false;
>         return 0;
>  }
>
> @@ -789,6 +790,7 @@ bool acpi_s2idle_wake(void)
>
>  void acpi_s2idle_restore(void)
>  {
> +       int timeout;
>         /*
>          * Drain pending events before restoring the working-state configuration
>          * of GPEs.
> @@ -797,6 +799,10 @@ void acpi_s2idle_restore(void)
>         acpi_ec_flush_work(); /* flush the EC driver's workqueues */
>         acpi_os_wait_events_complete(); /* synchronize Notify handling */
>
> +       timeout = acpi_wait_for_resume_gpe_irq();
> +       if (timeout == 0)
> +               pr_warn("Failed to wait for ACPI interrupt after resume");

This is perfectly fine, for example if the system is woken up by a
non-ACPI IRQ (eg. the keyboard one).

> +
>         s2idle_wakeup = false;
>
>         acpi_enable_all_runtime_gpes();
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ed4aa395cc49..ef2ab7990f1c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1475,4 +1475,6 @@ static inline void acpi_device_notify(struct device *dev) { }
>  static inline void acpi_device_notify_remove(struct device *dev) { }
>  #endif
>
> +int acpi_wait_for_resume_gpe_irq(void);
> +
>  #endif /*_LINUX_ACPI_H*/
> --

Overall, I'm not convinced about the approach.

If the goal is to process all of the ACPI wakeup interrupts, this
doesn't meet it.

AFAICS the only way to do that which is not racy is to dispatch every
wakeup GPE in-line (from the ACPICA code) before disabling it in case
it is active at that point.
