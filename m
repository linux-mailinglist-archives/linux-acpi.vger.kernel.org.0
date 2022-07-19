Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29AB5798C0
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jul 2022 13:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiGSLuX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jul 2022 07:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiGSLuW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2022 07:50:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A4959B
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jul 2022 04:50:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g17so11732139plh.2
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jul 2022 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qafXaXkIM/uHsJQqJP5nDPOn9hfjFKGF8wnaV/Bkdes=;
        b=tusAWoyw3TsYqhLLXBcTMYpo1xp/IdnAPgB7Z1dyi9njONTu1eYg82N8fG1GIDEY5+
         ReXJ4EprggsoH0SPnIRE26aQEu8Ve8VOmPz2M/hpYAGDWS5TauLNj3v9BXFG8lAd28tJ
         z4LYvPRw650AAxwx5IHSEiYYpk/anDTIJ6hhSYVZdu2JJXvW8ZtS8uc8XE+SsCpqeOik
         nRnKbqUC3x+qHxLZ/jIW6nVT/3Jbzsod7fr5cq9YW3NGz/Xrv6o4lppbwQzbV4zC27N3
         GDeLdI9nuXOJRYdsAU7LBQCceS/S5BTGyN1QCreL1KcWgNRXX2LIar+oHPfqmFX6qwNX
         jwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qafXaXkIM/uHsJQqJP5nDPOn9hfjFKGF8wnaV/Bkdes=;
        b=mS92LcTCK1ObH/UFOVUv+SmdVEJNwBHJr38D9R+EEtzHtOCkC8Mal0VM0J19IQKiau
         PW5PlQmp+ZmBvpicLWDM1WJcGX8k9HYcmyCZq/xduqrG7NJWUo+FqwzNOkO8k30AyrK3
         mII/trfjlDkvlg3iOBzkpk+AJ+kaUwzm9T7NpKd6pMPYh6u/UIKE9XjYlo996J4y8VBh
         Lep9gK5KhlYacAJmiZog+1AzeZiDQNseYaQ4d46poLuUDlIoBNuDqyvjpoVGzwAtDMN9
         ilf4HZoFUE+A8VdtpAY6M9ahNKbGo4dPAH00a7dVogoBi5ItAFXsTshJ3f4nNy6Z19uu
         Wohw==
X-Gm-Message-State: AJIora/PSa4VbXfEzIhr6oFh1KeDUPIWvHk/aIQiFm/nIr8qqXigL6de
        F/6IU2gw59SC/9s9QWWxBB94fQ==
X-Google-Smtp-Source: AGRyM1uLQnncqRk8F0w7HNZ+X3qpphGJmFRIOJpOFskO1lX2aBT2K5cte86IfEZhj9Rm4LxS3RDJYw==
X-Received: by 2002:a17:902:aa82:b0:16c:4bee:1f90 with SMTP id d2-20020a170902aa8200b0016c4bee1f90mr33458243plr.69.1658231420542;
        Tue, 19 Jul 2022 04:50:20 -0700 (PDT)
Received: from n37-155-090.byted.org. ([121.30.179.126])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b0016be4d78792sm11372606plh.257.2022.07.19.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:50:19 -0700 (PDT)
From:   Qifu Zhang <zhangqifu@bytedance.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, jarkko@kernel.org, tony.luck@intel.com,
        dave.hansen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qifu Zhang <zhangqifu@bytedance.com>
Subject: [PATCH] Documentation: ACPI: EINJ: Fix obsolete example
Date:   Tue, 19 Jul 2022 19:50:13 +0800
Message-Id: <20220719115013.744751-1-zhangqifu@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), the EINJ debugfs interface no longer accepts
negative values as input. Attempt to do so will result in EINVAL.

Signed-off-by: Qifu Zhang <zhangqifu@bytedance.com>
---
 Documentation/firmware-guide/acpi/apei/einj.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index 55e2331a6438..d6b61d22f525 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -168,7 +168,7 @@ An error injection example::
   0x00000008	Memory Correctable
   0x00000010	Memory Uncorrectable non-fatal
   # echo 0x12345000 > param1		# Set memory address for injection
-  # echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
+  # echo 0xfffffffffffff000 > param2		# Mask - anywhere in this page
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
-- 
2.20.1

