Return-Path: <linux-acpi+bounces-14843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5688AED30F
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 05:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FB417195B
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 03:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDD1C861E;
	Mon, 30 Jun 2025 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nGQu5xHB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19319924D
	for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255304; cv=none; b=Pz20gG0tfwljYzH9SS5dquYZIBWQbS02b6ChN2DXUWbDUzeSa1BWI00y1JWtrxYT476OBxIuPdkkWNVaoor7UNAnOQWseuKM6kaFcgLZ98A+hOA1WIjeBQbqV6SxNXjK5FfzcrcQLxT1+WABaUZXzn9AwjQ7fI0Fn6MHROdR0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255304; c=relaxed/simple;
	bh=rcXB8sUVYbgV/LLd1eTDWsHjfWUpMTfAU5sX2LEsSqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0Ouz260msHlAZPpN3hlEsUgENbqf5HlfKAY9LdEYoeCDqc6mY8b8sPQE3+0Rf/VAdN40gBUxmWI9i6KjLb0KZo3A0+wPDTNXsp8uPQIlGYIryA7MpeCV6/tvtzB17I42Ps1gPu0VupwYpFq1b5A1hn5Fv6N+G/uiNHuyY46nic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nGQu5xHB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490cb9a892so2864925b3a.0
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jun 2025 20:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255302; x=1751860102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri1e7xvqfD1xJqzMHYa8cxstKVT8liDfwJUs4Nyy/QU=;
        b=nGQu5xHBdZu4RrFpUhYeQ/5dMhpGrfKrQP2iW+7NPkBOchXxwuZD5CPD2c9zPVDozB
         wosV4xwdpBqfw3Z3eoPEffFj1H0OdoFKSKTotfdKi5rqIZLaJPMwOadlseplTD8D2Fti
         5H1ND4pVynUNR0RGuQv6KKWtH1Q/4IoMjBgdhb13pNNEznd/FDCsHUrHMU5zzkeRbI0O
         0oJaWz8f0iS77bnyUeJDnoxFJuPdsoo4K9zixFatCgt8VjRNnbSKseQE3VHBI4k83zDO
         BdT9Sy1VotZWjOItxHlNPAmJgxkrU2I9fgqiWlyjCMmLkDWPTtiAGK3Eb0DVWw496NHo
         FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255302; x=1751860102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri1e7xvqfD1xJqzMHYa8cxstKVT8liDfwJUs4Nyy/QU=;
        b=G3ekkljVxfDQpz7dbPZSA0GkdKvhzG+WxlpqN3i71rwXUsLQ4COO8jMQbRgWXxHWEJ
         qgnGDRjEMACqzCuDb/MxBli4E2MwiT0ibiliQLFKb50xFO+rsKPXJqqCACjlIZn9iX5O
         PaIyujwtkuatYN7QKzPVvp+1XDBOw0ta+5N3UIvfaEKAmS0yB1iitct8Es1Jtv64loHs
         /H3uHe/VSd/OOOtZfGOPLirgIjcEW/kLJh/nADPPvyRrqUfLInasmebux+dDzhtK2ehZ
         bUT/JVDElIY8klBmnjUfSPJ6Sl2izjOE0vT4e7UzdD9ZoiD7NikwQHUS0OL5MBxsABfl
         Htsw==
X-Forwarded-Encrypted: i=1; AJvYcCVjWGLKQagwfDcJPpCC77HsGXuDdF8a+Jg+VbQdqsFAaDIBzDPsjJnsQgFP8xI2srYxw82rQKe9LUFB@vger.kernel.org
X-Gm-Message-State: AOJu0YxuccoaLuIlOLiRJ3A3CzmV4aHyUgHAtAe4qiZ7wRst9EzJdkrs
	0sMap3Cu0iDKX032uF1VVFjfqePeEx9JkKzMZvb954R166Vk2nWm6/VI9L058apcAzk=
X-Gm-Gg: ASbGnctjsEMWG71fsYIJ0Di8yY3l/Y1NylzlXPa/KGUE8ByE+7QZAt3GkC1QZzxJ0cb
	Euab4wX/BCkH1XNKxQKkS2czH0AXO4+fzl9z3a67lipkL0E91TWEHBOSZR96efjrvr7jSprYunh
	lvk4gKHiHEJ8fgsjbIfkgvrlTd5Q5vQJF9oVeN5mfQyN/5/OjtK//wlBUi7Y5H6NcklgTgRfNYr
	ASR+IVlEi89UvTUaod4fk7YQZqY94K5dZVmerpwXvDWvsNcn6ovSnVGIzk1PBoLhDA0GMmevGl0
	4TW946jRMBc4L1wip5VOye4pG4OrRLGeFkKqQnQkpq6rTPSdVKarjVVmwhdORVjMLQN2Y1Iv
X-Google-Smtp-Source: AGHT+IG71WwVUzest/mJtvn+9x2w5xMiAsY0zQAJe8GnER+ZaxhJXmmKNzdMlkrBD48ocwYkdyfatg==
X-Received: by 2002:a05:6a00:1813:b0:746:2591:e531 with SMTP id d2e1a72fcca58-74af6f081c9mr17099430b3a.12.1751255302416;
        Sun, 29 Jun 2025 20:48:22 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efaecsm7837862b3a.161.2025.06.29.20.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:48:21 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
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
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Mon, 30 Jun 2025 09:18:02 +0530
Message-ID: <20250630034803.1611262-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


