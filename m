Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5E369628
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhDWP27 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 11:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhDWP26 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 11:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619191702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IE04CqF9RHUsW0AvlcDxMmLQRo8yrNxWZ072sc2mrCs=;
        b=G+afSFlAhg71HDOgK4TR8Gv4t9NGY7xvrUHeyNopvbTPEuhqFOhdInY+lsjx2hlEqisCKa
        DIiqpXQCr+wLu+cv3aSWG1ctg4yReghbj+wIiwAS1AZBRt2jeVDWqS7lyt4zcOErNb0RiM
        vq/T2SJtsnhGzthhIVxziu2hBcyCdSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-Y46JNLW4MHCKAMUX7F3uOw-1; Fri, 23 Apr 2021 11:28:20 -0400
X-MC-Unique: Y46JNLW4MHCKAMUX7F3uOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748671922960
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 15:28:19 +0000 (UTC)
Received: from redhatnow.users.ipa.redhat.com (ovpn-112-207.phx2.redhat.com [10.3.112.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B2B160BD8
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 15:28:19 +0000 (UTC)
From:   Mark Langsdorf <mlangsdo@redhat.com>
To:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: custom_method: fix potential use-after-free issue
Date:   Fri, 23 Apr 2021 10:28:17 -0500
Message-Id: <20210423152818.97077-1-mlangsdo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In cm_write(), buf is always freed when reaching the end of the
function.  If the requested count is less than table.length, the
allocated buffer will be freed but subsequent calls to cm_write() will
still try to access it.

Remove the unconditional kfree(buf) at the end of the function and
set the buf to NULL in the -EINVAL error path to match the rest of
function.

Fixes: 03d1571d9513 ("ACPI: custom_method: fix memory leaks")
Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 drivers/acpi/custom_method.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 443fdf62dd22..8844f895f9be 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -55,6 +55,7 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 	    (*ppos + count < count) ||
 	    (count > uncopied_bytes)) {
 		kfree(buf);
+		buf = NULL;
 		return -EINVAL;
 	}
 
@@ -76,7 +77,6 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
-	kfree(buf);
 	return count;
 }
 
-- 
2.26.3

