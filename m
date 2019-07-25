Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD57757B9
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfGYTTr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 15:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:34164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbfGYTTr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 15:19:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFC79ADD9;
        Thu, 25 Jul 2019 19:19:44 +0000 (UTC)
Date:   Thu, 25 Jul 2019 21:19:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
Message-ID: <20190725191943.GA6142@dhcp22.suse.cz>
References: <20190724143017.12841-1-david@redhat.com>
 <20190725125636.GA3582@dhcp22.suse.cz>
 <6dc566c2-faf6-565d-4ef1-2ac3a366bc76@redhat.com>
 <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu 25-07-19 16:35:07, David Hildenbrand wrote:
> On 25.07.19 15:57, Michal Hocko wrote:
> > On Thu 25-07-19 15:05:02, David Hildenbrand wrote:
> >> On 25.07.19 14:56, Michal Hocko wrote:
> >>> On Wed 24-07-19 16:30:17, David Hildenbrand wrote:
> >>>> We end up calling __add_memory() without the device hotplug lock held.
> >>>> (I used a local patch to assert in __add_memory() that the
> >>>>  device_hotplug_lock is held - I might upstream that as well soon)
> >>>>
> >>>> [   26.771684]        create_memory_block_devices+0xa4/0x140
> >>>> [   26.772952]        add_memory_resource+0xde/0x200
> >>>> [   26.773987]        __add_memory+0x6e/0xa0
> >>>> [   26.775161]        acpi_memory_device_add+0x149/0x2b0
> >>>> [   26.776263]        acpi_bus_attach+0xf1/0x1f0
> >>>> [   26.777247]        acpi_bus_attach+0x66/0x1f0
> >>>> [   26.778268]        acpi_bus_attach+0x66/0x1f0
> >>>> [   26.779073]        acpi_bus_attach+0x66/0x1f0
> >>>> [   26.780143]        acpi_bus_scan+0x3e/0x90
> >>>> [   26.780844]        acpi_scan_init+0x109/0x257
> >>>> [   26.781638]        acpi_init+0x2ab/0x30d
> >>>> [   26.782248]        do_one_initcall+0x58/0x2cf
> >>>> [   26.783181]        kernel_init_freeable+0x1bd/0x247
> >>>> [   26.784345]        kernel_init+0x5/0xf1
> >>>> [   26.785314]        ret_from_fork+0x3a/0x50
> >>>>
> >>>> So perform the locking just like in acpi_device_hotplug().
> >>>
> >>> While playing with the device_hotplug_lock, can we actually document
> >>> what it is protecting please? I have a bad feeling that we are adding
> >>> this lock just because some other code path does rather than with a good
> >>> idea why it is needed. This patch just confirms that. What exactly does
> >>> the lock protect from here in an early boot stage.
> >>
> >> We have plenty of documentation already
> >>
> >> mm/memory_hotplug.c
> >>
> >> git grep -C5 device_hotplug mm/memory_hotplug.c
> >>
> >> Also see
> >>
> >> Documentation/core-api/memory-hotplug.rst
> > 
> > OK, fair enough. I was more pointing to a documentation right there
> > where the lock is declared because that is the place where people
> > usually check for documentation. The core-api documentation looks quite
> > nice. And based on that doc it seems that this patch is actually not
> > needed because neither the online/offline or cpu hotplug should be
> > possible that early unless I am missing something.
> 
> I really prefer to stick to locking rules as outlined on the
> interfaces if it doesn't hurt. Why it is not needed is not clear.
> 
> > 
> >> Regarding the early stage: primarily lockdep as I mentioned.
> > 
> > Could you add a lockdep splat that would be fixed by this patch to the
> > changelog for reference?
> > 
> 
> I have one where I enforce what's documented (but that's of course not
> upstream and therefore not "real" yet)

Then I suppose to not add locking for something that is not a problem.
Really, think about it. People will look at this code and follow the
lead without really knowing why the locking is needed.
device_hotplug_lock has its purpose and if the code in question doesn't
need synchronization for the documented scenarios then the locking
simply shouldn't be there. Adding the lock just because of a
non-existing, and IMHO dubious, lockdep splats is just wrong.

We need to rationalize the locking here, not to add more hacks.

-- 
Michal Hocko
SUSE Labs
