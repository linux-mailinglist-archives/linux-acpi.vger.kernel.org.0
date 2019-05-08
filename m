Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F917ACA
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2019 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfEHNgf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 May 2019 09:36:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33777 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfEHNgf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 May 2019 09:36:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so10530187pfk.0;
        Wed, 08 May 2019 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcAjCFqvrEogAPswfF0d6RXu+qS3neWGcM2Ua3UFe2k=;
        b=VQMI0LrSKYe10St2+918vW77S+/TVdK5nuIUgSDKJk9JF8zf2163RF6L+wUOb8Th9Z
         DJ0h6//Ex1f5OSlf4vQw2PA9+yOBt4RhfX/dsjz+s5oQyRcIxF+sAxs6tdhgNH6Hoii1
         m2CPC8pzqigkSA0uKdvo1npx7mnR8MZbf7VWLr+naD+BNwF/dylPJ2dkUiFy/mp7kp+r
         DT30n62LsEz9D11a05bcqIdkS+ltHLUHD4v7GFzG8am9ZZSMijl2WZm45/nMzAfIHEZy
         55rty48R46WV0HHwRimMa2LEwlcWt6iwkvvcSS9Rf5h5iRh8TF8gare15o4dMtP7C2d2
         m+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcAjCFqvrEogAPswfF0d6RXu+qS3neWGcM2Ua3UFe2k=;
        b=Qd5utrj5gxETkscyNT2Hhwo8pzcX3udaqQz3V0wbPumeIxaq71r8xjXBr0LBa+iQah
         EAd8csHg9PBFt5KxO8O+tPc1jBPILLyS56KiXygIKk+uJw6J/bEONKDSXsIH/fZi7nU2
         lvfFyIlYvtd7k/qUEbyax9KSDhIRAmNKdK32FSpN5qL5djOKqtsC1fsZbAcoaHISZTVp
         XHEF5V9ic5L1LMOBSXu7SSLNhExZ51yDGX1AxYzx4PPiR/PaWCi3bKs6bZOJgUYTTKfF
         wFgwf4gU9FCHEOAb8zqsftXdDbgJ/aHODxrksySq5mYShcr10UyLBoYeWBZ7yhXfx+IU
         JZ1A==
X-Gm-Message-State: APjAAAVPp94Wk06WRnvlMum4NcSQxKhEOFC7H/hT+0/KEQ0mvkLxlGQu
        rSS7gzVBcNbT6CB0h2KCLW86YD/47ID0QX3KwgKs/ah/UBJ0Yw==
X-Google-Smtp-Source: APXvYqxSZ+g127sAZ2xVF3qpVOpzxi03BfU/y7EIin06xjklKr3FEQEEW6UOavGyMz5qNV1wvooOGDnyOmaCqFQYh+8=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr15211082pge.428.1557322594290;
 Wed, 08 May 2019 06:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com> <d6ee51cc-eb0f-2bb9-fef9-f8b4bf849076@gmail.com>
In-Reply-To: <d6ee51cc-eb0f-2bb9-fef9-f8b4bf849076@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 16:36:23 +0300
Message-ID: <CAHp75VfMXAyUpWTrEHnv1NcQcHch+RHehWYTjk6KMTbXbtppPg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] platform/x86: asus-wmi: Improve DSTS WMI method
 ID detection
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 19, 2019 at 1:08 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The DSTS method detection mistakenly selects DCTS instead of DSTS if
> nothing is returned when the method ID is not defined in WMNB. As a result,
> the control of keyboard backlight is not functional for TUF Gaming series
> laptops. Implement another detection method instead.
>
> There is evidence that DCTS is handled by ACPI WMI devices that have _UID
> ASUSWMI, whereas none of the devices without ASUSWMI respond to DCTS and
> DSTS is used instead [1]. To check the _UID a new method is added to wmi.h
> / wmi.c. It returns _UID of the ACPI WMI device that declares WMI object
> with given GUID.
>
> Generally, it is possible that multiple PNP0C14 ACPI devices are present in
> the system as mentioned in the commit message of commit bff431e49ff5
> ("ACPI: WMI: Add ACPI-WMI mapping driver").
>
> Therefore the _UID is checked for given GUID that maps to a specific ACPI
> device, to which it is also mapped by other methods of wmi module.
>
> DSDT examples:
>
> FX505GM:
> Method (WMNB, 3, Serialized)
> { ...
>     If ((Local0 == 0x53545344))
>     {
>         ...
>         Return (Zero)
>     }
>     ...
>     // No return
> }
>
> K54C:
> Method (WMNB, 3, Serialized)
> { ...
>     If ((Local0 == 0x53545344))
>     {
>         ...
>         Return (0x02)
>     }
>     ...
>     Return (0xFFFFFFFE)
> }
>

> [1] https://lkml.org/lkml/2019/4/11/322

Link: ...?

>         int rv;
> +       char *wmi_uid;

Keep them in reversed spruce order.



> +       if (!strcmp(wmi_uid, ASUS_ACPI_UID_ASUSWMI)) {

> +               pr_info("Detected ASUSWMI, use DCTS\n");

dev_info()?

>                 asus->dsts_id = ASUS_WMI_METHODID_DSTS;
> -       else
> +       } else {

> +               pr_info("Detected %s, not ASUSWMI, use DSTS\n", wmi_uid);

Ditto.

> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c

> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h

This change should go separately.


> -#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS */
> -#define ASUS_WMI_METHODID_DSTS2                0x53545344 /* Device STatuS #2*/

> +#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS (DCTS) */

It's not clear from the description what 'C' stands for.
Is there any specification which describes the difference and actual
abbreviations?

> +#define ASUS_WMI_METHODID_DSTS2                0x53545344 /* Device STatuS (DSTS) */

-- 
With Best Regards,
Andy Shevchenko
