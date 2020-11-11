Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52992AF7DE
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 19:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKKS1y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKKS1x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2020 13:27:53 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C04C0613D4
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 10:27:52 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id i19so4051077ejx.9
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 10:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaIQwQ+15TEIyZyj8/aGmJs71bDkEvM66klWaC5vlLw=;
        b=cnRi1TRg7jw+Q2T7s80k8pjxHp2E5efgzbSibQo+wp0XYHn6gCIhi3vNHWCxptg9Nz
         jGfzwu0NWVsuKRnP9w2nD9AnEdmLkkVNSjB3vDpMYog/W0vHnXhUzJxwGm1XUaHJvDMt
         a6AhEicgbyD1kVVvpqKJc4wSVXrHptK1B3U8WBilNceCSKVEhKmNjkUak68xGcMmygjV
         9x3OdkxyOqZ5x4cTKB3QUXAn1XFPJaFLEg/1FRP021/QuMG89u9neAGRG5y0mAD9D2u9
         mId9w4sM6GZFqJHiK0BfdgPyAvkCWLFrxs9XhsRj4XNwSEXWnbFndg8+Yes9F0MqPbpZ
         3W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaIQwQ+15TEIyZyj8/aGmJs71bDkEvM66klWaC5vlLw=;
        b=ojWOYKG5DLaDk+jm7tETk2hKdfnOv4Ze738khRrTiFMQKIec2Ffs2opBoyB7273rU+
         X4o0t6GuMXGC+XTJphipJdHKTFlxJTuxRN2QHHTh/CxtyrjSRayg9CPpDPvNEWs/BXjC
         Uyvgcea37LW6WaYneo8ABJ6q7KnQOJ7chEJzND8NE65P4Cu18et9hO0OxIkLqhu94sTc
         f9IZ8mow0CwzwUC0ifiUJR9hv3UzIIt3VZo07UhXNtJOAo42Rsn0ymcXS03yPo6w1alw
         YYkd8F63pg05UvfI3Loa/It8Nnueh9phVGdtMpTIBUuqOi9bu+XHKqWz+S5OCFcNZaB8
         EwLQ==
X-Gm-Message-State: AOAM531+wlgcDcvCxfpG3NEAgeoIQAV1LsbS3T7NzI/zIRKdbBSycTqq
        NkXe3M2zbVB3eihGUGhrcDzpJ8Aqwt7xWN7UYY6r0Q==
X-Google-Smtp-Source: ABdhPJzROlVJ4lA34wzyb9HvHhqu0mRf5kwgVaNxyAE7k7nKG3aTa/QRqzTSgMFmoZ8jVa9/01KcLJhtrdpoiTDHIQg=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr26103639ejb.472.1605119270879;
 Wed, 11 Nov 2020 10:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com> <20201111071231.GC7829@infradead.org>
 <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
In-Reply-To: <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Nov 2020 10:27:38 -0800
Message-ID: <CAPcyv4g=pcai9FrKaGcAHtyfm=Lzzgh8xFyG6QLA4J6FPdy5yQ@mail.gmail.com>
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

On Wed, Nov 11, 2020 at 9:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > > +
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > > +             if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > > +                     return pos;
> > > +
> > > +             pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> >
> > Overly long lines again.
>
> I thought 100 is the new 80 these days?

Saw your clarification to Vishal, I had missed that. Will trim.
