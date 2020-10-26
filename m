Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC42986DE
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 07:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770403AbgJZGbB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 02:31:01 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:38946 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770402AbgJZGbB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Oct 2020 02:31:01 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 02:31:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=OBHgdJnglEUEIfa5O+
        JlmLtSW1bTyf2jx2IYEHgI8MQ=; b=EI24RwKCZlqCMgXcVcxavkGIki7UPReuXR
        FvTxUXE/wk3T10TyqIMtwg9AGqw4YIHeHDyYSSfNDDfjY0shk6D+1zidNqYAYwbl
        PeAhrjxvSYXLeWTpHV71rkRCbnJNo/rcqfWucTCmh+aklbuoGuJlhZDmRgTfEuym
        Z5DwX+Zws=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp1 (Coremail) with SMTP id GdxpCgBHFHJwaZZfr1yeAw--.248S2;
        Mon, 26 Oct 2020 14:15:14 +0800 (CST)
From:   yaoaili126@163.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, yangfeng1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: [PATCH] Fix incorrect return value of pre_map_gar_callback
Date:   Sun, 25 Oct 2020 23:15:09 -0700
Message-Id: <20201026061509.48212-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
X-CM-TRANSID: GdxpCgBHFHJwaZZfr1yeAw--.248S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZr45Zr4UJw45Kr48ArW7XFb_yoW8JryrpF
        W3uayjkrs2qw47trWUAr1aqFW5Can3JFy2yayj9wnI9F1rGF42kFyjgFn8Ca1rtF48G3yS
        qFsrtFW5ZayDArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf0eQUUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbisBzJG1UMPz1P4wAAsJ
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
acpi_os_map_generic_address() return value"),acpi_os_map_generic_address
will return logical address or NULL for error, but pre_map_gar_callback,for
ACPI_ADR_SPACE_SYSTEM_IO case, it should be also return 0,as it's a
normal case, but now it will return -ENXIO. so check it out for such case
to avoid einj module initialization fail.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 drivers/acpi/apei/apei-base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 552fd9ffaca4..042d2dbdb855 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -230,7 +230,8 @@ static int pre_map_gar_callback(struct apei_exec_context *ctx,
 {
 	u8 ins = entry->instruction;
 
-	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER)
+	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER &&
+	 entry->register_region.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return apei_map_generic_address(&entry->register_region);
 
 	return 0;
-- 
2.18.4

