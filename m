Return-Path: <linux-acpi+bounces-162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEE7AF539
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CBF37283555
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CE4A53F
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA029432
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 19:42:51 +0000 (UTC)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E3FC
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 12:42:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fa7e33573so254373039f.0
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695757369; x=1696362169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfBINqFi+tu9r+hgIndvcFHVghblGM5fsNWuNXfdXnI=;
        b=lEV6VOlJPdV09Ah2slGmsHMp5voeHDAUPfAZ8JxOV+ttSU+zaT0TWZ1Vj+jNS/PIJH
         pe77VvZn3EOVPmDJ8M+C8bZMPAT3GvB/Sj0uwzELyyE4mvSLPs7RHaugWWxlDH+wMOnk
         kE13JgIcZkdW5oNcEmTKPwzYQMmYybszxx5fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757369; x=1696362169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfBINqFi+tu9r+hgIndvcFHVghblGM5fsNWuNXfdXnI=;
        b=eXqMpaoz6jarygUtICsuub4XreWWSLtpHeSFJyqGQKacFIEtAa9tJycFGE+HWnNoMb
         ljHYisz9pKzTGi5bIUpokYx5apUI0/cBPy7J022HWYwf+sRobKD6yisTZaxhpz70tFJ/
         I1NaQG0n3f9OEFVz8t5P7XTggshyKH+gxCM+mCOYCIZa1pnPJplmKXr5wSiy2Ob/JP5X
         mn/245ZUUfTTDeUQLvg8dmQaJFoWTAkXrxZJP7Aa06hjHHl+6xdKzOz7lV+e4tBnMvl8
         5UD1V3QywOfjViqaZe0LUFpg4vRl9O6P0LFNnTA3ncAM6dHQ95V1ZaYxpgY5KfW0DuYO
         rjZg==
X-Gm-Message-State: AOJu0YwMy515vTWW9qc4ZescFT4xvQvEdRVq6bhtF3nR3SLTuS6AMmyp
	w7jdY80zArgdlOVEG6ZT3E3oIg==
X-Google-Smtp-Source: AGHT+IHn4wKAiOfOfPpJ96btA7O5kjWAiCXjuBwMWz61V9KKEyTA4jYKowovoVpbKAJXqsBb2Sa7gA==
X-Received: by 2002:a05:6e02:219c:b0:349:7cec:db76 with SMTP id j28-20020a056e02219c00b003497cecdb76mr14089105ila.31.1695757369179;
        Tue, 26 Sep 2023 12:42:49 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1da0:a3ce:7aae:e9fa])
        by smtp.gmail.com with ESMTPSA id g6-20020a056e02130600b0035134f1a240sm1961451ilr.86.2023.09.26.12.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:42:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Lean Sheng Tan <sheng.tan@9elements.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Dhaval Sharma <dhaval@rivosinc.com>,
	Maximilian Brune <maximilian.brune@9elements.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Guo Dong <guo.dong@intel.com>,
	Tom Rini <trini@konsulko.com>,
	ron minnich <rminnich@gmail.com>,
	Gua Guo <gua.guo@intel.com>,
	Chiu Chasel <chasel.chiu@intel.com>,
	linux-acpi@vger.kernel.org,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Date: Tue, 26 Sep 2023 13:42:39 -0600
Message-ID: <20230926194242.2732127-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926194242.2732127-1-sjg@chromium.org>
References: <20230926194242.2732127-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.

This aims to provide an small schema addition for the memory mapping
needed to keep these two pieces working together well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Rename acpi-reclaim to acpi
- Drop individual mention of when memory can be reclaimed
- Rewrite the item descriptions
- Add back the UEFI text (with trepidation)

Changes in v6:
- Drop mention of UEFI
- Use compatible strings instead of node names

Changes in v5:
- Drop the memory-map node (should have done that in v4)
- Tidy up schema a bit

Changes in v4:
- Make use of the reserved-memory node instead of creating a new one

Changes in v3:
- Reword commit message again
- cc a lot more people, from the FFI patch
- Split out the attributes into the /memory nodes

Changes in v2:
- Reword commit message

 .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml

diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
new file mode 100644
index 0000000..f7fbdfd
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common memory reservations
+
+description: |
+  Specifies that the reserved memory region can be used for the purpose
+  indicated by its compatible string.
+
+  Clients may reuse this reserved memory if they understand what it is for,
+  subject to the notes below.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    description: |
+      This describes some common memory reservations, with the compatible
+      string indicating what it is used for:
+
+         acpi: Advanced Configuration and Power Interface (ACPI) tables
+         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
+           the firmware for its use and is required to be saved and restored
+           across an NVS sleep
+         boot-code: Contains code used for booting which is not needed by the OS
+         boot-code: Contains data used for booting which is not needed by the OS
+         runtime-code: Contains code used for interacting with the system when
+           running the OS
+         runtime-data: Contains data used for interacting with the system when
+           running the OS
+
+    enum:
+      - acpi
+      - acpi-nvs
+      - boot-code
+      - boot-data
+      - runtime-code
+      - runtime-data
+
+  reg:
+    description: region of memory that is reserved for the purpose indicated
+      by the compatible string.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reserved@12340000 {
+            compatible = "boot-code";
+            reg = <0x12340000 0x00800000>;
+        };
+
+        reserved@43210000 {
+            compatible = "boot-data";
+            reg = <0x43210000 0x00800000>;
+        };
+    };
-- 
2.42.0.515.g380fc7ccd1-goog


