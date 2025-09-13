Return-Path: <linux-acpi+bounces-16830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3BB55D12
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 03:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203F31CC1EDB
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E91A314B;
	Sat, 13 Sep 2025 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm9piSCy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104419E968
	for <linux-acpi@vger.kernel.org>; Sat, 13 Sep 2025 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725974; cv=none; b=nfQpk4f/nwW9VdbPTi87wfR2q3YV7jOurEWXdhZdiQLiXMhmqCM3S+z3t8v9VNfjrVhdiKBF1N00lPJq21wx1YlDdoHuF/1WRB14XXqmLH4S+SIKPNSL18zTd2M0edyItYF9I0YRkJVJ9yvTxaRTIHr2pzy72DmVmWr2qpaTqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725974; c=relaxed/simple;
	bh=5w1rh0L6NznGkqOB1ptiKwAFOGZfY5CoA2D4m8g2/Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYYU3mxeYCXWjts9ecL9Zpb+PkrYczwRzP9V2ASln+BLf0i52YOcL81DX8Zxg2tRTG0tAK/0ptVHEFyotxaUaFP2z0x7yW/yFZf34R4bco+4tSCWPqUtCjoB6wc83Tb5+IOhlRBPo4ebsGxvdymp2pTkYGlAbc2dJWvhCEaGXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm9piSCy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07d01fd4fbso150673966b.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725970; x=1758330770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=jm9piSCyAtXZ4sW7o/h3SGpliQHevBkrhxl1tQii9mgHqdG87o74LcSjtY0avpY0iX
         RdeiQDrUqQ5C5qyGy2HNHbhjeW1tyThLcjGIFDuhifBp9ZAahZRe/JcjT78TZLjYxr6O
         clz08Pl2eYNgCRP3z65VvP8bCDfsGkCIvdvYFwno6M8/UvygM+KRsZjpRUrxOekYWGnI
         j0/O25Qolp3eD7BmcFGNh8/jP3xJV+WM11QZFpJ3kUVpHKMxijbTHMgjsau/ncgLiR1/
         GlkR/1ri7/XijIi7U6mEk94bP2JEKshCIzyPHHSsIIuiNpAyZbMwdpQELhiCIBLbGIjK
         LxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725970; x=1758330770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=tuZQtk1g0620MhE7IwaP6oKp4UQqxpgIeQfPa+y171lgx4bVMMlZYxsQnUEgz6/Kvl
         J2JhdcXXzLnGxD66LmDuiPKXnMM7zGs8wTABROEmjtwTht8CTo+5lqTIQMeK+th/k1A9
         ue4ktSGS9YXeIeALxpWLlWiVBsEOwf8niJPaT9+efrY5Z6Z+JfwXge32d+dV1ugN10Sy
         b5bV/9jlmA3t87E1rCC9DXhjSm+9baK8r/YzyWFkbBaIMagUScAyBFZN5I/axPgbg2pJ
         eu4/ogAxlL39ketSHoNnj7Boeqntzf/gAntFBGGM1zLba0cA742d164pO3gXv3CSGVQ7
         y3IA==
X-Forwarded-Encrypted: i=1; AJvYcCWaYfdETsTmoKflH5CZrzQ+eijcb1uU6M7UxBOcb6KT+JF9z1bbMyDWT+gYemSNgNnjJgJIouOLxf2X@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWl18tlXopv7shRiFh2/bmgb0QI8h8zKgzJLOHo5i781YI5Wg
	2E7FHvBH9D6ipb6PI/rdyY0nYFQlrHH5x5NySPPRUN1b/SpCVpL3w+dk
X-Gm-Gg: ASbGnctOY3XOZjOWOpnGGu4mebdh3FmvnSYcDca/YHnKdELHBlsVCOskqOsPHwHHTj1
	qSFGI/AfRn3rfIp61GxDjhgYh5G+LmBm1ey5VcVXoqWy4QXfL5eHj7Gu3Wdh84N9HsEgzg3epI3
	CU2CoxqwONas+3D7hMxE6Io02Ptmv6/4Tfavnf3aO86BahW8+T0lBgPdM/ImdVrDcbOexDFRDiR
	2tFdr7XWnXFjsS4Bh83LrBm2cv+pT4RCkAgZPYmkUiArZ7vmA+o3stFLm7RCVb3fGaX9SAtyO13
	V6gjNvAcRYyGFMdBEHnpt3aZs7kxSQJ4dLroblAcdhbctm8/y3Fwle/4nxbGVIj+SZgCBt+WOG5
	JtLMokmJJxlqOsVwS9/sx+Govb+gs71lWyv71Bewi
X-Google-Smtp-Source: AGHT+IExCbHobezsJZBylPatDCb3rXiTmvHjuHynF55nxxCc14bpP2oPLB71sx+Li40Hkl4GjqRelQ==
X-Received: by 2002:a17:907:97d2:b0:b04:31c6:a434 with SMTP id a640c23a62f3a-b07c324cf12mr467235966b.0.1757725969783;
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da327sm479612566b.11.2025.09.12.18.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
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
Subject: [PATCH RESEND 30/62] doc: remove documentation for block device 4 0
Date: Sat, 13 Sep 2025 00:38:09 +0000
Message-ID: <20250913003842.41944-31-safinaskar@gmail.com>
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

It doesn't work. I tested this both in system booted
using initramfs and in system booted from real root
device directly

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/devices.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 27835389ca49..6ce0940233a8 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -138,12 +138,6 @@
 		number for BSD PTY devices.  As of Linux 2.1.115, this
 		is no longer supported.	 Use major numbers 2 and 3.
 
-   4 block	Aliases for dynamically allocated major devices to be used
-		when its not possible to create the real device nodes
-		because the root filesystem is mounted read-only.
-
-		   0 = /dev/root
-
    5 char	Alternate TTY devices
 		  0 = /dev/tty		Current TTY device
 		  1 = /dev/console	System console
-- 
2.47.2


