Return-Path: <linux-acpi+bounces-887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E577D5438
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C481C20B95
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051A31A78
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQh0FwQl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2742943C
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 14:14:23 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFBB6
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 07:14:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e4107f47so3266599b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698156862; x=1698761662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scCY6Z97zhmNP1gAoFGdRujC/I+uoKWN9MG2mo0gcTs=;
        b=iQh0FwQlMa87RELBXsNWCfDI3b2MGNPOe73mEkNZpz9fz2kQp+lJVOjgkfGZ9t8ve0
         rE21QNzM9UIS+7IdD84dW9d9cMgMrNFAJMk/Zv6a4NicM9T+K8bED20twNghv6azdzoB
         f2oLvj7bzm+g5GMafulru3VPe7B55rMGOmyNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698156862; x=1698761662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scCY6Z97zhmNP1gAoFGdRujC/I+uoKWN9MG2mo0gcTs=;
        b=U1nK+FwU6REbOMBqCitVdNVVNQaj2thqMJYAhOsomOAryl1txapRxK3DVX/S9tsNqT
         8dFU/cH5NceOOZIrmL6RUDjgulAYdW23uC6FdxubAzjReiwiRoJ6xxPsNUycu3EItrsr
         msLQNOaiQUliXe/o8/Pblj7gM9SXaHfFecq0693F6bdfm8uV9gmuvMIvECZ8nLrn4PDW
         wPMkdu1WuyMbMVnanLSr4Ir3DVnI4edkG3tIFs0hECzhMnkO9oDl32EbMlIZt6h3gNvl
         t6c0N0BDfdsRSiWDDaDMJ6IMguB4bDH5o3sUaHXI6ddSE2GffOnDwHWSqQblQW0MGLUq
         K45w==
X-Gm-Message-State: AOJu0YytCACa/N8G6xrtZo5jfU7LUG0hSvhDJ1QFaP7E1hivlaZ0+5qc
	wx9vaJrUjWo/u43pxbswWSlFvhWyKrhlJQrYevk=
X-Google-Smtp-Source: AGHT+IGpC/t6xxkJj/reT4dvsvDu+Vx92dgL9E2tM2g9pdt3DgoDM4cfSf2pbaCWkKKxb14LJz1dpg==
X-Received: by 2002:a05:6808:152a:b0:3b2:e48d:97bd with SMTP id u42-20020a056808152a00b003b2e48d97bdmr16779320oiw.23.1698156862206;
        Tue, 24 Oct 2023 07:14:22 -0700 (PDT)
Received: from jdenose34.roam.corp.google.com (99-137-158-190.lightspeed.cicril.sbcglobal.net. [99.137.158.190])
        by smtp.gmail.com with ESMTPSA id bx20-20020a0568081b1400b003af60f06629sm1948590oib.6.2023.10.24.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:14:21 -0700 (PDT)
From: Jonathan Denose <jdenose@chromium.org>
X-Google-Original-From: Jonathan Denose <jdenose@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org,
	Jonathan Denose <jdenose@google.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] ACPI: EC: Add quirk for HP 250 G7 Notebook PC
Date: Tue, 24 Oct 2023 09:13:36 -0500
Message-ID: <20231024091336.1.Ie25ddf26b761bf185b7152c6a9884977f0ce73f9@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added GPE quirk entry for HP 250 G7 Notebook PC. This change
allows the lid switch to be identified as the lid switch and not
a keyboard button. With the lid switch properly identified, the
device triggers suspend correctly on lid close.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c95d0edb0be9e..a59c11df73754 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1924,6 +1924,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
 		},
 	},
+	{
+		/*
+		 * HP 250 G7 Notebook PC
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook PC"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.42.0.758.gaed0368e0e-goog


