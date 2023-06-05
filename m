Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68952722C4C
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jun 2023 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjFEQPN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 5 Jun 2023 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjFEQPM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 12:15:12 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C7F7
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 09:15:07 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso108179766b.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jun 2023 09:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685981706; x=1688573706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4GbpkJ31zeUmtWNGxfALeyV6aqDXtUZF49h3ce4Yd8=;
        b=ZmOShpM1yiEVEopFMhDFfc1ViLJXK4KwTkSbXvn58w7Y89b2F2HzouftmLW4dRAi+a
         oHgAfutSiQqzX+DdU6xfWOHGRNU9QWOWRK0pJZLEb1biawHIfRL3M5n9iXKOt1a5pnwK
         sDf+I45Kr5G8BfXF/HYIz3RLAuzfF9xwkL/rfgsOXg+HcBtAWfzmSu6I8m3VCD8HO1OL
         6wzYEK/gFoOi+SpDkrsRjGvimNDHW2xHcsJW09mUoFAT5gv8klruOyz45QNJUJoIBRA4
         uVU23hAXHBDi4ferP1GbwSKL40R3RBW5hRlwd4BLSjqv3gg7jnWtZDIOHostPMsic+g3
         7ayw==
X-Gm-Message-State: AC+VfDz3XzZHQ5hSqAEh2eY5dZIQ/u7POp6i1r9Q9+uc1HUcoHAPsEgx
        ycfo8zApr7Z0MiljWSUdfn0c2qwfe2o3RtgwjWCB5kZexZ8=
X-Google-Smtp-Source: ACHHUZ5vGwAL8Rjslj4Raw3GAsdycj7d3YyhPINXvM0tP/DwQRqKOlCNnd3QCnYCF1Z9sqIMBn8Jfudtwv+ckll4ywE=
X-Received: by 2002:a17:906:15d:b0:974:5ec0:5246 with SMTP id
 29-20020a170906015d00b009745ec05246mr8111592ejh.7.1685981705781; Mon, 05 Jun
 2023 09:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <87353x87p7.fsf@jcompost-mobl.amr.corp.intel.com>
In-Reply-To: <87353x87p7.fsf@jcompost-mobl.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 18:14:54 +0200
Message-ID: <CAJZ5v0gCcWJHkrf1zfcSJU1Aw1ZDEVkkTnvBFOpORJ6L0ji6UQ@mail.gmail.com>
Subject: Re: ACPI: EC: Clear GPE on interrupt handling only
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 16, 2023 at 2:02 AM Compostella, Jeremy
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

And if I'm not mistaken, it is not necessary to run the entire
interrupt handler in that case, because the currently running
advance_transaction() will take care of the pending event anyway.

I agree that it is confusing to increase sci_not in that case, but I'm
not sure if running the entire advance_transaction() for the same
transaction twice in a row, once from ec_poll() and once from the
interrupt handler is entirely correct.

> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> ---
>  drivers/acpi/ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 928899ab9502..42af09732238 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -674,7 +674,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
>          * 2. As long as software can ensure only clearing it when it is set,
>          *    hardware won't set it in parallel.
>          */
> -       if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
> +       if (interrupt && ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
>                 acpi_clear_gpe(NULL, ec->gpe);
>
>         status = acpi_ec_read_status(ec);
> --
> 2.40.1
>
