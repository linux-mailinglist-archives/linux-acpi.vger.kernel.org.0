Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695C83F4766
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Aug 2021 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhHWJ0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Aug 2021 05:26:55 -0400
Received: from out0.migadu.com ([94.23.1.103]:24523 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231825AbhHWJ0v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Aug 2021 05:26:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629710768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FLB9DVMupAofSDipQoKcArGSgy4Sp+/fU10Kv3Cwb7k=;
        b=nrXp4Sg/AkFQluqeUN18PmL4fGD9l8DmQ97IS6QFQiVy14iO5vfDiji7v1A0S/iJIqTWdg
        0WEEW1MGKPCWkh6mwmX0EeEuS2WaILoY2XfNSZrRcDLnPh1Uhn4oGyuf/UJnBEF7CBMtwG
        E5G77p4OaMqKX7dtAz6QJh+sBURsWrs=
From:   Jackie Liu <liu.yun@linux.dev>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com
Cc:     linux-acpi@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] acpi/arm64: fix next_platform_timer() section mismatch error
Date:   Mon, 23 Aug 2021 17:25:26 +0800
Message-Id: <20210823092526.2407526-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Fix modpost Section mismatch error in next_platform_timer().

  [...]
  WARNING: modpost: vmlinux.o(.text.unlikely+0x26e60): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
  The function next_platform_timer() references
  the variable __initdata acpi_gtdt_desc.
  This is often because next_platform_timer lacks a __initdata
  annotation or the annotation of acpi_gtdt_desc is wrong.

  WARNING: modpost: vmlinux.o(.text.unlikely+0x26e64): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
  The function next_platform_timer() references
  the variable __initdata acpi_gtdt_desc.
  This is often because next_platform_timer lacks a __initdata
  annotation or the annotation of acpi_gtdt_desc is wrong.

  ERROR: modpost: Section mismatches detected.
  Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
  make[1]: *** [scripts/Makefile.modpost:59: vmlinux.symvers] Error 1
  make[1]: *** Deleting file 'vmlinux.symvers'
  make: *** [Makefile:1176: vmlinux] Error 2
  [...]

Fixes: a712c3ed9b8a ("acpi/arm64: Add memory-mapped timer support in GTDT driver")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 0a0a982f9c28..c0e77c1c8e09 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -36,7 +36,7 @@ struct acpi_gtdt_descriptor {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
-static inline void *next_platform_timer(void *platform_timer)
+static inline __init void *next_platform_timer(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
 
-- 
2.25.1

