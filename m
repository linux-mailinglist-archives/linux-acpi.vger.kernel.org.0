Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82441104CA2
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 08:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfKUHc3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 02:32:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46430 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUHc2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 02:32:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so2029612otr.13
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2019 23:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9wDawpHcea7HfUbnxzvdCHT/HpQNck9P448/UedoQM=;
        b=RUey+MSk1Jxsoa8ZqmDeOeA4Qu0lkrGc8OKXCXqKYlNDPNE/RI693KUy2YDy1bs0Bq
         ckWMixCAW5axJ3kJe7EpdMPizq+94X82FKhtwD7vIIOrm5PL4rWL5tMsRQc+gCoqi2TK
         RVgk0Kg9QPwUIVbMM59J11QqVgfeIgZPu4jOo1P8CBl7ke4N9DJQqfgylUSmvoKQKCbj
         mBjTqC/uvyUH/7bVZEmz7QQpfP5gtFAcrfBHGIuVQoZJNq8iC+Dgu0eAy4vcTOSab/Fh
         5mD7rv1Vz3M2bsNxX5R/1UKzn0KB1ehwLLvkMlxZ8kQlbvrKCCz1llIjyOUowure8p6X
         BRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9wDawpHcea7HfUbnxzvdCHT/HpQNck9P448/UedoQM=;
        b=ckV9ai8goFAuvwpQaFwA1LlZVkWMCcSnnVDLsZ0hDLoEMYeTAU69V0vWv10Yenf//V
         LvOo0j0CP0iKbx5p889u720yPu7XvEiWAQ6pMoTZTnc9Zh7FPC4v4r0Lo0FcTspq+1A+
         6iD6KFiuzNIkC0QhBGT059hH4iynTB9kLeImXlxKhBINVbFQcQ0knOC5k0O7ulS+zkc9
         8mZilPBhL5aezJukMFxglLSbfEh+la1DfPG5YSZDUQFiwZLwPNPn4eQz24L51T7w9JTv
         xgjJF8Rjl1HMrS7c+bwkwQlwG17Nf1Dmqq1FlfQTeQKyZi13XGnvXtXv6Yjl+CmSs9Wq
         1uQQ==
X-Gm-Message-State: APjAAAXhcrCNQM4fZcIa73f+KmeP8CvGVf2FWykmhnunuSAv/M5M5MTT
        WTMMf1zQ9W/HzjAzNSCtmXX4MmFuyb6gW3R+qfcBPg==
X-Google-Smtp-Source: APXvYqxVdzze/Bv9h7nJAgHDFshYj18n/blQjGCiUjfCo8aBpbC+/jW+Mgs+B30i9qOHhWav26iyCwsoCBet2GWzaNY=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr5418112otg.363.1574321547958;
 Wed, 20 Nov 2019 23:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
In-Reply-To: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 23:32:16 -0800
Message-ID: <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 20, 2019 at 11:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Pankaj Gupta <pagupta@redhat.com> writes:
> >
> > >  Remove logic to create child bio in the async flush function which
> > >  causes child bio to get executed after parent bio 'pmem_make_request'
> > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> > >  data write request.
> > >
> > >  Instead we are performing flush from the parent bio to maintain the
> > >  correct order. Also, returning from function 'pmem_make_request' if
> > >  REQ_PREFLUSH returns an error.
> > >
> > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> >
> > There's a slight change in behavior for the error path in the
> > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> > converted to -EIO.  Now, they are reported as-is.  I think this is
> > actually an improvement.
> >
> > I'll also note that the current behavior can result in data corruption,
> > so this should be tagged for stable.
>
> I added that and was about to push this out, but what about the fact
> that now the guest will synchronously wait for flushing to occur. The
> goal of the child bio was to allow that to be an I/O wait with
> overlapping I/O, or at least not blocking the submission thread. Does
> the block layer synchronously wait for PREFLUSH requests? If not I
> think a synchronous wait is going to be a significant performance
> regression. Are there any numbers to accompany this change?

Why not just swap the parent child relationship in the PREFLUSH case?
