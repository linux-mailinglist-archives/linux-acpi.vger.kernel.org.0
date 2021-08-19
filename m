Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2D3F1431
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Aug 2021 09:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhHSHP2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 03:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhHSHP1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2021 03:15:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6FC061575
        for <linux-acpi@vger.kernel.org>; Thu, 19 Aug 2021 00:14:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l11so3388878plk.6
        for <linux-acpi@vger.kernel.org>; Thu, 19 Aug 2021 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7QIgZNjyUrLYr2pJJ0vLUbXHLJQNTp+TgzvSKxpnP78=;
        b=LRIpbDjw6ZR9BqoIKYGRnwbKFloMsiac9fujhSex49GKAN6bBU5sSkPSLy34hiM/kQ
         2ejMuf1tu+bymhsWO931gu1AQkurIhPK3sYNa3dMYI91PgI+EiyQ5AstNXecVUUcKfV8
         l3zbVBFwvHyCLvnzJpjUUytV11lIxWERgqDOdcjWu16/5WKopDDzZhdA17KNy9wT2tX3
         ksGHcHjQnYSpHXpLPKXDlSFX40i2DgPumYyd+WEME8Rs+Ms4kqZKP2NIMT5KTmkvn2Zf
         yqo0z72qrjwkTeaSRDpqbLbgEzCMjO0lcynRbC6SnCxHqFk1mN+7Q/mv9IDudJpy9oki
         Ix2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7QIgZNjyUrLYr2pJJ0vLUbXHLJQNTp+TgzvSKxpnP78=;
        b=FXMFfRBxvFTuhK08zVWjgigxVC+6jP9xdABQ4k2RNKJExK4WBgQ18bMfNJ/R6e+Cw0
         bYQYOpHRYOpcVwOluvocUJk97R4gybaGLWrd6Ew1NUK2vc2AplT6+BouqEus3ktz9+dT
         hDmG2jIDuvo+aqAEhwa0uxyVpsAYFrJcI95tlGI2N3A+ec5QceR1AUNUZ+hX7aWu0X2t
         1xAqeAbfbdzJ+lrohCp3s0JosGCwRtJkahgh0tsB7wgmufcl24tlmIySVDXXqmj51iV8
         9YqWLqsyRYtdEOLmJdz9HGiB21dYLrToDm2kNWVMVJnwSkPg3F+c6NkRMFzA1JcKfRdS
         YRyw==
X-Gm-Message-State: AOAM530gA/ubstbVfehfnCpoZq6zMSaazE2Jc/aOSQt2q4p6kkXGVzBL
        2o2RCxkRJE3MicB5swL9hWZnCY1dpdYGAtD+
X-Google-Smtp-Source: ABdhPJyZBg7w2YOxljo5enouPJ/zbb0aTgAm8JSKP+2db2C179EwolO9WaeVHjfHQBvI/slHKIifAQ==
X-Received: by 2002:a17:90a:d702:: with SMTP id y2mr13966154pju.127.1629357290626;
        Thu, 19 Aug 2021 00:14:50 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (220-143-230-157.dynamic-ip.hinet.net. [220.143.230.157])
        by smtp.gmail.com with ESMTPSA id d19sm7248051pjz.26.2021.08.19.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 00:14:50 -0700 (PDT)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH v2 1/1] ACPI: tables: FPDT: Do not print FW_BUG message if record types are reserved
Date:   Thu, 19 Aug 2021 15:14:16 +0800
Message-Id: <20210819071416.14975-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

In ACPI 6.4 spec, record types "0x0002-0xffff" of FPDT Performance Record
Types [1] and record types "0x0003-0xffff" of Runtime Performance Record
Types [2] are reserved.

Users might be confused with the FW_BUG message, and they think this
is the FW issue. Here is the example in a Lenovo box:

  ACPI: FPDT 0x00000000A820A000 000044 (v01 LENOVO THINKSYS 00000100 01000013)
  ACPI: Reserving FPDT table memory at [mem 0xa820a000-0xa820a043]
  ACPI FPDT: [Firmware Bug]: Invalid record 4113 found

So, remove the FW_BUG message to avoid confusion since those types are
reserved in ACPI 6.4 spec.

[1] https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fpdt-performance-record-types-table
[2] https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#runtime-performance-record-types-table

Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---

Changes since v2:
 * Fix "0x0002-0xFFFF" of FPDT Performance Record Types, per Rui

 drivers/acpi/acpi_fpdt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index 4ee2ad234e3d..6922a44b3ce7 100644
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
@@ -254,8 +254,7 @@ static int __init acpi_init_fpdt(void)
 					      subtable->type);
 			break;
 		default:
-			pr_info(FW_BUG "Invalid subtable type %d found.\n",
-			       subtable->type);
+			/* Other types are reserved in ACPI 6.4 spec. */
 			break;
 		}
 		offset += sizeof(*subtable);
-- 
2.25.1

