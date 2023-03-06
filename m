Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35526AD0FC
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Mar 2023 23:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCFWBJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Mar 2023 17:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCFWBH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Mar 2023 17:01:07 -0500
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 14:00:53 PST
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DF6C887
        for <linux-acpi@vger.kernel.org>; Mon,  6 Mar 2023 14:00:53 -0800 (PST)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4PVsZW5sqXzDPc
        for <linux-acpi@vger.kernel.org>; Mon,  6 Mar 2023 16:45:39 -0500 (EST)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PVsZT6P5Sz3rbX;
        Mon,  6 Mar 2023 16:45:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1678139138; bh=OokC9caJijB2R6x/uvmHEfwIj7maH40ayrBrHRxaoEw=;
        h=Date:Subject:From:To:Cc;
        b=OLLp0H9Q3NQeipWSvj3ygBjfsF7RfpV7LPyR/l2dl8rNj0Ar2rEVeVI9rWY0WhQ0K
         /W2Vve1A2xhzmaq928KRldmJDWfPdnAqotgW/blCQBAf4pV2tOKjqQGR6JMr3Smj9L
         2BgL6k+ZozPOuZvXATkkUM6nb7vuP4z+BODtlTQE=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Mon, 6 Mar 2023 16:45:37 -0500
Message-ID: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
Date:   Mon, 6 Mar 2023 16:45:37 -0500
Subject: [Regression] acpi: laptop panics early in boot
From:   "Pierre Asselin" <pa@panix.com>
To:     linux-acpi@vger.kernel.org
Cc:     regressions@lists.linux.dev,
        =?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[First bug report, apologies if I break etiquette, pointers appreciated.]

Laptop crashes when booting on AC power.

The laptop is on Gentoo; upgrading from 5.15.88 to 6.1.12, the kernel
panics before reaching early userspace.  I find no other report like
this on the Gentoo, arch, mint, or Ubuntu forums, on kernel.org, or out
of duckduckgo.  This is a regression (because, you know, the kernel used
to boot) but so far it's only me, and only on my 16-year old laptop.
Also, I have a workaround.

Image of the panic screen at
https://www.panix.com/~pa/linux-6.1.12-crash/boot-failure.jpg .

Seeing acpi_ac_notify() near the top of the traceback, I tried booting on
battery power.  Works fine.  The panic occurs only when booting on AC power,
whether or not a battery is present.  Sometimes, rarely, it boots fine
even on AC, but that is the exception not the rule.

Based on comments in drivers/acpi/ac.c I tried a trivial patch,

	--- drivers/acpi/ac.c.orig	2022-12-11 17:15:18.000000000 -0500
	+++ drivers/acpi/ac.c	2023-02-19 17:38:06.958733031 -0500
	@@ -47,7 +47,7 @@ static int acpi_ac_resume(struct device
	 #endif
	 static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);

	-static int ac_sleep_before_get_state_ms;
	+static int ac_sleep_before_get_state_ms = 1000;
	 static int ac_only;

	 static struct acpi_driver acpi_ac_driver = {

and it works.  This is probably not the right fix but it will be my
workaround for the time being.

Problem is still present in 6.3-rc1 .  Bisecting, the first bad commit
is d6fb6ee1820c .

The starting config (from 5.15.88) is at
https://www.panix.com/~pa/linux-6.1.12-crash/config-base .
The test is make olddefconfig, make bzImage, then kexec the bzImage with an
initramfs to see if it reaches the rescueshell prompt.  Has to succeed
three times to be declared good.

In case I forgot something, here is my post on the Gentoo forums:
https://forums.gentoo.org/viewtopic-t-1161834-highlight-.html

#regzbot introduced d6fb6ee1820c

Also in bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217152

