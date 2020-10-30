Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854FA29FECF
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 08:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgJ3Hmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 03:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgJ3HlF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B9622400;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043663;
        bh=FP3F4ZgL5XCH4fGqHCJkgaGUhs4N/I/277tGvHvCmsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXzxs/nlrS13EdTNsTRSK/h/RFOc2XD7SlAoOXDuxlx9+FidlLgUqfZUYITnUqDnS
         anZX/PFUAEixCDB2vSrgbwus68qavwqqb/KmXGhtQ0jK3RAcDqvBjePhwO3q6MLKMW
         1FF+RuGlstYZWgEOqWUU15wW1DKGExIDTRuv4PnM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004OgT-DD; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/39] docs: ABI: convert testing/configfs-acpi to ReST
Date:   Fri, 30 Oct 2020 08:40:46 +0100
Message-Id: <f56daf94b80f1051438e8c787ba04552adb66e67.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are some problems with this file when a ReST content
is produced. Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/configfs-acpi | 34 ++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-acpi b/Documentation/ABI/testing/configfs-acpi
index 4ab4e99aa863..c09b640c3cb1 100644
--- a/Documentation/ABI/testing/configfs-acpi
+++ b/Documentation/ABI/testing/configfs-acpi
@@ -14,7 +14,8 @@ Description:
 		This group contains the configuration for user defined ACPI
 		tables. The attributes of a user define table are:
 
-		aml 		- a binary attribute that the user can use to
+		aml
+			      - a binary attribute that the user can use to
 				fill in the ACPI aml definitions. Once the aml
 				data is written to this file and the file is
 				closed the table will be loaded and ACPI devices
@@ -26,11 +27,26 @@ Description:
 		The rest of the attributes are read-only and are valid only
 		after the table has been loaded by filling the aml entry:
 
-		signature 	- ASCII table signature
-		length 		- length of table in bytes, including the header
-		revision 	- ACPI Specification minor version number
-		oem_id 		- ASCII OEM identification
-		oem_table_id 	- ASCII OEM table identification
-		oem_revision 	- OEM revision number
-		asl_compiler_id - ASCII ASL compiler vendor ID
-		asl_compiler_revision - ASL compiler version
+		signature
+				- ASCII table signature
+
+		length
+				- length of table in bytes, including the header
+
+		revision
+				- ACPI Specification minor version number
+
+		oem_id
+				- ASCII OEM identification
+
+		oem_table_id
+				- ASCII OEM table identification
+
+		oem_revision
+				- OEM revision number
+
+		asl_compiler_id
+				- ASCII ASL compiler vendor ID
+
+		asl_compiler_revision
+				- ASL compiler version
-- 
2.26.2

