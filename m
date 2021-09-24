Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33A417848
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbhIXQPP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 12:15:15 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34635 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347280AbhIXQPO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 12:15:14 -0400
Received: by mail-ot1-f42.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so8112528otb.1;
        Fri, 24 Sep 2021 09:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZC1EsaX6wL9yAIaslJ+DDFzcPPT/Y6p1NPh5ojVAeNQ=;
        b=jbiAyrW2gdcd6B7LThjfje/H/jPuaLEcVBln34uxnnBI8Cbn+v7cZTnTQhjmh86ifT
         iYHZcHCw1N/jtAegV2liq7Ot/Gzo5vaHPf3kyxQmHxLkXs7qRh3LSCtT62/hZY/xXwgT
         cCIkURK4SLpCJFUgDi8wkXZRD2G1YRM9xaysKxfsYXQPfWScsUTt8dFDhy+cxtEH2FOD
         TN50ruyBtVuyUwhBqfOLGEevvyT525usSP7VnVSheh9WoGlc4z/eGvtuUu+9xd4xuuDj
         rHtEpasVwn7odWX5M8NxmnRKTo/DIuLfBTLd33Fvf5jLY5j4Op0w6t4wMdPYh5vwh1+u
         T0kA==
X-Gm-Message-State: AOAM532V/qBwij4/+2y3fo4La3voL2coloall/SEy5RFltzcUF070SJ+
        +HCzosaEUiCUcc+LxOKdh44pVoPpVuvFKqEo4Fs=
X-Google-Smtp-Source: ABdhPJyDmk32YSUnR4jaxOpngtEpUVlNAQbbQN6VQfqSURZRXjSvfaW8NMxlUVFCefrC+4cm6RdlM+vRJJSgqXQipr0=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr4892011otu.86.1632500021144;
 Fri, 24 Sep 2021 09:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
 <20210916170054.136790-2-krzysztof.kozlowski@canonical.com>
 <f78523c5-df88-a768-3b9a-d542bbd73a1c@redhat.com> <CAJZ5v0gBZUrvX+w2oz-tmvDrHz_tFvzyzVGe4iz2wc3-V_9qPg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBZUrvX+w2oz-tmvDrHz_tFvzyzVGe4iz2wc3-V_9qPg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 18:13:30 +0200
Message-ID: <CAJZ5v0j03SLpmJhX1jBHcsrVyt+kecmfE8n8-1quCVZBN+4RvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] acpi: pnp: remove duplicated BRI0A49 and BDP3336 entries
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 21, 2021 at 3:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Sep 21, 2021 at 2:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 9/16/21 7:00 PM, Krzysztof Kozlowski wrote:
> > > BRI0A49 and BDP3336 are already on the list.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >
> > Thanks, patch looks good to me:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > Rafael, I've picked up 1/2 since that applies to a drivers/platform/x86
> > driver. I'll leave picking this one up to you.
>
> I'll pick it up, thanks!

Applied as 5.16 material now, thanks!

> > > ---
> > >  drivers/acpi/acpi_pnp.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> > > index 8f2dc176bb41..ffdcfcd4a10d 100644
> > > --- a/drivers/acpi/acpi_pnp.c
> > > +++ b/drivers/acpi/acpi_pnp.c
> > > @@ -156,8 +156,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
> > >       {"BRI0A49"},            /* Boca Complete Ofc Communicator 14.4 Data-FAX */
> > >       {"BRI1400"},            /* Boca Research 33,600 ACF Modem */
> > >       {"BRI3400"},            /* Boca 33.6 Kbps Internal FD34FSVD */
> > > -     {"BRI0A49"},            /* Boca 33.6 Kbps Internal FD34FSVD */
> > > -     {"BDP3336"},            /* Best Data Products Inc. Smart One 336F PnP Modem */
> > >       {"CPI4050"},            /* Computer Peripherals Inc. EuroViVa CommCenter-33.6 SP PnP */
> > >       {"CTL3001"},            /* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
> > >       {"CTL3011"},            /* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
> > >
> >
