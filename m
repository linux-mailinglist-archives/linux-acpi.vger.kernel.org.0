Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F752AD70C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 14:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJNDo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 08:03:44 -0500
Received: from smtp.asem.it ([151.1.184.197]:62662 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbgKJNDo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 08:03:44 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000597663.MSG 
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2020 14:03:41 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 10
 Nov 2020 14:03:39 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 10 Nov 2020 14:03:39 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] Documentation: ACPI: fix spelling mistakes
Date:   Tue, 10 Nov 2020 14:03:38 +0100
Message-ID: <20201110130338.143077-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090215.5FAA8FAC.0074,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/firmware-guide/acpi/acpi-lid.rst       | 8 ++++----
 Documentation/firmware-guide/acpi/method-tracing.rst | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/acpi-lid.rst b/Documentation/firmware-guide/acpi/acpi-lid.rst
index 874ce0ed340d..71b9af13a048 100644
--- a/Documentation/firmware-guide/acpi/acpi-lid.rst
+++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
@@ -19,9 +19,9 @@ report the "current" state of the lid as either "opened" or "closed".
 
 For most platforms, both the _LID method and the lid notifications are
 reliable. However, there are exceptions. In order to work with these
-exceptional buggy platforms, special restrictions and expections should be
+exceptional buggy platforms, special restrictions and exceptions should be
 taken into account. This document describes the restrictions and the
-expections of the Linux ACPI lid device driver.
+exceptions of the Linux ACPI lid device driver.
 
 
 Restrictions of the returning value of the _LID control method
@@ -46,7 +46,7 @@ state is changed to "closed". The "closed" notification is normally used to
 trigger some system power saving operations on Windows. Since it is fully
 tested, it is reliable from all AML tables.
 
-Expections for the userspace users of the ACPI lid device driver
+Exceptions for the userspace users of the ACPI lid device driver
 ================================================================
 
 The ACPI button driver exports the lid state to the userspace via the
@@ -100,7 +100,7 @@ use the following kernel parameter:
 C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
-   ensure that the reliable "closed" notifications can always be delievered
+   ensure that the reliable "closed" notifications can always be delivered
    to the userspace by always pairing "closed" input events with complement
    "opened" input events. But there is still no guarantee that the "opened"
    notifications can be delivered to the userspace when the lid is actually
diff --git a/Documentation/firmware-guide/acpi/method-tracing.rst b/Documentation/firmware-guide/acpi/method-tracing.rst
index 0aa7e2c5d32a..6ab6c0964042 100644
--- a/Documentation/firmware-guide/acpi/method-tracing.rst
+++ b/Documentation/firmware-guide/acpi/method-tracing.rst
@@ -98,7 +98,7 @@ subject to change::
    [    0.188903]   exdebug-0398 ex_trace_point        : Method End [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
 
 Developers can utilize these special log entries to track the AML
-interpretion, thus can aid issue debugging and performance tuning. Note
+interpretation, thus can aid issue debugging and performance tuning. Note
 that, as the "AML tracer" logs are implemented via ACPI_DEBUG_PRINT()
 macro, CONFIG_ACPI_DEBUG is also required to be enabled for enabling
 "AML tracer" logs.
-- 
2.25.1

