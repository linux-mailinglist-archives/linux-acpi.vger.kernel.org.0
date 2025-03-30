Return-Path: <linux-acpi+bounces-12541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEAFA758B3
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Mar 2025 07:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34CD3ACB93
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Mar 2025 05:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925EB13C9D4;
	Sun, 30 Mar 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWOcUPgE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7A8632C;
	Sun, 30 Mar 2025 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314125; cv=none; b=j0HBmJqcIi9BbPsFjgqX37VsINzAwP6LPg7cdaF70KQM+SyS2ZsyvpDO8NSSFyWNICYcOASOn5dzr3xFFrxWPkVTO/digWtT/a/I+gUT0kGgn0SNHEpf7nLoQ0Sra97Pn6QvDY+PJ79HvF/IMAtjYZy5z7K5tUb9MkopiUnEUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314125; c=relaxed/simple;
	bh=jq+T0KY3Uy+rx4nE/vr2dkayKbNzmAXvHQY/LI1TJw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqFIN7rtLx/O3SIVpGbA1htSgi8sbg0CIP8PF8dx7tDKi61Z0dI4q1QU793WawQCEe91qX9KA7366iGEMr9dQ/rsPgaan6sb6IkZKwDmlvueyevkc8muOmXyx329EHmOIb5tYw3gU1MU022RwIJtyf5V6iqH9mg5emewN4p7pJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWOcUPgE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac298c8fa50so570535166b.1;
        Sat, 29 Mar 2025 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743314122; x=1743918922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PpTlh5KVVgsGhCGF4y/CrrtuRXsy3r6ZCRQJL7GKJ8=;
        b=MWOcUPgEcqvRSJY2VK2B8XAMZsFPxy/kM75X/jDVzADq0GlFfOTq9jbQagM6wF2Adq
         K+nKhupoodiWcXC1I8YXEZsFkcmlxHkf34hbp+vQtAt3NBvq8J+Rd5rNP7+HZ+zMHnbb
         ow1Esu4sL4FTXW/FMpyxHlivQD8eC2LS2f1HHPnlKNl9owktGKpJkBiVmZkVpyb2kwO2
         O+8Atvzuvku2g0bP9HgxySGun3oDsgMgfkbT9KQGKEBQnxDOQcbrOM+vwDtb/xo8qk8X
         iIiuh/wziNuktPh1sMFa5IPqgz5+f+lNxmZRIX/xpE/w8+bzl74eXsvxMNuH75CYfL7p
         R0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743314122; x=1743918922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PpTlh5KVVgsGhCGF4y/CrrtuRXsy3r6ZCRQJL7GKJ8=;
        b=MdhwVLyBX243/Mvj62Hy1k8SdrCN3dA+qTZyfz6/ZYALKGjaB14Dvh2AIs3uYw5KI5
         AcmSx3yjuWCh66MMdgq1PalXupXjuidoI9KA3grXna3kfROzTDKF1p+3C3laejkbYYh2
         QuulIJvpUF9iG90+ddmv8QhN56Xuxn7wxc1QvWk0BnQUr7FJLFPkKGXCJMGA0Vz49TwX
         VnvtrxifEZzcaOHkYOYs7apy8K32YkS877Pt4LrymTYA6qvcEfyP1GCxpox5g+KekOrO
         8FA704uyeG5Vka628WJuqRbdQjEaKC523y0Y+Q8gcWYjhYLKA2wUFFvngrLFQnkSfRY2
         2Zvw==
X-Forwarded-Encrypted: i=1; AJvYcCU+uTVbaQceqTSR25XreVMDPx3CkSEY+uKk1CKMPGZ4522ARrNnh9eLR8HyZc/C3w4fSQhBuacuW4HE@vger.kernel.org, AJvYcCWIe/bXDSp+9gZ4AZV7rKMCCCp+UQTiEohBaqzdk7hbUDEa2TBLJkVcoj0HTdf8UOr7t+jzptPU/AcV/8Nm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rAnA9b86CJixdyl8GCCGi+M9rVkfoz/J4N+cZsL9aAk+6tCU
	+2Veljg9MVEaL3R7h4azPqU5XYPSrRrMPotoqtHUpaFTx7UjswkrZfT6ci4e6ez4fBp9
X-Gm-Gg: ASbGncvQVNbDy524r5Cph901KGOEf3enMZgKhCEOAaepfaxcuGm81mxuvdRikSkKcZi
	8LarsxJSlYOFvPqJ/Cqs1A3+V9fYh7PXULUTCWR8vfWeJDnbG52jtc8VD0IW+Rte9r7HUu9i+Q0
	gdJTfqfHSLpseneFkEJBxz3d+Pinhfyk/s/EvpNFdaAmDEeowwfvAOJrfC4WklG7jWlcY6Zx8bF
	iCCTvovQstFbV2crchAGE0l6jqWw3yP2EE2hgQ2nqF4a1Z/dIy5U1s7DKOrEU5eLwRnV7kaF5gM
	mSTzQoAS+3bUolsGaJbGy1RLupFkKUgdFtetWrEuhJui1vBKL8irlkir
X-Google-Smtp-Source: AGHT+IGos8Q7srbIrNbIAkO4sMWeffy1fVcgAryd53kfETkDp506bEMrCTcyjRgqYm0R6nLDH4kAow==
X-Received: by 2002:a17:907:6092:b0:ac3:8aa5:53f6 with SMTP id a640c23a62f3a-ac738a0c683mr434267666b.24.1743314121909;
        Sat, 29 Mar 2025 22:55:21 -0700 (PDT)
Received: from localhost (44.tor-exit.nothingtohide.nl. [192.42.116.218])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5edc16aae7asm3872618a12.2.2025.03.29.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 22:55:21 -0700 (PDT)
Date: Sun, 30 Mar 2025 07:55:18 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] ACPI: replace deprecated strncpy() with strtomem()
Message-ID: <6c1a263a89712b5cdc2a6752a91bb9f71f379a2a.1743313252.git.x0rw3ll@gmail.com>
References: <cover.1743313252.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743313252.git.x0rw3ll@gmail.com>

strncpy() is deprecated for NUL-terminated destination buffers[1].

Use strtomem() for ACPI_COPY_NAMESEG() as destinations are length-bounded,
and not all of them require NUL termination.

Also replace strncpy() with memcpy() for copying header.oem_id
and header.oem_table_id

[1] https://github.com/KSPP/linux/issues/90

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---
 drivers/acpi/acpica/tbfind.c | 4 ++--
 include/acpi/actypes.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..35f72dffc250 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	memcpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	memcpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 80767e8bf3ad..b85dec57f00d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -522,7 +522,7 @@ typedef u64 acpi_integer;
 #define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
 #else
 #define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAMESEG_SIZE))
-#define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
+#define ACPI_COPY_NAMESEG(dest, src)     (strtomem (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src))))
 #endif
 
 /* Support for the special RSDP signature (8 characters) */
-- 
2.47.2


