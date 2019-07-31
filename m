Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9647A7C3A2
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725209AbfGaNdq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Jul 2019 09:33:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfGaNdq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jul 2019 09:33:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C41B9AFCF;
        Wed, 31 Jul 2019 13:33:44 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:33:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Fixup "acquire
 device_hotplug_lock in acpi_scan_init()"
Message-ID: <20190731133344.GR9330@dhcp22.suse.cz>
References: <20190731123201.13893-1-david@redhat.com>
 <20190731125334.GM9330@dhcp22.suse.cz>
 <d3cc595d-7e6f-ef6f-044c-b20bd1de3fb0@redhat.com>
 <20190731131408.GP9330@dhcp22.suse.cz>
 <23f28590-7765-bcd9-15f2-94e985b64218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f28590-7765-bcd9-15f2-94e985b64218@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 31-07-19 15:18:42, David Hildenbrand wrote:
> On 31.07.19 15:14, Michal Hocko wrote:
> > On Wed 31-07-19 15:02:49, David Hildenbrand wrote:
> >> On 31.07.19 14:53, Michal Hocko wrote:
> >>> On Wed 31-07-19 14:32:01, David Hildenbrand wrote:
> >>>> Let's document why we take the lock here. If we're going to overhaul
> >>>> memory hotplug locking, we'll have to touch many places - this comment
> >>>> will help to clairfy why it was added here.
> >>>
> >>> And how exactly is "lock for consistency" comment going to help the poor
> >>> soul touching that code? How do people know that it is safe to remove it?
> >>> I am not going to repeat my arguments how/why I hate "locking for
> >>> consistency" (or fun or whatever but a real synchronization reasons)
> >>> but if you want to help then just explicitly state what should done to
> >>> remove this lock.
> >>>
> >>
> >> I know that you have a different opinion here. To remove the lock,
> >> add_memory() locking has to be changed *completely* to the point where
> >> we can drop the lock from the documentation of the function (*whoever
> >> knows what we have to exactly change* - and I don't have time to do that
> >> *right now*).
> > 
> > Not really. To remove a lock in this particular path it would be
> > sufficient to add
> > 	/*
> > 	 * Although __add_memory used down the road is documented to
> > 	 * require lock_device_hotplug, it is not necessary here because
> > 	 * this is an early code when userspace or any other code path
> > 	 * cannot trigger hotplug operations.
> > 	 */
> 
> Okay, let me phrase it like this: Are you 100% (!) sure that we don't
> need the lock here. I am not -  I only know what I documented back then
> and what I found out - could be that we are forgetting something else
> the lock protects.
> 
> As I already said, I am fine with adding such a comment instead. But I
> am not convinced that the absence of the lock is 100% safe. (I am 99.99%
> sure ;) ).

I am sorry but this is a shiny example of cargo cult programming. You do
not add locks just because you are not sure. Locks are protecting data
structures not code paths! If it is not clear what is actually protected
then that should be explored first before the lock is spread "just to be
sure"

Just look here. You have pushed that uncertainty to whoever is going
touch this code and guess what, they are going to follow that lead and
we are likely to grow the unjustified usage and any further changes will
be just harder. I have seen that pattern so many times that it is even
not funny. And that's why I pushed back here.

So let me repeat. If the lock is to stay then make sure that the comment
actually explains what has to be done to remove it because it is not
really required as of now.

-- 
Michal Hocko
SUSE Labs
