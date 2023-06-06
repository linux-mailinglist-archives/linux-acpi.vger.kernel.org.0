Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349927245D6
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbjFFOZO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 6 Jun 2023 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbjFFOY7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 10:24:59 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491D19A5
        for <linux-acpi@vger.kernel.org>; Tue,  6 Jun 2023 07:24:38 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51669dd574aso360667a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jun 2023 07:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061477; x=1688653477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TTznq6l6PIkSOkjT11ue3Dzn6+2AGRhCkXdIK0HmZk=;
        b=BoQ15eXF5k7Cs4CsS4rEL2KaTcW8vtiUoB1p0Qsf6udlyVtKxtuXRbkx2d4XmoPB6q
         EZpxQwTOmEDw3ZBczIN0KABtUzGDGtkEBLMH8KoBWEnEi6scbTMiiYC2QCnOfndhMn9R
         7pF6gDpsAKkmYJ2JpGTaizbsDxCEWgW6Rj4kA5xmLISiKtF7E0zaYP1ObY0j9yYEejlq
         a39P/vEBptObMpbUSyluJvuIYgMGjsre3ganuEts/Pyj3WF+uvKPG4ujLirbiZNtBp4y
         fKAoS0WcQnMNgV8hggyDQwe3zl4MzptkZlH8mD6IURpO9A8zaucoRzswERXsLk5lT1Po
         lcTg==
X-Gm-Message-State: AC+VfDy+bR+7XFCm6HqUqZjMzkMComH+0h/yBrn0IPjryUqbRDyDKqum
        wwnkS+0ekbJ1iGO46VtZJ3x9xDZQsvfZcDW1QV4=
X-Google-Smtp-Source: ACHHUZ5x0GnZDHZcUFi2fUhBFe4DKu0ddRez+FLig0/XBGP1KHJ7RIs4308Rsy6ttLhkTECRPFMdSiF3lnA8ai9xYVs=
X-Received: by 2002:a05:6402:254e:b0:514:971b:7f36 with SMTP id
 l14-20020a056402254e00b00514971b7f36mr2645691edb.3.1686061476461; Tue, 06 Jun
 2023 07:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <87353x87p7.fsf@jcompost-mobl.amr.corp.intel.com>
 <CAJZ5v0gCcWJHkrf1zfcSJU1Aw1ZDEVkkTnvBFOpORJ6L0ji6UQ@mail.gmail.com>
 <CAJZ5v0jina9b4Yt9prEwbemyiGY2Q4psRawkwLZ+VKYY90R2xA@mail.gmail.com> <87ilc1lf4c.fsf@jcompost-mobl.amr.corp.intel.com>
In-Reply-To: <87ilc1lf4c.fsf@jcompost-mobl.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Jun 2023 16:24:23 +0200
Message-ID: <CAJZ5v0gE+hNJiLfoEq8QWWKbseBT2AEdBCv+8G9i88cx0mfcbw@mail.gmail.com>
Subject: Re: ACPI: EC: Clear GPE on interrupt handling only
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
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

On Tue, Jun 6, 2023 at 12:27 AM Compostella, Jeremy
<jeremy.compostella@intel.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Mon, Jun 5, 2023 at 6:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Tue, May 16, 2023 at 2:02 AM Compostella, Jeremy
> >> <jeremy.compostella@intel.com> wrote:
> >> >
> >> > On multiple devices I work on, we noticed that
> >> > /sys/firmware/acpi/interrupts/sci_not is non-zero and keeps increasing
> >> > over time.
> >> >
> >> > It turns out that there is a race condition between servicing a GPE
> >> > interrupt and handling task driven transactions.
> >> >
> >> > If a GPE interrupt is received at the same time ec_poll() is running,
> >> > the advance_transaction() clears the GPE flag and the interrupt is not
> >> > serviced as acpi_ev_detect_gpe() relies on the GPE flag to call the
> >> > handler. As a result, `sci_not' is increased.
> >>
> >> And if I'm not mistaken, it is not necessary to run the entire
> >> interrupt handler in that case, because the currently running
> >> advance_transaction() will take care of the pending event anyway.
> >>
> >> I agree that it is confusing to increase sci_not in that case, but I'm
> >> not sure if running the entire advance_transaction() for the same
> >> transaction twice in a row, once from ec_poll() and once from the
> >> interrupt handler is entirely correct.
> >
> > However, if the interrupt handler wins the race, advance_transaction()
> > will run for the same transaction twice in a row anyway, so this
> > change will only make it happen more often.
> >
> > So no objections, but I would move the GPE clearing piece directly
> > into acpi_ec_handle_interrupt(), because it will only be needed there
> > and it doesn't depend on anything else in advance_transaction().
>
> I took into account your suggestion (cf. patch in attachment).

Yes, this is what I meant.

I think that you can resend it as a v2 with the same changelog.

>
> >> > Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> >> > ---
> >> >  drivers/acpi/ec.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >> > index 928899ab9502..42af09732238 100644
> >> > --- a/drivers/acpi/ec.c
> >> > +++ b/drivers/acpi/ec.c
> >> > @@ -674,7 +674,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
> >> >          * 2. As long as software can ensure only clearing it when it is set,
> >> >          *    hardware won't set it in parallel.
> >> >          */
> >> > -       if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
> >> > +       if (interrupt && ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
> >> >                 acpi_clear_gpe(NULL, ec->gpe);
> >> >
> >> >         status = acpi_ec_read_status(ec);
> >> > --
