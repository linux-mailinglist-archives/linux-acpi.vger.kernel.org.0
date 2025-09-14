Return-Path: <linux-acpi+bounces-16868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EBEB565C8
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 05:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6CC1A22BE8
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D07273D6C;
	Sun, 14 Sep 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKs6hFjH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409926B955
	for <linux-acpi@vger.kernel.org>; Sun, 14 Sep 2025 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822375; cv=none; b=P6lXeWXh2vMiJ2oypb/JKg9J78z4UYPYo4lxCBCk5IWRmYv5z8BIRBGYCq5bI3pnvPa8rL/ri4709bJ0j50Q6Ujfi5jISYN/255oFHceRjlCCw2MgbVMtYMtaNqod7YYNWkIc4hpxVrldrHZ2q6H1Psq3sje98Q56uqdMXndiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822375; c=relaxed/simple;
	bh=dWOevKs33KVPp7BfwW01lTdoAaIwqA9A0zVQ5+zAb7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsIPvQ9Xg2v8RLE4OxtRR/UGaLQpksHhBJcE0/BlUtpb3pjSjUJrLPXd5SEYPC4XFXGu4i+5O4+LXqx/nCkZk6f6Pz+pHvs95PKyXcrkbtyx87agt5kdAeH6wygSpttyXh3I7sAv0W/IBj0zKijLoTKeCvCrDTQ5q8qovJs2JDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKs6hFjH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so479129766b.3
        for <linux-acpi@vger.kernel.org>; Sat, 13 Sep 2025 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822372; x=1758427172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=HKs6hFjH8hGEx8kFtB0nX1YwQKxkyNvIdKjk/YzKI/z0N2ZDpeaXyG20MCSaoI/O2G
         2InbYsM0JIlQw7fF9JQOjh6n9wTE10N4NGXAGVvOCQCKKy9hNkIvXHLpTaffaQ6s4mep
         pn0gal8CFQcQZ85hI0z7RZR+ISakVK9tsmvSpSebNlKb7PJPBY29jl/n1UT+16TV+0Kq
         W5Tf98TOSJKftoJa69Zn2ced0NPDfmm4/u8FNqhdlooOtvVHogWf1HBA6yplUDCHmgHZ
         OkkxLOYjZIXLTHxcdVwz73zpMIl1H00w+5KjoLiwvSIKL2neU5Q4/hIDRV0tsOcrkaR0
         rIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822372; x=1758427172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=YfBeq0wzg3lSClH8LH3oOx+EpNsq93cKoCopvmDfozp/yOLdL/38iQj/ftMnGEMSDW
         5o3ATQ5rcn1pQwkWxra2EKeHs0HxQbtkik4/GZGfdeKsjshsjkvd3e8608nY7k8cIiOP
         an2eC413zMQJ8OeFS91MKi0+d8JVRQScIPPC1I0RYPvSc4xgj8fLHdJ3NKglDX7YXhrW
         4JfOP0ZhXj4xN71FspPVUde4SoYkAMN78Vpvfau/xy6O6GtGhySeazJPjOdPGAiYz0ca
         jsAIIC8VXsj9hxIw26Wv4CT+Iaq5YRLmlABi4KSoU4Dl305xV8JtOBYTdC/MuYiGUmga
         w4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWJKTG+A5T7KqAthS5NnYc/bMz/RVjxgZYI/qWA3fXhIvr8W+au5CaDYXmL20GL1BpB+QT+w5M07f9m@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzaw7yAx3GYy9+Y0RcRxSKGyFb7REDhEWrAgcZGB3GTE2lqvbI
	ldLevT+OnvkS8N+OB/fSdb3VTSGUJeyBfXY/GR4Jgp+Xgdriq4uRU6fS
X-Gm-Gg: ASbGncsEZ9cJvxvaUF3fHLSuEEffdaC8+XrBM6cG4NNHT547OErcd+cLZ+fVDrQqyLT
	hbAumMWIdXg4JjqcTUyshBn/sWQ0qOsLPeyHU3pNF9TUw08oSNuySCCOL1wQWOWsEYk66XEOQM7
	VTppNOIgQIL8QYLq4W5t0DMHGtEylAbi/78h2SBwVB75v+7qZkvvwme42oROT4aMFOodAfHbj03
	JmFKXeML0PwPk6Aw2A4z1s/4XAEZrTSpzeLlRdIXh+bY8yi7U3qGNQi4yjEyyIJpEY/3MGURx5M
	9EnYi5IlWSEjZ6JA97ew443t1ZLVaAxUgwrLlfHljYnjLmg8dZ1LmhNcmZrFQO33cg8J2wh4Tf1
	rqyxp5e65O8wrKu9dA/c=
X-Google-Smtp-Source: AGHT+IHIaNmlQUOqaI2XvHaD2x2sJJCA+iwXMxeIqgPaozK4MzRrxS2gXxwIxVkINaRf0GrOSh3U1Q==
X-Received: by 2002:a17:907:3ea6:b0:b09:48c6:b7ad with SMTP id a640c23a62f3a-b0948c6c6a4mr387666066b.57.1757822371514;
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07de03d93csm287001766b.12.2025.09.13.20.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 53/62] init: rename kexec_free_initrd to kexec_free_initramfs
Date: Sun, 14 Sep 2025 06:59:26 +0300
Message-ID: <20250914035926.3770703-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 40c8e4b05886..d52314b17c25 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -690,7 +690,7 @@ void __weak __init free_initramfs_mem(unsigned long start, unsigned long end)
 }
 
 #ifdef CONFIG_CRASH_RESERVE
-static bool __init kexec_free_initrd(void)
+static bool __init kexec_free_initramfs(void)
 {
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
@@ -713,7 +713,7 @@ static bool __init kexec_free_initrd(void)
 	return true;
 }
 #else
-static inline bool kexec_free_initrd(void)
+static inline bool kexec_free_initramfs(void)
 {
 	return false;
 }
@@ -743,7 +743,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initrd()) {
+	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initramfs()) {
 		free_initramfs_mem(virt_external_initramfs_start, virt_external_initramfs_end);
 	} else if (retain_initramfs && virt_external_initramfs_start) {
 		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
-- 
2.47.2


