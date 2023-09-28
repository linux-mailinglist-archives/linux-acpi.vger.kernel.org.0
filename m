Return-Path: <linux-acpi+bounces-277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39207B2874
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 00:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 96E0228321C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55719465
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022C9CA6A
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 21:48:16 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190CF1A1;
	Thu, 28 Sep 2023 14:48:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so21295054e87.1;
        Thu, 28 Sep 2023 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695937692; x=1696542492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHFjIMlDbV5kSmnyZox+gz39Xi2GjyZylQuebCzLYHE=;
        b=DCU1e3zP+IcFciXYKaLxq660eJI5QYAysG/L38frUwg3uk6Kw4MDvZ6W58hZCZXqZg
         LVj9uwskdRZPaPO0fxeROUXN9vY9jlULMxS1o/0RAQEPtO7KvKi7kfT35DjNY3MKT1jQ
         gbEB6wmtc/pSukR3V4w7LK0RcK0XUFsrvxRI8+DU9IpxIHgIlfPRWf/psE+WTTLlH+pg
         v7doHc/8VGF/IH1g/mIQPY52T2L/JHCAm94OUtuR4ckipNGG3B2kdu+GFS+S46iz1opv
         k+x6tiQCe4XBwQ0TLQVZbmHOs7nTBwC/kCrmedjHUhQoSNEII+auCbx5Xd/VihzXXuF0
         vOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937692; x=1696542492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHFjIMlDbV5kSmnyZox+gz39Xi2GjyZylQuebCzLYHE=;
        b=JSEQX5HFqm1SK9KJyp46vHNgmh1GxUxj7A6J/hpwo797Bkws/FtPoZLcFzZqB3SmFn
         uUZLu5tBBjfeKuEKs3mvU/4GAVgmAq9AqjoGKezt0EHTjO9u/1wVIMdTczFGvUYmY58S
         sXZvYbp572hBsbqNz5rFtrj+wngGhbahFuBJrrY5y3NbcXE0FqmCWKILNHxwHPzP3ayQ
         lSDGO8x+KGK3AN620vYUhtLVa8kYZXZi5RQvaQnhpAYS0y/iTps5rwsOCh7fER62UJzB
         w/Ec+VAT9VuT8+SYw1bFTrlj9WqKxsbZABwwlXvIZV7ZlBot/NPmr2odvIpjZstoi4CJ
         mR2w==
X-Gm-Message-State: AOJu0YxXBh/5tudx59x4jQ77XAPW+EcJDmc/z+KCtmJLJOuf9tJbpKrI
	z0TPKc02vH05phFUotf+MpaUYknqS3E1jQ==
X-Google-Smtp-Source: AGHT+IG+n6HpGdHLmIq/ZZ3U2mK8r7GpAKB/WgnmRMGFrG0wFGGhc5jQHmSGVPZDeV5lpSj7yE6GFA==
X-Received: by 2002:ac2:4e85:0:b0:4fe:2d93:2b50 with SMTP id o5-20020ac24e85000000b004fe2d932b50mr1942084lfr.31.1695937691961;
        Thu, 28 Sep 2023 14:48:11 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056512096200b00503189d8b8csm3246714lft.198.2023.09.28.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:48:11 -0700 (PDT)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: lenb@kernel.org,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/2] drivers: acpi: Fix label indentation and leading comma formatting issues
Date: Thu, 28 Sep 2023 23:48:07 +0200
Message-Id: <20230928214807.43409-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fixed the following formatting issues flagged by checkpatch
in utils.c:
 * Remove incorrect indentation before goto label
 * Remove whitespace ahead of comma in parameter list

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/acpi/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 2ea14648a661..300646bf8ba7 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -399,7 +399,7 @@ acpi_evaluate_reference(acpi_handle handle,
 		acpi_handle_debug(list->handles[i], "Found in reference list\n");
 	}
 
-      end:
+end:
 	if (ACPI_FAILURE(status)) {
 		list->count = 0;
 		//kfree(list->handles);
@@ -523,7 +523,7 @@ acpi_handle_printk(const char *level, acpi_handle handle, const char *fmt, ...)
 	vaf.va = &args;
 
 	path = acpi_handle_path(handle);
-	printk("%sACPI: %s: %pV", level, path ? path : "<n/a>" , &vaf);
+	printk("%sACPI: %s: %pV", level, path ? path : "<n/a>", &vaf);
 
 	va_end(args);
 	kfree(path);
-- 
2.34.1


