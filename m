Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D664918C9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jan 2022 03:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbiARCsY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jan 2022 21:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345482AbiARCbf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2022 21:31:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77FC061763;
        Mon, 17 Jan 2022 18:29:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC556117D;
        Tue, 18 Jan 2022 02:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1096DC36AEB;
        Tue, 18 Jan 2022 02:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642472964;
        bh=/nQm1xNgpdAOTxyswTWsS/Qa079KxmX+Nz2TBRcCI6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clDhxAnGr4ayCHX+ZNSThf6MkW9Rbad4DQEfPCQSlrvbY5f8Mjj986Yp9rKUXaXKK
         0BwPmA//OhJZA5LCTdcqRtQXAlwOF5kNKORcp5tC2+crY6VfXk+YtbEINVkVknAhAX
         tULUqc7Ad0M5pnDD3+rqjPPQpQBhJy0XXLVaf9/M0XDSmLOLPQahnjFno3/z2f78un
         BgOLr0jaTZ0Y41NlCaaFF6Nzp4YxLTlI5QQ7WdXEvRvZn3tV2p8mG2Skl7/NHqWh+E
         +tyvLlpqDOuRAVj7nLHjOiyJG3x9pd+vNdfAMQ80wf8V+jtcFcK46WoADkl9AsCofu
         x4pukWzU5Ze/w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Bob Moore <robert.moore@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH AUTOSEL 5.16 181/217] ACPICA: Executer: Fix the REFCLASS_REFOF case in acpi_ex_opcode_1A_0T_1R()
Date:   Mon, 17 Jan 2022 21:19:04 -0500
Message-Id: <20220118021940.1942199-181-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 24ea5f90ec9548044a6209685c5010edd66ffe8f ]

ACPICA commit d984f12041392fa4156b52e2f7e5c5e7bc38ad9e

If Operand[0] is a reference of the ACPI_REFCLASS_REFOF class,
acpi_ex_opcode_1A_0T_1R () calls acpi_ns_get_attached_object () to
obtain return_desc which may require additional resolution with
the help of acpi_ex_read_data_from_field (). If the latter fails,
the reference counter of the original return_desc is decremented
which is incorrect, because acpi_ns_get_attached_object () does not
increment the reference counter of the object returned by it.

This issue may lead to premature deletion of the attached object
while it is still attached and a use-after-free and crash in the
host OS.  For example, this may happen when on evaluation of ref_of()
a local region field where there is no registered handler for the
given Operation Region.

Fix it by making acpi_ex_opcode_1A_0T_1R () return Status right away
after a acpi_ex_read_data_from_field () failure.

Link: https://github.com/acpica/acpica/commit/d984f120
Link: https://github.com/acpica/acpica/pull/685
Reported-by: Lenny Szubowicz <lszubowi@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/exoparg1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index b639e930d6429..44b7c350ed5ca 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -1007,7 +1007,8 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 						    (walk_state, return_desc,
 						     &temp_desc);
 						if (ACPI_FAILURE(status)) {
-							goto cleanup;
+							return_ACPI_STATUS
+							    (status);
 						}
 
 						return_desc = temp_desc;
-- 
2.34.1

