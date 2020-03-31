Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACFC1988C1
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Mar 2020 02:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgCaARm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 20:17:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgCaARm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2020 20:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=21yG7P+pD4KJzJpZlNZgHTRJCQuMzOkPgSdwN+wXzXw=; b=CMoURB9X9+WTmwOK6yajm6s91M
        k4grT8SPVE0oCzP/jGqecuOm2xBDa/PIl4WxIwtWGFUuUy1maOBEU68qgOPyesSJAloNgiRn80BJY
        Yc7tZhCd64WP7sHPYyR7gXO2rBv/z74jAeb+shH6hJBkC3dSAppA88tcVs2Thcmrejfg0t12WZ29q
        WxfSRVwQ+haBJTRD+bM84xKeB035EpdVikGIFGKZaz8Y7nNiwMtxbUD1teSPsX+yPETbIooXyy3r6
        R8RIySGdt/q3NrsOLUd8XmcPCvBTIqZ9O+fjE6cubhdnGocGU9MWZ+pUTlo924taMYKf15pwPbOJD
        D53M/h9g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ4b5-0007Yu-4D; Tue, 31 Mar 2020 00:17:39 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ACPI; update docs for "acpi_backlight" kernel parameter
 options
Message-ID: <19409af2-f38a-6760-c7b3-aa5794a94df0@infradead.org>
Date:   Mon, 30 Mar 2020 17:17:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Update the Documentation for "acpi_backlight" by adding
2 new options (native and none).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-next-20200330.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20200330/Documentation/admin-guide/kernel-parameters.txt
@@ -22,11 +22,13 @@
 			default: 0
 
 	acpi_backlight=	[HW,ACPI]
-			acpi_backlight=vendor
-			acpi_backlight=video
-			If set to vendor, prefer vendor specific driver
+			{ vendor | video | native | none }
+			If set to vendor, prefer vendor-specific driver
 			(e.g. thinkpad_acpi, sony_acpi, etc.) instead
 			of the ACPI video.ko driver.
+			If set to video, use the ACPI video.ko driver.
+			If set to native, use the device's native backlight mode.
+			If set to none, disable the ACPI backlight interface.
 
 	acpi_force_32bit_fadt_addr
 			force FADT to use 32 bit addresses rather than the

