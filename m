Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137A0797E08
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjIGVkV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 17:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbjIGVkU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 17:40:20 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B3B4
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 14:40:16 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34ca1aadcccso5891365ab.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694122815; x=1694727615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuNfNRXcT/k9V+ptR/yNdUXnw9b7b9R/vB+EyNk6U1Q=;
        b=DUcnESjB2G4a+r+kZyaMIL95itY3jFk9Xf2wUH31Wsb1CWuNuPD5M/TeOL/9MsS/Mn
         fXDSD7la8pGixY+KDfBy9uawuatiDHbuPm03RI2uQMrEjGoeizcLIwJDF+/4ZPnKjfgy
         VwR0caEPZOy1ONn6sfKEGK0JbfqKfdCpr/ItQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122815; x=1694727615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuNfNRXcT/k9V+ptR/yNdUXnw9b7b9R/vB+EyNk6U1Q=;
        b=S41CyzQy8xpxW+gaNik0SXzMarta2gQsmOch5gqT8SHeiY/ogGW7PlDwtUJtMHIvBo
         zt6S3BNXFK5xoAPjQcmOGBcUQh0lmffoqLeuDYOg3rMZDRlSRY8Hz+32vS0fZI3+4t1m
         xvt6OfTdgQFI0wzfVdiS0AkEQ8jIAlta1+vYlsHfwKSRnzAvwNE9VYbStUdsaK4Y0ZZM
         RrLHLdk95TOkiyweUyAINo2YMxDAhmSHKzhcSD+k58gZ4wsrpfQdwUu03zPbf93vlwes
         DrUgDiGunU8AXXraP3hnG1O/GJquAmrV2ryZ0nuDpe4N8EzA/Vkok7IqaGA6wzhGRNL/
         5pNA==
X-Gm-Message-State: AOJu0YzAMKsFGiNEoS98QOMXU43L9/7tup705Wx9ZLkzrDsV8j10Fabe
        o18cWnyzl5A7Fi/A5ABphQEohQ==
X-Google-Smtp-Source: AGHT+IHDLp8Ggcfk51qBwQHePnX3O5h7/52QV2/g5gnYYMU/kivj6AJyv0nmeNnWNBadoPNLcyCjng==
X-Received: by 2002:a92:d44c:0:b0:349:8a8b:70ca with SMTP id r12-20020a92d44c000000b003498a8b70camr1055691ilm.14.1694122815649;
        Thu, 07 Sep 2023 14:40:15 -0700 (PDT)
Received: from sjg1.lan (c-73-243-118-188.hsd1.co.comcast.net. [73.243.118.188])
        by smtp.gmail.com with ESMTPSA id x14-20020a92d30e000000b00348edca2abesm72006ila.47.2023.09.07.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 14:40:15 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Dhaval Sharma <dhaval@rivosinc.com>, Guo Dong <guo.dong@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-acpi@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
Date:   Thu,  7 Sep 2023 15:40:10 -0600
Message-ID: <20230907214012.74978-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

This aims to provide an small schema addition for the memory mapping
needed to keep these two pieces working together well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index 0000000..4889f59
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
+      This describes some common memory reservations:
+
+         acpi-reclaim: Contains ACPI tables; memory may be reclaimed when the
+           tables are no-longer needed
+         acpi-nvs: Contains ACPI Non-volatile-storage data; memory may be
+           reclaimed when the tables are no-longer needed
+         boot-code: Contains code used for booting; memory may be reclaimed by
+           the OS when it is running
+         boot-code: Contains data used for booting; memory may be reclaimed by
+           the OS when it is running
+         runtime-code: Contains code used for interacting with the system when
+           running; memory may be reclaimed if this code is not called
+         runtime-data: Contains data used for interacting with the system when
+           running; memory may be reclaimed if the runtime code is not used
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
2.42.0.283.g2d96d420d3-goog

