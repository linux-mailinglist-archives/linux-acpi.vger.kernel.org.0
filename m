Return-Path: <linux-acpi+bounces-605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0777C79E1
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 00:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8851C214C7
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Oct 2023 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE32B5CE
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Oct 2023 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIA+h5/n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BE3FB21
	for <linux-acpi@vger.kernel.org>; Thu, 12 Oct 2023 21:59:12 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D2DA;
	Thu, 12 Oct 2023 14:59:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c746bc3bceso3979785ad.1;
        Thu, 12 Oct 2023 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697147951; x=1697752751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bRmsNjujjr87IHjRkMLVF3EP+IER+0qQMW+fpMjLQg=;
        b=VIA+h5/nZoHUgD3AI0UixqdM6pdd0yjw+UrdxuWekL0/bcwmZ23iPlB9eqHKjSnaiG
         jfzk1dzBbMVlk+yPvOeNcIO24a0vk949cizdDQQNArl/PIECN3RzFLf5JCQzTid/yV5l
         gCccI8QiVoTUD8QJXp/wkXR4Viv6qCRX25t1ySGGQNU+UCq21aDwisgvpZBLgdqdZHtn
         eaUNNpD+2/IY+0oijDHQHnDR3715FoMUor5dcTA5Tboucb14xFR0b2rvJ3rg4nk9Eg2e
         DNcfNuJ1tDFXEkcqL71fMk9YtfSUsN2PJ/bIZVwqWCWRBvhwscge1WQYBcpynHkHwtwc
         V+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697147951; x=1697752751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bRmsNjujjr87IHjRkMLVF3EP+IER+0qQMW+fpMjLQg=;
        b=OHoPGrSN+5tg87wabtpV71E9/i41dKVixVarFHCLkpCZHW5ATsA6kC1yVutKahfsHN
         9xXB122fqQulj0qLH1jfpLoCucme/fI+dYsBU3NVTc7gqcZET2NDos71fUsoO+Glik5Q
         xkuR8Huw8x67nS8KspDTOavEiNgvC5MTFFZf5HT/+ZfTXfYHhrtWpfiYw55eh0C1Pa35
         CcrQ4mDgH4/tvCQk6rqwwZxxYcYE2qPIF9kw7yDJdyMkGdfTufGrZ4dDBpKY5ndPqCCk
         a5Vrv7p/gfrG58g/W0rKMLVZlC5GiSUw1Xe5OVeUduzcsHlnuqJbb4EyWK6RQg4xAvc8
         hcBw==
X-Gm-Message-State: AOJu0YxE3+sz5Z0jFURgvXRfhQ1qHdqTBJRHpY/7utDraomOVqqzBfWV
	crJ1J21zwe4R9QTMK0n0vqE=
X-Google-Smtp-Source: AGHT+IEJ5AnfE0+n1T0JHCM+RVwVG1qkIZvLRGfH9TlJVR5npNnpa4dd1sYhMzJW9LCyM0so1ZGDLw==
X-Received: by 2002:a17:90a:9f83:b0:27c:fbf8:6c43 with SMTP id o3-20020a17090a9f8300b0027cfbf86c43mr7314082pjp.1.1697147950948;
        Thu, 12 Oct 2023 14:59:10 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a198500b0027768125e24sm2489295pji.39.2023.10.12.14.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:59:10 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] ACPI: NFIT: Optimize nfit_mem_cmp() for efficiency
Date: Fri, 13 Oct 2023 05:59:03 +0800
Message-Id: <20231012215903.2104652-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The original code used conditional branching in the nfit_mem_cmp
function to compare two values and return -1, 1, or 0 based on the
result. However, the list_sort comparison function only needs results
<0, >0, or =0. This patch optimizes the code to make the comparison
branchless, improving efficiency and reducing code size. This change
reduces the number of comparison operations from 1-2 to a single
subtraction operation, thereby saving the number of instructions.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/acpi/nfit/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f96bf32cd368..eea827d9af08 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1138,11 +1138,7 @@ static int nfit_mem_cmp(void *priv, const struct list_head *_a,
 
 	handleA = __to_nfit_memdev(a)->device_handle;
 	handleB = __to_nfit_memdev(b)->device_handle;
-	if (handleA < handleB)
-		return -1;
-	else if (handleA > handleB)
-		return 1;
-	return 0;
+	return handleA - handleB;
 }
 
 static int nfit_mem_init(struct acpi_nfit_desc *acpi_desc)
-- 
2.25.1


