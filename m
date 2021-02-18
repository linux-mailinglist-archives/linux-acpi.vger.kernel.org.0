Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32231EC77
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Feb 2021 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhBRQpO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 18 Feb 2021 11:45:14 -0500
Received: from mx1.emlix.com ([136.243.223.33]:57396 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233095AbhBRNDa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Feb 2021 08:03:30 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 5E9626000C;
        Thu, 18 Feb 2021 13:30:40 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-acpi@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2 RESEND] tools/thermal: tmon: default to prefixed pkg-config when crosscompiling
Date:   Thu, 18 Feb 2021 13:30:39 +0100
Message-ID: <5626379.Ia07YmbPEo@devpool47>
Organization: emlix GmbH
In-Reply-To: <1946777.uSh3co5Jvm@devpool47>
References: <3551127.BzHy4GdJBa@devpool21> <6322266.jcO1KTHXCh@devpool21> <1946777.uSh3co5Jvm@devpool47>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This matches what other parts of the tools/ directory already do.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Cc: stable@vger.kernel.org
---
 tools/thermal/tmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 36dc70497066..0a2fd593c65f 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -10,7 +10,7 @@ override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
 override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
-PKG_CONFIG?= pkg-config
+PKG_CONFIG?= $(CROSS_COMPILE)pkg-config
 
 override CFLAGS+=-D VERSION=\"$(VERSION)\"
 TARGET=tmon
-- 
2.30.0

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



