Return-Path: <linux-acpi+bounces-15188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C5B073B9
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750997B85F0
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3FC2F49EB;
	Wed, 16 Jul 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NZRwvBL7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F262F432F
	for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662484; cv=none; b=ctPU26RT6Latzzq+hxTbAWnncQ259OEsuZZdI7xUX5hxwLUgILVi+UH7yVPIbmbq+TcES1shYInkL+6YlzIjOaw9dpGWavfz94CtwuH5vKh6c+p4gGSg2cAB4drOH6f+0Y8KIW5y1FG+O8sMe/ZGSJpHeX9MJfASX8SLtk0XSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662484; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFkFFpJyC7m0STw5XGLj314DDG2eJB+PuFlaIs/0QsTv5PDdAlVb/o2Te6gvBlmOMv9c3i0uoZD1V2ESEpw1+ZHhOSSBHB1U9HzTh0lktu+aALXuXoz4twSj1YH5QP7/scDjZnTUjLn81TovGMEr5DxujX2LvuEdTF+IMCPat0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NZRwvBL7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c7a52e97so5334148b3a.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662482; x=1753267282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=NZRwvBL7TQCUevVXlVOVDtTEb4fXOJ0970bmPnHHjezYtwcOFyf23lbCu1M0BUwOjd
         c4KZvgeZtaYKGCIPa7SqZc4IoR0TNYVLA6hS/4Str8WlMLipmxs+Onzc8OYEImAivX16
         rlsPJAVHgkRo/A9dRoxO6PFVs/FrDIRYFRgMGw4uXseFg5dVpGlR3qJyRkaeACbw6HWC
         j+SthCv7wctN/ZzgYz9xhW9nrzO1aKvoa230paMOl62wr2YoS6v9y+qnkDAOYHHAAxAH
         8h+fp5h3g2/IuEuPlT0SSlc5hPBSm0oKy7NO1SgVHZhkjdBsoNWZ2W15H8vzXHzcBlfC
         Y0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662482; x=1753267282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=CpfQV80h3y4fl/7IKk8dg4k8DqaMwK+pM/wHOn/2v/Q1cRwRogbYcoHPMj0kB+yWEa
         UeQ0Tw2Bm3NPrffIauPTdqfRhuQv8ePo4q4fA6cqJbMqUu8ba9jORuh4nNNZtpgKw0mf
         yujTMz9NVR4rvLjLqLWMSvqRqm9VANkuPLGGovB9/4uVus9S31jq7zvoJ3BcMrXUNzV2
         SMOxej5GRLfmbvQAd5pWejp7xNP1VMaixIRbEtbNAb62FrsRRG5fRbrYMFCLv7AFF+7d
         OpDMacdj7qEJX2qlYZiHMpsPGNpRFn0stlYht9zUUpYajdt2viFrEf3uUuiFiCbrVm2u
         Ks7w==
X-Forwarded-Encrypted: i=1; AJvYcCX4ym/er61l5g9f/8dWUkHdGom6ggidxIpHvBeKkTCm+qPFKENrYkTfFg6EHf1cI7BkxzyhQYkF1udX@vger.kernel.org
X-Gm-Message-State: AOJu0YzFO8LwDAtKXru/Z6nHnXY/IFPmjTJgXZ10qfsaDdmvtbrCYG+6
	nn3oQieKK705l4XG7JNN48p+Ww2i3acwR24eGIkwuYLRaFDBLLIHLLu89VGBDeNDee0=
X-Gm-Gg: ASbGnctuQSrDNwQMRGjUZLdOoRZKGSFMqYRrgLNVz5hoJASlmfNf5eFJfSKO2yn8iGy
	ULbItGrd5T7HPYRdLaMbIITCZUcQ2JvLIGFTFWn6By5wWx8UXQ37WfrV66ogxgdyMZvahsEyeDM
	OTVkk5Z+8L0Ae2DVT23cf4gshzX2z5JAFkYNXrIMg4ZU/UIPelT15jtVc6gIms9vxhd2sfqMcWG
	t6QcM+RdzwMzm+Bkb2NYLIdU7lFLiZj35VOR5RhN+FaZ/N6ASOwq0WLgjA0Tc1ikUTsc/wHLdhz
	HaOBGyTZTwedptNvXkTEb83OQCuaPOU7J+8jSSk1zj5nSh3bXsLEqTg10bcppAVHEW/Zcs6oFRe
	vaanvkrd7aRtCOntuuCSYkscZ4gvZ6OL8
X-Google-Smtp-Source: AGHT+IEC8Wh248xbvV7SVKKzD0alSVzVgeFsgJh9ogEs3+/ngP7xonwyOrkgTHqNNgbjcXTmqAIWTg==
X-Received: by 2002:a05:6a00:2387:b0:749:540:ca72 with SMTP id d2e1a72fcca58-756ea8b944bmr4580850b3a.24.1752662481956;
        Wed, 16 Jul 2025 03:41:21 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:21 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Wed, 16 Jul 2025 16:10:58 +0530
Message-ID: <20250716104059.3539482-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
References: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
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


