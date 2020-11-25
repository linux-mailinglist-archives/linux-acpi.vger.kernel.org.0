Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916442C44BC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgKYQQ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 11:16:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:9130 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbgKYQQ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Nov 2020 11:16:58 -0500
IronPort-SDR: KZN+0tgX5IcgUfxhn27msJpqUaFciDDgtIK+fLHcTPI5VQGvFXTWNJzDchyddkE3+0Mf6eCPS2
 QqZGLcUjazqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="190299142"
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="190299142"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 08:16:29 -0800
IronPort-SDR: aFuMajIaf/Yarkt/9zkYbhOtoPGi40qljayuaXLUG55UoNU34DHebFeVDMJKaYi+xwsULkZajF
 REu8jFHWVrWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="535357184"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2020 08:16:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8800CFC; Wed, 25 Nov 2020 18:16:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] resource: provide meaningful MODULE_LICENSE() in test suite
Date:   Wed, 25 Nov 2020 18:16:26 +0200
Message-Id: <20201125161626.66180-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

modpost complains that module has no licence provided.
Provide it via meaningful MODULE_LICENSE().

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: resent with linux-acpi@ included
 kernel/resource_kunit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 9fdbca8426f1..58ab9f914602 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -148,3 +148,5 @@ static struct kunit_suite resource_test_suite = {
 	.test_cases = resource_test_cases,
 };
 kunit_test_suite(resource_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.29.2

