Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D411498539
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jan 2022 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbiAXQun (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jan 2022 11:50:43 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50622 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbiAXQum (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jan 2022 11:50:42 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4JjG3937n7z9yTB2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 16:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AADGK3yTSmuA for <linux-acpi@vger.kernel.org>;
        Mon, 24 Jan 2022 10:41:41 -0600 (CST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4JjG3913Wnz9yT9Z
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 10:41:41 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4JjG3913Wnz9yT9Z
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4JjG3913Wnz9yT9Z
Received: by mail-pl1-f198.google.com with SMTP id z11-20020a1709027e8b00b0014a642aacc6so3617078pla.10
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2022 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjxyaAEg9dgyhIAkpzzAptxU/LU+QVbkLgcz/aYUJL0=;
        b=VirmN0SOTo8kwAsb6NJ8f0My6angxwwfXPytMw1MiWvZSTJvH+k60e1XJyHLwmUJ8I
         gb0dYxOJhTRm6FHSjRNj1F6BYyfFQ8+rziWRzJ00cmkMG234HWQcyUGZn5QJtTbt/0x5
         WbHHVlcfwvqCi20uI+e6uqC7Qe1Eo2tLyk+amiDmu4D5peJpc9psf3Irx6gq3vG41A0C
         FIAlbksV75hxBifi+VXqDsxG/vbBE68AVFX6uEYDWAe+mYQwZ8A+Pc4O0JHjfAlsM/mJ
         4xTil0FcCZpFLqjqcbEgxhd0Ryw/MGyG3tq1qmv37KkJPwdGE8iTmytU4kXKL8ky7oxJ
         COMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjxyaAEg9dgyhIAkpzzAptxU/LU+QVbkLgcz/aYUJL0=;
        b=1f/NEqvfTOvFPxb+snBpc4zzCBVPZ7FBHQjF3N/DPmLyCkcZvTVbInZNn3GqcA7GbA
         0f/NNqgYe+nNwQEamxAPJjsxw6VIcl8P0po2f+ntp2y7Bx2JPwvB/s8ebPKFQQstTtXm
         j+gkDsS1QLfNHoHj6/+A96UNALvBUUf26FC5RCyjt7SWWuYxqXuqdDDd33WrFaui7/Xk
         qji8T/kxKzkoWrFY/JNT/guIgGL10RY1hdZ6h6Uyi2lE2J8uk3Ost/9sG/QFtDiBCjHA
         FcfmjbAHFxYoBvxSNwPYGiOXeW0NfP7GVo5Z63XBRKhX6QyPySVWj8rq7dn8JUEtGkUp
         QMQQ==
X-Gm-Message-State: AOAM533BNGFFdzN9E9+8AniV4Eg470Bca+DDQumz/e927fariH388Akw
        x8mLj6py4E31g7OIksSzHgVAQueEGhY8hd3CFcMO+hgi/Rc4PXx7RxIYt93xf3CSdHuve578Bbc
        SsROR/5LSgab4ATvyT+J+X+umvg==
X-Received: by 2002:a17:90a:3f09:: with SMTP id l9mr2728755pjc.38.1643042500404;
        Mon, 24 Jan 2022 08:41:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOpsozHODGgFyK9SCHH//gLgeWWuohBy6yEBU2ijxYIw5SjGOPgAKzc1o1kBe/gI7Gr6S2GA==
X-Received: by 2002:a17:90a:3f09:: with SMTP id l9mr2728731pjc.38.1643042500108;
        Mon, 24 Jan 2022 08:41:40 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id my11sm11680862pjb.35.2022.01.24.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:41:39 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: OSL: Fix a NULL pointer dereference in extlog_init().
Date:   Tue, 25 Jan 2022 00:41:34 +0800
Message-Id: <20220124164134.52046-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In extlog_init(), acpi_os_map_iomem() is assigned to extlog_l1_hdr and
there is a dereference of it through l1_head. on the failure of
acpi_os_map_iomem(), the return value of it could be NULL, which may
introduce a NULL pointer dereference.

Fix this bug by adding a NULL check of extlog_l1_hdr.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: a238317ce818 ("ACPI: Clean up acpi_os_map/unmap_memory() to eliminate __iomem.")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/acpi/acpi_extlog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 72f1fb77abcd..2187ac23d3d4 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -239,6 +239,12 @@ static int __init extlog_init(void)
 	}
 
 	extlog_l1_hdr = acpi_os_map_iomem(l1_dirbase, l1_hdr_size);
+	if (!extlog_l1_hdr) {
+		rc = -ENOMEM;
+		release_mem_region(l1_dirbase, l1_hdr_size);
+		goto err;
+	}
+
 	l1_head = (struct extlog_l1_head *)extlog_l1_hdr;
 	l1_size = l1_head->total_len;
 	l1_percpu_entry = l1_head->entries;
-- 
2.25.1

