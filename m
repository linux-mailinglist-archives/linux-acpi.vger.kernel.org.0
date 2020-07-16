Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E12227F2
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jul 2020 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgGPQBB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jul 2020 12:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPQBA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2020 12:01:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521EC061755
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2020 09:01:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so7082139ejc.8
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yV3LwwP/SEpzaIEmeMBzbOghkFrbv+sk/VN9onw9N4c=;
        b=PmM7BFqw2PSR4FOOXVxXhA2f6W9m437kj4FNos9CDP3AJplZthVDkyvWlsqXdsVzAW
         IM0jY8Aj2cjRUyQ5//pe2xP0Djmun92aIvQU+RkGKuprB7WpZ6t9y8XW97H8aPkZsSws
         LauGKXBWtxn+z294PiF58zpqTAMdaJnRkNRZDJaoBHdyv0iIexU9jpq+lDfX70zSDlM/
         uuwpQMBzj+gyc/2Gi9ptBI+nur9z9JdfUf8q8QbPcre4pqAcb3Yf2Q8Tt35VJ37cGQ76
         IoN3YCs7xA0vUYw1/o3x6BLHfCW/Hf3I81JzZNOwPjM+60sb/ZQZu+tFvmc25pLG3/oe
         slkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yV3LwwP/SEpzaIEmeMBzbOghkFrbv+sk/VN9onw9N4c=;
        b=BBEr5lcZvh6mVCW5DUQ8BSYv6R/B/vRO2R6ByzAJjJuFuYGPR+RPkdeEfUXdPLgVIU
         Pv8vRUpAgnda0G7l4G+ADs4OAGb1Z9JyBjL6Uox9Uwm0RJJnwOovqxVv8hQMt0kHYKVQ
         t6XVPjZiyK0QEjYxNs8quudrd2Zdws1Cm2lNXjJZ1J6BR9uFQtxDIh4m3XabePUIbvxZ
         yR018c/sYvkqZW0ffaMu2dMQJb9C6BgD+onUe4Uwx9jE4XKuDqUc824WHj05BMmUzy9Q
         hPRj/fRnGVVzYr3FZMuZmVee+cJQzN5JuGc5yTtbRecIL/lkapCIdP+l2ZYuD7bDLMM7
         8x9A==
X-Gm-Message-State: AOAM53003jrRr0iZtLudCExO+JTobTfrgYeis97N3b/pminqp/Ly7D5I
        mpSMfZsS42YhqOm3a6LHo9Fkt+fQaI1SsT94/fSqmA==
X-Google-Smtp-Source: ABdhPJw6daMW61UwPNGt9t0xFJ7BOFzJkc2Eqyf8Rfj0dreUEGgSjFtNL4bh/7oZZRDtti8BDS586JUwVYpyjV4FRCo=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr4585391ejt.440.1594915258725;
 Thu, 16 Jul 2020 09:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457128462.754248.10443613927921016089.stgit@dwillia2-desk3.amr.corp.intel.com>
 <7ecd1b82-06ab-be49-4b92-ac42caab146c@oracle.com>
In-Reply-To: <7ecd1b82-06ab-be49-4b92-ac42caab146c@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Jul 2020 09:00:47 -0700
Message-ID: <CAPcyv4hFS7JS9s7cUY=2Ru2kUTRsesxwX1PGnnc_tudJjoDUGw@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] device-dax: Introduce 'mapping' devices
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 16, 2020 at 6:19 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 7/12/20 5:28 PM, Dan Williams wrote:
> > In support of interrogating the physical address layout of a device with
> > dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
> > and 'page_offset' attributes. The alternative is trying to parse
> > /proc/iomem, and that file will not reflect the extent layout until the
> > device is enabled.
> >
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/bus.c         |  191 +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/dax/dax-private.h |   14 +++
> >  2 files changed, 203 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index f342e36c69a1..8b6c4ddc5f42 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -579,6 +579,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
> >  }
> >  EXPORT_SYMBOL_GPL(alloc_dax_region);
> >
> > +static void dax_mapping_release(struct device *dev)
> > +{
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +
> > +     ida_free(&dev_dax->ida, mapping->id);
> > +     kfree(mapping);
> > +}
> > +
> > +static void unregister_dax_mapping(void *data)
> > +{
> > +     struct device *dev = data;
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +     struct dax_region *dax_region = dev_dax->region;
> > +
> > +     dev_dbg(dev, "%s\n", __func__);
> > +
> > +     device_lock_assert(dax_region->dev);
> > +
> > +     dev_dax->ranges[mapping->range_id].mapping = NULL;
> > +     mapping->range_id = -1;
> > +
> > +     device_del(dev);
> > +     put_device(dev);
> > +}
> > +
> > +static struct dev_dax_range *get_dax_range(struct device *dev)
> > +{
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +     struct dax_region *dax_region = dev_dax->region;
> > +
> > +     device_lock(dax_region->dev);
> > +     if (mapping->range_id < 1) {
>             ^^^^^^^^^^^^^^^^^^^^^ it's 'mapping->range_id < 0'
>
> Otherwise 'mapping0' sysfs entries won't work.
> Disabled ranges use id -1.

Whoops, yes. Needs a unit test.
