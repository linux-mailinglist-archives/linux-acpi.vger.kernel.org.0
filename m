Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5434E711
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhC3MFp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 08:05:45 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38712 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhC3MFf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 08:05:35 -0400
Received: by mail-oi1-f175.google.com with SMTP id f9so16231476oiw.5;
        Tue, 30 Mar 2021 05:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gSpMHBqfF0ztmaxY0HWMjy3Yg1wW/3Zssdp7txxPh0=;
        b=Ttm1kyC1kcyFaRJm9074us8dPCGlQGfYVkrGjEIjI2AxNYnBNRdfAfLXnWz4kLqcqo
         Z+WHG61wiNaTDO5wFJEYFfS3fLzIYLPbVAOe7z9mNTsyZ6BhMbZsOT/mxuJEYMO0lMce
         /2ZQTMWaKQ+b/uPU4N1T6hgrFUBsiEBs9kehI6FzVuUjM9RmFlo19TKoNv8KM/Wlx+on
         1I3WZAgqTUenzbsBlF/2R30r+rxx5rx3Q+9oAsE3UHmGwgyqNJqIwV1BuOxSsby6wIEC
         F9l8P+cC1hZA5BCMR4NTlrOQg3Rr1kU4AXNPsIW+duxPFO4UeX90/dO3KkBYDDNpPE2v
         odFg==
X-Gm-Message-State: AOAM530G72OtTYVg0vweA+tsxT5DCIe2qs2xP0gu0K9W4q9bSCuwB1Nv
        ztZjKk47e3s6Inl/MPFitkFAvwInwWqiE/2N2mo=
X-Google-Smtp-Source: ABdhPJyvALkfL8/HLhMkZXqqpPnJFTbVIs7Jgdkb82xywZuWf677uaTgXhH1KFNPxVY899UjtUcAwYGNcjmtiKQbHqY=
X-Received: by 2002:aca:c4c5:: with SMTP id u188mr2948538oif.71.1617105934975;
 Tue, 30 Mar 2021 05:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210326001922.4767-1-unixbhaskar@gmail.com> <CAJZ5v0izUkL=7NSFuefNYcqdq2vSxseDCCLKUTOZGC82WjJNPg@mail.gmail.com>
 <MWHPR11MB15993DB0504FBD17DB4B1792F07D9@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB15993DB0504FBD17DB4B1792F07D9@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Mar 2021 14:05:23 +0200
Message-ID: <CAJZ5v0gf4i+HLPYzETCiG740FCXBHe5hf2PeCfCiqVJODhaMyg@mail.gmail.com>
Subject: Re: [Devel] Re: [PATCH] ACPICA: Fix a typo
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 30, 2021 at 2:19 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Monday, March 29, 2021 5:48 AM
> > To: Bhaskar Chowdhury <unixbhaskar@gmail.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; ACPI Devel Maling List
> > <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> > (ACPICA) <devel@acpica.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Randy Dunlap <rdunlap@infradead.org>
> > Subject: [Devel] Re: [PATCH] ACPICA: Fix a typo
> >
> > On Fri, Mar 26, 2021 at 1:22 AM Bhaskar Chowdhury
> > <unixbhaskar@gmail.com> wrote:
> > >
> > >
> > > s/optimzation/optimization/
> > >
> > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > > ---
> > >  include/acpi/acoutput.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> > > index 1538a6853822..1b4c45815695 100644
> > > --- a/include/acpi/acoutput.h
> > > +++ b/include/acpi/acoutput.h
> > > @@ -362,7 +362,7 @@
> > >   *
> > >   * A less-safe version of the macros is provided for optional use if the
> > >   * compiler uses excessive CPU stack (for example, this may happen in the
> > > - * debug case if code optimzation is disabled.)
> > > + * debug case if code optimization is disabled.)
> > >   */
> > >
> > >  /* Exit trace helper macro */
> > > --
> >
> > Erik, could you pick up this patch, please?  It is simple enough IMV ...
>
> No problem, I'll pick it up

Thanks!
