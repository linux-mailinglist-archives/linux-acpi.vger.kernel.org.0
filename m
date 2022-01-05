Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59048579E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jan 2022 18:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiAERrV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jan 2022 12:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242509AbiAERrS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jan 2022 12:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641404837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fDT5H8pQ/OfX8gGdYPX2t26Huq3xsUEgiRSc/LetT5g=;
        b=L/aB36drMNAJ8gBYmJs5+F29N6eewaWcblHURYtdgSj01wjjZJPxHfhqxM5DrJND53Z6yL
        3KFdU7fBzL5ok3LBiP632zDSHPETpDLoDZs6dHpiYjJ3XvCcucac532XdI5ACqtlpnz0F1
        Xq+yz5ljCVmIbkoBLWEMay1hXOGBvfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-VYQPpGLjMmeCOl-wPrq5Cg-1; Wed, 05 Jan 2022 12:47:16 -0500
X-MC-Unique: VYQPpGLjMmeCOl-wPrq5Cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93758101AFA7
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jan 2022 17:47:15 +0000 (UTC)
Received: from redhatnow.users.ipa.redhat.com (unknown [10.2.17.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47768838D7
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jan 2022 17:47:15 +0000 (UTC)
From:   Mark Langsdorf <mlangsdo@redhat.com>
To:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: SPCR: check if table->serial_port.access_width is too wide
Date:   Wed,  5 Jan 2022 11:47:14 -0600
Message-Id: <20220105174714.15723-1-mlangsdo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If table->serial_port.access_width is more than 29, it causes
undefined behavior when ACPI_ACCESS_BIT_WIDTH shifts it to
(1 << ((size) + 2)):

[    0.000000] UBSAN: Undefined behaviour in drivers/acpi/spcr.c:114:11
[    0.000000] shift exponent 102 is too large for 32-bit type 'int'

Use the new ACPI_ACCESS_ defines to test that serial_port.access_width
is less than 30 and set it to 6 if it is not.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 drivers/acpi/spcr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 25c2d0be953e..d589543875b8 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -107,8 +107,13 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		pr_info("SPCR table version %d\n", table->header.revision);
 
 	if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		switch (ACPI_ACCESS_BIT_WIDTH((
-			table->serial_port.access_width))) {
+		u32 bit_width = table->serial_port.access_width;
+
+		if (bit_width > ACPI_ACCESS_BIT_MAX) {
+			pr_err("Unacceptable wide SPCR Access Width.  Defaulting to byte size\n");
+			bit_width = ACPI_ACCESS_BIT_DEFAULT;
+		}
+		switch (ACPI_ACCESS_BIT_WIDTH((bit_width))) {
 		default:
 			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
 			fallthrough;
-- 
2.26.3

