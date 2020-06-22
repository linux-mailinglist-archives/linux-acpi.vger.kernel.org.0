Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5948203B66
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgFVPrJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgFVPrI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 11:47:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4F3C061573;
        Mon, 22 Jun 2020 08:47:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so7741388plk.3;
        Mon, 22 Jun 2020 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xc2mKgeExdGmIWqPOYOYWo2Adk+x5jGFKVodlRCWmyU=;
        b=cHFkvNQ3kDK5qybk3Qkc7QMvYMDxnAW7w/x/z161hVHqWAJJ/0Mxy1ocu8GLKCHwwf
         AL54f+6RUWVivK0X3t1NG3a0lB5qLdxCGOOb8sIzxjwbywiESpPsEbnWmuoFPAt7YEue
         D83hrHNbHTPE0LkgCvRcCxjf7nPTEAVgTgiV+4R/1r9w/GwBO4vv3wN4UJF0jaOi0Cyw
         wp86iZ1b5TX6/RDHzyacxQcruuDDIb/uVZJEbjmrFJu36VXuY3WhlUDx+iu+YZ2Cx65D
         Mlc/2aK6I8TySALnESH8Q5RhFEavkhTc74hokrDyv/aYVOFILUOnwoLreHDmR/XWOEnf
         E8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xc2mKgeExdGmIWqPOYOYWo2Adk+x5jGFKVodlRCWmyU=;
        b=HX5/J01a8FMsMEm6Jco0K29JzMcNzvINPf1tkxiMGIjwxYs+Iv/J3GJ3pDC+SLOwGV
         6ADNsOIIB4CizTLoWl36nBBv5iSti5uLZ45Ic+TyAXk3PieY+KDvZUcvnbzkSbjOI6JF
         afm3endvgKmBbSW0PJ+rfZqT8yvh57pjhqCSN9ctzRbUlLhMW93Uo+gCB4U7H5yKt4GX
         BWF8rnL7cXJHWGVyaJ068Gkj+TKvoVwg0iafe9r4aIzpdWbr6JLBMxOkf8Iiqfa1pWoI
         Vew95qRNqw6vTtiFD8VH5URIhxt0tasLAc1SCSJC0yIddR4szjnspcvJGNq5rzpjh37y
         Pn/Q==
X-Gm-Message-State: AOAM531hC56usaaq382aSdD5/0l0SEOF3+F4we4KvgqxAm7GaWuiXpVn
        3dAebcrDzDAuh0OPeVhLQm36Si8exPOYeXf2xJE=
X-Google-Smtp-Source: ABdhPJz7jigT5zkg/O2S5/eaBk4kjsdhjro5aDd0v+PmSBHqwDtOO8xOJsJOC98Bakhoy/3YazfLdb/XwgY8UG1pf7Q=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr18713382pjr.181.1592840828258;
 Mon, 22 Jun 2020 08:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <1821880.vZFEW4x2Ui@kreacher>
 <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com> <CAJZ5v0hu9_TA0KAe=9ZCSG4_KijSYb=qnt8MYe9QYwGbz=pmBg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hu9_TA0KAe=9ZCSG4_KijSYb=qnt8MYe9QYwGbz=pmBg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 18:46:55 +0300
Message-ID: <CAHp75VdQbH28ZyqkgPU_tq8WpHf152=4LpLCSLUji3MmywMiQw@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 2/4] ACPI: OSL: Add support for deferred unmapping
 of ACPI memory
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 22, 2020 at 6:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jun 22, 2020 at 4:56 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 22, 2020 at 5:06 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

...

> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> >
> > A nit:
> >
> > Effectively it returns a value of defer.
> >
> >   return defer;
> >
> > >  }
>
> Do you mean that one line of code could be saved?  Yes, it could.

Yes. The question here would it make a cleaner way for the reader to
understand the returned value?

(For the rest, nevermind, choose whatever suits better in your opinion)

-- 
With Best Regards,
Andy Shevchenko
