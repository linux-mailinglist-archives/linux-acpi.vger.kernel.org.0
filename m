Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A506301B6A
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Jan 2021 12:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhAXLep (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Jan 2021 06:34:45 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:56695 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhAXLek (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Jan 2021 06:34:40 -0500
Received: from localhost.localdomain ([92.131.99.25])
        by mwinf5d43 with ME
        id LbYv240060Ys01Y03bYvtp; Sun, 24 Jan 2021 12:32:57 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Jan 2021 12:32:57 +0100
X-ME-IP: 92.131.99.25
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ACPICA: Common: Fix a typo
Date:   Sun, 24 Jan 2021 12:32:52 +0100
Message-Id: <20210124113252.733716-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This module is 'cmfsize', not 'cfsize'.
Fix it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 tools/power/acpi/common/cmfsize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index 9ea2c0aeb86c..185b8c588e1d 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
 /******************************************************************************
  *
- * Module Name: cfsize - Common get file size function
+ * Module Name: cmfsize - Common get file size function
  *
  * Copyright (C) 2000 - 2021, Intel Corp.
  *
-- 
2.27.0

