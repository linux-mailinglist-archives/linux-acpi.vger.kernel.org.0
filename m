Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A9536CB57
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhD0SzX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Apr 2021 14:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236889AbhD0SzW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Apr 2021 14:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619549678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SEt3Zizca67SuoXjsRTLcir+vAvjzN+U+jVjcjuIJKQ=;
        b=h6lYiwg1XZ3eld9LH2EqQmVkGlGP1EP1o4vQ39e5cXD5j5+/fTYf+QyttENHctaVgh6pEq
        OJMbR8XuNi21KFlXxTSasODu6IFMjJ2CrVoskUsWTq6PZBXgf3qNwHHgTJZrOi89ijKPXi
        8s5ShyogibvKg/CUQdfBjmBiHO4rJP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-06PqNkX5OcWGa8q3X8VnOg-1; Tue, 27 Apr 2021 14:54:36 -0400
X-MC-Unique: 06PqNkX5OcWGa8q3X8VnOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7451A8014C1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Apr 2021 18:54:35 +0000 (UTC)
Received: from redhatnow.users.ipa.redhat.com (ovpn-113-173.phx2.redhat.com [10.3.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A0C719714
        for <linux-acpi@vger.kernel.org>; Tue, 27 Apr 2021 18:54:35 +0000 (UTC)
From:   Mark Langsdorf <mlangsdo@redhat.com>
To:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: custom_method: fix a possible memory leak
Date:   Tue, 27 Apr 2021 13:54:33 -0500
Message-Id: <20210427185434.34885-1-mlangsdo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In cm_write(), if the 'buf' is allocated memory but not fully consumed,
it is possible to reallocate the buffer without freeing it by passing
'*ppos' as 0 on a subsequent call.

Add an explicit kfree() before kzalloc() to prevent the possible memory
leak.

Fixes: 526b4af47f44 ("ACPI: Split out custom_method functionality into an own driver")
Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 drivers/acpi/custom_method.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 443fdf62dd22..6dc96f2cef1d 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -42,6 +42,8 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 				   sizeof(struct acpi_table_header)))
 			return -EFAULT;
 		uncopied_bytes = max_size = table.length;
+		/* make sure the buf is not allocated */
+		kfree(buf);
 		buf = kzalloc(max_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
-- 
2.26.3

