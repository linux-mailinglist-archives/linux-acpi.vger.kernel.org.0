Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505CE456201
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhKRSNb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 13:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhKRSNa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 13:13:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E6C061574
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 10:10:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b68so6805892pfg.11
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 10:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q368l7fjeNqHP5ISVkbzG/vda0dVsxtnzUR8yuiy/Ak=;
        b=f+rCeIS9kQ5bKBONykSzHLuZIbUc0qMSKBmLcGjRW8omFAyNmhmJhPMwe9tFryhLH0
         TnU8PQP2Ogng+LkHYZweg9GV9e6g7qmDf6UxNLfkSzGdpp7rdr1lJ0ObY7gJ0WVNjAtZ
         HsUYSn6Xf6v4QyGqCJcD6RUfzZbjHCekRA9Qn/12+e1Pdrt3kvsiqKiUztBgqXmRaIoo
         2LHQ5Q4VZayn5VJzfx3dmxoQhhjg8zHnrWXvatkaDyuU9Wrl/pOlGci/AsP4FNxLsj8Y
         7mhNzaD+ViInREQSDGypZTBVTKC4WBBjTMx4K725datUacGnFNy5fAJyTH3u6sSg34D1
         jaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q368l7fjeNqHP5ISVkbzG/vda0dVsxtnzUR8yuiy/Ak=;
        b=06zezTilBYOVJApyXtAnwm3fH7xBcMAPAXBRnr+4En67EsIVKuwSMW1ePhdU8nJ24f
         9kF7gk0ow7GSiCDE8Z62PVv+rZaRYOKOvsal6v86oXAreELYqhTcGVBqLnMkBktF3gcM
         zWUSiicWBCfvs7g669bRbJci4N3yatTpX397pOPx9jqpUJxnTkMWLzzEHQdwV/g7UPOq
         TddyyvugyCPjOBPRhejpqaLdzcicb2hJpY/M8FEeF4tPZB9cjft90GRz6q1+/gmE0k9d
         SYz1jpN0wn3q232yVf+MPf4ixI3kFGNAK02QxOrDrjvEDGE6/uCHwI0YJ+uiWLWb9UFr
         YaLQ==
X-Gm-Message-State: AOAM531snpKG4uCqqlUN1aR4A6yb4GuQ7G9w3Wg6AgDixYf6vOhAFMn6
        OyD8o9s2zpUkUN+7B88ifdKBUUKq1fqKbI3M+XC3Vw==
X-Google-Smtp-Source: ABdhPJz40g8D4HY5/feziv/1ex5AJrWp0f66zO2Azm6FUnxuh2JbwrqtmGkIgKaMyiZzuKxF2/Q4M6xJm7eUwH9Rr7E=
X-Received: by 2002:a63:6302:: with SMTP id x2mr12817331pgb.5.1637259029761;
 Thu, 18 Nov 2021 10:10:29 -0800 (PST)
MIME-Version: 1.0
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163553711933.2509508.2203471175679990.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211118131218.00005645@Huawei.com> <CAPcyv4j9fpKVjJ3as0jVLEDouUF1ai0iOknuGSx_r9B6E2KGzw@mail.gmail.com>
 <20211118175343.00006526@Huawei.com>
In-Reply-To: <20211118175343.00006526@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Nov 2021 10:10:18 -0800
Message-ID: <CAPcyv4hbYSk1p=_Wtvw-U6TPaAaxusb=cBYvzQDuFzT=5yaOeQ@mail.gmail.com>
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

On Thu, Nov 18, 2021 at 9:54 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 18 Nov 2021 09:14:07 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Thu, Nov 18, 2021 at 5:12 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 29 Oct 2021 12:51:59 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > >
> > > > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > > > subtable may be assigned to a NUMA node. Since there is no
> > > > requirement that the SRAT be comprehensive for CXL memory another
> > > > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > > > in the SRAT.
> > > >
> > > > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> > > > Early Discovery Table (CEDT) to find all CXL memory ranges.
> > > > Create a NUMA node for each CFMWS that is not already assigned to
> > > > a NUMA node. Add a memblk attaching its host physical address
> > > > range to the node.
> > > >
> > > > Note that these ranges may not actually map any memory at boot time.
> > > > They may describe persistent capacity or may be present to enable
> > > > hot-plug.
> > > >
> > > > Consumers can use phys_to_target_node() to discover the NUMA node.
> > > >
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Hi,
> > >
> > > I was just discussing this with one of our firmware / ACPI experts and he asked
> > > an interesting question.   If you want to have CFMWS regions correspond to
> > > new NUMA nodes, why not put them in SRAT as hotpluggable memory, but have none
> > > present in the memory map (whichever route you use to get that)?
> > > We do this for normal memory hotplug as (via the other discussion on qemu virtio-mem
> > > nodes) apparently does qemu.
> > >
> > > https://lore.kernel.org/all/655c65af-fd7a-8007-37b3-a56c60a0ec5b@redhat.com/
> > >
> > > This doesn't solve the question of whether we have enough nodes, but it's
> > > not worse than if we use CFMWS regions and fits within existing ACPI spec.
> > >
> > > The only reason I can immediately think of to not do this, is that it might be
> > > a pain to later change over to dynamic numa node allocation in a fashion that
> > > then ignores SRAT entries.  Probably a solvable problem.
> >
> > Interesting, yes, that works for expanding the NUMA node number space.
> > However, if you populate SRAT what do you put in the corresponding
> > HMAT entries? In the case of dynamic CXL regions the driver is going
> > to generate the equivalent of the corresponding HMAT data based on
> > what devices it decides to place in that range. I actually do not know
> > what happens with HMAT today for memory hotplug, but I suspect there
> > are less degrees of freedom of what might populate those ranges than
> > what CXL allows, and there is a chance to pre-populate the HMAT for
> > future hotplug.
>
> So... There are two answers to that question as I understand it.
>
> 1) What Linux does is nothing.  You get whatever was in HMAT to start with.
>    Worth noting that HMAT doesn't need to be in any sense 'complete' so it
>    is possible there was nothing there with a target in this NUMA node.
>
> 2) What ACPI intends to happen if anyone implements it.  There is an event
> notification for this..
>
> "Heterogeneous Memory Attributes Update. Dynamic reconfiguration of
> the system may cause existing latency, bandwidth or memory side caching
> attribute to change. The platform software issues the Heterogeneous
> Memory Attributes Update notification to a point on a device tree to
> indicate to OSPM that it needs to invoke the _HMA objects associated
> with the Heterogeneous Memory Attributes on the device tree starting
> from the point notified."
>
> So call an AML method in DSDT for which ever device has a notification event.
> A similar dance is actually implemented for NFIT updates and Linux
> actually implements that handling for that one.

Oh, yes, I know I helped implement it, and I think it is objectively a
terrible interface because you have no idea what changed or is allowed
to change. _HMA is slightly less problematic because it can't invent
new ranges, but I have low expectations that the BIOS would be able to
coordinate properly with the OS that has done the dynamic
re-configuration of the CXL topology. The OS could tell the BIOS what
to put in the HMAT, but might as well skip that step and just have the
OS populate its parsed copy of the HMAT data. I like your "just don't
publish HMAT for entries for these ranges" observation better.
