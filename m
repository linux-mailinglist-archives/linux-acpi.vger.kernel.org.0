Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E81C4B42
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 03:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEEBIi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 21:08:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:50714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgEEBIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 21:08:37 -0400
IronPort-SDR: 1ibL4Tv64an3xcxABkjQHZMU8cMYvk0RqR25sHlcoTV58GOXog6TORfAzs3p5bmAaSEnOfVpzZ
 +JcXadiNXqDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:08:36 -0700
IronPort-SDR: IYUYGFACsZMSJXqWrP9+gYCdWlCkvatKcQBFR1PkAUVNgBGIBVU69WCdNfb2iEKe5i7rsJUWA8
 czE0Pc8Fcnqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460865801"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 18:08:35 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Paul A Lohr <paul.a.lohr@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 5/6] ACPICA: Fix required parameters for _NIG and _NIH
Date:   Mon,  4 May 2020 17:46:53 -0700
Message-Id: <20200505004654.2870591-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505004654.2870591-1-erik.kaneda@intel.com>
References: <20200505004654.2870591-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 4b0e043386c7e698bea9e862f60a388647f56622

Previously, there was a mixup where _NIG required one parameter and
_NIH required zero parameters. This changes swaps these parameter
requirements. Now this change requires _NIH to be called with one
parameter and _NIG requires zero.

Link: https://github.com/acpica/acpica/commit/4b0e0433
Reported-by: Paul A Lohr <paul.a.lohr@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index cd0f5df0ea23..2cbb56652f1c 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -640,10 +640,10 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	{{"_NIC", METHOD_0ARGS,	/* ACPI 6.3 */
 	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
 
-	{{"_NIG", METHOD_1ARGS(ACPI_TYPE_BUFFER),	/* ACPI 6.3 */
+	{{"_NIG", METHOD_0ARGS, /* ACPI 6.3 */
 	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
 
-	{{"_NIH", METHOD_0ARGS,	/* ACPI 6.3 */
+	{{"_NIH", METHOD_1ARGS(ACPI_TYPE_BUFFER), /* ACPI 6.3 */
 	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
 
 	{{"_NTT", METHOD_0ARGS,
-- 
2.25.1

