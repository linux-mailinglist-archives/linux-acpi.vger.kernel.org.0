Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0500E160F3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEGJbp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 05:31:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43177 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGJbp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 May 2019 05:31:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id z5so8559326lji.10;
        Tue, 07 May 2019 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UugU8bcqRlU6fUtnSXsie58MePyLeanBGjIGYAFl8bk=;
        b=vDCyn5CxNnPUPCEqRgPPlKFIwkGh/ugk6h4gCIIv1s1wr1Lel0KufmmwTeWRK6cFDT
         h2ti7rwxjv1O4yhQZ02PvNEutBCvkvaq7h/wJdxO2cz/XL0qz9d9/HTSRvsDOdBzlocn
         iWQh0CS8vqZVsb+nXhX2CYGUxEWTs6bCS82HjQVVirqa7/XfDz97RjhVJKMVWLEmxPeW
         Rmlz66GyZI1vX5/Tc12EhrsLodCCTcjncx4/2iAN5psrKBFrK1b/TrYrH0zYgiZK3R3t
         omo7CMkoX1Rr1hZj8fbMT6i9rpk0cIrSy1MIFs+MVbmreVQE7EngxF2+uHyx6KbvFOfB
         roYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UugU8bcqRlU6fUtnSXsie58MePyLeanBGjIGYAFl8bk=;
        b=Gl6dvSeqHw3CwFqFdzNMc8dDwChqk7VlaCexrPN2/JFRUgJRGe686qURx3Jo3klU0m
         9j5QF3ZjL5XxzNNdj0XW0/H/SVcm343BOmppuB7I0SvfvES0CDFWM3cwyDd7iP7YcGys
         nRoG1KL4LNFwuCygsQ0SkR8PWMh+aGTNZdRxq+M5ov8uJ1srlRnLQ76hsFotDsvOwMAf
         63WdZJGb4JBjM0PG8yEYZWufU2ISMeC1fv6CNs4LBIDU6VOFDb1QPkYBJkHyPEK97lmm
         z++t6QCRWYk9DK0dW7jzvniFkbpfiPwhgAXCQFKVRmH3pZVMQx930I7OiySRGNfYaECs
         bo7w==
X-Gm-Message-State: APjAAAVveesWlvPt1dnTeMLyvEFcoItUd4hSL+5AmoXWBPFu8JiDDBn4
        g2p+UDItiTt9LqRqCRcCPEFsqcsecHYeP9sB58mwTr446g==
X-Google-Smtp-Source: APXvYqzsrvWHDsBC8hJz1bIApGfTaiO6V5Ia64cqo9Y/K1NUL41UYcprH8OmSozcsgbmqxm93LCrYpQjYbNdgC8Oj1k=
X-Received: by 2002:a2e:9d4c:: with SMTP id y12mr16436600ljj.132.1557221502347;
 Tue, 07 May 2019 02:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
 <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
 <CAEJqkgiNYXwsJaT0d3JyMW-2yJ2DV53FHPV5-iAy7b-NbAEAcw@mail.gmail.com> <CAJZ5v0ghNMPMdc03T-is-=-k11rZ8K5O9Av+TnbBY_2mNr-eug@mail.gmail.com>
In-Reply-To: <CAJZ5v0ghNMPMdc03T-is-=-k11rZ8K5O9Av+TnbBY_2mNr-eug@mail.gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Tue, 7 May 2019 11:33:01 +0200
Message-ID: <CAEJqkgiB7woieNZ-vVm7x-GzVrqGpJWLXOM9JpSUgPgE7eA6gA@mail.gmail.com>
Subject: Re: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG being set
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am Di., 7. Mai 2019 um 10:35 Uhr schrieb Rafael J. Wysocki <rafael@kernel.org>:
>
> On Tue, May 7, 2019 at 9:31 AM Gabriel C <nix.or.die@gmail.com> wrote:
> >
> > Am Di., 7. Mai 2019 um 09:01 Uhr schrieb Rafael J. Wysocki <rafael@kernel.org>:
> > >
> >  Hello Rafael ,  Erik
> >
> > > +Erik
> > >
> > > On Tue, May 7, 2019 at 1:33 AM Gabriel C <nix.or.die@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > while testing kernel-5.1 I get on one of my Lenovo Laptops very
> > > > strange 'ACPI Debug:' messages.
> > > >
> > > > After some grepping I realized these are Debug messages from DSDT ,
> > > > however my kernel does
> > > > not have ACPI_DEBUG enabled.
> > > >
> > > > I found out the module triggering this, on this Laptop is
> > > > ideapad_laptop , but looking at the code
> > > > I cannot see what would causes that.
> > > >
> > > > Also on the same Laptop with any 5.0.X kernels I cannot see these.
> > > >
> > > >
> > > > ~$ grep -i ACPI_DEBUG /boot/config-5.1-fw1
> > > > # CONFIG_ACPI_DEBUGGER is not set
> > > > # CONFIG_ACPI_DEBUG is not set
> > > > # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> > > > # CONFIG_THINKPAD_ACPI_DEBUG is not set
> > > >
> > > > .. dmesg ..
> > > > ...
> > > > [   68.020812] calling  ideapad_acpi_driver_init+0x0/0x1000
> > > > [ideapad_laptop] @ 1322
> > > > [   68.026708] input: Ideapad extra buttons as
> > > > /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input16
> > > > [   68.038236] ACPI Debug:  "=====QUERY_64====="
> > > > [   68.050232] ACPI Debug:  "=====QUERY_65====="
> > > > [   68.060218] ACPI Debug:  "=====QUERY_64====="
> > > > [   68.092216] probe of VPC2004:00 returned 1 after 71386 usecs
> > > > [   68.092245] initcall ideapad_acpi_driver_init+0x0/0x1000
> > > > [ideapad_laptop] returned 0 after 69751 usecssg
> > > >
> > > > ...
> > > >
> > > > These =====QUERY_XX===== messages are from DSDT:
> > > >
> > > > ~/acpi$ grep QUERY dsdt.dsl
> > > >                Debug = "=====QUERY_11====="
> > > >                Debug = "=====QUERY_12====="
> > > >                Debug = "=====QUERY_24====="
> > > >                Debug = "=====QUERY_25====="
> > > >                Debug = "=====QUERY_37====="
> > > >                Debug = "=====QUERY_38====="
> > > >                Debug = "=====QUERY_64====="
> > > >                Debug = "=====QUERY_65====="
> > > >
> > > > Also this is the code from DSDT for QUERY 64 and 65:
> > > >
> > > > ...
> > > >             Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query
> > > >            {
> > > >                Debug = "=====QUERY_64====="
> > > >                If ((OSYS == 0x07D9))
> > > >                {
> > > >                    If (((WLEX == One) & (WLAT == One)))
> > > >                    {
> > > >                        SGOV (0x02040005, One)
> > > >                    }
> > > >                    Else
> > > >                    {
> > > >                        SGOV (0x02040005, Zero)
> > > >                    }
> > > >                }
> > > >            }
> > > >
> > > >            Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query
> > > >            {
> > > >                Debug = "=====QUERY_65====="
> > > >                If ((OSYS == 0x07D9))
> > > >                {
> > > >                    If (((BTEX == One) & (BTAT == One)))
> > > >                    {
> > > >                        SGOV (0x0202000B, One)
> > > >                    }
> > > >                    Else
> > > >                    {
> > > >                        SGOV (0x0202000B, Zero)
> > > >                    }
> > > >                }
> > > >            }
> > > >
> > > > ...
> > > >
> > > >
> > > > Any idea what would cause this ?
> >
> > I think I found what is causing that.
> >
> > Commit aa9aaa4d61c0048d3faad056893cd7860bbc084c is moving
> > definition of Linux's  ACPI_DEBUG_DEFAULT to incude/acpi/platform/aclinux.h ,
> > however include/acpi/acpi.h didn't got updated and  ACPI_DEBUG_DEFAULT now
> > being always defined as  (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT |
> > ACPI_LV_EVALUATION | ACPI_LV_REPAIR)
>
> I'm not sure what you mean by this.
>
> include/acpi/acpi.h should get the right definitions through
> include/acpi/platform/acenv.h and include/acpi/acoutput.h that are
> included by it.
>

Hmm yes should , I missed that include. However it does not work.

I've just put back old code back into drivers/acpi/bus.c to test
and all working now fine without any other changes.

> It looks like incude/acpi/platform/aclinux.h has not been included by
> include/acpi/platform/acenv.h for some reason when building this
> module.

If this one getting it wrong all will do so , they all just include
<linux/acpi.h>.

Probably not so much users will notice that , I just did because my
BIOS vendor forgot DEBUG around.
