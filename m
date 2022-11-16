Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DDC62C264
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 16:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKPPXE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 10:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiKPPXC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 10:23:02 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676514B9AA
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 07:23:01 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id bp12so9279826ilb.9
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixv3Fmx1mnew0WeMfI1+VxxOz2mqpaE/UA185d2bGDg=;
        b=Wgmy6ylQ7twJ7OvN1+vXvfWhy99X1ngOvzqefyA2DCYaaIKA6BBjvEYmD9H7qNLhCU
         m5lse8o672fAKzs5LjJzSE1O/zlon7XRT6St9bECgOhbBAeqhavtH/v5us4idJACpXO0
         kSuLQDPwt2n2VfOozwNXpcuIQi7VBuTYD1kQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ixv3Fmx1mnew0WeMfI1+VxxOz2mqpaE/UA185d2bGDg=;
        b=PU+mb6V6XFlIUTYlD97dmAX3yNrzWgnxRTArhgKe0NFmuDg7wWTdkiP1gA4KrKQrIz
         4chahgvBqeaapLdlalkQ/ydft14UD/aDZ9CtkWcVjDmZns9Y8ger4xwdenc/WZfVHsHw
         pN0bAMpH1v0cRSP3H+m/24QfZ+uoBgKECdIgh5vOqNjZetkVWt6jFJfWyLW41UIK6LtU
         hHURi6pR9P7Fm4EGSfYiJeKuxPrvfT29xIKKi3hMNCgVkMabwKwnfK+kI5P1IJvfivWn
         DVHjxq3Zuutk8nh5/ynzB10g32JZHaUYKPU48DqfaOi/iVuLkr1Bk4ZuXlcxV3ewmiVB
         qtCQ==
X-Gm-Message-State: ANoB5pncRopuL+oqbd3t0HhHmlZScTfinIYKx4BmIdXaKIXlUK5mVFh5
        YAFAbaShIW77BsxTcou+hrH/NQ==
X-Google-Smtp-Source: AA0mqf4kUYHmzbxFG5NK2C6XJVgFrboMfZeb8vbobAWQVXewEuvYjYC+DduuZAi40KT0Ay5mu312sA==
X-Received: by 2002:a92:c889:0:b0:2fd:1880:7f6e with SMTP id w9-20020a92c889000000b002fd18807f6emr10672589ilo.227.1668612180698;
        Wed, 16 Nov 2022 07:23:00 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r4-20020a92c5a4000000b002fc681a6ad8sm6323228ilt.78.2022.11.16.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:23:00 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: Fix sprintf() INT_MAX -Wformat-truncation= warn
Date:   Wed, 16 Nov 2022 08:22:58 -0700
Message-Id: <20221116152258.28772-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

utprint module is included in tools/acpidump and when acpidump is built,
the following warning occurs.

 CC       tools/acpidump/utprint.o
/usr/include/x86_64-linux-gnu/bits/stdio2.h: In function ‘sprintf’:
../../../../../drivers/acpi/acpica/utprint.c:602:18: warning: specified bound 4294901760 exceeds ‘INT_MAX’ [-Wformat-truncation=]
  602 |         length = vsnprintf(string, ACPI_UINT32_MAX-ACPI_UINT16_MAX,
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  603 |                         format, args);
      |                         ~~~~~~~~~~~~~

Fix sprintf() to use ACPI_UINT32_MAX/2 to get rid of the truncate problem.
This change is inline other sprintf() implementations.

If using ACPI_UINT32_MAX is necessary in the kernel, acpidump might require
special case to get rid of this truncate problem.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpica/utprint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index d5aa2109847f..02cff16c8f77 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -599,7 +599,7 @@ int sprintf(char *string, const char *format, ...)
 	int length;
 
 	va_start(args, format);
-	length = vsnprintf(string, ACPI_UINT32_MAX, format, args);
+	length = vsnprintf(string, ACPI_UINT32_MAX/2, format, args);
 	va_end(args);
 
 	return (length);
-- 
2.34.1

