Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F10417059
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhIXKdZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 24 Sep 2021 06:33:25 -0400
Received: from pout.email.it ([77.93.251.230]:46064 "EHLO pout.email.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhIXKdY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Sep 2021 06:33:24 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 06:33:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id 9F8BCCE381;
        Fri, 24 Sep 2021 12:23:30 +0200 (CEST)
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9CKuUfwyWPdf; Fri, 24 Sep 2021 12:23:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id 24558CE1CF;
        Fri, 24 Sep 2021 12:23:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at ir-mtaout02.email.it
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WupZ5Wsvxoei; Fri, 24 Sep 2021 12:23:20 +0200 (CEST)
Received: from ir-zstore42.email.it (unknown [192.168.25.42])
        by pout.email.it (Postfix) with ESMTP id 276B9CD180;
        Fri, 24 Sep 2021 12:23:18 +0200 (CEST)
Date:   Fri, 24 Sep 2021 12:23:18 +0200 (CEST)
From:   blinkin@email.it
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Message-ID: <1811728383.1384020.1632478998559.JavaMail.zimbra@email.it>
In-Reply-To: <87tujwhxl2.ffs@tglx>
References: <629765464.1655403.1628264743080.JavaMail.zimbra@email.it> <87tujxssp2.ffs@tglx> <217397770.2008922.1628604301644.JavaMail.zimbra@email.it> <877dgtql9v.ffs@tglx> <1437097118.2114098.1628689870926.JavaMail.zimbra@email.it> <87tujwhxl2.ffs@tglx>
Subject: Re: Bug report for kernel v4.15-rc8+
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [109.118.219.53]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - GC92 (Linux)/8.8.15_GA_4059)
Thread-Topic: Bug report for kernel v4.15-rc8+
Thread-Index: Y6D5gTTm9munIF0vbJIxXTKah8PVWg==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

hello, any news on this?

----- Messaggio originale -----
Da: "Thomas Gleixner" <tglx@linutronix.de>
A: blinkin@email.it
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, linux-acpi@vger.kernel.org
Inviato: Mercoledì, 11 agosto 2021 16:20:41
Oggetto: Re: Bug report for kernel v4.15-rc8+

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
