Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF17C3DC
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfGaNoY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Jul 2019 09:44:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:40070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfGaNoY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jul 2019 09:44:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8AA4ABD0;
        Wed, 31 Jul 2019 13:44:22 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:44:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Fixup "acquire
 device_hotplug_lock in acpi_scan_init()"
Message-ID: <20190731134422.GS9330@dhcp22.suse.cz>
References: <20190731123201.13893-1-david@redhat.com>
 <20190731125334.GM9330@dhcp22.suse.cz>
 <d3cc595d-7e6f-ef6f-044c-b20bd1de3fb0@redhat.com>
 <20190731131408.GP9330@dhcp22.suse.cz>
 <23f28590-7765-bcd9-15f2-94e985b64218@redhat.com>
 <20190731133344.GR9330@dhcp22.suse.cz>
 <b135e167-a0e1-0772-559b-6375ea40c9c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b135e167-a0e1-0772-559b-6375ea40c9c4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 31-07-19 15:37:56, David Hildenbrand wrote:
[...]
> The other extreme I saw: People dropping locks because they think they
> can be smart but end up making developers debug crashes for months (I am
> not lying).

Any lock removal should be accompanied with an explanation that is to be
a subject of the review. Sure people can make mistakes but there is no
way to around it I can see.
 
> As I want to move on with this patch and have other stuff to work on, I
> will adjust the comment you gave and add that instead of the lock.

Thanks!

-- 
Michal Hocko
SUSE Labs
