Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B10265E2D
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Sep 2020 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgIKKgk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Sep 2020 06:36:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31252 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgIKKgI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Sep 2020 06:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599820566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcPWZv9PYAHyw7ygKg8TV8AW3ZEfFOjouUb95Y7pmVU=;
        b=U5Ur8RRHZosiMT46QmThdNtOTYxMN4LERxUDr/zUrV1aB0WS1kRYr/1+XjXZWAYXCjNUm1
        ddFrWvq5YRojmgGhyHb0Y1Eisa5c/sjfjZeUax1zHIczYWQH+T0Q9nTNAQSGXAqAr+z9Ge
        4pG2FiMIFkQd2qN2NGsPeV4VOtsiGsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-8nXwlIW-OjOX_tpbFlQW3g-1; Fri, 11 Sep 2020 06:36:03 -0400
X-MC-Unique: 8nXwlIW-OjOX_tpbFlQW3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF911008301;
        Fri, 11 Sep 2020 10:36:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-186.ams2.redhat.com [10.36.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B94C81C49;
        Fri, 11 Sep 2020 10:35:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpmt@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v4 7/8] xen/balloon: try to merge system ram resources
Date:   Fri, 11 Sep 2020 12:34:58 +0200
Message-Id: <20200911103459.10306-8-david@redhat.com>
In-Reply-To: <20200911103459.10306-1-david@redhat.com>
References: <20200911103459.10306-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's try to merge system ram resources we add, to minimize the number
of resources in /proc/iomem. We don't care about the boundaries of
individual chunks we added.

Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Andrew Morton <akpmt@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Julien Grall <julien@xen.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 9f40a294d398d..b57b2067ecbfb 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -331,7 +331,7 @@ static enum bp_state reserve_additional_memory(void)
 	mutex_unlock(&balloon_mutex);
 	/* add_memory_resource() requires the device_hotplug lock */
 	lock_device_hotplug();
-	rc = add_memory_resource(nid, resource, MHP_NONE);
+	rc = add_memory_resource(nid, resource, MEMHP_MERGE_RESOURCE);
 	unlock_device_hotplug();
 	mutex_lock(&balloon_mutex);
 
-- 
2.26.2

