Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92632EF4CA
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbhAHP0o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:26:44 -0500
Received: from smtp.asem.it ([151.1.184.197]:54745 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbhAHP0o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 10:26:44 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000699523.MSG 
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 16:26:02 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 Jan
 2021 16:26:00 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 8 Jan 2021 16:26:00 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] Documentation: ACPI: add new rule for gpio-line-names
Date:   Fri, 8 Jan 2021 16:24:47 +0100
Message-ID: <20210108152447.116871-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F26.5FF87988.008D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The gpio-line-names lists must respect some rules.

This patch adds a new rule in documentation, to avoid
the use of duplicate names in the same gpiochip.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/firmware-guide/acpi/gpio-properties.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index b36aa3e743d8..4e264c16ddff 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -146,6 +146,7 @@ following rules (see also the examples):
     other words, it is not mandatory to fill all the GPIO lines
   - empty names are allowed (two quotation marks ``""`` correspond to an empty
     name)
+  - names inside one GPIO controller/expander must be unique
 
 Example of a GPIO controller of 16 lines, with an incomplete list with two
 empty names::
-- 
2.25.1

