Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82E2B92FA
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 14:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKSM6H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 07:58:07 -0500
Received: from smtp.asem.it ([151.1.184.197]:64704 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgKSM6G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 07:58:06 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000618689.MSG 
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2020 13:58:04 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 13:58:02 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 19 Nov 2020 13:58:02 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Alexander A . Klimov" <grandmaster@al2klimov.de>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] docs: ACPI: dsd: enable hyperlink in final references
Date:   Thu, 19 Nov 2020 13:58:01 +0100
Message-ID: <20201119125801.719775-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090203.5FB66BDA.006B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For inline web links, no special markup are needed.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/firmware-guide/acpi/dsd/leds.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/leds.rst b/Documentation/firmware-guide/acpi/dsd/leds.rst
index aba1e9abfeeb..b99fff8e06f2 100644
--- a/Documentation/firmware-guide/acpi/dsd/leds.rst
+++ b/Documentation/firmware-guide/acpi/dsd/leds.rst
@@ -90,10 +90,10 @@ where
 References
 ==========
 
-[1] Device tree. <URL:https://www.devicetree.org>, referenced 2019-02-21.
+[1] Device tree. https://www.devicetree.org, referenced 2019-02-21.
 
 [2] Advanced Configuration and Power Interface Specification.
-    <URL:https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf>,
+    https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf,
     referenced 2019-02-21.
 
 [3] Documentation/devicetree/bindings/leds/common.txt
@@ -101,11 +101,11 @@ References
 [4] Documentation/devicetree/bindings/media/video-interfaces.txt
 
 [5] Device Properties UUID For _DSD.
-    <URL:https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+    https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
     referenced 2019-02-21.
 
 [6] Hierarchical Data Extension UUID For _DSD.
-    <URL:https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+    https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
     referenced 2019-02-21.
 
 [7] Documentation/firmware-guide/acpi/dsd/data-node-references.rst
-- 
2.25.1

