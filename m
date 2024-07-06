Return-Path: <linux-acpi+bounces-6781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B09291BE
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2504282DE3
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527142AB9;
	Sat,  6 Jul 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI8972uT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5316AC0;
	Sat,  6 Jul 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253476; cv=none; b=X6NZkH3DlcclA8KLokVBIoC5htQqQu4TKh/sDmOMjQmubYuO+9KmcUmVS+fqvCB8L/OzFommuAFZxX/JOgPP0lk75SK5GNe7Udl+9/aiPB7NVRICA1VPpPpWIPiiyA248pxAKOHxjXOKZZCtIaKUCzVKYlh6jjR59jC3nbIWJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253476; c=relaxed/simple;
	bh=rfZEouzOxsNRA4awpkHYUc2icZH/Imr5myeeWGkXRSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tdn7HncwlZ8R5rit3+YaK0OyR0I1wgfDt2TK/RaZQsWiln8Ju9PWQmMYOuvY7JO+Lu1ox2HtGj01EZD5FGEUoxIsgCqZnaq+dqGzpIuAmdbJf2JnF/U36ul8dv5ZAwKAZ4qQL59kTs8i3mLNfYloodvysUJ7PUhDlaPq9RSkJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI8972uT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367a2c2e41aso991818f8f.2;
        Sat, 06 Jul 2024 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720253473; x=1720858273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jxdnk9LdT8owd0wJzaCgXhayUh+BFK4CbLfMVXWHNtg=;
        b=aI8972uTYNQvFili5Pgrd4z5mEX5lsr1y2HEQool5bsMrFYY5XH9Oaxc8BsXnlGT2V
         kX0YWhVx/xLu4Pe24KHjO1FT7Iu0A1de4/fXPNeFX7JiTeiSMeDVD/53ME30aUTzorbr
         eJmNR3xVwNWkEFTgaY+cAqeAKc7UWmSGhId2AntOXUxKv6kfKpyTnyFGUJ5iW0f6s0XT
         Rv076r69F6O6v+qyMcjAx/uYYMmAC7ZiE9/Fzdb1WQD3izzkvlQ1veNIUcnNCSmLE17K
         VbR1IecXSUabEsDN/L0lhBqLoaH161H9ZfCriX2HAzHnTHtG9q0tX+My4rp99d1BKkSK
         uobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720253473; x=1720858273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jxdnk9LdT8owd0wJzaCgXhayUh+BFK4CbLfMVXWHNtg=;
        b=CIdLdg3fRz+X44EHrD09mHVsE8E0sw6oTnFn3PexeyCmraoeeghw3PBHbQ2/4uzJe9
         AiYCjlWVZmGAqXbvCllR7JzicIMYqjxEyJgJhESemtiraopsfVsDezmYeMnu3dK5NoQ4
         wAHiz6htNn0XlGlYpqeQ5mULkxHMkdDfvenMnSgEq4DaypZiraFUJdnsV7RkOP3RELh7
         yZS9AKNNrp3EAWYLZExij6dCNU48TEcNRG0tuGWE4H6wbPmOx0pXIRvfLi22eg1UbUj9
         tP66r5TbXU5uoo/mQPEOu/msQ9eB1PMkGFHeV7TNWTarbbS8AGV9Fo1yJx90R3EWuY0M
         XilQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsT4H9My3XrnQeZmBrzh2FNkcmPQWUUavLwd4H+igmwnKN0NpfmRfdN+DZQPfcGI11cLilgx6hjiViOJH5bM7kzN6236Z8Ev4qOA6aBU7bIj5pOzJJXl0aq3Xa7gwimBvjBBPdke+Rog==
X-Gm-Message-State: AOJu0YwWqEl2xAFfmsUiYCcvUZXzgsTQb+Euh200VQMUHLCPOaUZBbEr
	DHrByGyiJj3wx7droxfdB5/60zpIok+eM8TZX+cxcySun7DNnnoRv8jwT+AD
X-Google-Smtp-Source: AGHT+IFy6A3hKW7ZOYBZj6yCN1WQxglhxu7RdXUwCCGKSa4XPbZVh4Namx902c/KY2bbHNyp63ukkw==
X-Received: by 2002:adf:fd02:0:b0:366:eeda:c32d with SMTP id ffacd0b85a97d-3679dd353c3mr4798004f8f.31.1720253472975;
        Sat, 06 Jul 2024 01:11:12 -0700 (PDT)
Received: from qamajeed.Home ([39.45.163.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678e5c2b08sm10235931f8f.71.2024.07.06.01.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:11:12 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 1/4] Updating a deprecated use of strcpy from acpi_pad.c file.
Date: Sat,  6 Jul 2024 13:11:01 +0500
Message-Id: <20240706081104.14493-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy.
strcpy is a deprecated function.
It should be removed from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/acpi_pad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index bd1ad07f0290..e49f89bbeacf 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -417,8 +417,8 @@ static int acpi_pad_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
-	strcpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
-	strcpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
+	strscpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
+	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
 	status = acpi_install_notify_handler(adev->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify, adev);
-- 
2.34.1


