Return-Path: <linux-acpi+bounces-15787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18156B298B8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 07:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6927A916B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603A26FDBB;
	Mon, 18 Aug 2025 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LJB1YjhS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9826E711
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493107; cv=none; b=asBV4UUN4Tyrxo1dLE8PjvZUNreRFkhWpd7Sr9kIUnAoedtbzwcXlyyJ/sGxJHS2j5Oh+FwUp43dKzf8dWWkB6zQhEvY9G+9IFhco7AAPGwUEPBnkC6I5ZA9rFd8sjpXjbncNB5Bhjqtu6PK+xQu5yabu72AJ7Lu6V1XGl5kJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493107; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQXeQwC67azP0mfc2zo2El3VDs15AI2t2844TQCthMHtF0vGNPKGuRHhPiu99cRStVFNPHuS4ABLah7rJQeEzEM9As3hItKCpD5fn7wM/Py2DHuolHJnEt/KJ5iCBpAEDphDIeZESabYJd7zPUe0ISIeQtvWqcR47E3/vIxZTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LJB1YjhS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e614b84so3442068b3a.0
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493105; x=1756097905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=LJB1YjhSPDi3ASqdXd9e/3LjdPdQdKuh2m3QLX0xEEkeGWoHBtjZvukIpWej28w4sz
         54om+6mfqUJQRaifI5eEyVSxcDFgVlIDhblGGCXgNVhkJ3iLBK9Wzur/bpMs/7teNJG5
         tw0JrDsiZ1TY0JMxtwoYgMMk+Bl3R+Q3Uj3uIEnjY6mmQn46H7s46lpI5Ffde3licWB+
         1ee6PnKl0m6sMHiKAXbiXfa3EfRhYJARKX8Ypt4r0mRWND6jfIgIkjZcehzpB5fmBLLv
         6KgQsIAz8+iIIvAwLj+2DQKWjpIvX4quMFvEgKJ5bf6mPAvwMSBiqb8exMPcRLuBD/jo
         OI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493105; x=1756097905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=Efn+tCNDjZVAh3So0SktjO+IMB0nmUiOBn4aw7AYkLjqAvkqbtABEPlGScADAYrGE7
         RCH5GdteBNzRbs4g1XglfQpFohC0ktboCPhGpYe7S9Q8eET56dlpWRLqw9ianKH46S37
         2oWPHZQYtEUg7+dFPQv1EbdkCQvTchDbRtlDxhyWghRBqF1F8BeddFU3nLLLybS+yQoU
         48ogwT9+AgdX0VoWWXHyFE9fdA4QWFgaC8+wzZyfnW+e7o9kbN+OhP7z4vxInJcf0Qdm
         jkw3aKYmpeAtDpP/3iHgOq9VaErCwfFIBBElFHarKWhRzDAWP4O34wbL5UcN9C7kGwRH
         ZDzA==
X-Forwarded-Encrypted: i=1; AJvYcCUToRNALZXYo2zxKn8d6v9u8efXF1uNX+tdw+pvTimSe5X2FEcFR/k8UjuXqk0R9R1srJPK38u3pDIJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Dfz434zZb+vf9f0s4vp1304UJwQMWlQp8k10BC9FNvW/fGSb
	HmX7JNkpEia2sxyCTGN5oiyL3rNY/uUgRcUagg8xqgN5khif6hpHEsSmT+umnffTt4M=
X-Gm-Gg: ASbGncstzQ2Segzlh2HqqkSq/E2yuLaCNmijDcxzQE+nAuR00jJmko3x/ota21OfJ5Y
	R0T5S3okREmEGl5jXMHLV6soHMGWPFrHx/UprXE/lVcN1UVGkGum1PMOdZPFBU3rE0+tusPI0xI
	gWUK38wTXXmPzcxOrLmFANZFPZ3Pc69glGKNXFTJM/ykVNQOP+eKVAOzrx+tGMqjAhNAx0fnGjx
	dpd1fvVT8u3HRd8hi+MJketqjajV+77CW9zklK88yFlHMBEmvu/uIp9DYfRFoh2aQDtOaOow6s3
	iYcT8bFxueMBCKNhm90rivsTyAirB48nQ1Ggl5VUTWUJNXJXZS4LXBoH7Spry2QRofIS7RFvSvk
	Y5nFM+o/kH8gWNje7GpIYUPKIgxAjXnp0XG7jiAG2
X-Google-Smtp-Source: AGHT+IEemk+BWiEUx5FojBtceZEGdoOXlJtGCjztrL0+XbJGAKrKEJt4aBwM+DlqJqMugoECLw6zgA==
X-Received: by 2002:a05:6a20:5493:b0:22b:8f7f:5cb2 with SMTP id adf61e73a8af0-240d2dec932mr14433397637.8.1755493105211;
        Sun, 17 Aug 2025 21:58:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:24 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Mon, 18 Aug 2025 10:28:06 +0530
Message-ID: <20250818045807.763922-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818045807.763922-1-sunilvl@ventanamicro.com>
References: <20250818045807.763922-1-sunilvl@ventanamicro.com>
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
 drivers/acpi/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..f022f32de8a4 100644
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
@@ -1628,8 +1629,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = rimt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0


