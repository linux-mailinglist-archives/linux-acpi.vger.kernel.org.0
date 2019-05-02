Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924AA122F3
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2019 22:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfEBUAy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 May 2019 16:00:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBUAx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 May 2019 16:00:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8047A308620E;
        Thu,  2 May 2019 20:00:53 +0000 (UTC)
Received: from lszubowi.bos.redhat.com (dhcp-17-123.bos.redhat.com [10.18.17.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA89A4274;
        Thu,  2 May 2019 20:00:52 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     rjw@rjwysocki.net, lenb@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: ACPI / LPIT: Correct LPIT end address for lpit_process()
Date:   Thu,  2 May 2019 16:00:52 -0400
Message-Id: <20190502200052.26754-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 02 May 2019 20:00:53 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Correct the LPIT end address which is passed into lpit_process()
and the end address limit test in lpit_process().

The LPI state descriptor subtables follow the fixed sized
acpi_lpit_header up to the end of the LPIT. The last LPI state
descriptor can end at exactly the end of the LPIT.

Note that this is a fix to a latent problem. Although incorrect,
the unpatched version works because the passed in end address
is just slightly beyond the actual end of the LPIT and the size
of the ACPI LPIT header is smaller than the size of the only
currently defined LPI state descriptor, acpi_lpit_native.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 drivers/acpi/acpi_lpit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index e43cb71b6972..8b170a07908a 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -137,7 +137,7 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 
 static void lpit_process(u64 begin, u64 end)
 {
-	while (begin + sizeof(struct acpi_lpit_native) < end) {
+	while (begin + sizeof(struct acpi_lpit_native) <= end) {
 		struct acpi_lpit_native *lpit_native = (struct acpi_lpit_native *)begin;
 
 		if (!lpit_native->header.type && !lpit_native->header.flags) {
@@ -156,7 +156,6 @@ static void lpit_process(u64 begin, u64 end)
 void acpi_init_lpit(void)
 {
 	acpi_status status;
-	u64 lpit_begin;
 	struct acpi_table_lpit *lpit;
 
 	status = acpi_get_table(ACPI_SIG_LPIT, 0, (struct acpi_table_header **)&lpit);
@@ -164,6 +163,6 @@ void acpi_init_lpit(void)
 	if (ACPI_FAILURE(status))
 		return;
 
-	lpit_begin = (u64)lpit + sizeof(*lpit);
-	lpit_process(lpit_begin, lpit_begin + lpit->header.length);
+	lpit_process((u64)lpit + sizeof(*lpit),
+		     (u64)lpit + lpit->header.length);
 }
-- 
2.18.1

