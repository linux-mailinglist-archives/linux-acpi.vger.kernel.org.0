Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8C5797E0B
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbjIGVkY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 17:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbjIGVkV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 17:40:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E31BD2
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 14:40:17 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34ca1bcb48fso5502065ab.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694122817; x=1694727617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5daRRTdLNlkY+bK37VVR4v3WldsBabAY6GSX8MwLbs=;
        b=OyHT13bXBPctSXjNAl3OPDab+bC4pZcxqmpQSrIhCcnms4Q/6xZslH2mCIu18Y2B88
         gIMYlOKZwBIqs+J4s9Tuyg50W0gq1o4pGmgG22MfvpqiVVEVKZgUjI6NLELZGdbosczf
         6RoVT7/ihB0VLbbdHcFMBx14PUAZu1RMRWC/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122817; x=1694727617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5daRRTdLNlkY+bK37VVR4v3WldsBabAY6GSX8MwLbs=;
        b=OU0dk3U1eUZrVuHWwVbkBr/ZPsKM5xKWU0gKJjxnJe1121WCZ7frYuT7MW+4YaPjUY
         rp1Je/34TIkQS7ikKfkriMjnF6Io6AvGiFmwyGHl6wRX3ugwDjfnzehkGbxBMUPwp6/U
         vNfAuUH/s0fERgEewyKDY06k9fmawg40Pd2JtZYry6r3Rp2GjWbTOWfSO39iNfRBohyP
         9zykJ8xeqB4wvVFP3c1Xv5iljBFpO0dLLahsV4SQSkr4aF4weAlJkKac/HOgz6f6rcws
         XSSzDZp5JcgEUa1tVVIX3I43f97Lof0s2Z/WLMfVi5IvL20XxYF4SsNGd5N/ifJJO37X
         xzbw==
X-Gm-Message-State: AOJu0YxLgpxmSP6zFDgMnF+BloXXzwWbdzFU9egJPnXwAN3d3dGK2p/o
        MMMyww2qoOGx12wTV+fvkURZIg==
X-Google-Smtp-Source: AGHT+IEOo9i8+AV7SDMWoVUID/hLd8I+L2Kc4qthbyfM9QnHCrPKzqJp7ucAuhasGZkxp4mk+KwwGw==
X-Received: by 2002:a05:6e02:219b:b0:34a:c751:28ca with SMTP id j27-20020a056e02219b00b0034ac75128camr1176329ila.15.1694122817229;
        Thu, 07 Sep 2023 14:40:17 -0700 (PDT)
Received: from sjg1.lan (c-73-243-118-188.hsd1.co.comcast.net. [73.243.118.188])
        by smtp.gmail.com with ESMTPSA id x14-20020a92d30e000000b00348edca2abesm72006ila.47.2023.09.07.14.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 14:40:17 -0700 (PDT)
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
Subject: [PATCH v6 2/2] schemas: memory: Add ECC properties
Date:   Thu,  7 Sep 2023 15:40:11 -0600
Message-ID: <20230907214012.74978-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907214012.74978-1-sjg@chromium.org>
References: <20230907214012.74978-1-sjg@chromium.org>
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

Some memories provide ECC detection and/or correction. For software which
wants to check memory, it is helpful to see which regions provide this
feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v6:
- Use a number of bits instead of a string property
- Fix inidcates typo

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..1a48b1c 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -31,10 +31,21 @@ patternProperties:
 
       numa-node-id:
         $ref: types.yaml#/definitions/uint32
-        description:
+        description: |
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
-
+      ecc-detection-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be detected and reported by the Error-Correction Code (ECC) memory
+          subsystem (typically 0, 1 or 2).
+      ecc-correction-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be corrected by the Error-Correction Code (ECC) memory subsystem
+          (typically 0, 1 or 2).
 
     required:
       - device_type
-- 
2.42.0.283.g2d96d420d3-goog

