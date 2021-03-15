Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8C33C8F2
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Mar 2021 23:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhCOWAh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Mar 2021 18:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhCOWAX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Mar 2021 18:00:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D3C06174A
        for <linux-acpi@vger.kernel.org>; Mon, 15 Mar 2021 15:00:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bf3so19126687edb.6
        for <linux-acpi@vger.kernel.org>; Mon, 15 Mar 2021 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jm6ME5Ke2ec4S2+7NHMKywv1YbT8opTwdatgbb2rJmM=;
        b=wHU34whALnBvZm+fGkt4RVEOcttX4YJXTa8pwRsSYJiah1gEQZOXfhlVI99dOlHbRM
         hrvu4sqBZ6v+DVnoPCHOcuUugFLIlk1uVk4EARrZRWO5Y8T+NF3Df9S8LR04DK59/YwC
         UBpf8RQzS30RftmdopH9sPOi9Cz9Hx+KZQv69dMpDxUgbemU7fSw25uysMGCkB/c6v+5
         OWYjJA5yPnauuxT9pTsvvSWB9IHXdYg3ky/TD3uZcWy1UQof3nimCFOj7G12Wm/ASAj7
         tjThqgNo48HKN7NY/xqpmwPGj+5Os9ngTqsd7umyJlMkdKxTBbzPxsrMyZYgVgoUri6R
         NS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jm6ME5Ke2ec4S2+7NHMKywv1YbT8opTwdatgbb2rJmM=;
        b=CjKPCgmMzBoKzv2iJolgoDGlQ+m+JlPLQ5DLIWDu8DrIJAtXjkxbLqXaQOzFMxNY1a
         7q5KL4ULhgyKH0wiOo7JZJ49IfZpGUF3qrQJ3NVYhu/gCV0znz9/ZoYCMMySsBB5MJF7
         N7Va1fbv+FiFBZ/tySTQV/snWsoXiz3WUEGD8VLgDk9PZhtFeS59aop82vOPlQThz/56
         WA6ZNCVG2lmVugCpV4Rd5V0DYLrnFrfpYwS5Cq8uVfY1qN3+Ckqicmurhi6JUlmqcybQ
         EvOZu8qNm+BbyiteyIVrYquUy/bM1UDG2PFCbD2Vu3IBYOf/J+nHCMUeB9yi2y4sCVmR
         lkHQ==
X-Gm-Message-State: AOAM5307GizLIUd/BcN+UG1Kf6MlcSPvVPhgzjhDq7szZQ+/c0o3zYCn
        +ghWO2HJ4Nd0Bs85dtmoR3Eha0ZBg03gBd6rMWy/Hw==
X-Google-Smtp-Source: ABdhPJwsUAPzSibKZBdxadwUsL2ZkAE/u7IQj26lhYC+gmkTcFSBdHPqe/IriSvQqkHdTlb9EmRdB4hDsvcZP1JzunM=
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr32952432edw.354.1615845617324;
 Mon, 15 Mar 2021 15:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
 <20210310180306.1588376-3-Jonathan.Cameron@huawei.com> <20210310181459.000005c7@huawei.com>
In-Reply-To: <20210310181459.000005c7@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Mar 2021 15:00:08 -0700
Message-ID: <CAPcyv4jq-KovQcEqesA=kCdzdDNtQ9y8g2aBCSXqQv7cvmABtg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 10, 2021 at 10:15 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 11 Mar 2021 02:03:06 +0800
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
> > This patch simply provides some debug print outs of the entries
> > at probe time + a sysfs binary attribute to allow dumping of the
> > whole table.
> >
> > Binary dumping is modelled on /sys/firmware/ACPI/tables/
> >
> > The ability to dump this table will be very useful for emulation of
> > real devices once they become available as QEMU CXL type 3 device
> > emulation will be able to load this file in.
> >
> > Open questions:
> > * No support here for table updates. Worth including these from the
> >   start, or leave that complexity for later?
> > * Worth logging the reported info for debug, or is the binary attribute
> >   sufficient?  Larger open question of whether to expose this info to
> >   userspace or not left for another day!
> > * Where to put the CDAT file?  Is it worth a subdirectory?
> > * What is maximum size of the SSLBIS entry - I haven't quite managed
> >   to figure that out and this is the record with largest size.
> >   We could support dynamic allocation of the record size, but it
> >   would add complexity that seems unnecessary.
> >   It would not be compliant with the specification for a type 3 memory
> >   device to report this record anyway so I'm not that worried about this
> >   for now.  It will become relevant once we have support for reading
> >   CDAT from CXL switches.
> > * cdat.h is formatted in a similar style to pci_regs.h on basis that
> >   it may well be helpful to share this header with userspace tools.
> > * Move the generic parts of this out to driver/cxl/cdat.c or leave that
> >   until we have other CXL drivers wishing to use this?
>
> Naturally I remembered another open question within 10 seconds of sending :(
>
>   * Do we want to add any sort of header to the RAW dump of CDAT to aid
>     tooling?  Whilst it looks a little like an ACPI table it doesn't have
>     a signature.
>
> My gut feeling is no, because the CDAT specification doesn't define one but
> I can see that it might be very convenient to have something that identified
> the data once it was put in a file.

I'm not yet convinced raw dumping is worth it for the same reason that
command payload logging was eliminated from the v5.12-rc1 submission.
There's not much userspace can do with the information besides debug
the kernel behavior. If the kernel assigns a numa node to target a
given CXL memory range with NUMA apis then HMEM_REPORTING should
enumerate the properties. In other words, don't expand the userspace
ABI problem, funnel users to the canonical source for such data.
