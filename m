Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFE2068A3
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jun 2020 01:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgFWXs5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jun 2020 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbgFWXs5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2020 19:48:57 -0400
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Jun 2020 16:48:56 PDT
Received: from mail.klausen.dk (mail.klausen.dk [IPv6:2001:470:1f0b:1730::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142CC061573;
        Tue, 23 Jun 2020 16:48:56 -0700 (PDT)
Subject: Re: [PATCH v13 1/4] battery: Add the battery hooking API
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klausen.dk; s=dkim;
        t=1592955747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4g5w63uD1aXz3cObU8Y1okQo2GDDE+cBxkna1MnTOqQ=;
        b=nKLcQnci93IxtvDZQUO5UhWuybhxYljcwchzOEd9aJXluuHbT1F1cJNocCeYKSVaYtqoss
        vJbvFhqJozN/8h4GvzdkfSbjLeb88p4PYTFEsy5NWxW4KaVILqzTspWUyeMpTG3k0u4gAk
        r0e6xzzpT3cEq7GRmsb0UEirrrU8Rd0=
To:     Ognjen Galic <smclt30p@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Linux PM <linux-pm@vger.kernel.org>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph@boehmwalder.at>,
        Kevin Locke <kevin@kevinlocke.name>
References: <20180207145813.icmv6rwemyejhxbk@thinkpad>
From:   Kristian Klausen <kristian@klausen.dk>
Message-ID: <2270b8c7-beec-5ab6-f8b7-5ec41751c699@klausen.dk>
Date:   Wed, 24 Jun 2020 01:42:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180207145813.icmv6rwemyejhxbk@thinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07.02.2018 15.58, Ognjen Galic wrote:
> This is a patch that implements a generic hooking API for the
> generic ACPI battery driver.
>
> With this new generic API, drivers can expose platform specific
> behaviour via sysfs attributes in /sys/class/power_supply/BATn/
> in a generic way.
>
> A perfect example of the need for this API are Lenovo ThinkPads.
>
> Lenovo ThinkPads have a ACPI extension that allows the setting of
> start and stop charge thresholds in the EC and battery firmware
> via ACPI. The thinkpad_acpi module can use this API to expose
> sysfs attributes that it controls inside the ACPI battery driver
> sysfs tree, under /sys/class/power_supply/BATN/.
>
> The file drivers/acpi/battery.h has been moved to
> include/acpi/battery.h and the includes inside ac.c, sbs.c, and
> battery.c have been adjusted to reflect that.
>
> When drivers hooks into the API, the API calls add_battery() for
> each battery in the system that passes it a acpi_battery
> struct. Then, the drivers can use device_create_file() to create
> new sysfs attributes with that struct and identify the batteries
> for per-battery attributes.

Hi

I did that, when I implemented charge threshold support for ASUS 
laptops[1][2].

It works very well but I can't control the threshold with udev (also 
reported by another user here[3]). So I did a bit of digging and the 
doc[4] states: "If attributes are added after the device is registered, 
then userspace won’t get notified and userspace will not know about the 
new attributes.", which seems to be the way the current code works:
power_supply_register_no_ws is called[5] and if it success all the hooks 
are run.

Looking at the code I'm not sure there is a easy way to fix it, do you 
have any good ideas?

Best
Kristian Klausen

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d507a54f5865d8dcbdd16c66a1a2da15640878ca
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7973353e92ee1e7ca3b2eb361a4b7cb66c92abee
[3] 
https://www.reddit.com/r/linuxhardware/comments/g8kpee/psa_kernel_54_added_the_ability_to_set_a_battery/fp8bwgu/
[4] 
https://www.kernel.org/doc/html/v5.8-rc2/driver-api/driver-model/device.html
[5] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/battery.c?id=8c3f6993c221cc1a2588046e3ff32d64580396b7#n854

>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
