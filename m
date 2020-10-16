Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF728FEA9
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 08:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394502AbgJPG41 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 02:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394370AbgJPG41 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 02:56:27 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6528A20878;
        Fri, 16 Oct 2020 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602831386;
        bh=Qt5cK4GbMy1zYjzp9yoahcnNoGCra0PWF0mygx/BzDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kW25M9o0mHtPxHMea8yV80oWEA7vsMtr2BnXS+nM5/3MQhqUaPvN+MhMXTh+FopX7
         uX5bRbMj4YsNF7JnVpLGJ8bkygcEu+ZEiqZ/YvRS766TMA7DF9cF/fcUls1f6GBkDC
         KZugE4D2A0tX8R0wG7oMBjzYLxgCNaiu0dmN+tRI=
Received: by mail-oi1-f181.google.com with SMTP id 16so1304914oix.9;
        Thu, 15 Oct 2020 23:56:26 -0700 (PDT)
X-Gm-Message-State: AOAM531HCuQEnna6iOxKGOyB3vnnPvZ0yNCKizN5R3cmxlOivjNic3jN
        6A2xymeivDxvxmdva287P2YvJNCmV9NpU6zqybs=
X-Google-Smtp-Source: ABdhPJz06rV6WAWm42aN14z1C+ajNWUQE5kD2qLfjxAdRc9MpB29T/PNIdoPGp5uO2oI3ZIgGfWCv7Dbtg/8qUfzXjc=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr1596675oig.174.1602831385656;
 Thu, 15 Oct 2020 23:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de> <20201015103106.GA24739@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201015103106.GA24739@e121166-lin.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Oct 2020 08:56:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGRcP_8OMHAdjTLNod40N_8dzqrX9=F+s7pd0EXy8O6DQ@mail.gmail.com>
Message-ID: <CAMj1kXGRcP_8OMHAdjTLNod40N_8dzqrX9=F+s7pd0EXy8O6DQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT scan
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 15 Oct 2020 at 12:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Oct 14, 2020 at 09:12:09PM +0200, Nicolas Saenz Julienne wrote:
>
> [...]
>
> > +unsigned int __init acpi_iort_get_zone_dma_size(void)
> > +{
> > +     struct acpi_table_iort *iort;
> > +     struct acpi_iort_node *node, *end;
> > +     acpi_status status;
> > +     u8 limit = 32;
> > +     int i;
> > +
> > +     if (acpi_disabled)
> > +             return limit;
> > +
> > +     status = acpi_get_table(ACPI_SIG_IORT, 0,
> > +                             (struct acpi_table_header **)&iort);
> > +     if (ACPI_FAILURE(status))
> > +             return limit;
> > +
> > +     node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
> > +     end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
> > +
> > +     for (i = 0; i < iort->node_count; i++) {
> > +             if (node >= end)
> > +                     break;
> > +
> > +             switch (node->type) {
> > +                     struct acpi_iort_named_component *ncomp;
> > +                     struct acpi_iort_root_complex *rc;
> > +
> > +             case ACPI_IORT_NODE_NAMED_COMPONENT:
> > +                     ncomp = (struct acpi_iort_named_component *)node->node_data;
> > +                     if (ncomp->memory_address_limit)
> > +                             limit = min(limit, ncomp->memory_address_limit);
> > +                     break;
> > +
> > +             case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> > +                     rc = (struct acpi_iort_root_complex *)node->node_data;
> > +                     if (rc->memory_address_limit)
>
> You need to add a node revision check here, see rc_dma_get_range() in
> drivers/acpi/arm64/iort.c, otherwise we may be reading junk data
> in older IORT tables - acpica structures are always referring to the
> latest specs.
>

Indeed - apologies for not mentioning that when handing over the patch.

Also, we could use min_not_zero() here instead of the if ()
