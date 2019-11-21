Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CA104D1B
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 09:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKUICD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 03:02:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38355 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbfKUICD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Nov 2019 03:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574323322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mG0FHW0fig4Cx/LxAaJLR6J3VqDT9J+mhAWOfYVykWs=;
        b=M/BxHV9MEmk+gkhq8PlUSFXybhegVDOwzS6YMLHmbbxGpTLlNaX2b/P8YOkXHJaiseT6Nw
        PqiAltKhhfmZA+ltywuW0U4hovVizkkYUZrVED+8/XTE2b1nx6L14I142IKt5dj5kEWcg+
        NfrXnjS1px0UtRCO8cHHdEtzaOtWMd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-g80Ev-2mMmmrw3oAT5So1Q-1; Thu, 21 Nov 2019 03:01:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6273801E5D;
        Thu, 21 Nov 2019 08:01:56 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7AEC692BE;
        Thu, 21 Nov 2019 08:01:56 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8F4591809563;
        Thu, 21 Nov 2019 08:01:56 +0000 (UTC)
Date:   Thu, 21 Nov 2019 03:01:56 -0500 (EST)
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
Message-ID: <2089367516.35808121.1574323316486.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
MIME-Version: 1.0
X-Originating-IP: [10.67.116.169, 10.4.195.1]
Thread-Topic: virtio pmem: fix async flush ordering
Thread-Index: n73vjZWQN2B3un3TvjjmhkQyzbgvzg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: g80Ev-2mMmmrw3oAT5So1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> >
> > >  Remove logic to create child bio in the async flush function which
> > >  causes child bio to get executed after parent bio 'pmem_make_request=
'
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
>=20
> I added that and was about to push this out, but what about the fact
> that now the guest will synchronously wait for flushing to occur. The
> goal of the child bio was to allow that to be an I/O wait with
> overlapping I/O, or at least not blocking the submission thread. Does
> the block layer synchronously wait for PREFLUSH requests? If not I
> think a synchronous wait is going to be a significant performance
> regression. Are there any numbers to accompany this change?

My bad, I missed this point completely.

Thanks,
Pankaj

>=20
>=20

