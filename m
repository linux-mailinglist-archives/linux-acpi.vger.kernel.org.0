Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0878E31B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Aug 2023 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbjH3XSO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Aug 2023 19:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjH3XSO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Aug 2023 19:18:14 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A10A3
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 16:18:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7927952ca67so11401239f.2
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693437489; x=1694042289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IomW+Mec9sthmR9cu2/c2HOTyUZrOLUcRUv85KAO91E=;
        b=HeGKYJiVQcey1hhJvHAPgIWumyvkUl7DzP3F21rzsplSxBigebVkhwe08kAbeBQRxf
         BtpZx0wKFbXDts9uRh953LzYYHha8EQaQPq1uaeLh7EfncrEBlGlnVmyHCSh9pPpnKX8
         rSNjJGqoSWi+r6YgytUKv8fYf8tVQe2mg+ytQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437489; x=1694042289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IomW+Mec9sthmR9cu2/c2HOTyUZrOLUcRUv85KAO91E=;
        b=Dgk7Wz6maq4Tos5BoV/UVLbBVpVCQhEBEpX9y5JBJlCs1IL+831zvrafawWh4f+JxX
         eFCwZ0CkHKHe8pXiOGPzSGLvzwxKK+zRCpNaM8P3eAGnMoVSVWAiziEZLUEOtBzWT4T5
         TjVa/Xn1tkjmpNojwmSsRGz3zi2uhqk7K37xkJ8rV4K1rAsdu0Ku09+0CoVzMmKd6mOf
         a+gXsNdfzFIz8wUEi2KI1Bndo9ppypkoSFXHQY1XSxl1veL5fBEg2+BOByrdGOVRbcwP
         NWaZAOgAG1gnHyAvrZH1RBcqIn7q5PhcAJbf3QKX6Diqn6lQ2CLwd0JsgHw8R5S76iXM
         xg2w==
X-Gm-Message-State: AOJu0Yw486KuJvJ2hhsodpn7AOoVBwkyKc3J4/a17yLyJ7/6LsifYeuR
        JKJIn9Pj14IppWXbCPcbQ2ZKqg==
X-Google-Smtp-Source: AGHT+IEYGJNH1CGCeQsbWkow001Dg/4CtvKV/pF2SGqYbrCiviXf5gzS1igFQo1OGrX4mpY8x0Tnlg==
X-Received: by 2002:a5e:a706:0:b0:78b:d0a9:34fb with SMTP id b6-20020a5ea706000000b0078bd0a934fbmr3795029iod.20.1693437489546;
        Wed, 30 Aug 2023 16:18:09 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
        by smtp.gmail.com with ESMTPSA id z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:18:09 -0700 (PDT)
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
Subject: [PATCH v5 1/4] Add reserved-memory
Date:   Wed, 30 Aug 2023 17:17:49 -0600
Message-ID: <20230830231758.2561402-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
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

Bring in this file from Linux v6.5

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- New patch

 .../reserved-memory/reserved-memory.yaml      | 181 ++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/reserved-memory.yaml

diff --git a/dtschema/schemas/reserved-memory/reserved-memory.yaml b/dtschema/schemas/reserved-memory/reserved-memory.yaml
new file mode 100644
index 0000000..c680e39
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/reserved-memory.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/reserved-memory.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory Child Node Common
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+description: >
+  Reserved memory is specified as a node under the /reserved-memory node. The
+  operating system shall exclude reserved memory from normal usage one can
+  create child nodes describing particular reserved (excluded from normal use)
+  memory regions. Such memory regions are usually designed for the special
+  usage by various device drivers.
+
+  Each child of the reserved-memory node specifies one or more regions
+  of reserved memory. Each child node may either use a 'reg' property to
+  specify a specific range of reserved memory, or a 'size' property with
+  optional constraints to request a dynamically allocated block of
+  memory.
+
+  Following the generic-names recommended practice, node names should
+  reflect the purpose of the node (ie. "framebuffer" or "dma-pool").
+  Unit address (@<address>) should be appended to the name if the node
+  is a static allocation.
+
+properties:
+  reg: true
+
+  size:
+    oneOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
+    description: >
+      Length based on parent's \#size-cells. Size in bytes of memory to
+      reserve.
+
+  alignment:
+    oneOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
+    description: >
+      Length based on parent's \#size-cells. Address boundary for
+      alignment of allocation.
+
+  alloc-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: >
+      Address and Length pairs. Specifies regions of memory that are
+      acceptable to allocate from.
+
+  iommu-addresses:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: >
+      A list of phandle and specifier pairs that describe static IO virtual
+      address space mappings and carveouts associated with a given reserved
+      memory region. The phandle in the first cell refers to the device for
+      which the mapping or carveout is to be created.
+
+      The specifier consists of an address/size pair and denotes the IO
+      virtual address range of the region for the given device. The exact
+      format depends on the values of the "#address-cells" and "#size-cells"
+      properties of the device referenced via the phandle.
+
+      When used in combination with a "reg" property, an IOVA mapping is to
+      be established for this memory region. One example where this can be
+      useful is to create an identity mapping for physical memory that the
+      firmware has configured some hardware to access (such as a bootsplash
+      framebuffer).
+
+      If no "reg" property is specified, the "iommu-addresses" property
+      defines carveout regions in the IOVA space for the given device. This
+      can be useful if a certain memory region should not be mapped through
+      the IOMMU.
+
+  no-map:
+    type: boolean
+    description: >
+      Indicates the operating system must not create a virtual mapping
+      of the region as part of its standard mapping of system memory,
+      nor permit speculative access to it under any circumstances other
+      than under the control of the device driver using the region.
+
+  reusable:
+    type: boolean
+    description: >
+      The operating system can use the memory in this region with the
+      limitation that the device driver(s) owning the region need to be
+      able to reclaim it back. Typically that means that the operating
+      system can use that region to store volatile or cached data that
+      can be otherwise regenerated or migrated elsewhere.
+
+allOf:
+  - if:
+      required:
+        - no-map
+
+    then:
+      not:
+        required:
+          - reusable
+
+  - if:
+      required:
+        - reusable
+
+    then:
+      not:
+        required:
+          - no-map
+
+oneOf:
+  - oneOf:
+      - required:
+          - reg
+
+      - required:
+          - size
+
+  - oneOf:
+      # IOMMU reservations
+      - required:
+          - iommu-addresses
+
+      # IOMMU mappings
+      - required:
+          - reg
+          - iommu-addresses
+
+additionalProperties: true
+
+examples:
+  - |
+    / {
+      compatible = "foo";
+      model = "foo";
+
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        adsp_resv: reservation-adsp {
+          /*
+           * Restrict IOVA mappings for ADSP buffers to the 512 MiB region
+           * from 0x40000000 - 0x5fffffff. Anything outside is reserved by
+           * the ADSP for I/O memory and private memory allocations.
+           */
+          iommu-addresses = <&adsp 0x0 0x00000000 0x00 0x40000000>,
+                            <&adsp 0x0 0x60000000 0xff 0xa0000000>;
+        };
+
+        fb: framebuffer@90000000 {
+          reg = <0x0 0x90000000 0x0 0x00800000>;
+          iommu-addresses = <&dc0 0x0 0x90000000 0x0 0x00800000>;
+        };
+      };
+
+      bus@0 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x0 0x0 0x40000000>;
+
+        adsp: adsp@2990000 {
+          reg = <0x2990000 0x2000>;
+          memory-region = <&adsp_resv>;
+        };
+
+        dc0: display@15200000 {
+          reg = <0x15200000 0x10000>;
+          memory-region = <&fb>;
+        };
+      };
+    };
+...
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

