Return-Path: <linux-acpi+bounces-20598-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m0D0KR0sdGkV2wAAu9opvQ
	(envelope-from <linux-acpi+bounces-20598-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 03:19:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F917C32F
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 03:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FFE13019535
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 02:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBD8178372;
	Sat, 24 Jan 2026 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Kx8wb/R4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D41459FA;
	Sat, 24 Jan 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769221146; cv=none; b=IlvdbRMWnHeXdXVZ87Xc1arrlHSs5IS7YE86PN+TCXuQ403ayQb1+qzs+IbUIgtoKhtg9GlQkoK7awJT8rHU0woUqV8HOWPZlkfKtCj0gwI/Tqv0EHOxh9ghKLCb4CruvX162qlkZncRzEICul5NIkEKxSDJ9gleFd7I0gxMVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769221146; c=relaxed/simple;
	bh=vgz4wVRU0EbOjIqSrDOwksFXdzM2czTryQ+XM4C8MOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuI+xjcO/j3GPQr3rCXL+f7kq+PpBhqXQRFX5FdUoyeNYG/3oW1ipnqxRZWIvjofs20s0h/ogUfGXhuSLs/Ra4LP8BDU0gG/eJMk/KOg0Cbc8JhKPDWPoLp7Cfcn27YHZdkhYjJYmUJcCGgLE6rf0Eb0cnB+DVQNGyWmSdtrbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Kx8wb/R4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769221142; x=1769825942; i=w_armin@gmx.de;
	bh=iP0EZ4wOzqcD0Z+tsLEN9OsHq2n0KEuSI/NGvgt242s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kx8wb/R4GbrnzVv4gI8sXMqRAFvDqPNoVKebPqly85L/7TxLEencRcq3KRkQancy
	 eXACqxB3CshRhH8M3yFoWGq6OtWEKwOZVp0r5HW7Jqow6nmCwZnNz8WqGl+BNMTuZ
	 yXSJxAWq8TeRYi4H/totmudoXu5nlifVrzpxucSOhliNlHRQO803UvU9y0LqTMSQn
	 7DSxEpN4/NGpFGk49mV/3AcVgeZWxfsbP35ceAqKoSNl/io3lcCJMNWhI04bsUR0a
	 1YR4VVaYFr0G3DDJZpGKttqHm9PVN4MaBOoHR7fW84sn5pQlmsOdgjfmAgO2KjZoB
	 RCPjca0sLDGMSS143A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MhU5b-1wFFgL2ApX-00aG33; Sat, 24 Jan 2026 03:19:02 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: OSL: Panic when encountering a fatal ACPI error
Date: Sat, 24 Jan 2026 03:18:59 +0100
Message-Id: <20260124021859.8337-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ECK2NWbmYPltfaSUbIxaJw2TbJHxMRShFNsKhWY3IpghEFZ8U3Q
 Pj33/eQhqabb4tQtZ+dEzNRlpd1p9H9Ca7fWaT89gmyGV/UVw3sSwau0lqxJbCj7kkqaV5t
 6w007a/x6nH7jygDLWWPn/AJkQhgqq5yN2bA4AW+XMJjgUoFgFevh89aSfrFRqLjk/gdO/M
 9g5ZYKKZPscbaPLLyHWdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fk1LhW+IICw=;9bF/lyR3XCr6YrhyhYCNXVCQ2fp
 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
 +N/fG+aolSsMiSmR5hXN
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20598-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:dkim,gmx.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uefi.org:url]
X-Rspamd-Queue-Id: F3F917C32F
X-Rspamd-Action: no action

The ACPI spec states that the operating system should respond
to a fatal ACPI error by "performing a controlled OS shutdown in
a timely fashion". Windows complies with this requirement by entering
a BSOD upon executing the "Fatal()" ASL opcode, a implementation
detail that is used by some firmware implementations for signaling
fatal hardware errors.

Comply with the ACPI specification by triggering a kernel panic
when ACPICA signals a fatal ACPI error. Users can still disable
this behavior by using the acpi.panic_on_fatal kernel option to
work around firmware bugs.

Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fatal-er=
ror-check
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../admin-guide/kernel-parameters.txt          |  9 +++++++++
 drivers/acpi/Kconfig                           | 11 +++++++++++
 drivers/acpi/osl.c                             | 18 +++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..140bb239857f 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -187,6 +187,15 @@ Kernel parameters
 			unusable.  The "log_buf_len" parameter may be useful
 			if you need to capture more output.
=20
+	acpi.panic_on_fatal=3D	[ACPI]
+			{0 | 1}
+			Causes the kernel to panic when the ACPI bytecode signals
+			a fatal error. The default value of this setting can
+			be configured using CONFIG_ACPI_PANIC_ON_FATAL.
+			Overriding this value should only be done for diagnosing
+			ACPI firmware problems, as some firmware implementations
+			use this mechanism to signal fatal hardware errors.
+
 	acpi_enforce_resources=3D	[ACPI]
 			{ strict | lax | no }
 			Check for resource conflicts between native drivers
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index df0ff0764d0d..7139e7d8ac25 100644
=2D-- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
        depends on THERMAL
        bool
=20
+config ACPI_PANIC_ON_FATAL
+	bool "Panic on fatal ACPI error"
+	default y
+	help
+	  The ACPI bytecode can signal that a fatal error has occurred using the=
 Fatal()
+	  ASL operator, normaly causing a kernel panic. Disabling this option ca=
uses such
+	  a condition to be treated like a ordinary ACPI error.
+
+	  This setting can also be overridden during boot using the acpi.panic_o=
n_fatal
+	  kernel parameter.
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface"
 	select ACPI_DEBUG
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 05393a7315fe..b62ea126ea59 100644
=2D-- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "ACPI: OSL: " fmt
=20
 #include <linux/module.h>
+#include <linux/panic.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -70,6 +71,10 @@ static bool acpi_os_initialized;
 unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
 bool acpi_permanent_mmap =3D false;
=20
+static bool panic_on_fatal =3D CONFIG_ACPI_PANIC_ON_FATAL;
+module_param(panic_on_fatal, bool, 0);
+MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encounterin=
g a fatal ACPI error");
+
 /*
  * This list of permanent mappings is for memory that may be accessed fro=
m
  * interrupt context, where we can't do the ioremap().
@@ -1381,9 +1386,20 @@ acpi_status acpi_os_notify_command_complete(void)
=20
 acpi_status acpi_os_signal(u32 function, void *info)
 {
+	struct acpi_signal_fatal_info *fatal_info;
+
 	switch (function) {
 	case ACPI_SIGNAL_FATAL:
-		pr_err("Fatal opcode executed\n");
+		fatal_info =3D info;
+		if (panic_on_fatal) {
+			panic("Fatal ACPI BIOS error (type 0x%X code 0x%X argument 0x%X)",
+			      fatal_info->type, fatal_info->code, fatal_info->argument);
+		} else {
+			pr_emerg("Fatal ACPI BIOS error (type 0x%X code 0x%X argument 0x%X)\n"=
,
+				 fatal_info->type, fatal_info->code, fatal_info->argument);
+			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		}
+
 		break;
 	case ACPI_SIGNAL_BREAKPOINT:
 		/*
=2D-=20
2.39.5


