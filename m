Return-Path: <linux-acpi+bounces-6320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5463905095
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43A31C20F20
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD016EBFB;
	Wed, 12 Jun 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6himaj7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AC16EBF8
	for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188957; cv=none; b=Tu5Q6m8aHcwy1Qm2sUsCvoMX7Lv9Ppx1h+9z+5TA3XxO8zZNyUpv37RbNH0nuV558Vmzdr2XQO91An3XaM0GDWihk2c0zaR7xgmo/SVrUYvYd68IMN2xW+uSaHnTbN2PvaBMjSGVBXe5g6L48ukFB6cQlC5wiOl2coSK8WuYgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188957; c=relaxed/simple;
	bh=4qeU+BH4L7ZSdqz5prMqOvuznMdYTQsDMUl0cmgcWLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkuxeCWjVKfUvRJY11b47W7renqW/3e9eog7UFCddTBrWdkH+xQfeooR4SV9+zPPQGS1zmEFKdsmhc8WE5Fl9r7MA6wqIOKHORIxhRvz2XLijGP2TUaJJZ9aqKD4Xc6MG0NDlE7cR/lV7AbbSHCHl3tLApdTaZgBkro9v5oasvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6himaj7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718188954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WIBTfbVBBmyg3xIq26D/CzZPKpc6Ha7O2uPuJ1J8wqU=;
	b=N6himaj70sHeWVe+l+jxX1MCDHprZx5ALdVWIcJQoBGfsKGhKeelrxH1Qp9xn/tuR49MXH
	8WrQVqX/YqcPh0sUOEQqSlz2CMIEwSC81KvfCQ8LnRm324H8g848bmNHSPDnSymOWveJDo
	d854YwoQlPabfEmqVg4pcfIaNxnH8pQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-s97hiYvsPbS4_P2oq2mAHw-1; Wed,
 12 Jun 2024 06:42:29 -0400
X-MC-Unique: s97hiYvsPbS4_P2oq2mAHw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52B82195608B;
	Wed, 12 Jun 2024 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98F8A1956056;
	Wed, 12 Jun 2024 10:42:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all Dell Tiger, Alder and Raptor Lake models
Date: Wed, 12 Jun 2024 12:42:20 +0200
Message-ID: <20240612104220.22219-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

It seems that all Dell laptops with IPU6 camera or the Tiger Lake,
Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
information.

Instead of adding a lot of DMI quirks for this, check for these CPU
generations and disable ACPI MIPI DISCO support on all Dell laptops
with these CPU generations.

Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from _CRS")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/internal.h       |  4 ++++
 drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 2a0e9fc7b74c..601b670356e5 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
 void acpi_mipi_scan_crs_csi2(void);
 void acpi_mipi_init_crs_csi2_swnodes(void);
 void acpi_mipi_crs_csi2_cleanup(void);
+#ifdef CONFIG_X86
 bool acpi_graph_ignore_port(acpi_handle handle);
+#else
+static inline bool acpi_graph_ignore_port(acpi_handle handle) { return false; }
+#endif
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index d05413a0672a..0ab13751f0db 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
 		acpi_mipi_del_crs_csi2(csi2);
 }
 
-static const struct dmi_system_id dmi_ignore_port_nodes[] = {
-	{
-		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
-		},
-	},
-	{ }
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
+/* CPU matches for Dell generations with broken ACPI MIPI DISCO info */
+static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
+	{}
 };
 
 static const char *strnext(const char *s1, const char *s2)
@@ -761,7 +767,10 @@ bool acpi_graph_ignore_port(acpi_handle handle)
 	static bool dmi_tested, ignore_port;
 
 	if (!dmi_tested) {
-		ignore_port = dmi_first_match(dmi_ignore_port_nodes);
+		if (dmi_name_in_vendors("Dell Inc.") &&
+		    x86_match_cpu(dell_broken_mipi_disco_cpu_gens))
+			ignore_port = true;
+
 		dmi_tested = true;
 	}
 
@@ -794,3 +803,4 @@ bool acpi_graph_ignore_port(acpi_handle handle)
 	kfree(orig_path);
 	return false;
 }
+#endif
-- 
2.45.1


