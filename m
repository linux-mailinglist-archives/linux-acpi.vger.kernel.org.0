Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB00722C74
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jun 2023 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFEQ1A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 5 Jun 2023 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFEQ07 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 12:26:59 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BB9E9
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 09:26:57 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-977c8baa86fso65550566b.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jun 2023 09:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685982416; x=1688574416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrqlshbiBifqSPafbZHS78SHmxs0wVmYxbKQkDA7zp8=;
        b=NFwGlr42Tdt9cVvlc1mVnr4G+k7ENx61IxXGoGs7nOJfo/Q0rXqJs2f4k5mtvH4ILi
         y6mo5ZqT9ZjdNzhLdJKMLYRa8JO0KWsRA2I/OSt1OE4omqdggCkLAI1TCVVr5j166ehS
         /ZmDHOBY9IFtPe5eoPjaK1QTxf02XPCNZ4lef2CDu930URoYthXpinW/t0lp293BGZCk
         ELRVNA/WShJD5KJ1sB/bc0c/4j/541feAl9GXXjjiCNBDc4TUFBOYOLvW37s1P/NKKVW
         dsOwyWHZ4UnST0yzmrlBBkhwdHiAUYQv/Ks8+1JKn3K8z8LLVVdLLax1IHoK40HlKM+K
         c1Lw==
X-Gm-Message-State: AC+VfDy0ZOBleHVZr7XFsZpoIUPz2PJQAX/19QnfCroiWYQPHlSV+cSz
        qOFULF5gPGMEihb/iuDtRwtMJ3A8jHFShV9GujQ=
X-Google-Smtp-Source: ACHHUZ5kvaGzOoQLjF4m64vrG4odrD05WEWVa+JSW9VdYH3/krvT1K5DVR3SicOLiTuuSxkZMlaKSpiflcGM1nyYSxc=
X-Received: by 2002:a17:906:77c6:b0:977:cc87:62b5 with SMTP id
 m6-20020a17090677c600b00977cc8762b5mr4624195ejn.4.1685982416218; Mon, 05 Jun
 2023 09:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <87353x87p7.fsf@jcompost-mobl.amr.corp.intel.com> <CAJZ5v0gCcWJHkrf1zfcSJU1Aw1ZDEVkkTnvBFOpORJ6L0ji6UQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gCcWJHkrf1zfcSJU1Aw1ZDEVkkTnvBFOpORJ6L0ji6UQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 18:26:45 +0200
Message-ID: <CAJZ5v0jina9b4Yt9prEwbemyiGY2Q4psRawkwLZ+VKYY90R2xA@mail.gmail.com>
Subject: Re: ACPI: EC: Clear GPE on interrupt handling only
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        linux-acpi@vger.kernel.org
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

On Mon, Jun 5, 2023 at 6:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, May 16, 2023 at 2:02 AM Compostella, Jeremy
> <jeremy.compostella@intel.com> wrote:
> >
> > On multiple devices I work on, we noticed that
> > /sys/firmware/acpi/interrupts/sci_not is non-zero and keeps increasing
> > over time.
> >
> > It turns out that there is a race condition between servicing a GPE
> > interrupt and handling task driven transactions.
> >
> > If a GPE interrupt is received at the same time ec_poll() is running,
> > the advance_transaction() clears the GPE flag and the interrupt is not
> > serviced as acpi_ev_detect_gpe() relies on the GPE flag to call the
> > handler. As a result, `sci_not' is increased.
>
> And if I'm not mistaken, it is not necessary to run the entire
> interrupt handler in that case, because the currently running
> advance_transaction() will take care of the pending event anyway.
>
> I agree that it is confusing to increase sci_not in that case, but I'm
> not sure if running the entire advance_transaction() for the same
> transaction twice in a row, once from ec_poll() and once from the
> interrupt handler is entirely correct.

However, if the interrupt handler wins the race, advance_transaction()
will run for the same transaction twice in a row anyway, so this
change will only make it happen more often.

So no objections, but I would move the GPE clearing piece directly
into acpi_ec_handle_interrupt(), because it will only be needed there
and it doesn't depend on anything else in advance_transaction().

> > Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> > ---
> >  drivers/acpi/ec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index 928899ab9502..42af09732238 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -674,7 +674,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
> >          * 2. As long as software can ensure only clearing it when it is set,
> >          *    hardware won't set it in parallel.
> >          */
> > -       if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
> > +       if (interrupt && ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
> >                 acpi_clear_gpe(NULL, ec->gpe);
> >
> >         status = acpi_ec_read_status(ec);
> > --
