Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843D35F596
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351683AbhDNNv3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 14 Apr 2021 09:51:29 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36601 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349187AbhDNNvZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Apr 2021 09:51:25 -0400
Received: by mail-oi1-f176.google.com with SMTP id c16so20666667oib.3;
        Wed, 14 Apr 2021 06:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wBROHEdqHjbHn2xOAzD9zl5G4PP8Iw0t5oCeREsbRUI=;
        b=F2D6psmUzXXC1AdCBajhfRvsnbwY7cIDXsB1Y3274pR9nLpR9203y6zEZ3tLFlZMr2
         9BYsg4Ubsqu/yXblNfO99k1JiyNvMCqksp3BqbTOQ/Vm2KdFaOU2JfDJlsKuVLmyJaSd
         A6kyQD8Fd9JkL9OifZ88alXyJLSx2stiyjLvra/1tZAY7g7RFv3J6TuWp2DQG8PXXCJq
         coCiscT2+NiLVayvYjlfKH8Lrk+CS2YAL+cZebcd/LHB4+QSd8YoUFExsQexgFQbpV0C
         /0Fc+02oGpHYkH5WmKXBQhrpZi8G88vKskfp0BvTg7/w7dASfnJfiV1Trpf3eJAC7w1+
         FB3A==
X-Gm-Message-State: AOAM5323I084gmIbVzV0c5T9bIb1+iiT9DdDAiRe3k75kVPsM1A+2sjo
        QWWJqi0FA8LTK/A68nATNMT95J8r5ik8Q6GNk4E=
X-Google-Smtp-Source: ABdhPJyhYaDnUaYnzBxw8igmmnt23AyoMpasJJWHn8h31YSoD28txunXdSxgxZg0g8G7IlVS4hI/flsMyB1LxHSZP2c=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr2337394oib.69.1618408264317;
 Wed, 14 Apr 2021 06:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210413063435.18111-1-me@fabwu.ch> <20210414083022.25453-1-me@fabwu.ch>
 <20210414083022.25453-2-me@fabwu.ch>
In-Reply-To: <20210414083022.25453-2-me@fabwu.ch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Apr 2021 15:50:53 +0200
Message-ID: <CAJZ5v0ich7DA47ybP552MJJg6-TkShnJyGcrz0PpWYETHHREHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: Add _PLD panel positions
To:     =?UTF-8?Q?Fabian_W=C3=BCthrich?= <me@fabwu.ch>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2021 at 10:30 AM Fabian Wüthrich <me@fabwu.ch> wrote:
>
> The ACPI specification v6.3 defines the panel positions in chapter 6.1.8
> "_PLD (Physical Location of Device)"
>
> Signed-off-by: Fabian Wüthrich <me@fabwu.ch>
> Reviewed-by: Daniel Scally <djrscally@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

This is ACPICA material.

Erik, can you pick up this one, please?

> ---
>  include/acpi/acbuffer.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
> index 18197c16149f..d42e82a82852 100644
> --- a/include/acpi/acbuffer.h
> +++ b/include/acpi/acbuffer.h
> @@ -207,4 +207,13 @@ struct acpi_pld_info {
>  #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16, ACPI_16BIT_MASK)
>  #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16, ACPI_16BIT_MASK, value)      /* Offset 128+16=144, Len 16 */
>
> +/* Panel position defined in _PLD section of ACPI Specification 6.3 */
> +#define ACPI_PLD_PANEL_TOP                     0
> +#define ACPI_PLD_PANEL_BOTTOM                  1
> +#define ACPI_PLD_PANEL_LEFT                    2
> +#define ACPI_PLD_PANEL_RIGHT                   3
> +#define ACPI_PLD_PANEL_FRONT                   4
> +#define ACPI_PLD_PANEL_BACK                    5
> +#define ACPI_PLD_PANEL_UNKNOWN                 6
> +
>  #endif                         /* ACBUFFER_H */
> --
> 2.31.1
>
