Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0501C9B5B
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2019 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfJCKBH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Oct 2019 06:01:07 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36856 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfJCKBG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Oct 2019 06:01:06 -0400
Received: by mail-ua1-f65.google.com with SMTP id r25so698718uam.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Oct 2019 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ML7iGjCkdk3T2RUYqxLIiWX6QK9V+cTAyo+lZTGYhEg=;
        b=k2WgVKBMUG6BnJ7WwXT6WneVf49y81sfCSZmPfn4mNlx3geInIen0RP3hPUbg/jkXm
         epQR2qrp2xxsefUoDIQx0BIsoTQSx1xF8K6pwuCU2c1EuO+oj9oEnidz3dFC+VBQiAZl
         aI3o8KTvSSY4rBGL0vRHcaeBVAGFJvxRjkE4XaDcYcQY+spQepqqgLhBsdGOay95Jv+L
         /a7aiJFJJvZxf2Wtj5WsgPLsmo06HHbLfQs7Q+fAnVNxDh0Yb8kBeK9jVAIqZrBVYTjQ
         JevdRziG3ApzhBJ/oTGw35uFFzHKk6Mz7Ui0nPUgahL3ZOUPwx95+jf3h7Bw2zj95+Dp
         4wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ML7iGjCkdk3T2RUYqxLIiWX6QK9V+cTAyo+lZTGYhEg=;
        b=ZDKE99FpCV4zQeq2BlG4AZgM5f9u0p8RwL5Crrjsjxo36vHxIX3pG31G4feyzGdvLq
         zwfN+0XVbJ7EWJYtrsVImrwj3licTIeljC/ar/VAP/c7/x/y+sOVnNNKBPhQQA6bqC4i
         SaLI2ABuNMsjgOkKl7ezsVb65LH9y3hwPgah42vRdHvLGh/ojh6pfItfZwUX6+FCahZ5
         MA6rRsOwe9wvdRAFVCx7EmXkoMLPEBIAt9mVSkQGy1/oxbFSkScwKAZbddlWveUcjMt4
         KTZFjDWLkaCAh7SZtzn4G9Qt0se7Q7yPhgBK8YjaXf/ufMefvYlJTBDfnPwr0WLs79LJ
         I2CA==
X-Gm-Message-State: APjAAAWvCElVSiy/Sj+paDu00xiOtHW4pFZbxQufh0D58iydJOnveEEO
        nQzZIUIRcS2AaPBaRO1O8hmQeBL6zuWEpy1IHa+cew==
X-Google-Smtp-Source: APXvYqxdtcpDHsTAYowYb9631c0RBuYsoH8cHEL10avvjnLuGotCXrQZLi8185Qxw90DxHswtjDxgdlZmu0frmN+y+M=
X-Received: by 2002:ab0:1856:: with SMTP id j22mr4554523uag.19.1570096865564;
 Thu, 03 Oct 2019 03:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:00:29 +0200
Message-ID: <CAPDyKFq_HPDW5i5ND_df4GJsnaOowHWbFTkgCCOP6w9ar2uo6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ACPI / utils: add new helper for HID/UID match
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 1 Oct 2019 at 16:27, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are few users outside of ACPI realm that re-introduce a custom
> solution to match ACPI device against HID/UID. Add a generic helper for
> them.
>
> The series is supposed to go via linux-pm tree.
>
> In v3:
> - correct logic in sdhci-acpi for qcom devices (Adrian)
> - add Mika's Ack
>
> In v2:
> - add patch 2 due to latent issue in the header (lkp)
> - get rid of match_hid_uid() completely in patch 6
>
> Andy Shevchenko (6):
>   ACPI / utils: Describe function parameters in kernel-doc
>   ACPI / utils: Move acpi_dev_get_first_match_dev() under CONFIG_ACPI
>   ACPI / utils: Introduce acpi_dev_hid_uid_match() helper
>   ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
>   mmc: sdhci-acpi: Switch to use acpi_dev_hid_uid_match()
>   iommu/amd: Switch to use acpi_dev_hid_uid_match()
>
>  drivers/acpi/acpi_lpss.c      | 21 +++------------
>  drivers/acpi/utils.c          | 32 +++++++++++++++++++++++
>  drivers/iommu/amd_iommu.c     | 30 ++++-----------------
>  drivers/mmc/host/sdhci-acpi.c | 49 ++++++++++++-----------------------
>  include/acpi/acpi_bus.h       |  8 +++---
>  include/linux/acpi.h          |  6 +++++
>  6 files changed, 67 insertions(+), 79 deletions(-)
>
> --
> 2.23.0
>

I guess Rafael intend to pick this up for v5.5?

In any case, for the mmc patch, feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
