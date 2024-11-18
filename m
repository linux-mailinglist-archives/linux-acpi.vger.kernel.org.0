Return-Path: <linux-acpi+bounces-9639-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F619D1560
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3885B29339
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97381BD007;
	Mon, 18 Nov 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbSD7YP3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A821BBBC4;
	Mon, 18 Nov 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947205; cv=none; b=qCzQvdOKvoNcdP4RghRYW/nWT78SOwT97Rc7tVzuEmAcjgywFEBRNDOdxj1qbrOGHvPp3mgcKOeGNJDhY5Inr74e9vTNSlB5LB9HHSZ4W7Bx2VeEDpxxys4aCojwjKXvwbX/58uNHU1EV2EedfwAyKagCxr+4Drik/CZofZCt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947205; c=relaxed/simple;
	bh=QHMLVwqjyzpJ2KbNsx+ktbIbtg5K37IdbLaSNC1Nl6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGj4Ei0biMGYhdoIL9jKydx9h2LKHYbsM9LkjT+aZzmLRsi4xkqbZ003bSWFSkVLb3dizF6ASo6LNjUuk9abHZ4bsTl76EW3CbjThc93scwkOSLBHEUfooJJeXGDYNdAgr7fikR+ZQ0dUIsp64npPR8GLl//zXZDqK/6WksawZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbSD7YP3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7240fa50694so2711470b3a.1;
        Mon, 18 Nov 2024 08:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947204; x=1732552004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=By9ts3alHiV5Lex/gW6NiR6HKoO44qWXwHBKt11BkXE=;
        b=IbSD7YP3C5vjfEQ8x6lLGJpzK3Hx5xsmMNl8KY6vbb1QnBw8b+B+zYLASDnpQRABEx
         oWZLuMQIDIa81m1g0LKjkxr8v8QkPwEePdnS7W4MR49Sw4hT9g4NrplvItX3R2CeUMlE
         gTcGSC7/DM0ridFu5XxMKIVI2eqvr1YoM+8ZBUk9q+Pn8K0/IlHxXovrbYoaioN2jKyD
         cLDVpfAQPAvvZ731/xcyZi4xV5AT6zC29JdzSq3WMZYyhV7AMd2p4oGOwoij5BmtpchJ
         2AJ19puQkqMhGmyEky5kbyR1c5R1CAviNJe72D3kmhYDC7hA/mYw86MrVTV+ApO0w8Xx
         QbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947204; x=1732552004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By9ts3alHiV5Lex/gW6NiR6HKoO44qWXwHBKt11BkXE=;
        b=G7q8rT180zf0r1oQhGRSopjOt8rRsOVlAxmulv/QQMOTh49SbkKoO3WTn6plbtH2Kb
         UXPhsKSKnAiA/n0B62PCBs6kLmh7pNpRJLe/x2Lv20Ck1PxQK8Pk0DmGog/PHURtqwWg
         raztWcAG395RE3HLcKzjP98jxRMqB3h/ZbsfhuRnh3///gKu7uIrHFbqH2A/6O78gs4k
         Wf9GmE0ZgpwIk3pg2lpqWPwbBFIM2NtAvEX3hBcLmWoDv3cT3H0O5ScMXLz5pDyIRcOP
         8Dcr3Zd3OmsYden5+4V25F5In6SgIivBOZF1FTSxNDODRh1f0GJw7s85j0MWVuPhEfNG
         ifiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4yC7vFu5J/eNZyWe/aP9pIMaxe4nxK2561Uz2kvwkpFUzXP68YwB3jMIg8EZ9MVLqo/KoSvkrAj+e@vger.kernel.org, AJvYcCVLX8lFc0Df9YOqlIw3PGS4dXJgnpjNJFCweCxERZEQxtvQAfM0Rhyx8mFz5umzNc9nsrOJhtZnbAdHo/Vf@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSBWEZrJaFblJZsG0YXKAIAOfq/KAgoLu5Efmy+hn5IPugxqA
	dtw0XdSL5S5WrGUBcN8xP728UwvMenAD2rRgwmwmGTVPyGMdxtzR8QHB4MW7D58=
X-Google-Smtp-Source: AGHT+IFiKgz7pu3gD4X7bzU0TJnmSTpiC+2A4HM/HOlp+lRQXsQHOsdhu2AnZV19kQuNxudWLUjyDQ==
X-Received: by 2002:a05:6a00:84f:b0:71e:75c0:2552 with SMTP id d2e1a72fcca58-724769ed786mr17680701b3a.0.1731947203548;
        Mon, 18 Nov 2024 08:26:43 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0dfcsm6589764b3a.106.2024.11.18.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:26:43 -0800 (PST)
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
Subject: [PATCH v6] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Date: Mon, 18 Nov 2024 21:56:09 +0530
Message-Id: <20241118162609.29063-1-surajsonawane0215@gmail.com>
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
V6: Remove the goto out condition from the error handling and directly
returned -EINVAL in the check for buf and buf_len

 drivers/acpi/nfit/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef..a5d47819b 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -454,8 +454,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
-	if (cmd == ND_CMD_CALL)
+	if (cmd == ND_CMD_CALL) {
+		if (!buf || buf_len < sizeof(*call_pkg))
+			return -EINVAL;
+
 		call_pkg = buf;
+	}
+
 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
 	if (func < 0)
 		return func;
-- 
2.34.1


