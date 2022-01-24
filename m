Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED44985A3
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jan 2022 18:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiAXRCq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jan 2022 12:02:46 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36480 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243930AbiAXRCq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jan 2022 12:02:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4JjGWT3h8Mz9vCBl
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 17:02:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g_QuzA2dla6N for <linux-acpi@vger.kernel.org>;
        Mon, 24 Jan 2022 11:02:45 -0600 (CST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4JjGWT1bZ0z9vCC5
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 11:02:45 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4JjGWT1bZ0z9vCC5
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4JjGWT1bZ0z9vCC5
Received: by mail-pf1-f199.google.com with SMTP id i6-20020a626d06000000b004c0abfd53b3so9531677pfc.12
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNEeCGoKa1V6rmYqi+3L0jEf0NTPic6Q/DwIqKljNuU=;
        b=oB+TQmFq3vUafAHIx75KxfATkLnzA+020njfiNxZ7n4IVOIyb8n0++/zm1oUOQsUX5
         7Jbo9yoDrwfe4y+V1Qhmw6QSlZLJ6VQ4zXnMqYw2wRKx7Wx++ARQhcW2/d/hzR+hcGxU
         cmtxskJiLEtUDFoRZS5PGx+yjgTn8bz9Y2tGPNnKB7RpDxcjshCxnCorZzjVfNZLSjvG
         iSxUkHlgtvpcZOnLkOmE0TzZxNoL7hKnKSU7lXK5LIe5rQNOZWI+TFJcRXNg8vDePNUv
         JqvxA7OQlKcmMWYepLjiLFq6VUxNGycAGKmf9p1j/EqZOxyOV+GW8NOxsmcQJtka6Snt
         yjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNEeCGoKa1V6rmYqi+3L0jEf0NTPic6Q/DwIqKljNuU=;
        b=W4GhSU3WHj3jUf1GmP9f/f8DY/KcUdIFm5dbP/09vjhecXFp/4AZqWSlUqDerPY+lL
         fHoeHwQd4nQJk7apYZjaOeJD5qRylHjdACVBpCwRd9BFDPQwIdG6AxekXu4I3VGamKN8
         bXsgtnIfkpNrvQ9340srJ429o+8Rf4LE157XEI37dTIrhEAig81kVRceeDwv2lT/p3Fz
         wotY3IKJQZJZqpRjqF2BMoQFLtEHfE3r81hdC9pDIC3Rfy1f15Y7F8+irzCmpnB/HcEG
         xKRiTfgdxnL4nRgMq1efmT2tCDTKowRtqPibexqD4zQaNF0Bhf4KlbpbNP6pS5hvrfpt
         IpTQ==
X-Gm-Message-State: AOAM533XIum0ESDniNjOQ6SozK1lms2mw8MXZ2SNTvgTPdzYEO+13Ha4
        MalWzCVxdPXp0VsaGGBmfwpeH1rVsV4/mMNvMTKWGJS/gq5D3/mwG/uGz5BWl35LRxzpJQ22R98
        dhPGJLV5MsGwafDbtut1WQeFERw==
X-Received: by 2002:a17:902:cec8:b0:14b:47b3:c0a2 with SMTP id d8-20020a170902cec800b0014b47b3c0a2mr6663270plg.51.1643043764477;
        Mon, 24 Jan 2022 09:02:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwut5m/BhVkcZcrvznz08wiT4QN4M/h6lmE32uu9pEMjPLtxdzu4Rdmt39nrJ/+uAbft69Pqw==
X-Received: by 2002:a17:902:cec8:b0:14b:47b3:c0a2 with SMTP id d8-20020a170902cec800b0014b47b3c0a2mr6663249plg.51.1643043764246;
        Mon, 24 Jan 2022 09:02:44 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id q17sm17263784pfu.158.2022.01.24.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:02:43 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / tables: Fix a NULL pointer dereference in acpi_table_initrd_scan()
Date:   Tue, 25 Jan 2022 01:02:37 +0800
Message-Id: <20220124170237.57718-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In acpi_table_initrd_scan(), the return value of acpi_os_map_memory()
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

 drivers/acpi/tables.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 8b10c192ed32..356e08c4015b 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -755,6 +755,9 @@ static void __init acpi_table_initrd_scan(void)
 	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
 		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
 					   ACPI_HEADER_SIZE);
+		if (!table)
+			return;
+
 		if (table_offset + table->length > all_tables_size) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			WARN_ON(1);
-- 
2.25.1

