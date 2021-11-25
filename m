Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE545D853
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 11:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhKYKli (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 05:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347736AbhKYKji (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 05:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637836587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rj/+BdtxxqMjfAndWn4bKVjlengUFC8Pa+4X7IknJMY=;
        b=O7b0/Ka6B6d2gCZsNTCgZIlDJL80EyO0Ko/uMByNSGU4+eeMg+jpCQV8afjyzhSlRpDQuX
        LMdSE29BxW6rt1Y+Pzq8dMukHjwlvOQVWe5/Bu6Avy+WnlQ8u8XD/SzZyjZfsRrXcQVBqe
        DevM9zsvPfrIMQrLtCZPAivRqKQGQOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-HcIRK1aKNTqtfjGSGo95iQ-1; Thu, 25 Nov 2021 05:36:20 -0500
X-MC-Unique: HcIRK1aKNTqtfjGSGo95iQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D1DD1800D41;
        Thu, 25 Nov 2021 10:36:19 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.195.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0308C2271F;
        Thu, 25 Nov 2021 10:36:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>
Subject: [PATCH] ACPI / EC: Mark the ec_sys write_support param as module_param_hw()
Date:   Thu, 25 Nov 2021 11:36:16 +0100
Message-Id: <20211125103616.47742-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Using write_support=1 with the ec_sys module changes the mode of the
"io" debugfs file to 0600. This will cause any attempts to access it under
a kernel in lockdown mode to return -EPERM, which makes the entire ec_sys
module unusable.

Use the special module_param_hw() macro for module parameters which
may not be used while in lockdown mode, to avoid this.

Cc: Mark Pearson <markpearson@lenovo.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ec_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index fd39c14493ab..c074a0fae059 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -19,7 +19,7 @@ MODULE_DESCRIPTION("ACPI EC sysfs access driver");
 MODULE_LICENSE("GPL");
 
 static bool write_support;
-module_param(write_support, bool, 0644);
+module_param_hw(write_support, bool, other, 0644);
 MODULE_PARM_DESC(write_support, "Dangerous, reboot and removal of battery may "
 		 "be needed.");
 
-- 
2.33.1

