Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE6179C0B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 23:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgCDWzz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 17:55:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46881 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgCDWzz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 17:55:55 -0500
Received: from 2.general.alexhung.us.vpn ([10.172.65.255] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1j9cvL-0007N9-Ky; Wed, 04 Mar 2020 22:55:32 +0000
From:   Alex Hung <alex.hung@canonical.com>
To:     corbet@lwn.net, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, mchehab+samsung@kernel.org,
        jpoimboe@redhat.com, akpm@linux-foundation.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, alex.hung@canonical.com
Subject: [PATCH][RESEND] acpi/x86: add a kernel parameter to disable ACPI BGRT
Date:   Wed,  4 Mar 2020 15:55:29 -0700
Message-Id: <20200304225529.6706-1-alex.hung@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

BGRT is for displaying seamless OEM logo from booting to login screen;
however, this mechanism does not always work well on all configurations
and the OEM logo can be displayed multiple times. This looks worse than
without BGRT enabled.

This patch adds a kernel parameter to disable BGRT in boot time. This is
easier than re-compiling a kernel with CONFIG_ACPI_BGRT disabled.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---

 * Resend to include linux-acpi emailing list

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/kernel/acpi/boot.c                     | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ffff776..55c5b2f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -442,6 +442,9 @@
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
+	bgrt_disable	[ACPI][X86]
+			Disable BGRT to avoid flickering OEM logo.
+
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
 	bttv.radio=	Most important insmod options are available as
 			kernel args too.
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 04205ce..d1757ce 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -45,6 +45,7 @@ EXPORT_SYMBOL(acpi_disabled);
 #define PREFIX			"ACPI: "
 
 int acpi_noirq;				/* skip ACPI IRQ initialization */
+int acpi_nobgrt;			/* skip ACPI BGRT */
 int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
@@ -1619,7 +1620,7 @@ int __init acpi_boot_init(void)
 	acpi_process_madt();
 
 	acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);
-	if (IS_ENABLED(CONFIG_ACPI_BGRT))
+	if (IS_ENABLED(CONFIG_ACPI_BGRT) && !acpi_nobgrt)
 		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 
 	if (!acpi_noirq)
@@ -1671,6 +1672,13 @@ static int __init parse_acpi(char *arg)
 }
 early_param("acpi", parse_acpi);
 
+static int __init parse_acpi_bgrt(char *arg)
+{
+	acpi_nobgrt = true;
+	return 0;
+}
+early_param("bgrt_disable", parse_acpi_bgrt);
+
 /* FIXME: Using pci= for an ACPI parameter is a travesty. */
 static int __init parse_pci(char *arg)
 {
-- 
2.7.4

