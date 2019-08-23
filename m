Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651EC9A5DA
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2019 04:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbfHWC7b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Aug 2019 22:59:31 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39370 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403921AbfHWC7b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Aug 2019 22:59:31 -0400
Received: by mail-qk1-f170.google.com with SMTP id 125so7054445qkl.6
        for <linux-acpi@vger.kernel.org>; Thu, 22 Aug 2019 19:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/8CxqwsRkdRi8cJc2K8PmSBN30m7zHwz61/cmkT2+Po=;
        b=Uxfw2yiXSiDsnIveILok2gx0jbvBwTSM+0WZPvd3pcVrlDReiOJDh55yh+LKKTfVpR
         l3hX0IANtA5XhVhcIE0JN29I71SHbiheZUdV9TsvotSpXO+ViogL6/PfV3LfKpGPjxMA
         P8uDzBhvIetkz1DPCd8YCnCYIeMQ+fcu6anHtGBNXNzkWm3A0byBoRxfICVLrIGJfWRv
         wO4iCD/6QMgm9hksYH5kSbZN9y+C2Jvay2rWsOG+oVYQ4WoNC9cDYfvQyPIcM3FiYnr5
         krGaenjhMl4br+rpLlVawy9GIlxoKmtwDyAShPiSPsh+mlLGFJB4rR8BeIFJAKikBpoF
         Q/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/8CxqwsRkdRi8cJc2K8PmSBN30m7zHwz61/cmkT2+Po=;
        b=NpVy5XcVfQRqS+XbYzWGkKu0VwiUxu9aazPEh0iyv1zFdKq5j17rG04/j2mBEF55N0
         iv8CenfQMJf6eqk61dNDzgbalqzdhZ6owSIhStC1YlHs8u/EsYE3NOInho0TLxxieqkI
         nT6sXL/YVp2Jqy77AVVI/MCpLfYziAIMsaR7OIQaRLm65yYZqrp/cvJfdVRujqPVydb3
         k4mdeH9fWeph7fw27qVT0JQfVJht4VnzlusDQl3QExmR1IBA0Ju+8IzqAOjOUhvxGIy7
         kmxGCxQJAQrMZcvIgBmZdtI4beS3rMemvIk1cdYKNf6BQFBltUhsTVH2xLmrBsZb7Olt
         V3cA==
X-Gm-Message-State: APjAAAWgKqz1EhF60++wicj3Co7OVL343xQHMDZKVx5PYu1ErmP7szIo
        WLLis2rP07+EQTTEQpBO6Ww0SdqtJoFKp7y//FqGgQ==
X-Google-Smtp-Source: APXvYqyjJ3CuKhqN3ivirNwwxZRKN/iqJkeWR1LtdJFop8szzHnkUvptg4ODcCLcVoQkCY+mcIDA2Q+5waLS+s6JLV4=
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr2007429qkl.445.1566529170056;
 Thu, 22 Aug 2019 19:59:30 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 23 Aug 2019 10:59:19 +0800
Message-ID: <CAD8Lp47Le8CBkc3HN4_8+x6ZqR5eiwbVh+VbnfFysKgPgErptQ@mail.gmail.com>
Subject: gpiolib-acpi problematic trigger of edge events during boot
To:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Endless Linux Upstreaming Team <linux@endlessm.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

acpi_gpiochip_request_irq() has this code:

    /* Make sure we trigger the initial state of edge-triggered IRQs */
    value = gpiod_get_raw_value_cansleep(event->desc);
    if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
        ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
        event->handler(event->irq, event);

Originally introduced in:
commit ca876c7483b697b498868b1f575997191b077885
Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu Jul 12 17:25:06 2018 +0200

    gpiolib-acpi: make sure we trigger edge events at least once on boot

This code is causing a problem on a new consumer laptop, which is
based on the new ACPI reduced hardware standard. Under this design,
the power button is now just an ordinary GPIO that should be handled
by software: ACPI's _AEI method lists this GPIO as one that the OS
should monitor for changes, and the OS is expected to call the
corresponding _EVT method when that happens, which will in turn raise
a Notify event on the power button device.

Here, the GpioInt defined in _AEI is Edge-triggered, ActiveHigh. The
GPIO level is ordinarily high, but goes low when the button is
pressed. We checked this definition and behaviour with the vendor,
even suggesting that it should maybe be ActiveLow instead, but they
responded that this is correct and by-design.

These conditions set the IRQF_TRIGGER_RISING flag and cause the _EVT
event handler to be called by the code above as soon as the pinctrl
module is loaded. In other words, loading the pinctrl driver causes
the system to incorrectly believe the power button has been pressed so
it will immediately go into suspend or shutdown.

Fortunately this is perhaps not a serious issue, as at least Ubuntu
and Endless build the corresponding pinctrl drivers directly into the
kernel image. They are then loaded in early boot, and despite a power
button event being reported, it's so early that userspace doesn't
notice and no action is taken.

But I raise this anyway as a potential problem should that ever
change, it may also become a more widespead issue as the ACPI reduced
hardware standard becomes more and more common in consumer devices.

Any ideas for how we can better deal with this issue?

I can see the rationale for handling the specific cases mentioned in
the original commit message, but at the same time this code seems to
be assuming that an edge transition has happened, which is not true in
this case.

Thanks,
Daniel
