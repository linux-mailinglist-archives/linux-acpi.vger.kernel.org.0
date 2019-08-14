Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83288DFD5
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfHNVb0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:31:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfHNVbZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 17:31:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so426596wrf.11
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 14:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnqmTFBl6UH0AjitgL4NS1jwiF8ciOoeoor1qBPQFQM=;
        b=OywmjUTnsw7hWj+6SoTwe9tfZ6WWSCopQegEfgC0zB64hkzrWIUQVAcpE46LHol5Kv
         5I1wc+XyfgMYTqvagARPtSYGS8lxDdIcQ63fKo0WsVufPeiFiZGAl1G6duBOyx9h5MS9
         7zxWAHEh/wpV+ntz5bjgn+g3nwh4mIRA/926RxXQF6mRjDotBPv4kYdPOl/3wp3X40en
         ytrV4Ev1fJA6vnX8hoXwRQAI2TaWbGFnefzzSgCJuiDE5RjKnQEMWSZP9hc9cibjwcH1
         t/Vngobutn/1A+W4zc3qHaJ3ydENtLGVn9TxXL02hlxmZWKTuTyVUK+r5pFv47HAEgQN
         wksQ==
X-Gm-Message-State: APjAAAXF7mAwcYtdL08SU8TB4ZYMEpqYjnBhxRFE7y95wss8Y/i9hjQp
        1eWqbYVvyJbCtAw7OalkPX2QtQ==
X-Google-Smtp-Source: APXvYqzSVT+o3wy2DXl2BjBaEcVKdDbY4rCB1w2Yu2iz4eCbRD6vvvxvJe0FB/RLEmTeX7aqPb9o/w==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr1630518wrn.197.1565818283445;
        Wed, 14 Aug 2019 14:31:23 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:22 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to enable dGPU direct output"
Date:   Wed, 14 Aug 2019 23:31:12 +0200
Message-Id: <20190814213118.28473-2-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.

The original commit message didn't even make sense. AMD _does_ support it and
it works with Nouveau as well.

Also what was the issue being solved here? No references to any bugs and not
even explaining any issue at all isn't the way we do things.

And even if it means a muxed design, then the fix is to make it work inside the
driver, not adding some hacky workaround through ACPI tricks.

And what out of tree drivers do or do not support we don't care one bit anyway.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/acpi/osi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index bec0bebc7f52..9b20ac4d79a0 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -61,13 +61,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	 * a BIOS workaround.
 	 */
 	{"Linux-Lenovo-NV-HDMI-Audio", true},
-	/*
-	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
-	 * output video directly to external monitors on HP Inc. mobile
-	 * workstations as Nvidia and AMD VGA drivers provide limited
-	 * hybrid graphics supports.
-	 */
-	{"Linux-HPI-Hybrid-Graphics", true},
 };
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
-- 
2.21.0

