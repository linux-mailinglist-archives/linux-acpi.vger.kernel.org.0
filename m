Return-Path: <linux-acpi+bounces-17863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6DBE7F7D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F77505EA3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCDB311C1F;
	Fri, 17 Oct 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IerYUUVd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D49311951
	for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695675; cv=none; b=F5pPlTL0rl1gtrMCuzHh2BINoMlrOCbxrkskNc3Dmt0hvWwOmqLwde7qFGFMKlJGOZ8DUOqzi27BcLLFVu+7HqGiBqrTfsArmieAy/v1J5N6nshonF0D7EWOsZEo7H7bXSdD3/72gsYhHWMWd/GQCP1bn2pt5ed/tUXAXI9moR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695675; c=relaxed/simple;
	bh=IyWTiQNF25BYk2oQublRhbi2VYkn4hoGCVt/bUMoH6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tShd3DLuQbM76pKgm3jIui5dglsM6HrlrKKepndPvndcPEJBjqGSceDaVGZ1egStRUZn+kJUB8n/mrXJU5XY51fVTuvmE9K9nNnJCakPf9Qjuji/SKqq2451wwy5dKEpkC+n+jqKidCcVoUy+S41MowCsv71eC/IP7WKpTXstLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IerYUUVd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7811fa91774so1615207b3a.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760695673; x=1761300473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGe/CRT39ZQFPjeA+jyXUuqmmxANn1zMrtmj+nPNink=;
        b=IerYUUVd2VNRUVztq/SSejqP75P9XNuWSiWb+rrU9miCP5h5pHQFZzgRZkhTJsLg3z
         jy4w+SVXHc1FEPFkfNaoceeexi8QWwfM+TTJXQQXZ/D2P7TFsG7plHzPkENWn342UT60
         j4XHb4a0UbN+EscpfuJSQArLlsNbaC70gALoFD708i0weeK/G5Wfte54GlVLRDMZXqxd
         ioyU5g35C1tNy1XJcMrPfkTSKbkWOzOawZcS9qRUGtpyoCtK/nmFhoPTNjE70cHIrlqa
         j4y9mOJa15l04M9hUzfOfksUeLc2j2ZCmxMEy/foLH89FzQ/SFjgXDLY9H26JO6rQNWA
         ZXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695673; x=1761300473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGe/CRT39ZQFPjeA+jyXUuqmmxANn1zMrtmj+nPNink=;
        b=KystIEtKeTActLEDrthfp1BRZWpwrRrT201rEHLYIGISb1oyp8OSndJ1Z157DMFULb
         Ll1LHyxpN6ZeGgmlg5c3NJeOxpvnoYVePuM30LvLBGsFi2mR3jLeQxP5mW+u1hCJC1Kn
         980GXScGZJDo/LhQPTpXPocgWc1zB0b9holtijs1QNDBUPqN2bXTqi4iS1Xld8JpfRMU
         HCGtDBIkwH45AqO2RzDHR1h5jUF5A2Gs0QtEcQtB8jNGCnDhBYLv+BAKlw4SVX4pvaxc
         zm650Z26UDbdSbMWbX2wHJMsihicKG+h0JT1gmzEnOlMO07IBJrdY0Hm7HGIKnXCmzqI
         ogeg==
X-Gm-Message-State: AOJu0YwIMzE2FhDOnsiTchErBr5GEZfDwSp4BveDmoLcbNd6WReLbViG
	kvcBaqcKw+jk4pFwu469mavz1yAH6eOQ9x8piryvfjJ2ajw2fGuZx3x+p28x6NIZeLctPpONLvH
	NQAnx
X-Gm-Gg: ASbGnctSvQR8jf/erLwrR1AQ2xUhs5WoXf34xpmmhqTDvExRg4/axalykBVNE1ehEVO
	mKCOZWBvUkrJmc5dheu5jbbUziCeUg1mHVu3fUwUpqARkQi+z9MiYSSP8KAE35owyJTsC88Q4+D
	Y5uWkvxp61JMDEwJOqQ2wTcRnG+zIRUKJtw7aLZ77geCMkznE0D6b8ksE0vtWOFGxZFSijA9Df4
	qr7hvBKTchWVHFnMdQRrHiJ/jiVsc9HMObGvnYvfDxIkrVCohaBIFJS7ZpHC0uteRCpWZ6ZPTI8
	ERxo22VVqUASSBuUHpbo+r/dTvgSh1ExWq6G0f1OsgM1U5dqART1KKu7h1uvZJ7eZ/R9RXrKZQR
	5iXpVKo1GwiFQgkXAit4S1gjFAzDCcWR4jSiFwq0Q9Q654BpgXm4FFrOcOmJCYnUf8uZOoxlIQv
	pNzoXzf+XiOlV4Wh2+fAs=
X-Google-Smtp-Source: AGHT+IFYdxhdopSeCt1Ue9AYvkyQWlrnVCBo+RDvUTTSjKJXSA/CgP5zTKZtZzV2zbMC7CPhk5pG9g==
X-Received: by 2002:a05:6a20:3956:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-334a8504834mr4672273637.8.1760695673108;
        Fri, 17 Oct 2025 03:07:53 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.92])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2472fe0bsm5092826a12.17.2025.10.17.03.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:07:52 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH] ACPI: property: Fix argument order in __acpi_node_get_property_reference()
Date: Fri, 17 Oct 2025 15:37:44 +0530
Message-ID: <20251017100744.71871-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A refactoring bug introduced an argument order mistake in the call to
acpi_fwnode_get_reference_args() from __acpi_node_get_property_reference().
This caused incorrect behavior when resolving ACPI property references.

Fix the issue by correcting the argument order.

Fixes: e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args() to support nargs_prop")
Reported-by: Thomas Richard <thomas.richard@bootlin.com>
Closes: https://lore.kernel.org/all/1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com/
Tested-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1b997a5497e7..43d5e457814e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 				       size_t num_args,
 				       struct fwnode_reference_args *args)
 {
-	return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
+	return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
 }
 EXPORT_SYMBOL_GPL(__acpi_node_get_property_reference);
 
-- 
2.43.0


