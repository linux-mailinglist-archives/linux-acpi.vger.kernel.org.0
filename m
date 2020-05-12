Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4691CEC8C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 07:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgELFwD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 01:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgELFwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 01:52:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D6120746;
        Tue, 12 May 2020 05:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589262723;
        bh=mTfFTEj10PUezYbFjACvwdRUN6gWsatVJhycyQ8E1A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7JMxL5xFZds/ZMDh5Qf5pBZmPDYhHjkpH+l27E4DGH5/sN6+M80u51fdmkJMr7Oh
         dpIkKBFAfbOdoVRHsXXKW9Hlw5IK/Frqj5u1ulW7Levlm+uSmnQuxQiBbcoLURlC6Q
         Qg/j/MbDrlPP9nMzVKJ2XiHwR6UxXoXMaxyoWN+A=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jYNpg-001Yqs-M7; Tue, 12 May 2020 07:52:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
Date:   Tue, 12 May 2020 07:51:56 +0200
Message-Id: <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589262490.git.mchehab+huawei@kernel.org>
References: <cover.1589262490.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Asus T101HA, we keep receiving those error messages:

	i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
	intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
	intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff

Because the opregion is missing the I2C address.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 7ccd7d9660bc..a5101b07611a 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -102,6 +102,7 @@ static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
 	.power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
 	.thermal_table = chtdc_ti_thermal_table,
 	.thermal_table_count = ARRAY_SIZE(chtdc_ti_thermal_table),
+	.pmic_i2c_address = 0x5e,
 };
 
 static int chtdc_ti_pmic_opregion_probe(struct platform_device *pdev)
-- 
2.26.2

