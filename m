Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DED76114
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGZIoK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jul 2019 04:44:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfGZIoK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jul 2019 04:44:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40DBAAD5E;
        Fri, 26 Jul 2019 08:44:09 +0000 (UTC)
Date:   Fri, 26 Jul 2019 10:44:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
Message-ID: <20190726084408.GK6142@dhcp22.suse.cz>
References: <20190725125636.GA3582@dhcp22.suse.cz>
 <6dc566c2-faf6-565d-4ef1-2ac3a366bc76@redhat.com>
 <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
 <20190725191943.GA6142@dhcp22.suse.cz>
 <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
 <20190726075729.GG6142@dhcp22.suse.cz>
 <fd9e8495-1a93-ac47-442f-081d392ed09b@redhat.com>
 <20190726083117.GJ6142@dhcp22.suse.cz>
 <38d76051-504e-c81a-293a-0b0839e829d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d76051-504e-c81a-293a-0b0839e829d3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri 26-07-19 10:36:42, David Hildenbrand wrote:
> On 26.07.19 10:31, Michal Hocko wrote:
[...]
> > Anyway, my dislike of the device_hotplug_lock persists. I would really
> > love to see it go rather than grow even more to the hotplug code. We
> > should be really striving for mem hotplug internal and ideally range
> > defined locking longterm. 
> 
> Yes, and that is a different story, because it will require major
> changes to all add_memory() users. (esp, due to the documented race
> conditions). Having that said, memory hotplug locking is not ideal yet.

I am really happy to hear that we are on the same page here. Do we have
any document (I am sorry but I am lacking behind recent development in
this area) that describes roadblocks to remove device_hotplug_lock?
-- 
Michal Hocko
SUSE Labs
