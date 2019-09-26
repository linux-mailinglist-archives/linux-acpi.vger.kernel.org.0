Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6ABFA08
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2019 21:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfIZT0b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Sep 2019 15:26:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40168 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZT0a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Sep 2019 15:26:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so151367ota.7;
        Thu, 26 Sep 2019 12:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWSNDGi3jKauQ9dQ/11vDbIdImhGLJ9T350jR54cptU=;
        b=Ch3ANC7uT8h8GDEBihiCRnJ9aHuarO0AyAWMnGJeZoCFvqEipeoMFsmg34n9/ahLWt
         60oLpK6lVu/cQYRUNolJj62FnESDN4upJ8Mlbmh9FfOS+c8McXSCS0Fc1gWZtu+MIOXj
         Z65r6JPrcAewlqK/wTtU9snIXuImyd04ySYA5ThiIXpPsFhoCeeiG9HEAsDj90aRgZdA
         Rr1AKzld5BVpxIqoeGeybinAtez2YGAErxRidKEgoRhd/d/zWoXzeOX9Av60kEQbAAdE
         GmrsRMJ3sMkTq+ZSzqFjzK44TxoVVnuStE0thcy/0I8ZZfa3pYoXDTuzxNdGAuSeIcQZ
         P5Kw==
X-Gm-Message-State: APjAAAU8PpL7CZSr6FslgKORdVrBblWICAPINVtsKW/yo5SAtoz7/vwk
        azipwwy3malggSe1VEyjtGX7ldZG+kxFR5uJpPs=
X-Google-Smtp-Source: APXvYqzW9DF/vWRb6DCPzhE4K2ZyyzirbhSAsNzpATto9PNZE1oQN6tTcBuhGTR8dBQ4vCwYDV6M2uzCLf9BDAv5XT0=
X-Received: by 2002:a9d:6a16:: with SMTP id g22mr260324otn.118.1569525989675;
 Thu, 26 Sep 2019 12:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190906174605.GY2680@smile.fi.intel.com> <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <CF6A88132359CE47947DB4C6E1709ED53C6481B1@ORSMSX122.amr.corp.intel.com>
 <20190926163528.GH32742@smile.fi.intel.com> <CF6A88132359CE47947DB4C6E1709ED53C6481F2@ORSMSX122.amr.corp.intel.com>
 <alpine.DEB.2.20.1909262043380.13592@fox.voss.local>
In-Reply-To: <alpine.DEB.2.20.1909262043380.13592@fox.voss.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Sep 2019 21:26:18 +0200
Message-ID: <CAJZ5v0g=onKCidHMLNWuYFCuhcQGmtDDp5QSGiHu1jhoDRuhWQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
To:     Nikolaus Voss <nv@vosn.de>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 26, 2019 at 8:44 PM Nikolaus Voss <nv@vosn.de> wrote:
>
> On Thu, 26 Sep 2019, Schmauss, Erik wrote:
> >> -----Original Message-----
> >> From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org>
> >> On Behalf Of Shevchenko, Andriy
> >> Sent: Thursday, September 26, 2019 9:35 AM
> >> To: Schmauss, Erik <erik.schmauss@intel.com>
> >> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>; Rafael J. Wysocki
> >> <rjw@rjwysocki.net>; Moore, Robert <robert.moore@intel.com>; Len Brown
> >> <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel
> >> Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-
> >> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org;
> >> nv@vosn.de
> >> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
> >>
> >> On Thu, Sep 26, 2019 at 07:09:05PM +0300, Schmauss, Erik wrote:
> >>>> -----Original Message-----
> >>>> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> >>>> Sent: Thursday, September 12, 2019 1:08 AM
> >>>> To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik
> >>>> <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> >>>> Moore, Robert <robert.moore@intel.com>
> >>>> Cc: Len Brown <lenb@kernel.org>; Jacek Anaszewski
> >>>> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan
> >>>> Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org;
> >>>> devel@acpica.org; linux- kernel@vger.kernel.org; nv@vosn.de;
> >>>> Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> >>>> Subject: [PATCH] ACPICA: make acpi_load_table() return table index
> >>>>
> >>> Hi Nikolaus,
> >>>
> >>>> For unloading an ACPI table, it is necessary to provide the index of the table.
> >>>> The method intended for dynamically loading or hotplug addition of
> >>>> tables, acpi_load_table(), should provide this information via an
> >>>> optional pointer to the loaded table index.
> >>>
> >>> We'll take this patch for ACPICA upstream
> >>
> >> Erik,
> >>
> > Hi Andy,
> >
> >> how about to have also counterpart to acpi_load_table() which will do what it's
> >> done now in acpi_configfs.c via acpi_tb_*() API?
> >
> > I should have given more details. We decided to add this extra parameter
> > in AcpiLoadTable and we're going to create an AcpiUnloadTable function
> > that will take table index to unload the table (basically the
> > acpi_tb_unload..). Once we do this, you can use table indices with
> > AcpiUnloadTable and AcpiLoadTable.
>
> that's even better news.
>
> Rafael, shall I prepare anything?

I don't think so.  I'm expecting to get a proper fix from the upstream
through the normal process.

Thanks,
Rafael
