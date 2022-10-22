Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F618608DDA
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Oct 2022 17:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJVPHk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Oct 2022 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVPHj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Oct 2022 11:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E3193D1
        for <linux-acpi@vger.kernel.org>; Sat, 22 Oct 2022 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666451256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UdygFogJPVNiES2UUsRuX8cMl6pXUhLZbaeNDbHetCw=;
        b=KXO2pjRok+PJiAB+bNjGdBaOzHq4wYs72IB/CXH6Xuy7rhEDAs25giGLuTp7LM6UN0ft9u
        56MR/AFV8EKR+QWQBbblZ84Cr90ijY0b2FyyjfoAVGNHd6GWU3wl9sSUgJCiDYC3dPlWUm
        W5X8/WzP89npW1MJekCcPCeX6BXYPs8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-aqkdlxnHPhmutyd5saM41g-1; Sat, 22 Oct 2022 11:07:33 -0400
X-MC-Unique: aqkdlxnHPhmutyd5saM41g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAE631C06EF7;
        Sat, 22 Oct 2022 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30CFD2166B30;
        Sat, 22 Oct 2022 15:07:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: scan: Add LATT2021 to acpi_ignore_dep_ids[]
Date:   Sat, 22 Oct 2022 17:07:22 +0200
Message-Id: <20221022150722.31787-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some x86/ACPI laptops with MIPI cameras have a LATT2021 ACPI device
on which the ACPI devices for the sensors (which have flags.honor_deps set)

The _DDN for the LATT2021 device is "Lattice FW Update Client Driver",
suggesting that this is used for firmware updates of something. There
is no Linux driver for this and if Linux gets support for it it will
likely be in userspace through fwupd.

For now add the LATT2021 HID to acpi_ignore_dep_ids[] so that
acpi_dev_ready_for_enumeration() will return true once the other _DEP
dependencies are met.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 558664d169fc..eb57b014d1a3 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -789,6 +789,7 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
 static const char * const acpi_ignore_dep_ids[] = {
 	"PNP0D80", /* Windows-compatible System Power Management Controller */
 	"INT33BD", /* Intel Baytrail Mailbox Device */
+	"LATT2021", /* Lattice FW Update Client Driver */
 	NULL
 };
 
-- 
2.37.3

