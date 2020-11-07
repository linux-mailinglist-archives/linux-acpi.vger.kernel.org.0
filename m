Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35D2AA3E2
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Nov 2020 09:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKGIeo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 Nov 2020 03:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgKGIeo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2020 03:34:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691BC0613D2
        for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2020 00:34:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q83so4521014ybq.17
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2020 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Z1peopUQ0CXJcnmm3Y1iXQw/XLE0Jshqm+lf7SqAfcA=;
        b=ljoBwQSYeuvhSAm05Tb8i9IjvzUi2f9jfINj73VmVc0oHO1K+tLPdjZfs/7fHxJ4Zg
         M4r7Y7HSH212OENIhVPZXNEZdCOhGxYuNm3F3hktzk1t64hSVnYEq72r1jbUYXQCigQZ
         FSHlH5bRWBwmHB7mM4WOK4FqSdiPP/l4x2SL+sGyMFNPuIEuuu1KtFpMoelEt96svhee
         q3OqD9B2RwumGf0HzoIJSID4KWqU8RZxG+Wb2TJ40/vyVlG4G3sNo/7FGU/wMlOWbvcA
         mQZk/looCHFKwfFM81fXiCVvxXSjBE8Dl82hNtH2o/Pk5QLkmWAmblmJYYM5HJgNJBfg
         4faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Z1peopUQ0CXJcnmm3Y1iXQw/XLE0Jshqm+lf7SqAfcA=;
        b=s/T3kBn2uoGV7CPhEDEdckWVDP5LoEepcT738+w4XXlEGZ7CgRBPvy5237koQYzBpN
         bJKpBoiK+sGvHyF2GqFgn8ObKS4YOQJWgu5AyPzl6i6hMUMJs9v1M/JQ9dcV68K0wVyz
         xzKwMo6nhPFKFPAvdNkE++kF0A2oLLXDB8EF6oLmcFt/2rruCwek895pMX550Pq034uR
         bQgzg2HD09m/Bu3yzHJ3ZYoy6kTLZ21bBq+j+b4i6MKc7Qa3Ubw6tEItvocfC3fzQYCF
         wMT/I6UjN11Orki23byf1bxfvf6Bm3iUcW1w4Y4U0+j2OkHbL7XJYpeQhXpDGKVMcpwl
         z8qA==
X-Gm-Message-State: AOAM5316KHVBpHUx71LM4ry9glexi1xRRt5Rnxftxk5VgvHDfR3vehJZ
        GnPX6OC1T9d2Ceb8+EvpGP2VMibbC2gBglun5L8=
X-Google-Smtp-Source: ABdhPJzjQVKzDOUD8t863oyfAR/B79KgYVM6UYlPHGButDCCQosno5E9YKHuoNnqgIbwcIAXjWrI2nd0GbIGErKO4xE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:ca8e:: with SMTP id
 a136mr7465151ybg.101.1604738081544; Sat, 07 Nov 2020 00:34:41 -0800 (PST)
Date:   Sat,  7 Nov 2020 00:34:31 -0800
Message-Id: <20201107083432.3175710-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] ACPI: GED: fix -Wformat
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Clang is more aggressive about -Wformat warnings when the format flag
specifies a type smaller than the parameter. It turns out that gsi is an
int. Fixes:

drivers/acpi/evged.c:105:48: warning: format specifies type 'unsigned
char' but the argument has type 'unsigned int' [-Wformat]
trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
                                            ^~~

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Fixes: commit ea6f3af4c5e6 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/acpi/evged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index b1a7f8d6965e..fe6b6792c8bb 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -101,7 +101,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 
 	switch (gsi) {
 	case 0 ... 255:
-		sprintf(ev_name, "_%c%02hhX",
+		sprintf(ev_name, "_%c%02X",
 			trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
 
 		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
-- 
2.29.2.222.g5d2a92d10f8-goog

