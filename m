Return-Path: <linux-acpi+bounces-9613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E699B9CFEA8
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E01F22E2A
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073C5192B8F;
	Sat, 16 Nov 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EveRJaJT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FF191F9B;
	Sat, 16 Nov 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731757240; cv=none; b=RMOyYYL4LbdU+nDwBJdJuBplb840vFwzWlChyA48Xu8rcQC0Z4JfJYeENaB435lLIyddOhRj1GovGCMoFb6VNziytCS+Xg17crx43Fh7M91bRhVnoZkBn6uhiCipG1wyonDkEVu/y+QfPdeg/4rCL1LOfSJHRp/BKuNlj7vg6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731757240; c=relaxed/simple;
	bh=4yqtf3TxzZLdieOGloCVo+/KNale2JTxAEniThZmU1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEMKA78ymybC+9RLILiceGRuJuVf1wc5HUwuahGV6MS6ogvuz6sAkOOujwi51niYxVzPG8sdTWFkiqqX6Z3fnbUdc+hAwlP4MaoR5EXy4hAyqO3c2nZ0VRUQCljFYbr2FHRanD5PJeAoUDLfWUAeJFFRN9FXN+p/Gga9tKkML9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EveRJaJT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so2161374a12.0;
        Sat, 16 Nov 2024 03:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731757239; x=1732362039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QES5ivYy4we8CGU9IJFUjy9+jaCCLBYcx/iDh9H/oSQ=;
        b=EveRJaJTbOH6ZpgiTkqh+0F+JaO5ZjSNQYJHy1tFj/Qqs3z4qn02bpfQ0bKfL20z1G
         /6KGQZ4RcFS5OMaFvkdAcgEcnBPtva7edTLVq5HkbeiFnBrede2h5ht9KDEuhnL2HeSu
         KYqtj29VgJoXBfVIbx4PH0czHjRv08NDs2RMTGoIqTy7svmTYkDPH9mcupW3pE7liCWI
         zJX9EuUsSQFiGF5Th7uk9PghqUlEPMoQ24D2SBgLCBoRYsfTEBOstYc3d6IuePTfBWh7
         mEIx1NFHtvRM1bar4ND6ACocsCGGOM6m5V8yYdtzPCxlIWO+g6Yj26aKGUAsPPUZFgC0
         NXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731757239; x=1732362039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QES5ivYy4we8CGU9IJFUjy9+jaCCLBYcx/iDh9H/oSQ=;
        b=grsrTG8ZTlLjCG7T4NB6ozMYPR2wQ87c9YKnO1PF8nmp2VtL/IgcTC06PCm1qS6HRY
         Vv0Vy1aohmOAeGPbRIXpPv0BPDMwo6J65/t99cDyDgyV0x9sHCGO+6eRsBUyMcSQnzW7
         f1JOnjR4Y6m5YOtpi+7YlkGcR9CE8/3CU5MIkxGGVQBOWoJ4XnQptDcE96K4V7V0VQ6S
         aGpkwlVO1ynMyeipsltnGL1S38d77XSswzaOMnXVM+Lcrmzj5lMdfS6p0DT7Qj1ZRCLn
         3rpocnHQ+2IIrIFTTOk5Ee5YUl0Vl/C4VLoigOJ+Ffp2G4RZW7oZB2G4hp+WP0nqomsd
         zOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsr4+H3DeUCyoJF34vBk53Q356+W6+ODonKTnc+hZ7JkxynEZrguXe1Y2NoVg9mg9qGYCWOMO1uKbH@vger.kernel.org, AJvYcCXmNzAh8H+zwPIL94Zl0IndDMqJNvPA1/zlA7LOTo4dfQaoJRnuvdUZycZb3DSyvtKMIijmlKLIzmy9YE6A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7s3AkSiMf+Hm8WxlDXkWrkRPW27+PQGWXe9oO+fTVkKh8TNyA
	jo56/dhLrv6R6UNDZb8p8gmiuvJQ6l/yuYbAWFW9jEqM8tYjtRnf
X-Google-Smtp-Source: AGHT+IEcEqeRIULoqbB9V79aG/v2fsxloM/p8RLsB1XrG/4rD4IVC3xsTHDvM3Zh3WY/8ejIOOSrsA==
X-Received: by 2002:a17:903:2b04:b0:20c:79f1:fed9 with SMTP id d9443c01a7336-211d0d7e444mr87833935ad.25.1731757238639;
        Sat, 16 Nov 2024 03:40:38 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4040:6e99:f02a:954f:e157:760e:3d30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f346d7sm26078255ad.138.2024.11.16.03.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 03:40:38 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com,
	dan.j.williams@intel.com
Cc: dave.jiang@intel.com,
	ira.weiny@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	rafael@kernel.org,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com,
	vishal.l.verma@intel.com
Subject: [PATCH v5] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Date: Sat, 16 Nov 2024 17:10:27 +0530
Message-Id: <20241116114027.19303-1-surajsonawane0215@gmail.com>
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
V5: Re-Initialized `out_obj` to NULL. To prevent
potential uninitialized variable usage if condition is true.

 drivers/acpi/nfit/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef..573ed264c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	union acpi_object in_obj, in_buf, *out_obj;
+	union acpi_object in_obj, in_buf, *out_obj = NULL;
 	const struct nd_cmd_desc *desc = NULL;
 	struct device *dev = acpi_desc->dev;
 	struct nd_cmd_pkg *call_pkg = NULL;
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


