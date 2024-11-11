Return-Path: <linux-acpi+bounces-9487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E289C3960
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2024 09:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A59E1F21F8A
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2024 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1510158536;
	Mon, 11 Nov 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="greRZW5L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B51514EE;
	Mon, 11 Nov 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312288; cv=none; b=iNDVixqy59WAgCcv8IggFznuvTDUXa6uzK26lqgZ+W6z+fKEfsNP5AVfwyVCN2h5lU4FXi82Ycr/MkQSQyCnBnXn24UlZIbkqdO2/BWhPCWPxxpYXXBSXYogPszIzr8p9laseWPiAUVOeAPgQ2fbTnRwSQZVda0dr3x0eWoFo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312288; c=relaxed/simple;
	bh=FWuw35zTuOKihJHzlCpRNKQMqJVYA/pDbaVVTKXkXnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NuSAPb3cQfpDvVPq7LrkS6xtu+/RhmTNhAQ5cFKJuq/tZ+aUV+AbItXbOYgQzXKp5n/EvS8GpK4imshl7Xl2FIicYY1PU2FmR9QqtZ3KQQ9eV3ka7pI1a+Hz0iX75fgE9yY11LjA4mKJyIZQJy7Jqp/Bat/TChFeln+jjJS5+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=greRZW5L; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20e6981ca77so48276795ad.2;
        Mon, 11 Nov 2024 00:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731312286; x=1731917086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UT6ZfI59cRDazAWHMhRwJefY/Lo29/Jrx3Vk/czny0=;
        b=greRZW5Ln2/LY5HLTEzdRJB5YdyJPnUtf0aaoHWcWkwTunsQtMroFiThp96ao3govL
         UKwgohCrPoYwK+rAEzuItNZVhmWqVO2QsvIskA9DBz/ds44I0yiTEeH70DmVeQqwdkkB
         9BAdg7qwL5hXDtcOiSq7TVZKVq3h05QFsSUaI1x6C0N2B3XkW404VE136wKxJCH+tJOl
         uMAnrXM3ZWFN3dniFnQtkuTPDAhF+wOXdO3O1DymGQK4cBlKBEi0CxClqZMokp3nIyUA
         +s6k2eNRu/QEfQn2EDv92o93VuQVnkyRzHpLBoR6JbMDyUWqelpH9OCQIk9fqmeV76lp
         BR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731312286; x=1731917086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UT6ZfI59cRDazAWHMhRwJefY/Lo29/Jrx3Vk/czny0=;
        b=hPw7wdx7QLecX7lF24ac+b73XEyDouMMZgv+4brgILrQfai4/78QHNy3RbVA/wFitC
         m0KLSHK2oJGOnC2ZgZ4QUjSqa+ygVQSnnVW2nJ/2RTWXLfjq9gzCe9zaCJ7CJJR5Ap8A
         p21heO6gGOp7oKnoXFNgxnxliD1W/pUkJ30Ia53nvK3lKOaoFISqXzDTgUfMlydXSu+Y
         bvuGr0ZKEyCWI4iEBEZoZ4GQlY4x3jozGsvhvddAwQyUyc5DplSeX53tHB2ERDLKY3V0
         q0qw9vgffPO7DrBD3o6U0xYAQcrxkr/utf/PxxM37rtksSqT9rVeZxtqXNo1Hz3y+rA9
         Mjwg==
X-Forwarded-Encrypted: i=1; AJvYcCUkmPsalKe52++JHbGOS6eA3OjUf9YfM495pCTLNP+nYiyuEfnlEguw0fYr9JKfZU7vfpPhvQEyQ/Uz@vger.kernel.org, AJvYcCXssqpsS1p+A/Fr6/VVoecS7IuvXNqVWUAXTQksy0aIn7HwRsOkxZwyqdu8kent/gnJZJgppR/U2IXqZojc@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcp5P1s9h793rjWqtg769eqsfC4qcC7In/Q85JkUc305s73iP
	1I0JL/S37mnokqf5N3I1qbQzovcc5yZIMdl4iKSk59SipYMkbKcP
X-Google-Smtp-Source: AGHT+IF9aCi7YVWolUezV0kEH14eAYavYX0IFCbOuS9oCD/EYTdHBk6SwYCMWY+FmzpFdW+e2+YBHA==
X-Received: by 2002:a17:902:c942:b0:211:a6d:85dd with SMTP id d9443c01a7336-211835d9930mr158383425ad.47.1731312286442;
        Mon, 11 Nov 2024 00:04:46 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm71061485ad.255.2024.11.11.00.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 00:04:46 -0800 (PST)
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
Subject: [PATCH] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Date: Mon, 11 Nov 2024 13:34:29 +0530
Message-Id: <20241111080429.9861-1-surajsonawane0215@gmail.com>
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
Fixes: 906bd684e4b1 ("Merge tag 'spi-fix-v6.12-rc6'")
Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 drivers/acpi/nfit/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef..4a2997b60 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -454,8 +454,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
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
 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
 	if (func < 0)
 		return func;
-- 
2.34.1


