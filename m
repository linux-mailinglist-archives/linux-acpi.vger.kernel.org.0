Return-Path: <linux-acpi+bounces-15104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B9B01E7C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020AE543E82
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FD2DE6E6;
	Fri, 11 Jul 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Mg20vGtU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CD2882AA
	for <linux-acpi@vger.kernel.org>; Fri, 11 Jul 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242422; cv=none; b=FjqYWa/IQJqPP8Da7TyTN+u/1clNkMO2c8qa0vleLt0j1Ol0sRr8ExNQWMU6Ki82eWikH8q/ta+0v9jszfekShDhyCg8ItiN3ZMn5QrZmGa0wWkB22hdBIuqxkAYT7rBLkgebdQCIgJRPXNrLEFCUZsNi3z8PdytcvZTk1yV4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242422; c=relaxed/simple;
	bh=WCYFclCcrsK42IAAK01Ss0/XRWTb3Qmt+dcYv5w0+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2dQ3o5wYMJkvi1VCMDDC8kzGFY5+nvCIYxr+Bz2bZ/OZlKs8n6ntMYKhjcvIxHdl0S582QfqJeJEhk5ZFkPEowVkUxa8JRJRfn0dQK0BIiD8Mp8jcdLDfibd09FX1ZGiwVbEH7waMMFNJ8/IJz39kLfFkGiY/LdhoQyrcZjugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Mg20vGtU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-236192f8770so15088865ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 11 Jul 2025 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752242420; x=1752847220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmPdsQbDpIgCjumkrL5H7FFgimsuzlN0TDDo32sfzWk=;
        b=Mg20vGtUIngSiGJQQT4DVPHeIwevo1295TTx6h0NSwT1LPQ2MzqQdeGkwwCvO7OTR2
         bu19LtuCRue1RRFh10vOaezVsGiTbxLxUD0WtvQO4BYxoRR31o0UaNO1Tm5L1TIcDHHT
         5hd3/g12VcFs/pJWBSBZaMeMXDo9kA230NIovboKrIOkLER86Yz6BUB9RjBTTxsHEakM
         nD4dNzPwirkfUlN70PotyeAkNPuWu78oyNHiWZwrzXbD05JgVmct/OEclA2nyxNBU9Fx
         MrHjGfhXyalnASfKmgeGuxUc5gvaY0avrcWkbXzFn3XzD+29iw97n1q16c75PpvCFUjT
         itLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242420; x=1752847220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmPdsQbDpIgCjumkrL5H7FFgimsuzlN0TDDo32sfzWk=;
        b=nE5+9wiR2AedHwhKJE0MLFTHYmHtU2Q3H0NoM0ZAea+/W96DyWWY+CWqyHHqYxnDtO
         QPJUQM5Z/JyGJBFZe3Kk+z51/3Tk9V4OX/2vH1P7hJ+NGjjem2DnrWBJWO1Hq+b5O/wM
         dzuv78MamfZ0z2QOaAYA/Au58Pk9MPgQoNEjAb7x3/jXCltKqDK6ybivhZUKCDGBBNOP
         Cy8+/pc9B8mCE7DRGZJsV0AduetY/gXe42oCgID+SElzux1OhqCbx+QMyFW+KzU3rPie
         8jsRF+pd7dCsBEgzEiu9u5NTX/A4utX0qPmQ2qwHKdc+q0z/M6o0r6uZ2DlC3iqdiD8c
         qTIw==
X-Gm-Message-State: AOJu0Yx5nu09MmDHLyReAgCvHWZ14BEqn0kIh6XhvaRx1G/qdGCzhSf4
	sN+4m3tZe1RoYD7XriRkCjO72ncjHrPXr5X99U4QZt9mWip2sBAHTZsHKCa3SuNatLlBvZmjTbB
	BTWim
X-Gm-Gg: ASbGncvWcC/qPeKlWVwgaqQNOk0tO6VDYpdm+SCmzj9mGQRhwa2SIXOcQk43ABLss5Z
	dTxLlikYWGKK6gg3GR82VfwsX5omwCmi6s6Z0oBIFpYerP9MIrK4GnKVu31tndnQrORimUO/0gw
	gExO8Lxj/LRfZoMue1q+v0Ibe2wpTTYr5w+4nx2v60ZMIOAnGt1qUHrc2afsFalKTvq0G6VpqUX
	4eJHICnyjX9cptCxYxUtk3D5uiYccDJaurjW9kjywIIFmwt6ZgJmwmtIUvtQf0YTsyNn8lqEuXF
	ym3nWza58bzICwki3nOaQCMymW5oFSyImRFJD3ndbInqeDYdNljM9gA3yPe2zWgcU2X80ZKZ5mE
	TgQdN3At/895G26lJQ5BAEs1Wi5DmIefu
X-Google-Smtp-Source: AGHT+IFJ0rcsB4i4vXXPgW5KkKIV4zeIjjpkek1NMqdQXCIN7LpmxVPatDuK+xoO9TrfDZV5gowLpw==
X-Received: by 2002:a17:903:f8b:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-23dede67c19mr48246905ad.25.1752242419961;
        Fri, 11 Jul 2025 07:00:19 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae9dfsm48405845ad.73.2025.07.11.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:00:19 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] ACPI: RISC-V: Remove unnecessary CPPC debug message
Date: Fri, 11 Jul 2025 19:30:13 +0530
Message-ID: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The presence or absence of the CPPC SBI extension is currently logged
on every boot. This message is not particularly useful and can clutter
the boot log. Remove this debug message to reduce noise during boot.

This change has no functional impact.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/cppc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 4cdff387deff..440cf9fb91aa 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -37,10 +37,8 @@ static int __init sbi_cppc_init(void)
 {
 	if (sbi_spec_version >= sbi_mk_version(2, 0) &&
 	    sbi_probe_extension(SBI_EXT_CPPC) > 0) {
-		pr_info("SBI CPPC extension detected\n");
 		cppc_ext_present = true;
 	} else {
-		pr_info("SBI CPPC extension NOT detected!!\n");
 		cppc_ext_present = false;
 	}
 
-- 
2.43.0


