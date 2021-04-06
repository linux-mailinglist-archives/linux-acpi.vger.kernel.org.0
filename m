Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78614355DB9
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbhDFVRI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 17:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238577AbhDFVRI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2021 17:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617743819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KJUn2ssf/ULcrdCSKFDPTC4Gfd9s1AfVOAzFNeb3+Q4=;
        b=GoR8t//7cTpv1/UfPd8TVdLi26IbFDcGn3sA43PY+1fTFRWkzJ+RbJ3X2D/Tb0JgjfmL3s
        2zKiofO2MoUz7GQH4/19vO+rbdUYi0Yr3OEzw2n6G680ukb42mHFdJZgKC79CAlWlVKAqn
        AUMBlxlPt6WbDT2/ngeErmtRjh8Xc7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-vJX9QZhUPdig9HOkf3w2NA-1; Tue, 06 Apr 2021 17:16:57 -0400
X-MC-Unique: vJX9QZhUPdig9HOkf3w2NA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100AA8030D6;
        Tue,  6 Apr 2021 21:16:56 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6465D6EF54;
        Tue,  6 Apr 2021 21:16:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: utils: Add acpi_reduced_hardware() helper
Date:   Tue,  6 Apr 2021 23:16:52 +0200
Message-Id: <20210406211653.182338-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a getter for the acpi_gbl_reduced_hardware variable so that modules
can check if they are running on an ACPI reduced-hw platform or not.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/utils.c    | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 682edd913b3b..4cb061d3169a 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -872,6 +872,17 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 }
 EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
 
+/**
+ * acpi_reduced_hardware - Return if this is an ACPI-reduced-hw machine
+ *
+ * Return true when running on an ACPI-reduced-hw machine, false otherwise.
+ */
+bool acpi_reduced_hardware(void)
+{
+	return acpi_gbl_reduced_hardware;
+}
+EXPORT_SYMBOL(acpi_reduced_hardware);
+
 /*
  * acpi_backlight= handling, this is done here rather then in video_detect.c
  * because __setup cannot be used in modules.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f28b097c658f..d631cb52283e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -78,6 +78,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 
 bool acpi_dev_found(const char *hid);
 bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
+bool acpi_reduced_hardware(void);
 
 #ifdef CONFIG_ACPI
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3bdcfc4401b7..e2e6db8313c8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -748,6 +748,11 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 	return NULL;
 }
 
+static inline bool acpi_reduced_hardware(void)
+{
+	return false;
+}
+
 static inline void acpi_dev_put(struct acpi_device *adev) {}
 
 static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
-- 
2.30.2

