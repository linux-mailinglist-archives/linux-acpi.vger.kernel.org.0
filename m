Return-Path: <linux-acpi+bounces-14984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE7AF84EC
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 02:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B256D1C22543
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB517BA6;
	Fri,  4 Jul 2025 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgFa/g6b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD98488
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589637; cv=none; b=cBwWBYT0q5/eUQn2BTOaKeYRNj7MernrJlNpg7PdZ/uK+ZJIamQTY6lN4CRyiLO80O5x4zGGskmrJDthvqJPE34nKt5K5SG+6xmeSpz6xFKS9SmcVdUBE1vO9G1+R2xiSpx8QnqY9sArxNGUaE8DEAiBLaqvPVNKNPjEGHTtQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589637; c=relaxed/simple;
	bh=Thjz2k5imvIazPN2cs4iyvg/4RJcnVhKqoo67pUDnMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbH6/9IiZ4n2hHwJntn2PUUxN0tYk9R8Ly9jwcggSF2sbawjZllY8ZNNy1UuykyV88605M2xrXmoGU+47IsYD+kMIUvrXJCJuPYY+eyZ21ZpTNE6APKRhEzZ7zsyYWxTrCsci0JbHEHhSaUYsfhaPDAcTkUHEGFsAloRciephQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgFa/g6b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450ce671a08so1965315e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jul 2025 17:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751589634; x=1752194434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MiRydu86i61hX+gOiR+p04KFIHhqaKfhWesMu/K1Mo=;
        b=FgFa/g6bou9BjIa6v65uJiErB4ecTtiokim9kocTCquSbhjsAODY0IclqC4Le108P0
         phSp8OobIJjTDpJSTQI1rbanf+pX642t9vWGQpoFc1gCkFA1kjo8oRIrLipsHYbqySzv
         fTFuc45031sZBpbK8EQfX64lL1w/8/28qV4xtYcr4pClUQ40zgyFdSm4d0a10Ra2Uc0n
         YXi+uwkQ/ho5iIlyRQ9alIsMXaM62z9hwVcYFeT5w7UT/uSnpXoT/k38MTmJ9OHm2NXq
         /mTR9+/kMfJ8GOae9nSfKVZ1GGgkHU/HTkQNRkmTkvDqZnzySJTUOSnE3TJ92d849Iv1
         tLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751589634; x=1752194434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MiRydu86i61hX+gOiR+p04KFIHhqaKfhWesMu/K1Mo=;
        b=Li8tr9y81JGEvEXCr4zwZnpFslTeUIY4hPmWHYkr6g4XBwn4C8iKq+Mwm/tc1sBk1e
         Ffhsfeae+cwzpflf4qnpijka10q54OAAsQ5Rn0Fwawih0+HYKeid/g/es02bKuIMyuZj
         wPy9mRPXh7I7th8+Jdt/uWCUQWTdBqY20tZQh08VERjd/StK7hJecQt6uCsi4QGf03eL
         y9DlRmwultmIuowuOwSRpwUpwoeO1Qcp2mAVw2z8NRi3i6w4ElGjGL+ZRjzLFtoZbMp0
         0qrh5ojapP6AFX8IIdM5vtJ/L9PoLDdNw+4HMCskzk5UX5g+JeA8WQ9REo6SMqCl6h8e
         TK0g==
X-Forwarded-Encrypted: i=1; AJvYcCUeNRWszyIQoCJ30Msu69KUoAjngp7yEJm2afhaPVCXPDoR0cTeYS7EG8My+H5OPd8iYg0KQbUu09Bb@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPJQCGVb6KJdg97m2I7XeajFiqskJKYSfe0BEQJrO3/O+GXHy
	kCV4pvoGg2oJF3krjUgMC+W/O4nZiaD0MvFVIKG4NU4DlyLJ83VSP1cg
X-Gm-Gg: ASbGncsKH5FRu7A5TdhAM6x/seLa8ooFKPrEA+8NpQqrTLJ5O0pEDMrvif0uqxWaF4C
	MNWrP+OGENbe+liCXuo3bwnqSClSLfwWfLB5ieJRkqvJmMtgjWdNCPmNDgXIV8lEDsn1YneB2NY
	Qw7AEzgVeDJCfKnesHrCT/eDPrgOfC26RtrdMxOBBkfyl+65pdp1KH4om4RYIY2kU4xdlntTsxf
	QUvsOOLrC2aZeZtZ1nEkVTB8Vn7pzPk1owST785DZDKoKoMsbyzHNyodi/e1okB8PQEdAn2pe/8
	ScVmGGFf2tM0S31Ft8j2A5qLUTAYnwedBM4ydxsveeoxUfqcCayK2c+dGir+yDSzVhc4R5DQK+k
	ts4uL6i79wVdXjwEPtefx9yRPv41PQZFbil9g3g==
X-Google-Smtp-Source: AGHT+IEwgEBHNXVuH//1bkr0zDfAm2ycq8VtR9B4tLH6+m34M65kLFmtqxjpTBK3xOVvIZ6HKBF74w==
X-Received: by 2002:a05:600c:3153:b0:453:8042:ba47 with SMTP id 5b1f17b1804b1-454b4ea67a2mr90145e9.19.1751589634312;
        Thu, 03 Jul 2025 17:40:34 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([197.46.119.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm1059686f8f.11.2025.07.03.17.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 17:40:34 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: rafael@kernel.org
Cc: Eslam Khafagy <eslam.medhat1993@gmail.com>,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	skhan@linuxfoundation.com
Subject: [PATCH] ACPI: fan_attr: Replace sprintf with sysfs_emit
Date: Fri,  4 Jul 2025 03:40:00 +0300
Message-ID: <20250704004002.70839-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf with sysfs_emit in function show_fine_grain_control in
according to Documentation/filesystems/sysfs.rst.

This patch builds on the fix proposed in patch:
Message-ID 20250621055200.166361-1-abdelrahmanfekry375@gmail.com

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/acpi/fan_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index 22d29ac2447c..f4e7f2351616 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -67,7 +67,7 @@ static ssize_t show_fine_grain_control(struct device *dev, struct device_attribu
 	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
 	struct acpi_fan *fan = acpi_driver_data(acpi_dev);
 
-	return sprintf(buf, "%d\n", fan->fif.fine_grain_ctrl);
+	return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
 }
 
 int acpi_fan_create_attributes(struct acpi_device *device)
-- 
2.43.0


