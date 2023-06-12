Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BDB72CC50
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jun 2023 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjFLRWR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 12 Jun 2023 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjFLRWQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2023 13:22:16 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B25B2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jun 2023 10:22:10 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-97ea801b0d0so49202666b.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jun 2023 10:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590529; x=1689182529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7WVFzKIqQEcAcQmSETj8pHhIEToE2gftqc2j5ZT0WM=;
        b=U+aEVGe++4qKDsMooE9bE0/0QaDNy1y381Y0cZMR3Ow9gVhsjErMkP4MLA8ufsgU6u
         DB3mA62WKnB3KaMsjL3CQk+rZQwUbdlFVJ7v4oTvlOzda7mndRmUV2geeFPt2oH3u457
         tEXvImsOo9spg24ZX1XF98U/HUU6PN6U4+3ZOY4BqN7Qkt6/BfcpIUngQEhgUXyFws8C
         zyvFxEbxwv1fxpS5j47zGbYAeiLmDwTu7p5qfUcMwd8t0q4U75CsY0Mw4gjVATx9bEz5
         ZyCVvTIWt3aD63G5lDT9gvwqaB8VoG2aEw//tHf5FZm8XxQ8u/Z0HH3a1Ky2/2Cef8Mv
         NPOg==
X-Gm-Message-State: AC+VfDxZ2+/B8a8/pR2Zt1aHIPPCa3Tipqvjf7KgFKBIL7PyREBCVgKr
        W6hQ2XVzm/P398sXHUdOL3XBqm2LMETd1fnx4Vu8Zz1Y
X-Google-Smtp-Source: ACHHUZ6zp5ZvgfscpOf19hYeuwE4fum+QlWzrVw27faZddgpcwHbGLnMX04R6LLYQW7y+FCinEQxNqWGq7cAaepLoCs=
X-Received: by 2002:a17:906:6485:b0:974:5ec0:5246 with SMTP id
 e5-20020a170906648500b009745ec05246mr7084528ejm.7.1686590528993; Mon, 12 Jun
 2023 10:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <875y80lgbg.fsf@jcompost-mobl.amr.corp.intel.com>
In-Reply-To: <875y80lgbg.fsf@jcompost-mobl.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:21:57 +0200
Message-ID: <CAJZ5v0herXf=1n9nd_edd23bX9VgikK6OOs6t662xd_a0LTSvA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: EC: Clear GPE on interrupt handling only
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc:     linux-acpi@vger.kernel.org
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

On Tue, Jun 6, 2023 at 6:17 PM Compostella, Jeremy
<jeremy.compostella@intel.com> wrote:
>
> On multiple devices I work on, we noticed that
> /sys/firmware/acpi/interrupts/sci_not is non-zero and keeps increasing
> over time.
>
> It turns out that there is a race condition between servicing a GPE
> interrupt and handling task driven transactions.
>
> If a GPE interrupt is received at the same time ec_poll() is running,
> the advance_transaction() clears the GPE flag and the interrupt is not
> serviced as acpi_ev_detect_gpe() relies on the GPE flag to call the
> handler. As a result, `sci_not' is increased.
>
> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> ---
>  drivers/acpi/ec.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 928899ab9502..8569f55e55b6 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -662,21 +662,6 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
>
>         ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
>
> -       /*
> -        * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
> -        * changes to always trigger a GPE interrupt.
> -        *
> -        * GPE STS is a W1C register, which means:
> -        *
> -        * 1. Software can clear it without worrying about clearing the other
> -        *    GPEs' STS bits when the hardware sets them in parallel.
> -        *
> -        * 2. As long as software can ensure only clearing it when it is set,
> -        *    hardware won't set it in parallel.
> -        */
> -       if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
> -               acpi_clear_gpe(NULL, ec->gpe);
> -
>         status = acpi_ec_read_status(ec);
>
>         /*
> @@ -1287,6 +1272,22 @@ static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
>         unsigned long flags;
>
>         spin_lock_irqsave(&ec->lock, flags);
> +
> +       /*
> +        * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
> +        * changes to always trigger a GPE interrupt.
> +        *
> +        * GPE STS is a W1C register, which means:
> +        *
> +        * 1. Software can clear it without worrying about clearing the other
> +        *    GPEs' STS bits when the hardware sets them in parallel.
> +        *
> +        * 2. As long as software can ensure only clearing it when it is set,
> +        *    hardware won't set it in parallel.
> +        */
> +       if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
> +               acpi_clear_gpe(NULL, ec->gpe);
> +
>         advance_transaction(ec, true);
>         spin_unlock_irqrestore(&ec->lock, flags);
>  }
> --

Applied as 6.5 material, thanks!
