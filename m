Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287A51075BA
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVQZX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 11:25:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37820 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbfKVQZW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 11:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574439921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHdyHfkNKosHl51NLrMjsjBT0ZayHryhZQGO5Md7wqE=;
        b=fkgsDrpJ7qdIE/ZntwpIM9t+ZRHI9I5rZef9UUq/cc683neCdFAK8wWNTagVaOZypEDPJj
        F+K+n9KUBq5NYuzGaOwTp4CB7XaPiP4Wwhxu7MRK5Lrnr7mbChG+Wwwa5B+JEmHUw5zgXm
        0Omj5nQeZygrjnBujNrvFfvvSS1obTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-FxwrXjrrPBO6LPh4PmY5hA-1; Fri, 22 Nov 2019 11:25:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07B7B184CAA8;
        Fri, 22 Nov 2019 16:25:15 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 659181CB;
        Fri, 22 Nov 2019 16:25:13 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny\, Ira" <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
References: <20191120092831.6198-1-pagupta@redhat.com>
        <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
        <x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4idC=LgkwP+A1GKJ1CWkzUZ_RVBDCVfA3yAL9TNw1zZmw@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 22 Nov 2019 11:25:11 -0500
In-Reply-To: <CAPcyv4idC=LgkwP+A1GKJ1CWkzUZ_RVBDCVfA3yAL9TNw1zZmw@mail.gmail.com>
        (Dan Williams's message of "Fri, 22 Nov 2019 08:13:05 -0800")
Message-ID: <x49d0djev4o.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FxwrXjrrPBO6LPh4PmY5hA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Nov 22, 2019 at 8:09 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>> >>
>> >> Pankaj Gupta <pagupta@redhat.com> writes:
>> >>
>> >> >  Remove logic to create child bio in the async flush function which
>> >> >  causes child bio to get executed after parent bio 'pmem_make_reque=
st'
>> >> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with th=
e
>> >> >  data write request.
>> >> >
>> >> >  Instead we are performing flush from the parent bio to maintain th=
e
>> >> >  correct order. Also, returning from function 'pmem_make_request' i=
f
>> >> >  REQ_PREFLUSH returns an error.
>> >> >
>> >> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
>> >> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>> >>
>> >> There's a slight change in behavior for the error path in the
>> >> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush we=
re
>> >> converted to -EIO.  Now, they are reported as-is.  I think this is
>> >> actually an improvement.
>> >>
>> >> I'll also note that the current behavior can result in data corruptio=
n,
>> >> so this should be tagged for stable.
>> >
>> > I added that and was about to push this out, but what about the fact
>> > that now the guest will synchronously wait for flushing to occur. The
>> > goal of the child bio was to allow that to be an I/O wait with
>> > overlapping I/O, or at least not blocking the submission thread. Does
>> > the block layer synchronously wait for PREFLUSH requests?
>>
>> You *have* to wait for the preflush to complete before issuing the data
>> write.  See the "Explicit cache flushes" section in
>> Documentation/block/writeback_cache_control.rst.
>
> I'm not debating the ordering, or that the current implementation is
> obviously broken. I'm questioning whether the bio tagged with PREFLUSH
> is a barrier for future I/Os. My reading is that it is only a gate for
> past writes, and it can be queued. I.e. along the lines of
> md_flush_request().

Sorry, I misunderstood your question.

For a write bio with REQ_PREFLUSH set, the PREFLUSH has to be done
before the data attached to the bio is written.  That preflush is not an
I/O barrier.  In other words, for unrelated I/O (any other bio in the
system), it does not impart any specific ordering requirements.  Upper
layers are expected to wait for any related I/O completions before
issuing a flush request.

So yes, you can queue the bio to a worker thread and return to the
caller.  In fact, this is what I had originally suggested to Pankaj.

Cheers,
Jeff

