Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFE27B45A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Sep 2020 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1SVy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Sep 2020 14:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgI1SVy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Sep 2020 14:21:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601317313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85B0mZRKs5mkl5E8BDbfnUinjf/rtUnPl3Qk/CJCPXg=;
        b=Pd5ifQU2liRV0lnmVrW6JnQW8ZxOFN9yHvXVDBv/YIbVkUHHqOkche1SWgQ8aHMGyjUfb9
        Q/l7XZlG+Rq5vcUHSofLm3C/lRCKalwKhjYadsnPj/agrdwCc28bywIfVMA0BxzAzT44DA
        qfg63DvarH4xiKg3/ENhbZHZ2XIbx1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-NY6l3ukFNlmJxz48QH7ihg-1; Mon, 28 Sep 2020 14:21:51 -0400
X-MC-Unique: NY6l3ukFNlmJxz48QH7ihg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F39EC8015AA;
        Mon, 28 Sep 2020 18:21:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B58827CD4;
        Mon, 28 Sep 2020 18:21:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v1 5/5] mm/memory_hotplug: update comment regarding zone shuffling
Date:   Mon, 28 Sep 2020 20:21:10 +0200
Message-Id: <20200928182110.7050-6-david@redhat.com>
In-Reply-To: <20200928182110.7050-1-david@redhat.com>
References: <20200928182110.7050-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As we no longer shuffle via generic_online_page() and when undoing
isolation, we can simplify the comment.

We now effectively shuffle only once (properly) when onlining new
memory.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9db80ee29caa..c589bd8801bb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -859,13 +859,10 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
 
 	/*
-	 * When exposing larger, physically contiguous memory areas to the
-	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
-	 * them either to the head or the tail of the freelist) is only helpful
-	 * for maintaining the shuffle, but not for creating the initial
-	 * shuffle. Shuffle the whole zone to make sure the just onlined pages
-	 * are properly distributed across the whole freelist. Make sure to
-	 * shuffle once pageblocks are no longer isolated.
+	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
+	 * the tail of the freelist when undoing isolation). Shuffle the whole
+	 * zone to make sure the just onlined pages are properly distributed
+	 * across the whole freelist - to create an initial shuffle.
 	 */
 	shuffle_zone(zone);
 
-- 
2.26.2

