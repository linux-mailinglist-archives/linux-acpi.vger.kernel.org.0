Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776661823E0
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 22:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgCKVbz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 17:31:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCKVbz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2020 17:31:55 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jC8x9-0000Qv-7t; Wed, 11 Mar 2020 22:31:47 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B7C2E100F5A; Wed, 11 Mar 2020 22:31:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] x86: Select HARDIRQS_SW_RESEND on x86
In-Reply-To: <0e5b484d-89f5-c018-328a-fb4a04c6cd91@redhat.com>
References: <87sgk4naqh.fsf@nanos.tec.linutronix.de> <0e5b484d-89f5-c018-328a-fb4a04c6cd91@redhat.com>
Date:   Wed, 11 Mar 2020 22:31:46 +0100
Message-ID: <87fteek27x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:
>> I just need to stare at the legacy PIC and the virt stuff.
>> 
>>> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
>>> somewhat a big change for that but it does solve some real issues...
>> 
>> Yes. Let me stare at the couple of weird irqchips which might get
>> surprised. I'll teach them not to do that :)
>
> I know that you are very busy, still I'm wondering is there any progress
> on this ?

Bah. That fell through the cracks, but actually I looked at this due to
the PCI-E AER wreckage. So yes, this is fine, but we want:

 https://lkml.kernel.org/r/20200306130623.590923677@linutronix.de
 https://lkml.kernel.org/r/20200306130623.684591280@linutronix.de

if we want to backport this to stable.

Thanks,

        tglx
