Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B4432320
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJRPmy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 11:42:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:31329 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhJRPmt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 11:42:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="289127326"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="289127326"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 08:40:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="482789500"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 08:40:31 -0700
Date:   Mon, 18 Oct 2021 08:40:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ: Relax platform response timeout to 1
 second.
Message-ID: <YW2Vbkn5d6r3Y4LA@agluck-desk2.amr.corp.intel.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <4d492cef3640414d85ecfdb602ad6fa0@intel.com>
 <869f0c92-0800-b24e-9de8-d8c9cb6972a7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869f0c92-0800-b24e-9de8-d8c9cb6972a7@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 17, 2021 at 12:06:52PM +0800, Shuai Xue wrote:
> Hi, Tony,
> 
> Thank you for your reply.
> 
> > Spinning for 1ms was maybe ok. Spinning for up to 1s seems like a bad idea.
> >
> > This code is executed inside a mutex ... so maybe it is safe to sleep instead of spin?
> 
> May the email Subject misled you. This code do NOT spin for 1 sec. The period of the
> spinning depends on the SPIN_UNIT.

Not just the subject line. See the comment you changed here:

> > -#define SPIN_UNIT		100			/* 100ns */
> > -/* Firmware should respond within 1 milliseconds */
> > -#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
> > +#define SPIN_UNIT		100			/* 100us */
> > +/* Firmware should respond within 1 seconds */
> > +#define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)

That definitely reads to me that the timeout was increased from
1 millisecond to 1 second. With the old code polling for completion
every 100ns, and the new code polling every 100us
> 
> The period was 100 ns and changed to 100 us now. In my opinion, spinning for 100 ns or 100 us is OK :)

But what does the code do in between polls? The calling code is:

        for (;;) {
                rc = apei_exec_run(&ctx, ACPI_EINJ_CHECK_BUSY_STATUS);
                if (rc)
                        return rc;
                val = apei_exec_ctx_get_output(&ctx);
                if (!(val & EINJ_OP_BUSY))
                        break;
                if (einj_timedout(&timeout))
                        return -EIO;
        }

Now apei_exec_run() and apei_exec_ctx_get_output() are a maze of
functions & macros. But I don't think they can block, sleep, or
context switch.

So this code is "spinning" until either BIOS says the operation is
complete, or the FIRMWARE_TIMEOUT is reached.

It avoids triggering a watchdog by the call to touch_nmi_watchdog()
after each spin between polls. But the whole thing may be spinning
for a second.

I'm not at all sure that I'm right that the spin could be replaced
with an msleep(). It will certainly slow things down for systems
and EINJ operations that actually complete quickly (because instead
of returnining within 100ns (or 100us with your patch) it will sleep
for 1 ms (rounded up to next jiffie ... so 4 ms of HZ=250 systems.

But I don't care if my error injections take 4ms.

I do care that one logical CPU spins for 1 second.

-Tony
