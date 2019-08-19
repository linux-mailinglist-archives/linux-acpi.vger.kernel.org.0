Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17E09221B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfHSLW2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 07:22:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:16980 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfHSLW2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="202264268"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2019 04:22:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BD8E61A1; Mon, 19 Aug 2019 14:22:23 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 3/8] thunderbolt: Use 32-bit writes when writing ring producer/consumer
Date:   Mon, 19 Aug 2019 14:22:18 +0300
Message-Id: <20190819112223.15359-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The register access should be using 32-bit reads/writes according to the
datasheet. With the previous generation hardware 16-bit writes have been
working but starting with ICL this is not the case anymore so fix
producer/consumer register update to use correct width register address.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
 drivers/thunderbolt/nhi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 27fbe62c7ddd..9c782706e652 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -143,9 +143,20 @@ static void __iomem *ring_options_base(struct tb_ring *ring)
 	return io;
 }
 
-static void ring_iowrite16desc(struct tb_ring *ring, u32 value, u32 offset)
+static void ring_iowrite_cons(struct tb_ring *ring, u16 cons)
 {
-	iowrite16(value, ring_desc_base(ring) + offset);
+	/*
+	 * The other 16-bits in the register is read-only and writes to it
+	 * are ignored by the hardware so we can save one ioread32() by
+	 * filling the read-only bits with zeroes.
+	 */
+	iowrite32(cons, ring_desc_base(ring) + 8);
+}
+
+static void ring_iowrite_prod(struct tb_ring *ring, u16 prod)
+{
+	/* See ring_iowrite_cons() above for explanation */
+	iowrite32(prod << 16, ring_desc_base(ring) + 8);
 }
 
 static void ring_iowrite32desc(struct tb_ring *ring, u32 value, u32 offset)
@@ -197,7 +208,10 @@ static void ring_write_descriptors(struct tb_ring *ring)
 			descriptor->sof = frame->sof;
 		}
 		ring->head = (ring->head + 1) % ring->size;
-		ring_iowrite16desc(ring, ring->head, ring->is_tx ? 10 : 8);
+		if (ring->is_tx)
+			ring_iowrite_prod(ring, ring->head);
+		else
+			ring_iowrite_cons(ring, ring->head);
 	}
 }
 
@@ -662,7 +676,7 @@ void tb_ring_stop(struct tb_ring *ring)
 
 	ring_iowrite32options(ring, 0, 0);
 	ring_iowrite64desc(ring, 0, 0);
-	ring_iowrite16desc(ring, 0, ring->is_tx ? 10 : 8);
+	ring_iowrite32desc(ring, 0, 8);
 	ring_iowrite32desc(ring, 0, 12);
 	ring->head = 0;
 	ring->tail = 0;
-- 
2.23.0.rc1

