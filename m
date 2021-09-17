Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB940F94F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Sep 2021 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbhIQNgB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Sep 2021 09:36:01 -0400
Received: from foss.arm.com ([217.140.110.172]:53356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245321AbhIQNfp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 09:35:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C3713A1;
        Fri, 17 Sep 2021 06:34:23 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E57423F719;
        Fri, 17 Sep 2021 06:34:21 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 14/14] ACPI/PCC: Add myself as maintainer for PCC mailbox driver
Date:   Fri, 17 Sep 2021 14:33:57 +0100
Message-Id: <20210917133357.1911092-15-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917133357.1911092-1-sudeep.holla@arm.com>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Not much functionality is added since PCC driver was added 5 years ago.
There is need to restructure the driver while adding support for PCC
Extended subspaces type 3&4. There is more rework needed as more users
adopt PCC on arm64 platforms. In order to ease the same, I would like
to take responsibility to maintain this driver.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

Hi Rafael,

As you mentioned offline that you haven't followed ACPI PCC changes
much and don't have time to review this, I thought of adding myself
as maintainer for the ACPI PCC part of the mailbox as I will be tracking
and using PCCT. Let me know if you have any objections.

Regards,
Sudeep

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..8d41dd710ae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -401,6 +401,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/i2c-multi-instantiate.c
 
+ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-acpi@vger.kernel.org
+S:	Supported
+F:	drivers/mailbox/pcc.c
+
 ACPI PMIC DRIVERS
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Len Brown <lenb@kernel.org>
-- 
2.25.1

