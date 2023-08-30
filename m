Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31A278E324
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Aug 2023 01:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbjH3XSg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Aug 2023 19:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjH3XSY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Aug 2023 19:18:24 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C2E40
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 16:18:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-792975085b2so11827239f.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693437496; x=1694042296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2cU6JGuZrguIyfLb09NlceqC/Y62AT/KhqZYbIbwU=;
        b=M942CseN4xXa7ivkN3BQ9ivaUDeaX11zck40TQgJZ7eE9yfunHmrPWwL7oyxKDAHF7
         0zvPrCY65S9NnUXzqwpP8gTCEo4NfmUuA6CkeJOSEttfV5HAiQlD4cW/tMxVKR5vWtaf
         u8QANLGfifUWO9TKEFik3R95p/ZOjrZqmdL+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437496; x=1694042296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2cU6JGuZrguIyfLb09NlceqC/Y62AT/KhqZYbIbwU=;
        b=cuNMHLILDby0YSZLglYnBhHPiAikrudU4+JTuFjVVxqCRDVNmvt2lHjcDCD992Hebb
         H0qRUAzbPe0zXUcTHGbR4HkuwiI40i5Bs8eCULlK6eGM/1+UdErY58N6aJ2JAsCxIqJL
         xotdOuhA7+uuM6OejH/oD47xxwXtUx+QdPRWuX4AOOukT0IQOsZ9rGhyOB32Sj4DeAS0
         3gkxYMl/f6Fqgqa6UdOuMXew6SPvpxT2IcqNxa1KTLPuqx9QYiS9CrAj54H5ljkHwSSS
         Owsu4qmdOq4Dof/9rrR6DTbj8SSlJl0+6N4mvstBW81Bmw10qcvtQnnNhGWoIlk7TcpQ
         udCw==
X-Gm-Message-State: AOJu0YykSQje0SlycizkSG3Qut+NoOHwca5O+bOiRv6+kcEtQ3zxkM8v
        /ft3k64uBC9PFYfXRd2Dm6CLtQ==
X-Google-Smtp-Source: AGHT+IEDA6Kz+88UsYqnGtgINRuvJ4OfWV7BCV1mSX3IDTB900P56/Cp3vrRoaq3PqkXR21lxfX66Q==
X-Received: by 2002:a6b:6112:0:b0:790:f733:2f9e with SMTP id v18-20020a6b6112000000b00790f7332f9emr3861880iob.13.1693437496510;
        Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
        by smtp.gmail.com with ESMTPSA id z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
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
Subject: [PATCH v5 4/4] memory: Add ECC properties
Date:   Wed, 30 Aug 2023 17:17:52 -0600
Message-ID: <20230830231758.2561402-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
References: <20230830231758.2561402-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some memories provide ECC detection and/or correction. For software which
wants to check memory, it is helpful to see which regions provide this
feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..944aa9f 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -34,7 +34,37 @@ patternProperties:
         description:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
+      ecc-detection:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - none
+          - single-bit
+          - multi-bit
+        description: |
+          If present, this inidcates the type of memory errors which can be
+          detected and reported by the Error-Correction Code (ECC) memory
+          subsystem:
 
+            none       - No error detection is possible
+            single-bit - Detects and reports single-bit ECC errors
+            multi-bit  - Detects and reports multiple-bit ECC errors
+
+          If not present, this is equivalent to 'none'.
+      ecc-correction:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - none
+          - single-bit
+          - multi-bit
+        description: |
+          If present, this inidcates the type of memory errors which can be
+          corrected by the Error-Correction Code (ECC) memory subsystem:
+
+            none       - No error correction is possible
+            single-bit - Corrects single-bit ECC errors
+            multi-bit  - Corrects multiple-bit ECC errors
+
+          If not present, this is equivalent to 'none'.
 
     required:
       - device_type
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

