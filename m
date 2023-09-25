Return-Path: <linux-acpi+bounces-116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407467AE1B1
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 00:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 515EB1C2091C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B52628A
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 22:30:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E51170A
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 21:41:03 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1EA3;
	Mon, 25 Sep 2023 14:41:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5faa2af60so7842655ad.0;
        Mon, 25 Sep 2023 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695678062; x=1696282862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+7R1ZC1LpCIsd5QhAKbQCzI8a0TBew1Yl2b+K+Z1Aw=;
        b=GZ/etxxprpv/iAoiwItDSFy86IgxJIbnO17JA8T5X7D/YhjvRLNvFNEaPCd6e6HWgM
         vbkHoyVRhL1BkA7RMbkQ9ZncoMeyjdSrjaX8GEpaxGYu4UCOG4/HlDNJ1kg+fmsfqxKM
         +88XsqihDYodmSlQt0K0yJ63QgzTa1qb3TBOtrWPQKZauZyLUAPDhBJ2wG/mv+nstpbb
         Os8TL/WJFI+qVVsOimsY0tDSp4S+1pMIOmJldNPg1X4zI3k/F9Y0VSCTIupHhcXgZgX6
         rM+WKSLccTZt6y9m9WRClvdQ2CztNVIuXgICdLWxNVqqV6EytehQ4gIvK6O2tXGK3+Rm
         S0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695678062; x=1696282862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+7R1ZC1LpCIsd5QhAKbQCzI8a0TBew1Yl2b+K+Z1Aw=;
        b=Li2CnU0PUVr9OPNXAH3aPBomgL4awVh+0Ny4LRWnfq5KbUyGXUZBReRpgPlguIlcUZ
         glsAFRHHJ2I6El+2mDRGOWChl4iYB7I0tZyZihgjiAXPKiKzbIS3xDMQlz3x6nMZGt9e
         wYldUQXkRHid6WHBOwAjkWckt+/QkQvMsoNlPtSoIFhC05zjNLSyuZWIX8V0HkFvV4hE
         rVfAF328UK9gVUFRKAcFOrCd7rS599A1Xb8eFfn4E1EZ+OAE0EnxhCTHjA3tJF52/pX9
         OqNkklVVsAAmOM+eYaYABH1y6887PSQPqIJBEVBfSxn4S2aIw1arYtmKV9Epzxx9LSNQ
         KshQ==
X-Gm-Message-State: AOJu0YwFSLzk2glapWeRC+X6CMJkX7rt/y6/CS9uuShjoWuenGJQBpRp
	ynV9iB4efCtgj8uckccTIOg=
X-Google-Smtp-Source: AGHT+IHkIBPT5iv2P/n5JInOlCW7/Pv1ttVPoyLSIFMmbU+DWK46ltC0v8bQ9hQ/M8UiexcmNRVyIA==
X-Received: by 2002:a17:903:22cb:b0:1bb:d7d4:e2b with SMTP id y11-20020a17090322cb00b001bbd7d40e2bmr10112393plg.0.1695678062341;
        Mon, 25 Sep 2023 14:41:02 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:c13::398])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001c0a4146961sm5582271plc.19.2023.09.25.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 14:41:01 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: FPDT: break out of the loop if record length is zero
Date: Mon, 25 Sep 2023 14:40:21 -0700
Message-ID: <20230925214046.1051350-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Buggy BIOSes may have zero-length records in FPDT, table, as a result
fpdt_process_subtable() spins in eternal loop.

Break out of the loop if record length is zero.

Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
Cc: stable@vger.kernel.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/acpi/acpi_fpdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index a2056c4c8cb7..53d8f9601a55 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -194,6 +194,11 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 		record_header = (void *)subtable_header + offset;
 		offset += record_header->length;
 
+		if (!record_header->length) {
+			pr_info(FW_BUG "Zero-length record found.\n");
+			break;
+		}
+
 		switch (record_header->type) {
 		case RECORD_S3_RESUME:
 			if (subtable_type != SUBTABLE_S3PT) {
-- 
2.42.0


