Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C917E446575
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 16:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhKEPJx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 11:09:53 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40585 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhKEPJx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 11:09:53 -0400
Received: by mail-oi1-f177.google.com with SMTP id y11so14972119oih.7;
        Fri, 05 Nov 2021 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvVdVt6Iz/HVU1yKu8B9fwySzZLcp1LPGBp9S6J40qg=;
        b=S6AbPrv2bvsUbRDIuDCavJDmlSl8EeQiOKvwlkgT9oMXAabV5OL40QL/cPpH+6VTfw
         2BIyWg9s1s2fmT5dtwHpwJXbnGq9gDSTfb8IMZh2WPEHzDDQjwGfa+OXxE/LdcKwcfa3
         kM0cIch+jY/biO2CbXE7ypmmvPu5H+WfRud4pfYpua9XXXSmedySoW5J4cklvukLcpwG
         kPMVYZK2gkkt0nJf8Mwcj5AOXY7R1nVpKV27j9n0o8yC2/F5wvXMH+y2qLiZuibDCovf
         WqPNUTavfwOv2k/HiXPTa6cdzikmfEGneSCeM/g+fRvTOARbbt5BBmn0FpBSBy7e6Ad2
         X/Qw==
X-Gm-Message-State: AOAM532Dq2N17LPHPHDWqC1bprLnf80mLlC/qih4nclTVWJJ3dkBm7dA
        53/Ts3spvnPKQVC2vjjixcHnm1hzcifhe6WIBws=
X-Google-Smtp-Source: ABdhPJwkyYu3R6ttJ3AqyUzqpIoAIZUMOGQX2Sxr0+VX/E1g0DM4eu61bup+kE+U8voiN+5jC9G1vAsjGp5f8greXoc=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr22306423oif.154.1636124832859;
 Fri, 05 Nov 2021 08:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211101120055.00007383@Huawei.com> <CAPcyv4g_c1mF6WvsMHC7-US7YybSprk=GX6cFWjoGOVa+yLx9g@mail.gmail.com>
 <20211102174421.00002ae4@Huawei.com>
In-Reply-To: <20211102174421.00002ae4@Huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 16:07:01 +0100
Message-ID: <CAJZ5v0jd9ntjmEa=-EyXUOExgJsU_A5fJdB0HirT6c6V802f6Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce acpi_table_parse_cedt and extra nodes for CXL.mem
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 2, 2021 at 6:44 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Nov 2021 20:41:34 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Mon, Nov 1, 2021 at 5:01 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 29 Oct 2021 12:51:27 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > Hi Rafael,
> > > >
> > > > While reviewing "[PATCH v3] ACPI: NUMA: Add a node and memblk for each
> > > > CFMWS not in SRAT" [1]. I noticed that it was open coding CEDT sub-table
> > > > parsing in a similar fashion as drivers/cxl/acpi.c. The driver open
> > > > coded the parsing because the ACPI sub-table helpers are marked __init.
> > > > In order to avoid the ongoing maintenance burden of a split between
> > > > "early" and "late" ACPI sub-table parsing this series proposes to make
> > > > those helpers available to drivers.
> > > >
> > > > The savings in drivers/cxl/ are:
> > > >
> > > >  drivers/cxl/Kconfig |    1
> > > >  drivers/cxl/acpi.c  |  234 +++++++++++++++++++--------------------------------
> > > >  2 files changed, 88 insertions(+), 147 deletions(-)
> > > >
> > > > ...and 15 lines new code not added are saved in this new version of
> > > > "ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT".
> > > >
> > > > Let me know if this looks ok to you and I can carry it in the CXL tree
> > > > (i.e. after the merge window, for v5.17 consideration).
> > > >
> > > > [1]: https://lore.kernel.org/r/20211019050908.449231-1-alison.schofield@intel.com
> > >
> > > Is it worth the complexity of the __init_or_acpilib and export part?
> > > Seems like a fiddly dance for what looks to be minor savings...
> >
> > It follows the __initdata_or_meminfo precedent that identifies data
> > that is normally __init unless a specific driver needs it. The lesson
> > from the tinyconfig effort was that image size dies a death of many
> > cuts unless care is taken to preserve minor savings. Yes, it's likely
> > trivial in this case, but it's at least a gesture to avoid bloating
> > the kernel image size unnecessarily when the kernel has gotten by so
> > long with this infrastructure being purely __init.
>
> I'm in favor avoiding bloat, but this is ACPI code so rarely very small machines
> and very like that all distros will turn it on anyway on basis they will want
> to support CXL (hopefully!)
>
> I guess let's see what Rafael's opinion is.  I don't feel that strongly about
> it if general view is that it is worth the small amount of complexity.

The general ACPI changes in this series are fine with me, so Dan
please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

Thanks!
