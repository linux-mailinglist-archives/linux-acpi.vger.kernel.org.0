Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51757349DA3
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Mar 2021 01:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCZAVl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 20:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCZAVi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Mar 2021 20:21:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B21C06174A;
        Thu, 25 Mar 2021 17:21:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c6so3168732qtc.1;
        Thu, 25 Mar 2021 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZP7LCr6VFQMI1nlD6D3G/vs5KL0ERu/J6Ru13m29K0=;
        b=ttFi+KWZgUPlYtGrdoYKATIk26OpABOssyChmT8ceJps9SccZkwv/xojr++WSmhIx9
         XY/mIdo2KMnBy+sATKnfjFDjR/coF0a6cIcmaxzS9N0Tm7ZPUXebJUZrMyimR0pi9kpr
         Ybxo96gl8L0cT5hUgBKT63j3rXljgPdUGqsPq/P8grOtWxnwjMfMj87UylOb2f9PTDa7
         8FKtGhT7BbX6XEraIJRuIBWeLIyLjgkI2XulaBT3Hict3d23bd7iWTjr82AFthwOnMpG
         ntjudQFpavuMAvHVNI9M2MjYlCJU5ztF1bpMFIL1bAtjR9TOvpDpw1OEKJEn+6dKRqPQ
         CKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZP7LCr6VFQMI1nlD6D3G/vs5KL0ERu/J6Ru13m29K0=;
        b=BBzCYkYlsRws3Cd0G+7MZDfPvSnVcvipMxTYtSg27yk5vzFNVc8TzRBpixpxguPbNl
         O3PRoLsmmaaQQyi+FKd5lbXu6GVjrSmMEqF4J8zy9QHtyy0IULAbH9eilnEt0oEyEVDD
         D3F0c7mquac059ZE8vmCoXbvbK6XJN6XPmSb+weiRjfpndALc6Mkkiy05rT6sLqtsps3
         iN/dHWjQRVSUvgGTUWJBXGonr4Ox+v8jAB9qxk0SFvzjxoummqsZ0KJNsqsnBcN4JYaR
         W+BSAgmnpF0elMuvKxaoOMcUn/BIvwStCF6XM2dSUcqF9O+QwvN1E3JVVo2j5FnFrJ65
         ePqg==
X-Gm-Message-State: AOAM532YP+GOBCLVFhta9pTPa2r6w2E9/4UPNFV7CMESdLsFhOT58zRB
        M5+nXmD08YwEM86SdK7zfZM=
X-Google-Smtp-Source: ABdhPJxcbdhKCAphIIz27zZAygifOWwj5YXoJTYJa2MVFlbCvmHuElrAfdYX4+I8VJlXSbHxi1/IeA==
X-Received: by 2002:ac8:698f:: with SMTP id o15mr10551740qtq.39.1616718095835;
        Thu, 25 Mar 2021 17:21:35 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id t24sm4777234qto.23.2021.03.25.17.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:21:35 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] ACPICA: Fix a typo
Date:   Fri, 26 Mar 2021 05:49:22 +0530
Message-Id: <20210326001922.4767-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


s/optimzation/optimization/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/acpi/acoutput.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 1538a6853822..1b4c45815695 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -362,7 +362,7 @@
  *
  * A less-safe version of the macros is provided for optional use if the
  * compiler uses excessive CPU stack (for example, this may happen in the
- * debug case if code optimzation is disabled.)
+ * debug case if code optimization is disabled.)
  */

 /* Exit trace helper macro */
--
2.26.2

