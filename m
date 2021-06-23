Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20E3B1168
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 03:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFWBlP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 21:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFWBlO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Jun 2021 21:41:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A7D76137D;
        Wed, 23 Jun 2021 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624412338;
        bh=GPF0WU0fX1LOCzKrpyTOeYxkBOMEHDtAKOkeYmjfo8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1YI5HnYTyeZXNeF9zX3FAqL/vQJN7eiCcEDBH9KGqUjJxO+WbJpvD7fT8vesUzCX
         xbKr9ms5/f/ydCqnGR+Yv7XwGyiOymt61xUvbWkqzDYBhz3vs5eA+Rcg64rlptTJ1z
         422vq7MHqXonOZMZXS2K1ijVwAtJt9N0zwaHMvCZXsemu9xZR3+fFti35SczbsBVL7
         tKU2knxojUf9YNZwRGiQXjPQ7QPsavjeBqT92vjU3Wrz63OghvZFsGst2+LnXBb+OO
         1vTc9kwT9E/YMajGshwOSNw0s8ED5V8TMJ8Tb3/GT9eC15DnBFzfc34BAEVcIRUxoB
         WhgKdoIaNMN2A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] ACPI: bgrt: Use sysfs_emit
Date:   Tue, 22 Jun 2021 18:38:02 -0700
Message-Id: <20210623013802.1904951-2-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
In-Reply-To: <20210623013802.1904951-1-nathan@kernel.org>
References: <20210623013802.1904951-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

sysfs_emit is preferred to snprintf for emitting values after
commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format
sysfs output").

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/acpi/bgrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index e0d14017706e..02d208732f9a 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -19,7 +19,7 @@ static struct kobject *bgrt_kobj;
 	static ssize_t _name##_show(struct kobject *kobj,			\
 				    struct kobj_attribute *attr, char *buf)	\
 	{									\
-		return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab._member);	\
+		return sysfs_emit(buf, "%d\n", bgrt_tab._member);		\
 	}									\
 	struct kobj_attribute bgrt_attr_##_name = __ATTR_RO(_name)
 
-- 
2.32.0.93.g670b81a890

