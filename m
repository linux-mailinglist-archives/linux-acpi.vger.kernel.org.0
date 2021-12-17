Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA43479423
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Dec 2021 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhLQShN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Dec 2021 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbhLQShN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Dec 2021 13:37:13 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D642C06173E
        for <linux-acpi@vger.kernel.org>; Fri, 17 Dec 2021 10:37:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p18so2560497pld.13
        for <linux-acpi@vger.kernel.org>; Fri, 17 Dec 2021 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jw3+o9tkTtZaFXuWp2piyMoDxF7elmFPwWeoUWpMXV8=;
        b=xEH1wEdUSk1xmiYH6ttaReiH5aeghdNG1EYWe4VzJd8UpXsRJ0qf7fKQwfbfjoAiMD
         qQRbrVQCNbFP0y2sBr7RPCzh8bk/vDdf0kLIHuaWJMfnressCyvgbEr13bk0uidFYB1a
         y+GFFrk8YicAA8/KS/HEyqWKedlu8bBssZnMXN4NsSQLE7bdKAtIx/Uvv6xlyOl8L++d
         h+OG2Bp2vB8zvWT3vgkPV+T12CqmDvx3XMFHkJfcmayOhbBsfP34YK166mx/VJxoh3Fa
         djf3lk2phSoFObMeS7U8K9L+drSJlVtE8fO1KWvC1O3/XXgr4e04060KG0B0r2R8MaPo
         beYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jw3+o9tkTtZaFXuWp2piyMoDxF7elmFPwWeoUWpMXV8=;
        b=pI0R22Me0+1O6RB0SB7dWbJxAM5MDehxSbqxbgIKYUDOhT+YJgAlEAINWC1oiZKUoq
         3qIfgT5H/R9CI1rqkv+NlKktPoN9N6rlji85NEf7KbZlVOb4E0XrDsTv4AR4u6k8rA3S
         cBG4qf6qizGw1A7RnQpYF4N0DPy/dHlabqeh5vuGreLocTSsk3JNwhk6bwCuoD/8s5Lo
         gA3Bq5coHZI0Fmhgjqq684x969Fl6nAwz5Nof6YPp1thjRkUSq+P22OH6yO7jv3sL51B
         xyhqtdKmPtOaaNZhzLpmFjGgP/8OyJgPk6IQ+ml6K/uDDDNdlVVqnMhpuvk+23LQSxil
         P0CA==
X-Gm-Message-State: AOAM530CxaFLw0n4Q7xgsbDaZplxKgVyL+5/0KhlZDUyfaARyRBO5fgl
        3S8lyt7cwUvsz3/bfyl7PewQBm4rWUTj3TQyhzGnfQ==
X-Google-Smtp-Source: ABdhPJxDBkvgS9A026yO5Rs99/u8nNKM0OcQsqOSN3zAuOrNgAwJTO5XzM/AR0gZffNPUZNSYWtxvjhGqJ6Iy+HwKgw=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr5150038pjb.93.1639766232605;
 Fri, 17 Dec 2021 10:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20211213204632.56735-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0jq=XdH+xeHs5=wMGsu28i+r3nzZbhCNMJkfdOi65N0Gg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jq=XdH+xeHs5=wMGsu28i+r3nzZbhCNMJkfdOi65N0Gg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 17 Dec 2021 10:37:02 -0800
Message-ID: <CAPcyv4hA41u=RvNfvukrcRDjmw6i7t4Vg3u1cXReQGKi6MHwJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 17, 2021 at 10:10 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 13, 2021 at 9:46 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Strictly speaking the comparison between guid_t and raw buffer
> > is not correct. Import GUID to variable of guid_t type and then
> > compare.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Dan, are you going to take care of this or should I?

I'll take it.

Apologies for the delay in responding. I am still catching up on some
patch merging backlog.
