Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B463A26269
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 12:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfEVKvS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 06:51:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfEVKvS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 06:51:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 03:51:17 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 03:51:15 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 01/16] software node: Allow node creation without properties
Date:   Wed, 22 May 2019 13:50:58 +0300
Message-Id: <20190522105113.11153-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Software nodes are not forced to have device properties.
Adding check to property_entries_dup() to make it possible
to create software nodes that don't have any properties.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7fc5a18e02ad..30077454eb68 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -383,6 +383,9 @@ property_entries_dup(const struct property_entry *properties)
 	int i, n = 0;
 	int ret;
 
+	if (!properties)
+		return NULL;
+
 	while (properties[n].name)
 		n++;
 
-- 
2.20.1

