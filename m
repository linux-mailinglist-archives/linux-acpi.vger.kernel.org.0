Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992D17638D
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 12:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfGZKbP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jul 2019 06:31:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:47874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbfGZKbP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jul 2019 06:31:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58D0DAEAF;
        Fri, 26 Jul 2019 10:31:13 +0000 (UTC)
Date:   Fri, 26 Jul 2019 12:31:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
Message-ID: <20190726103112.GL6142@dhcp22.suse.cz>
References: <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
 <20190725191943.GA6142@dhcp22.suse.cz>
 <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
 <20190726075729.GG6142@dhcp22.suse.cz>
 <fd9e8495-1a93-ac47-442f-081d392ed09b@redhat.com>
 <20190726083117.GJ6142@dhcp22.suse.cz>
 <38d76051-504e-c81a-293a-0b0839e829d3@redhat.com>
 <20190726084408.GK6142@dhcp22.suse.cz>
 <45c9f942-fe67-fa60-b62f-31867f9c6e53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c9f942-fe67-fa60-b62f-31867f9c6e53@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri 26-07-19 10:57:52, David Hildenbrand wrote:
> On 26.07.19 10:44, Michal Hocko wrote:
> > On Fri 26-07-19 10:36:42, David Hildenbrand wrote:
> >> On 26.07.19 10:31, Michal Hocko wrote:
> > [...]
> >>> Anyway, my dislike of the device_hotplug_lock persists. I would really
> >>> love to see it go rather than grow even more to the hotplug code. We
> >>> should be really striving for mem hotplug internal and ideally range
> >>> defined locking longterm. 
> >>
> >> Yes, and that is a different story, because it will require major
> >> changes to all add_memory() users. (esp, due to the documented race
> >> conditions). Having that said, memory hotplug locking is not ideal yet.
> > 
> > I am really happy to hear that we are on the same page here. Do we have
> > any document (I am sorry but I am lacking behind recent development in
> > this area) that describes roadblocks to remove device_hotplug_lock?
> 
> Only the core-api document I mentioned (I documented there quite some
> current conditions I identified back then).

That document doesn't describe which _data structures_ are protected by
the lock though. It documents only the current state of locking.

> I am not sure if we can remove it completely from
> add_memory()/remove_memory(): We actually create/delete devices which
> can otherwise create races with user space.

More details would be really appreciated.

> Besides that:
> - try_offline_node() needs the lock to synchronize against cpu hotplug
> - I *assume* try_online_node() needs it as well

more details on why would be great.

> Then, there is the possible race condition with user space onlining
> memory avoided by the lock. Also, currently the lock protects the
> "online_type" when onlining memory.

I do not see the race, if the user API triggered online/offline takes a
range lock on the affected physical memory range

> Then, there might be other global variables (eventually
> zone/node/section related) that might need this lock right now - no
> details known.

zones/nodes have their own locking for spans. Sections should be using
a low level locking but I am not really sure this is needed if there is
a mem hotplug lock in place (range or global)

> IOW, we have to be very carefully and it is more involved than it might
> seem.

I am not questioning that. And that is why I am asking about a todo list
for that transition.

> Locking is definitely better (and more reliably!) than one year ago, but
> there is definitely a lot to do. (unfortunately, just like in many areas
> in memory hotplug code :( - say zone handling when offlining/failing to
> online memory).

Yeah, the code is shaping up. And I am happy to see that happening. But
please try to understand that I really do not like to see some ad-hoc
locking enforcement without a clear locking model in place. This patch
is an example of it. Whoever would like to rationalize locking further
will have to stumble over this and scratch head why the hack the locking
is there and my experience tells me that people usually go along with
existing code and make further assumptions based on that so we are
unlikely to get rid of the locking...
-- 
Michal Hocko
SUSE Labs
