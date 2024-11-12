Return-Path: <linux-acpi+bounces-9499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F29C4E18
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 06:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F5B1F239E7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5D205E31;
	Tue, 12 Nov 2024 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la/JXcHf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78A1B86E4;
	Tue, 12 Nov 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388848; cv=none; b=qr00q4jdJEvSaIwvW9ouCrhFrkWxRoaYnAYFD4FxRxvhDSe8zHuY9QGYeZQm8LC85fTsJO32irZufSwihhTzstPoRdLefSt6H3rrem65NdOTFD9c9rTPL6NwdX9ahnFEbLFtBGv7+7NeOcAlrfrqfPh1Si+pfJ/LxDLVSTy1db4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388848; c=relaxed/simple;
	bh=xYGzH9hAlrxBlbHGfPc0XgIXYM4XAfbRpAuBzkRUnz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P73RQnMjneWN+HZVJ5q+sPNkkn2fd/z82ysT3s4GhcUTKHy0CnJ+hTm7++86B8M6Z152G9lwLo6tQvJSr70TUelgJyvCUNqO9TQlew/sJyvA/rul/vNg4qJlAq5ZiAIhV6VQz4tI8x/OFtN8XJmWXwCesnNg6e6C++ikTCgqBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la/JXcHf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-210e5369b7dso53552095ad.3;
        Mon, 11 Nov 2024 21:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731388846; x=1731993646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nraq509unMAALzeVagoiRPKJbfQ4zWQzvCgRLQ6O0iE=;
        b=la/JXcHfSU6exQdaRAGdp++fG8U/GiPbm6tI3WjOzCQCyeXVqxFwTNLopGky7jMamc
         0VULtJIs3vQ1VXneeyrhx5TyMHeAGGtHnjZeRG8SKDQBCFLQZ32ci1KZ0WyHkOKUy5T0
         ozcfDZJlUTteLpNNU5QRA6fiCLfkQe7Fux/ZsT0BNvwvdMJVgRS28i3jsQu5mF21yGk9
         WFelAzuhg05WQUlPKbhTPzJpykanfbPXFdXXal+tjEKretI6HRzph97+8EIUkoscduBv
         1TuMy1KP7gLPotwqA3Qlpr04+Kdwru/GTGI4YAaW+usXnBYtw80cncQtflYPcyFDtMe7
         1Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731388846; x=1731993646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nraq509unMAALzeVagoiRPKJbfQ4zWQzvCgRLQ6O0iE=;
        b=DbBy61jq/LLhCP8uIhObfqTnrWPXwyvbxUcyG/5teenvGY0xxyTv0BkLYHJ8HyOmnp
         qeJn0o23GoEPCDs8208MiLRcGh5rMbAgWFSoBw3AgoFMOsDusr3IfobEQ0xOVC9MLDOi
         ZsKTNif65FwbHFjMtzmfqZFusFtWo532ny0FvSdSpdAgrcWybvioPl/OiR72rqvkKRPv
         Z/adNXXVpKEqZbuaa6TYpzjxwm2tHVENE7foLmDM3TCXnWY84ZIsxUOUSVdLM2DgzSzo
         9P2r+d1KWSx19rxLYPAbYgWIgjreQhNxUa4jbq5nGlRoecE1GXb96ZQjF10B+Nyh532O
         KkTA==
X-Forwarded-Encrypted: i=1; AJvYcCV8D6xKUiQWPWVLh/FA2uzpLk4+VLsuzrkV+3OnsXEd7IRKH/pkYPMPrQLoPpOY6GGMoCX5u43G1aTQ6IUU@vger.kernel.org, AJvYcCXOnw/aNj+QtkS0ybAN78mJ1D37EvNLqsAco4D+r3Hk/R/lZqftzLc//bHQq92VKBTcH/NY8XOBkAa3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15wDRHUOF3QppzQO+yAB+VgHAxmJxS7BBrZeJP9k9uzHftb+f
	UWD2c3KSbeqm2yPvJ6214brardyLl/RGglenSqi5xa9eWajz1RtR
X-Google-Smtp-Source: AGHT+IEqt1K+FlBqj/5RBYdoY6r0noCkeefboU76QtLTtaAGk+R/+2di6v4C395v6POpzeSOxjuQAQ==
X-Received: by 2002:a17:902:d4cc:b0:211:898:7cde with SMTP id d9443c01a7336-21183d23fe0mr185099865ad.31.1731388845729;
        Mon, 11 Nov 2024 21:20:45 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2405:204:20ac:21b:f63:7054:e444:2bb5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211af0d6f9csm1173445ad.58.2024.11.11.21.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 21:20:45 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Subject: [PATCH v2] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Date: Tue, 12 Nov 2024 10:50:35 +0530
Message-Id: <20241112052035.14122-1-surajsonawane0215@gmail.com>
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

The issue occurs in `cmd_to_func` when the `call_pkg->nd_reserved2`
array is accessed without verifying that `call_pkg` points to a
buffer that is sized appropriately as a `struct nd_cmd_pkg`. This
could lead to out-of-bounds access and undefined behavior if the
buffer does not have sufficient space.

To address this issue, a check was added in `acpi_nfit_ctl()` to
ensure that `buf` is not `NULL` and `buf_len` is greater than or
equal to `sizeof(struct nd_cmd_pkg)` before casting `buf` to
`struct nd_cmd_pkg *`. This ensures safe access to the members of
`call_pkg`, including the `nd_reserved2` array.

This change preventing out-of-bounds reads.

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Fixes: 2d5404caa8c7 ("Linux 6.12-rc7")
Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/ 
V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
potential uninitialized variable usage if condition is true.

 drivers/acpi/nfit/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef..d0e655a9c 100644
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
+		if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {
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


