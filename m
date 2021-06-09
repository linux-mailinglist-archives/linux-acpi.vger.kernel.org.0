Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD943A1C60
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhFIRxd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 13:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231873AbhFIRxb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 13:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623261096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LDnuAzrmrDQnj1kMe7z9bfcxYs5KpfPfk3851+HN8rM=;
        b=SGdwoJgeSELVR/xfYT1PbVPTfuPOYTG1Ljfnnsa4ZQSBJ9SwGyzpeW+s31qF31L0Fx4Xci
        nD4LwFkkyRhQu3KONdJwKhplpB9sAJR3JwkgKOyWoMv1CfyvsmjNCkxfwuhxdYOkCWny3L
        krjOwkcykuXXWK/zZk33J5cqm/rWtjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-G0gEp-T1PFmMJw46BJnklw-1; Wed, 09 Jun 2021 13:51:33 -0400
X-MC-Unique: G0gEp-T1PFmMJw46BJnklw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C6F2101F7A3;
        Wed,  9 Jun 2021 17:51:32 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-55.ams2.redhat.com [10.36.113.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6311001281;
        Wed,  9 Jun 2021 17:51:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: Remove redundant clearing of context->ret.pointer from acpi_run_osc()
Date:   Wed,  9 Jun 2021 19:51:30 +0200
Message-Id: <20210609175130.224274-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

context->ret.pointer already gets set to NULL at the beginning of
acpi_run_osc() and it only gets assigned a new value in the success
path near the end of acpi_run_osc(), so the clearing of
context->ret.pointer (when status != AE_OK) at the end of
acpi_run_osc() is redundant since it will always already be NULL when
status != AE_OK.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a4bd673934c0..ab41185cd2a8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -262,8 +262,6 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 
 out_kfree:
 	kfree(output.pointer);
-	if (status != AE_OK)
-		context->ret.pointer = NULL;
 	return status;
 }
 EXPORT_SYMBOL(acpi_run_osc);
-- 
2.31.1

