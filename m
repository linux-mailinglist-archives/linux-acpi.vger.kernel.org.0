Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C154D3C8
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346713AbiFOVcJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350179AbiFOVcH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 17:32:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CA8562F7
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 14:32:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x5so18038237edi.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odvCzLSKKuiENzizfeaGPvIgCKaPVvEk14WpPahs/w0=;
        b=OnzhAziPMz7BHhj/klhh24Swx+QtNowWmbMd6LuDCBdP+N43Bru7ha5pDEi+zB8Wrn
         C5LJr23DLqYvwwlmXfU5XJSqKepu5Kld6wRDFojm8YhrHA91B8VfXbHpxmtQnT78d+8M
         sBKz1cmPGJzIE76Zqawbp47jx13Qukc/o3cujrY4VqY+++HfchJW6IdNvp3v7XcDVy47
         Qv7m6tXQpwATaT38bi/yk6TK1OBatkIfvQ1A187WEMFcQJJRJayYu+M4OxdBFC1wGF3R
         tlL3n4rMjbpmMhYzoIKKVL40bQlJ8DUZcBnR7mMjAqyxKQTywAPAR+2av4zBbXzvBy8S
         p2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odvCzLSKKuiENzizfeaGPvIgCKaPVvEk14WpPahs/w0=;
        b=QCkQa2FWtanX15Wz/S0voJUOh5K+mgr19vfl6yoPWuQkoX2LFg7Iwwia1VTAUSvgOE
         TaF+Rl47uMC+gs1klbAVjCI+41MS5BoTc5FwkODgjWuliTp5h53sOuVJW+EUswGUIP2B
         UMZ9QQ+wts0P1umQVlQ1ewmCbcQVd9Btzu9AtiGpeu/B666YNrsgwlof5Hgj+19hTKZH
         eega0uIIUL2U9UaB65hO/TneI+/iBEkLbkP/pu34442eUSbEWJB8UHPovzUKx75BA2x5
         9+lZ6ef8ajQFXs3QyVZT3FohH/RFSHO25d3iC6jGcSUojFolNXaNSAIGVLY0d9oJWmGy
         VztQ==
X-Gm-Message-State: AJIora+OTwntwT58tWDsBCLj80+oHwBziFEf73ONXqkTs+iXakCoiUul
        dZHo3St8sqKdXOhOGBNgO2gq+VLgHeZ+AhlE8vk=
X-Google-Smtp-Source: AGRyM1tTcMur2c22XOrIYhYZpjD/tj2dl8cIS+3H0YGB/UpWbCUfUHZePvyqd7sDIfyssr64VznjuvMDXBNDbIPABAs=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr2263152eda.141.1655328721215; Wed, 15
 Jun 2022 14:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220615195643.12608-1-hdegoede@redhat.com> <20220615195643.12608-3-hdegoede@redhat.com>
In-Reply-To: <20220615195643.12608-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 23:31:24 +0200
Message-ID: <CAHp75VcPEw93_3dZvKCadnAqrJCVvdVcKh+DodgBC68xkmJ7VQ@mail.gmail.com>
Subject: Re: [RFC 2/4] ACPICA: Add \_SB.PC00, \SB.PCI0 to acpi_ns_early_initialize_devices()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Since ACPICA commit f005ee6b90d1 / Linux commit 2d3349de8072
> ("ACPICA: Namespace: Reorder \_SB._INI to make sure it is evaluated
> before _REG evaluations") acpi_initialize_objects() calls \_SB._INI
> before executing _REG OpRegion methods, because the _REG methods may
> rely on initialization done by this _INI method.
>
> In many DSDTs the \_SB.PC00._INI / \_SB.PCI0._INI methods set an OSYS
> global variable based on _OSI evaluations.
>
> In some cases there are _REG methods which depend on the OSYS value and
> before this change ACPICA would run these _REG methods before running
> _SB.PC00._INI / \_SB.PCI0._INI causing issues.
>
> 2 examples of problems caused by running _REG methods before these
> _INI methods are:
>
> 1. on a "Lenovo IdeaPad 5 15ITL05" \_SB.PC00.LPCB.EC0._REG gets
> evaluated before \_SB.PC00._INI and that _REG contains:
>
>     If ((OSYS == 0x07DF))
>     {
>         Local0 = 0x06
>     }
>
>     If ((Acquire (LFCM, 0xA000) == Zero))
>     {
>         OSTY = Local0
>         ...
>
> With OSTY being a SystemMemory OpRegion field, due to the _INI running
> too late, Local0 stays at 0. Causing OSTY to be set to 0 instead of 6,
> which causes the brightness up/down keys to not work:
> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>
> 2. On a "Lenovo Thinkbook 14-ILL" \\_SB_.PCI0.I2C0._REG gets
> evaluated before \_SB.PCI0._INI and that _REG contains:
>
>     If ((OSYS == 0x07DF))
>     {
>         ...
>         LNUX = Zero
>         TPID = 0x4E
>     }
>     else
>     {
>         LNUX = One
>         TPID = 0xBB
>     }
>
> And then later on the TPID value gets used to decide for which of multiple
> devices describing the touchpad _STA should return 0xF and the one which
> gets enabled by TPID=0xBB is broken, causing to the touchpad to not work:
> https://bugzilla.redhat.com/show_bug.cgi?id=1842039
>
> Fix these issues by adding \_SB.PC00._INI / \_SB.PCI0._INI to the list of
> _INI methods to run early (before executing _REG methods).

...

> -       char path[ACPI_PATH_SEGMENT_LENGTH + 2];
> +       char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];

Strictly speaking this should be, IIUC,

1 + ACPI_PATH_SEGMENT_LENGTH + ACPI_NAMESEG_SIZE + 1

\\ + path segment length (with a separator) + name + \0

That said, it seems the original code adds 1 unneeded byte.

Perhaps a comment in the code?

-- 
With Best Regards,
Andy Shevchenko
