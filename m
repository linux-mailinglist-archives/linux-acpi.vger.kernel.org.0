Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD28E555
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfD2Oup (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 10:50:45 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:46648 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfD2Oup (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 10:50:45 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-03.nifty.com with ESMTP id x3TEkG9M011741
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2019 23:46:16 +0900
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x3TEjcf1013725;
        Mon, 29 Apr 2019 23:45:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x3TEjcf1013725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556549139;
        bh=KazEk9hxi8U+torRKasXD0v/5Dw35CGY2jNpa95zJ0k=;
        h=From:To:Cc:Subject:Date:From;
        b=x3p/1yoTt1qfBJ8BtWa/94gnwhth+mOGtXYdZrowO8QhSTpN7y82EP7/u3zdrRv79
         b4eqIxKtVy9ER/h7dUGxDCT+7U8Rc8dVwzL9l0yvpAsyqRHhs9irkjuoUiWHK2peHz
         ElHU7+A7RnA+O+EJaHNTwi3ajpDNSFOGWFtu8QX6i5UQdh1j0YDCupXuiB6S/2IcY7
         s5IhzdeztEupu1nWn4LcYWSh2B6d8p3yDWgVzjXfW2sICRxxtfxi3lSFMzICQyMxrj
         8yshP3fcBlqwU23KKddnq6cQxFvkt7kdn6VObZDd65LvV6VwTEFoCgjcxIDb0+FShJ
         U7JRKPlkDHkAw==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org,
        Erik Schmauss <erik.schmauss@intel.com>, devel@acpica.org
Subject: [PATCH] tools/power/acpi: exclude tools/* from .gitignore pattern
Date:   Mon, 29 Apr 2019 23:45:06 +0900
Message-Id: <1556549106-16119-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tools/power/acpi/.gitignore has the following entries:

  acpidbg
  acpidump
  ec

They are intended to ignore the following build artifacts:

  tools/power/acpi/acpidbg
  tools/power/acpi/acpidump
  tools/power/acpi/ec

However, those .gitignore entries are effective not only for the
current directory, but also for any sub-directories.

So, the following directories are also considered to be ignored:

  tools/power/acpi/tools/acpidbg
  tools/power/acpi/tools/acpidump
  tools/power/acpi/tools/ec

They are obviously version-controlled, so should be excluded from the
.gitignore patterns.

You can fix it by prefixing the patterns with '/', which means they
are only effective in the current directory.

I also prefixed the "include" consistently. IMHO, '/' prefixing is
safer when you intend to ignore specific files or directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 tools/power/acpi/.gitignore | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
index cba3d99..f698a0e 100644
--- a/tools/power/acpi/.gitignore
+++ b/tools/power/acpi/.gitignore
@@ -1,4 +1,4 @@
-acpidbg
-acpidump
-ec
-include
+/acpidbg
+/acpidump
+/ec
+/include/
-- 
2.7.4

