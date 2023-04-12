Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7670F6DFD90
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Apr 2023 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDLSda convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 12 Apr 2023 14:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLSd3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2023 14:33:29 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCBB40F2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Apr 2023 11:33:27 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-50489d1af35so3303440a12.3
        for <linux-acpi@vger.kernel.org>; Wed, 12 Apr 2023 11:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324406; x=1683916406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cglFzpDVhbUiJmyQaISYZpkYpWV7axhuwy9XuPgyKI=;
        b=TBdME8odUaMKsbFrO7fxYBOSQ2D1qlyuOZ+lk8UffPVCWKsl8YS0gcrny/cr2FlmyY
         qYrGGsXEK2jgSc2TuUuedQ7OW0qUzmEearaXLjXeD8+7hYf3rKbzBa5wCUW9MexpUHj6
         ITbZBMwYFZY9PL6HBwna53XLVlIPFDvs8GkI+usIiwlLOXKrKOg7kn7d15iIb+UtT6pR
         iQSzoSqZALRI+crCtd9lUJzT2HC9Iw6iNr3XMWc0KdnaNqVuzbJlOdJDawR7RjbBk/10
         jwk8igbbPZ2OJjxpNFO1zvP+EJvwkUHkB+JHLFdIL/4MzZwmLxBepRbnWnsRQNUp2y14
         k8xA==
X-Gm-Message-State: AAQBX9c1Gn1nabWRBON/on8EaTS2xI5DHW0vyC2dDBMWxPrLUgB+Ne+l
        EH5H8X0AvXEpOg8+BpfKezcUr+kqlmyEeUX9CL4=
X-Google-Smtp-Source: AKy350ZpvHbcv5ohuiFCSYX+oqgPaH0oeVxw+s/qEZZ+saSxDiO6nsrXg11LwTXz0bBJsZxYUnYIoQNZ9t/i0uG0b9w=
X-Received: by 2002:a50:a41c:0:b0:504:898b:e482 with SMTP id
 u28-20020a50a41c000000b00504898be482mr3507927edb.3.1681324406248; Wed, 12 Apr
 2023 11:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221220154447.12341-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0inEMEQ1NJwjNboDokL_35-yG8o6QwVb5po2qKW8LRLWA@mail.gmail.com>
 <20221221182138.aqupmjom5kixvvsu@pengutronix.de> <20230412145517.6vozcdkhcg6xd5xh@pengutronix.de>
In-Reply-To: <20230412145517.6vozcdkhcg6xd5xh@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Apr 2023 20:33:15 +0200
Message-ID: <CAJZ5v0hswyNQoY9GPuPaj61a3xHbNE+Xhd+7K-JekKRzTPDbfQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: arm_sdei: Make sdei_unregister_ghes() return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>
Cc:     linux-acpi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 12, 2023 at 4:55 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Rafael,
>
> On Wed, Dec 21, 2022 at 07:21:38PM +0100, Uwe Kleine-König wrote:
> > On Wed, Dec 21, 2022 at 02:53:05PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 20, 2022 at 4:45 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > [...]
> > > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > > index 066dc1f5c235..7d705930e21b 100644
> > > > --- a/drivers/acpi/apei/ghes.c
> > > > +++ b/drivers/acpi/apei/ghes.c
> > > > @@ -1275,12 +1275,20 @@ static int apei_sdei_register_ghes(struct ghes *ghes)
> > > >                                  ghes_sdei_critical_callback);
> > > >  }
> > > >
> > > > -static int apei_sdei_unregister_ghes(struct ghes *ghes)
> > > > +static void apei_sdei_unregister_ghes(struct ghes *ghes)
> > > >  {
> > > > +       /*
> > > > +        * If CONFIG_ARM_SDE_INTERFACE isn't enabled apei_sdei_register_ghes()
> > > > +        * cannot have been called successfully. So ghes_remove() won't be
> > > > +        * called because either ghes_probe() failed or the notify type isn't
> > > > +        * ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED.
> > > > +        * Note the if statement below is necessary to prevent a linker error as
> > > > +        * the compiler has no chance to understand the above correlation.
> > > > +        */
> > > >         if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
> > > > -               return -EOPNOTSUPP;
> > > > +               BUG();
> > >
> > > Well, you could just provide an empty stub for the !CONFIG_ARM_SDE_INTERFACE.
> > >
> > > It would be cleaner and probably fewer lines of code too.
> >
> > It's you who cares for this code, but I'd prefer my option. If we assume
> > the describing comment would have a similar length, we're saving 3 or
> > four lines of code here but need 3 lines for the #if / #else / #endif
> > plus the stub definition. And compared to my suggested solution we don't
> > catch someone introducing a (bogus) call to apei_sdei_unregister_ghes()
> > (or sdei_unregister_ghes()). And (again IMHO) two different
> > implementations are harder to grasp than a single with an if.
> >
> > If you don't like the BUG, a plain return is in my eyes the next best
> > option which is semantically equivalent to an empty stub.
> >
> > If you still like the stub better (or a return instead of the BUG), I
> > can send a v3, just tell me your preference.
>
> I work on changes that depend on a solution here. However you didn't
> tell me your preference here. I'm unsure if this means that this
> discussion fell through the cracks, or if it annoys you and you still
> prefer the cpp #ifdef solution. A note from your side would be very
> welcome.

Well, every time I see BUG() in the code I wonder if crashing the
kernel really is the best thing one can do should the execution reach
that point.

In any case, it's not my opinion that matters the most regarding
APEI/GHES, so I would like Tony/Boris/James to speak up here.
