Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7639C432629
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhJRSRz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhJRSRy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Oct 2021 14:17:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788EEC06161C
        for <linux-acpi@vger.kernel.org>; Mon, 18 Oct 2021 11:15:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f5so16997394pgc.12
        for <linux-acpi@vger.kernel.org>; Mon, 18 Oct 2021 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpdkPFVH/NCzfgyWBlahaXx9ZR5/yHZzN8fYBWo0jMw=;
        b=SWeg2Am3MmgbnUcwus/gc1MA3THXNpLxoA9jZnG7PheZw24fRTL61XKW+M7eTflqL1
         TZV/rTR2r/CmvXgiRymx55EemC2wpqQ0ubqA+IwBd6oCF3todJJ2C0mAIG5HVsDD5NoD
         AGvT3xe9pyoRwl6XifekuEudEX7XwcDejjEGb1W1d1HyD/qDzOFCGh80/7IRFFePaRu0
         j8+Uc8oHOqTFiFvRk9QqBGoy+3TX5is21y2Ti2/nYo1jX08Miqroce17e9He1T9uxP41
         P8tmWZbZy67V7yqoXqgNayHDg/E68TCL1wvMQq+MuCi9xbYZ96SAorSBFjxg61iX1ocJ
         fBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpdkPFVH/NCzfgyWBlahaXx9ZR5/yHZzN8fYBWo0jMw=;
        b=BegHf9AfPUmS1fjZwJVZqPMpV+UarjID7h1uSj5rvZM8qwc6qxF0+buHVlU19Lpb6O
         hEV6foLMBuToXNhiLbrxv71BUslIOJgSOOlJizpXhfIUBgw88dGQ71nXCW1GB7Ckm/3q
         KmQ4dzPen2pt8df6GvwXywt+wWw3vLZ3fpXwYqPDdncfdTF6Zcu3XDO4SbvDpts6YlQP
         yMNSWdjEK6vAQ4+/qNvbFD5nS9mmYNGeBGuWnQovOs/0ilZLjmMgxuLVe6i7e471I+Ju
         IzcbxtOBb0PsD1//AeDnycsTPtsQfbk9cowcSvp7qFxQH7iWpg89KV634tiUd+JjBPdN
         CkTQ==
X-Gm-Message-State: AOAM533M7JmbHSNH01SDIzuq5Xx5eALPQV6HLJmKeEyOcXnUMMiD54eK
        PCA6cEOU5+K1WLrQ58Wcqz2/QcDh2CVwt51Ymxevxg==
X-Google-Smtp-Source: ABdhPJz11wHab7pUziRHFzVugVLBtgidzh620b1Ez2zIpcRS9pa8V7oEJPRTqwa3V4UUbpH3nk3/bI96Q5K7jEnqPKM=
X-Received: by 2002:a05:6a00:15c8:b0:44d:9f7e:ece2 with SMTP id
 o8-20020a056a0015c800b0044d9f7eece2mr20624235pfu.86.1634580942887; Mon, 18
 Oct 2021 11:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211009015339.400383-1-alison.schofield@intel.com>
 <20211015175943.000070b8@Huawei.com> <CAPcyv4hziy_+aHz7SSJ0441saDwfHeNyHsB1DMsPjPg7aFHzeg@mail.gmail.com>
 <20211018102538.00007023@Huawei.com>
In-Reply-To: <20211018102538.00007023@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Oct 2021 11:15:36 -0700
Message-ID: <CAPcyv4g=gVeJtSAMPH5VTZfDk+eoL0zkgnQMny=T+xX8RyQKjQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 18, 2021 at 2:25 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 15 Oct 2021 11:58:36 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Fri, Oct 15, 2021 at 10:00 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 8 Oct 2021 18:53:39 -0700
> > > <alison.schofield@intel.com> wrote:
> > >
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > >
> > > > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > > > subtable may be assigned to a NUMA node. Since there is no
> > > > requirement that the SRAT be comprehensive for CXL memory another
> > > > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > > > in the SRAT.
> > > >
> > > > Use the CXL Fixed Memory Window Structure's (CFMWS) of the ACPI CXL
> > > > Early Discovery Table (CEDT) to find all CXL memory ranges. Create a
> > > > NUMA node for each range that is not already assigned to a NUMA node.
> > > > Add a memblk attaching its host physical address range to the node.
> > > >
> > > > Note that these ranges may not actually map any memory at boot time.
> > > > They may describe persistent capacity or may be present to enable
> > > > hot-plug.
> > > >
> > > > Consumers can use phys_to_target_node() to discover the NUMA node.
> > > >
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > Hi Alison,
> > >
> > > I'm not sure that a CFMWS entry should map to a single NUMA node...
> > >
> > > Each entry corresponds to a contiguous HPA range into which CXL devices
> > > below a set of ports (if interleaved) or one port should be mapped.
> > >
> > > That could be multiple devices, each with it's own performance characteristics,
> > > or potentially a mix of persistent and volatile memory on a system with limited
> > > qtg groups.
> > >
> > > Maybe it's the best we can do though given information available
> > > before any devices are present.
> > >
> >
> > Regardless of the performance of the individual devices they can only
> > map to one of the available CFMWS entries. So the maximum number of
> > degrees of freedom is one node per CFMWS. Now if you have only one
> > entry to pick from, but have interleave sets with widely different
> > performance characteristics to online it becomes a policy decision
> > about whether to force map those interleave sets into the same node,
> > and that policy can be maintained outside the kernel.
> >
> > The alternative is to rework NUMA nodes to be something that can be
> > declared dynamically as currently there are assumptions throughout the
> > kernel that num_possible_nodes() is statically determined early in
> > boot. I am not seeing strong evidence that complexity needs to be
> > tackled in the near term, and "NUMA-node per CFMWS" should (famous
> > last words) serve CXL needs for the foreseeable future.
>
> I'm less optimistic we won't end up revisiting this in the medium
> term but can tackle that when we have better visibility of what
> people are actually building.

Agree. When we were game planning this patch internally the 2 options
were, build full support for defining new NUMA nodes after boot, or
just extend the boot-time NUMA node possibilities minimally by the
declared degrees of freedom in the CFMWS. The latter path was taken
because it gets us "80%" of what CXL needs without precluding going
the former path later if that remaining "20% proves critical to add
finer grained dynamic support.
