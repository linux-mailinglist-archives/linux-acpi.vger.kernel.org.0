Return-Path: <linux-acpi+bounces-20501-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B75A5TUcWk+MgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20501-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:41:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3EF6298C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47DB4507E2A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71F31AF2C;
	Thu, 22 Jan 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="wNQzGcVg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-30.ptr.blmpb.com (sg-1-30.ptr.blmpb.com [118.26.132.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF232512F5
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067315; cv=none; b=HY7J6o+Ma5UrjI9RuEkhFoXd1O8qTkm6vHt2lvexYC30axWYYgCwMUie4zADICgnSbT9weQYHPH/GXLlrvtkWUIRz9Rw/8mkfWFa3VCi81wwaNGpnAxjzsGsdlIZA702GDTrmXHIV3ENJqjMbZ8Oo+afsVIOqhGPPdshjInkpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067315; c=relaxed/simple;
	bh=Zg4V6RJ5CX9TkQlNvozgJSw3th6d9YeG4f0THZUNWK4=;
	h=Date:In-Reply-To:To:Cc:Mime-Version:From:Subject:References:
	 Message-Id:Content-Type; b=mENkOXf6xQoti6uvKLIFVsx/++egbCg0nb3Y58El9jVC8pqOPgv90nh9gmNXIff2dLGbdODp0WXTjKb0Uwe/neopjtQdauV/JjprIMrZ0h3hzguajiGLTVvTfoJcr/3EkTA4jSZmi9ylli9MtoPhgfOD4dKBmz1cd69POajBSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=wNQzGcVg; arc=none smtp.client-ip=118.26.132.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769067297;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+g/3tjO+rV9WYb2Jh/rm5GHV4Veu7YSdogQYF3BcWcg=;
 b=wNQzGcVgLadD5kvUkSUhWc45cDCxqGNGk6kd/+Wz0BUSIemBHHh9+csbwE5Lol9hTFdnSx
 lnDZNlRR+79edruORKpTgTilX5NN3Df7nP4eDQjYgLTtpB2k7e+A3mO3k35LX2QkuYGqfq
 +HYh0Z6Mj8kSsz4CygQGQGIsuN/U9Jfa/UqKNGfb3YLrzCZgboO/lo9jqP4qz/u0vMPzIu
 dEM0lIys8QnUps1Lcltctl6o2i2Yrt0O5QcBr33LcrzqoQdqA2ur8uLOgJKS2xrcOBJ4vl
 QC1TbrPduy45WUvBIN30u0XxrjloAjEMU8p58mzFrI29VsImUHE+9/Z5vYaoSg==
Date: Thu, 22 Jan 2026 15:34:46 +0800
In-Reply-To: <20260122073446.45628-1-yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Lms-Return-Path: <lba+26971d31f+b5db0e+vger.kernel.org+yang.yicong@picoheart.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <tglx@kernel.org>, 
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>
Cc: <akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<yang.yicong@picoheart.com>, <linux-acpi@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: [PATCH 2/2] init: Move console_on_rootfs after async_synchronize_full
Received: from G9WYR9K0VW ([58.250.122.114]) by smtp.feishu.cn with ESMTPS; Thu, 22 Jan 2026 15:34:54 +0800
X-Mailer: git-send-email 2.50.1
References: <20260122073446.45628-1-yang.yicong@picoheart.com>
Message-Id: <20260122073446.45628-3-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20501-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[picoheart.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,picoheart-com.20200927.dkim.feishu.cn:dkim]
X-Rspamd-Queue-Id: 6D3EF6298C
X-Rspamd-Action: no action

Currently the console_on_rootfs() is called before
async_synchronize_full(), the console initialization
could be still in process in theory due to async
probe, etc. Make it after the async_synchronize_full()
to make sure the initialization work is done.

Log the error code as well if we failed to open the console.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index b84818ad9685..c37ba5f89b96 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1578,6 +1578,7 @@ static int __ref kernel_init(void *unused)
 	kernel_init_freeable();
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
+	console_on_rootfs();
 
 	system_state = SYSTEM_FREEING_INITMEM;
 	kprobe_free_init_mem();
@@ -1647,7 +1648,7 @@ void __init console_on_rootfs(void)
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
 	if (IS_ERR(file)) {
-		pr_err("Warning: unable to open an initial console.\n");
+		pr_err("Warning: unable to open an initial console, err = %ld\n", PTR_ERR(file));
 		return;
 	}
 	init_dup(file);
@@ -1690,7 +1691,6 @@ static noinline void __init kernel_init_freeable(void)
 	kunit_run_all_tests();
 
 	wait_for_initramfs();
-	console_on_rootfs();
 
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
-- 
2.34.1

