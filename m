Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2474F2243CB
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jul 2020 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgGQTFz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jul 2020 15:05:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31534 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728528AbgGQTFz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2020 15:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595012754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QA04z49XQxRpsbQtr5ADLmijNDZoNbT33TpqwbOswEA=;
        b=iwJ53EAXW4bgYTrGk0C63noQBMof9u42LMtfCuQg5xk31qxw5KtPfZ31RV9k5UbMBYYMaO
        b7kB5v8en+RXToP/jz6Wfisq4Abr8b/uNcZX0iOdfOtFoAmN3kn/g55qz9DSHmx+vWOuFW
        BnEaQgaaop2nZe3RolFCpOLZkCDfYxo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-zLib_LCzPyqp2j4e6T7a_w-1; Fri, 17 Jul 2020 15:05:52 -0400
X-MC-Unique: zLib_LCzPyqp2j4e6T7a_w-1
Received: by mail-ej1-f69.google.com with SMTP id gv21so3506519ejb.8
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2020 12:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA04z49XQxRpsbQtr5ADLmijNDZoNbT33TpqwbOswEA=;
        b=TGYvMeiI25qMwqUA7mS27MuTZRFUwzzs5/Ln5myuRfP/Ps98y4blj8PG2wOMv3mjQr
         Ole5tm8eyj6oo0wGW/q2w+19AE7FC6dPk3X0N6UjYB+9EBMmP+/e5ajAinIoSrNqrurX
         dGfva01mBChUJ82SA4HVyAOfkijj0axNVi4BmW+uQcnLQspZV6miNZpIJdLLl8pUr9Ww
         gmXkQLzlr/d7Z83KyDOGFU891jRDU+iZe7v3E7bzL1Q++BH8Fn2MVH9HnWbiR6eNP8V/
         YWfTnsaxu2j0Y1ZSPfCqS1MEYxrZAeqR9czf9RVyGufybTuS0iJe1YSaFL0U2DmHWe6Z
         dk2A==
X-Gm-Message-State: AOAM533joMZkkkram49vSlGB1xc0iR7kmcPAcceVSi0iDfoM3aPPKX2F
        j3GESQH+qD7FU1MrPSk0tnVDa6d8Fxa2LyneMPYecqXvHRv50VfrSQidaC2ALtxucxXv5fa4gyJ
        w8uz3q/TjFRhSqqfbRgG/8g==
X-Received: by 2002:a17:906:a449:: with SMTP id cb9mr9659947ejb.115.1595012750737;
        Fri, 17 Jul 2020 12:05:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxawMnEihhU00mwwY2KMXzPnp583S5oS9vU4nqqnr6E/4WlXYRDH2z1ZDUEgvDfZKxqw/acwg==
X-Received: by 2002:a17:906:a449:: with SMTP id cb9mr9659924ejb.115.1595012750517;
        Fri, 17 Jul 2020 12:05:50 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:482c:9537:40:83ba])
        by smtp.gmail.com with ESMTPSA id 92sm9030732edg.78.2020.07.17.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:05:49 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-acpi@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lyude Paul <lyude@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH] RFC: ACPI / OSI: remove workarounds for hybrid graphics laptops
Date:   Fri, 17 Jul 2020 21:05:47 +0200
Message-Id: <20200717190547.648604-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's hard to figure out what systems are actually affected and right now I
don't see a good way of removing those...

But I'd like to see thos getting removed and drivers fixed instead (which
happened at least for nouveau).

And as mentioned before, I prefer people working on fixing issues instead
of spending time to add firmware level workarounds which are hard to know
to which systems they apply to, hard to remove and basically a big huge
pain to work with.
In the end I have no idea how to even figure out what systems are affected
and which not by this, so I have no idea how to even verify we can safely
remove this (which just means those are impossible to remove unless we risk
breaking systems, which again makes those supper annoying to deal with).

Also from the comments it's hard to get what those bits really do. Are they
just preventing runtime pm or do the devices are powered down when booting?
I am sure it's the former, still...

Please, don't do this again.

For now, those workaround prevent power savings on systems those workaround
applies to, which might be any so those should get removed asap and if
new issues arrise removing those please do a proper bug report and we can
look into it and come up with a proper fix (and keep this patch out until
we resolve all of those).

Signed-off-by: Karol Herbst <kherbst@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
CC: Lyude Paul <lyude@redhat.com>
CC: linux-kernel@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: nouveau@lists.freedesktop.org
---
 drivers/acpi/osi.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 9f68538091384..d4405e1ca9b97 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -44,30 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
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
-	/*
-	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
-	 * audio device which is turned off for power-saving in Windows OS.
-	 * This power management feature observed on some Lenovo Thinkpad
-	 * systems which will not be able to output audio via HDMI without
-	 * a BIOS workaround.
-	 */
-	{"Linux-Lenovo-NV-HDMI-Audio", true},
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
2.26.2

