Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF610568F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKUQJO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 11:09:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40210 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUQJO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 11:09:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id d22so3658448oic.7
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXcgcbvs+2MnPA/4X38cmSpaLsc4tBMazAvEwqgqGLo=;
        b=UE/6TT7HfPuj8S5WgeIZ69I021cjsb4qGDZt3qc9fk1IB5APVoH66ut51jVBes4iSW
         Aef0fLKZocovV80FGW/O+Gv57tCW1pRhplxGliybAKG42xLiMrtbqrEIgCZ6c+KmfCnf
         dgvaBxYJ35Q4ov8s6LeUCSJ9dYGNH8PcnuIi4h6Cd61vCgrzzcoQi7EHEGMv6fGYmXFq
         ZiKVURucVh43UjBdWpw4DNKYA1CKXYHftPdvH2B0cR4G3F+T+udGHGGCvHw31xJf3qSy
         xTb97wVqCQKA608tb1v79CHsPYi02hOh3NrGphXwbN+jVtzlRPeKPQCB+mCUZPdYStwN
         m24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXcgcbvs+2MnPA/4X38cmSpaLsc4tBMazAvEwqgqGLo=;
        b=CtO66pttiVHw+jIXBotDDT99eDnN0CdNPIeuDxi4udlW53rCbZtYud0FVYOGF+/big
         cK/xJG3DyDBkur2UcRLEVuVsjfeYjZphpaLOyl5T00liFVElF3oBLJYAIWg0delU1PJm
         E1E5+U+y8tmN4jb7GNWEH/IL+9h8cO7StwmQWkUgRhVJrL83q21okNpiM3IMfXqCJB5v
         o3NebP7NBCPwlag9RC23uLOdPaOCDHGON43Z5ZRP1QufcY9Z8ot6tpRBnJ8bxxv278mj
         BLIRUHN6FRPTrs8nDHlw3KMCpjlVr+/SBZcmDcg6aqsn9k9djV2D8pkmdggvz7tA7cL3
         UIUA==
X-Gm-Message-State: APjAAAUE2t8sr/EPUqtDKFNe6FB+g1COWBU9YBA0kMqsjJySpihuCGrj
        wHBgSXcWCYiJBhEyEAv4LNiLL+flF0Jhu9OUAq19Zg==
X-Google-Smtp-Source: APXvYqwkBEKt2Ayxyhbxss+ahZZeyKGZ4wQSytQ1j5jmWgdtz59MSNkUesIZGAabUlJVAxO+Bd8N8I04KKrwKi4VgcA=
X-Received: by 2002:aca:3c1:: with SMTP id 184mr7837409oid.70.1574352553381;
 Thu, 21 Nov 2019 08:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
 <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com> <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
In-Reply-To: <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Nov 2019 08:09:02 -0800
Message-ID: <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com>
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

On Thu, Nov 21, 2019 at 12:00 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> > > >
> > > > >  Remove logic to create child bio in the async flush function which
> > > > >  causes child bio to get executed after parent bio 'pmem_make_request'
> > > > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> > > > >  data write request.
> > > > >
> > > > >  Instead we are performing flush from the parent bio to maintain the
> > > > >  correct order. Also, returning from function 'pmem_make_request' if
> > > > >  REQ_PREFLUSH returns an error.
> > > > >
> > > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > >
> > > > There's a slight change in behavior for the error path in the
> > > > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> > > > converted to -EIO.  Now, they are reported as-is.  I think this is
> > > > actually an improvement.
> > > >
> > > > I'll also note that the current behavior can result in data corruption,
> > > > so this should be tagged for stable.
> > >
> > > I added that and was about to push this out, but what about the fact
> > > that now the guest will synchronously wait for flushing to occur. The
> > > goal of the child bio was to allow that to be an I/O wait with
> > > overlapping I/O, or at least not blocking the submission thread. Does
> > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > think a synchronous wait is going to be a significant performance
> > > regression. Are there any numbers to accompany this change?
> >
> > Why not just swap the parent child relationship in the PREFLUSH case?
>
> I we are already inside parent bio "make_request" function and we create child
> bio. How we exactly will swap the parent/child relationship for PREFLUSH case?
>
> Child bio is queued after parent bio completes.

Sorry, I didn't quite mean with bio_split, but issuing another request
in front of the real bio. See md_flush_request() for inspiration.
