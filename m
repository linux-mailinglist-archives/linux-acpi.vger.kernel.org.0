Return-Path: <linux-acpi+bounces-9546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EAC9C6FCA
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 13:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AE8288A97
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 12:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B232038B3;
	Wed, 13 Nov 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfSpfs9X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FC203705;
	Wed, 13 Nov 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502332; cv=none; b=kyriVBbaboFIpoZ6eI+toPc0BU0OV758xlqlEh9K0ZUhCD3ZCHmOq/q9YdhpwfN5DDF91zJXBSw+v1VaS6pXkF0XsHih8fEfyv/oBnrIypuijb9v4j+wRO823u/8/wMCDocXqUHcdM3z/mZ4DIVuxTZplAJxcBiyvuGZIkVdH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502332; c=relaxed/simple;
	bh=IOO+gahwY6lUx7jzJRo2ttmcb/P3yYcCsKHSCzWDji8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KyAv09ZPe2/gv01yqUk4TjaF6I2LpPbQ0WEmym14b9ttLO4wnmfytwv0tPHukIHpzDjiB24y95SQpfScqMzjJQ14BwdHGTtjz7wjR5rTFFYoubj8z6xwVvHAJ4AS4R6X4NCia+Gcr8E3a0Z/QWNN73B4E+aUEauLnPhkvTrrXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfSpfs9X; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e9ecba5db0so1129764a91.2;
        Wed, 13 Nov 2024 04:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502330; x=1732107130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXfaqI+XhSuEYFsBiNURhzLUN5JAhtELIqV1xO9NeS4=;
        b=RfSpfs9XlxhZe9ysCTW+pepxo/ZoO2K92iORAeiCJGURVKtazothoLkme09q6Lq3Zs
         OwTNnsmjhD9qdQNn916Vt/3IBRBaukAinSq/ZqbhB+it8UKGCZW0JmSBO9c/QA1X4LPf
         B7h4jwBWkgqzOIZnn0+plmYqU9iPON/fmxUJRHLxtqStURG/9Plnc+PdXmqx12Eu5DN5
         ehA4vOPCL0dVs3Rw0+OrV1xYuwcBNL6OOHiXzfGjMzUOiEQcYvcLmusxFCL4YlIqGZlV
         zI1F0pv3eOqNqeRqZU8leJecBSNzmP8VLxh5yENiwfwUtCY60OR7LfJfkB2GvXS2m/QE
         fYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502330; x=1732107130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXfaqI+XhSuEYFsBiNURhzLUN5JAhtELIqV1xO9NeS4=;
        b=BNAKWyuwUwsTT50Ni0ffhQ1ZNeew50WqyCB9No6eSjrr7CE3ZtXhD2FSOJ3Ti7I8bK
         aRbWkLUQdBSw9lXNs41qEy+5sERRjryIBeM1WAxd+tLpW7HIrU5X+ISInZAr01yPo6nn
         MB86ld1EJpRswpHIHlDX6Ruvrb8iiz9UoQvmqrA7I2+86QieM9pvruiUNL8meGPufnIe
         LlwMDXLQeuwTrOvO9x2qzlqqwvpr0v3ZkeyMAW5v0ZqemC+SagM+SNNGpnboMqtebsGi
         JG9VW97LF+S4l42mSYV2LCz342ze/E/HcyLoZ0mPCuFRQIfF8L//bC+ro6zaRiv4OApW
         fUkg==
X-Forwarded-Encrypted: i=1; AJvYcCWVjqDdHeXSVfcVoFA3FVTGwzQQ1xjsHtolnfbbCxFx2jdCO964rAMMMR9n2grhHxPxyIaQ59SIMUt5gBC4@vger.kernel.org, AJvYcCXpca8CL5qBAV79VpuVASoZnsD1cXGA4iYIIFBUgpBFBPuVFuo0fd+U9tXtICJyHWDMEXpjCcXRh5In@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbG+VPipCl09QwhBVWP0sN1RJSqo5sxZD10vAPD+NCCEK5nHZ
	bSpvL1Cd0CeFx5TVwGVFCzKWbg3PU3qFqTQTu+u8Rrlr5/MDpzrU
X-Google-Smtp-Source: AGHT+IFezAIWYeQpIbbXmbe8WTIeLbdz1LgWEQWUIyHbss2jQ4NdhgbFSjIKCtuVZbAeXWoyERtmAQ==
X-Received: by 2002:a17:90b:380a:b0:2e2:bd34:f23b with SMTP id 98e67ed59e1d1-2e9b178fd9dmr25130667a91.32.1731502329524;
        Wed, 13 Nov 2024 04:52:09 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f1138dsm1354513a91.35.2024.11.13.04.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:52:09 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Subject: [PATCH v3] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Date: Wed, 13 Nov 2024 18:21:57 +0530
Message-Id: <20241113125157.14390-1-surajsonawane0215@gmail.com>
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
buf is not NULL and that buf_len is greater than sizeof(*call_pkg)
before casting buf to struct nd_cmd_pkg *. This ensures safe access
to the members of call_pkg, including the nd_reserved2 array.

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

 drivers/acpi/nfit/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef..eb5349606 100644
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
@@ -454,8 +454,14 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
-	if (cmd == ND_CMD_CALL)
-		call_pkg = buf;
+	if (cmd == ND_CMD_CALL) {
+		if (!buf || buf_len < sizeof(*call_pkg)) {
+			rc = -EINVAL;
+			goto out;
+		}
+		call_pkg = (struct nd_cmd_pkg *)buf;
+	}
+
 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
 	if (func < 0)
 		return func;
-- 
2.34.1


