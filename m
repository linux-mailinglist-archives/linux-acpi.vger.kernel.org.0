Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018D015D223
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 07:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgBNGaP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 01:30:15 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:44941 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgBNGaP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Feb 2020 01:30:15 -0500
Received: from localhost.localdomain ([93.22.37.15])
        by mwinf5d17 with ME
        id 2WWB220080KcLDH03WWBpd; Fri, 14 Feb 2020 07:30:13 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 14 Feb 2020 07:30:13 +0100
X-ME-IP: 93.22.37.15
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ACPICA: Fix a typo in acuuid.h
Date:   Fri, 14 Feb 2020 07:30:03 +0100
Message-Id: <20200214063003.29741-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The comment related to the ending of the include guard should be related to
__ACUUID_H__, not __AUUID_H__ (i.e. 'C' is missing).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/acpi/acuuid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 9dd4689a39cf..9e1367b19069 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -57,4 +57,4 @@
 #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-7cb7b9f4e500"
 #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-bc9bbf4aa301"
 
-#endif				/* __AUUID_H__ */
+#endif				/* __ACUUID_H__ */
-- 
2.20.1

