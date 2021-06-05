Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6739C69F
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhFEHcL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Jun 2021 03:32:11 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:43499 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFEHcK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jun 2021 03:32:10 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d43 with ME
        id DKWL2500421Fzsu03KWLD5; Sat, 05 Jun 2021 09:30:22 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 05 Jun 2021 09:30:22 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ACPI / NUMA: fix a a typo in a comment
Date:   Sat,  5 Jun 2021 09:30:19 +0200
Message-Id: <114091055ede539a924ec675ad4a56284b9314d5.1622878126.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix a typo in comment related to the closing #endif of an include-guard.
s/__ACP_NUMA_H/__ACPI_NUMA_H/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/acpi/acpi_numa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 40a91ce87e04..68e4d80c1b32 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -43,4 +43,4 @@ static inline void disable_hmat(void)
 {
 }
 #endif				/* CONFIG_ACPI_HMAT */
-#endif				/* __ACP_NUMA_H */
+#endif				/* __ACPI_NUMA_H */
-- 
2.30.2

