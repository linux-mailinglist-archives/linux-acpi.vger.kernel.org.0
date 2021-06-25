Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFFD3B4818
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 19:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFYRUk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYRUk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jun 2021 13:20:40 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF2C061766
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jun 2021 10:18:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id g19so5542369qvx.12
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jun 2021 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=siE1epn+L3LEogU7I1mjth/qAGMeZkKTvnoymSTcs6c=;
        b=t9Hr2wERvksnNIIXbbNLYC8013rau1+cspy+iLOaqOjLrwLyX5f9cKWMtjCkkcsBcE
         QAYhLBYKt+1lMLRxRd0LPsdPE49lU8jFeWAhAq8qEy/19GHgTCdEftmZDgfG5pWoMQvC
         Q/3fW4qY8mom/IcoXAUGpC0k0cv3iaHjBKVMbFT4zTfTxuyqCB0rpwvJQEOzFRg/vBBB
         ntsdEEBAe7qF8w305bdxSezi+/CO1kFTlUZTiaWXkz3kNMvXWwokwncN1eTtfRbvwcaq
         ZUBvhfo4EsS5N0ZMo9yloBnlOiRF9g3ukEzCOsRRsmcKvjletpv9PF93qFrXIu+kgB/F
         EKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=siE1epn+L3LEogU7I1mjth/qAGMeZkKTvnoymSTcs6c=;
        b=cF77q9uoRl4I7PCNRKHQ545Mku48i18WnsQ8Ua3QzNEQifBI2MnPnCvA36/2e5Q3QU
         CZe18N4+WS3CP/QSM4nzfOMYF0NmdQg0YMFgQaUZwp5PkIAR2ValTMISI3etGU5aLkcp
         P4H2FYlCULnuSGzfdsnNtLYWwJSGiZO9Vtx+T/tBkrLh9mLEHqCKBJsSLMCnrqnDw9Cm
         8vxUVrS9JI+1B8/uEMDK7RG6u1i2dOcG1DyUdhlk2xxQPR3ZMtvwYaJ5uJeyUSoqrmCd
         FE/koyGWyQPLO4zDEWE81vgPtaZgUGKN5QVzQfsU0dsZAgzo1caCdI6CUZYcfNMQM+Nk
         27Eg==
X-Gm-Message-State: AOAM532mHulq4b/+UDGAY976f4svWqeThddl59VZuzFv2ULQfr87VS6z
        YrlEgD8a/5/8m4hkYKT3ISQTp6q3Ys9S/2P2ASYMxg==
X-Google-Smtp-Source: ABdhPJyDrxwptFBzZu95ukspWmOhoRNz2DCZa+4AlwV4VvfZDJcQW7QHwfm5Ct/4sT82zwYNmNDhOQWKHBwQPyYaiJU=
X-Received: by 2002:a05:6214:c89:: with SMTP id r9mr3466579qvr.40.1624641498324;
 Fri, 25 Jun 2021 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210621200459.3558199-1-mw@semihalf.com> <CAPv3WKctDU7WOxHzeHc49-G_h42qX-pUpinJN2CVHNoRH86QHw@mail.gmail.com>
In-Reply-To: <CAPv3WKctDU7WOxHzeHc49-G_h42qX-pUpinJN2CVHNoRH86QHw@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 25 Jun 2021 19:18:06 +0200
Message-ID: <CAPv3WKf=ufj-RbqOKm3cjOQcG1PDAEAkVLdLQUkRK94=_vtj9w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Add new 16550-compatible Serial Port Subtype
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org
Cc:     Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net,
        lenb@kernel.org, erik.kaneda@intel.com, robert.moore@intel.com,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

pon., 21 cze 2021 o 22:06 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(a):
>
> Apologies for the patch prefix, of course it's a first version and
> unrelated to the networking subsystem.
>
> Best regards,
> Marcin
>
>
> pon., 21 cze 2021 o 22:05 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(a)=
:
> >
> > The Microsoft Debug Port Table 2 (DBG2) specification revision
> > May 31, 2017 adds support for 16550-compatible Serial Port
> > Subtype with parameters defined in Generic Address Structure (GAS) [1]
> >
> > Add its support in SPCR parsing routine.
> >
> > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/a=
cpi-debug-port-table
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  include/acpi/actbl1.h | 1 +
> >  drivers/acpi/spcr.c   | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index ce59903c2695..f746012eba8d 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -498,6 +498,7 @@ struct acpi_dbg2_device {
> >  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
> >  #define ACPI_DBG2_ARM_DCC           0x000F
> >  #define ACPI_DBG2_BCM2835           0x0010
> > +#define ACPI_DBG2_16550_WITH_GAS    0x0012
> >
> >  #define ACPI_DBG2_1394_STANDARD     0x0000
> >
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index 88460bacd5ae..25c2d0be953e 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bo=
ol enable_console)
> >                 break;
> >         case ACPI_DBG2_16550_COMPATIBLE:
> >         case ACPI_DBG2_16550_SUBSET:
> > +       case ACPI_DBG2_16550_WITH_GAS:
> >                 uart =3D "uart";
> >                 break;
> >         default:
> > --

Do you have any comments / remarks to the patch?

Best regards,
Marcin
