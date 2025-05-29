Return-Path: <linux-acpi+bounces-13961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC16AC8580
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 01:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22AE3A9090
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0B21E0B7;
	Thu, 29 May 2025 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YxDZKzGf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5221770A;
	Thu, 29 May 2025 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562799; cv=none; b=kRV4Ycj2b0O9cNEjJIVWI5MeHwubD9dKvXWZlK7JmVKryyrRAmluoIDiW0Pj0YcXpwNNxSb0vA0WAxguSxFNu9Di9m91m+yEdpwRmSx6jJbAmRIm+GqtnBgzC8jgbkhZDeeaEvPuv6+mcn1zDTFPsgpQZFWPCcIUXilc9k6jSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562799; c=relaxed/simple;
	bh=JOC4w+zue4FTMoTi6ERNkb+SeYMApstV7lkRuxVtVv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dnqLvrsCw7rU+ZuOdX5WQTbzNTzC5MvfSg5wjypKIoMFanlUuBne7SnYsd4N8u2AdQYI524FZ+DjQU6G/A9mvGAmEzuRJ0y1pkPIOmpxgS//EMht9VbNJ7bUd4eiTiLXyv1Kerwmi1/H8lLh9+y9qe818oIogr8j1D41+ISzZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YxDZKzGf; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748562794; x=1749167594; i=w_armin@gmx.de;
	bh=e9xuln1SvriLHl8ZltQCd3nro3KjfHT21Kdvd6/SSG8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YxDZKzGf3wjoM9kdskdRpXTGwNXBkFkDXzp3ZZZ+DZeCXWgSHWMYPTdsgGg6TJn7
	 GTXDqPYRHIK/lEdqjPQta8q2SE8xPhcyAvH7Hlx9r/oFtIh3dFnDKwjQM++szsL9Q
	 wbfKEtdqaKCeytWsoLxOgTTuX1+G8zD7219KmX2YySHBJnA26f98H9Lc2MnDJJk+Y
	 oS77GkeKGCR9viLwbCf0vdZuzR2SRD7mgmml63tHlU6u4MmOAz1jTLoiIm3wZY3y/
	 Okf2kmdjzhoVbM7Jy4uEFWIVDoSoC/P0UItHcZqNt6F8xfJ+JnoJjGZ2jw3KEci7+
	 EMgOna/m/hKBRcs40Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M5QJD-1uMAVL1htF-001y4D; Fri, 30 May 2025 01:53:14 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org,
	glpnk@proton.me
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: EC: Ignore ECDT tables with an invalid ID string
Date: Fri, 30 May 2025 01:53:10 +0200
Message-Id: <20250529235310.540530-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XAOejiPRm/Ixf+GhQ1c0z3To6JH8BeqCT/OJtDiT0EymRO5stWb
 p1HW9GgypqWAdjGGFBZsGgomE5YpylmV+6Mwop5QfxKS0aWaSS+QIS4/D5H35JZ20/YTa5q
 Mrxy9jux/d1RYvZQogMfggk7EfapKAu/y/8iS5qVp7y4AjC7Zhr86Gn3WMnAo3y1/U3Vtvo
 sE59GvXkJViXzrRlV7ovg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nY97imZsYwU=;N9k4ToxvN6q9vTvrpOpcAMsTC0Y
 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
 JVJarF/h6KSrMSfm

On the MSI Modern 14 C5M the ECDT table contains invalid data:

	UID : 00000000
 GPE Number : 00	/* Invalid, 03 would be correct */
   Namepath : ""	/* Invalid, "\_SB.PCI0.SBRG.EC" would
			 * be correct
			 */

This slows down the EC access as the wrong GPE event is used for
communication. Additionally the ID string is invalid.

Ignore such faulty ECDT tables by verifying that the ID string has
a valid format.

Tested-by: glpnk@proton.me
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 6f4203716b53..75c7db8b156a 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -23,8 +23,10 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
@@ -2031,6 +2033,21 @@ void __init acpi_ec_ecdt_probe(void)
 		goto out;
 	}
=20
+	if (!strstarts(ecdt_ptr->id, "\\")) {
+		/*
+		 * The ECDT table on some MSI notebooks contains invalid data, together
+		 * with an empty ID string ("").
+		 *
+		 * Section 5.2.15 of the ACPI specification requires the ID string to b=
e
+		 * a "fully qualified reference to the (...) embedded controller device=
",
+		 * so this string always has to start with a backslash.
+		 *
+		 * By verifying this we can avoid such faulty ECDT tables in a safe way=
.
+		 */
+		pr_err(FW_BUG "Ignoring ECDT due to invalid ID string \"%s\"\n", ecdt_p=
tr->id);
+		goto out;
+	}
+
 	ec =3D acpi_ec_alloc();
 	if (!ec)
 		goto out;
=2D-=20
2.39.5


