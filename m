Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19D86C809E
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 16:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCXPCS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjCXPCR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 11:02:17 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3214619F2E
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 08:02:14 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4Pjlmh6l9Vz43yD;
        Fri, 24 Mar 2023 11:02:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1679670133; bh=ChfbjGRiFL92LPJtGpRt/wgijRzpCQ49RN1Njtbwtpw=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=UvwCvjmdQ/cxywq865blRBmHCngJBPk2hr0y+EEPzlnkN1EDlDBwawIsvLiuJ23Et
         fJfgKVLt3+yWvldmOcDVfPK3nwBnw0iP0owRgQaqDZXV3BFNAtC/DiQCp/GyMde9oe
         szQCP0uREPrrxpC0BWcbM/73EDeQWMMmLZOi7Tl0=
X-Panix-Received: from 166.84.1.3
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Fri, 24 Mar 2023 11:02:13 -0400
Message-ID: <8ac89f507c8e5c14635d215284f2f2b1.squirrel@mail.panix.com>
In-Reply-To: <20230323212212.udho2htrhd2vlzxm@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
    <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
    <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
    <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
    <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
    <20230307200843.yxhvnb23tpecjjng@pengutronix.de>
    <20230323212212.udho2htrhd2vlzxm@pengutronix.de>
Date:   Fri, 24 Mar 2023 11:02:13 -0400
Subject: Re: [Regression] acpi: laptop panics early in boot
From:   "Pierre Asselin" <pa@panix.com>
To:     =?iso-8859-1?Q?=22Uwe_Kleine-K=C3=B6nig=22?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Pierre Asselin" <pa@panix.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?iso-8859-1?Q?=22Robert_=C5=9Awi=C4=99cki=22?= 
        <robert@swiecki.net>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> This mail didn't make it into the archive on lore.kernel.org. Did
> someone receive it? If not, that would explain why I didn't get any
> feedback on it ...

First time I see it.

>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 9531dd0fef50..fddca263ac40 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -518,13 +518,15 @@ static void acpi_bus_notify(acpi_handle handle,
>> u32 type, void *data)
>>  	if (!adev)
>>  		goto err;
>>
>> -	if (adev->dev.driver) {
>> +	device_lock(&adev->dev);
>> +	if (device_is_bound(&adev->dev)) {
>>  		struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
>>
>>  		if (driver && driver->ops.notify &&
>>  		    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
>>  			driver->ops.notify(adev, type);
>>  	}
>> +	device_unlock(&adev->dev);
>>
>>  	if (!hotplug_event) {
>>  		acpi_put_acpi_dev(adev);
>>

This patch works, in that the kernel reaches early userspace reliably.
I would want to test it more extensively, i.e. install the modules and
run it for real instead of just kexec-ing the bzImage.  I'll test Rafael's
patch first.

Full disclosure: I made small changes to the starting .config, see below.
6.3-rc1 is still bad with the new .config, the patch makes it good.
The changes:
  1) PROVE_LOCKING=y
  2) CONFIG_DEBUG_ATOMIC_SLEEP=y  (why not, what could go wrong :)
  3) radeon driver modular instead of built-in.
I don't think it matters.  Here is the diffconfig, just in case.

-EXTRA_FIRMWARE_DIR "/lib/firmware"
 CEC_CORE y -> m
 DEBUG_ATOMIC_SLEEP n -> y
 DEBUG_LOCK_ALLOC n -> y
 DEBUG_MUTEXES n -> y
 DEBUG_RT_MUTEXES n -> y
 DEBUG_RWSEMS n -> y
 DEBUG_SPINLOCK n -> y
 DEBUG_WW_MUTEX_SLOWPATH n -> y
 DRM_DISPLAY_HELPER y -> m
 DRM_KMS_HELPER y -> m
 DRM_RADEON y -> m
 DRM_TTM y -> m
 DRM_TTM_HELPER y -> m
 EXTRA_FIRMWARE "radeon/R300_cp.bin" -> ""
 FB_CFB_COPYAREA y -> m
 FB_CFB_FILLRECT y -> m
 FB_CFB_IMAGEBLIT y -> m
 FB_SYS_COPYAREA y -> m
 FB_SYS_FILLRECT y -> m
 FB_SYS_FOPS y -> m
 FB_SYS_IMAGEBLIT y -> m
 I2C_ALGOBIT y -> m
 PROVE_LOCKING n -> y
+DEBUG_LOCKDEP n
+LOCKDEP y
+LOCKDEP_BITS 15
+LOCKDEP_CHAINS_BITS 16
+LOCKDEP_CIRCULAR_QUEUE_BITS 12
+LOCKDEP_STACK_TRACE_BITS 19
+LOCKDEP_STACK_TRACE_HASH_BITS 14
+PREEMPTIRQ_TRACEPOINTS y
+PROVE_RAW_LOCK_NESTING n
+PROVE_RCU y
+TRACE_IRQFLAGS y
+TRACE_IRQFLAGS_NMI y


