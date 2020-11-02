Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71D02A232D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 03:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgKBCuY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Nov 2020 21:50:24 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:47528 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgKBCuY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Nov 2020 21:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=KCsv8vHkO6xKCVErXe
        6VA5vMcS6AIzNNqhdF1YcHtn0=; b=HfGJ+1dGzNQwruv4K9jmhNDcatvuH/QdTU
        G1gLCSGFsm/g96JXB2kx5levv5MdqoZETvGtXV5Oyox1rkx8sgW1yIdJVWo6FMWz
        tvylOram0FC5eo6B9cGaYDTV1mQHDWEl0XVcVaQGK3HtDhhetHKHkX8NxxLnZSu7
        6rHSKq4CA=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp3 (Coremail) with SMTP id G9xpCgDHeGlAc59fZ4mSJw--.12S2;
        Mon, 02 Nov 2020 10:47:33 +0800 (CST)
From:   yaoaili126@163.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, yangfeng1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: [PATCH] ACPI, APEI, Fix incorrect return value of apei_map_generic_address
Date:   Sun,  1 Nov 2020 18:47:26 -0800
Message-Id: <20201102024726.8214-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <28dc453f-40b8-8263-5aeb-f8979f54a941 () arm ! com>
References: <28dc453f-40b8-8263-5aeb-f8979f54a941 () arm ! com>
X-CM-TRANSID: G9xpCgDHeGlAc59fZ4mSJw--.12S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZr45Zr4UJw45Kr48ArW7XFb_yoW8Jr13pF
        W29FW2kr4Utr48Kw4UAw1YqFy5u3Z3AFy7tr40ywn09F15CFW7Cryq9a1DCa4rJF48J3yF
        qFsrtFW5uayDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaLvNUUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbiLAnQG1spZS4liQAAs7
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
acpi_os_map_generic_address() return value"),acpi_os_map_generic_address
will return logical address or NULL for error, but
pre_map_gar_callback and related apei_map_generic_address ,for
ACPI_ADR_SPACE_SYSTEM_IO case, it should be also return 0,as it's a
normal case, but now it will return -ENXIO. so check it out for such
case to avoid einj module initialization fail.

Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 drivers/acpi/apei/apei-base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 552fd9ffaca4..3294cc8dc073 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -633,6 +633,10 @@ int apei_map_generic_address(struct acpi_generic_address *reg)
 	if (rc)
 		return rc;
 
+	/* IO space doesn't need mapping */
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		return 0;
+
 	if (!acpi_os_map_generic_address(reg))
 		return -ENXIO;
 
-- 
2.18.4

