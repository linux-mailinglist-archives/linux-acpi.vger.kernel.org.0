Return-Path: <linux-acpi+bounces-7991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975EB964E10
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF63B2315D
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656A1BD51C;
	Thu, 29 Aug 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="EqkWNcNU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067341BCA01;
	Thu, 29 Aug 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957078; cv=none; b=ZPr7/9obLMDu1r9DJhBVOSITg4bCcrLQtv3u7EhqONTCGGnSs/7cbMUYb6Tbq9I62oQJbjfL/xKaeahycgbVzYN5ESZ3nJQAGQS0fCmL340NjwtVmZrusL0Gb01wJn8cbvy2kc5uwWYIYiHpsNOlT+Ot3AImuGXOyMgDvpaslog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957078; c=relaxed/simple;
	bh=Mq3V6QLhYW+ch+key7wZXsUe+kaLlVaVj42moIwnKvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FL46hogyV3nHygniNkBUP2qtjn0/t/nL5gzJVWySKChQaQGrgfeRnC/2LIy3CC9f2AmARyueuBQHb0DAyMYZkdqvnueSoBfkTqcfRKye/UR0VdHbDSpPrTkKGFHYHIcNS6h07EeR8dGBKzr8YIAvXV3ZZFuo6/g+hTztCoOa89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=EqkWNcNU; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ae884a71b6712b5e; Thu, 29 Aug 2024 20:44:34 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AEC726A8C15;
	Thu, 29 Aug 2024 20:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957074;
	bh=Mq3V6QLhYW+ch+key7wZXsUe+kaLlVaVj42moIwnKvo=;
	h=From:Subject:Date;
	b=EqkWNcNUZI98Fic2Xk11c59ew/9v7dnR5Pg4iM/Cg+cFw24mNlXYwjSsIBwNrQMO7
	 F5LkWngQYGxuj1HzoGNmmKGIzKjoOSAsJO3uqrqF1ml8j9vnEA7TkB02VX9AkaocOe
	 KtDpiqwCl60lv4chPkLoeb6AsdvEF6xVySIJtx5MBd6VsP2slIhOcDefqoofWasw4X
	 hL04enFuFKk1cZwzc+SCIjHVvRzeqIxz2ghLHUdJt1G6/Po8VzLvCYBEZQO6QdV2Zf
	 kyW/ZtktD4Zzx0deha/G/Vf48umlsLXXJieHz5YJEMLR0KiWg3d/v8kkOuoWd5UXth
	 I+hcXbl+nY8sQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 03/20] ACPICA: SPCR: Update the SPCR table to version 4
Date: Thu, 29 Aug 2024 20:27:40 +0200
Message-ID: <2203218.irdbgypaU6@rjwysocki.net>
In-Reply-To: <5819337.DvuYhMxLoT@rjwysocki.net>
References: <5819337.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjefgjeejgfekjeetkedtkeegjeetjedtgfegtddtfeeigfegueeljedukeeitdenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdr
 tghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

ACPICA commit 1eeff52124a45d5cd887ba5687bbad0116e4d211

The Microsoft Serial Port Console Redirection (SPCR) specification
revision 1.09 comprises additional fields [1]. The newly added fields
are:
- RISC-V SBI
- Precise Baud Rate
- namespace_string_length
- namespace_string_offset
- namespace_string

Additionaly, this code will support up to SPCR revision 1.10, as it
includes only minor wording changes.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table # [1]
Link: https://github.com/acpica/acpica/commit/1eeff521
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl3.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 8f775e3a08fd..5cd755143b7d 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -92,10 +92,10 @@ struct acpi_table_slit {
 /*******************************************************************************
  *
  * SPCR - Serial Port Console Redirection table
- *        Version 2
+ *        Version 4
  *
  * Conforms to "Serial Port Console Redirection Table",
- * Version 1.03, August 10, 2015
+ * Version 1.10, Jan 5, 2023
  *
  ******************************************************************************/
 
@@ -112,7 +112,7 @@ struct acpi_table_spcr {
 	u8 stop_bits;
 	u8 flow_control;
 	u8 terminal_type;
-	u8 reserved1;
+	u8 language;
 	u16 pci_device_id;
 	u16 pci_vendor_id;
 	u8 pci_bus;
@@ -120,7 +120,11 @@ struct acpi_table_spcr {
 	u8 pci_function;
 	u32 pci_flags;
 	u8 pci_segment;
-	u32 reserved2;
+	u32 uart_clk_freq;
+	u32 precise_baudrate;
+	u16 name_space_string_length;
+	u16 name_space_string_offset;
+	char name_space_string[];
 };
 
 /* Masks for pci_flags field above */
-- 
2.43.0





