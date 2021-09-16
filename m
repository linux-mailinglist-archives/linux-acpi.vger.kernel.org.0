Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A48040EB1C
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhIPTvW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 15:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235213AbhIPTvW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Sep 2021 15:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631821801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BIXxdMj/GwK0wSsl9s6XVLDrEh9z7LhGL8W11zqn3fM=;
        b=KCv3w0AM7QxhCj0fgFjEOjbaJNV+z7ZVdpPhPeBI+U0wub/uT08LDiwcCjsuyGc6jRwhCp
        Sq8oGkJyhhdSbF1o1hiLdEMyq1RWWj/UWwPbby+ooFuQxMeo9oONAwWxZq/o83jIHNs9VP
        NshjBAuhkDKToA+KAFVCIYjldWVUg9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-qmra59S5Om2qwjHKGvuRKQ-1; Thu, 16 Sep 2021 15:49:59 -0400
X-MC-Unique: qmra59S5Om2qwjHKGvuRKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17A55824FA6
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 19:49:59 +0000 (UTC)
Received: from redhatnow.users.ipa.redhat.com (ovpn-114-122.phx2.redhat.com [10.3.114.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C03D569322
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 19:49:58 +0000 (UTC)
From:   Mark Langsdorf <mlangsdo@redhat.com>
To:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: SPCR: check if table->serial_port.access_width is too wide
Date:   Thu, 16 Sep 2021 14:49:57 -0500
Message-Id: <20210916194957.197119-1-mlangsdo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If table->serial_port.access_width is more than 29, it causes
undefined behavior when ACPI_ACCESS_BIT_WIDTH shifts it to
(1 << ((size) + 2)):

[    0.000000] UBSAN: Undefined behaviour in drivers/acpi/spcr.c:114:11
[    0.000000] shift exponent 102 is too large for 32-bit type 'int'

Test that serial_port.access_width is less than 30 and set it to 6
if it is not.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 drivers/acpi/spcr.c    |  8 ++++++--
 include/acpi/actypes.h | 10 ++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 134f7f60cf8102..52f17d631d24e9 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -111,8 +111,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		pr_info("SPCR table version %d\n", table->header.revision);
 
 	if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		switch (ACPI_ACCESS_BIT_WIDTH((
-			table->serial_port.access_width))) {
+		u32 bit_width = table->serial_port.access_width;
+		if(bit_width > ACPI_ACCESS_BIT_MAX) {
+			pr_err("Unacceptable wide SPCR Access Width.  Defaulting to byte size\n");
+			bit_width = ACPI_ACCESS_BIT_DEFAULT;
+		}
+		switch (ACPI_ACCESS_BIT_WIDTH((bit_width))) {
 		default:
 			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
 			fallthrough;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 92c71dfce0d5d9..cefbb7ad253e02 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -536,8 +536,14 @@ typedef u64 acpi_integer;
  * Can be used with access_width of struct acpi_generic_address and access_size of
  * struct acpi_resource_generic_register.
  */
-#define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + 2))
-#define ACPI_ACCESS_BYTE_WIDTH(size)    (1 << ((size) - 1))
+#define ACPI_ACCESS_BIT_SHIFT		2
+#define ACPI_ACCESS_BYTE_SHIFT		-1
+#define ACPI_ACCESS_BIT_MAX		(31 - ACPI_ACCESS_BIT_SHIFT)
+#define ACPI_ACCESS_BYTE_MAX		(31 - ACPI_ACCESS_BYTE_SHIFT)
+#define ACPI_ACCESS_BIT_DEFAULT		(8 - ACPI_ACCESS_BIT_SHIFT)
+#define ACPI_ACCESS_BYTE_DEFAULT	(8 - ACPI_ACCESS_BYTE_SHIFT)
+#define ACPI_ACCESS_BIT_WIDTH(size)	(1 << ((size) + ACPI_ACCESS_BIT_SHIFT))
+#define ACPI_ACCESS_BYTE_WIDTH(size)	(1 << ((size) + ACPI_ACCESS_BYTE_SHIFT))
 
 /*******************************************************************************
  *
-- 
2.26.3

