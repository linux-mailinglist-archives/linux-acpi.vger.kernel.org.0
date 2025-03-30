Return-Path: <linux-acpi+bounces-12540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BBA758B0
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Mar 2025 07:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D886D3ACB09
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Mar 2025 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9486358;
	Sun, 30 Mar 2025 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln3XgHIC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763817C2;
	Sun, 30 Mar 2025 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314097; cv=none; b=gOFw/phuaF4fQzLQ9/IlQ9obMeB/V+WAUvHsTBMX4nJ7Em0tHxXpfljcjeeEezj+0RNIbCTDqSDV35ZTcTqRJ2MhtO43ye2G4BHFcG7puqRPDa7hxwKO+UjnEC+79e5qr0VnH86jePNky6rEeJUZLd8Pn1p6KyNKekLLaJW4a5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314097; c=relaxed/simple;
	bh=6p8gncaaZsHPc5k3Qs2ZLsncfJuQGvSixclKj5eyQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V62ZETbRle0UMDvB/qm66BLA6k7cfUD5z/7hUtz9NMoK+XYOJIlVEoglxHOIcOd7LPYiPbxOYEOcSRywBcj2ibWjq8IdcaXOJyszZhLrNoqRrvDkpZslVENeDnu9ezkqVfQaE7SZtJABdwkNU6/2T7+qyr7IkoZ51IYmKHSvPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln3XgHIC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so452914966b.1;
        Sat, 29 Mar 2025 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743314094; x=1743918894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZS5hChiziL0zECiXtf+2ICQEzuKraJOFVrf1WXGBpo=;
        b=Ln3XgHICO3pkubsy+qBzV8NjDOrPbTSJN8Q1Dz1oRlPg/+WL/xwSWeCEkdds5/Kbg0
         ptPuhHS8atkyczWHA72rsEv6XzU5kG78/c6jJy83pt/nxckswwMChTemrwrpdAKvON2N
         lwiLf9vQSLhcwLTIU3w0jDpt8jjXixUZuvRFDSqVUXnqbPDxa+6II7IiaF6Xgwc4hOFn
         7A+qQgkLqbvRXSzauw9bdormpCA4lEHwA/zl7sBTkSfZ+FEcKhBJesJdM5hNqcXPc19x
         8Kiu7ZLQGJ1RE9bNjhfdUrg+eZ3kStoiKBXKUbCgasrfTE724E+Ogyq5L3gVeX2C7LmK
         6edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743314094; x=1743918894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZS5hChiziL0zECiXtf+2ICQEzuKraJOFVrf1WXGBpo=;
        b=encZSJE8pjQsci/JvWpopnvUXvKBxoEZZqPXfOLKuOLtuikg2S4XYxQCe5RvvTjVoK
         qo9zJyh9J5xy4rMyS+DWVTL3MAjGNa+30ahyEw0xwJyxH6xdig1q6rh5WWWxSYPd82f1
         xnOVX033A1Llmrgqub3uXQaD6NA9lCRDzRmWfpUuXfTmQJGz+X40gEBGxAnRcLmnLpMX
         /ctJAQc56RF5sfjS7pzFIL04w7HS/GFp4mLMR1Z9YElLyipmJZst1Byjfiht0IUQbbiy
         KZAgn+cAcoNt4FHt8/tOjnIlLs53eYtu44Ap4oZLfxkmzPGhztq77/uXwT6+oKMyCXPg
         uiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGaJfY6Wl6vptABiiUA0M4rCnr90QPJnXNK6u1tG75qFR8HHcGP0Cbqiq/CEnBeKA0SB3TwfZ+Yk0iQivD@vger.kernel.org, AJvYcCWdS3OTMM6yj98qsws4WinOHRY3YRI9OyzcF7CB9ysOd/tkkV3a/iRHxD3VFRDOLjVdcEVf+DPUS/Aq@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJ83sgPMNuZyqDWih8TDQwVYwLjNKgdc0YZFVMr9wei9teT6N
	LJOjvBaWhrQadg+e9+8li0tEclBrRPDK94kYUHrqiq9SpLHFNKdv
X-Gm-Gg: ASbGncsAETgwnZx8m7V4uaj1Leg83OC6YQFM+8fOcC0Tj99+3byBAJzJq468Z/15TrP
	nX00MAvLkdHA25a90R9AiiJZQNwRKA3l3S6aIQ2/IEjNlvBlO8clEqUfq2sYRSYU/uQp1khEkZU
	JN4a2OxKqIKO4TTLXjpgv5CTIn7jE7iPhIlsG2XTaDPqbOb5/fQm/gDOWde4trcc4MKrjTYFlwI
	uga9XKbhCA7RnuexrAKU0tFkwIQVKGcnq2stzx9eXsu05lEyBMJSNNHB29VX1Ob/EW9z43zPS2N
	Rer/yOMd8K5ek2VUzdAk0oU21dewgzq4kqAFd9e7XK+2RJdx7rMMouNuB374SRNDxko=
X-Google-Smtp-Source: AGHT+IE87WJv0/ZzDl3FXShm+jTRY2Te+7Zv9PYAX8DvccPdhOEnetOp/txCzMreLmUt78hsaQBNgA==
X-Received: by 2002:a17:907:7f07:b0:ac2:55f2:f939 with SMTP id a640c23a62f3a-ac738975e33mr385096066b.6.1743314093493;
        Sat, 29 Mar 2025 22:54:53 -0700 (PDT)
Received: from localhost (44.tor-exit.nothingtohide.nl. [192.42.116.218])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac71922ba63sm433884266b.2.2025.03.29.22.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 22:54:53 -0700 (PDT)
Date: Sun, 30 Mar 2025 07:54:50 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] ACPI: mark ACPI_COPY_NAMESEG destinations with
 __nonstring attribute
Message-ID: <a9bd2a1b490b4305c18f8473aab21c97e8902fb8.1743313252.git.x0rw3ll@gmail.com>
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

strncpy(), which ACPI_COPY_NAMESEG currently uses, is deprecated[1].

This patch is the first of two, ultimately replacing strncpy() with
strtomem(), avoiding future compiler warnings about truncation.

[1] https://github.com/KSPP/linux/issues/90

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---
 drivers/acpi/acpica/acdebug.h                            | 2 +-
 drivers/acpi/prmt.c                                      | 2 +-
 drivers/acpi/sysfs.c                                     | 4 ++--
 include/acpi/actbl.h                                     | 6 +++---
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 911875c5a5f1..2b56a8178f43 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -37,7 +37,7 @@ struct acpi_db_argument_info {
 struct acpi_db_execute_walk {
 	u32 count;
 	u32 max_count;
-	char name_seg[ACPI_NAMESEG_SIZE + 1];
+	char name_seg[ACPI_NAMESEG_SIZE + 1] __nonstring;
 };
 
 #define PARAM_LIST(pl)                  pl
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..ca70f01c940c 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -40,7 +40,7 @@ struct prm_buffer {
 };
 
 struct prm_context_buffer {
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] __nonstring;
 	u16 revision;
 	u16 reserved;
 	guid_t identifier;
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..a05d4032d4f1 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -307,9 +307,9 @@ static struct kobject *hotplug_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __nonstring;
 	int instance;
-	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
+	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] __nonstring;
 	struct list_head node;
 };
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 451f6276da49..8aa60281e7db 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -66,12 +66,12 @@
  ******************************************************************************/
 
 struct acpi_table_header {
-	char signature[ACPI_NAMESEG_SIZE];	/* ASCII table signature */
+	char signature[ACPI_NAMESEG_SIZE] __nonstring;	/* ASCII table signature */
 	u32 length;		/* Length of table in bytes, including this header */
 	u8 revision;		/* ACPI Specification minor version number */
 	u8 checksum;		/* To make sum of entire table == 0 */
-	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
-	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
+	char oem_id[ACPI_OEM_ID_SIZE] __nonstring;	/* ASCII OEM identification */
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE] __nonstring;	/* ASCII OEM table identification */
 	u32 oem_revision;	/* OEM revision number */
 	char asl_compiler_id[ACPI_NAMESEG_SIZE];	/* ASCII ASL compiler vendor ID */
 	u32 asl_compiler_revision;	/* ASL compiler version */
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 9d70d8c945af..52026b9e389e 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -19,7 +19,7 @@ ACPI_MODULE_NAME("oslinuxtbl")
 typedef struct osl_table_info {
 	struct osl_table_info *next;
 	u32 instance;
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] __nonstring;
 
 } osl_table_info;
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 13817f9112c0..5a39b7d9351d 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
 
 int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 {
-	char filename[ACPI_NAMESEG_SIZE + 16];
+	char filename[ACPI_NAMESEG_SIZE + 16] __nonstring;
 	char instance_str[16];
 	ACPI_FILE file;
 	acpi_size actual;
-- 
2.47.2


