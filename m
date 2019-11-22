Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E50105F6B
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfKVFRm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 00:17:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42367 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfKVFRl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 00:17:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id o12so5424045oic.9
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 21:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keeodVCAfBP266uKFs6gORVjfgMY0eZ+dSw8j1koUJM=;
        b=BIOGnljlLRD9J80W8RY8QHF75L0lSFekBNWZN8hg6Rk7ljv9ZJisk86mocS5aiKe4M
         BRZGCQpb/a/2HBXTpqGHIr6gl5Yi174AJyQgmbRrjnEf1eD4TmgrawnUt12HU3lJfSnM
         jsv9KaL9by0JkoV7d5CABQDDWhnr3Yv4lsOpRt/wfUrMC3daEO/UP2vIWl/f6F9SjRg6
         vV8w8h+6ne19HZGi9F8YO59Tk42WwohDyYShHdM82hUpHeHhD6F2MdT47XhV3HW4jl3e
         zBa9aicw9PLNxx2NdjnxS7BRDDf9mRGgi26FURoNfyPLFC4eL9NDJ4NpFIDQcLSbfchm
         nJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keeodVCAfBP266uKFs6gORVjfgMY0eZ+dSw8j1koUJM=;
        b=PHZTKyGTmORSHjEGWWCIkWZ9yCj7kJP6iobyW16CRwaFreHXIfaYejVcJLqMMIc89t
         kQsv1vJp44/RPNP7vjRxfAf2cJHNreuFnkFsjZce0hwaa0xT9FNNRZWPYxKW2z2a60so
         KlnUBjzYPVzjN9ytpGp2YoXCht1wfVIbLt7QiBexcaVTsuQClFV9sMIf8N90gNlMZ3pI
         mCxtogpRWSpYEhbaI4ye81Cf/7EoFjCLNcM2rwKiLzD/PKJEKkr0aOU55N5LTSDzrxe8
         kRLE4cqBV+ur/Olgo7Wy6NEfp6Le/X8DDsFhVweIO0mirIIMGUuTVgoToQoB79GRP9Na
         kj3A==
X-Gm-Message-State: APjAAAXdlKBQ/D6Usi52QrSbGe67qMzP4FNXxfjSc4yEZBQMphJEtmDg
        uVImqfB3uF/UArypZ64M42c07QdOHnD4Yb5s8KkjRg==
X-Google-Smtp-Source: APXvYqyeVnRwhSQg9omPamcyvVHAk303c8e0hbTEeNPBnyGzGAg4XQG9mA2ytTDgrGbVNkDXXZO49Ddks50Gg2ZmNG8=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr11122498oih.0.1574399860567;
 Thu, 21 Nov 2019 21:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
 <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
 <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
 <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com> <560894997.35969622.1574397521533.JavaMail.zimbra@redhat.com>
In-Reply-To: <560894997.35969622.1574397521533.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Nov 2019 21:17:29 -0800
Message-ID: <CAPcyv4gsQXY5C5URF2vrTaD-0Q_CJ+ib3GVb1VFZAO+1Gdau2w@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 21, 2019 at 8:38 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> > > > > >
> > > > > > >  Remove logic to create child bio in the async flush function which
> > > > > > >  causes child bio to get executed after parent bio
> > > > > > >  'pmem_make_request'
> > > > > > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with
> > > > > > >  the
> > > > > > >  data write request.
> > > > > > >
> > > > > > >  Instead we are performing flush from the parent bio to maintain
> > > > > > >  the
> > > > > > >  correct order. Also, returning from function 'pmem_make_request'
> > > > > > >  if
> > > > > > >  REQ_PREFLUSH returns an error.
> > > > > > >
> > > > > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > > > >
> > > > > > There's a slight change in behavior for the error path in the
> > > > > > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush
> > > > > > were
> > > > > > converted to -EIO.  Now, they are reported as-is.  I think this is
> > > > > > actually an improvement.
> > > > > >
> > > > > > I'll also note that the current behavior can result in data
> > > > > > corruption,
> > > > > > so this should be tagged for stable.
> > > > >
> > > > > I added that and was about to push this out, but what about the fact
> > > > > that now the guest will synchronously wait for flushing to occur. The
> > > > > goal of the child bio was to allow that to be an I/O wait with
> > > > > overlapping I/O, or at least not blocking the submission thread. Does
> > > > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > > > think a synchronous wait is going to be a significant performance
> > > > > regression. Are there any numbers to accompany this change?
> > > >
> > > > Why not just swap the parent child relationship in the PREFLUSH case?
> > >
> > > I we are already inside parent bio "make_request" function and we create
> > > child
> > > bio. How we exactly will swap the parent/child relationship for PREFLUSH
> > > case?
> > >
> > > Child bio is queued after parent bio completes.
> >
> > Sorry, I didn't quite mean with bio_split, but issuing another request
> > in front of the real bio. See md_flush_request() for inspiration.
>
> o.k. Thank you. Will try to post patch today to be considered for 5.4.
>

I think it is too late for v5.4-final, but we can get it in the
-stable queue. Let's take the time to do it right and get some testing
on it.
