Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379CD456138
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhKRRRW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhKRRRT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 12:17:19 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2BC06173E
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 09:14:19 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so6670533pfe.7
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ezy3R/Faw5RWcB1gHJ2mcr71Y9EH1+NI+yh4ga9QoAc=;
        b=cdn+vejRX98o8Ni8P6sqrArWQuHCBh7swKk8I4vLdzioRLIo+OZnlAmAUIAE4IMYVi
         rfHoNTGEUOEUfBuGCIjObCcqoTKX/xSiz0JGpm4P/wx1nrKlcxz8OFQ5kMl1u+l9APev
         tkRqnivZUE6kB//+qW8PUoxjURh1yYAZRPvN02bdzzND9MiZJ2ft/YLhDNrgwPRMqo9H
         ANiu01pXBou0YJEi56d4Ah/KqScZcpPqNpRISRS+PVLELfP3SY8J29yV2v19cEafxUUa
         44kjEs9Q81W0jAHYYGeAnvdBI5Tji2MDmOZp535JF7d4YmbRQapgT3QP970/dbMKN3T6
         mn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ezy3R/Faw5RWcB1gHJ2mcr71Y9EH1+NI+yh4ga9QoAc=;
        b=PccZbhlGDYDc9/e9+NTwO1VjtAgZeE1BtcupYK8lQdwzs8cOWXUgBg0MImKWUKeVPE
         Wcsh7KQIwl0LNEcrO43Aaf3BKsf2SSBmW44k1gb/CPByR1mBGBTW97mZiKE3dHe5ZwQ9
         OMKKKd7kJYAfMxxdzcmqXMHJN92arbWk797tibT/D8KT9P97MO6oX2ZL7xEBMEpTqzKo
         Squzxq481mpOHuo5TPu67KeQJJFaOliiUrb6tGaF3yIVf4jNOwYEVMgqJf3jyT1VFg+/
         GaavFU8uovBbnS5EmzArTxNnUNMTCxW6PajGxwefbxRNaLuaR0L64xyLtpFEEgmH0cX+
         xh8Q==
X-Gm-Message-State: AOAM532EJOeiQvqaUFCZjhEdXBVHM59SFT5NQcIz9QU0YfcGiSThhV8N
        4t663cNpWt4xFiTe37QbOaKTxvpPcf4mvyloEq73+A==
X-Google-Smtp-Source: ABdhPJymKkxPemnH4DGQVIEcjy4h36xxBmuk5nAk5K2TRr0nKxBZYeDP5hVqF+E2+OHbaESL8X1yJpg+p9F9bRdApiQ=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr12117881pgd.377.1637255658534;
 Thu, 18 Nov 2021 09:14:18 -0800 (PST)
MIME-Version: 1.0
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163553711933.2509508.2203471175679990.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211118131218.00005645@Huawei.com>
In-Reply-To: <20211118131218.00005645@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Nov 2021 09:14:07 -0800
Message-ID: <CAPcyv4j9fpKVjJ3as0jVLEDouUF1ai0iOknuGSx_r9B6E2KGzw@mail.gmail.com>
Subject: Re: [PATCH 6/6] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 5:12 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 29 Oct 2021 12:51:59 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > subtable may be assigned to a NUMA node. Since there is no
> > requirement that the SRAT be comprehensive for CXL memory another
> > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > in the SRAT.
> >
> > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> > Early Discovery Table (CEDT) to find all CXL memory ranges.
> > Create a NUMA node for each CFMWS that is not already assigned to
> > a NUMA node. Add a memblk attaching its host physical address
> > range to the node.
> >
> > Note that these ranges may not actually map any memory at boot time.
> > They may describe persistent capacity or may be present to enable
> > hot-plug.
> >
> > Consumers can use phys_to_target_node() to discover the NUMA node.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Hi,
>
> I was just discussing this with one of our firmware / ACPI experts and he asked
> an interesting question.   If you want to have CFMWS regions correspond to
> new NUMA nodes, why not put them in SRAT as hotpluggable memory, but have none
> present in the memory map (whichever route you use to get that)?
> We do this for normal memory hotplug as (via the other discussion on qemu virtio-mem
> nodes) apparently does qemu.
>
> https://lore.kernel.org/all/655c65af-fd7a-8007-37b3-a56c60a0ec5b@redhat.com/
>
> This doesn't solve the question of whether we have enough nodes, but it's
> not worse than if we use CFMWS regions and fits within existing ACPI spec.
>
> The only reason I can immediately think of to not do this, is that it might be
> a pain to later change over to dynamic numa node allocation in a fashion that
> then ignores SRAT entries.  Probably a solvable problem.

Interesting, yes, that works for expanding the NUMA node number space.
However, if you populate SRAT what do you put in the corresponding
HMAT entries? In the case of dynamic CXL regions the driver is going
to generate the equivalent of the corresponding HMAT data based on
what devices it decides to place in that range. I actually do not know
what happens with HMAT today for memory hotplug, but I suspect there
are less degrees of freedom of what might populate those ranges than
what CXL allows, and there is a chance to pre-populate the HMAT for
future hotplug.

All that said, if an ACPI platform did do that population it would not
collide with the scheme proposed in this patch because this is
checking SRAT for the range before padding the proximity domain number
space for CFMWS entries.
