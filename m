Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE5347CEC
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 16:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhCXPpc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 11:45:32 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45703 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbhCXPpB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 11:45:01 -0400
Received: by mail-ot1-f41.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so2122426oty.12;
        Wed, 24 Mar 2021 08:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfhJOg09ikxWSIDPpHsrjFdK9fLKr7xknDIbplXzRO0=;
        b=HjnhrbpheK5tMS9k29vE0lekUUqTTb1CAY2R9hBHQCNu72tkJh5pHWJQTePJdDc/dV
         dpy7aCGZjz11BFhcxfUQZXVOqKrItenOUw4tLlBCDlw6WD0oS6zvYes/C1g8uQFY9BiL
         yqd2QRuMWVKQcPa6zc4WKMxOPximXkYqO0aOS1lybWPyH7fe9m86/GChmBamysh4pssz
         f9ZIc4YjpVIJsbUxVpQdFFxbbFxy06BUdUa+51oGLbkMK1hX8YHuKoGAzotQjPSKqQ4N
         zz1xKSftI+SOHfNjkHt9run0q95TAjEV11sLwimD+i5ltYJFRi9LyYdV2RvQRNbgEvm0
         afRw==
X-Gm-Message-State: AOAM532vLCScw/xWKFyKnojOUFFOyehlgReBwuFfs4Wb5RsezeY9ga/y
        3GSW6YsgcXPjQMJa/s/AuZ3B9nA9mhP+rHkAMTI=
X-Google-Smtp-Source: ABdhPJznvfbua4AyfGFUKYyzKuFs1u1F8dwJMZKu9QkTc4HwM7IBTRdhTFzkGEBa5+QRALOhKDZb+xDSkXn3UCqq+lU=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr3803460otr.321.1616600700966;
 Wed, 24 Mar 2021 08:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com> <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher> <YFMAdIVn2hpTHfBq@linux.ibm.com>
 <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
 <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
 <YFWxbzN92XcXNl95@linux.ibm.com> <4650320.31r3eYUQgx@kreacher>
 <YFr3KMhW0ajHzeH4@linux.ibm.com> <CAJZ5v0gWWGx8dvtz2pnXcCoxz_Aswo8Yxp=vo-z=jYX1OzC3=Q@mail.gmail.com>
 <933519a8-faaf-644c-4368-bc92cfab937f@oracle.com>
In-Reply-To: <933519a8-faaf-644c-4368-bc92cfab937f@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Mar 2021 16:44:49 +0100
Message-ID: <CAJZ5v0gS3vPn+rcpiuAxXfwcTY7s-Lrbp3+oq8+=oRVGofe18Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: x86: Reserve memory occupied by ACPI tables
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        x86 Maintainers <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 24, 2021 at 4:42 PM George Kennedy
<george.kennedy@oracle.com> wrote:
>
>
>
> On 3/24/2021 9:27 AM, Rafael J. Wysocki wrote:
> > On Wed, Mar 24, 2021 at 9:24 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >> On Tue, Mar 23, 2021 at 08:26:52PM +0100, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> The following problem has been reported by George Kennedy:
> >>>
> >>>   Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
> >>>   in __free_pages_core()") the following use after free occurs
> >>>   intermittently when ACPI tables are accessed.
> >>>
> >>>   BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
> >>>   Read of size 4 at addr ffff8880be453004 by task swapper/0/1
> >>>   CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
> >>>   Call Trace:
> >>>    dump_stack+0xf6/0x158
> >>>    print_address_description.constprop.9+0x41/0x60
> >>>    kasan_report.cold.14+0x7b/0xd4
> >>>    __asan_report_load_n_noabort+0xf/0x20
> >>>    ibft_init+0x134/0xc49
> >>>    do_one_initcall+0xc4/0x3e0
> >>>    kernel_init_freeable+0x5af/0x66b
> >>>    kernel_init+0x16/0x1d0
> >>>    ret_from_fork+0x22/0x30
> >>>
> >>>   ACPI tables mapped via kmap() do not have their mapped pages
> >>>   reserved and the pages can be "stolen" by the buddy allocator.
> >>>
> >>> Apparently, on the affected system, the ACPI table in question is
> >>> not located in "reserved" memory, like ACPI NVS or ACPI Data, that
> >>> will not be used by the buddy allocator, so the memory occupied by
> >>> that table has to be explicitly reserved to prevent the buddy
> >>> allocator from using it.
> >>>
> >>> In order to address this problem, rearrange the initialization of the
> >>> ACPI tables on x86 to locate the initial tables earlier and reserve
> >>> the memory occupied by them.
> >>>
> >>> The other architectures using ACPI should not be affected by this
> >>> change.
> >>>
> >>> Link: https://lore.kernel.org/linux-acpi/1614802160-29362-1-git-send-email-george.kennedy@oracle.com/
> >>> Reported-by: George Kennedy <george.kennedy@oracle.com>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> FWIW:
> >> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > Thank you!
> >
> > George, can you please try this patch on the affected system?
>
> Rafael,
>
> 10 for 10 successful reboots with your patch.
>
> First, verified the failure is still there with latest 5.12.0-rc4.

Thank you!

I'll add a Tested-by from you to it, then.
