Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF96A30BE
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Feb 2023 15:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBZOxG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Feb 2023 09:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjBZOwH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Feb 2023 09:52:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395CD12852;
        Sun, 26 Feb 2023 06:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B11CB80BAB;
        Sun, 26 Feb 2023 14:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3BAC4339B;
        Sun, 26 Feb 2023 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677422856;
        bh=3cHPdIx8yaZdN9E+LDZt4UvqpNDwAc4yywObzCervkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IN/H/tsMTrobReRCO/L2SRxpFIttl0upJ1MQLy1HFqVwFTCkh48aU+B/a9THL8VJL
         U1Wld8UdpHyhh70VldSPlozUDHYqELKQX8MdT7BeHHbf6q9d1HmfZt3wassvIhmQ+O
         rV5TYsWIpPIlvV4Xwf+7G/56W2wVTPfW/tSfwEk47Gcd7kJg2AiNe+4VxXGxr2giZ6
         s9WBA85ELAm4IlzDoHY2zboCPOnGxHrciUl6VNqOoxddTgccdYDGwxHPsCcVYzv38b
         wJuQi25wv4iEq3CE7mgz1yG76NDQDUG9zecIcnGAqBwldfEsBJfYxQ86vIp6phEjCW
         5jUBElniYW3kw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Florent Revest <revest@chromium.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Moore <robert.moore@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        acpica-devel@lists.linuxfoundation.org
Subject: [PATCH AUTOSEL 6.1 19/49] ACPI: Don't build ACPICA with '-Os'
Date:   Sun, 26 Feb 2023 09:46:19 -0500
Message-Id: <20230226144650.826470-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230226144650.826470-1-sashal@kernel.org>
References: <20230226144650.826470-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 8f9e0a52810dd83406c768972d022c37e7a18f1f ]

The ACPICA code has been built with '-Os' since the beginning of git
history, though there's no explanatory comment as to why.

This is unfortunate as GCC drops the alignment specificed by
'-falign-functions=N' when '-Os' is used, as reported in GCC bug 88345:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345

This prevents CONFIG_FUNCTION_ALIGNMENT and
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B from having their expected effect
on the ACPICA code. This is doubly unfortunate as in subsequent patches
arm64 will depend upon CONFIG_FUNCTION_ALIGNMENT for its ftrace
implementation.

Drop the '-Os' flag when building the ACPICA code. With this removed,
the code builds cleanly and works correctly in testing so far.

I've tested this by selecting CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y,
building and booting a kernel using ACPI, and looking for misaligned
text symbols:

* arm64:

  Before, v6.2-rc3:
    # uname -rm
    6.2.0-rc3 aarch64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    5009

  Before, v6.2-rc3 + fixed __cold:
    # uname -rm
    6.2.0-rc3-00001-g2a2bedf8bfa9 aarch64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    919

  After:
    # uname -rm
    6.2.0-rc3-00002-g267bddc38572 aarch64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    323
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
    0

* x86_64:

  Before, v6.2-rc3:
    # uname -rm
    6.2.0-rc3 x86_64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    11537

  Before, v6.2-rc3 + fixed __cold:
    # uname -rm
    6.2.0-rc3-00001-g2a2bedf8bfa9 x86_64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    2805

  After:
    # uname -rm
    6.2.0-rc3-00002-g267bddc38572 x86_64
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | wc -l
    1357
    # grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] ' | grep acpi | wc -l
    0

With the patch applied, the remaining unaligned text labels are a
combination of static call trampolines and labels in assembly, which can
be dealt with in subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-acpi@vger.kernel.org
Link: https://lore.kernel.org/r/20230123134603.1064407-4-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 59700433a96e5..f919811156b1f 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -3,7 +3,7 @@
 # Makefile for ACPICA Core interpreter
 #
 
-ccflags-y			:= -Os -D_LINUX -DBUILDING_ACPICA
+ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 # use acpi.o to put all files here into acpi.o modparam namespace
-- 
2.39.0

