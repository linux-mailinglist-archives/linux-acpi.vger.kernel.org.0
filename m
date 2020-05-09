Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959AD1CC0DF
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEILWM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 May 2020 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727093AbgEILWM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2020 07:22:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC9C061A0C;
        Sat,  9 May 2020 04:22:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so5445835pjd.1;
        Sat, 09 May 2020 04:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc0J+alQfOrvgwIOBD8elSqmi3vnePVNZdws8SziVdQ=;
        b=s/yXFOFLCfVR6jEU6GzFIKNNpotAKDJUK8b99OGXLCIjN/6huyEwt3Cd9Yw3Mtm71U
         hH2qaX6gQSZ1pIaEgH37SHvQncbLrulga2SZDgUMzCw0awTWOuBnfLIOrTkf+NNH+w1X
         /pLd/PMubOFlh1/Vvws3zf+ZsrrWEOGNCAvPsEY291MZ6G0FPA06RfKVO+pmJSkcuFAS
         Ko5u1eJryTQyBXqeWktV8sBGk4/k3glhbpNKZoxnvBunpNOpHrThP0MVjjha1i5VQ34A
         qzNIicBHLtCoeGqQP/HoDutdZTVPmyuKetkN7bA3Oa1wrN70wg/PrlD6xg9Ci6GJ9wBv
         xy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc0J+alQfOrvgwIOBD8elSqmi3vnePVNZdws8SziVdQ=;
        b=PhAlEweKfwo62ZKk8da4Vq7rjx6BhT+r8md5CehbM0x7giTGR74SjSgfxImp+ovTMa
         kCiSqYl15J7Bsy5orSu+sLe62uyYm1mgBCE6V1p6JRe057xg6E5iMBV/bIDM8qW5LeI4
         eejQg/2Zs+wOtG25chTnjSjFwQ61JJOaVNkncLAMLdLEZcxbfqQlO2yeWcpOZawqwYI/
         E3m0FpIyEYNrxPJuE6nIh958ss+OQSIqXifLU0Z0qedNHdOISuhQB4jhnZwrf4cIybPh
         c6MjhJpYgw4YU/upj2I6k7b53TXQ8omGW2ThmUx4VU959rI1THHc9H8hyWUb2Mgqo/v3
         ZbtA==
X-Gm-Message-State: AGi0PuYfeO+OHzplw3cOz4KHGFZ+4pIkEP9IGT2ict3CUvaxS+W597mp
        17rh+nxEzBUjTrlRXayE2UT5a4osWX9DBkn/fGA=
X-Google-Smtp-Source: APiQypLqaOrW/kTHlmjah1lQ7VugqF1t6VsA1s5ASMnzgFEDI6a6f6vRMXehV0/h2i/GCrTb1m0ZRADj9jNrMe4iKTg=
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr11230982pjb.228.1589023331915;
 Sat, 09 May 2020 04:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200508164819.1.I6f1b6f973ee6c8af1348611370c73a0ec0ea53f1@changeid>
In-Reply-To: <20200508164819.1.I6f1b6f973ee6c8af1348611370c73a0ec0ea53f1@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 May 2020 14:22:00 +0300
Message-ID: <CAHp75VfF-y6GSrFKMx75b756jiO+0KtJUpa2X=778XVvoTh5dg@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix get_acpihid_device_id
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, May 9, 2020 at 1:50 AM Raul E Rangel <rrangel@chromium.org> wrote:
>
> acpi_dev_hid_uid_match expects a null pointer for UID if it doesn't

acpi_dev_hid_uid_match()

> exist. The acpihid_map_entry contains a char buffer for holding the
> UID. If no UID was provided in the IVRS table, this buffer will be
> zeroed. If we pass in a null string, acpi_dev_hid_uid_match will return

acpi_dev_hid_uid_match()

> false because it will try and match an empty string to the ACPI UID of
> the device.

Thank you for testing and producing a patch! My comments below, after addressing

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Fixes: ae5e6c6439c3 ("iommu/amd: Switch to use acpi_dev_hid_uid_match()")

Suggested-by?

> Signed-off-by: Raul E Rangel <rrangel@chromium.org>



> ---
>
>  drivers/iommu/amd_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 20cce366e951..06f603366cb1 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -125,7 +125,8 @@ static inline int get_acpihid_device_id(struct device *dev,
>                 return -ENODEV;
>
>         list_for_each_entry(p, &acpihid_map, list) {
> -               if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
> +               if (acpi_dev_hid_uid_match(adev, p->hid,
> +                                          p->uid[0] ? p->uid : NULL)) {

I would still use *p->uid as done in other places in the driver and
put this all on one line (however, the latter is complete style
preference depending on maintainer's choice)

>                         if (entry)
>                                 *entry = p;
>                         return p->devid;
> --
> 2.26.2.645.ge9eca65c58-goog
>


-- 
With Best Regards,
Andy Shevchenko
