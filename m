Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3B10756E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKVQI5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 11:08:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbfKVQI4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 11:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574438935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aChokPuSf/E1/myJnN2scacEgSwoRMHnNtyJ+8WYM+U=;
        b=bZKVkc80LqafSV4UKq4s6/QqRLLEijI5u81HkHqcWRkWLnzDY7hUgIPziITJRMVBi0eYDB
        wB1BFM6TPt3Ak1yXaLNjRBJk0ljDDWe1HgANZ0iLsItt2mxnFad8SaSmHh2D2ut+Fst6KA
        +K6XV3hKctpTfLdgyqcYaey8kur3nBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-paFjoYLyMj6EbrgB8Ql3JA-1; Fri, 22 Nov 2019 11:08:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 889F01005510;
        Fri, 22 Nov 2019 16:08:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B08A8516;
        Fri, 22 Nov 2019 16:08:48 +0000 (UTC)
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
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 22 Nov 2019 11:08:46 -0500
In-Reply-To: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
        (Dan Williams's message of "Wed, 20 Nov 2019 23:23:46 -0800")
Message-ID: <x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: paFjoYLyMj6EbrgB8Ql3JA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Pankaj Gupta <pagupta@redhat.com> writes:
>>
>> >  Remove logic to create child bio in the async flush function which
>> >  causes child bio to get executed after parent bio 'pmem_make_request'
>> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
>> >  data write request.
>> >
>> >  Instead we are performing flush from the parent bio to maintain the
>> >  correct order. Also, returning from function 'pmem_make_request' if
>> >  REQ_PREFLUSH returns an error.
>> >
>> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
>> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>>
>> There's a slight change in behavior for the error path in the
>> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
>> converted to -EIO.  Now, they are reported as-is.  I think this is
>> actually an improvement.
>>
>> I'll also note that the current behavior can result in data corruption,
>> so this should be tagged for stable.
>
> I added that and was about to push this out, but what about the fact
> that now the guest will synchronously wait for flushing to occur. The
> goal of the child bio was to allow that to be an I/O wait with
> overlapping I/O, or at least not blocking the submission thread. Does
> the block layer synchronously wait for PREFLUSH requests?

You *have* to wait for the preflush to complete before issuing the data
write.  See the "Explicit cache flushes" section in
Documentation/block/writeback_cache_control.rst.

-Jeff

