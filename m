Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D8438AA8
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Oct 2021 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhJXQih (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Oct 2021 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhJXQif (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Oct 2021 12:38:35 -0400
X-Greylist: delayed 4052 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Oct 2021 09:36:14 PDT
Received: from mailout3.inleed.net (mailout3.inleed.net [IPv6:2a0b:dc80:cafe:103::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36213C061745
        for <linux-acpi@vger.kernel.org>; Sun, 24 Oct 2021 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=andraxin.se
        ; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xxBJVgiO7wCXrXBmL18qaePlip97nn5PadFSgEFDo5k=; b=hQZ8m8EujjkO08F9fGxawXM/Qa
        RYCQ5X1ypif5WUFG0sQKH7Wgzl8HshFddU1ZapcdjKWhUhOAHb2kmRs+xbd0I5cGf5BVcLXxG1Qad
        3/M03c9SmeXCJcp1FbQkFDGMvDMs3EM5sqcbkqzbzAxjUFj3ZqVc/9+MOfa+Ma4DWI4n/dgNoHerq
        4Ga5+3rfbcAhM81pRO5UysvAE/X9tPoeLej8etobMJZfvOIaDZ2497/a4JSbyCdd9d21jyqZ7rfrL
        V53FHKyKTPKi5jit0HrOlYaiH/tinouS8HOTI2k3Jnez9Zp8iQB+97rzIpKyiciCbaK+P0MJBRbYC
        JKxMndFA==;
Received: from c-2b3c524e.07-62-73746f67.bbcust.telenor.se ([78.82.60.43] helo=localhost)
        by ns3.inleed.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linux-acpi@andraxin.se>)
        id 1mefQT-00AVAj-HL; Sun, 24 Oct 2021 17:28:45 +0200
Date:   Sun, 24 Oct 2021 17:28:50 +0200
From:   linux-acpi@andraxin.se
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ACPI: PM: Do not turn off power resources in
 unknown state
Message-ID: <YXV7srrMqWK4XagI@eleven>
References: <3625109.kQq0lBPeGtkreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3625109.kQq0lBPeGtkreacher>
X-Authenticated-Id: andras@andraxin.se
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

My NVME drive was affected by the "turn off in unknown state" feature,
preventing my system from booting on 5.13 and above, while everything
worked fine on 5.12 and below.  BTW, I'm really grateful that 5.13 used
`dev_info` intstead of `dev_dbg`, otherwise I wouldn't have had a chance
to track this down from comparing plain `dmesg` output alone.

I cooked up a different patch (before checking here), which takes the
comment removed by the patch in
    https://marc.info/?l=linux-acpi&m=163431826227166
that _some system_ may truly need this at face value, and introduces
a command-line parameter that allows the current behavior by setting
'acpi=unknown_off', but allows my system to boot when that's omitted.

I have no idea if using a kernel parameter for such is OK or a no-no,
but I'll surely learn soon enough...

Regards,

--andrás


Alternative patch against 5.14.14 follows
==========================================================
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -30,6 +30,7 @@
 extern int acpi_use_timer_override;
 extern int acpi_fix_pin2_polarity;
 extern int acpi_disable_cmcff;
+extern int acpi_unknown_off;
 
 extern u8 acpi_sci_flags;
 extern u32 acpi_sci_override_gsi;
@@ -138,6 +139,7 @@
 #define acpi_lapic 0
 #define acpi_ioapic 0
 #define acpi_disable_cmcff 0
+#define acpi_unknown_off 0
 static inline void acpi_noirq_set(void) { }
 static inline void acpi_disable_pci(void) { }
 static inline void disable_acpi(void) { }
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -52,6 +52,7 @@
 int acpi_ioapic;
 int acpi_strict;
 int acpi_disable_cmcff;
+int acpi_unknown_off;
 
 /* ACPI SCI override configuration */
 u8 acpi_sci_flags __initdata;
@@ -1641,6 +1642,10 @@
 	/* "acpi=nocmcff" disables FF mode for corrected errors */
 	else if (strcmp(arg, "nocmcff") == 0) {
 		acpi_disable_cmcff = 1;
+	}
+	/* "acpi=unknown_off" turns off unused devices in unknown state */
+	else if (strcmp(arg, "unknown_off") == 0) {
+		acpi_unknown_off = 1;
 	} else {
 		/* Core will printk when we return error. */
 		return -EINVAL;
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1033,6 +1033,7 @@
 		 * power resources without any users unconditionally.
 		 */
 		if (!resource->ref_count &&
+		    (acpi_unknown_off || resource->state != ACPI_POWER_RESOURCE_STATE_UNKNOWN) &&
 		    resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
 			dev_dbg(&resource->device.dev, "Turning OFF\n");
 			__acpi_power_off(resource);
