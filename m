Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4091B43C359
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 08:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhJ0G5L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 02:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJ0G5K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 02:57:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A77C061570;
        Tue, 26 Oct 2021 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qVOKPEL+cDjPj9AyhxqEr6YMFHO5I/IxeFePZHp1xYQ=; b=y2wGLilDfKTHKFlZK96sqT+YWt
        owB6xFZjNBYeLaHJxQte8mjJm1j8s/EX3mmuobz4/iaZbMTr2/vJmc055sjYIuJWif9mU34/vlL5m
        uLvWww2GkBzivuwX+Me/LSouEJTUnVNlu710xOfidmS8vqz3PtSnHN8TvwJ9ajPCDiMbFJUd2sWmP
        WoDfxJei2GM3tCD/x5ncpP6lWoVTWBXbr87CYuFYnhric9fBwtbIhghNrBzrpStVWoUZGJ/rZDVxP
        RtjlUZFVXu6L5THUtMWpIbKrYjdaz2LCmPPIxpvACOsT+0FQaUo1Pc2chfWSl1Er+hA2sy+jjVQgi
        79ZzpMSQ==;
Received: from [2001:4bb8:199:7b1d:1f8e:c2bd:5443:4343] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfcpb-0044U6-U6; Wed, 27 Oct 2021 06:54:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org
Subject: [PATCH] ACPI: APEI: mark apei_hest_parse
Date:   Wed, 27 Oct 2021 08:54:38 +0200
Message-Id: <20211027065438.1742175-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

apei_hest_parse is only used in hest.c, so mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/acpi/apei/hest.c | 5 +++--
 include/acpi/apei.h      | 3 ---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 277f00b288d14..0edc1ed476737 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -86,7 +86,9 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 	return len;
 };
 
-int apei_hest_parse(apei_hest_func_t func, void *data)
+typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
+
+static int apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
@@ -121,7 +123,6 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(apei_hest_parse);
 
 /*
  * Check if firmware advertises firmware first mode. We need FF bit to be set
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 680f80960c3dc..ece0a8af2bae7 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -37,9 +37,6 @@ void __init acpi_hest_init(void);
 static inline void acpi_hest_init(void) { return; }
 #endif
 
-typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
-int apei_hest_parse(apei_hest_func_t func, void *data);
-
 int erst_write(const struct cper_record_header *record);
 ssize_t erst_get_record_count(void);
 int erst_get_record_id_begin(int *pos);
-- 
2.30.2

