Return-Path: <linux-acpi+bounces-1449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B72F7E9EE1
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880DB280DBE
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F9210FB
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5B1DFE4
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 13:15:21 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86755D6C;
	Mon, 13 Nov 2023 05:15:17 -0800 (PST)
Received: from [10.28.138.149] (port=17042 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1r2WmW-0000gj-5s; Mon, 13 Nov 2023 16:15:13 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1102.mail.hosting.nic.ru (Exim 5.55)
	with id 1r2WmW-00A2aA-2O;
	Mon, 13 Nov 2023 16:15:12 +0300
Message-ID: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
Date: Mon, 13 Nov 2023 16:15:11 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPICA: debugger: check status of acpi_evaluate_object in
 acpi_db_walk_for_fields
To: Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Len Brown <lenb@kernel.org>, Erik Kaneda <erik.kaneda@intel.com>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

Errors in acpi_evaluate_object can lead to incorrect state of buffer.
This can lead to access to data in previously ACPI_FREEd buffer and
secondary ACPI_FREE to the same buffer later.

Handle errors in acpi_evaluate_object the same way it is done earlier
with acpi_ns_handle_to_pathname.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5fd033288a86 ("ACPICA: debugger: add command to dump all fields 
of particular subtype")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/acpica/dbnames.c | 8 ++++++--
  1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index b91155ea9c34..c9131259f717 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
  	ACPI_FREE(buffer.pointer);
   	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
-
+	status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not evaluate object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
  	/*
  	 * Since this is a field unit, surround the output in braces
  	 */
-- 
2.34.1


