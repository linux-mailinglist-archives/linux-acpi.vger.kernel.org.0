Return-Path: <linux-acpi+bounces-20855-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PdAdFES6g2l4tgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20855-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 22:29:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D21ECBC7
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 22:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 310DB30120C8
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233437C113;
	Wed,  4 Feb 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Emw50Z8F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E4326942;
	Wed,  4 Feb 2026 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240577; cv=none; b=leifE/FjqiU0XmAYoLS5GXQg73QjHprassb23CpYe186dVzuM3KqJ6ZBM5okc+ylFCvZZs5WhotKwMCbPUkUTSefljCA/U848NV/B0sxDP6qX8V9OEnfGDfMdS1pQbTHkubic20LmUq8cPjiWcbCWv5TXWfufXfyRcVOpTEbXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240577; c=relaxed/simple;
	bh=f3wEGtVnMpHJp1HZOPppaVOCjnRS8fdXMhoEy7L/ykc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zcihxm7ASq8a7Wf9rMX4/03jetKNnb2fQq4kapQYS5o1Nu382dnOR+LkuEZlKRCkyh7GBh2Ktt447rcgMuy2WCS2iPd2O2PD5TSkZpV0a+yvdqgP+l94bOME2gV7TPPtQJUsoHbxZa5fKRM3cKg2adrZaZ1rVXEwMYuQoEMMRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Emw50Z8F; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770240574; x=1770845374; i=w_armin@gmx.de;
	bh=xdLu25vZJxn+0JI1GoGSC0KPyXXZd0i8cHBjshao/4k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Emw50Z8FgX0drvmeZjFk7k75GbDER/Id7IWVxntJu1Zctt1FxrJCrlrgYGrynOtT
	 ecQjEJLZ+RsKVgS0MqN+Qa1GWzyjNSCJKBPqy497OLbNElidM0ZAUvfywqFTYhKwR
	 hK61pBU/F9cCeox7T5WrZhFjgdk8NLsszmih65Y+hGdeWz/Ulctd76PpMrcb9ZQqU
	 UzAIivXar5z0mVPa713KXdbVzKIv/RKqHZy0K4OkAChhAg3ZOZxAY2tLjq7AZOs8l
	 BVl37kTlImKOEdPy71oxx7mVlp9VB/d+8J3mGXAy7Nf/BP3z3MSgiIZ7XGm1VsCt3
	 4ha09JKlKtPGevB2xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.242.224]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MuDc7-1vZ6Qt1wOT-011RMm; Wed, 04 Feb 2026 22:29:34 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI error
Date: Wed,  4 Feb 2026 22:29:31 +0100
Message-Id: <20260204212931.3860-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ypJSRcfzQDo8t1p8t+NdmNrQS+wnm0g8SgdnazpWyp+PvmvUGcr
 HGheIdfMRpEHYsuxfWoamSe3405jskIy0w3DlJc6H+5MOZzIHqY3Rwix5y10D06x5p1F6r7
 snZAVb9xC5TvIV6GlOhfSX3fPhiKMuJtE1LVgV3UeOfYZG9Yy7LZk4+mBXUGcI95RWZhbLI
 1isEuhpL0KMzq/AuX1cNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LYffmuMScO8=;2ugR+mqa/Gd/yAXT1LebujIolEJ
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20855-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email,gmx.de:dkim,gmx.de:mid,uefi.org:url]
X-Rspamd-Queue-Id: B2D21ECBC7
X-Rspamd-Action: no action

The ACPI spec states that the operating system should respond
to a fatal ACPI error by "performing a controlled OS shutdown in
a timely fashion". Comply with the ACPI specification by powering
off the system when ACPICA signals a fatal ACPI error. Users can
still disable this behavior by using the acpi.poweroff_on_fatal
kernel option to work around firmware bugs.

Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fatal-er=
ror-check
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v2:
- poweroff instead of triggering a kernel panic

Changes since v1:
- use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON_FATAL
=2D--
 .../admin-guide/kernel-parameters.txt         |  9 +++++++++
 drivers/acpi/Kconfig                          | 11 +++++++++++
 drivers/acpi/osl.c                            | 19 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..1f2eaa0ec424 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -187,6 +187,15 @@ Kernel parameters
 			unusable.  The "log_buf_len" parameter may be useful
 			if you need to capture more output.
=20
+	acpi.poweroff_on_fatal=3D	[ACPI]
+			{0 | 1}
+			Causes the system to poweroff when the ACPI bytecode signals
+			a fatal error. The default value of this setting can
+			be configured using CONFIG_ACPI_POWEROFF_ON_FATAL.
+			Overriding this value should only be done for diagnosing
+			ACPI firmware problems, as the system might behave erratically
+			after having encountered a fatal ACPI error.
+
 	acpi_enforce_resources=3D	[ACPI]
 			{ strict | lax | no }
 			Check for resource conflicts between native drivers
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index df0ff0764d0d..1610dd4c8278 100644
=2D-- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
        depends on THERMAL
        bool
=20
+config ACPI_POWEROFF_ON_FATAL
+	bool "Poweroff on fatal ACPI error"
+	default y
+	help
+	  The ACPI bytecode can signal that a fatal error has occurred using the=
 Fatal()
+	  ASL operator, normaly causing the system to poweroff. Disabling this o=
ption causes
+	  such a condition to be treated like a ordinary ACPI error.
+
+	  This setting can also be overridden during boot using the acpi.powerof=
f_on_fatal
+	  kernel parameter.
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface"
 	select ACPI_DEBUG
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 05393a7315fe..f2b45fa4a752 100644
=2D-- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -11,8 +11,10 @@
=20
 #define pr_fmt(fmt) "ACPI: OSL: " fmt
=20
+#include <linux/kconfig.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
@@ -70,6 +72,10 @@ static bool acpi_os_initialized;
 unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
 bool acpi_permanent_mmap =3D false;
=20
+static bool poweroff_on_fatal =3D IS_ENABLED(CONFIG_ACPI_POWEROFF_ON_FATA=
L);
+module_param(poweroff_on_fatal, bool, 0);
+MODULE_PARM_DESC(poweroff_on_fatal, "Poweroff when encountering a fatal A=
CPI error");
+
 /*
  * This list of permanent mappings is for memory that may be accessed fro=
m
  * interrupt context, where we can't do the ioremap().
@@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(void)
=20
 acpi_status acpi_os_signal(u32 function, void *info)
 {
+	struct acpi_signal_fatal_info *fatal_info;
+
 	switch (function) {
 	case ACPI_SIGNAL_FATAL:
-		pr_err("Fatal opcode executed\n");
+		fatal_info =3D info;
+		pr_emerg("Fatal error while evaluating ACPI control method\n");
+		pr_emerg("Type 0x%X Code 0x%X Argument 0x%X\n",
+			 fatal_info->type, fatal_info->code, fatal_info->argument);
+
+		if (poweroff_on_fatal)
+			orderly_poweroff(true);
+		else
+			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+
 		break;
 	case ACPI_SIGNAL_BREAKPOINT:
 		/*
=2D-=20
2.39.5


