Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A22682387
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2019 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfHERDu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Aug 2019 13:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfHERDu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Aug 2019 13:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 976D0369D3;
        Mon,  5 Aug 2019 17:03:49 +0000 (UTC)
Received: from masetto.com (ovpn-117-160.phx2.redhat.com [10.3.117.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF6CB5DA21;
        Mon,  5 Aug 2019 17:03:46 +0000 (UTC)
From:   Al Stone <ahs3@redhat.com>
To:     linux-acpi@vger.kernel.org
Cc:     Al Stone <ahs3@redhat.com>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI / CPPC: do not require the _PSD method when using CPPC
Date:   Mon,  5 Aug 2019 11:03:38 -0600
Message-Id: <20190805170338.29493-1-ahs3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 05 Aug 2019 17:03:49 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

According to the ACPI 6.3 specification, the _PSD method is optional
when using CPPC.  The underlying assumption appears to be that each CPU
can change frequency independently from all other CPUs; _PSD is provided
to tell the OS that some processors can NOT do that.

However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
method present, or an ACPI error status if an error occurs when evaluating
_PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
in violation of the specification, and only on Linux.

This has forced some firmware writers to provide a dummy _PSD, even though
it is irrelevant, but only because Linux requires it; other OSPMs follow
the spec.  We really do not want to have OS specific ACPI tables, though.

So, correct acpi_get_psd() so that it does not return an error if there
is no _PSD method present, but does return a failure when the method can
not be executed properly.  This allows _PSD to be optional as it should
be.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 15f103d7532b..e9ecfa13e997 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
 	union acpi_object  *psd = NULL;
 	struct acpi_psd_package *pdomain;
 
-	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
-			ACPI_TYPE_PACKAGE);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
+	if (acpi_has_method(handle, "_PSD")) {
+		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
+						    &buffer, ACPI_TYPE_PACKAGE);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+	} else
+		return 0;		/* _PSD is optional */
 
 	psd = buffer.pointer;
 	if (!psd || psd->package.count != 1) {
-- 
2.21.0

