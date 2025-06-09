Return-Path: <linux-acpi+bounces-14232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF8AD18AC
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 08:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D55188AB71
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 06:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47DE27FD41;
	Mon,  9 Jun 2025 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6zdAB+j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D525487D;
	Mon,  9 Jun 2025 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749451362; cv=none; b=QmY0H+DTptfPvvMD4IVrw7UQmswTqhHIl4ikXHrR2NEjF9b4F6vl6pRvfj7hwU82OPBBBY6eJSCKRGQdh592yUARaOcsyu2jZI5Y6E1CdpJIX+jS0ecI9XFXMvq6fG3Dk9o1yle8abnzX2EkRoliUtBgajvmM8oeasju6k37Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749451362; c=relaxed/simple;
	bh=2XdTmYQJi0Dve/gohPb33702aqfKwBa5HtvprFQQu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxxfO8nNA7izsiZuIn3Bi4H1sT0kdRdkj6SPLVoAoCkz+6yyzA1btLXXBzcPEMBHmZoEtf2W0RgnMewaJc7q3tptm70+GXEp8j802x2HONBPqn0ZCwjE4CqU2w4OHQsksG7fM6wvJZ4JQPdOfHIrSjJCQEiH1MddSX5ALELrA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6zdAB+j; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad51ba0af48so946977966b.0;
        Sun, 08 Jun 2025 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749451359; x=1750056159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeBBqy6v2UZFNklROzVxIjgbTRxIdySSihaP3aLIF5A=;
        b=i6zdAB+jx7FD+QfjT2TkRlg6uKhzyk4ZQJlk7nQwv7nSy7NaOF332zVbdCB8YP1qxz
         k8MKEX0Eg/qOwXSZGwoSSXk7jg2JHhmGiHgGMoxc8kLDXdC1rsgzX1qafnkFqQj/VY3e
         lWPW51N4MsR47MnJ/9Cl2rm5iKxhRa+qx1mw9l7dJJou3igLW87EOgEXLZf+55ke4bc5
         2Wv6Nrb1lORz2yXc1rcdfctXw9s8WXvcqHlOzu2gH4avcBZlkC83gxiymd4hMo1LsGHr
         xyQPxXn3c877nBH1WQEMJL9CR6OYGSpLmuDAHpewm8anOuY6wt5lj14XtfxqqwS15F/f
         PgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749451359; x=1750056159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeBBqy6v2UZFNklROzVxIjgbTRxIdySSihaP3aLIF5A=;
        b=aJSwk87C23DPKXp3Ksj84P0to8B+5o+IuILHK/6UAOMGUn7yl+XJCb/4auIL1qqTTx
         4pXZo0n/usPZjGjUfbPq+BEjJxSi7dmL7YmCYUQnM7ulmSlPm+RK956f4nvpw4CNmPIb
         /E0MM8e0q1OnAoQtFOzbzjaw/jPPGxfAs9IYkcJaTudKe7TEVkGE30KY7+RpJrfc0QCw
         2PoEgtAKPHRKPwhVQfoNjbjMwEsBgOrChSIwd4mvwcp79rau7tTxfV62Knm5WnPCoJty
         02T559mH+XMStemryCoZjdpo4GfYL940nfuBLscbJ6wCtS47sEq1tPhBLpo5LmhKAXSe
         0eHA==
X-Forwarded-Encrypted: i=1; AJvYcCU97IgrAaB214Ox16sj4mNnf6qPkUyOU+qcVC5OU5MWeGqGrCERFf+s7SWqHTL7aXuWUSUtyEd+A6aPswY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5ztLmiiDb832iqgNcD4tYcgUyXhk/7Hc9m/drpJrWWsuZJIT
	mQ9tt6eWSfhU3eixnIp6ZfpMB4QkGmizywhyT3d5vvjxhxNTwtMRXP4ol4WQwg==
X-Gm-Gg: ASbGncsADCgJQMv0M6W3UfW5TrcGZp7IzKdMB1aa2eIXCVHMfMGg6nQn3uEMFwN/nrj
	+dHrNyXs2wbt2SwR5UKnSByXQMJogxoyVwYLC01IoM/kiO3tzLfZpgbooGgKhmINXvwLHW0ibDU
	Ph86CKJD+WMANZMhCL2MVs6g6Fv6GU4prRmtAZM3ZtqKliOGHjWYtbGzKNhUGal7XrSS1319+dC
	3/AA9KS+Na3fzpwdSRwAEz9KPtr0oAD+LbAPl4VugYOG2DorZSfD87jcu1U6gmJwNTL79xwj3/Z
	/V/FtsbcZUMTiQe0ufG4B4C+ASX9hQLnyNIhK7NVuKSnPr3Vcswy+yQLEg23YF4S
X-Google-Smtp-Source: AGHT+IFmOMa/7gbKwA455ikZjHXKCcGC8wUocGzkIVxvO6+ix8dguCuIMmEGRWk+GFKZEBELG6zNXg==
X-Received: by 2002:a17:906:ef0a:b0:add:fb1c:a9c3 with SMTP id a640c23a62f3a-ade1aaad9cbmr1108343666b.28.1749451358859;
        Sun, 08 Jun 2025 23:42:38 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d754896sm502881266b.36.2025.06.08.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 23:42:38 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: acpi_pad: Update arguments of mwait_idle_with_hints()
Date: Mon,  9 Jun 2025 08:42:06 +0200
Message-ID: <20250609064235.49146-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a17b37a3f416 ("x86/idle: Change arguments of mwait_idle_with_hints() to u32")
changed the type of arguments of mwait_idle_with_hints() from unsigned
long to u32. Change the type of variables in the call to
mwait_idle_with_hints() to unsigned int to follow the change.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/acpi_pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 6f8bbe1247a5..c9a0bcaba2e4 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -33,7 +33,7 @@
 static DEFINE_MUTEX(isolated_cpus_lock);
 static DEFINE_MUTEX(round_robin_lock);
 
-static unsigned long power_saving_mwait_eax;
+static unsigned int power_saving_mwait_eax;
 
 static unsigned char tsc_detected_unstable;
 static unsigned char tsc_marked_unstable;
-- 
2.49.0


