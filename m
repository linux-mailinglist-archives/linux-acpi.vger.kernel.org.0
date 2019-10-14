Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154F3D6C44
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 01:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfJNX5x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Oct 2019 19:57:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44226 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfJNX5w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Oct 2019 19:57:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so8668585pll.11;
        Mon, 14 Oct 2019 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvXicvKODDLIBrrmqaNFFvvMmJzFOFLga8h9y3ZgZGc=;
        b=IxuAc88QtjB+R1hTHXCTLux1d9f6r1BsDQ5Cbfit9zZ5g5PKFdHOoc1N7Hoghz+zvB
         hrbzn9MYAxffJvXXRzkiFE0en0cir+eBsQ82qbaX12xegOYP5kdFENTxBR1TmxTPloru
         /fwWhtQr52rqIefsqSYphEyLClfmYN3IgCtbOdYMOx2hzJHah3NUAlztMfaltRVihCRK
         Q2y7UyiSI+2Wo3TUu1upsqn0emTa5udSO906FvxYFwqlSvIldo/nL+H0BECy/ghcyQos
         /XfPZMF0gb4LYMYrcY2ijnXJ1lbWxxUlFO0Adm9jNZsMiK/F6rZy4kF0df6UMKPqst77
         qFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvXicvKODDLIBrrmqaNFFvvMmJzFOFLga8h9y3ZgZGc=;
        b=j47E/XtL7IlPMi4xilOe9odDXR5Tg16c8ZTLVlElz6uIheKmmMJivuVbaXl0erj7dZ
         UFoo9fCrqd/XKagg4IOUsstJq2VflQbKMIbWDz62QIHd6fms5Me1valN2c4rUr38UdTj
         EL7lWoz2Wq5HfHteHQ7LNGPs9hjYPBpJtXW644nwnF5b3dsyCtJIg/O5H6rVhwWIvpdX
         SUdAhs02RWM82qGVtJoPmqEbeiGB9G2p5sKFfslpJTGovwIVNegUL7fnh3GtN4Qc+7WR
         KkevG6cRYxNjpwFoMOJgvApfkHxt7/MuEXHZ/UjpuSeNfcEUZElu8x0yz/xDvwClsOwP
         Ec3A==
X-Gm-Message-State: APjAAAVG4PkR7MiO5wQUVHZ1LWw+o7HOHxmdNw744BI5FzFvGCdbGyzQ
        dXiXX+3Pi/AQF0gWpuKQt6k=
X-Google-Smtp-Source: APXvYqwMpDhZmsbOwgQ61I4KBxC7rbT1HjnTGoHHSJFP+sCgNEt7Uw3duYXbb1+UcEXxmo1MbaF/HQ==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr33076756plp.218.1571097471651;
        Mon, 14 Oct 2019 16:57:51 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h6sm24862693pfg.123.2019.10.14.16.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 16:57:50 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:57:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 00/14] software node: add support for reference
 properties
Message-ID: <20191014235747.GA105649@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191014073837.GI32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014073837.GI32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 14, 2019 at 10:38:37AM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 04:07:07PM -0700, Dmitry Torokhov wrote:
> > These series implement "references" properties for software nodes as true
> > properties, instead of managing them completely separately.
> > 
> > The first 10 patches are generic cleanups and consolidation and
> > unification of the existing code; patch #11 implements moving of small
> > properties inline when copying property entries; patch #12 implements
> > PROPERTY_ENTRY_REF() and friends; patch #13 converts the user of
> > references to the property syntax, and patch #14 removes the remains of
> > references as entities that are managed separately.
> 
> Can we get some test cases?

Something like this? (I'll beef it up if we decide KUnit is OK for
this).

From 0b8256ceed44760e63becb5b9636099d9fc17a4c Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 14 Oct 2019 16:55:12 -0700
Subject: [PATCH] software node: add basic init tests

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/test/Makefile              |  2 +
 drivers/base/test/property-entry-test.c | 56 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 drivers/base/test/property-entry-test.c

diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 0f1f7277a013..22143102e5d2 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
+
+obj-$(CONFIG_KUNIT) += property-entry-test.o
diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
new file mode 100644
index 000000000000..cd6a405734a0
--- /dev/null
+++ b/drivers/base/test/property-entry-test.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// Unit tests for property entries API
+//
+// Copyright 2019 Google LLC.
+
+#include <kunit/test.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+static void pe_test_move_inline_u8(struct kunit *test)
+{
+	u8 u8_array_small[8] = { 0 };
+	u8 u8_array_big[128] = { 0 };
+	struct property_entry entries[] = {
+		PROPERTY_ENTRY_U8_ARRAY("small", u8_array_small),
+		PROPERTY_ENTRY_U8_ARRAY("big", u8_array_big),
+		{ }
+	};
+	struct property_entry *copy;
+
+	copy = property_entries_dup(entries);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy);
+	KUNIT_EXPECT_TRUE(test, copy[0].is_inline);
+	KUNIT_EXPECT_FALSE(test, copy[1].is_inline);
+}
+
+static void pe_test_move_inline_str(struct kunit *test)
+{
+	char *str_array_small[] = { "a" };
+	char *str_array_big[] = { "a", "b", "c", "d" };
+	struct property_entry entries[] = {
+		PROPERTY_ENTRY_STRING_ARRAY("small", str_array_small),
+		PROPERTY_ENTRY_STRING_ARRAY("big", str_array_big),
+		{ }
+	};
+	struct property_entry *copy;
+
+	copy = property_entries_dup(entries);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy);
+	KUNIT_EXPECT_TRUE(test, copy[0].is_inline);
+	KUNIT_EXPECT_FALSE(test, copy[1].is_inline);
+}
+
+
+static struct kunit_case property_entry_test_cases[] = {
+	KUNIT_CASE(pe_test_move_inline_u8),
+	KUNIT_CASE(pe_test_move_inline_str),
+	{ }
+};
+
+static struct kunit_suite property_entry_test_suite = {
+	.name = "property-entry",
+	.test_cases = property_entry_test_cases,
+};
+
+kunit_test_suite(property_entry_test_suite);
-- 
2.23.0.700.g56cf767bdb-goog


-- 
Dmitry
