Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00C21DB43
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgGMQJb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMQJb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2020 12:09:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE45C061794
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 09:09:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so14139127edr.5
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPX1344KqFXDG152MSs7m1f71nuvQxMI0VbbfK01bWI=;
        b=r7ELJ2cBdTaQzo9pqUPojaVz6tHhKqoH2KZY2zuAlJN0hbnOqbT4c12Oy38pcBR/Nj
         utOjvomkH01KnV48ustA657XHya8dxhiC4zKoTXDfmRE5M9q3CaTL/2f1Ttg6runvIq7
         RWnzutbQaMQZuQkbRYM6KLs9dYVs2pWP8m2YSi7TYPnwA2kYkHbV3zTVnZD3+aGspwQv
         visTBbIeQ8KXGdQAzK/GZmGnfQOSTPpyx1Y/65IykomzQzj2jp7TFsb05AzbD0WDujBa
         O7/7Q4OI36y4JCe9b58Hkm5W/23aJBSWmta1Co+BkMqTd+7t5uECfERRweordez+CtHr
         OHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPX1344KqFXDG152MSs7m1f71nuvQxMI0VbbfK01bWI=;
        b=mZnYcOZQHcqd9kO42bD2j/fe/3NmQxBBE4Vpsy5z6EAu/+cbcRqX1IxIK6eUFFhILN
         vo65Rc0c5Da0M6lpnFzzX8hwj9PookV+VkWujGPjcPqxWlZP4HLR4rJ5Bm9N5yNOqUZM
         sEdVX61IwqG85sBqDYV3MnujT0PLp0gKnXVpFAuQW+oRX/LyEm6rFdpSlhm3fqnmWpyx
         eR3CYZZeKWECAByINAEjYeEtfx2w2eCRn2rgPUewWfXdeEDwyYAgL9YdK4FgZAWDVDg8
         e6TezPtpdoKgM5sQ+vj0c/dnmJFstvYC9gnho5tnAMqC/Nmae5fu4XIXKZrG8M5TZpKY
         2wWQ==
X-Gm-Message-State: AOAM5338bD9O/o8vqyIwi6z0bm+/gYwdd2T/BOItptxbN5CG8vDbyDwC
        6aospAQds/Mze4JYT3sT5e40cALqFc1rTCztDuLg1A==
X-Google-Smtp-Source: ABdhPJzkfFp48TgN6o9u+tichXDgD3w2nI1pgUIrildgifHznsxd6AynKdQoAl6SqJnCRUpI/mZg24+ERLg8WLos9MU=
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr95726edr.383.1594656569387;
 Mon, 13 Jul 2020 09:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com> <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
 <20200713155222.GB267581@kroah.com>
In-Reply-To: <20200713155222.GB267581@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 09:09:18 -0700
Message-ID: <CAPcyv4ijb3nS3WuO38Yn3epBec8uQqw+UfimqFByqRT9QXCpLw@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 13, 2020 at 8:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 13, 2020 at 08:39:43AM -0700, Dan Williams wrote:
> > On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > > > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > > > sysfs input string that might contain a trailing newline.
> > > >
> > > > The other "device by name" interfaces,
> > > > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > > > strings.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/base/core.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 67d39a90b45c..5d31b962c898 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> > > >
> > > >       klist_iter_init(&parent->p->klist_children, &i);
> > > >       while ((child = next_device(&i)))
> > > > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > > > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
> > >
> > > Who wants to call this function with a name passed from userspace?
> > >
> > > Not objecting to it, just curious...
> > >
> >
> > The series that incorporates this patch adds a partitioning mechanism
> > to "device-dax region" devices with an:
> >     "echo 1 > regionX/create" to create a new partition / sub-instance
> > of a region, and...
> >     "echo $devname > regionX/delete" to delete. Where $devname is
> > searched in the child devices of regionX to trigger device_del().
>
> Shouldn't that be done in configfs, not sysfs?

I see configfs as an awkward fit for this situation. configfs wants to
software define kernel objects whereas this facility wants to augment
existing kernel enumerated device objects. The region device is
created by firmware policy and is optionally partitioned, configfs
objects don't exist at all until created. So for this I see sysfs +
'scheme to trigger child device creation' as just enough mechanism
that does not warrant full blown configfs.

I believe it was debates like this [1] that have led me to the camp of
sysfs being capable of some device creation dynamism and leave
configfs for purely software constructed objects.

[1]: https://lore.kernel.org/lkml/17377.42813.479466.690408@cse.unsw.edu.au/

> > This arrangement avoids one of the design mistakes of libnvdimm which
> > uses a sysfs attribute of the device to delete itself. Parent-device
> > triggered deletion rather than self-deletion avoids those locking
> > entanglements.
>
> Ugh, yeah, getting rid of that would be great, it's a mess.  I think
> scsi still does that :(

Yeah, both nvdimm and scsi both end up need to delay device deletion
to its own thread, and it has led to bugs in the nvdimm case.
