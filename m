Return-Path: <linux-acpi+bounces-1835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB71E7FA69A
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF35B20EEB
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3031A60
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wb5OPor9"
X-Original-To: linux-acpi@vger.kernel.org
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 07:05:23 PST
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF6BB
	for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2023 07:05:23 -0800 (PST)
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id C9C4667DF5
	for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2023 18:00:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1492:0:640:cd24:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTP id 628F1608F6;
	Mon, 27 Nov 2023 18:00:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xxUYkABcsa60-j97w3XwR;
	Mon, 27 Nov 2023 18:00:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701097200; bh=vJObKaWIE7oscY8SvaCxBGhWiswWq6kWoCCmp134KWU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=wb5OPor979+hNvRwVMjpkkkxBIjL5VbaAfkhCffq0TwECanOQS71KNEO3+vlbWr3o
	 kQOiIStdVRqYeM6dBJAHgyjKJQGHjC1j0LnTvMstzCwGbIAgjGXaiqijQrY76t0dmV
	 amQkjLsgqR3wdkwwcd3ewhq0+QzXeJhaP38rO/rk=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-acpi@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] pnp: acpi: fix fortify warning
Date: Mon, 27 Nov 2023 17:58:50 +0300
Message-ID: <20231127145907.131160-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
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
 drivers/pnp/pnpacpi/rsparser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 4f05f610391b..af51f893525e 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -152,12 +152,12 @@ static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
 				    struct acpi_resource_vendor_typed *vendor)
 {
 	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
-		u64 start, length;
+		struct { u64 start, length; } range;
 
-		memcpy(&start, vendor->byte_data, sizeof(start));
-		memcpy(&length, vendor->byte_data + 8, sizeof(length));
+		memcpy(&range, vendor->byte_data, 16);
 
-		pnp_add_mem_resource(dev, start, start + length - 1, 0);
+		pnp_add_mem_resource(dev, range.start, range.start +
+				     range.length - 1, 0);
 	}
 }
 
-- 
2.43.0


