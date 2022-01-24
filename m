Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4D49853A
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jan 2022 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiAXQun (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jan 2022 11:50:43 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50634 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243835AbiAXQum (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jan 2022 11:50:42 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4JjG4f3nnsz9yTBB
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 16:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G-s_iCUNSSkc for <linux-acpi@vger.kernel.org>;
        Mon, 24 Jan 2022 10:42:58 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4JjG4f0hn8z9yTBG
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 10:42:58 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4JjG4f0hn8z9yTBG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4JjG4f0hn8z9yTBG
Received: by mail-pj1-f69.google.com with SMTP id 19-20020a17090a001300b001b480b09680so11026669pja.2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 08:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkMHnLhdVlAFXL1f9xT6ZtHXh+qR3Ozk42TcA0ftXx4=;
        b=ZhdWKaWWfpclwFUb8NuXxOWd5VrMEBGzCGE7PFvSoQsXdoWIFrcS6HCyURolNWkbuf
         MbOj3l3r8fxXLQi33EYslAJJqn0CC3yaZbSH/yrKBVS2l44o5Z9+iR5pOLEOZtl6EgQt
         lCr1UhIzQO/k6K+Cw5uTyws2k+Na0rZIAl30PBPbph2ctGSc2pyoS7k8NfZGX6RdhKN/
         OpuY/UqEgv7fphtn95LpHupAwjbIEl/vTBywUB3kdg2C7EGX5nb2oUGb/3bDet+USh1w
         z8rM0HkqgbhCFYZrVyHcmWyCdeGq9MfzaXzHRO587j3bXbd7LEVcR9hDH5xmizmLB71o
         NtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkMHnLhdVlAFXL1f9xT6ZtHXh+qR3Ozk42TcA0ftXx4=;
        b=onnAu0tfcMOoLkeDrrdTWKdouybUdHd0/dzWQxOyzpiAWCYIrvXdvDB9VeEFyyiOjM
         z6VkD/vmtBDyozBMMs2OsdcPaHvl4dzflPR7BnDM25/lXPiomWFkoYTKlxcMkaXfGoon
         UFoMYzzWoFyxHpzZvahD6GGhEBL7fK4ALA38noPWwQNWghpesmFMiQk279ApdBNOpxCV
         RLvUjEMp1AhHrlrpJJ2S/sMEmoP8q6rwQrnEWy3zIe1a8EL5SpAeBEFR5OTwx/Y+1i4P
         PQbbIeGHQgBtB5MwQ+vUE6K/VhBbIK5RLht4GdwgjtuM42eJOAFL6f8G1/u945FOw+Vg
         1Hyw==
X-Gm-Message-State: AOAM531nsyXc8hDoFU3kUevCqXo2B6PKbLff2CZeuDWWgMOxpzVhXnQj
        qGJa7CeRP/QPPTkVTlcbNaAy9CIaCZ0+4rausgh0+j4DsELCY5sUfnxVUHr1GU6vU2x8j5WAUW/
        D1pdzUsfoMP9bJDUEN1p/CIT/ig==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr12483300pgc.306.1643042577256;
        Mon, 24 Jan 2022 08:42:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI5QjCBYvNzKdspif2Q6QAqpXfTi6c38b6CKUse+xdHlcdxo3pGtKk1r+Pl3rp4yf7ug9MHA==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr12483281pgc.306.1643042576997;
        Mon, 24 Jan 2022 08:42:56 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id r4sm8201788pjj.56.2022.01.24.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:42:56 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / tables: Fix a NULL pointer dereference in acpi_table_initrd_override()
Date:   Tue, 25 Jan 2022 00:42:51 +0800
Message-Id: <20220124164251.52466-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In acpi_table_initrd_override(), the return value of acpi_os_map_memory()
is assigned to table and there is a dereference of it after that.
acpi_os_map_memory() will return NULL on failure, which may lead to NULL
pointer dereference.

Fix this bug by adding a NULL check of table.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 5ae74f2cc2f1 ("ACPI / tables: Move table override mechanisms to tables.c")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/acpi/tables.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0741a4933f62..8b10c192ed32 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -696,6 +696,10 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
 	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
 		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
 					   ACPI_HEADER_SIZE);
+		if (!table) {
+			return AE_NO_MEMORY;
+		}
+
 		if (table_offset + table->length > all_tables_size) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			WARN_ON(1);
-- 
2.25.1

