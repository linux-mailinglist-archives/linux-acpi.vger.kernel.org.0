Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CBC3573C2
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354992AbhDGR6k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 13:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240322AbhDGR6i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 13:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617818307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kXhMkXHhdVuxpFZxF0bECUgYFZlCe/vw8kPsCyy+70Y=;
        b=GTpknNKhC+enoFEGRFYavgjUCU85HZ0kHl+LbqLo4WWlYMqnwhx4yd+kzmG76+3goY6oby
        jiQWdoqk5BVbfbigkuyyHIfZCNkU/6vLnGSYyrPHcNktJneEFdB7H8hxz6F4huG5IZzBMH
        A8/NK51qIZfwMkl7KxU1XDcJyK/F594=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-McSflKO4PB6S_U8M6PDZ0Q-1; Wed, 07 Apr 2021 13:58:24 -0400
X-MC-Unique: McSflKO4PB6S_U8M6PDZ0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A75876D4E6;
        Wed,  7 Apr 2021 17:58:22 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-82.ams2.redhat.com [10.36.112.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA4B610F0;
        Wed,  7 Apr 2021 17:58:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/2] ACPI: utils: Add acpi_reduced_hardware() helper
Date:   Wed,  7 Apr 2021 19:58:20 +0200
Message-Id: <20210407175820.447847-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a getter for the acpi_gbl_reduced_hardware variable so that modules
can check if they are running on an ACPI reduced-hw platform or not.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
---
 drivers/acpi/utils.c    | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 682edd913b3b..b20774c48c74 100644
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
+EXPORT_SYMBOL_GPL(acpi_reduced_hardware);
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

