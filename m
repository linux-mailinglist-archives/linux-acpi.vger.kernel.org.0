Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4878E323
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Aug 2023 01:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjH3XSX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Aug 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbjH3XSV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Aug 2023 19:18:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7CA1A2
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7927f24140eso11987139f.2
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693437495; x=1694042295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5dYm0P+tYaP9ugFonlv+1+ajXE4Bun3MDvz1H4U99Y=;
        b=P3WE23B6141JCcjBvCXKkZ7FZ1BuR5KSG/cfbHG5l/0nMg13lRkfd4lzJoJboyZMXM
         LOLioz0G6BJuozaNPPem3a8juIZ3aE+OxFRYiP0uZf94/xApZ3fs2ziLqBDeBcPaW+zv
         bJ48Nf5TpnApbfzow1xSiyJNpZyBFsnWag/bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437495; x=1694042295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5dYm0P+tYaP9ugFonlv+1+ajXE4Bun3MDvz1H4U99Y=;
        b=k88xMtJIRvMPckE06n5es/LvKfugIbYC2lrjW+1wyhrt/NIJsFdpmpcNF4fsO6Fcs2
         nxGcubghopuhtmIqDXnFPV7UZuyGbFwnoIv8Sp33imAsaAXjv4TGUuFcdpJZ+7VxzXne
         ngkj0PMKerWGbzliqe+eMsG3k0Dgk/Q/H9ftGLqSgQVTr6GzFPBMYMFQCV1VNzF34yME
         S9SmUaFdzZ8HSI5BFsFiVNTmBQJ4kkRkM/poaLlTzvmGhghPFvAxY8Qmty71+0eC0Oto
         KTzYv5cKavQot2+rFA3P1dsHlM5s+1VKwSECQyA9xWQ0kstE92FaTgkqMF4OMHkEm3dL
         I2vQ==
X-Gm-Message-State: AOJu0YzsooJYiCfwseO3VtVwDM7Tzz6VGVH7xzbdJOZTN0VvJSXOwOxC
        g+/5m64clDpVFr6akZLcpw50Jw==
X-Google-Smtp-Source: AGHT+IHbhEkN2e11zGzdoaKLoCaWImVUNVgxzxMc+LsGq9Hv9e+k6T9lyQM2LaTI4FZURLKgKoaYeg==
X-Received: by 2002:a5e:8a48:0:b0:790:c259:4ee5 with SMTP id o8-20020a5e8a48000000b00790c2594ee5mr4273635iom.8.1693437495666;
        Wed, 30 Aug 2023 16:18:15 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
        by smtp.gmail.com with ESMTPSA id z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:18:15 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Maximilian Brune <maximilian.brune@9elements.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Gua Guo <gua.guo@intel.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Guo Dong <guo.dong@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
Date:   Wed, 30 Aug 2023 17:17:51 -0600
Message-ID: <20230830231758.2561402-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
References: <20230830231758.2561402-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Devicetree specification skips over handling of a logical view of
the memory map, pointing users to the UEFI specification.

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.

This aims to provide an small schema addition for this mapping.

For now, no attempt is made to create an exhaustive binding, so there are
some example types listed. More can be added later.

The compatible string is not included, since the node name is enough to
indicate the purpose of a node, as per the existing reserved-memory
schema.

This binding does not include a binding for the memory 'attribute'
property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
to have that as well, but perhaps not as a bit mask.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

 .../reserved-memory/common-reserved.yaml      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml

diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
new file mode 100644
index 0000000..d1b466b
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
@@ -0,0 +1,53 @@
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
+  indicated by its node name.
+
+  Clients may reuse this reserved memory if they understand what it is for.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  $nodename:
+    enum:
+      - acpi-reclaim
+      - acpi-nvs
+      - boot-code
+      - boot-data
+      - runtime-code
+      - runtime-data
+
+  reg:
+    description: region of memory that is reserved for the purpose indicated
+      by the node name.
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
+        boot-code@12340000 {
+            reg = <0x12340000 0x00800000>;
+        };
+
+        boot-data@43210000 {
+            reg = <0x43210000 0x00800000>;
+        };
+    };
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

