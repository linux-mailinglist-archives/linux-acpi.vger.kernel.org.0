Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3FC5A51B3
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 10:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfIBIdB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 04:33:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:28818 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfIBIcp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 04:32:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:32:42 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="211625735"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:32:40 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 28ACA2102C;
        Mon,  2 Sep 2019 11:32:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4hlQ-0005Jq-FL; Mon, 02 Sep 2019 11:32:40 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v4 09/11] lib/vsprintf: OF nodes are first and foremost, struct device_nodes
Date:   Mon,  2 Sep 2019 11:32:38 +0300
Message-Id: <20190902083240.20367-10-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Factor out static kobject_string() function that simply calls
device_node_string(), and thus remove references to kobjects (as these are
struct device_node).

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 lib/vsprintf.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a04a2167101ef..4ad9332d54ba6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1905,6 +1905,9 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	struct printf_spec str_spec = spec;
 	str_spec.field_width = -1;
 
+	if (fmt[0] != 'F')
+		return error_string(buf, end, "(%pO?)", spec);
+
 	if (!IS_ENABLED(CONFIG_OF))
 		return error_string(buf, end, "(%pOF?)", spec);
 
@@ -1978,17 +1981,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
-static char *kobject_string(char *buf, char *end, void *ptr,
-			    struct printf_spec spec, const char *fmt)
-{
-	switch (fmt[1]) {
-	case 'F':
-		return device_node_string(buf, end, ptr, spec, fmt + 1);
-	}
-
-	return error_string(buf, end, "(%pO?)", spec);
-}
-
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2167,7 +2159,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'G':
 		return flags_string(buf, end, ptr, spec, fmt);
 	case 'O':
-		return kobject_string(buf, end, ptr, spec, fmt);
+		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}
-- 
2.20.1

