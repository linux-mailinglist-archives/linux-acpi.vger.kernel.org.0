Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A242A3E937F
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Aug 2021 16:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhHKOVI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Aug 2021 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhHKOVG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Aug 2021 10:21:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E68C061765;
        Wed, 11 Aug 2021 07:20:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628691641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OafCV4to9crXJDZQlKZLG9oI45GR46qnotTCu0bnsWg=;
        b=EHUkGagFvKnCQfRChYF6XHFSVvFkpBTTSBznUoNqLIaN/MtSeRxqbpW0jv1fi56h8WDEmK
        rxSLrO0jGRbOfwk+0EbUXiOulBMfssktsSLCWww9KOlMRMI9etJTXmXjiFKuKHUwQ+VTzQ
        FVUrBjPXMXjugerRSCzY2amVrGRh0Tyf5fobbAoQQvFhMH7BBk0S0NrbTrY3NaFe45YKkA
        SZGHv/tcioR4+5pX1iKrJA4gKHDmBG2ZNIwyexbLLOT2rNUtr9RyQzk3kH2xxf4Z5IFDrn
        /Vnt88zEbk5XRba5fPgWrRmz1ikvuPHxOUMxu5LAI2dxakjrrfkaUu/Oignsmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628691641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OafCV4to9crXJDZQlKZLG9oI45GR46qnotTCu0bnsWg=;
        b=HAyOZ9MVx5HrgdCxBFhawXExDimFeQOh1KIrtLFE68XqN2B6WuRUJqfNSd0pV9UX9WSoUd
        UslWqykbe6uHL0BA==
To:     blinkin@email.it
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: Bug report for kernel v4.15-rc8+
In-Reply-To: <1437097118.2114098.1628689870926.JavaMail.zimbra@email.it>
References: <629765464.1655403.1628264743080.JavaMail.zimbra@email.it>
 <87tujxssp2.ffs@tglx>
 <217397770.2008922.1628604301644.JavaMail.zimbra@email.it>
 <877dgtql9v.ffs@tglx>
 <1437097118.2114098.1628689870926.JavaMail.zimbra@email.it>
Date:   Wed, 11 Aug 2021 16:20:41 +0200
Message-ID: <87tujwhxl2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 11 2021 at 15:51, blinkin@email.it wrote:
> 1) You're booting with an out of tree module
>
>   Uninstalled virtualbox, reproduced same behavior without the module.
>   dmesg outputs attached with and without the workaround
>   (dmesg_novboxdrv_clean.txt and dmesg_novboxdrv_irqaffinity0.txt)

Ok.

> 2) Please provide information what is consuming 90% of a CPU
>
>   top shows a kworker process consistently at 50% without the
>   workaround, 60% with the workaround. No significant activity amounts
>   from other processes.  Sometimes that 50% is split between two
>   kworker processes for a short time.  CPU core #0 activity is a
>   constant 60% without the workaround, 90% with the workaround

That's broken. /proc/interrupts gives some hint:

1) Stock kernel

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:          0          0          0          9  IR-IO-APIC    1-edge      i8042
>    8:          0          1          0          0  IR-IO-APIC    8-edge      rtc0
>    9:          0     923411          0          0  IR-IO-APIC    9-fasteoi   acpi

900k ACPI interrupts right after boot

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:          0          0          0         11  IR-IO-APIC    1-edge      i8042
>    8:          0          1          0          0  IR-IO-APIC    8-edge      rtc0
>    9:          0    4869059          0          0  IR-IO-APIC    9-fasteoi   acpi

One minute later it's 4.8M

With affinity forced to CPU0 it's even more:

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:          9          0          0          0  IR-IO-APIC    1-edge      i8042
>    8:          1          0          0          0  IR-IO-APIC    8-edge      rtc0
>    9:    7576456          0          0          0  IR-IO-APIC    9-fasteoi   acpi

7.5M right after boot

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:         11          0          0          0  IR-IO-APIC    1-edge      i8042
>    8:          1          0          0          0  IR-IO-APIC    8-edge      rtc0
>    9:   10992420          0          0          0  IR-IO-APIC    9-fasteoi   acpi

10.9M after one minute. Though the delta between right after boot and 1
minute later is in the same ballpark.

Cc'ed the ACPI people for clues.

Thanks,

        tglx
