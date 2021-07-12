Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658023C5C72
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhGLMoR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 08:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233843AbhGLMoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 08:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626093687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qEbDQXGhHEIQfXJJ1NDA7WskESqj8IOu7J2/Cf7/u6Q=;
        b=Fs9CXKbGTKina7mFGIErfcSJizxtVYM/EAiaRIGse6BQP2OcL+UNviTMEKgOYl17mMcoF2
        xZKaj8KjV45vyXdzvpbJXD0Y4yaEsu6gLbTD9OXVDTNqgKiFZPCKxYeY/cup5OLxzqqwSb
        kei8JGwPG1iwLTcC5bbrRGm1tePS4yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-VADwkUjmOYKhbpMmcyul4g-1; Mon, 12 Jul 2021 08:41:26 -0400
X-MC-Unique: VADwkUjmOYKhbpMmcyul4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A5AB802C87;
        Mon, 12 Jul 2021 12:41:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-111.rdu2.redhat.com [10.10.113.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 285555C1D1;
        Mon, 12 Jul 2021 12:40:53 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jia He <justin.he@arm.com>, Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rich Felker <dalias@libc.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: mm/memory_hotplug: preparatory patches for new online policy and memory
Date:   Mon, 12 Jul 2021 14:40:48 +0200
Message-Id: <20210712124052.26491-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

these are all cleanups and one fix previously sent as part of [1]:
	[PATCH v1 00/12] mm/memory_hotplug: "auto-movable" online policy
	and memory groups

These patches make sense even without the other series, therefore I pulled
them out to make the other series easier to digest.

[1] https://lkml.kernel.org/r/20210607195430.48228-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-acpi@vger.kernel.org

David Hildenbrand (4):
  mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()
  mm/memory_hotplug: remove nid parameter from arch_remove_memory()
  mm/memory_hotplug: remove nid parameter from remove_memory() and
    friends
  ACPI: memhotplug: memory resources cannot be enabled yet

 arch/arm64/mm/mmu.c                           |  3 +-
 arch/ia64/mm/init.c                           |  3 +-
 arch/powerpc/mm/mem.c                         |  3 +-
 .../platforms/pseries/hotplug-memory.c        |  9 +++--
 arch/s390/mm/init.c                           |  3 +-
 arch/sh/mm/init.c                             |  3 +-
 arch/x86/mm/init_32.c                         |  3 +-
 arch/x86/mm/init_64.c                         |  3 +-
 drivers/acpi/acpi_memhotplug.c                | 11 +-----
 drivers/dax/kmem.c                            |  3 +-
 drivers/virtio/virtio_mem.c                   |  4 +--
 include/linux/memory_hotplug.h                | 17 +++++----
 mm/memory_hotplug.c                           | 36 +++++++++++--------
 mm/memremap.c                                 |  5 +--
 14 files changed, 45 insertions(+), 61 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.31.1

