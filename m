Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DB15F71
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfEGIfJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 04:35:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39263 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfEGIfJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 May 2019 04:35:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id x16so5851056oic.6;
        Tue, 07 May 2019 01:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SxMmkP+qrTMooncfYcZ8EYVxmGvWyjBxzbd0N8H+DY=;
        b=R173PrfQ6Hv23OgekbcFGlRs8D2AEokaxGBphH/6Vyrwvc+YrkMIOTQEDSJ8pumMZL
         +h0pNV6pBjsNMuHUagEcqfaDclyA4nlGss41e8h7buwgjQl0js/gEuiHQWc4dxuH3e1s
         vz2oTqjTWMudeD47k/xwjJQ3xyVg3+loqpW34hOXs2R1CaDvzRvtUPYlry9W4q3DTFST
         vBsBIhcWxePEZ0F0peabVvOkMrYVnbOgiNQspOVqSufwQThAhvkiP3b31FZXRm8jxsOn
         eYFF+DD+XFGimwcp+1HrgeQ04tbarL6RxON6g3vjH7FOSopj8Z+02nFDwqF6RNqMRMDV
         8dbA==
X-Gm-Message-State: APjAAAU1h1IwmHs6aVG+XaGYeAzgvnzLqHYR+1HEhNodN3sKEK8IFkvC
        Lli+8GTZc60k3AbH/7pH3BVamcpqhi1/B5v5gYI=
X-Google-Smtp-Source: APXvYqxGZD9naHZ2K7DX4Lus8IP4GTwcbDbDxO6hGyFx+mkTUyD/nb8n2uAcDG+C015zd8xM72NZYPA5CmslIXJx8AU=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr1820842oif.110.1557218108118;
 Tue, 07 May 2019 01:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
 <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com> <CAEJqkgiNYXwsJaT0d3JyMW-2yJ2DV53FHPV5-iAy7b-NbAEAcw@mail.gmail.com>
In-Reply-To: <CAEJqkgiNYXwsJaT0d3JyMW-2yJ2DV53FHPV5-iAy7b-NbAEAcw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 May 2019 10:34:56 +0200
Message-ID: <CAJZ5v0ghNMPMdc03T-is-=-k11rZ8K5O9Av+TnbBY_2mNr-eug@mail.gmail.com>
Subject: Re: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG being set
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 7, 2019 at 9:31 AM Gabriel C <nix.or.die@gmail.com> wrote:
>
> Am Di., 7. Mai 2019 um 09:01 Uhr schrieb Rafael J. Wysocki <rafael@kernel.org>:
> >
>  Hello Rafael ,  Erik
>
> > +Erik
> >
> > On Tue, May 7, 2019 at 1:33 AM Gabriel C <nix.or.die@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > while testing kernel-5.1 I get on one of my Lenovo Laptops very
> > > strange 'ACPI Debug:' messages.
> > >
> > > After some grepping I realized these are Debug messages from DSDT ,
> > > however my kernel does
> > > not have ACPI_DEBUG enabled.
> > >
> > > I found out the module triggering this, on this Laptop is
> > > ideapad_laptop , but looking at the code
> > > I cannot see what would causes that.
> > >
> > > Also on the same Laptop with any 5.0.X kernels I cannot see these.
> > >
> > >
> > > ~$ grep -i ACPI_DEBUG /boot/config-5.1-fw1
> > > # CONFIG_ACPI_DEBUGGER is not set
> > > # CONFIG_ACPI_DEBUG is not set
> > > # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> > > # CONFIG_THINKPAD_ACPI_DEBUG is not set
> > >
> > > .. dmesg ..
> > > ...
> > > [   68.020812] calling  ideapad_acpi_driver_init+0x0/0x1000
> > > [ideapad_laptop] @ 1322
> > > [   68.026708] input: Ideapad extra buttons as
> > > /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input16
> > > [   68.038236] ACPI Debug:  "=====QUERY_64====="
> > > [   68.050232] ACPI Debug:  "=====QUERY_65====="
> > > [   68.060218] ACPI Debug:  "=====QUERY_64====="
> > > [   68.092216] probe of VPC2004:00 returned 1 after 71386 usecs
> > > [   68.092245] initcall ideapad_acpi_driver_init+0x0/0x1000
> > > [ideapad_laptop] returned 0 after 69751 usecssg
> > >
> > > ...
> > >
> > > These =====QUERY_XX===== messages are from DSDT:
> > >
> > > ~/acpi$ grep QUERY dsdt.dsl
> > >                Debug = "=====QUERY_11====="
> > >                Debug = "=====QUERY_12====="
> > >                Debug = "=====QUERY_24====="
> > >                Debug = "=====QUERY_25====="
> > >                Debug = "=====QUERY_37====="
> > >                Debug = "=====QUERY_38====="
> > >                Debug = "=====QUERY_64====="
> > >                Debug = "=====QUERY_65====="
> > >
> > > Also this is the code from DSDT for QUERY 64 and 65:
> > >
> > > ...
> > >             Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query
> > >            {
> > >                Debug = "=====QUERY_64====="
> > >                If ((OSYS == 0x07D9))
> > >                {
> > >                    If (((WLEX == One) & (WLAT == One)))
> > >                    {
> > >                        SGOV (0x02040005, One)
> > >                    }
> > >                    Else
> > >                    {
> > >                        SGOV (0x02040005, Zero)
> > >                    }
> > >                }
> > >            }
> > >
> > >            Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query
> > >            {
> > >                Debug = "=====QUERY_65====="
> > >                If ((OSYS == 0x07D9))
> > >                {
> > >                    If (((BTEX == One) & (BTAT == One)))
> > >                    {
> > >                        SGOV (0x0202000B, One)
> > >                    }
> > >                    Else
> > >                    {
> > >                        SGOV (0x0202000B, Zero)
> > >                    }
> > >                }
> > >            }
> > >
> > > ...
> > >
> > >
> > > Any idea what would cause this ?
>
> I think I found what is causing that.
>
> Commit aa9aaa4d61c0048d3faad056893cd7860bbc084c is moving
> definition of Linux's  ACPI_DEBUG_DEFAULT to incude/acpi/platform/aclinux.h ,
> however include/acpi/acpi.h didn't got updated and  ACPI_DEBUG_DEFAULT now
> being always defined as  (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT |
> ACPI_LV_EVALUATION | ACPI_LV_REPAIR)

I'm not sure what you mean by this.

include/acpi/acpi.h should get the right definitions through
include/acpi/platform/acenv.h and include/acpi/acoutput.h that are
included by it.

It looks like incude/acpi/platform/aclinux.h has not been included by
include/acpi/platform/acenv.h for some reason when building this
module.
