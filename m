Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801994B7FA
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 14:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFSMSt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 08:18:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43966 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMSt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2019 08:18:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so3125238wru.10
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2019 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vQWMM04qjKoqvfboQwGxdL+4IwL/Af9mC5Qcpbu+To=;
        b=j8h7hwqk/6xqaFEt6OOoRh7tpGPbjyYjJQ3Qb540gSRoOdA2c+HOIWbsBug6YKGtRj
         K3G8XmS0qLhJw9wJZjBZ5m7t9CmnLs61UmAaN7apJq1WJ/WEyrqijL2z/XCJhn7OCNtY
         wNf4d/xSw2Ux1cJDB3z+DoykyNzzJnxFSdxj2xgp4kYBalm5W4m9WkXQ7YPm8sM0hBBz
         1N33eXUzFsDoHsnke7h5acQUiukL20gjlJ1vTn1wWCexatchAXJpkVIjwafa2KDB14Wc
         +9BSSENlfxbg4S0RFD+raL7crb0iQ7xWlHMTxNGb7tuoAEF0BohDd44vqorWdnLD2pXH
         VcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vQWMM04qjKoqvfboQwGxdL+4IwL/Af9mC5Qcpbu+To=;
        b=SrWFN/PDxnjvckyjwyJI89grokE8L1I+a9/7J1lPBrB1sRIHcZVn0k/zDl+x48nm57
         3+kZnMASMEE+DXOWtdVRti8a6lBxbIk6EiQGas5OeW/3k0EMBczTXAL74d6oz5qVAcmI
         CLaq4PbFRK0qvbRug2ZUWoW/XZB96fXH+68AS7Kw7I6JgfBCBXOy7Helso3kZM5uRZcu
         THgmQ9obbemVyC+6vyqOSuJFTUxmFEbt6QCyYDr4T8eXAuVVYQsPv+4/qoTH5Nl89b8H
         wYVvH+qbwVPg+11w+TiLzXaliGASabFnDxjz4COSfmPInmkqDXV8Q8EJPkP10cOmw656
         Ry1Q==
X-Gm-Message-State: APjAAAW0VcJ5BwXTCqdjfxmsMyva25O5yh6exWe/54SrRP+yHKTMMfup
        A1KG8joawjh8Ihpmt8xhW2zTQNIZYH8=
X-Google-Smtp-Source: APXvYqzHJaIzt42CI09p+2CTvyYHvJupQyZzEbBqSy9ydAsF+kbAr1BlDLVE1BEhXHSXE4VMY9UarQ==
X-Received: by 2002:adf:ea92:: with SMTP id s18mr9348470wrm.257.1560946727177;
        Wed, 19 Jun 2019 05:18:47 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-6-209.w90-88.abo.wanadoo.fr. [90.88.128.209])
        by smtp.gmail.com with ESMTPSA id 5sm20419966wrc.76.2019.06.19.05.18.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:18:46 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        lee.jones@linaro.org, leif.lindholm@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Date:   Wed, 19 Jun 2019 14:18:31 +0200
Message-Id: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
are clearly ACPI 5.1 based, given that that is the first ACPI revision
that supports ARM, and introduced the FADT 'arm_boot_flags' field,
which has a non-zero field on those systems.

So in these cases, infer from the ARM boot flags that the FADT must be
5.1 or later, and treat it as 5.1.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/acpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 803f0494dd3e..7722e85fb69c 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -155,10 +155,14 @@ static int __init acpi_fadt_sanity_check(void)
 	 */
 	if (table->revision < 5 ||
 	   (table->revision == 5 && fadt->minor_revision < 1)) {
-		pr_err("Unsupported FADT revision %d.%d, should be 5.1+\n",
+		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 5.1+\n",
 		       table->revision, fadt->minor_revision);
-		ret = -EINVAL;
-		goto out;
+
+		if (!fadt->arm_boot_flags) {
+			ret = -EINVAL;
+			goto out;
+		}
+		pr_err("FADT has ARM boot flags set, assuming 5.1\n");
 	}
 
 	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
-- 
2.20.1

