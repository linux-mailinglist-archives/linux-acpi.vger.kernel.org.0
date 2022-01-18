Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2166491B49
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jan 2022 04:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353820AbiARDEl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jan 2022 22:04:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59028 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350010AbiARCu7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2022 21:50:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91DCBB81250;
        Tue, 18 Jan 2022 02:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30D7C36AF4;
        Tue, 18 Jan 2022 02:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642474257;
        bh=ZzK+2SGE79mfIfB99YLPe0DxQhuLsDGpW7dwz+d8KhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEJAxU5bHc/4bmyaLIugwFpBoVSzWtLc+xB4mzkPlcQRkIqivV4fze0vuj9rOGboc
         iT7shkmZkiqPs8oGjCCSJ+8PU/Und/PoFzEKl9dBJ/ey3CSdPzUUNrqcrnC04Nj9JQ
         WiPMctynN3v8kJZ/EIlwe22fuY5fmpZcsZRwxbv6ylVn0kyrxDBxkD6H2VPsXFrjCT
         mdip+EZQjtmc/06m9EzGzZI9w9nSKd2TDtW6RA6Rc5djMcGC3P4xd4tCOoLuhnLkj1
         3n1ajkrhAUhWzHOR6zvtrcr8j+VZXkCod7SYFzNuZkhrHldKw9Tdanmoccv7u6VDJx
         d2CZlGLo9xf6w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        Bob Moore <robert.moore@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH AUTOSEL 4.14 44/56] ACPICA: Utilities: Avoid deleting the same object twice in a row
Date:   Mon, 17 Jan 2022 21:48:56 -0500
Message-Id: <20220118024908.1953673-44-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024908.1953673-1-sashal@kernel.org>
References: <20220118024908.1953673-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 1cdfe9e346b4c5509ffe19ccde880fd259d9f7a3 ]

ACPICA commit c11af67d8f7e3d381068ce7771322f2b5324d687

If original_count is 0 in acpi_ut_update_ref_count (),
acpi_ut_delete_internal_obj () is invoked for the target object, which is
incorrect, because that object has been deleted once already and the
memory allocated to store it may have been reclaimed and allocated
for a different purpose by the host OS.  Moreover, a confusing debug
message following the "Reference Count is already zero, cannot
decrement" warning is printed in that case.

To fix this issue, make acpi_ut_update_ref_count () return after finding
that original_count is 0 and printing the above warning.

Link: https://github.com/acpica/acpica/commit/c11af67d
Link: https://github.com/acpica/acpica/pull/652
Reported-by: Mark Asselstine <mark.asselstine@windriver.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/utdelete.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 61a979d0fbc5a..64a90ba71f18c 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -442,6 +442,7 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 			ACPI_WARNING((AE_INFO,
 				      "Obj %p, Reference Count is already zero, cannot decrement\n",
 				      object));
+			return;
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-- 
2.34.1

