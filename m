Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1471148B2B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2020 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgAXPTN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jan 2020 10:19:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42601 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAXPTN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jan 2020 10:19:13 -0500
Received: from [5.158.153.53] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iv0jg-0003nk-5e; Fri, 24 Jan 2020 16:19:04 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DE067103089; Fri, 24 Jan 2020 16:19:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] x86: Select HARDIRQS_SW_RESEND on x86
In-Reply-To: <20200123210242.53367-1-hdegoede@redhat.com>
Date:   Fri, 24 Jan 2020 16:19:02 +0100
Message-ID: <87sgk4naqh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hans,

Hans de Goede <hdegoede@redhat.com> writes:
>
> The Intel GPIO controllers do not allow implementing irq_retrigger without
> emulating it in software, at which point we are better of just using the
> generic HARDIRQS_SW_RESEND mechanism rather then re-implementing software
> emulation for this separately in aprox. 14 different pinctrl drivers.

Indeed.

> I'm sending this out as a RFC since I'm not %100 sure this is the best
> solution and it seems like a somewhat big change to make.

It's not that bad. The only affected interrupt chips on x86 should be
secondary interrupt chips like the GPIO controller.

ioapic/msi/... have irq_retrigger() functionality, so it won't do the
software resend.

I just need to stare at the legacy PIC and the virt stuff.

> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
> somewhat a big change for that but it does solve some real issues...

Yes. Let me stare at the couple of weird irqchips which might get
surprised. I'll teach them not to do that :)

Thanks,

        tglx
