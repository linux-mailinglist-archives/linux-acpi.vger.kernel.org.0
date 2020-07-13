Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA821DB56
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgGMQMw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 12:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMQMv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jul 2020 12:12:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E70420738;
        Mon, 13 Jul 2020 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594656771;
        bh=VlAjnpp6Rq3jEDIk5j3UJZnZRDKR7KG+uZq+CX6PEn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C79mtxlSvr92vC6lazskxG3NC8/ahhjh74xdQnppAPRU4U2pvZQ2jhSQ2Vh/eIWHn
         jF5G1YghWoHVa49GprTKDkdBeW+x2+bvmADLJ62J1RgDU05L6/kd1LSx8dwxJhH+/A
         fiRYraviQQo3OkKnLKMNkK1fBrovrdrxo+BWoLi4=
Date:   Mon, 13 Jul 2020 18:12:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
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
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
Message-ID: <20200713161251.GA366826@kroah.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com>
 <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
 <20200713155222.GB267581@kroah.com>
 <CAPcyv4ijb3nS3WuO38Yn3epBec8uQqw+UfimqFByqRT9QXCpLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ijb3nS3WuO38Yn3epBec8uQqw+UfimqFByqRT9QXCpLw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 13, 2020 at 09:09:18AM -0700, Dan Williams wrote:
> On Mon, Jul 13, 2020 at 8:52 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 13, 2020 at 08:39:43AM -0700, Dan Williams wrote:
> > > On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > > > > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > > > > sysfs input string that might contain a trailing newline.
> > > > >
> > > > > The other "device by name" interfaces,
> > > > > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > > > > strings.
> > > > >
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > > ---
> > > > >  drivers/base/core.c |    2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > index 67d39a90b45c..5d31b962c898 100644
> > > > > --- a/drivers/base/core.c
> > > > > +++ b/drivers/base/core.c
> > > > > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> > > > >
> > > > >       klist_iter_init(&parent->p->klist_children, &i);
> > > > >       while ((child = next_device(&i)))
> > > > > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > > > > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
> > > >
> > > > Who wants to call this function with a name passed from userspace?
> > > >
> > > > Not objecting to it, just curious...
> > > >
> > >
> > > The series that incorporates this patch adds a partitioning mechanism
> > > to "device-dax region" devices with an:
> > >     "echo 1 > regionX/create" to create a new partition / sub-instance
> > > of a region, and...
> > >     "echo $devname > regionX/delete" to delete. Where $devname is
> > > searched in the child devices of regionX to trigger device_del().
> >
> > Shouldn't that be done in configfs, not sysfs?
> 
> I see configfs as an awkward fit for this situation. configfs wants to
> software define kernel objects whereas this facility wants to augment
> existing kernel enumerated device objects. The region device is
> created by firmware policy and is optionally partitioned, configfs
> objects don't exist at all until created. So for this I see sysfs +
> 'scheme to trigger child device creation' as just enough mechanism
> that does not warrant full blown configfs.
> 
> I believe it was debates like this [1] that have led me to the camp of
> sysfs being capable of some device creation dynamism and leave
> configfs for purely software constructed objects.
> 
> [1]: https://lore.kernel.org/lkml/17377.42813.479466.690408@cse.unsw.edu.au/

"some" :)

And that was from 2006, ugh, how did you find that...

Ok, that's fine, no objection from me for this patch:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
