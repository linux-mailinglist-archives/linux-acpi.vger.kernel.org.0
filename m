Return-Path: <linux-acpi+bounces-9597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60BB9CF1F0
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BDB28E574
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F921D5CD4;
	Fri, 15 Nov 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghshrvB+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62B1D5165;
	Fri, 15 Nov 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688954; cv=none; b=Lw3NJ2JRWH3RDxtRirD+/S3xTmTZMrKEpDpojlaaMdBTf4ObEOmzUVzJHEPoSeAFoTojVD+4/o8zUWVFZui2t9punvVyI7t5bqjFndi+jbBM78v6jCIxrDQUbgwMA8fYGOR10CsA5sEnptu1H3cFL39a0OVs3lE/2ZIkwUnUuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688954; c=relaxed/simple;
	bh=eGCZvEmA7ie7pKdU66pNqnQZp8Z9obRQA7YclCEYj64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IqnDlksC4xxwh7faMZ105pg0Nyb/kTiRSAzAKNZO59jI1qLPbMjV7Ux7xm1RKrKhfJgfUwA1Ic1a6Qyi9xVB/GB4QqUHdu3tIRmkCcHBL7RZOiLjM2Y8dU1Rj3SmmGEih/RpPaU9+IrLoRQbZMJ9aF2AYu6wXesZ31a98vfhHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghshrvB+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c77459558so18890985ad.0;
        Fri, 15 Nov 2024 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688952; x=1732293752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TODZ+AXcsK9cjGMUdNaxyVTGCoF9DGWEPGU3RYo2xFg=;
        b=ghshrvB+6L4Axjhh3vKVaK3SfJl6CORvL8wyvPCenVggi7mXWs2zGD8GQKjJcYYJnX
         VsYPRDgi0s89jNutlXRDIrcxq59/z0oAOQVSc+/juhdGcRSv3PcxF8SL0MEFc1zY/78G
         wo+i2xw2q4Dy87Dhu+L9eeQdXs5j2N4+i2lh2poHtIwAkFqqhWdP2ndBjwDN1DFuwbNt
         zPvbn5+AKrVgMT2q58g4ZKJ1/Jq17A+WjSoxV5fH+gcb58AW04Xu3eEGvS7zWEq3GqZc
         7YKU94Z9kScpXusM+xib/MT9K+WNwgMBlTEPTtormzzDTR//jCzMZaCA/nJPVK1Tot2/
         Dhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688952; x=1732293752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TODZ+AXcsK9cjGMUdNaxyVTGCoF9DGWEPGU3RYo2xFg=;
        b=ffHmkgOZPuOYjC+8cpcuLWCbZzkCBH+qF1BCr8DK0TiR4ry6Dmoebv6orGMQmRQz7q
         QYyUNlnAB7WvyGnT6usLklQ762LhewhLlKwjh/kH6ILut7dkRrDR2RsrRY9MygdHdVjl
         zMBHBnMOwAsBy+f+Wkid4OF/RWTP+e1GKjupWW+BAhpBWuQ/K2Oh14uV2TL6dE0vnMq1
         ZDzyVh59F4b+rWCaOi5wRHUtiwFcodSdqMSlfSmExjJqkYeLKJ9jHS2AW1oZ+BLL8ubi
         zRxOCR5mq3y2xz/IeHkrGhsioaomtTOGUgNfQCPKptQUtghW7Z7Tq1WZlhKTz6kr+TYH
         SCmA==
X-Forwarded-Encrypted: i=1; AJvYcCWCcQPZac/M0rGgNG5ljBO03pDePotpibExJb7TnUNKDQlSQbvpJLhZVjvRjJ0xmEW9Scr/JPD/6jDr@vger.kernel.org, AJvYcCXtt8UH+tzevXIfnV9u3xIJlmG/U6AE5l5uCeUIcf5LJGedKywL6K0tpKVXvqw8MYLNkLI/ty5WayJ2FlxN@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNyt1J0skJJrU1i5V0DZY426TVW6QApLwfH5jKmA0iuxHZLkP
	JZWsTEv19Xgtn3LLLt1cancQn3AfwivcYii5ssPb/mJChRc8bohb
X-Google-Smtp-Source: AGHT+IFXVEq2Os8nSZr+X/xzuwmlc1jAw5JYzx1aeop97PjJb18gp5M5i6T7dsafCr4jsCVhF8YItA==
X-Received: by 2002:a17:902:e886:b0:20c:b606:d014 with SMTP id d9443c01a7336-211d0ebcc2emr43947885ad.44.1731688952479;
        Fri, 15 Nov 2024 08:42:32 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f32008sm14351125ad.157.2024.11.15.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:42:31 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com
Cc: dave.jiang@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Subject: [PATCH v4] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Date: Fri, 15 Nov 2024 22:12:23 +0530
Message-Id: <20241115164223.20854-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by syzbot with KASAN:

BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
core.c:416 [inline]
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
drivers/acpi/nfit/core.c:459

The issue occurs in cmd_to_func when the call_pkg->nd_reserved2
array is accessed without verifying that call_pkg points to a buffer
that is appropriately sized as a struct nd_cmd_pkg. This can lead
to out-of-bounds access and undefined behavior if the buffer does not
have sufficient space.

To address this, a check was added in acpi_nfit_ctl() to ensure that
buf is not NULL and that buf_len is less than sizeof(*call_pkg)
before accessing it. This ensures safe access to the members of
call_pkg, including the nd_reserved2 array.

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/ 
V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
potential uninitialized variable usage if condition is true.
V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
and updated the Fixes tag to reference the correct commit.
V4: Removed the explicit cast to maintain the original code style.

 drivers/acpi/nfit/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef..84d8eef2a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -454,8 +454,15 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
-	if (cmd == ND_CMD_CALL)
+	if (cmd == ND_CMD_CALL) {
+		if (!buf || buf_len < sizeof(*call_pkg)) {
+			rc = -EINVAL;
+			goto out;
+		}
+
 		call_pkg = buf;
+	}
+
 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
 	if (func < 0)
 		return func;
-- 
2.34.1


