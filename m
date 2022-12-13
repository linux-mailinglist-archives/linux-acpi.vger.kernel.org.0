Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CABC64B53A
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Dec 2022 13:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLMMfv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Dec 2022 07:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLMMfu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Dec 2022 07:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5C60EF
        for <linux-acpi@vger.kernel.org>; Tue, 13 Dec 2022 04:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670934902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D7ufP1Uvhr9DHiBwqcJin06gJD9whBG0qdVq9o7mdJU=;
        b=ZkdNYl1h5pSXk9MEtg5/MyRSUUybZoSREL0NEV/aYmm4M0aFKx/Ym/EIbnyMmY0RaLk48G
        cKcyupAg6ijdFbWfMQ5xfTb6VxJDu0WursWhHjBvUYOdeEERfcqYoMEam9blT8mEPUxg1i
        AucEqH1wQYYq4xBdzeZbR726/lBhDR4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-iaCsKGKGPDKS7Tm4cVogfQ-1; Tue, 13 Dec 2022 07:34:58 -0500
X-MC-Unique: iaCsKGKGPDKS7Tm4cVogfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 483553817A60;
        Tue, 13 Dec 2022 12:34:58 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C61153AA;
        Tue, 13 Dec 2022 12:34:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI / PMIC: Add pmic_i2c_address to BYT Crystal Cove support
Date:   Tue, 13 Dec 2022 13:34:54 +0100
Message-Id: <20221213123454.11404-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a pmic_i2c_address entry to intel_pmic_bytcrc.c, so that
intel_soc_pmic_exec_mipi_pmic_seq_element() can be used on
devices with a Bay Trail Crystal Cove PMIC OpRegion driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic_bytcrc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
index 9ea79f210965..2b09f8da5400 100644
--- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -283,6 +283,7 @@ static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
 	.power_table_count= ARRAY_SIZE(power_table),
 	.thermal_table	= thermal_table,
 	.thermal_table_count = ARRAY_SIZE(thermal_table),
+	.pmic_i2c_address = 0x6e,
 };
 
 static int intel_crc_pmic_opregion_probe(struct platform_device *pdev)
-- 
2.38.1

