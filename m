Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF780430BA8
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Oct 2021 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhJQTLF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Oct 2021 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhJQTLE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Oct 2021 15:11:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C8BC06161C;
        Sun, 17 Oct 2021 12:08:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y12so63436656eda.4;
        Sun, 17 Oct 2021 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4wPfnIdmFR0mVDCTT9DLYHlH1SJpsLuL8bJ7s6TiF8=;
        b=eqXhpr1xFPJ6ot/+IRHxQv4y0Qu2npluiR4EBgsxDvJyYyLtOJMz8z49dpwQ+QTNXG
         VG4o1Sbe0nL3M3b/t/sFJYd2zzVO7qjKH9tW7ZuFMtkKUxuC+ll8nM+tpN3pi8QysFGg
         C61mZ2f43rxRSHFwzuGJJ0mhkYAL6eBaJC+nkS5ohyWutc78gaiN7hu4TRET+Mxm0bSq
         qg6+thWnZ/5YHTP5MZAMybf+dLkYTKDac8mKPSw+lItQc7QN+fx+3ezezu5ncweFhPku
         gIVd53ib4HZx6FX53d727UYtWxGExf56chxPQXFIF+kYqtpB3GVbeVybhBvo0Q1KcnG8
         nSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4wPfnIdmFR0mVDCTT9DLYHlH1SJpsLuL8bJ7s6TiF8=;
        b=CFkTAEGlS7Oae94qAbVSeH0xxiBwpm5g3ZpM10LovruIy8/a0ZJ+FqOkNeAKMVBQ5K
         LsU6aFQpNxLNnGVpkwdiBx7HY9p8E5xilbqgWeXzctE797UFy5OAumxBh7C7cQzC7ABl
         Zi+xXbfkkwyNC5tln7ful8jZ8EjOpIb1VPkVnCnAWTLJXdUgU2CEU0t1rYuYtUg7JHuA
         q/UJTpKElAHJO2w5Y9+HRpJxGOofOrkJYz4WOlNphxGev8IW+GaFpI30OjO4AcXSY5tK
         g7t7PGngfAopsaQCsVpOUR7gy0IYFZfIlbgJLSWAhC693OfQwv6t0OcWygYD/wZhUs2m
         UWjQ==
X-Gm-Message-State: AOAM531NXsKz2OMwBsxklgRQS6FDY4pWPWz7SoR3tsBuQAn2KliEVG2i
        WXbQpZ/jmE76WEvgAZkC5uF3P4oINUJENJIF9pw=
X-Google-Smtp-Source: ABdhPJxA4vOkMI89Yz/fNxUEqKJBbnJJL1WyIvbb0BkBTvaC9TlQZLCw9egWLsYTEwxT45L4WzXIMXCvULOS+joAYd0=
X-Received: by 2002:a17:907:8a27:: with SMTP id sc39mr23636774ejc.567.1634497732785;
 Sun, 17 Oct 2021 12:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211017161523.43801-1-kitakar@gmail.com> <20211017161523.43801-2-kitakar@gmail.com>
In-Reply-To: <20211017161523.43801-2-kitakar@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 17 Oct 2021 22:08:16 +0300
Message-ID: <CAHp75VfZyk_Ar23grNk2PvzRqaSO++CdkU4NWe2guNkwdGivzg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to intel_pmic_bytcrc driver
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 17, 2021 at 7:16 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
> On Microsoft Surface 3 (uses Intel's Atom Cherry Trail SoC), executing
> intel_soc_pmic_exec_mipi_pmic_seq_element() results in the following
> error message:
>
>         [ 7196.356682] intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
>         [ 7196.356686] intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x6e reg-addr 0x57 value 0x63 mask 0xff
>
> Surface 3 uses the PMIC device INT33FD, and the DSDT describes its _HRV
> value is 0x02 [1]:
>
>         Scope (PCI0.I2C7)
>         {
>             Device (PMIC)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _HID: Hardware ID
>                 Name (_CID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _CID: Compatible ID
>                 Name (_DDN, "CRYSTAL COVE+ AIC")  // _DDN: DOS Device Name
>                 Name (_HRV, 0x02)  // _HRV: Hardware Revision
>                 Name (_UID, One)  // _UID: Unique ID
>                 Name (_DEP, Package (0x01)  // _DEP: Dependencies
>                 {
>                     I2C7
>                 })
>         [...]
>
> Due to this _HRV value, intel_pmic_bytcrc is used as the PMIC driver.
> However, the i2c address is currently not defined in this driver.
> This commit adds the missing i2c address 0x6e to the intel_pmic_bytcrc
> driver.
>
> [1] https://github.com/linux-surface/acpidumps/blob/f8db3d150815aa21530635b7e646eee271e3b8fe/surface_3/dsdt.dsl#L10868

> References: cc0594c4b0ef ("ACPI / PMIC: Add i2c address for thermal control")

Not sure what this tag means.

After reading a bit of code I think the best approach is to quirk the
drivers/mfd/intel_soc_pmic_core.c with DMI to supply HRV. Setting an
address to all BYT devices may not be the best since I have no idea if
there are different addresses in use. It may be the case, but the
problem is that we have no proof. Also BYT driver uses hardcoded power
and thermal tables, I'm completely unsure that this would not damage
hardware in some circumstances.

Hans, what's your opinion on this?

P.S. I dunno if _UID correlates to the type of the chipset (BYT/CHT).

-- 
With Best Regards,
Andy Shevchenko
