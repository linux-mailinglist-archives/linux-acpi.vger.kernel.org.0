Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381A6B920C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Sep 2019 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbfITO2Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Sep 2019 10:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389512AbfITO1D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Sep 2019 10:27:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8516920C01;
        Fri, 20 Sep 2019 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989621;
        bh=Kp0F9xN2DY9KI2mFHvBUHu7JeaG+dR9flgRLbMMsFb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lSu7XTlBVMrUGwrNJPF4Yo0VlQiHn6c3t/fp8gHGWeFTRgN6STBo/62eT6oHpd1M
         PbV/gcUXgJ3n/nH/yj5N4zUzfuklV6gJ2+GhauH/X8P6ti73rOSJpaTCanS5NTWjAA
         3JYqJC7UBv+it6c8rTlzyHNUNO6evNCz6FDzFoYY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Joe Perches <joe@perches.com>,
        linux-acpi@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/31] tools lib traceevent: Convert remaining %p[fF] users to %p[sS]
Date:   Fri, 20 Sep 2019 11:25:36 -0300
Message-Id: <20190920142542.12047-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

There are no in-kernel %p[fF] users left. Convert the traceevent tool,
too, to align with the kernel.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lore.kernel.org/lkml/20190918133419.7969-2-sakari.ailus@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-func_apis.txt  | 10 +++++-----
 tools/lib/traceevent/event-parse.c             | 18 ++++++++++++++----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt b/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
index 38bfea30a5f6..f6aca0df2151 100644
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
index bb22238debfe..6f842af4550b 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4367,10 +4367,20 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 					switch (*ptr) {
 					case 's':
 					case 'S':
-					case 'f':
-					case 'F':
 					case 'x':
 						break;
+					case 'f':
+					case 'F':
+						/*
+						 * Pre-5.5 kernels use %pf and
+						 * %pF for printing symbols
+						 * while kernels since 5.5 use
+						 * %pfw for fwnodes. So check
+						 * %p[fF] isn't followed by 'w'.
+						 */
+						if (ptr[1] != 'w')
+							break;
+						/* fall through */
 					default:
 						/*
 						 * Older kernels do not process
@@ -4487,12 +4497,12 @@ get_bprint_format(void *data, int size __maybe_unused,
 
 	printk = find_printk(tep, addr);
 	if (!printk) {
-		if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
+		if (asprintf(&format, "%%ps: (NO FORMAT FOUND at %llx)\n", addr) < 0)
 			return NULL;
 		return format;
 	}
 
-	if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)
+	if (asprintf(&format, "%s: %s", "%ps", printk->printk) < 0)
 		return NULL;
 
 	return format;
-- 
2.21.0

