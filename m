Return-Path: <linux-acpi+bounces-16858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C36B5650D
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 05:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AA6174497
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97402271449;
	Sun, 14 Sep 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnfVFf76"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F823FC41
	for <linux-acpi@vger.kernel.org>; Sun, 14 Sep 2025 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822018; cv=none; b=cH9CaG+k4j6qMXvmol+rAfTf94w5c3YJrik6FtqnnzwR/xesKEFN5v3WvKRFh0LIiiSwNN4Cw4unGk8ptUIUgnM0cqpE8Bb/Ro252wpwzBxiSvnxZRwuoqFUa7JQd8FtKxvqOW8mrg00QfwzwbsCSUA5KdUWG4v1tH/BImCuX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822018; c=relaxed/simple;
	bh=FZoweijhihxtu6HrPrxAC18gjv4DF8N0f7D122SferU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMkhyI5AEXUFaxwtdKWugC5GbghvJ6rljuqKLJK/kM1/hTEKp5LQ5nfDbQMjOb6BSCvoVMzWXZVkPK/5gqBOj4uiHtovTlBD4OFmlI4Vu/miUOpZc28WzKgGNmu4y+dL0/LjdWE7eNc6pxkgIWUKaBbX1/6Im5UFUE3PDzw58z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnfVFf76; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f1987d446so948904a12.0
        for <linux-acpi@vger.kernel.org>; Sat, 13 Sep 2025 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822013; x=1758426813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=lnfVFf762khiYz0FDgghMlXPGvOITxGCtk+wu9qrbN5hxLRAJ1gs2+ppk7BKe0HXlG
         G5OREfPjiRmY8EwPfB8G4xt1X/oakdJZUIVKAQidEaQcGSNKY/+M0I9BNsBTVp63txq9
         mWNSh2WPW1lcIW6EbcZonrtOLr+rPOcWu02CjDYUuTOSmFZo9hjdGaUQTIax5JlCS+NZ
         TNYxrphaJHRheaHZZPcAmZYwIMBqEB73xXkFvBqUDa4R/U5otIgxVvxeHp4zNeeaJNCP
         7lKrRo7Ge+7IBKugxANcXh/v7/I3r3NwkZPsvZtjWj9jftx6y6vKzysCIfWd+kJWivtX
         fbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822013; x=1758426813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=K/nb75JiRSb+/MrWn3t8neZJWUYnVMegoUrcVEMefPS8LpUxCPDC1YSPzdcZvTkDn0
         01XFSZNz0/88Iv0Cf21AyvZ4zcSVcmWBQU06Ms/QeYcobc+Ui4nqYxFzn05aJ6qvbHeJ
         R4L0oQ1YjJvWmzETZGzvdW5Z4voGZ15lkRuJzLQvPC0FREtH8AJaOgzbsHyyKtYvbqKT
         zyxb5U9ESTLk68E0q/nt1j6A/Orp1PxrI1Xo2AkwTi6WXJwlxKdD0CvnetRgo9e8odqn
         m6gmi9cfLIuDzseJp/mUS3ePqbVnC55U/xdv2/QMcHFQySK8tsRUeLs8GglmzWxxNxhW
         afIg==
X-Forwarded-Encrypted: i=1; AJvYcCVKiOhw7yyQUXnLB2z3ABar3ZRof+nOD0yAldKNFO+q52agz/WHEiQ8zHyo2AfJB5GgclQMv4zRvhYC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywznp3Bw+J08GTmWH3GkxqC75856upS+Afh4nu+kYv9ycn1j4I/
	s65S7LCRTwMRdhRmbpEV6lyHCjRkWWWKYZx4rMGF2YozFyTHhef+j8uE
X-Gm-Gg: ASbGncuXA1C71CMDPrrQh1Wvbln0o2GWr6SlDS7Cj6UKE+J3VSXSVajnfjVZy8vv6Uu
	fumSkDnNCSnUE+g35e6+yAUIqfFq4+9/WCsPESVaPadC6T3Z+aBLzt8u6hV4HhGxVdgrBwP7iqE
	ziUNEf9jUz5+ytkHdsPkSTfRgxQ6xUrjJjXGeYB/x2UfiH1OfIxd93Yde0yKLRbDaM1mw4mKbgc
	xA/18mzfMoFI1kH9Pnqy/S35AwyX//1PP9is5ByosV6a8M15typTWRE4phJaJJydZohMeZhDFw7
	302fzaGDtxDIsuxSwpiFibO2Rnsnam9C73wJF+eXvSulHtsbmd//gQP9H2B0jic5xn6W1gwMAL2
	V8TO3BZbp4qA/7Uk5oPbNEhMx+OsFoA==
X-Google-Smtp-Source: AGHT+IGUQXhZVcMzH5x4qrxgNQpCZ4sYyZ3ugDsvfNumu2I8pECs9df4oC+H+CMnm997jPnr5crTug==
X-Received: by 2002:a05:6402:2111:b0:61d:2096:1e92 with SMTP id 4fb4d7f45d1cf-62ed82614c4mr7020136a12.15.1757822012514;
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3a5esm6570485a12.30.2025.09.13.20.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
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
Subject: [PATCH RESEND 43/62] setsid: inline ksys_setsid into the only caller
Date: Sun, 14 Sep 2025 06:53:26 +0300
Message-ID: <20250914035326.3661003-1-safinaskar@gmail.com>
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
 include/linux/syscalls.h | 1 -
 kernel/sys.c             | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77f45e5d4413..75e9ee03d19b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1231,7 +1231,6 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
-int ksys_setsid(void);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
 ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..66e1e2dfd585 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1265,7 +1265,7 @@ static void set_special_pids(struct pid **pids, struct pid *pid)
 		change_pid(pids, curr, PIDTYPE_PGID, pid);
 }
 
-int ksys_setsid(void)
+SYSCALL_DEFINE0(setsid)
 {
 	struct task_struct *group_leader = current->group_leader;
 	struct pid *sid = task_pid(group_leader);
@@ -1300,11 +1300,6 @@ int ksys_setsid(void)
 	return err;
 }
 
-SYSCALL_DEFINE0(setsid)
-{
-	return ksys_setsid();
-}
-
 DECLARE_RWSEM(uts_sem);
 
 #ifdef COMPAT_UTS_MACHINE
-- 
2.47.2


