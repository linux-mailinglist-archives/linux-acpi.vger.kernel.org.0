Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C112AF743
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 18:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgKKRRu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 12:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKRRu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2020 12:17:50 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172BAC0613D6
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 09:17:50 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id v4so3133866edi.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 09:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQoq2RQCuafra2/12uiljwu+rCNgXWp3T6t2+sz8FTY=;
        b=1DH8VH1JKBZbEDlGbtroiVXOVC0/URrnHQ4E8/tzT86j+/9Tva1H6wuleBdwke7NC0
         OtOJ5SRmQEMcfqXHix2vJ5Kn8HKTL1/oLfya12FbOsO3FsuLYwnjILQiqYj0mmVqQmXe
         Cuzt9YWBUz/3UdIPnqCEFjRKthmWHf8atJVS3KK4AVkpnTPVBpBpbAZHnG8I43hcBvXW
         Dk0rimoptgAKqXt+ANHhaSihWslTP3l33/U4JZ+UD25Y7G9behZfPGt1U9buudqH9QV0
         03q5re0g52eZpMu1pz1uDdM8rCL00SnesUh0Gsb1iRIs7nPiQag7jBP9pfO1pyFr2IEo
         Ll0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQoq2RQCuafra2/12uiljwu+rCNgXWp3T6t2+sz8FTY=;
        b=mwAlGyWFRPW3CQAR3DRzwrXb2jN67AZdd8AQzkbD5uNUdIURX3bZ36knv3JZJeg0od
         BQSjW4krO37gkwD0+sTtV8mchWrnGRu4akS+dIUD1mGW/mNe6+O1H+GM29WyXft0MAWi
         MuxLz9RfRbWPxc5lhKA0cRWHHKkxCgTT2glnIZISl8FGt9HEZgbRCPgoXCXgx6eViDg4
         rUUejqqpEnY0pQluKV0p5KNPFFFvuqeSBTenV3NvWl6pgfCGDAxsIxYB9R/t0yTkiOE9
         dN41Z+3kmJe0B/p3EcZ15k4pjyXP+w0qfSGCeM+JAd24H3lokACfqbdPlRicAYH5Ynqf
         cm5w==
X-Gm-Message-State: AOAM532TE5LF9FdRUMDpKSRCuQu4X1ToRSogvDJ7E+es/rNgoMMhIuU5
        aBKbEmuQVGBNXpy/aaWdzOVG8N25AjAbAjJxJ3LifaheXec=
X-Google-Smtp-Source: ABdhPJwTwbtangRhABKsob3Xr0CrmoBXrd71z27l2ZDvApiVBFS1mPJU50IdPt5HUcdZ+QRQ7ssj77pEMJ8fTBox2mA=
X-Received: by 2002:aa7:ca44:: with SMTP id j4mr511437edt.354.1605115068596;
 Wed, 11 Nov 2020 09:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com> <20201111071231.GC7829@infradead.org>
In-Reply-To: <20201111071231.GC7829@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Nov 2020 09:17:37 -0800
Message-ID: <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 11:12 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 10, 2020 at 09:43:50PM -0800, Ben Widawsky wrote:
> > +config CXL_MEM
> > +        tristate "CXL.mem Device Support"
> > +        depends on PCI && CXL_BUS_PROVIDER != n
>
> depend on PCI && CXL_BUS_PROVIDER
>
> > +        default m if CXL_BUS_PROVIDER
>
> Please don't set weird defaults for new code.  Especially not default
> to module crap like this.

This goes back to what people like Dave C. asked for LIBNVDIMM / DAX,
a way to blanket turn on a subsystem without needing to go hunt down
individual configs. All of CXL is "default n", but if someone turns on
a piece of it they get all of it by default. The user can then opt-out
on pieces after that first opt-in. If there's a better way to turn on
suggested configs I'm open to switch to that style. As for the
"default m" I was worried that it would be "default y" without the
specificity, but I did not test that... will check. There have been
times when I wished that distros defaulted bleeding edge new enabling
to 'm' and putting that default in the Kconfig maybe saves me from
needing to file individual config changes to distros after the fact.

>
> > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
>
> Please don't use '//' for anything but the SPDX header.

Ok, I find // following by /* */ a bit ugly, but I don't care enough to fight.

>
> > +
> > +             pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > +             pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > +             if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > +                     return pos;
> > +
> > +             pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
>
> Overly long lines again.

I thought 100 is the new 80 these days?

> > +static void cxl_mem_remove(struct pci_dev *pdev)
> > +{
> > +}
>
> No need for the empty remove callback.

True, will fix.

>
> > +MODULE_AUTHOR("Intel Corporation");
>
> A module author is not a company.

At least I don't have a copyright assignment clause, I don't agree
with the vanity of listing multiple people here especially when
MAINTAINERS has the contact info, and I don't want to maintain a list
as people do drive-by contributions and we need to figure out at what
level of contribution mandates a new MODULE_AUTHOR line. Now, that
said I would be ok to duplicate the MAINTAINERS as MODULE_AUTHOR
lines, but I otherwise expect MAINTAINERS is the central source for
module contact info.
