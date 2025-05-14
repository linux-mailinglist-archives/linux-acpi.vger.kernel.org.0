Return-Path: <linux-acpi+bounces-13713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C2AB62A0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 07:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A04189E7A3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547E51FC104;
	Wed, 14 May 2025 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="acS4zCvn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277D1FAC4D
	for <linux-acpi@vger.kernel.org>; Wed, 14 May 2025 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202272; cv=none; b=esooPdEbxf4hC5Q1Y0Wbmj0H8Po5lL5sougG/S8fq+HhkN3rMF5jEfR4QN5eCylkUXJGlcWQsdfaqhc6BBfZYJeU1qdwxKsAf67KW4M+oL3GzdMNZcujf/Cy5B/4LVmGTvBAXUHx39z7D1K5TwQyXAXYaZR43pKotqrYE+Fs3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202272; c=relaxed/simple;
	bh=j10W9ERtTCLuRtXkzV2FgTmpZyoQoyxJASYgwPYwbms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3ZOtZ9dDAtRKzWiJ9k7J8JwSJb1On4/jpSKFKTwrPtif4tc4ZfwU47WIEO89LKUgalzVRu0u/M3skH0FGJVZJ1FHSpY4+Bxsu7GreD8QeYVNGRLK3KQSiB7EZawjy96DsUEJ1bv7brT+C4a9voBnExVRw7pjesunHjgzaHlKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=acS4zCvn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b170c99aa49so4338257a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 May 2025 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202270; x=1747807070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnkjvbjcuENvVJ26saTSRizx+WjEaICu8Lhi+aJlcF8=;
        b=acS4zCvnlH0ZhS+mvxsQX3lGvU0SupI9o/3bFSXPS7s2zfMB+TKAsfsgHcaQCgersX
         iWsZMTNiGQtAVPbdoeC77/jKOB5puwghTYa9VRfTdl0WPahbA/ahAW3nfpWwUsHJH5xM
         9hF0sCXL9oK2ObwGsCgDtTw7Hv4d0QYhTJLb9Ym5z8CtCC+aWhFUppGkzjkkIKC4gAcH
         sPRIH1cJf/+FeCDay+dSWrZTiNd1mjdENp6+JA3NXvk7ZQMN0K/BlFR9RFB+3Xq+Hoyo
         8mt/a9PTHkYvV0nTU6cRPUvQ1BNA0AD/L3+SjqADEZlNwTqwMJX0gs67dZ0g2MiMzc30
         FEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202270; x=1747807070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnkjvbjcuENvVJ26saTSRizx+WjEaICu8Lhi+aJlcF8=;
        b=Pm0JMQTDIBwaPFewtOgvAz4ftg9+fpH0atzxI3MxNyeEvJ4wuA6TEJAJqagn0twVQi
         wAQ7uGuPCn90D3IaCd/i7PEvkfpAtryx14uD6Zc3uaBSddXbtn0xWq832Zk7cFVbmPBe
         rC+JBvrYyO8j+0gtirCvgOO0UHJJRr35z0T+xSmpsn7rm2/ND7lUXtPgM5aa1Er0uSeH
         pT4imRY6FEUu2mquEHkdP7aR3+HxXUtNmaKD0GvtkOLwGijZJJISimE9L8vhci7pcL5I
         spXGTLo3fN5y1Ugrg4myI4YnEqEXDmgktFoqjGw4pu+BTeXFdCIMTqXwEodpusF21w27
         YnUg==
X-Forwarded-Encrypted: i=1; AJvYcCVEQXOKoosh26WPwumvhkceuZzXSDWA+JTKVxyRBYxT85fz9HsaqSmBaNofs4wjr8IkbeE+1Q/CO/Ti@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaw68KnMnA95ATPX5PFlpiW4FsuSzgz5Kmb7zqViPPaXtqyEt
	gfL9s4Dle/72mJrrhIFaqj8gusT+RNe6beP8mB2J4VFd57+cC2xbbgSax+N3+ys=
X-Gm-Gg: ASbGncuRaawN4McAuqfpgAxFpjx2Q5wNhkuKsCxeHk5HlBkpw6dXSF597S2ADJLdYyU
	ZCkJbiwL/7V/vzGW7HpR09AAXf7GlcVwFzUkxTKLIrd1EVDM/jVDrY7/1e2VgWyOvUmqosXDWO2
	qzkueS65U/XO6DkH8m/ICPKmcP/tR4ePXKYr6Brz45jHS5rVmvgVVoyExSRcbb/PX4qyFLK27Gr
	x7dZgHGeFPfKMZIHaLuqqLTrWJnO+DeszWUr98CuXjK8cNNFcKd6LToy8CIlnR75SFLWSuagwPU
	vPoL+qjpJ0enZ84lxztvXemsASG85QZFuUhvH12ouSJWPtVys3HXHcj1svhhaQ==
X-Google-Smtp-Source: AGHT+IGOnxIH4YjGEW5GtZaYNs+W/C6hB2R8AaG0BsyNWrPx0B0lajN6mf6PqMko8vPxUuZYiIe5uA==
X-Received: by 2002:a17:903:3ba3:b0:223:3396:15e8 with SMTP id d9443c01a7336-2319810114emr33089565ad.22.1747202270073;
        Tue, 13 May 2025 22:57:50 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:49 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	acpica-devel@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 3/4] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Wed, 14 May 2025 11:27:22 +0530
Message-ID: <20250514055723.1328557-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
References: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for RISC-V as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..70f57d58fd61 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
@@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
-	if (err && err != -EPROBE_DEFER)
-		err = viot_iommu_configure(dev);
+	if (err && err != -EPROBE_DEFER) {
+		err = rimt_iommu_configure_id(dev, id_in);
+		if (err && err != -EPROBE_DEFER)
+			err = viot_iommu_configure(dev);
+	}
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0


