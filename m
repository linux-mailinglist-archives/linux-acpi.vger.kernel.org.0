Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1098AAE5DE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2019 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbfIJIrN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Sep 2019 04:47:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:21856 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbfIJIrM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Sep 2019 04:47:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:12 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="335852641"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:07 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 8C39D20A0F;
        Tue, 10 Sep 2019 11:47:05 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i7bnn-0004nN-7g; Tue, 10 Sep 2019 11:47:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        linux-trace-devel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v6 01/12] tools lib traceevent: Convert remaining %p[fF] users to %p[sS]
Date:   Tue, 10 Sep 2019 11:46:56 +0300
Message-Id: <20190910084707.18380-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are no in-kernel %p[fF] users left. Convert the traceevent tool,
too, to align with the kernel.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: linux-trace-devel@vger.kernel.org
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 .../Documentation/libtraceevent-func_apis.txt          | 10 +++++-----
 tools/lib/traceevent/event-parse.c                     |  7 +++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt b/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
index 38bfea30a5f64..f6aca0df2151a 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
@@ -59,12 +59,12 @@ parser context.
 
 The _tep_register_function()_ function registers a function name mapped to an
 address and (optional) module. This mapping is used in case the function tracer
-or events have "%pF" or "%pS" parameter in its format string. It is common to
-pass in the kallsyms function names with their corresponding addresses with this
+or events have "%pS" parameter in its format string. It is common to pass in
+the kallsyms function names with their corresponding addresses with this
 function. The _tep_ argument is the trace event parser context. The _name_ is
-the name of the function, the string is copied internally. The _addr_ is
-the start address of the function. The _mod_ is the kernel module
-the function may be in (NULL for none).
+the name of the function, the string is copied internally. The _addr_ is the
+start address of the function. The _mod_ is the kernel module the function may
+be in (NULL for none).
 
 The _tep_register_print_string()_ function  registers a string by the address
 it was stored in the kernel. Some strings internal to the kernel with static
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index b36b536a9fcba..1d7927ff32660 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4335,8 +4335,6 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 					switch (*ptr) {
 					case 's':
 					case 'S':
-					case 'f':
-					case 'F':
 					case 'x':
 						break;
 					default:
@@ -4455,12 +4453,13 @@ get_bprint_format(void *data, int size __maybe_unused,
 
 	printk = find_printk(tep, addr);
 	if (!printk) {
-		if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
+		if (asprintf(&format, "%%ps: (NO FORMAT FOUND at %llx)\n",
+			     addr) < 0)
 			return NULL;
 		return format;
 	}
 
-	if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)
+	if (asprintf(&format, "%s: %s", "%ps", printk->printk) < 0)
 		return NULL;
 
 	return format;
-- 
2.20.1

