Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11129DE62
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 01:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgJ1WTL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 18:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbgJ1WRm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D77247BE;
        Wed, 28 Oct 2020 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895015;
        bh=FP3F4ZgL5XCH4fGqHCJkgaGUhs4N/I/277tGvHvCmsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMTh9xqjokxXlLHuHLEOZelkwQfZVpK4I7PevDGM+SnhbUOUqzF/YvjBAdVDwrhgU
         nwrAkBG8Ohqf77iyd0FCME73PVb1VKcPVyYdgid/UFcSJAakIZKzzP66vR1jhI7Sq4
         lRuPBHYAPdzHomZ2mXZMyzpfy/iBuqpyRM+2YYck=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMP-003hlv-FW; Wed, 28 Oct 2020 15:23:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/33] docs: ABI: convert testing/configfs-acpi to ReST
Date:   Wed, 28 Oct 2020 15:23:24 +0100
Message-Id: <7a278b19168593d905a0eabbd10ee5f8bbbcb935.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
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

