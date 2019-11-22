Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5E105F45
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 05:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKVEiv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 23:38:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726500AbfKVEiu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 23:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574397529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGSHBQja7qoAUYzMf3cEFcK/LDtr3a+1zdNJojEp37E=;
        b=E3Nds/5qjcFsI7um6PHPrHZYl7ar5/9vKJ8aug1JQxa1Oi6z/Tp9umeI7fX1VK/KvxbOFh
        KkxN8ti6UjvSPmH6AUPeWO++JqwtANeqvhFtImtHEuIeKVffDMIK3HlcV+ANg1YqeA8z5Y
        QHjtS4i4KHS9V5R0LCfNeSZxng2GJT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-K6V0ySTOOYGesCDyUuoUIw-1; Thu, 21 Nov 2019 23:38:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3EE2107ACC4;
        Fri, 22 Nov 2019 04:38:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9719028D18;
        Fri, 22 Nov 2019 04:38:42 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id D29F64BB5C;
        Fri, 22 Nov 2019 04:38:41 +0000 (UTC)
Date:   Thu, 21 Nov 2019 23:38:41 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
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
Message-ID: <560894997.35969622.1574397521533.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com>
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com> <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com> <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com> <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
MIME-Version: 1.0
X-Originating-IP: [10.67.116.36, 10.4.195.13]
Thread-Topic: virtio pmem: fix async flush ordering
Thread-Index: LSm9oNBEmc1YyqOBo3tZ7gh0w041hg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: K6V0ySTOOYGesCDyUuoUIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> > > > >
> > > > > >  Remove logic to create child bio in the async flush function w=
hich
> > > > > >  causes child bio to get executed after parent bio
> > > > > >  'pmem_make_request'
> > > > > >  completes. This resulted in wrong ordering of REQ_PREFLUSH wit=
h
> > > > > >  the
> > > > > >  data write request.
> > > > > >
> > > > > >  Instead we are performing flush from the parent bio to maintai=
n
> > > > > >  the
> > > > > >  correct order. Also, returning from function 'pmem_make_reques=
t'
> > > > > >  if
> > > > > >  REQ_PREFLUSH returns an error.
> > > > > >
> > > > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > > >
> > > > > There's a slight change in behavior for the error path in the
> > > > > virtio_pmem driver.  Previously, all errors from virtio_pmem_flus=
h
> > > > > were
> > > > > converted to -EIO.  Now, they are reported as-is.  I think this i=
s
> > > > > actually an improvement.
> > > > >
> > > > > I'll also note that the current behavior can result in data
> > > > > corruption,
> > > > > so this should be tagged for stable.
> > > >
> > > > I added that and was about to push this out, but what about the fac=
t
> > > > that now the guest will synchronously wait for flushing to occur. T=
he
> > > > goal of the child bio was to allow that to be an I/O wait with
> > > > overlapping I/O, or at least not blocking the submission thread. Do=
es
> > > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > > think a synchronous wait is going to be a significant performance
> > > > regression. Are there any numbers to accompany this change?
> > >
> > > Why not just swap the parent child relationship in the PREFLUSH case?
> >
> > I we are already inside parent bio "make_request" function and we creat=
e
> > child
> > bio. How we exactly will swap the parent/child relationship for PREFLUS=
H
> > case?
> >
> > Child bio is queued after parent bio completes.
>=20
> Sorry, I didn't quite mean with bio_split, but issuing another request
> in front of the real bio. See md_flush_request() for inspiration.

o.k. Thank you. Will try to post patch today to be considered for 5.4.

Best regards,
Pankaj
>=20
>=20

