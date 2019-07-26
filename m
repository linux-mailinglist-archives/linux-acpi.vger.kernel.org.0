Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09537603B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfGZH5b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jul 2019 03:57:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZH5b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jul 2019 03:57:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6042B01F;
        Fri, 26 Jul 2019 07:57:29 +0000 (UTC)
Date:   Fri, 26 Jul 2019 09:57:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
Message-ID: <20190726075729.GG6142@dhcp22.suse.cz>
References: <20190724143017.12841-1-david@redhat.com>
 <20190725125636.GA3582@dhcp22.suse.cz>
 <6dc566c2-faf6-565d-4ef1-2ac3a366bc76@redhat.com>
 <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
 <20190725191943.GA6142@dhcp22.suse.cz>
 <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu 25-07-19 22:49:36, David Hildenbrand wrote:
> On 25.07.19 21:19, Michal Hocko wrote:
[...]
> > We need to rationalize the locking here, not to add more hacks.
> 
> No, sorry. The real hack is calling a function that is *documented* to
> be called under lock without it. That is an optimization for a special
> case. That is the black magic in the code.

OK, let me ask differently. What does the device_hotplug_lock actually
protects from in the add_memory path? (Which data structures)

This function is meant to be used when struct pages and node/zone data
structures should be updated. Why should we even care about some device
concept here? This should all be handled a layer up. Not all memory will
have user space API to control online/offline state.
-- 
Michal Hocko
SUSE Labs
