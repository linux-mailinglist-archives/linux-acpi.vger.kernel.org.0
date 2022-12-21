Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735D665320F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Dec 2022 14:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLUNxW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 21 Dec 2022 08:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUNxU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2022 08:53:20 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8759220CC
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 05:53:19 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id pj1so6802054qkn.3
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 05:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGJInwS7IyTDTvJ2qeZXiadMhDas+w9jUjouSxw03dQ=;
        b=1ndN/+7hQMfmxbhJa15dN8M8b9IM5oZLwaqOfg2jPSMjBtFDTn6TNyU8T5alvTZu/J
         8FBK/VhuZbE2INo7cjT6NWQ9BjePLvWE/nBwAJt/6ku6M5SXlboB+DNQedhEF+Qyurcb
         rHktyiORsWbcotmvP+TGwBGw7IveEP7cBO+ZWCuqdTNPOXD8WLglhreU1H354BZpr5lK
         NhgjcQMNQoFP9srdLaUf2XTih5BM/RsS1+IB4/lR4kdsKkDn/iQOAnY1zoHx84ah2Gog
         V15cjXeEgxZDEiLaR95khPuUIbhwJN1rn0yQIUxpH+HezIZqnhgdkqENHgnNpqgnyiHP
         3YmA==
X-Gm-Message-State: AFqh2krI+y66r/hgfy3OhZitPYSSEvLF3uAdHeSYJV0B+//XV/hoKdzF
        g7t0OHtw5Pm8e34ePjxF8MYdMvZamrKtYisG8W0=
X-Google-Smtp-Source: AMrXdXt58oXFKmB1zQxSR6Nd1/zayovYrHOvr+H9Sc5MzblWEmClNbKNiS5WhVvpxyScUTQyWE6U8aMS6QqlmDwUMPs=
X-Received: by 2002:a05:620a:50:b0:6fb:c38e:e5dd with SMTP id
 t16-20020a05620a005000b006fbc38ee5ddmr79381qkt.23.1671630799002; Wed, 21 Dec
 2022 05:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20221220154447.12341-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20221220154447.12341-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Dec 2022 14:53:05 +0100
Message-ID: <CAJZ5v0inEMEQ1NJwjNboDokL_35-yG8o6QwVb5po2qKW8LRLWA@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: arm_sdei: Make sdei_unregister_ghes() return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, kernel@pengutronix.de,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
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

On Tue, Dec 20, 2022 at 4:45 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Unregistering a ghes shouldn't fail (because how can firmware refuse to
> disable an event on unregister). And the callers are not really in a
> position to handle errors. (Note: The return value of platform remove
> callbacks is ignored.) So make sdei_unregister_ghes() return void and
> add warnings at the few locations that can theoretically fail.
>
> !IS_ENABLED(CONFIG_ACPI_APEI_GHES) and
> !IS_ENABLED(CONFIG_ARM_SDE_INTERFACE) cannot be hit here, because if
> these aren't given, ghex_probe() already fails and so ghes_remove()
> isn't called.
>
> This change improves the behaviour in the error case. Without it the
> platform code emits a very generic (and so very unhelpful) error
> message. Now the warning is at least helpful.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> Changes since (implicit) v1: Add the if (...) BUG() part to fix a linker
> error with CONFIG_ARM_SDE_INTERFACE disabled.
>
> Best regards
> Uwe
>
>  drivers/acpi/apei/ghes.c    | 19 ++++++++++++-------
>  drivers/firmware/arm_sdei.c | 14 +++++++-------
>  include/linux/arm_sdei.h    |  2 +-
>  3 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 066dc1f5c235..7d705930e21b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1275,12 +1275,20 @@ static int apei_sdei_register_ghes(struct ghes *ghes)
>                                  ghes_sdei_critical_callback);
>  }
>
> -static int apei_sdei_unregister_ghes(struct ghes *ghes)
> +static void apei_sdei_unregister_ghes(struct ghes *ghes)
>  {
> +       /*
> +        * If CONFIG_ARM_SDE_INTERFACE isn't enabled apei_sdei_register_ghes()
> +        * cannot have been called successfully. So ghes_remove() won't be
> +        * called because either ghes_probe() failed or the notify type isn't
> +        * ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED.
> +        * Note the if statement below is necessary to prevent a linker error as
> +        * the compiler has no chance to understand the above correlation.
> +        */
>         if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
> -               return -EOPNOTSUPP;
> +               BUG();

Well, you could just provide an empty stub for the !CONFIG_ARM_SDE_INTERFACE.

It would be cleaner and probably fewer lines of code too.

>
> -       return sdei_unregister_ghes(ghes);
> +       sdei_unregister_ghes(ghes);
>  }
>
>  static int ghes_probe(struct platform_device *ghes_dev)
> @@ -1421,7 +1429,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
>
>  static int ghes_remove(struct platform_device *ghes_dev)
>  {
> -       int rc;
>         struct ghes *ghes;
>         struct acpi_hest_generic *generic;
>
> @@ -1455,9 +1462,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
>                 ghes_nmi_remove(ghes);
>                 break;
>         case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
> -               rc = apei_sdei_unregister_ghes(ghes);
> -               if (rc)
> -                       return rc;
> +               apei_sdei_unregister_ghes(ghes);
>                 break;
>         default:
>                 BUG();
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 1e1a51510e83..7af619464183 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -889,7 +889,7 @@ int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
>         return err;
>  }
>
> -int sdei_unregister_ghes(struct ghes *ghes)
> +void sdei_unregister_ghes(struct ghes *ghes)
>  {
>         int i;
>         int err;
> @@ -897,16 +897,15 @@ int sdei_unregister_ghes(struct ghes *ghes)
>
>         might_sleep();
>
> -       if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
> -               return -EOPNOTSUPP;
> -
>         /*
>          * The event may be running on another CPU. Disable it
>          * to stop new events, then try to unregister a few times.
>          */
>         err = sdei_event_disable(event_num);
> -       if (err)
> -               return err;
> +       if (err) {
> +               dev_warn(ghes->dev, "Failed to disable event %u: %pe\n", event_num, ERR_PTR(err));
> +               return;
> +       }
>
>         for (i = 0; i < 3; i++) {
>                 err = sdei_event_unregister(event_num);
> @@ -916,7 +915,8 @@ int sdei_unregister_ghes(struct ghes *ghes)
>                 schedule();
>         }
>
> -       return err;
> +       if (err)
> +               dev_warn(ghes->dev, "Failed to disable event %u: %pe\n", event_num, ERR_PTR(err));
>  }
>
>  static int sdei_get_conduit(struct platform_device *pdev)
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index 14dc461b0e82..0812af4530a4 100644
> --- a/include/linux/arm_sdei.h
> +++ b/include/linux/arm_sdei.h
> @@ -40,7 +40,7 @@ int sdei_event_disable(u32 event_num);
>  /* GHES register/unregister helpers */
>  int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
>                        sdei_event_callback *critical_cb);
> -int sdei_unregister_ghes(struct ghes *ghes);
> +void sdei_unregister_ghes(struct ghes *ghes);
>
>  #ifdef CONFIG_ARM_SDE_INTERFACE
>  /* For use by arch code when CPU hotplug notifiers are not appropriate. */
> --
> 2.38.1
>
