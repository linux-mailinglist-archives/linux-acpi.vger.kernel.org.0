Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4483A18F2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFIPRt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFIPRs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 11:17:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DCC06175F
        for <linux-acpi@vger.kernel.org>; Wed,  9 Jun 2021 08:15:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e22so19706390pgv.10
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEXfhkKVesgl6rTue33hw4E6sTEKyZJepGu+zWkT2iU=;
        b=BJWfG2wc6L609hn4iK5PVJ6q7CCJdQ15qzZjlc8msYNL8f6Cm6/ZNEG0Nlf6w8xGAt
         mV47DsmF3QozhtMPibLGcn/GN3Wf5XBQcw2o+HCKPKXYFlFAGAFC4sfS8/X8kFx3GtAV
         G3P4hE5yTwbkahUUtAflgPp7IKR2eUsUmiXD/8wm3nbvvgW0TJD9ymcxIYAYu6ZLICo9
         SQdRbDGxEu/8wkxf/g4LbG6S4cY+hyAAw2WZEhMKhjXpQc8LBj3g3tEDK8U1SoKmhlIo
         5v4v1g48mkRKas3vujw+pDX29QueVhzvJZ+2j2mqQT1gcVyD1No/YGVjYnMbCUQhr0Qn
         TwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEXfhkKVesgl6rTue33hw4E6sTEKyZJepGu+zWkT2iU=;
        b=qpOQxoQ4sd7M2DhAxnK0JKYb0GKgck4rxKh30j/h+ch5Z2t9VvrKEEvJcQ3wBkCikz
         MduHqHzDfnhh+t6BvIEzPgOn/4GB2TtHdVuE0wH+5v/rEn/J1lGhqbxGAcjQndm8YikE
         2OZO8eg8LZrT1WSIhewQ8umAVRbxEJv0zSlGM1zLF/2ZX3MK4t2oCdNhh0yXN29KChhG
         7dTsG1JmX7hXpiORnOXghTUP7DExhMtR+SR/Bi/jn+OGC+Xi06ziX7/wNY3LOXrZgJJ7
         VsTeOF7PMrisTEpHv3rSyJyUKEH+PhCl+8lBXqRcpOlijmS+9h5onEi6mvokNnyxkutr
         7rQQ==
X-Gm-Message-State: AOAM531e18j+U5lAKqd1/jKXSSpg23RUr/th1imwQOxA4f9XKiv9Mfdh
        LieJUpyVeGgjZ7IgxlWLMC56MemSPxl+c/KMz6EzVQ==
X-Google-Smtp-Source: ABdhPJz7D5POILkdNfndhQKsZ7TKN7wCSaLY+EAtSIjbThxEZlR34xGyi0vEnTc53yaXD5O4gl5dAZbK/xKG21SV950=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr170203pgm.279.1623251753728;
 Wed, 09 Jun 2021 08:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295951736.1109360.12642726343803988356.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210608124910.0000329e@Huawei.com> <CAPcyv4jc07GuoOu8HPwVucj7PcdNjLjE1ScwRBDTyQ788Ot4tw@mail.gmail.com>
 <20210609122814.00005ed1@Huawei.com>
In-Reply-To: <20210609122814.00005ed1@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 08:15:42 -0700
Message-ID: <CAPcyv4i9Xv1MceTDzo-9XF70MSWi5FKzw8c56-SFYe55=83p1Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] cxl/acpi: Add downstream port data to cxl_port instances
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 9, 2021 at 4:28 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> > > This is a bit inconsistent wrt to what functions get full kernel-doc.
> > > My personal preference would be all the exported functions + any others
> > > where it is particularly useful.
> >
> > I agree with the sentiment for globally exported symbols. In this case
> > they are in the "CXL" module namespace and privately defined in
> > drivers/cxl/ headers. That said, I did document devm_add_cxl_port(),
> > so there's no good reason to skip the documentation on the other
> > devm_cxl_add_* routines... will fix.
>
> Maybe we should consider using symbol namespaces for CXL?
> EXPORT_SYMBOL_NS_GPL() etc

In fact, we already are using that, it's just implicit from the
Makefile with this line:

ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL

> > > > + * Append downstream port data to a cxl_port, note that all allocations
> > > > + * and links are undone by cxl_port deletion and release.
> > > > + */
> > > > +int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> > > > +               resource_size_t component_reg_phys)
> > > > +{
> > > > +     char link_name[CXL_TARGET_STRLEN];
> > > > +     struct cxl_dport *dport;
> > > > +     int rc;
> > > > +
> > > > +     if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> > > > +         CXL_TARGET_STRLEN)
> > > > +             return -EINVAL;
> > > > +
> > > > +     dport = kzalloc(sizeof(*dport), GFP_KERNEL);
> > > > +     if (!dport)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     INIT_LIST_HEAD(&dport->list);
> > > > +     dport->dport = get_device(dport_dev);
> > > > +     dport->port_id = port_id;
> > > > +     dport->component_reg_phys = component_reg_phys;
> > > > +     dport->port = port;
> > > > +
> > > > +     rc = add_dport(port, dport);
> > > > +     if (rc)
> > >
> > > If you get an error here, it's not been added to the list, but
> > > in the cxl_dport_release() you remove it from the list. I think you
> > > just want to put and free the device here.
> >
> > The delete is innocuous because of the INIT_LIST_HEAD() above. So the
> > delete will end up doing the right thing and leaving the entry empty
> > again, and that saves the need for custom code to handle that case.
>
> Ah fair enough. I'd missed that INIT.  Not sure I'm keen on that
> approach as it's not in the 'obviously correct' category but it's your
> code to maintain so I'm not that fussed.

I think it's in a similar spirit to devm and the lack of
ida_destroy(), try not to write unwind code if at all possible...
