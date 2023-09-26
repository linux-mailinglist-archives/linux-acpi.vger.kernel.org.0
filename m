Return-Path: <linux-acpi+bounces-161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552237AF538
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 073482835D5
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424A4A53F
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344929432
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 19:42:49 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CFADE
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso285351739f.2
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695757367; x=1696362167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylRB+o0Qkrun1yi4fSnYM174Q1wG3Ph+hurLuy8H7Hg=;
        b=TWm/VCEj9si6AjdAXsmNB/RbeRtOrLatEwkYKR+e8ab+fZZVdF0Ze8ewRdwZlSfYRk
         U3mS12hlGML+XU+1lFTvG8devxxWKU20JxkERQzwOJ5e8rm8r+9e4VuSuc2+soiuCFt7
         8rowKY81p6mGn+BYqQklLUGGovkJ/CPxcitoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757367; x=1696362167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylRB+o0Qkrun1yi4fSnYM174Q1wG3Ph+hurLuy8H7Hg=;
        b=Rum37LmmUkY+Om0bZYe6r8NqAb+qm+fdf7M76oVP9tUQti5UyS9QHVOU6hECjvRm3b
         bmYkfYsVarKmEKTKW/qC/WS2S4oNBHN7b0TbcCl8wAPbap6Q8OMRK1ScbsV5uARiA+v/
         GqNnsDw2/p/z+SeqyJbGm5KRBh/i/muzsPK/F6nB2iQUv8X2iNv2cHPESsRM4pIGTtN6
         /7xBIDUWIua2jTGKAr6woiu15IueaR9BfCtY2aZh7hAxQ1QH1N9HjCUI0unkxzGWnDKv
         JxVcAClS8KgTv43gX8jXPF40bb09xrIJbHcets/6qF6ooSHquhJYrOIzM1TOiUBl+zzm
         tL0A==
X-Gm-Message-State: AOJu0YySvNuMMra88lcWbItal0rNITjkz6gVG8i3bu1Hxs3KisbVUMF+
	SGeNp68PT8Ea8oJRr4I0VXkKIg==
X-Google-Smtp-Source: AGHT+IFzCUeJ4+/f6cMQn/wpsFZyt5uO+MfysuCHFTtVfIOOSW4N6mcQ3ugSwBAMbKLYPMLI3Tso2g==
X-Received: by 2002:a05:6e02:1d0c:b0:351:50f1:1f98 with SMTP id i12-20020a056e021d0c00b0035150f11f98mr3806231ila.32.1695757367326;
        Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1da0:a3ce:7aae:e9fa])
        by smtp.gmail.com with ESMTPSA id g6-20020a056e02130600b0035134f1a240sm1961451ilr.86.2023.09.26.12.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
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
Subject: [PATCH v7 1/2] schemas: memory: Add ECC properties
Date: Tue, 26 Sep 2023 13:42:38 -0600
Message-ID: <20230926194242.2732127-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some memories provide ECC detection and/or correction. For software which
wants to check memory, it is helpful to see which regions provide this
feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Drop unnecessary |
- Add a blank line between properties

Changes in v6:
- Use a number of bits instead of a string property
- Fix inidcates typo

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..b3bf3c9 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -35,6 +35,19 @@ patternProperties:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
 
+      ecc-detection-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be detected and reported by the Error-Correction Code (ECC) memory
+          subsystem (typically 0, 1 or 2).
+
+      ecc-correction-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be corrected by the Error-Correction Code (ECC) memory subsystem
+          (typically 0, 1 or 2).
 
     required:
       - device_type
-- 
2.42.0.515.g380fc7ccd1-goog


