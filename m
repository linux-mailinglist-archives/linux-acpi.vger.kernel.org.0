Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195FD26A9B9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgIOQ1b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 12:27:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35379 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgIOQ1E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 12:27:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id w16so4575291oia.2;
        Tue, 15 Sep 2020 09:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HH4K2Ik+9z0TLk55NCkKu0S9yy4lgkJGUwLdhLpq5Hc=;
        b=iTEXLqnXeagXjxAnXSMcAcbfnrTW6Cp+h++5LIUSkc+9hUiXhchoLnumuj4Wu8NaES
         kt7RIyFB2cn+YJoEG4nJz1xgspSUuluf+lE6xJ1V30KdJS7UqHcw6EN+0cIMdNkfYBkg
         9RGD1uZsmYwP9BX5QT/A5EgKOH12FvDUxcuDCjN+x8bsTPNfhgsBrbBFLolL8F6Gbrc2
         lX+oHY8pVa6DkYYdieu3qroWwMypK/1G3JKO6DB5BaW8cyKs2Haz1A73AUfNogr8uQTf
         2kltuCe2RWErB5Y7XdHmiNoLkzYd+Vl9C46riN+IwCt7eygspoHCDRRiGTzzazVYjCoi
         uhDA==
X-Gm-Message-State: AOAM5322ZqWr8ztgEtl/vyR19Weer1maUOUVwLaqughb4y9fVsImfM21
        tToUugLZN57FVYZPIbpfISiOnUYef/8Ar7ldTUTyRf4q
X-Google-Smtp-Source: ABdhPJzMjp9df4Vl73h4WCdFgKfKnk5Gc1r5xBP7urKG2Puv8ljR7Uo5eQmaN0+kpLziIzsMIxCyDJcZ4U1iW0jvYo8=
X-Received: by 2002:aca:fd95:: with SMTP id b143mr170257oii.68.1600187223051;
 Tue, 15 Sep 2020 09:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200915103157.345404192@infradead.org> <20200915103806.280265587@infradead.org>
In-Reply-To: <20200915103806.280265587@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Sep 2020 18:26:52 +0200
Message-ID: <CAJZ5v0jD-Lv5WAKHd9KN8sPozN4DeA-sQ4pXZTHNSZ4XS=as3A@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 12:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Make acpi_processor_idle use the common broadcast code, there's no
> reason not to. This also removes some RCU usage after
> rcu_idle_enter().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The whole series looks good to me, so please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all of the four patches.

Alternatively, please let me know if you want me to take the patches.

> ---
>  drivers/acpi/processor_idle.c |   49 +++++++++++++-----------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
>
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -161,18 +161,10 @@ static void lapic_timer_propagate_broadc
>  }
>
>  /* Power(C) State timer broadcast control */
> -static void lapic_timer_state_broadcast(struct acpi_processor *pr,
> -                                      struct acpi_processor_cx *cx,
> -                                      int broadcast)
> -{
> -       int state = cx - pr->power.states;
> -
> -       if (state >= pr->power.timer_broadcast_on_state) {
> -               if (broadcast)
> -                       tick_broadcast_enter();
> -               else
> -                       tick_broadcast_exit();
> -       }
> +static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
> +                                       struct acpi_processor_cx *cx)
> +{
> +       return cx - pr->power.states >= pr->power.timer_broadcast_on_state;
>  }
>
>  #else
> @@ -180,9 +172,9 @@ static void lapic_timer_state_broadcast(
>  static void lapic_timer_check_state(int state, struct acpi_processor *pr,
>                                    struct acpi_processor_cx *cstate) { }
>  static void lapic_timer_propagate_broadcast(struct acpi_processor *pr) { }
> -static void lapic_timer_state_broadcast(struct acpi_processor *pr,
> -                                      struct acpi_processor_cx *cx,
> -                                      int broadcast)
> +
> +static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
> +                                       struct acpi_processor_cx *cx)
>  {
>  }
>
> @@ -568,21 +560,13 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
>   * acpi_idle_enter_bm - enters C3 with proper BM handling
>   * @pr: Target processor
>   * @cx: Target state context
> - * @timer_bc: Whether or not to change timer mode to broadcast
>   */
>  static void acpi_idle_enter_bm(struct acpi_processor *pr,
> -                              struct acpi_processor_cx *cx, bool timer_bc)
> +                              struct acpi_processor_cx *cx)
>  {
>         acpi_unlazy_tlb(smp_processor_id());
>
>         /*
> -        * Must be done before busmaster disable as we might need to
> -        * access HPET !
> -        */
> -       if (timer_bc)
> -               lapic_timer_state_broadcast(pr, cx, 1);
> -
> -       /*
>          * disable bus master
>          * bm_check implies we need ARB_DIS
>          * bm_control implies whether we can do ARB_DIS
> @@ -609,9 +593,6 @@ static void acpi_idle_enter_bm(struct ac
>                 c3_cpu_count--;
>                 raw_spin_unlock(&c3_lock);
>         }
> -
> -       if (timer_bc)
> -               lapic_timer_state_broadcast(pr, cx, 0);
>  }
>
>  static int acpi_idle_enter(struct cpuidle_device *dev,
> @@ -630,7 +611,7 @@ static int acpi_idle_enter(struct cpuidl
>                         cx = per_cpu(acpi_cstate[index], dev->cpu);
>                 } else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
>                         if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
> -                               acpi_idle_enter_bm(pr, cx, true);
> +                               acpi_idle_enter_bm(pr, cx);
>                                 return index;
>                         } else if (drv->safe_state_index >= 0) {
>                                 index = drv->safe_state_index;
> @@ -642,15 +623,11 @@ static int acpi_idle_enter(struct cpuidl
>                 }
>         }
>
> -       lapic_timer_state_broadcast(pr, cx, 1);
> -
>         if (cx->type == ACPI_STATE_C3)
>                 ACPI_FLUSH_CPU_CACHE();
>
>         acpi_idle_do_entry(cx);
>
> -       lapic_timer_state_broadcast(pr, cx, 0);
> -
>         return index;
>  }
>
> @@ -666,7 +643,7 @@ static int acpi_idle_enter_s2idle(struct
>                         return 0;
>
>                 if (pr->flags.bm_check) {
> -                       acpi_idle_enter_bm(pr, cx, false);
> +                       acpi_idle_enter_bm(pr, cx);
>                         return 0;
>                 } else {
>                         ACPI_FLUSH_CPU_CACHE();
> @@ -682,6 +659,7 @@ static int acpi_processor_setup_cpuidle_
>  {
>         int i, count = ACPI_IDLE_STATE_START;
>         struct acpi_processor_cx *cx;
> +       struct cpuidle_state *state;
>
>         if (max_cstate == 0)
>                 max_cstate = 1;
> @@ -694,6 +672,11 @@ static int acpi_processor_setup_cpuidle_
>
>                 per_cpu(acpi_cstate[count], dev->cpu) = cx;
>
> +               if (lapic_timer_needs_broadcast(pr, cx)) {
> +                       state = &acpi_idle_driver.states[count];
> +                       state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +               }
> +
>                 count++;
>                 if (count == CPUIDLE_STATE_MAX)
>                         break;
>
>
