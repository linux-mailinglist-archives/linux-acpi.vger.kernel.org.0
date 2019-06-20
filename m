Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1494CC01
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfFTKfo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 06:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFTKfn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jun 2019 06:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1A41C1EB202;
        Thu, 20 Jun 2019 10:35:34 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-88.ams2.redhat.com [10.36.117.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A49D608A7;
        Thu, 20 Jun 2019 10:35:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Banman <andrew.banman@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arun KS <arunks@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juergen Gross <jgross@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Len Brown <lenb@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 0/6] mm: Further memory block device cleanups
Date:   Thu, 20 Jun 2019 12:35:14 +0200
Message-Id: <20190620103520.23481-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 20 Jun 2019 10:35:43 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

@Andrew: Only patch 1 and 6 changed. The patches are based on the
same state as the previous patches (replace the old ones if possible).

Some further cleanups around memory block devices. Especially, clean up
and simplify walk_memory_range(). Including some other minor cleanups.

Compiled + tested on x86 with DIMMs under QEMU.

v1 -> v2:
- "mm: Section numbers use the type "unsigned long""
-- "unsigned long i" -> "unsigned long nr", in one case -> "int i"
- "drivers/base/memory.c: Get rid of find_memory_block_hinted("
-- Fix compilation error
-- Get rid of the "hint" parameter completely

David Hildenbrand (6):
  mm: Section numbers use the type "unsigned long"
  drivers/base/memory: Use "unsigned long" for block ids
  mm: Make register_mem_sect_under_node() static
  mm/memory_hotplug: Rename walk_memory_range() and pass start+size
    instead of pfns
  mm/memory_hotplug: Move and simplify walk_memory_blocks()
  drivers/base/memory.c: Get rid of find_memory_block_hinted()

 arch/powerpc/platforms/powernv/memtrace.c |  22 ++---
 drivers/acpi/acpi_memhotplug.c            |  19 +---
 drivers/base/memory.c                     | 115 ++++++++++++++--------
 drivers/base/node.c                       |   8 +-
 include/linux/memory.h                    |   5 +-
 include/linux/memory_hotplug.h            |   2 -
 include/linux/mmzone.h                    |   4 +-
 include/linux/node.h                      |   7 --
 mm/memory_hotplug.c                       |  57 +----------
 mm/sparse.c                               |  12 +--
 10 files changed, 105 insertions(+), 146 deletions(-)

-- 
2.21.0

