Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EAF5070F7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Apr 2022 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352005AbiDSOvU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Apr 2022 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351904AbiDSOvT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2022 10:51:19 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB9F2B1B9
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 07:48:37 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id x39so1974734ybd.8
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 07:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGHFgEba/Avhd41SWbwY+/EsHiQJdReeJ5eB+OFN+qc=;
        b=ygzqL1IBUv70cSE50JGuOxWIRazsRxSs1bkjBNVRuhxNkRVQME5bdhmNoIu+EJeDC3
         qGMKADF+PtGLnyNwTolD+0HxhfPFDsfQfx3SGnux1ynXfXNN3+taUy27oIBJj54v31qB
         TMIuw0baXGIv8WvayxTuluMtFTCNtg8B7pR3B5o8orxn86tUBUrA7CUBS4fqQIdczPQv
         TgkqH7uDpd5wQI8OSQLbLlF2osH4XD06uTSw7PBrWHArNa8ZFWnC1vYkUBcM8rYqgdeh
         9U01rUkzbC6Lbya26P4c78IIlDZQ1beFtdrmllDZhlbtKkmp3t1dolO8fNk0GLgZdAnU
         w/aA==
X-Gm-Message-State: AOAM531REMqLQWmixic2dayPOvfeH9JPOvHQGwGwFEFKqUmAXuDie25U
        am/QdurgXkW2oKLvyRrtFM+TfKtktMwb7BJMUuFafFeY
X-Google-Smtp-Source: ABdhPJw/Ez3Jwad0QFiGusd+pbSuuu81ppzIZX+dBCUVfDmiB4nMxjaDbm9XLVQuqb/NXwOa7m2RWcP0yzXtIapIcP0=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr14933203ybh.81.1650379716538; Tue, 19
 Apr 2022 07:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <892bb009-4ba8-15fa-c8f9-eb66ab75b2f0@I-love.SAKURA.ne.jp>
In-Reply-To: <892bb009-4ba8-15fa-c8f9-eb66ab75b2f0@I-love.SAKURA.ne.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 16:48:19 +0200
Message-ID: <CAJZ5v0h1K4g8VKV2n_WUeV2RYovcFHRM1BVZY3Wu0TcXUaQVWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Avoid flush_scheduled_work() usage
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 19, 2022 at 3:57 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_wq with local acpi_wq.
>
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This patch blindly converts schedule_{,rcu_}work() into queue_{,rcu_}work()
> within drivers/acpi/ directory, based on an assumption that none of work items
> outside of drivers/acpi/ directory needs to be handled by acpi_wq.
> Also, I kept sharing acpi_wq between acpi/ and acpi/apei, based on assumption
> that sharing is safe and correct behavior. Did I convert correctly?

Please don't do it this way.

There is not much sense in sharing a dedicated workqueue between the
different pieces of code below.

I guess that there is a need to switch over to dedicated workqueues in
all cases when the workqueue needs to be flushed directly.  If so,
please let me look at what can be done.

>
>  drivers/acpi/acpi_video.c         | 2 +-
>  drivers/acpi/apei/apei-internal.h | 1 +
>  drivers/acpi/apei/ghes.c          | 2 +-
>  drivers/acpi/bus.c                | 2 +-
>  drivers/acpi/internal.h           | 1 +
>  drivers/acpi/osl.c                | 6 +++++-
>  drivers/acpi/scan.c               | 2 +-
>  drivers/acpi/video_detect.c       | 2 +-
>  8 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 990ff5b0aeb8..18a5b8dd766e 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1637,7 +1637,7 @@ static void brightness_switch_event(struct acpi_video_device *video_device,
>                 return;
>
>         video_device->switch_brightness_event = event;
> -       schedule_delayed_work(&video_device->switch_brightness_work, HZ / 10);
> +       queue_delayed_work(acpi_wq, &video_device->switch_brightness_work, HZ / 10);
>  }
>
>  static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 1d6ef9654725..205dcacf8abf 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -136,4 +136,5 @@ int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
>  int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
>
>  int apei_osc_setup(void);
> +extern struct workqueue_struct *acpi_wq;
>  #endif
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d91ad378c00d..871b5f6c2b45 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -619,7 +619,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>         entry->error_severity = sev;
>
>         INIT_WORK(&entry->work, ghes_vendor_record_work_func);
> -       schedule_work(&entry->work);
> +       queue_work(acpi_wq, &entry->work);
>  }
>
>  static bool ghes_do_proc(struct ghes *ghes,
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index e807bffc0804..7dae7f884187 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -608,7 +608,7 @@ static void acpi_sb_notify(acpi_handle handle, u32 event, void *data)
>
>         if (event == ACPI_SB_NOTIFY_SHUTDOWN_REQUEST) {
>                 if (!work_busy(&acpi_sb_work))
> -                       schedule_work(&acpi_sb_work);
> +                       queue_work(acpi_wq, &acpi_sb_work);
>         } else
>                 pr_warn("event %x is not supported by \\_SB device\n", event);
>  }
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 628bf8f18130..5f77c7c573a6 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -77,6 +77,7 @@ void acpi_lpss_init(void);
>  #else
>  static inline void acpi_lpss_init(void) {}
>  #endif
> +extern struct workqueue_struct *acpi_wq;
>
>  void acpi_apd_init(void);
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 7a70c4bfc23c..1725125890cd 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -64,6 +64,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
>
>  static acpi_osd_handler acpi_irq_handler;
>  static void *acpi_irq_context;
> +struct workqueue_struct *acpi_wq;
>  static struct workqueue_struct *kacpid_wq;
>  static struct workqueue_struct *kacpi_notify_wq;
>  static struct workqueue_struct *kacpi_hotplug_wq;
> @@ -1575,7 +1576,7 @@ acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
>          */
>         synchronize_rcu();
>         rcu_barrier();
> -       flush_scheduled_work();
> +       flush_workqueue(acpi_wq);
>
>         return AE_OK;
>  }
> @@ -1755,9 +1756,11 @@ acpi_status __init acpi_os_initialize(void)
>
>  acpi_status __init acpi_os_initialize1(void)
>  {
> +       acpi_wq = alloc_workqueue("acpi", 0, 0);
>         kacpid_wq = alloc_workqueue("kacpid", 0, 1);
>         kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 1);
>         kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);
> +       BUG_ON(!acpi_wq);
>         BUG_ON(!kacpid_wq);
>         BUG_ON(!kacpi_notify_wq);
>         BUG_ON(!kacpi_hotplug_wq);
> @@ -1786,6 +1789,7 @@ acpi_status acpi_os_terminate(void)
>         destroy_workqueue(kacpid_wq);
>         destroy_workqueue(kacpi_notify_wq);
>         destroy_workqueue(kacpi_hotplug_wq);
> +       destroy_workqueue(acpi_wq);
>
>         return AE_OK;
>  }
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 762b61f67e6c..f16aaec445f2 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2676,7 +2676,7 @@ void acpi_scan_table_notify(void)
>                 return;
>
>         INIT_WORK(work, acpi_table_events_fn);
> -       schedule_work(work);
> +       queue_work(acpi_wq, work);
>  }
>
>  int acpi_reconfig_notifier_register(struct notifier_block *nb)
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index becc198e4c22..441664275645 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -529,7 +529,7 @@ static int acpi_video_backlight_notify(struct notifier_block *nb,
>         /* A raw bl registering may change video -> native */
>         if (backlight->props.type == BACKLIGHT_RAW &&
>             val == BACKLIGHT_REGISTERED)
> -               schedule_work(&backlight_notify_work);
> +               queue_work(acpi_wq, &backlight_notify_work);
>
>         return NOTIFY_OK;
>  }
> --
> 2.32.0
>
