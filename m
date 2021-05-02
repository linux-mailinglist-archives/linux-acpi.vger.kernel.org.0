Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644C2370E30
	for <lists+linux-acpi@lfdr.de>; Sun,  2 May 2021 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhEBRY2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 May 2021 13:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhEBRY2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 May 2021 13:24:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A769C06174A
        for <linux-acpi@vger.kernel.org>; Sun,  2 May 2021 10:23:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g24so948645pji.4
        for <linux-acpi@vger.kernel.org>; Sun, 02 May 2021 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXTjGTOlTTY9sdxkzSR6emINpwnzr9PglCQwV2S6Ekc=;
        b=QhgvJS00fKUbeIpw5a18d7n5cD8P3AutRHRozqhyJavbukgTGcA//k5ASTywlswM6l
         PzhxTQfSYthv/HiWd1FtqtdwZxaN29cdGLx22iT1pxob+QlyoWeVGIzcZW25grx7OhEY
         03BvhqeOETO/20VQ94efc5HStWeKQYBrDJza4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXTjGTOlTTY9sdxkzSR6emINpwnzr9PglCQwV2S6Ekc=;
        b=U4vNlOsGvdG+qOG0eNvnygiIK885b0yBjWS570DwBFARalmV8FH9xkgiwrAfSsaBPm
         lJCsQDo5fPhCq0ybVYKDB5RSGGBa7G4nlqcYYWQXTcpETikWbsSSJJdUNx1LRX7TbRO9
         9DPE6aNp9AGLw/O4P2yQdsOiILG9txPDl5J84tgEsHf1N4HNf63fw2dPJqAaC3p/lHh5
         X0S/0vjjjzOapDrM3NDUKjLzhTL5M0jBwaa8zkQ/Xh4S8haZTbaypYKYFlln5Q3iJ0lb
         P8h4rGbwWoPm6M8rrZuyTq96itxn5o+Gy6UiVnj4sx34+gQxTPHeWuXrLTshL2wQq4mS
         olGw==
X-Gm-Message-State: AOAM5325i9ZJXa0rfXZ8J1ys/+2b+2J14l5+Se8oHQCugbwRku8qwG4T
        +sKLPiA1CYJXqB1VFni01Zu7Nw==
X-Google-Smtp-Source: ABdhPJxgpxHrWH1Z1a42UhZH8ooTPM0N+5pppYaK/MBCvnrvyHIGwBctabZ+DdUs4Ow8vICkur1gFg==
X-Received: by 2002:a17:902:e892:b029:ec:d257:b8a2 with SMTP id w18-20020a170902e892b02900ecd257b8a2mr16321769plg.15.1619976216172;
        Sun, 02 May 2021 10:23:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x23sm6851493pfc.170.2021.05.02.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 10:23:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
Date:   Sun,  2 May 2021 10:23:26 -0700
Message-Id: <20210502172326.2060025-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=27f4a3882208c0c7ab311bccbc7938a98215ce1b; i=4pHPPkCLiO0B5jX/lC0oWvEOjAppjon3wDcV95JIlCY=; m=B7t9QWkqpLbwV/hn+i+5AcQpHIFvut5e6PdfyOfbBvo=; p=dnBvSkSfZUmrGRocFe6rzb+j1MQ4jwUfNvP+Dje0+G8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCO4A0ACgkQiXL039xtwCbSqBAAlxq 1U9qI6T30iKOG2xGDH6nuqZSQKjgVrY89a0xtu6Cf+Dl0Tw3HvrLsLmIKppF2y8P02kh8Qgb/0wXK napAXAiwy1VvVuSICbEqtK9UGrbO3PDUPo8hLoOOsGckRVlHNjwk4af++Hri0QWu40SIGBo+AuRTT 8d08tNrswsng7ixEzO13C/rJ6iyFVwp4dF2HTc+VnyHyVKtuhtrZ12jwUuAZ5vOi//HeOGJbQ7HUT tA3IucfVq7xuyVpkREICcQuzzb+pUBwJMCm+4v384J4C0LjQk01f7FSWjpLRHot3UaredQDChe8rk 21Nw3fRd41kFMIzNXDqJyDm2Pd6+jS2r3tkj/493qHHPJGbXdE5L8V8Y6bas1LAuAUNPCtTDCfTW8 MBPkzb1Yrv6atCaG9wU4hD0Q/NrsmMtN/SViur7A/sw0sg161+DWGelyxWjxZHZ+0WnlSMeN848Gb 938HJXrAEI9vfk7ROWV5YbKNDT8onhvS413+uJBGx/I74S3WHG4bUNpYZPObNhETd2F3b9q4YHt0r TCh6wZ7jgpqXwNPQMsPhpoA2z0rKjOgP6zBj2Nyhza1Bw5Hgo8E7lSZ1XfuTsHAynEVf/hiHYMTn1 IMg9Otsq7NFqi7XNusFlVHbR4MbeBlFe2mAT+dB9/IEwm1/fg8mrNa1nQSmDGDEs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.

While /sys/kernel/debug/acpi/custom_method is already a privileged-only
API providing proxied arbitrary write access to kernel memory[1][2],
with existing race conditions[3] in buffer allocation and use that could
lead to memory leaks and use-after-free conditions, the above commit
appears to accidentally make the use-after-free conditions even easier
to accomplish. ("buf" is a global variable and prior kfree()s would set
buf back to NULL.)

This entire interface needs to be reworked (if not entirely removed).

[1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
[2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
[3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/

Cc: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/custom_method.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 7b54dc95d36b..36d95a02cd30 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -53,10 +53,8 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	if ((*ppos > max_size) ||
 	    (*ppos + count > max_size) ||
 	    (*ppos + count < count) ||
-	    (count > uncopied_bytes)) {
-		kfree(buf);
+	    (count > uncopied_bytes))
 		return -EINVAL;
-	}
 
 	if (copy_from_user(buf + (*ppos), user_buf, count)) {
 		kfree(buf);
@@ -76,7 +74,6 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
-	kfree(buf);
 	return count;
 }
 
-- 
2.25.1

