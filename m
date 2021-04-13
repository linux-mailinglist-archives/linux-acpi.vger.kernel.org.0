Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2835E097
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbhDMNu6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 09:50:58 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:47067 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbhDMNu6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Apr 2021 09:50:58 -0400
Received: by mail-oi1-f176.google.com with SMTP id m13so17012223oiw.13;
        Tue, 13 Apr 2021 06:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdyR71kTkfpeHF/EpMG2O0OtQJyT62euvnTos7ckC7w=;
        b=jGHypU+egmsvM/vqMdbAT4tyjSD51ZDYZ8uiWMFtswExCPY2uvVgljMUwR0FRJCaNv
         F4KvhXlqTslexvY4R8mqL5FL6FjwarSgeQW/iD1ITYMaWD8Cf2ZBTQCjfMGXYj8nWg25
         XJ9BY7U+tfUnG0lB0/imv7uQEc9GfomFWZsHla8jOhWMQj8Q6BVbgxTLGnJxBqRIzhxP
         rwAGet/vZiJt7TdYEuN3tg3l3U73WYQbIYWC+kw30KsoE+xRbkOJrG3DsFGHoaaAKiL1
         m0ZNWS/zlsp+0u+e9Pjb2FTFW0k4XPJXy+5wxYCbG29YlUrXIBq1Uj9duAUQL+yfFy2F
         ZveA==
X-Gm-Message-State: AOAM533CAmlPzy3riY7SpZUDQLQCzxkmFepIM2e3BSTaT8PtYXpgd8OV
        ejWc56drDIzAyATtsyM3YWt8MfLym24kuK8Fv94=
X-Google-Smtp-Source: ABdhPJyyTafYsWebd5UD1ovESk+NGxPPB3qbfRzAJK3Ea6IHUZIM0C1Aj1rLpINlnMuTHjvIfh/RqxSNgUtz4KH6Y/Y=
X-Received: by 2002:a54:4501:: with SMTP id l1mr62010oil.157.1618321832254;
 Tue, 13 Apr 2021 06:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210412232052.2162107-1-andy.shevchenko@gmail.com> <20210412232052.2162107-2-andy.shevchenko@gmail.com>
In-Reply-To: <20210412232052.2162107-2-andy.shevchenko@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Apr 2021 15:50:21 +0200
Message-ID: <CAJZ5v0gsSD=4FjtTwi=Op5-rdhTo1KGMSUJ4OirFGUiWueVFCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: utils: Capitalize abbreviations in the comments
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 13, 2021 at 1:21 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> The DSDT and ACPI should be capitalized.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v2: split from patch 1 as per Rafael's request
>  drivers/acpi/utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 60e46efc1bc8..3b54b8fd7396 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -811,7 +811,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
>   * Note that if the device is pluggable, it may since have disappeared.
>   *
>   * Note that unlike acpi_dev_found() this function checks the status
> - * of the device. So for devices which are present in the dsdt, but
> + * of the device. So for devices which are present in the DSDT, but
>   * which are disabled (their _STA callback returns 0) this function
>   * will return false.
>   *
> @@ -838,7 +838,7 @@ EXPORT_SYMBOL(acpi_dev_present);
>
>  /**
>   * acpi_dev_get_next_match_dev - Return the next match of ACPI device
> - * @adev: Pointer to the previous acpi_device matching this @hid, @uid and @hrv
> + * @adev: Pointer to the previous ACPI device matching this @hid, @uid and @hrv
>   * @hid: Hardware ID of the device.
>   * @uid: Unique ID of the device, pass NULL to not check _UID
>   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> --

Applied as 5.13 material along with the [1/2], thanks!
