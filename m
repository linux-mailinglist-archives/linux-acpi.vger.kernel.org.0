Return-Path: <linux-acpi+bounces-278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E27B2875
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 00:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4DCE1281BAE
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663A19461
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4E9CA6A
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 21:48:46 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699B199;
	Thu, 28 Sep 2023 14:48:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5031ccf004cso21470336e87.2;
        Thu, 28 Sep 2023 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695937723; x=1696542523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq+3NSCKf562cneQoiJ9VPGAAXb6BJhJtr98HGf8uQM=;
        b=QBCxUwN9Qrgmp8NJfVIE8pdUdk5o/UUImAhicGa4sYGPWL2LqOhmKcey+DuXtEqJCX
         bzveLX5jv50e5uh04YBBwRjRa/mLmGesxqESHtSeRdfbSf/a8KR7sakgAfMXiDZwD+1A
         Ugbqe71DQrTdAxuzxZvOt1vj7euXHiSjaNqPrSHmW1hePIJYwZmLZ+nRQhS1Av33lEUd
         GMjQZoN5yAgAQmYjzezfXFmBSTKvll5dsRa5wgFqog+Qq10P8wNa9kDVfMjctHakMSRE
         gd7IpDeMeVLwxIm+guZIXSOQv7XAMpOoAZEEdmBCWzASQ9WqXBwe5inZBWUGtj5C5d6U
         4/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937723; x=1696542523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq+3NSCKf562cneQoiJ9VPGAAXb6BJhJtr98HGf8uQM=;
        b=u3amRDvaMqtYkvVhCeewbOi4iMoezmySOQj0IWsiEp13xEke5HI0+hoUQ9AmMd81Xc
         OVBEImZsWHY/z6i9fJDo2sslvKJwD/ucUdZPxuNALZR9cFen2FlYQPbZGQ1Vz7mo4s3o
         Qf47PU4fFeY4hZyobfAysrxdni29EVAMooHJLXRe7cKW2SSm4LeLEVhKBPpXAg2ZVcUN
         zMcHzkus1LPKf1qz+Oer0fmQKJgnrGYDuBe5m2bBnjDOKOstdtmu7GY8kOYC0OdCLM9J
         FeGa7Dkp/QBPqdeC/F/tkZKlHNheyy4OxDqeLBfGDvEj7wY3YZG4O4HUlY6zUZTUSG2b
         eMrA==
X-Gm-Message-State: AOJu0YzIr0N8nvwhOOxR9OYXsv4ryULBpNKMomQr1z9aEZrMBqdcLX3j
	g9mGgCIrSo15Ivo3+ynCzNE=
X-Google-Smtp-Source: AGHT+IEYJdy64Li7e3Z38US8HAB/Br7nTo76+wuPRD5kbZgEK1Z2J1DAjI/fNLk4UQzF21ZOEZAwzw==
X-Received: by 2002:a05:6512:3987:b0:503:eae:4896 with SMTP id j7-20020a056512398700b005030eae4896mr2546442lfu.39.1695937723227;
        Thu, 28 Sep 2023 14:48:43 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id u13-20020ac2518d000000b00503200ce35bsm3260287lfi.136.2023.09.28.14.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:48:42 -0700 (PDT)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: lenb@kernel.org,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/2] drivers: acpi: Remove braces for single line statement following a control statement
Date: Thu, 28 Sep 2023 23:48:23 +0200
Message-Id: <20230928214823.43427-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Removed braces which are not required for single line statements which
follow a control statement.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/acpi/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 300646bf8ba7..9a95b37a3352 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -342,9 +342,8 @@ acpi_evaluate_reference(acpi_handle handle,
 	u32 i = 0;
 
 
-	if (!list) {
+	if (!list)
 		return AE_BAD_PARAMETER;
-	}
 
 	/* Evaluate object. */
 
-- 
2.34.1


