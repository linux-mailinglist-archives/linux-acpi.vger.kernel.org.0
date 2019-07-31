Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A595D7C30B
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfGaNOK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Jul 2019 09:14:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfGaNOK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jul 2019 09:14:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 712F5AE21;
        Wed, 31 Jul 2019 13:14:09 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:14:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Fixup "acquire
 device_hotplug_lock in acpi_scan_init()"
Message-ID: <20190731131408.GP9330@dhcp22.suse.cz>
References: <20190731123201.13893-1-david@redhat.com>
 <20190731125334.GM9330@dhcp22.suse.cz>
 <d3cc595d-7e6f-ef6f-044c-b20bd1de3fb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cc595d-7e6f-ef6f-044c-b20bd1de3fb0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 31-07-19 15:02:49, David Hildenbrand wrote:
> On 31.07.19 14:53, Michal Hocko wrote:
> > On Wed 31-07-19 14:32:01, David Hildenbrand wrote:
> >> Let's document why we take the lock here. If we're going to overhaul
> >> memory hotplug locking, we'll have to touch many places - this comment
> >> will help to clairfy why it was added here.
> > 
> > And how exactly is "lock for consistency" comment going to help the poor
> > soul touching that code? How do people know that it is safe to remove it?
> > I am not going to repeat my arguments how/why I hate "locking for
> > consistency" (or fun or whatever but a real synchronization reasons)
> > but if you want to help then just explicitly state what should done to
> > remove this lock.
> > 
> 
> I know that you have a different opinion here. To remove the lock,
> add_memory() locking has to be changed *completely* to the point where
> we can drop the lock from the documentation of the function (*whoever
> knows what we have to exactly change* - and I don't have time to do that
> *right now*).

Not really. To remove a lock in this particular path it would be
sufficient to add
	/*
	 * Although __add_memory used down the road is documented to
	 * require lock_device_hotplug, it is not necessary here because
	 * this is an early code when userspace or any other code path
	 * cannot trigger hotplug operations.
	 */

Now that is a useful comment because it documents an exception and gives
you reasoning. If the above statement ever turns out to be incorrect due
to later changes then you can replace it with the lock and the new
reasoning.

But "just for consistency argument" doesn't tell you much when
scratching your head in the future and trying to figure out whether that
consistency argument still applies or there are new reasons the lock is
still needed.
-- 
Michal Hocko
SUSE Labs
