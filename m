Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919E9430A72
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Oct 2021 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbhJQQSu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Oct 2021 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242551AbhJQQSg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Oct 2021 12:18:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D8C061768;
        Sun, 17 Oct 2021 09:16:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e7so13552706pgk.2;
        Sun, 17 Oct 2021 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9w/jSlnBTBOAMBruZ7F0bYt9ffERuon27iktHkxRroI=;
        b=q11AkCm4AcMtcuzs7/IU+6LYn6G0eySGdkAhKi0/cczuXDIzkk9/3b7kKG5YDRHmfg
         f6gAtiex7PDyWurvfCt8PBDYo2e5iNBluYjFT+jtgdAgHb7F8OSXE4kXvhm0ZICkv6mv
         T8wQrxKpISNvusM4d5hnLte5U5G7heYbGIWVZgVNHIUs3XGX8pwFpL8IRjyB1zG+XF2G
         fGCqdMol0jK9mB+676R9Qv5+UWypCMV3nCsl/UD5HxSZcb5UNN9S2Ykv5V+1GXq8SEsT
         fvfO3ribDNUjeKt+AE1Ab+J+M6KXxDFGYBsn9baMn1C8gMfm7nW7dmsP8Lmvh+Ob9uqR
         QOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9w/jSlnBTBOAMBruZ7F0bYt9ffERuon27iktHkxRroI=;
        b=EKENOy+7PbGH9s3oLtMTokkn00XfrK7QBqx5mlnIMLMlWU3ywi7IQSe4qaUeXI1L08
         GGlYaoUUfRAUVvQO7qWTyPEHYrCAzw2GDr2xUAEfaKeUp3jgiAUFvXlDjriHTkXoy57E
         +Y2C/f/cg4ZlFufBOrCxV8XX9HZTm+PRQR+2hJNd23oda0MLD2pKh4mt7FvRJ3Q+Vcou
         mrchMcHH0JBRy838tMTJb/wuWAG4OFSfwhcCQ0Bluc8c2VVMIqVX+zzGbs+jOCtRR91d
         wlR+kaeUnIZ3WSZ7LRlPqFOvFDDBE/Gwb1nmJ+vK0+RLxqSFbPmWk6sHzPP5gn6WzMKh
         3dAQ==
X-Gm-Message-State: AOAM533sgd1DJTQpj1HmPb8gyO/+v4bj/F5+rnizpTLnJazlqHWurgwf
        edaK8TtRLHaEBmGVXDmDHHU=
X-Google-Smtp-Source: ABdhPJwPkXXEgV4YgSuir/rTT5JVAZSG3vDmS5P4MEZzqiJR51hn9ilptQn9OVGITxNDICLjZpELxg==
X-Received: by 2002:a63:b51d:: with SMTP id y29mr13502287pge.75.1634487386673;
        Sun, 17 Oct 2021 09:16:26 -0700 (PDT)
Received: from sbwpb-arch.flets-east.jp ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id c11sm16591363pji.38.2021.10.17.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:16:26 -0700 (PDT)
From:   Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to intel_pmic_bytcrc driver
Date:   Mon, 18 Oct 2021 01:15:23 +0900
Message-Id: <20211017161523.43801-2-kitakar@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017161523.43801-1-kitakar@gmail.com>
References: <20211017161523.43801-1-kitakar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Microsoft Surface 3 (uses Intel's Atom Cherry Trail SoC), executing
intel_soc_pmic_exec_mipi_pmic_seq_element() results in the following
error message:

        [ 7196.356682] intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
        [ 7196.356686] intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x6e reg-addr 0x57 value 0x63 mask 0xff

Surface 3 uses the PMIC device INT33FD, and the DSDT describes its _HRV
value is 0x02 [1]:

        Scope (PCI0.I2C7)
        {
            Device (PMIC)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _HID: Hardware ID
                Name (_CID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _CID: Compatible ID
                Name (_DDN, "CRYSTAL COVE+ AIC")  // _DDN: DOS Device Name
                Name (_HRV, 0x02)  // _HRV: Hardware Revision
                Name (_UID, One)  // _UID: Unique ID
                Name (_DEP, Package (0x01)  // _DEP: Dependencies
                {
                    I2C7
                })
        [...]

Due to this _HRV value, intel_pmic_bytcrc is used as the PMIC driver.
However, the i2c address is currently not defined in this driver.
This commit adds the missing i2c address 0x6e to the intel_pmic_bytcrc
driver.

[1] https://github.com/linux-surface/acpidumps/blob/f8db3d150815aa21530635b7e646eee271e3b8fe/surface_3/dsdt.dsl#L10868

References: cc0594c4b0ef ("ACPI / PMIC: Add i2c address for thermal control")
Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
---
 drivers/acpi/pmic/intel_pmic_bytcrc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
index 2a692cc4b7ae..a64f50a42c54 100644
--- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -282,6 +282,7 @@ static struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
 	.power_table_count= ARRAY_SIZE(power_table),
 	.thermal_table	= thermal_table,
 	.thermal_table_count = ARRAY_SIZE(thermal_table),
+	.pmic_i2c_address = 0x6e,
 };
 
 static int intel_crc_pmic_opregion_probe(struct platform_device *pdev)
-- 
2.33.1

