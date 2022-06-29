Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9E5606EA
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jun 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiF2RDf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 29 Jun 2022 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiF2RDe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2022 13:03:34 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122C815A06
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 10:03:30 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v185so19554136ybe.8
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 10:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aqm4FC89DWarFJMROs925TeGjJpuRjPm9/zQL+5jjQE=;
        b=JkhBRZFc+jzkOhRGYotPQ0Ta6Ivy+BEWCoDMV5NcmRuhLeFT6WjF5FhdH2vw4Gljrv
         XqflT1WtKn6c/Gxm75Td6y2iTP91j7FtTPg+PUCAlLBMowSt4KTMWKgTuFORqjSWGlGP
         mxxJwNtcV1vqBIhUcFAtZkE/66afzUmq3WJY5Bqm3wKCZHIOaiyaoxFyYzysJ/zGxolW
         ilJEike/7Edtw3vcqVjlUEDXyTE0BbZBJr4MP0oe+qqC55wHhOm9hgiBXBhoWK4DowVB
         0fzK/2M/nwLkRd42hgCkw6e+UJttqU2T6cvrlt9dBHOVV27/gDew73vcvlxTSVyvN2Eo
         OWzw==
X-Gm-Message-State: AJIora8FX7IorDNBZxf19KDZ5XA2+piEuF5NgNi5+5vE76AhOjOxeCID
        c/7KMzlFzOJ3v6PTHneDDXTRrVPzTaWtMNZ25fg=
X-Google-Smtp-Source: AGRyM1totlxXjvK3OXv8JitH90a/+eghX8CaC1a/ln47tRlBn1zPE3Y6wq3ucmu8X9MfmmhLC/RXwQ0HXGtuP918OL0=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr4328210ybm.482.1656522209222; Wed, 29
 Jun 2022 10:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220618112311.14661-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220618112311.14661-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 19:03:18 +0200
Message-ID: <CAJZ5v0hgPwRHyU6cG-gqtRM4wLaKGRoL3z1nS_FiTybLAcvgGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: Drop redundant check in acpi_device_remove()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 18, 2022 at 1:23 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> A bus remove callback is only ever called by the device core with a
> bound driver. So there is no need to check if the driver is non-NULL.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/acpi/bus.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 86fa61a21826..67a3f8cf42f9 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1062,12 +1062,11 @@ static void acpi_device_remove(struct device *dev)
>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>         struct acpi_driver *acpi_drv = acpi_dev->driver;
>
> -       if (acpi_drv) {
> -               if (acpi_drv->ops.notify)
> -                       acpi_device_remove_notify_handler(acpi_dev);
> -               if (acpi_drv->ops.remove)
> -                       acpi_drv->ops.remove(acpi_dev);
> -       }
> +       if (acpi_drv->ops.notify)
> +               acpi_device_remove_notify_handler(acpi_dev);
> +       if (acpi_drv->ops.remove)
> +               acpi_drv->ops.remove(acpi_dev);
> +
>         acpi_dev->driver = NULL;
>         acpi_dev->driver_data = NULL;
>
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --

Applied (with minor modifications) as 5.20 material along with the [2/2].

Thanks!
