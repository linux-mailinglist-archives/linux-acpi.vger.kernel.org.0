Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD42C0C10
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 14:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgKWNm3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 08:42:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46856 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbgKWNm3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 08:42:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id q206so19643988oif.13
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2020 05:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsN0TIQ/d/NomnxZap/34lN2XKe3BFfylfeTvT8NqDc=;
        b=F5hRozrKC51jqlWp7nCxi7xGrjWtnLn3LPiLTa7MgbA6mg8MSr6IhFiXCKPDPqWUq/
         u/+c1I5+jrNhCESmoydlGUDcpyHbki41f7WHbcf4rP4UFMNDlJ+2Wwr1LxDYlJCg7G7w
         6ufJhpb68ChoZ2xI+Y+tYZV71NAW1XCe2qczYWrOB7io6T5bciAX/5G+bnsyKB84ZhJU
         Iom+dr4d42VXCmC4M2p4UGJ5ZIJ4bhbRqe1UZ/Fb0wisKLYpnESnZDHl5Rb8WocumFPN
         AKKf8L3WgAEh5PB/9TMoEwsy2JoNP5ZSEqfcBN+n5NUQk3NkDwElQs/uazFjwItPLswp
         ZcKQ==
X-Gm-Message-State: AOAM53109+wgOsx2xfhsFMGBCLojTQKHH2ZoCmTUiHQI38Ce/yrLVqA9
        QonznTHbjWJAYRwenmoQuUA0lSQDv73XrVm1lPU=
X-Google-Smtp-Source: ABdhPJxrRA1NnZDnBs8i7C2g6c0dZAshwRwlmHpYr9Y9UIDZI+hPLcEN++jcngZqsj3jkpswKL2i6jQk8MrrU3bfbBI=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr14506673oib.69.1606138947608;
 Mon, 23 Nov 2020 05:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20201113181317.2227833-1-bigeasy@linutronix.de>
In-Reply-To: <20201113181317.2227833-1-bigeasy@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 13:42:10 +0100
Message-ID: <CAJZ5v0hLVk0cZsj8jpSodMG1Dw9rBBD_Q9vyzV-kj3N6b8JGGA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Replace in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 13, 2020 at 7:13 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> advance_transaction() is using in_interrupt() to distinguish between an
> invocation from the interrupt handler and an invocation from another
> part of the stack.
>
> This looks misleading because chains like
>   acpi_update_all_gpes() -> acpi_ev_gpe_detect() ->
>   acpi_ev_detect_gpe() -> acpi_ec_gpe_handler()
>
> should probably also behave as if they were called from an interrupt
> handler.
>
> Replace in_interrupt() usage with a function parameter. Set this
> parameter to `true' if invoked from an interrupt handler
> (acpi_ec_gpe_handler() and acpi_ec_irq_handler()) and `false' otherwise.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/acpi/ec.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e0cb1bcfffb29..0caf5ca1fc076 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -169,7 +169,7 @@ struct acpi_ec_query {
>  };
>
>  static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
> -static void advance_transaction(struct acpi_ec *ec);
> +static void advance_transaction(struct acpi_ec *ec, bool interrupt);
>  static void acpi_ec_event_handler(struct work_struct *work);
>  static void acpi_ec_event_processor(struct work_struct *work);
>
> @@ -358,7 +358,7 @@ static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
>                  * EN=1 writes.
>                  */
>                 ec_dbg_raw("Polling quirk");
> -               advance_transaction(ec);
> +               advance_transaction(ec, false);
>         }
>  }
>
> @@ -488,7 +488,7 @@ static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
>          * Unconditionally invoke this once after enabling the event
>          * handling mechanism to detect the pending events.
>          */
> -       advance_transaction(ec);
> +       advance_transaction(ec, false);
>  }
>
>  static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
> @@ -632,14 +632,13 @@ static inline void ec_transaction_transition(struct acpi_ec *ec, unsigned long f
>         }
>  }
>
> -static void advance_transaction(struct acpi_ec *ec)
> +static void advance_transaction(struct acpi_ec *ec, bool interrupt)
>  {
>         struct transaction *t;
>         u8 status;
>         bool wakeup = false;
>
> -       ec_dbg_stm("%s (%d)", in_interrupt() ? "IRQ" : "TASK",
> -                  smp_processor_id());
> +       ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
>         /*
>          * By always clearing STS before handling all indications, we can
>          * ensure a hardware STS 0->1 change after this clearing can always
> @@ -699,7 +698,7 @@ static void advance_transaction(struct acpi_ec *ec)
>          * otherwise will take a not handled IRQ as a false one.
>          */
>         if (!(status & ACPI_EC_FLAG_SCI)) {
> -               if (in_interrupt() && t) {
> +               if (interrupt && t) {
>                         if (t->irq_count < ec_storm_threshold)
>                                 ++t->irq_count;
>                         /* Allow triggering on 0 threshold */
> @@ -710,7 +709,7 @@ static void advance_transaction(struct acpi_ec *ec)
>  out:
>         if (status & ACPI_EC_FLAG_SCI)
>                 acpi_ec_submit_query(ec);
> -       if (wakeup && in_interrupt())
> +       if (wakeup && interrupt)
>                 wake_up(&ec->wait);
>  }
>
> @@ -767,7 +766,7 @@ static int ec_poll(struct acpi_ec *ec)
>                         if (!ec_guard(ec))
>                                 return 0;
>                         spin_lock_irqsave(&ec->lock, flags);
> -                       advance_transaction(ec);
> +                       advance_transaction(ec, false);
>                         spin_unlock_irqrestore(&ec->lock, flags);
>                 } while (time_before(jiffies, delay));
>                 pr_debug("controller reset, restart transaction\n");
> @@ -1216,7 +1215,7 @@ static void acpi_ec_check_event(struct acpi_ec *ec)
>                          * taking care of it.
>                          */
>                         if (!ec->curr)
> -                               advance_transaction(ec);
> +                               advance_transaction(ec, false);
>                         spin_unlock_irqrestore(&ec->lock, flags);
>                 }
>         }
> @@ -1259,7 +1258,7 @@ static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
>         unsigned long flags;
>
>         spin_lock_irqsave(&ec->lock, flags);
> -       advance_transaction(ec);
> +       advance_transaction(ec, true);
>         spin_unlock_irqrestore(&ec->lock, flags);
>  }
>
> --

Applied (with minor edits in the subject) as 5.11 material, thanks!
