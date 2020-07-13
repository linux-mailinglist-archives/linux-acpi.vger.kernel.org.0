Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38D21DD12
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgGMQgb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgGMQgZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2020 12:36:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4737C061755
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 09:36:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so17930887eje.7
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZNThefDeIHtE1ePtyRHJh2smc+ji3rHASWHkarQpEA=;
        b=r/hwhToyzhzg5/h5ygCjJ458Jk5Wh/GLR4dkOAyc3nmzc2aqTLsx+s5BGZT3ir/OKo
         6R5Idb53R3uplzvPZRn2E+M9eXKxf5rYFtoEC7Kp9PbrU7m5nGXYM1qOjK2axYP1oLEN
         /uwxZbEZ8DYFqpXi83o0hVwVI6GKb/UOJYS6dG1LEouBCigaLZIqRh7Cca2yae2srQ6G
         mEDPayiqI+EOuBE0CAJvoi6oH4U+hqK/GxHt9jARP65uekKzTDprCRWAxiLvTDLVsLQC
         ktmXIHRQjZGsB9vRUQzIB3AR2Y+L1vKF50uWQxV+zE15bZebpEJAWBQB3fmJ5nkjMpqx
         SsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZNThefDeIHtE1ePtyRHJh2smc+ji3rHASWHkarQpEA=;
        b=jS/nUE4zkzkCauPf3FS0WUEFuru8g4wBWAz3q1DOnAhRmun2vXf3zGpZ9iMkQ632nF
         +tF6Qi1nUyoOsgx3Tv37kqi1e0USMqOn6r3OgylHreTPJbcZfMRJGpwOvAPZHWjjHcnb
         sR+ANXA+galXZ4c1ckrHA67/XSw/CWi4bX6+VJ0t0FsbUqKfV+69ME89lqAliRTIs7oG
         Wbk4bhAkPnhKqBGxxp7UPUWfFje2mSePLGgG4stKmF2tkD1j5+ZdDbiW59JzkKC/kOgx
         8SD7bX0RSyRJRnJfNV1GXdVnYM8pZM08zLt83Dl5Y0SHMjL9cq9ZBduSRTCAYJMKO1Jd
         nRfQ==
X-Gm-Message-State: AOAM53062g7FV0q5yQpCuKcg5c37BfM1ELJ++xXbqc9KSxofbZeqk+Fa
        2v5Uy1Z/nV5rEq1YUUTlLPcGl53Oy73I59YJeDrrQg==
X-Google-Smtp-Source: ABdhPJz7kJwN+FtUOtRMjCPxLqFf8n0GyUdgjTjIsPmDaKxiXHa/S9B+1Hu/3Wxq5ZlAvUmHgOkdeaVL/w0Di9GcUBo=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr588276ejt.440.1594658183401;
 Mon, 13 Jul 2020 09:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com> <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
 <20200713155222.GB267581@kroah.com> <CAPcyv4ijb3nS3WuO38Yn3epBec8uQqw+UfimqFByqRT9QXCpLw@mail.gmail.com>
 <20200713161251.GA366826@kroah.com>
In-Reply-To: <20200713161251.GA366826@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 09:36:12 -0700
Message-ID: <CAPcyv4iGbNShdA_pmaL-YwMaUX1zNM9MhviiSDyXXsX9aVG+gQ@mail.gmail.com>
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

On Mon, Jul 13, 2020 at 9:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 13, 2020 at 09:09:18AM -0700, Dan Williams wrote:
> > On Mon, Jul 13, 2020 at 8:52 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 13, 2020 at 08:39:43AM -0700, Dan Williams wrote:
> > > > On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > > > > > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > > > > > sysfs input string that might contain a trailing newline.
> > > > > >
> > > > > > The other "device by name" interfaces,
> > > > > > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > > > > > strings.
> > > > > >
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > > > ---
> > > > > >  drivers/base/core.c |    2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > index 67d39a90b45c..5d31b962c898 100644
> > > > > > --- a/drivers/base/core.c
> > > > > > +++ b/drivers/base/core.c
> > > > > > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> > > > > >
> > > > > >       klist_iter_init(&parent->p->klist_children, &i);
> > > > > >       while ((child = next_device(&i)))
> > > > > > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > > > > > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
> > > > >
> > > > > Who wants to call this function with a name passed from userspace?
> > > > >
> > > > > Not objecting to it, just curious...
> > > > >
> > > >
> > > > The series that incorporates this patch adds a partitioning mechanism
> > > > to "device-dax region" devices with an:
> > > >     "echo 1 > regionX/create" to create a new partition / sub-instance
> > > > of a region, and...
> > > >     "echo $devname > regionX/delete" to delete. Where $devname is
> > > > searched in the child devices of regionX to trigger device_del().
> > >
> > > Shouldn't that be done in configfs, not sysfs?
> >
> > I see configfs as an awkward fit for this situation. configfs wants to
> > software define kernel objects whereas this facility wants to augment
> > existing kernel enumerated device objects. The region device is
> > created by firmware policy and is optionally partitioned, configfs
> > objects don't exist at all until created. So for this I see sysfs +
> > 'scheme to trigger child device creation' as just enough mechanism
> > that does not warrant full blown configfs.
> >
> > I believe it was debates like this [1] that have led me to the camp of
> > sysfs being capable of some device creation dynamism and leave
> > configfs for purely software constructed objects.
> >
> > [1]: https://lore.kernel.org/lkml/17377.42813.479466.690408@cse.unsw.edu.au/
>
> "some" :)

Yes, lowercase and quoted: "some" :).

> And that was from 2006, ugh, how did you find that...

Oh, public-inbox is a wonderful thing. "I kinda sort of remember Neil
laying out a configfs vs sysfs argument", /me searches for "f:neil
configfs" and voila.

> Ok, that's fine, no objection from me for this patch:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, Greg.
