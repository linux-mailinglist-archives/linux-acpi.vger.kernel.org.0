Return-Path: <linux-acpi+bounces-302-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C217B3FF3
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 355E0281C9F
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA70BA37
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 10:30:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D917ED
	for <linux-acpi@vger.kernel.org>; Sat, 30 Sep 2023 09:04:34 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86201AE;
	Sat, 30 Sep 2023 02:04:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso238624431fa.0;
        Sat, 30 Sep 2023 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696064670; x=1696669470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjvj3wwShKStYd4Opu01OitMSwv/jQBV1HVJIIxyVUM=;
        b=beH8rtf7kTT7aIYMGwheQWuq7U+n/9UmvTUTYZFjLYo58+SyiJxXjWyqpudOgyB9sK
         SXal8G0mCP7XZfawav/77ZJbaU7lEAUMiCHFDS2MMsRLqfuUD+MLNEXOpkuRQ4MCYR40
         yRyLB8Okm+UczNgTajRjHTpAnKAFiGy7FhuIoI2uaswCnQ1QnCSscttPYQDHzamKi641
         K6HNsMv+ovZCDYrG69HOkNT6/Vfdppp4yFzaaAtf9IgrgfM+q+vpctQiVdYveW5qCBKp
         AAdhADqalXF6SjnLq2qw+f1FemPQAGux6Kb9E5L3kqaJASmKu1kVJF8bkpgngcN5c7cJ
         R2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696064670; x=1696669470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bjvj3wwShKStYd4Opu01OitMSwv/jQBV1HVJIIxyVUM=;
        b=Rf303UWMUIgr5GSst+Pzj20d3/FqWl8u0FVP4EyEuK/geE/BIMMulsK6mgvAHcre9M
         YXZYaMwCZrXjFk792nhEwdIVJbYwPRse6lYnlCLlu2mApwCVXq23FBa5OOrhr8/Fh/t3
         YuTsxupJ+T6kq0cVmj/K7RG7q5MCOUA9TePKf73NAud+1vu1t7JolIT2K4pShDpk702l
         4PDUL8iVL+z/QJTtHB7oGeCnem/It3KRCsRNy2YxY4c88XpWMNxE3F0L2aeAiFO0XACe
         kBn2/k4m9qVKauDtbkYG8wM4AmXCqVtBeXjGPuecDeVtyfnJ3fEmjVlNejXbz+6m0ABz
         Icaw==
X-Gm-Message-State: AOJu0YwWTpNsnNPZjExMgzbWV2LdncGkEv5c3ImQoK1VFrH8fE4ZIgdG
	bchofXLM8L+DaDWNZ24msknrpoqwk1LOmbes
X-Google-Smtp-Source: AGHT+IGLB/o73aeMnlP+QKIKo5OqXRMyYGy1lwRE+yEN/rDnqkzDuoH0Mk89vCSo4ScJfUw7KLY9Pw==
X-Received: by 2002:a2e:9856:0:b0:2bd:140c:6d0f with SMTP id e22-20020a2e9856000000b002bd140c6d0fmr5755544ljj.47.1696064669720;
        Sat, 30 Sep 2023 02:04:29 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id f4-20020a2e6a04000000b002b95eb96ab7sm4350164ljc.18.2023.09.30.02.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 02:04:29 -0700 (PDT)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/3] drivers: acpi: Remove parentheses where return value is not a function
Date: Sat, 30 Sep 2023 11:04:21 +0200
Message-Id: <20230930090421.35831-1-bergh.jonathan@gmail.com>
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

Fixed formatting issue where return value from a function is not a
function but was wrapped in parentheses, causing checkpatch to flag
an error.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/acpi/osl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 29e0005c30aa..dbbccb612277 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1578,7 +1578,7 @@ acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t **cache)
 acpi_status acpi_os_purge_cache(acpi_cache_t *cache)
 {
 	kmem_cache_shrink(cache);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -1597,7 +1597,7 @@ acpi_status acpi_os_purge_cache(acpi_cache_t *cache)
 acpi_status acpi_os_delete_cache(acpi_cache_t *cache)
 {
 	kmem_cache_destroy(cache);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -1617,7 +1617,7 @@ acpi_status acpi_os_delete_cache(acpi_cache_t *cache)
 acpi_status acpi_os_release_object(acpi_cache_t *cache, void *object)
 {
 	kmem_cache_free(cache, object);
-	return (AE_OK);
+	return AE_OK;
 }
 #endif
 
-- 
2.34.1


