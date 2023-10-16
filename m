Return-Path: <linux-acpi+bounces-674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50E7CB2B9
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6AC1C2034D
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB21339A7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EBV9mw4O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904D273EB
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 17:09:50 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D109FD
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 10:09:49 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57b6c7d0cabso2986602eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697476188; x=1698080988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6AuZhMJdIdvOw1LD4IXAZJtQuk3yEBuC1IpwOZAs8Q=;
        b=EBV9mw4OOf3rs3uBrSRun1VhzjHHXFUpNg9lieAM1nZnqLvLpquXkXICkE9wrAH/j1
         wGMQkZ3Q9p2FCBALM4SPP320yKDJuPuUlqMbjJDUFPdQy6BvqnD+pVY2wT31Hs2cfE5f
         xTh7LkIkY97CxL558hresqy8AD4sIefOnmJrYE5rj8nbHPS7mGu5BhU0eemGAET8uH5X
         7oQyFq3v5HORLN98H6+SPc2RFatspukNICLlF9eRieV+auvsgFXp4q7lGkJI3P8OdcIm
         V7/XbUVax3wJyduLg59LdexEIO13mGBoJTj4vVRiJ5PcDGNxSbT+Dd3mhF18hzxoipCV
         MQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476188; x=1698080988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6AuZhMJdIdvOw1LD4IXAZJtQuk3yEBuC1IpwOZAs8Q=;
        b=iKO7okKzHnLxng147bwoe4rH4wx7gCgDAfArhn+ul4kXqep4WtwVN8Z8ppkucjOQ74
         yPB9f59YVT2qYLq2lSr8YoOGsfGPL8UnOgN4wWOpbiFxEaChk+FmR0W08P9xsFzBuBLO
         tpDxeob+YIrUrvVMIAcEKsZLjcYwXRoJsYijUJ1DzvLdMw0jr1bp/JLub2mtyAlP9Y0w
         HTSWqhU0rdihrZH1xkLcIlRd2M+VKccETODYsdODgNAGZrN0T/7W9IXR4/YokjUYNKu8
         v9fOCu7bRjU4ubHGBCv+hl8w5QG8o/0H/eiy66VhqwXl+9ujMUDarawXC69p4SnPmqP2
         lP1A==
X-Gm-Message-State: AOJu0Yzjidw1t20QNWkHA1T/iFsCwSqd7k70jw6VJVIwBraFh+Q3L0QU
	hkrXas7430WUvwXEPhom9kx9b1NJGOL9328Tlj8=
X-Google-Smtp-Source: AGHT+IGSbX9vMK3agaj90fIsWAJz/6r105PRLFK5J/Ls+bVX9/obgE1QyAyGTBKmK/HRo7fgNP4HWQ==
X-Received: by 2002:a05:6359:6604:b0:166:d143:36c9 with SMTP id sm4-20020a056359660400b00166d14336c9mr75146rwb.0.1697476187978;
        Mon, 16 Oct 2023 10:09:47 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id f64-20020a625143000000b00690fe1c928csm145888pfb.147.2023.10.16.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:09:47 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Agustin Vega-Frias <agustinv@codeaurora.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] ACPI: irq: Fix the incorrect return value in acpi_register_gsi()
Date: Mon, 16 Oct 2023 22:39:39 +0530
Message-Id: <20231016170939.1192260-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

acpi_register_gsi() should return negative value in case of failure.
Currently, it returns the return value from irq_create_fwspec_mapping().
However, irq_create_fwspec_mapping() returns 0 for failure. Fix the issue
by returning -EINVAL if irq_create_fwspec_mapping() returns zero.

Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain mapping")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/irq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c2c786eb95ab..403f33df66af 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -57,6 +57,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	struct irq_fwspec fwspec;
+	unsigned int rc;
 
 	fwspec.fwnode = acpi_get_gsi_domain_id(gsi);
 	if (WARN_ON(!fwspec.fwnode)) {
@@ -68,7 +69,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
-	return irq_create_fwspec_mapping(&fwspec);
+	rc = irq_create_fwspec_mapping(&fwspec);
+	if (!rc)
+		return -EINVAL;
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
-- 
2.39.2


