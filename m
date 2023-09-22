Return-Path: <linux-acpi+bounces-56-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D3F7AB933
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7A73A282257
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B245F63
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 18:34:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27F4447E
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 17:53:40 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01831FE7
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 10:53:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fe2470d81so2274545b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405197; x=1696009997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcpELJ6V4gzjq4olnmy80BvH10zkQAPgPKh3TzKHvh0=;
        b=LbbO0vAmasDHpCq/Xn4bin2MV97b+TsooKMyPxpB4qaWuEhipj8jE8kZ7cUvnKD+gW
         I2Fp30nUBbTSCpG9gGiBNsLpHlP05LXOSSZUGpSVLBYBcJCZTi14tVw3YcJbwFQWBump
         jgnE3fp4wfXuyB7i6dtstsnKOXqgdX5pwHIAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405197; x=1696009997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcpELJ6V4gzjq4olnmy80BvH10zkQAPgPKh3TzKHvh0=;
        b=duVcV3NlxUUTwMpe1TeQ2WIw/YQURGmg40vA6TslcH60cJH4f7lDnIhCsa+qiXA3LG
         rqr565plPd0vFh1iW0yTQLX985B3JgqZdWKmBDlMv2h/sK1oNKAeE/w4HKfF3dop4yOH
         tNIh/vM6P13y+3zEA+1DVG3O7BdEpgZSTA53eN3XOQ4JDzGyCkaet3b+pSnmWzowOtw9
         mwTGmpElmeziiBrgjmKaL3poowFDQa//XFR3alioBKMS+jJsom7XeUC++XcSa868hmGN
         +wvQtJDjSTayrWRQpRUQUOIEebsqEsR7n1VU8ceYU3RjI8ipuT5GzTGgVCahKXs3rvhW
         ZAGQ==
X-Gm-Message-State: AOJu0YxZy4bKQzEN/D+f8Zc5pC+Fkgt4E1Qb+hUbHT77S6qKGO8P0oT3
	TZx7vlFfTPr6yYvX5HC9aeL9TA==
X-Google-Smtp-Source: AGHT+IFVTmxlRYKWN+wwokRfxFr+8HhULrMeZ9/GnCZdsqlYKzOrL05eKg41orjRO2IX+YFvbyW4rA==
X-Received: by 2002:a05:6a00:1a91:b0:68f:c078:b0b6 with SMTP id e17-20020a056a001a9100b0068fc078b0b6mr145564pfv.10.1695405197151;
        Fri, 22 Sep 2023 10:53:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b0068842ebfd10sm3464677pfa.160.2023.09.22.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ACPI: PRM: Annotate struct prm_module_info with __counted_by
Date: Fri, 22 Sep 2023 10:53:15 -0700
Message-Id: <20230922175315.work.877-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4xy8hh2710nXi/x0gtI622DpqaNgXiLZ0l6ncbr16B8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSLMgKD0QiDVZgL6y9jKTQlJU/qmTzhAycS2
 CXqRf8eZcmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UiwAKCRCJcvTf3G3A
 Jv0yD/wMjoy6/sOr84h0xOw027syYiDYBNxQYJXRgeNq6pyUAb+CGO4TxgUm+9Dv9d9mCnhnKUC
 DpykKBQVPOPdvKCSfPDozBfQ+blTyrqhnHvpasy/qgBC1fLy+141QegfPqrxT+lXJiKMHrWDCEQ
 5v7B0cmKNFaCTcughRb2/odgzuA8p5b6cdZIInVetgDvroCqyOIw1qqGOJn/lQnmt+NapjFzzBw
 zWLUiUSZOMuMwa46HNlhXJmtg0N/zn9wUSm5U4O6WhitjGPMiJJ+0XKk+RHP4hGFFvs81iGkATN
 cc4iHAJwf3hfhD5FjxvMRRr4VFQIZ2nd2pBhp4icvLDzdtX3ckojAohlPKZRWLlgxZ5eAxvM6Yc
 OlqBwoWG9WtFP6gcvpd/v9jBdX59+KIPbRTIfIJC1A7mgwJGQyu+/w1Ropu8rKBmPVK/Mhp1XOR
 mY57DmUYN0tbmxiex9xY2IZN4wlgBV8MZ+sAB+gXU4l88bO6EusW5f3/hiiyDSQbO3n+FKUC2pE
 T4zKnz4ixMzPIOvkZ8w78JZfp4py1F6WM4EcmZ0wjopqxsl05/Wo/EJWs0eaQrz9tkefilKp40u
 ag8fUhMO4G2mHw6XsNzjs3t76z/LKhHrL6L4o7KBOT3pc1WMpEdxoRxJyFyFahBFmkB4gwPj8lm
 wK+Uws8 mmOV0DRg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct prm_module_info.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/prmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 7020584096bf..c78453c74ef5 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -69,7 +69,7 @@ struct prm_module_info {
 	bool updatable;
 
 	struct list_head module_list;
-	struct prm_handler_info handlers[];
+	struct prm_handler_info handlers[] __counted_by(handler_count);
 };
 
 static u64 efi_pa_va_lookup(u64 pa)
-- 
2.34.1


