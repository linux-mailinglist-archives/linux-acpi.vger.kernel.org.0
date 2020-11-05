Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352FB2A7D8B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 12:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgKELvb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 06:51:31 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37775 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgKELvb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2020 06:51:31 -0500
Received: by mail-oi1-f171.google.com with SMTP id m17so1382252oie.4
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2020 03:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrFoIrK1fyu+umUS6NCNsrrgGPmTpykgCScBSwp4bTU=;
        b=aOp71HaDIEnilWp9TLIEG2I2Y3DjZyx0zvr2/k7Ubzhr9cWMftKW6JxKGPUvlJ31XD
         WLmaQPE4l20zrwhu+y4mNwAXXuA4Zg6rbU/24NmVtf+DWjx9L3F2eHmpV/Jc8buEEH9p
         5nfLBYFlK0ZiypuYgaxlUdJBriZwW4OJ3uFjNsaT6oHvve3hls2CyhvvqHN6qxvhx7bX
         jUElUSq+CvTX4F5g6Dr1R3i45+rS1AIPGYsPV4Ad6H1qfBUrBLm7tAMdXYJsKPbTw+1j
         yDqWKZbyEhmqkmglaLwEjPRf0WPtWVszZ/sR3if4FgniUJ48uGge44vDIidEade+7ZlM
         iTSw==
X-Gm-Message-State: AOAM530Qg/r2cwIy3VGhRDtyP2ISQVzaHiFwlNfB67T6NVIqAhBR8md/
        UT1da3aLN+pIdHikJsoNx+/DLoc34YHq6oMz4b/D6vta
X-Google-Smtp-Source: ABdhPJxlpVGyrkc61jKENwVMmevbpaIiRID0+v0pcZrNgn3YKO2t3MLDXoj+tVR1eUO2+r4QGoWo0MFMrCxEJ1tzLl0=
X-Received: by 2002:a54:478f:: with SMTP id o15mr1318488oic.71.1604577090742;
 Thu, 05 Nov 2020 03:51:30 -0800 (PST)
MIME-Version: 1.0
References: <98acf6339a1b43d6a38f867069088530@asem.it>
In-Reply-To: <98acf6339a1b43d6a38f867069088530@asem.it>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 12:51:18 +0100
Message-ID: <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
Subject: Re: How to add the "gpio-line-names" property in a PCI gpio expander
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CC Mika and Andy who should be more familiar with that problem space than I am.

On Thu, Nov 5, 2020 at 10:46 AM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> Hi all,
>
> I'm working to introduce the "gpio-line-names" property in the ACPI
> configuration of the BIOS of our x86 boards (we can customize the BIOS of our
> boards).
>
> All is ok for the gpiochips related to the Intel chipset and some I2C gpio
> expanders. I have inserted the _DSD as described in the Linux documentation.
>
> In one of our boards we have an add-on PCI board, with a PCI serial device
> Exar XR17V352. This device also contains 16 gpios.
> The exar device drivers work good, both the "8250_exar" and the "gpio_exar", and
> I can manage the exar's gpios correctly.
> The problem is how to assign the gpio-line-names property to a PCI gpio
> expanders like this.
>
> I tried adding a new device in my ACPI configuration, as:
>
> Device (EXAR)
> {
>     Name (_HID, "13A80352")
>     Name (_STR, Unicode ("STR - Exar GPIOs"))  // _STR: Description String
>
>     Name (_DSD, Package () {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package () {
>                 "gpio-line-names",
>                     Package () {
>                         "exar_0",
>                         "exar_1",
>                         "exar_2",
>                         "exar_3",
>                         ...
>                     }
>                 }
>             }
>     })
> }
>
> but I have no result.
> Does anyone have a suggestion?
>
> Thanks,
>
> Flavio
