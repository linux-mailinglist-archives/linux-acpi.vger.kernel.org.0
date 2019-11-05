Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE8EFAA2
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2019 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbfKEKPQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Nov 2019 05:15:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:43173 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387945AbfKEKPQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2019 05:15:16 -0500
X-IronPort-AV: E=Sophos;i="5.68,270,1569254400"; 
   d="scan'208";a="20242"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2019 18:15:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id DD15B4CE151A;
        Tue,  5 Nov 2019 18:07:09 +0800 (CST)
Received: from localhost.localdomain (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 5 Nov 2019 18:15:25 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: [PATCH] ACPI: OSI: Shoot duplicate word
Date:   Tue, 5 Nov 2019 18:15:01 +0800
Message-ID: <20191105101501.3291-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: DD15B4CE151A.A6788
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Cao jin <caoj.fnst@cn.fujitsu.com>

"this" is duplicated.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 drivers/acpi/osi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index bec0bebc7f52..9f6853809138 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -473,9 +473,9 @@ static const struct dmi_system_id acpi_osi_dmi_table[] __initconst = {
 	 */
 
 	/*
-	 * Without this this EEEpc exports a non working WMI interface, with
-	 * this it exports a working "good old" eeepc_laptop interface, fixing
-	 * both brightness control, and rfkill not working.
+	 * Without this EEEpc exports a non working WMI interface, with
+	 * this it exports a working "good old" eeepc_laptop interface,
+	 * fixing both brightness control, and rfkill not working.
 	 */
 	{
 	.callback = dmi_enable_osi_linux,
-- 
2.21.0



