Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1386117F8
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Oct 2022 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ1QsE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 28 Oct 2022 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJ1QsC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Oct 2022 12:48:02 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957991FB78F
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2022 09:48:01 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id w10so4431180qvr.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2022 09:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR6hBUbaaS+vJGIDkedCMUN+TJ1RoJIi04HkXAKq/NI=;
        b=FtHNm6EGKTVWZ+khhF/4ISx0nSAq+3O9XjhiBik6NhblGV+GPxWWsWfQ1Mhtlgsdoe
         8kWeaABWuHZ5O5ZfJGK8cgergwWhtJlq8jX59eUO7LXviXX3Thtnh4asIyi61YZUpOIh
         PZhDENZm2nFBJsSKCc6+zQZS5+A03A2jinBbo1XFEQ0BWdapmgZnS3ABnysRqAA0arZI
         CCP3p3L8qE8xM2m7MmCd2CLECKwG2Rb5dQo1UWo3wyXjAAGNCoOjC6OUMotRBD0tJqGh
         Hk5IvzmgLSK6S+VAytf5uZaV8wxcc5Ed52jD2k0pYvQDVCN1UuNyUFkJyB+3GzfueVHh
         E8Gw==
X-Gm-Message-State: ACrzQf1oCSQ4RpT596gRvXdGPG/71UYHlGieFPi0tC6T9YcnWCJFDWCB
        oYG8rrfREwfZCDwx/2C6TNmyCsCQQWci8kb/uGg=
X-Google-Smtp-Source: AMsMyM4/7703x+MtC78iHXkoP1bDLY8CPs9Uzd5QUnwCJ0AvCcPrZCFGZPpB8zq5xOR0Wwd/NT/i1Ckf7FADChiSYx8=
X-Received: by 2002:ad4:596b:0:b0:4b1:ee66:1cb8 with SMTP id
 eq11-20020ad4596b000000b004b1ee661cb8mr324938qvb.3.1666975680756; Fri, 28 Oct
 2022 09:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221013064459.121933-1-u.kleine-koenig@pengutronix.de> <20221013064459.121933-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20221013064459.121933-2-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 18:47:49 +0200
Message-ID: <CAJZ5v0ifb-wvyp0JRq_4c1L6vTi_qEeXJ6P=Pmmq_56xRL74_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: APEI: Warn loudly on unsuccessful driver unbind
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 13, 2022 at 8:53 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> If the remove callback failed, it leaves some unfreed resources behind
> that will never be cleared. I didn't manage to understand the driver
> good enough to judge how critical that really is.
>
> This patch is part of an effort to change the remove callbacks for
> platform devices to return void in the hope this will prevent the wrong
> assumption that returning an error code from .remove() is proper error
> handling.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/acpi/apei/ghes.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> Hello,
>
> on a side note: The remove callback calls (in some cases) free_irq() for
> a shared interrupt. A requirement in this case is to disable the
> device's interrupt beforehand. It's not obvious (to me that is) that
> said irq is disabled here. This is another opportunity for ugly things
> to happen.
>
> Best regards
> Uwe
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 307fbb97a116..78d2e4df74ee 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1393,7 +1393,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
>         return rc;
>  }
>
> -static int ghes_remove(struct platform_device *ghes_dev)
> +static int _ghes_remove(struct platform_device *ghes_dev)
>  {
>         int rc;
>         struct ghes *ghes;
> @@ -1447,6 +1447,21 @@ static int ghes_remove(struct platform_device *ghes_dev)
>         return 0;
>  }
>
> +static int ghes_remove(struct platform_device *ghes_dev)
> +{
> +       /*
> +        * If _ghes_remove() returns an error, we're in trouble. Some of the
> +        * cleanup was skipped then and this will never be catched up. So some
> +        * resources will stay around, maybe even used although the platform
> +        * device will be gone.
> +        */
> +       int err = _ghes_remove(ghes_dev);
> +
> +       WARN_ON(err);
> +
> +       return 0;
> +}

No, no, no, we don't cut corners like this.

It is not very hard to observe that the only case in which
ghes_remove() can return an error is when it calls
apei_sdei_unregister_ghes().

So if you look at that one, you'll notice that it only propagates the
return value of sdei_unregister_ghes() (apart from the trivial "no
support" case).

Now, sdei_unregister_ghes() really does things that shouldn't fail
(because how can firmware refuse to disable an event on unregister
it), so that's where the warning should be emitted (in case they fail
nevertheless).

Also I don't think that dumping the stack is worth it, because the
code path is known.


> +
>  static struct platform_driver ghes_platform_driver = {
>         .driver         = {
>                 .name   = "GHES",
> --
