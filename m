Return-Path: <linux-acpi+bounces-770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897ED7D05D0
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 02:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B933C1C20AD9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39E80E
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOrye6cU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58F4292A
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 22:56:02 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5C98
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 15:56:01 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b7bf1c206fso123691a12.2
        for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 15:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697756160; x=1698360960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eogj0ZIYp5lAoNttJXlBaUD0mycxslTcJprZ08tb/AA=;
        b=cOrye6cUwi56uGYwBJAsKp3u3jdZAFWLYXaYkW+4+AOrGEJi/f2XWbiU9bRh2isT4u
         MRaqGheXLPfHrnwYe1fEIzMFJ1YR6DMBm5BgKTwouefjkrGesn4onVEnf41k0vuv883j
         y2Kbdu3ga7FJlSDUO+vSETojtxNGDsfniMG8W1e4QIcRaO3pj1drao8MYHtKynR4GSmx
         1KIINnCPCwtMP6ASjCTNJZkXjsG8nMnjT/3j2m4Anwpi+g1zOzK/pDhz3kyhGzkLkdnj
         hV0Rq3ApPBytBnM3fnBMNfHV96By0cgT/PiYOPR4vzEW0yMaMl6fUNmYK8wkBR5AhBxN
         taWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756160; x=1698360960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eogj0ZIYp5lAoNttJXlBaUD0mycxslTcJprZ08tb/AA=;
        b=jcqUpbFLR3yFKfPVjVA8W36FK67fpxKcp9ixbU4eJ+i2YTO20UBD9f/TskxtU9xbON
         cTL14rrz+mqa6yAdc+Nus4Xt55m1VaFa4p93hE9+sevedm7MyIWX5EthDQa+k9Oz3sYu
         2RzcZbFwbNhjaLmQgwbnrREm6aSlZ8wUWcU/7+dC1hLaxdUQGzySMfKSoKWRB1HS4s2M
         V5aUv6ezknSwrmLC4/qgcrj99G+kk7uvZmNNSO+lIklh2gjivyhjg1979xkwe+qAp+r9
         ejLGvyfGDNyqNRdjDk0QOQ+lxIMDaiqpdAwPqnCUaZUDBOtN5caFHHJLvKV6Nv+AO+k1
         lJZg==
X-Gm-Message-State: AOJu0YxOEF3y30Ol1Xqjp2pe72e8UHO83pMwV0aK+Bs3+Z+gAchTQTvj
	DIiRlhW9svlhieqlE0HsHEgKFl6TJ7XyIWsKmA==
X-Google-Smtp-Source: AGHT+IGqB8ePfZRfnc6eFr02PfyeXAhmA4mOPwWQgXiGl4wPSgLLHP9PZwQt6gAmJ10vDpPWoSqXiU8o2V125OsO1g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6871:330c:b0:1e9:9b7f:a04f with
 SMTP id nf12-20020a056871330c00b001e99b7fa04fmr107113oac.6.1697755678870;
 Thu, 19 Oct 2023 15:47:58 -0700 (PDT)
Date: Thu, 19 Oct 2023 22:47:58 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB2yMWUC/x2NMQ6DMAwAv4I81xIJYaBfqTqA4xYvwbIrVIT4O
 4HhhlvudnA2YYdns4PxKi5LqRIeDdA8li+j5OoQ29iFNgzoPyukG2aTlc1Ri16MpIK0GCNhn/I wUYopdQw1pMYf+d+T1/s4Tp7JueN0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697755678; l=2211;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=C6lzZd1cxmbbPTc6wyYJ22pu7h/P2ENQ5AFRalgiPpo=; b=ge/iP8gZqQZ3kKz0nqiurxoo3s00oFATnxJET06+lyq2Es+o9MhT5CXAqjQ4A8jC+RVZcccT+
 yv2TMnhmGYPBHTrmirBrNyBkwKZfL1Jzoy9d6rUK4WbdCBk0xS8hzEK
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>
Subject: [PATCH] ACPI: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We know dev->name should be NUL-terminated based on the presence of a
manual NUL-byte assignment.

NUL-padding is not required as dev is already zero-allocated which
renders any further NUL-byte assignments redundant:
dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid); --->
  dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding. This simplifies the code and makes
the intent/behavior more obvious.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/pnp/pnpacpi/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 6ab272c84b7b..a0927081a003 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -250,12 +250,9 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 		dev->capabilities |= PNP_DISABLE;
 
 	if (strlen(acpi_device_name(device)))
-		strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
+		strscpy(dev->name, acpi_device_name(device), sizeof(dev->name));
 	else
-		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
-
-	/* Handle possible string truncation */
-	dev->name[sizeof(dev->name) - 1] = '\0';
+		strscpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
 
 	if (dev->active)
 		pnpacpi_parse_allocated_resource(dev);

---
base-commit: dab3e01664eaddae965699f1fec776609db0ea9d
change-id: 20231019-strncpy-drivers-pnp-pnpacpi-core-c-54d9bc42443e

Best regards,
--
Justin Stitt <justinstitt@google.com>


