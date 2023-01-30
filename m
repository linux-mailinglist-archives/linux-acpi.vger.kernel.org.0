Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6766D6818C4
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbjA3SXi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbjA3SX0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:23:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE65590
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:22:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 5so12554546plo.3
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQmlSJt1mKnn8ZkMRDOuhHD/tvDeAwvwL75cA/i0XSQ=;
        b=QbvfBF3x8sRkM0Mnn/7yhdTo3EWPdiIllJBGkCmj/QGpf48KiP8LeNvULdX9sxCZOk
         xiFP+O2wlVL4Gq4cbuWRkJSt535XiYpwSdTb8m4eas8zTtvyr1acHedmKNvCJLRynZMv
         WOwZeKIHlMjKS3CS5V1Lq5PLZ+AdjrFEoGcYU05bT9wYYfYrk/Nv5Q1PxKPqveXNaiqY
         etq/G5VtbzZ69YGHfX2qubxDR8qDQNQqcv5bRx4sFIwJTdaXGYWkyz9C8Vu1WbgZ52L7
         KEoUJrdXZq8DH0h8L9/OLNamDd2vJtvBnCGv4io/LoAh46QsdpppGSyMk3smSCnDOFo6
         66Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQmlSJt1mKnn8ZkMRDOuhHD/tvDeAwvwL75cA/i0XSQ=;
        b=y7ABz6f3h4zIoAr3kzVyQMk5aHU1yO8hpPfAqOC4TJC1EdkQESVrY6SHrSLBhdmhVn
         S+pih5x5ZQ2eMvetJ3ZZTFcs+Pc2QKXHdquEsFWr0B124c0wplkidhKUPbjTejk1tl25
         vJcfVShd+u234g0tnbXzbSfIIY8CscVRAVBy3627ZO7OyETJveswPnGslyavzkJH6J8L
         oJ8x8tK6NnV0/Ewlm9lCJkupW82XJxeMYwpdditBsm4qhyPO1+SNU7ryMyxVHPikoRrL
         oPSZFeTNNIOLCWaBVL/CRfuAkm20Gh04BOQPMTRZf8Wq6y0LDFRzC29PXKzhV13Rd67t
         VSwg==
X-Gm-Message-State: AO0yUKXxpx2ODeUEF/k0qbvIPaoa1jfP9imAbfbVNY2xfPbjgvF5+LUK
        nKvPWyiUYEZdOcZvAtZFMUHVxA==
X-Google-Smtp-Source: AK7set/VYyvu92zZ3Xjk7mGEuU3c3+cw5HP/k76M0jAq7oPCWLADq7XR3KkvpFIG2EbGQYv5z3LwlQ==
X-Received: by 2002:a05:6a21:7885:b0:bc:f189:505d with SMTP id bf5-20020a056a21788500b000bcf189505dmr6444557pzc.48.1675102968293;
        Mon, 30 Jan 2023 10:22:48 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:22:47 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Robert Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org
Subject: [PATCH 03/24] ACPICA: Add structure definitions for RISC-V RHCT
Date:   Mon, 30 Jan 2023 23:52:04 +0530
Message-Id: <20230130182225.2471414-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

RISC-V Hart Capabilities Table (RHCT) is a new static table.
The ECR to add RHCT is approved by the UEFI forum and will be
available in the next version of the ACPI spec.

This patch is not yet merged in ACPICA but a PR is raised.

ACPICA PR: https://github.com/acpica/acpica/pull/804
Reference: Mantis: 2349

Cc: Robert Moore <robert.moore@intel.com>
Cc: acpica-devel@lists.linuxfoundation.org
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 include/acpi/actbl2.h | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c432fd15db65..86bb79fdfa62 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -47,6 +47,7 @@
 #define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
+#define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -2604,6 +2605,53 @@ enum acpi_rgrt_image_type {
 	ACPI_RGRT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
 };
 
+/*******************************************************************************
+ *
+ * RHCT - RISC-V Hart Capabilities Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_rhct {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 reserved;
+	u64 time_base_freq;
+	u32 node_count;
+	u32 node_offset;
+};
+
+/*
+ * RHCT subtables
+ */
+struct acpi_rhct_node_header {
+	u16 type;
+	u16 length;
+	u16 revision;
+};
+
+/* Values for RHCT subtable Type above */
+
+enum acpi_rhct_node_type {
+	ACPI_RHCT_NODE_TYPE_ISA_STRING = 0x0000,
+	ACPI_RHCT_NODE_TYPE_HART_INFO = 0xFFFF,
+};
+
+/*
+ * RHCT node specific subtables
+ */
+
+/* ISA string node structure */
+struct acpi_rhct_isa_string {
+	u16 isa_length;
+	char isa[];
+};
+
+/* Hart Info node structure */
+struct acpi_rhct_hart_info {
+	u16 num_offsets;
+	u32 uid;		/* ACPI processor UID */
+};
+
 /*******************************************************************************
  *
  * SBST - Smart Battery Specification Table
-- 
2.38.0

