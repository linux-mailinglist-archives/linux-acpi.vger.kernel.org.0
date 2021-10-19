Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377A94334F6
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Oct 2021 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJSLr3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhJSLrX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Oct 2021 07:47:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C30C06161C;
        Tue, 19 Oct 2021 04:45:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso2442723pjw.2;
        Tue, 19 Oct 2021 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MglkHL3I8pOQyT8id8QRZWPVa8Wa8unBVBsZ/PvSniQ=;
        b=Lxs0zOW48ZOq5Jak2/0u6Z0F2sxlznq6YMiO+bNC7OmfMgDh4IPXX7HSRGO4BrW/al
         IPQ91uGDO2Hui2GK+dqIB/PIylvk4dWl41qHDPZYy1OhPJILlWfu4zvkptZkaL6/fGv4
         pqiJitP51Ibr2Pl/QT6rLA0xY/zV2a6ixd7IPYl2k59/HSZgQTVTu9DbQM2PGt/6gfB4
         RpWpkkcNJiE6jH79yX8+o2XsglAOwKWn2J+tuuDI4hVHD3SzvETEFwG5X/xgm4EDpIek
         cOd3AIyj+TzZDJwGrz8cu92ZlTeXLgbEyNHol+y3SMyV1Mfl3s5MlF2MW/g6V2jPgJx0
         AoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MglkHL3I8pOQyT8id8QRZWPVa8Wa8unBVBsZ/PvSniQ=;
        b=cYTzBKV3fZhChjWWfOu1wofienj9JkC72g/Ft9hQq4PHZbXPhdHpSWHPjj4NfIG8fV
         maQj9OqjRcO11f3K/0XapUCwzXvQoCfEwbbBioAYvkmz/q68R/acqRPDvvi3oBpGHTOH
         MDNYU9m8rXH2L4W/WVtOo0ovfqeroCWgIKgXX3sCp4Nevfn2JAY+3uQV85d5m4yFpSYB
         EwUpAPl6tIxtsP3pbJ70MTFGWdxkgnvg8Sdec/lhW3Xj9pOLiYrXqzjXmcNTzu8J5nIo
         IjDP9Iqum9SI3EdaD6/qFGV5Dspwc+/qTkUSocYi1kA/gtPzFq2GAtkmD3EKoMPQ4cel
         gxxA==
X-Gm-Message-State: AOAM533q8HBQ3dhXY6pwPn6omB9NofOYEef1md5eGP/s6eizf+VbaEC1
        89yRv2ziryGCAOvqQ1xGb8KvWQ0CwDMjjg==
X-Google-Smtp-Source: ABdhPJxiatKS1Wr8/i/0jQI+M1WXBeOJRq4Rqoss6RqnaANTRhTQz4oI/AX2PYn9FER38GjjG6N4PA==
X-Received: by 2002:a17:902:d2c2:b0:13e:f4d2:ed3f with SMTP id n2-20020a170902d2c200b0013ef4d2ed3fmr32348919plc.87.1634643910184;
        Tue, 19 Oct 2021 04:45:10 -0700 (PDT)
Received: from ?IPv6:2400:4052:6980:3800:dba7:2b1f:3f26:a5ec? ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id o26sm16781587pfp.177.2021.10.19.04.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 04:45:09 -0700 (PDT)
Message-ID: <6881c1e592200b10be0b732cd038730c6bfbbb09.camel@gmail.com>
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to
 intel_pmic_bytcrc driver
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Oct 2021 20:45:06 +0900
In-Reply-To: <CAHp75VfZyk_Ar23grNk2PvzRqaSO++CdkU4NWe2guNkwdGivzg@mail.gmail.com>
References: <20211017161523.43801-1-kitakar@gmail.com>
         <20211017161523.43801-2-kitakar@gmail.com>
         <CAHp75VfZyk_Ar23grNk2PvzRqaSO++CdkU4NWe2guNkwdGivzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 2021-10-17 at 22:08 +0300, Andy Shevchenko wrote:
> On Sun, Oct 17, 2021 at 7:16 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
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
> 
> > References: cc0594c4b0ef ("ACPI / PMIC: Add i2c address for thermal control")
> 
> Not sure what this tag means.

Thanks!

I thought I could use this tag to mean "I made this patch with this
commit as a reference". If I used this tag incorrectly, I'll avoid using
it in the future and instead write with my words.

Regards,
Tsuchiya Yuto



