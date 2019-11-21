Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6576104C5C
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 08:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUHYA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 02:24:00 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46766 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUHX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 02:23:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so2013123otr.13
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2019 23:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEXJauHqWm8iI4LnNBvnulW7dvtwyPk4PjbYBEQHLv0=;
        b=Aamx4FNUou5OK5b7p9ovqCkit0cIfdpUzoZz7zxKIrRXmGuxUroJEy8wgfnhc4LNO9
         /bAUGOCzZnxJ+6JvDwrn1hrSEejsJDm9addm6MgSJJndGvNXP5xKWYE3TXfKO3zT1XmE
         G+cfBCOAa0MLYBx0J8IOpV6ETGNBWcIcBSKsVmQ18T+Av5T94jpinvYdky3C2cfJCxww
         zAYPLQyi/BjZmHcmFpPXkMpAq93xJVnFAVyNIJ7wM77MNuYDPu5abIu18Pi9wC4fb9Ij
         LyRjFAPS051ir8jmoxV6RL/1LXpeCK7iPrM3gAOrGb89knq52X47y1B6UQk7Vc8JyaZJ
         Bxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEXJauHqWm8iI4LnNBvnulW7dvtwyPk4PjbYBEQHLv0=;
        b=CdEjq2FzKlYMr0MImOVc+qeBs69Qp/r8Hyri4ETvfM5VY1scdro8VmH+wbXkYBMM0J
         luHB1au27ciKSu7mjsbX8z/I79JtLiNfu0Baubo7c6Hnjgxx14gnU4MxrJ3SkOfzLfcU
         klq7tBb2+gE3gI3Pt/jS6ssaBsPYkIirzQdPu4G1vf/mWikxJXmrCdWEBzISo4JbRKVu
         XxGuUDEBBJzMQa5aHh2A+Y0SfoPsTTXtUJpP0HgX9+4dNcJArfvj0Ow2hFLxYgHXuFAg
         to69omaDGc4sVG2LcaNHm9pq7BHcv82N2tYggmmnrvtEqTYFZD9LBa0kf9uT7YYPPahD
         yrjA==
X-Gm-Message-State: APjAAAWWh2z+EF0JV53QrND2xlLZnJuxni6n9wTQSQe1SxLAo7qpLNvt
        k+sZ56egDR+ALpsB2UBNwuW5C/cvPGB1SDDzLAz8zQ==
X-Google-Smtp-Source: APXvYqws9XkJQSLixl8sCxSf8KR7piXMbSGOHYMZNFTKMUrilxcOOTe8eFSPb/y5vtMhiXzk8SHG7lti/eziN7V7EtQ=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr5394180otg.363.1574321038732;
 Wed, 20 Nov 2019 23:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 23:23:46 -0800
Message-ID: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
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

On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Pankaj Gupta <pagupta@redhat.com> writes:
>
> >  Remove logic to create child bio in the async flush function which
> >  causes child bio to get executed after parent bio 'pmem_make_request'
> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> >  data write request.
> >
> >  Instead we are performing flush from the parent bio to maintain the
> >  correct order. Also, returning from function 'pmem_make_request' if
> >  REQ_PREFLUSH returns an error.
> >
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>
> There's a slight change in behavior for the error path in the
> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> converted to -EIO.  Now, they are reported as-is.  I think this is
> actually an improvement.
>
> I'll also note that the current behavior can result in data corruption,
> so this should be tagged for stable.

I added that and was about to push this out, but what about the fact
that now the guest will synchronously wait for flushing to occur. The
goal of the child bio was to allow that to be an I/O wait with
overlapping I/O, or at least not blocking the submission thread. Does
the block layer synchronously wait for PREFLUSH requests? If not I
think a synchronous wait is going to be a significant performance
regression. Are there any numbers to accompany this change?
