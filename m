Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E84133C6
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Sep 2021 15:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhIUNKT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 09:10:19 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41850 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhIUNKT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2021 09:10:19 -0400
Received: by mail-ot1-f46.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso21257129ota.8;
        Tue, 21 Sep 2021 06:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxkNFPBC461YfQgocr3vAKBRyMLGM7PbdciNNlGgvoQ=;
        b=nFvHGDNpcqFpsyJAOrgxxvq6rceJ+26Cc6Ft3SSdQ43ORVFz+ycalqF4aDohX5y1UO
         kS/mRKxCRVy2X4AeTh51L1qPDlQ7nPbBxCZvyQfX09bWgcYt35xjNbRxZ/0HaeEDJWQ1
         7HTEzpmL+udikZnKIhBgZ7ITGOmTE6XpP4CM4RKKyuVfAbOpP36IVGuOWKxOr+IT3VZv
         FldVKgPpSj0W7SlN1Gpq0/mzwvii07KCVdt6cPfQ+f4JPw6goTR7erRh30cofb3UvBYV
         KaX60/zCvlxqKgjibJkoN2y0W9NB4UnLFlh4BvaxFi4wlrsPOCR2JD1xz36VxvylMIbF
         BOvg==
X-Gm-Message-State: AOAM533cF1IODpgV9xcpdP+Uskvo9hMBbyc31ycJkK5SvyLTZpKKGfc2
        hB/+9PBZmnkAeASzY1UI1grkhcxpTWaqnovHXG/+LhIv
X-Google-Smtp-Source: ABdhPJy2lq2k9wr64rRinyx/OmSeoNOiP1icCASohpi+LrzO1geQDEpVRb3a/EXOsGBfCNvC1YkFnAxRrSc5LuaIDgo=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr25968827otk.86.1632229730204;
 Tue, 21 Sep 2021 06:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
 <20210916170054.136790-2-krzysztof.kozlowski@canonical.com> <f78523c5-df88-a768-3b9a-d542bbd73a1c@redhat.com>
In-Reply-To: <f78523c5-df88-a768-3b9a-d542bbd73a1c@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Sep 2021 15:08:39 +0200
Message-ID: <CAJZ5v0gBZUrvX+w2oz-tmvDrHz_tFvzyzVGe4iz2wc3-V_9qPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] acpi: pnp: remove duplicated BRI0A49 and BDP3336 entries
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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

On Tue, Sep 21, 2021 at 2:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 9/16/21 7:00 PM, Krzysztof Kozlowski wrote:
> > BRI0A49 and BDP3336 are already on the list.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Rafael, I've picked up 1/2 since that applies to a drivers/platform/x86
> driver. I'll leave picking this one up to you.

I'll pick it up, thanks!


> > ---
> >  drivers/acpi/acpi_pnp.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> > index 8f2dc176bb41..ffdcfcd4a10d 100644
> > --- a/drivers/acpi/acpi_pnp.c
> > +++ b/drivers/acpi/acpi_pnp.c
> > @@ -156,8 +156,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
> >       {"BRI0A49"},            /* Boca Complete Ofc Communicator 14.4 Data-FAX */
> >       {"BRI1400"},            /* Boca Research 33,600 ACF Modem */
> >       {"BRI3400"},            /* Boca 33.6 Kbps Internal FD34FSVD */
> > -     {"BRI0A49"},            /* Boca 33.6 Kbps Internal FD34FSVD */
> > -     {"BDP3336"},            /* Best Data Products Inc. Smart One 336F PnP Modem */
> >       {"CPI4050"},            /* Computer Peripherals Inc. EuroViVa CommCenter-33.6 SP PnP */
> >       {"CTL3001"},            /* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
> >       {"CTL3011"},            /* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
> >
>
