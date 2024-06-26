Return-Path: <linux-acpi+bounces-6630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A8918357
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F18B284E3A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D905E18732E;
	Wed, 26 Jun 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a65vOW3p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00A1849DB
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409883; cv=none; b=E6DZvFJnYYXZaKQR2vjlrzmn8mn+2V477E/rCLtzAYsZ9+k1KVXHXbmDJRH3UGpFmbA3T9fYs8RwIiSJfgwbP4WVyaZBDmQKveeVhGOM1HZIY/RHvflLrvqw4DJ0Q1cuwK4Dm6ZpdtUIyqlSRmeazyYI7e3wi7KuiG/bWT8tucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409883; c=relaxed/simple;
	bh=3ooqx0hGmFDZreTzc9ufv5w0ZvgD+eVwbGz3Trc8IU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsSK93MU8ABE/QnQf8IHTt+Y2F5k7bX4ZDkxn7mYik+uMifFuEZ3pIjxtei2fdQhFNvJoh+AQt9IfrSg26BDcq3Cqyi+Bw/Dy52Sv/EISnFSXwvcq3p3HlTyFmMjoe8IhDw0fG1f8YbHf2qu/Qjwn5XG3ZsPv2nK0WQo9TM+nFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a65vOW3p; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-700a6853664so2660719a34.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409881; x=1720014681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Fglha3zsHTnOmAct7LCmJkomz3+nHKecoSkTynKNvk=;
        b=a65vOW3py+Y/KV0bQnqAWeXnP5p45S6dnu6s+rQ95tli1XhOcwLmi9JjLPcm7lOTsx
         +StBBCKXyiGYeKM/LORwIHasFr/AXT4+6mr+7HsDOF8oY4P46/YuZKZXEWxyui9e3ddJ
         1FSGQD8OJWYcnoZqKl/2w5wM4wcDCGPeVDNsadnOoV0oet7V3gHPi1LNS7zeJlBYIVzn
         gkj4L9jdkV401gWCuF+rkMLWFBe8Qkj8yI+xCkxzgfM3qYmHNB7vf63e9PIKgHU/Zvsw
         Y4M53PLTyYyUrReTuNciNNfm7yWsIqsp7ArlPvwDKmmKNXTe35IALE2AvAOgVORajyru
         L4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409881; x=1720014681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Fglha3zsHTnOmAct7LCmJkomz3+nHKecoSkTynKNvk=;
        b=Bn5yYKLWyw1wzhnrqzyhxgnUrlVoDJQIs6JseoZJ6Fat6YBiYCAgCZcPiXkZcJtal0
         2oVRvmmdcLnrL5LbTN20MzOkOT52NemxpJUz5n7QIHWo+8b6DnGdoQWCSYKa1Kl2sz+m
         sBYDYNjAASOHxqHWT1xXwz6tL7f62EB3MmTC4S4jWVT5QdPQ/P0UWUHq4nBe7R0v67Pd
         7pxnwdXqpHMNzfVIcrqPif7JWXegtwuce0zCqYu9zT5I+3Xn0mPeVSkZ85ecRAxfn2so
         ohSHN12M+D9KBUFDx6eYv6b/mtYtzXuSFHjFA4tRsJwjcKDRNCwH9Zs0RCPh53d3s33o
         Xkdg==
X-Gm-Message-State: AOJu0Yx9bJ3uQLUBNK8cDpxTvej1a4GhI6SgjY7n1gBbiWl4QVoefcrU
	7GeZqYi1Bdwx2bIFH03BM4/O6Ph8Gn7lBrgJ1rAnCv3iw+nNPwYcyhQXQA==
X-Google-Smtp-Source: AGHT+IGKZl7Kgyut4q7u84GVyHPurTR9LlchepHuzeSBWRFOlVBQtag1/NJNYQZLFmQvdUww/aRmmw==
X-Received: by 2002:a05:6870:40c8:b0:250:7a8d:1756 with SMTP id 586e51a60fabf-25d0163e8d0mr11629239fac.12.1719409881177;
        Wed, 26 Jun 2024 06:51:21 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069eb83d7fsm2796088b3a.99.2024.06.26.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:51:20 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH] ACPI: Use str_plural() Function for Argument List Handling
Date: Wed, 26 Jun 2024 09:51:13 -0400
Message-ID: <20240626135113.1527954-1-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This patch enhances acpi_ut_display_predefined_method by using the str_plural()
function to handle argument pluralization. It improves readability and 
maintains consistency in displaying argument counts.

this patch generated using coccinelle.


Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/acpi/acpica/utpredef.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 29d2977d0746..5f148715f316 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -248,7 +248,7 @@ acpi_ut_display_predefined_method(char *buffer,
 	printf("%4.4s    Requires %s%u argument%s",
 	       this_name->info.name,
 	       (this_name->info.argument_list & ARG_COUNT_IS_MINIMUM) ?
-	       "(at least) " : "", arg_count, arg_count != 1 ? "s" : "");
+	       "(at least) " : "", arg_count, str_plural(arg_count));
 
 	/* Display the types for any arguments */
 
-- 
2.45.2


