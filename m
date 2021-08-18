Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA83EFCF3
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Aug 2021 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhHRGjp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Aug 2021 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbhHRGji (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Aug 2021 02:39:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719EC061764
        for <linux-acpi@vger.kernel.org>; Tue, 17 Aug 2021 23:39:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so1966015pjv.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Aug 2021 23:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6VE07LLbzv29aUtMl97q7xaV/5G6rvVI2//UYhL0to0=;
        b=YDLNXL1UfeGT2ueF9icsHaZv7z+FDPU7LSy2ZRXtSe5mZjy3LgTu7bQNdpqisl6xMY
         0YXqcyw3w0TFPpYQU2f0vc9ROEAVryFZjQXJytjB/enbNYmvVdx4kBPSlGuxnvtnCq/Y
         iohfl9roTW+pn6r5uFYkUxn6oKKYasENUaQvv4Ad0bSajOTsa80ALEnNV4pMANudDo/b
         8VtBSAvMSr7AwIXvAfZdHRhHoZu5Vm+gdF8kuO1RBXf+9PWhQrQ8uzjQdhyQgq4LCXxu
         RQx1CRLR+x2dp60rzHI9HNh3ZGnH98doLGfiKjMfKj7w07ZRabrCLYi9isp1wY2cMdKP
         0aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6VE07LLbzv29aUtMl97q7xaV/5G6rvVI2//UYhL0to0=;
        b=JqRSy/62hLvJqUUAIRP/o75EMLdsRN6BAsWz2O/F0CBml7QhKX41LEHTli3HjS/sjF
         odAVa6cJ1UAwMkEq+GyloVEwZYqmbmeDrgszAHsnPNVUrTlzX76NhQzSjeoqAtwDWnrr
         Efvv1X7+O8v5SY6NeoEB0hl5g1NcqghNH/g3xyUKmWNtrcwCCcg4g86bM8FJm7UBb8E9
         r3WqIrpMlcNP9t0VfH6i2SzjczVRhdjznAU8giZjmg11+RBsvUYwWTowPoZ4olA4AukU
         76NHWf5PKwySyfSJ312ArtueDkLPDzrgUc6iYUUxqaU04r5J999qO6RafhxRABNHFtAm
         RSxw==
X-Gm-Message-State: AOAM532vejpcyVMG6tX2wdMpscOf7unviKdXtVRT7Ug8Pv+SOIY+2FyW
        iB410mL/UZ8/wFN2rZhjQm7jSXHrWkAYRsrp
X-Google-Smtp-Source: ABdhPJwsxyZh2jMcjL70aRNuDM63r/08KQSklh6zuunF7uzTnIapDiJWyVzxwhSlCXUi8SN0pLpCrA==
X-Received: by 2002:a17:902:8301:b029:12c:d401:1b52 with SMTP id bd1-20020a1709028301b029012cd4011b52mr6127928plb.10.1629268743390;
        Tue, 17 Aug 2021 23:39:03 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (220-143-230-157.dynamic-ip.hinet.net. [220.143.230.157])
        by smtp.gmail.com with ESMTPSA id n18sm4896792pfu.3.2021.08.17.23.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:39:03 -0700 (PDT)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] ACPI: tables: FPDT: Do not print FW_BUG message if subtable types are reserved
Date:   Wed, 18 Aug 2021 14:38:31 +0800
Message-Id: <20210818063831.1349-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

Table 5.90 "Runtime Performance Record Types" in ACPI 6.4 spec [1] says:

  These type values "0x0003-0xFFFF" of Runtime Performance Record Types
  are reserved for ACPI spec usage, platform vendor usage, hardware
  vendor usage, platform firmware vendor usage and future use.

Users might be confused with the FW_BUG message, and they think this
is the FW issue. Here is the example in a Lenovo box:

  ACPI: FPDT 0x00000000A820A000 000044 (v01 LENOVO THINKSYS 00000100 01000013)
  ACPI: Reserving FPDT table memory at [mem 0xa820a000-0xa820a043]
  ACPI FPDT: [Firmware Bug]: Invalid record 4113 found

So, remove the FW_BUG message to avoid confusion since those subtable
types are reserved in ACPI 6.4 spec.

[1] https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#firmware-performance-data-table-fpdt

Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/acpi/acpi_fpdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index 4ee2ad234e3d..568f26a7490a 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -220,8 +220,8 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			break;
 
 		default:
-			pr_err(FW_BUG "Invalid record %d found.\n", record_header->type);
-			return -EINVAL;
+			/* Other types are reserved in ACPI 6.4 spec. */
+			break;
 		}
 	}
 	return 0;
-- 
2.25.1

