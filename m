Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF94193E6
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Sep 2021 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhI0MPV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Sep 2021 08:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhI0MPV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Sep 2021 08:15:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75E6D60F94;
        Mon, 27 Sep 2021 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632744823;
        bh=8u31DX783FdC23lJsimtIilUO38jZwFeE1YBJx/LGoc=;
        h=From:To:Cc:Subject:Date:From;
        b=UpUByMnIr/ZS/ZRpyvut2oEJ2FTzjyfQi7zLMWh9tZ1KvciN7L1PZl6CizIgwKfZl
         E+aOeb0YY14mId2O++/pwcxEXLNEt8v+nCxj9kry06OsZZyQ4j7+fQp33syzmBOxuM
         e5XQoOHLo0mFPcgNI9yY56MaZpZBtN9VaOMtHl4PN/wCVokhhc8KGi5pKFxBalykFh
         HQRkepe7RDmxd3BR/V1EAfy5qQRdboB8AWS1n4AatNMFdOgeOdJAGY9caUZZgvJzLQ
         S2Uwuv6jsVOpNEhe5jgQvH2qnioYdDE7Ral3+ABwNzFajOl8PKFjzH7Lnj2NSm1wkD
         pgpNbcHhIdQMw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] ACPI: avoid NULL pointer arithmetic
Date:   Mon, 27 Sep 2021 14:13:22 +0200
Message-Id: <20210927121338.938994-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are some very old macros for doing an open-coded offsetof() and
cast between pointer and integer in ACPI headers. clang-14 now complains
about these:

drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtraction with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtraction]
         ACPI_FADT_OFFSET(pm_timer_block),
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSET'
 #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
 #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
 #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
                                                                              ^ ~~~~~~~~~~~~~~~~~~~~~~~
Convert them to the modern equivalents.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/acpi/actypes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 92c71dfce0d5..285bc7b73de3 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -507,8 +507,8 @@ typedef u64 acpi_integer;
 /* Pointer/Integer type conversions */
 
 #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
-#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
-#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
+#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
+#define ACPI_OFFSET(d, f)               offsetof(d, f)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
-- 
2.29.2

