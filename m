Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46858DFDA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfHNVb2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:31:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfHNVb1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 17:31:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so454639wrr.5
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 14:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhvDIcAWfosZBJhY+0+tJdL27Lzyx+m3Z571YGmGrMU=;
        b=P9mqUsnBnbQwi4T9s0RL5vDiXusfblLzswuOmsZJD7dHxhFtmVet84/fHJaOEbdMhp
         bXQDRQlgM8Gzz6N/K+9WAT9sAB40UECRxpa7l9ZJaK0/S2wFN4cNR0+Ja1FPezIgBjQX
         dPLkZAsZKmmJYktNQJRwe3B6nDeiqL5dS4yw2nQIA4qrvYkuZ13Bo07dJrNDTAklmi96
         4yKZPsuohG+2Nljj+2PJamUYQDE+oBiC3C0OW+j+TFk3ocDYqyQWnq1hE45/64vsvs5z
         cA1PVY6HJ8c2r1e+4CZnxTQOXMGI5xpSRu6k5MhCo11SOU4fTsbLcrI4tnWCkcS9vjyZ
         w5FQ==
X-Gm-Message-State: APjAAAW++RdD1Ygdepu9VwYYtPCJZbI+eX+/GRzUSjHIEnOquOZtFKN0
        hpsXTHmXXu8DBtKLWby54k/qYQ==
X-Google-Smtp-Source: APXvYqzpILgvWyO/axbBU+RuIXy2MhZX3baBIQN5meB2TU+nSw73f26dSGUM9WN8J6xOSH+pbpo82A==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr1601044wrs.200.1565818285969;
        Wed, 14 Aug 2019 14:31:25 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:25 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 3/7] Revert "ACPI / OSI: Add OEM _OSI strings to disable NVidia RTD3"
Date:   Wed, 14 Aug 2019 23:31:14 +0200
Message-Id: <20190814213118.28473-4-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 9251a71db62ca9cc7e7cf364218610b0f018c291.

This was never discussed with anybody Nouveau related and we would have NACKed
this change immediately.

We have a better workaround, which makes it actually work with Nouveau. No idea
why the comment mentions the Nvidia driver and assumes it gives any weight to
the reasoning.... we don't care about out of tree drivers.

Nouveau does support RTD3, but we had some issues with that. And we even have
a better fix for this issue. Also, can we _please_ do it in a way worthy of an
upstream community the next time?

If some distribution feels like they have to please companies not wanting to
be part of the linux community, please do so downstream and don't try to push
something like this upstream.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/acpi/osi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 56cc95b6b724..f5d559a2ff14 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -44,15 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
-	/*
-	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
-	 * cards as RTD3 is not supported by drivers now.  Systems with NVidia
-	 * cards will hang without RTD3 disabled.
-	 *
-	 * Once NVidia drivers officially support RTD3, this _OSI strings can
-	 * be removed if both new and old graphics cards are supported.
-	 */
-	{"Linux-Dell-Video", true},
 };
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
-- 
2.21.0

