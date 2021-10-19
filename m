Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35FD433534
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Oct 2021 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhJSL6a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhJSL63 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Oct 2021 07:58:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1EC06161C;
        Tue, 19 Oct 2021 04:56:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e10so8603787plh.8;
        Tue, 19 Oct 2021 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dUv8SMn+VZQ1/ek8USa16cuvwtNq9xDQ8/6uQu5XFsw=;
        b=oH5SZvbOiqph7vo+xdOxFAxzsDTsj/XYfRElDAlNCv75sMneC7SvIsMk+hjE4TzY3a
         umUtZ7qQVKhcYKl1NXdsswpnK7U5TtJ0qd1Gw5hFYF8/MCD8N2fYa9WZ9B/VMdRyHkbO
         OMOXp5KyYjIrIZe24eMM5p2J/wUrZhc/llgmD1mxb3V+HRfUFpA+pSt5hr5aKwcDfqdv
         m0t/T8pSI6Kj59bOyZK0KXcVK6kdI9O7UJ2S2n+LpyjYpi5R/HxDnV1dIpZ4jMNTtWBE
         Z5gQsOoRxvQkwtxlxjY4pxG/RKM0RUn+cLM9KimPOBXW7hWMnV7GITs9fUEJhYjGvzWF
         Un+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dUv8SMn+VZQ1/ek8USa16cuvwtNq9xDQ8/6uQu5XFsw=;
        b=pPdVttWe+SnOQL3wpcuFFvhlzUjEHhe6kdlx/zW34d+I3rqkVRauvy++SxqzLDUx/G
         Uni4Aaqz77GIRjq1/i242/t+iyweNxGc+gYRQRwDlK0o8N7wBtJ5MQ2UKG8WoZmnuMRj
         1RmeRmLONEc7bOtldvy5HKpmpIWN46s4ezRyfldzW/AnteAIIXzUk/v2xfo91ua3jyW0
         H/QrEjBmcwAFfM3YfQzz7cqI1xJuJxBqJLOMNnTG2FsuNJ44Kyun6xkmTRHHJZxTInuQ
         LHAzWsRUJLAwJfX5OlfMihP6jvV2dwtFyIY0Qp3hMyiqSeSYjAwR27x24sd2a0XVFnKf
         IhNA==
X-Gm-Message-State: AOAM532E/2WI0tOwMuz60cCkTCeqe7uOg+1rOvp/fflH9gsShAks7/NB
        X/ka2gJJ4/eiVdWeqLzoJfY=
X-Google-Smtp-Source: ABdhPJxPNVhiTgTpCc4DEcK2JpAe/g7639VCbqKwp8Jx3lhhyCtICL6TieqpF0wJzlvF54P5aZf55Q==
X-Received: by 2002:a17:903:22c9:b0:13e:ed56:70e2 with SMTP id y9-20020a17090322c900b0013eed5670e2mr32940459plg.19.1634644576427;
        Tue, 19 Oct 2021 04:56:16 -0700 (PDT)
Received: from ?IPv6:2400:4052:6980:3800:dba7:2b1f:3f26:a5ec? ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id 11sm15904349pfl.41.2021.10.19.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 04:56:16 -0700 (PDT)
Message-ID: <23d641620aebd1aa47fd73d040dec4ad8974d03d.camel@gmail.com>
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to
 intel_pmic_bytcrc driver
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 20:56:04 +0900
In-Reply-To: <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
References: <20211017161523.43801-1-kitakar@gmail.com>
         <20211017161523.43801-2-kitakar@gmail.com>
         <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-10-18 at 11:16 +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/17/21 18:15, Tsuchiya Yuto wrote:
> > On Microsoft Surface 3 (uses Intel's Atom Cherry Trail SoC), executing
> > intel_soc_pmic_exec_mipi_pmic_seq_element() results in the following
> > error message:
> > 
> >         [ 7196.356682] intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
> >         [ 7196.356686] intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x6e reg-addr 0x57 value 0x63 mask 0xff
> > 
> > Surface 3 uses the PMIC device INT33FD, and the DSDT describes its _HRV
> > value is 0x02 [1]:
> > 
> >         Scope (PCI0.I2C7)
> >         {
> >             Device (PMIC)
> >             {
> >                 Name (_ADR, Zero)  // _ADR: Address
> >                 Name (_HID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _HID: Hardware ID
> >                 Name (_CID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _CID: Compatible ID
> >                 Name (_DDN, "CRYSTAL COVE+ AIC")  // _DDN: DOS Device Name
> >                 Name (_HRV, 0x02)  // _HRV: Hardware Revision
> >                 Name (_UID, One)  // _UID: Unique ID
> >                 Name (_DEP, Package (0x01)  // _DEP: Dependencies
> >                 {
> >                     I2C7
> >                 })
> >         [...]
> > 
> > Due to this _HRV value, intel_pmic_bytcrc is used as the PMIC driver.
> > However, the i2c address is currently not defined in this driver.
> > This commit adds the missing i2c address 0x6e to the intel_pmic_bytcrc
> > driver.
> > 
> > [1] https://github.com/linux-surface/acpidumps/blob/f8db3d150815aa21530635b7e646eee271e3b8fe/surface_3/dsdt.dsl#L10868
> > 
> > References: cc0594c4b0ef ("ACPI / PMIC: Add i2c address for thermal control")
> > Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
> 
> I believe that it is very unlikely that a device with a Cherry Trail SoC is actually using
> the Bay Trail version of the PMIC, I would expect that to not necessarily work all that well.
> 
> So as Andy said, the right fix here is something like the:
> 
> +	hrv = 0x03;
> 
> Workaround from your cover-letter.
> 
> As Andy said we could use a DMI quirk for this, but chances are that the Microsoft Surface
> DSDT is not the only one with the wrong HRV value. So instead it might be better to
> just test for the SoC type as the attached patch does.
> 
> Tsuchiya, can you give the attached patch a try.

Thanks!

I tried your attached patch, and I can confirm that it's working as
expected.

Now it's using cht one:

        $ ls /sys/devices/pci0000:00/808622C1:05/i2c-5/i2c-INT33FD:00
        cht_crystal_cove_pmic  crystal_cove_gpio  crystal_cove_pwm  driver  firmware_node  modalias  name  power  subsystem  uevent

and the function intel_soc_pmic_exec_mipi_pmic_seq_element() is also
working with atomisp driver.

Regards,
Tsuchiya Yuto

