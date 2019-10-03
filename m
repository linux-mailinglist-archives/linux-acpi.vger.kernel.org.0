Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5072AC9E89
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2019 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfJCMci (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Oct 2019 08:32:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:27929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbfJCMcb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Oct 2019 08:32:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 05:32:30 -0700
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="198516755"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 05:32:27 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 45320212BD;
        Thu,  3 Oct 2019 15:32:17 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1iG0HL-0002wf-Vc; Thu, 03 Oct 2019 15:32:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v9 11/12] lib/vsprintf: Add %pfw conversion specifier for printing fwnode names
Date:   Thu,  3 Oct 2019 15:32:18 +0300
Message-Id: <20191003123219.11237-12-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
support printing full path of the node, including its name ("f") and only
the node's name ("P") in the printk family of functions. The two flags
have equivalent functionality to existing %pOF with the same two modifiers
("f" and "P") on OF based systems. The ability to do the same on ACPI
based systems is added by this patch.

On ACPI based systems the resulting strings look like

	\_SB.PCI0.CIO2.port@1.endpoint@0

where the nodes are separated by a dot (".") and the first three are
ACPI device nodes and the latter two ACPI data nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst | 24 +++++++++++++++
 lib/vsprintf.c                            | 36 +++++++++++++++++++++++
 scripts/checkpatch.pl                     |  8 +++--
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 922a29eb70e6c..1ab3841686dc5 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -418,6 +418,30 @@ Examples::
 
 Passed by reference.
 
+Fwnode handles
+--------------
+
+::
+
+	%pfw[fP]
+
+For printing information on fwnode handles. The default is to print the full
+node name, including the path. The modifiers are functionally equivalent to
+%pOF above.
+
+	- f - full name of the node, including the path
+	- P - the name of the node including an address (if there is one)
+
+Examples (ACPI)::
+
+	%pfwf	\_SB.PCI0.CIO2.port@1.endpoint@0	- Full node name
+	%pfwP	endpoint@0				- Node name
+
+Examples (OF)::
+
+	%pfwf	/ocp@68000000/i2c@48072000/camera@10/port/endpoint - Full name
+	%pfwP	endpoint				- Node name
+
 Time and date (struct rtc_time)
 -------------------------------
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c56528dcc3d9..3b668ea2d1aca 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1982,6 +1982,36 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+static noinline_for_stack
+char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
+		    struct printf_spec spec, const char *fmt)
+{
+	struct printf_spec str_spec = spec;
+	char *buf_start = buf;
+
+	str_spec.field_width = -1;
+
+	if (*fmt != 'w')
+		return error_string(buf, end, "(%pf?)", spec);
+
+	if (check_pointer(&buf, end, fwnode, spec))
+		return buf;
+
+	fmt++;
+
+	switch (*fmt) {
+	case 'P':	/* name */
+		buf = string(buf, end, fwnode_get_name(fwnode), str_spec);
+		break;
+	case 'f':	/* full_name */
+	default:
+		buf = fwnode_full_name_string(fwnode, buf, end);
+		break;
+	}
+
+	return widen_string(buf, buf - buf_start, end, spec);
+}
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2086,6 +2116,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  *                  F device node flags
  *                  c major compatible string
  *                  C full compatible string
+ * - 'fw[fP]'	For a firmware node (struct fwnode_handle) pointer
+ *		Without an option prints the full name of the node
+ *		f full name
+ *		P node name, including a possible unit address
  * - 'x' For printing the address. Equivalent to "%lx".
  *
  * ** When making changes please also update:
@@ -2163,6 +2197,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return flags_string(buf, end, ptr, spec, fmt);
 	case 'O':
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
+	case 'f':
+		return fwnode_string(buf, end, ptr, spec, fmt + 1);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a60c241112cd4..726b6951bce78 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5988,14 +5988,18 @@ sub process {
 		        for (my $count = $linenr; $count <= $lc; $count++) {
 				my $specifier;
 				my $extension;
+				my $qualifier;
 				my $bad_specifier = "";
 				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
 				$fmt =~ s/%%//g;
 
-				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
+				while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w*))/g) {
 					$specifier = $1;
 					$extension = $2;
-					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
+					$qualifier = $3;
+					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
+					    ($extension eq "f" &&
+					     defined $qualifier && $qualifier !~ /^w/)) {
 						$bad_specifier = $specifier;
 						last;
 					}
-- 
2.20.1

