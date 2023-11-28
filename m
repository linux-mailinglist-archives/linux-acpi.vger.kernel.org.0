Return-Path: <linux-acpi+bounces-1841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48827FB0F0
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 05:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D03B2031D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 04:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE210792
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WhZgWzAB"
X-Original-To: linux-acpi@vger.kernel.org
X-Greylist: delayed 42879 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 18:54:44 PST
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479731A3
	for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2023 18:54:44 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTP id D06F560036;
	Tue, 28 Nov 2023 05:54:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bsJ7oIfa5mI0-dqbKgZ5Y;
	Tue, 28 Nov 2023 05:54:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701140078; bh=UPZl9BoNVOAZEiJrDswC4P0KrglEEZsHXCCZRP5h/ME=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=WhZgWzABcAz5yzzxPW43YWa/MiUFX1c0HdFyLQShVGDuOiL3j2NgIWjZbVfiM6rvp
	 apx1aZcBHHdPmHhfLWB7KwsyuCdkbja5hkzL1cpFnwWOCx4aP74Yjq4PHzeGf1Euos
	 SyQQnmxCSLS65OgnWDvE7u+MFPVS3DB/ynGIaZ7Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-acpi@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] pnp: acpi: fix fortify warning
Date: Tue, 28 Nov 2023 05:52:10 +0300
Message-ID: <20231128025411.141602-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0hrMy8c_eA+TxBb=gFF5tS147v3wORrQq=YTpuBDp5hKg@mail.gmail.com>
References: <CAJZ5v0hrMy8c_eA+TxBb=gFF5tS147v3wORrQq=YTpuBDp5hKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.0 20231126 (experimental)
and CONFIG_FORTIFY_SOURCE=y, I've noticed the following:

In file included from ./include/linux/string.h:295,
                 from ./include/linux/bitmap.h:12,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:17,
                 from ./arch/x86/include/asm/cpuid.h:62,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:9,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pnp/pnpacpi/rsparser.c:11:
In function 'fortify_memcpy_chk',
    inlined from 'pnpacpi_parse_allocated_vendor' at drivers/pnp/pnpacpi/rsparser.c:158:3,
    inlined from 'pnpacpi_allocated_resource' at drivers/pnp/pnpacpi/rsparser.c:249:3:
./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

According to the comments in include/linux/fortify-string.h, 'memcpy()',
'memmove()' and 'memset()' must not be used beyond individual struct
members to ensure that the compiler can enforce protection against
buffer overflows, and, IIUC, this also applies to partial copies from
the particular member ('vendor->byte_data' in this case). So it should
be better (and safer) to do both copies at once (and 'byte_data' of
'struct acpi_resource_vendor_typed' seems to be a good candidate for
'__counted_by(byte_length)' as well).

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: prefer sizeof(range) over hardcoded constant (Rafael J. Wysocki)
---
 drivers/pnp/pnpacpi/rsparser.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 4f05f610391b..c02ce0834c2c 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -151,13 +151,13 @@ static int vendor_resource_matches(struct pnp_dev *dev,
 static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
 				    struct acpi_resource_vendor_typed *vendor)
 {
-	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
-		u64 start, length;
+	struct { u64 start, length; } range;
 
-		memcpy(&start, vendor->byte_data, sizeof(start));
-		memcpy(&length, vendor->byte_data + 8, sizeof(length));
-
-		pnp_add_mem_resource(dev, start, start + length - 1, 0);
+	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid,
+				    sizeof(range))) {
+		memcpy(&range, vendor->byte_data, sizeof(range));
+		pnp_add_mem_resource(dev, range.start, range.start +
+				     range.length - 1, 0);
 	}
 }
 
-- 
2.43.0


