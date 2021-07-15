Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9853CA068
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhGOOUZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 10:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbhGOOUZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jul 2021 10:20:25 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCABC061760
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jul 2021 07:17:31 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id gh6so2884686qvb.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jul 2021 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CNbwYH1jj9aPFq6ITR5bv7LJgp03H7MSJ97sfJLz5XY=;
        b=tFhKa2IuUYww1ovA8t2rMqAqDzZYwIpTItc+P1P+RdsuZVM10lHlQ/zdhfeuW1/bb/
         530T9KuI9i/v5lXBMTUvzmlgg2XVVtVjtFX+qoxoLjRtxJOkzSQHjXl39mDVpid2Wi+U
         dmamAz6Ef/R8im8UNZbsowPsABXZeqpm6lAZ2xCxQUtDyLEgch1OxtnH+W/j2PVxMLRO
         yPF71fcdBDInztryeysZWH7lFc8jCZaLq5G5dqS6N4ULcI2mAOyj2MHZThwL2p+Wuouq
         pYmAtumCUd0nfX0iYt6845ULT8Y7IoaEFb8U/XFl/JD5bK1pHkzUHI0tmOIbVsOu+kUB
         ztSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CNbwYH1jj9aPFq6ITR5bv7LJgp03H7MSJ97sfJLz5XY=;
        b=kvF4+IVgtQsGBTS3h0JB17UW5wtKSMf0Aj56lI1fTdv11Obcp+vYbPvD1WOJNL6kZZ
         UJbv068+cte+njin409hvgHIoY3JVfRcyOmfh/cHR/rZe49kDdD2fGo14q/fqeXP1aq8
         JyUqQUJSJGadvM+0rd875bqgdKQ20D2rAVKhi23jEsBtvuQ4W3hqQiG8GMng3KTHUziB
         RRgPQwyZZShS3UkCxkXghotS1uh21xZ7wdtZBzFsIODr7Pa+0w6XGwwiUtVfV4xUNBTX
         Qf7WsZs6dkgLVqAm+ECLe5l3zIGIxU9FFf27Nl/sehgkvOdxVg/mXIAzRdloWbT9kqcQ
         j+vw==
X-Gm-Message-State: AOAM532wsHL5i2XGjA7a6ZGP/9/KNJok8nlrp1YbzoNpIca9CdGq9MtA
        zuMKkH/fxQuKg1NiAA64XLy9nMpt4bsilme/0V3DWg==
X-Google-Smtp-Source: ABdhPJwBwTxf19Rj3bFnP7Y2WCjEr1Mx7LovQqCJqWhS61xXy1AERdeEC9IeReWD2Bb20SOSh+O2Aadr7C8kREb60ng=
X-Received: by 2002:a05:6214:dce:: with SMTP id 14mr4619816qvt.40.1626358651017;
 Thu, 15 Jul 2021 07:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210714214346.1397942-1-mw@semihalf.com> <20210714214346.1397942-2-mw@semihalf.com>
 <BYAPR11MB3256CACCFB4A08B5D450D3A087129@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256CACCFB4A08B5D450D3A087129@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 15 Jul 2021 16:17:20 +0200
Message-ID: <CAPv3WKeN55zEW65yfyPizB0WA4HLtcf=m-7yUgpk7O1hCKW4SA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gjb@semihalf.com" <gjb@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "Samer.El-Haj-Mahmoud@arm.com" <Samer.El-Haj-Mahmoud@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


czw., 15 lip 2021 o 16:07 Moore, Robert <robert.moore@intel.com> napisa=C5=
=82(a):
>
> This was already reported (with a patch that we've already merged) by sem=
ihalf-wojtas-marcin
>

I'm not sure to be aware of the process. Reported where?
Are you planning to import the upstream patch on your own and I should
rebase the SPCR driver change on top once it lands?

Best regards,
Marcin

> -----Original Message-----
> From: Marcin Wojtas <mw@semihalf.com>
> Sent: Wednesday, July 14, 2021 2:44 PM
> To: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; devel@acpic=
a.org
> Cc: jaz@semihalf.com; gjb@semihalf.com; upstream@semihalf.com; Samer.El-H=
aj-Mahmoud@arm.com; jon@solid-run.com; tn@semihalf.com; rjw@rjwysocki.net; =
lenb@kernel.org; Moore, Robert <robert.moore@intel.com>; Marcin Wojtas <mw@=
semihalf.com>
> Subject: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
>
> ACPICA commit d95c7d206b5836c7770e8e9cd613859887fded8f
>
> The Microsoft Debug Port Table 2 (DBG2) specification revision September =
21, 2020 comprises additional Serial Port Subtypes [1].
> Reflect that in the actbl1.h header file.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acp=
i-debug-port-table
>
> Link: https://github.com/acpica/acpica/commit/d95c7d20
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  include/acpi/actbl1.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index ef2872de=
a01c..7bbb3e2bd33f 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -482,7 +482,7 @@ struct acpi_csrt_descriptor {
>   * DBG2 - Debug Port Table 2
>   *        Version 0 (Both main table and subtables)
>   *
> - * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10, 2015
> + * Conforms to "Microsoft Debug Port Table 2 (DBG2)", September 21,
> + 2020
>   *
>   ***********************************************************************=
*******/
>
> @@ -532,11 +532,24 @@ struct acpi_dbg2_device {
>
>  #define ACPI_DBG2_16550_COMPATIBLE  0x0000
>  #define ACPI_DBG2_16550_SUBSET      0x0001
> +#define ACPI_DBG2_MAX311XE_SPI      0x0002
>  #define ACPI_DBG2_ARM_PL011         0x0003
> +#define ACPI_DBG2_MSM8X60           0x0004
> +#define ACPI_DBG2_16550_NVIDIA      0x0005
> +#define ACPI_DBG2_TI_OMAP           0x0006
> +#define ACPI_DBG2_APM88XXXX         0x0008
> +#define ACPI_DBG2_MSM8974           0x0009
> +#define ACPI_DBG2_SAM5250           0x000A
> +#define ACPI_DBG2_INTEL_USIF        0x000B
> +#define ACPI_DBG2_IMX6              0x000C
>  #define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
>  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
>  #define ACPI_DBG2_ARM_DCC           0x000F
>  #define ACPI_DBG2_BCM2835           0x0010
> +#define ACPI_DBG2_SDM845_1_8432MHZ  0x0011
> +#define ACPI_DBG2_16550_WITH_GAS    0x0012
> +#define ACPI_DBG2_SDM845_7_372MHZ   0x0013
> +#define ACPI_DBG2_INTEL_LPSS        0x0014
>
>  #define ACPI_DBG2_1394_STANDARD     0x0000
>
> --
> 2.29.0
>
