Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF781087E
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfEANxl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 09:53:41 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:65220 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfEANxl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 May 2019 09:53:41 -0400
X-Greylist: delayed 169645 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 May 2019 09:53:39 EDT
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x41Dr9KW001783;
        Wed, 1 May 2019 22:53:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x41Dr9KW001783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556718790;
        bh=f6uJF7746NTCDxjp6+FkBz2Du0qsSubKTcds7GgCmco=;
        h=From:To:Cc:Subject:Date:From;
        b=SJA5DhTTi821Pj+Q5LYIHqGxGy2XM2r0Ng2p26UQO6PkIgt+5rBBRp0Cyhe1KOTYw
         nwONMzvbm9uYd0isyedRBSvziHXPGi4B/E35xIPVpGe4uRXCFeIrPDFT5HQosLhJSp
         zRT/GT7NzuED8Uq7Qjurvb2F1CH4AIhVjKOqKkIbTKiu2lcOLeCrZByp16SN0rUAvV
         BjwCX3YH7R76EGw58UrGw81RFCjob7ELLodCd6qsTQYWvhKS9gAs/OU30h8YsMO2Y+
         kh3RqFXH2jdbHCKPM41ZMrt/OMy8OUCUDBNWRf/izouPRkjOJLs6IlEn6ml2iyIPNj
         uFGhca07xFLcg==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>, devel@acpica.org
Subject: [PATCH v2] tools/power/acpi: exclude tools/* from .gitignore pattern
Date:   Wed,  1 May 2019 22:53:05 +0900
Message-Id: <1556718785-4417-1-git-send-email-yamada.masahiro@socionext.com>
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

So, from the point of .gitignore grammar, the following check-in
directories are also considered to be ignored:

  tools/power/acpi/tools/acpidbg
  tools/power/acpi/tools/acpidump
  tools/power/acpi/tools/ec

As the manual gitignore(5) says "Files already tracked by Git are not
affected", this is not a problem as far as Git is concerned.

However, Git is not the only program that parses .gitignore because
.gitignore is useful to distinguish build artifacts from source files.

For example, tar(1) supports the --exclude-vcs-ignore option. As of
writing, this option does not work perfectly, but it intends to create
a tarball excluding files specified by .gitignore.

So, I believe it is better to fix this issue.

You can fix it by prefixing the pattern with a slash; the leading slash
means the specified pattern is relative to the current directory.

I also prefixed the "include" consistently. IMHO, it is safer when you
intend to ignore specific files or directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add more information to the commit log to clarify my main motivation

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

