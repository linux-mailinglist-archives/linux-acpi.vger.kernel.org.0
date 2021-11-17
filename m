Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2C455012
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 23:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhKQWEj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 17:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240896AbhKQWEf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 17:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmMWn5KOBms1wR5n+liR0sEIGJwHIde5/MA0d8+M93s=;
        b=ijPQpDEwiaHSay7BJst+H3NXwOkZ9DUVo5ntg9GAf/CD14UHTaGhsrhS1K4CJqf4FvPOD0
        l7nJJiPoZvbrNRJIWYevAxviioaMoJ5dsLcIL7MovF0nbxb9jZGhyIVowPMDpKwSc3Fw81
        +m7ita2i7vuvRU1OI/r9KorAS0W625w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-epRhnkp1M7eSkUWz1IHdJg-1; Wed, 17 Nov 2021 17:01:32 -0500
X-MC-Unique: epRhnkp1M7eSkUWz1IHdJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB35515720;
        Wed, 17 Nov 2021 22:01:30 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DADF5D9DE;
        Wed, 17 Nov 2021 22:01:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 5.16 regression fix 2/5] ACPI: x86: Allow specifying acpi_device_override_status() quirks by path
Date:   Wed, 17 Nov 2021 23:01:15 +0100
Message-Id: <20211117220118.408953-3-hdegoede@redhat.com>
In-Reply-To: <20211117220118.408953-1-hdegoede@redhat.com>
References: <20211117220118.408953-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Not all ACPI-devices have a HID + UID, allow specifying quirks for
acpi_device_override_status() by path too.

Note this moves the path/HID+UID check to after the CPU + DMI checks
since the path lookup is somewhat costly.

This way this lookup is only done on devices where the other checks
match.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 42 ++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 165110210750..a854c28047f2 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -38,22 +38,30 @@ struct override_status_id {
 	struct x86_cpu_id cpu_ids[2];
 	struct dmi_system_id dmi_ids[2]; /* Optional */
 	const char *uid;
+	const char *path;
 	unsigned long long status;
 };
 
-#define ENTRY(status, hid, uid, cpu_model, dmi...) {			\
+#define ENTRY(status, hid, uid, path, cpu_model, dmi...) {		\
 	{ { hid, }, {} },						\
 	{ X86_MATCH_INTEL_FAM6_MODEL(cpu_model, NULL), {} },		\
 	{ { .matches = dmi }, {} },					\
 	uid,								\
+	path,								\
 	status,								\
 }
 
 #define PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
-	ENTRY(ACPI_STA_DEFAULT, hid, uid, cpu_model, dmi)
+	ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_model, dmi)
 
 #define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
-	ENTRY(0, hid, uid, cpu_model, dmi)
+	ENTRY(0, hid, uid, NULL, cpu_model, dmi)
+
+#define PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
+	ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_model, dmi)
+
+#define NOT_PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
+	ENTRY(0, "", NULL, path, cpu_model, dmi)
 
 static const struct override_status_id override_status_ids[] = {
 	/*
@@ -125,13 +133,6 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(override_status_ids); i++) {
-		if (acpi_match_device_ids(adev, override_status_ids[i].hid))
-			continue;
-
-		if (!adev->pnp.unique_id ||
-		    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
-			continue;
-
 		if (!x86_match_cpu(override_status_ids[i].cpu_ids))
 			continue;
 
@@ -139,6 +140,27 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 		    !dmi_check_system(override_status_ids[i].dmi_ids))
 			continue;
 
+		if (override_status_ids[i].path) {
+			struct acpi_buffer path = { ACPI_ALLOCATE_BUFFER, NULL };
+			bool match;
+
+			if (acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &path))
+				continue;
+
+			match = strcmp((char *)path.pointer, override_status_ids[i].path) == 0;
+			kfree(path.pointer);
+
+			if (!match)
+				continue;
+		} else {
+			if (acpi_match_device_ids(adev, override_status_ids[i].hid))
+				continue;
+
+			if (!adev->pnp.unique_id ||
+			    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
+				continue;
+		}
+
 		*status = override_status_ids[i].status;
 		ret = true;
 		break;
-- 
2.31.1

