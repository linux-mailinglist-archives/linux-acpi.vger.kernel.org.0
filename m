Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B25B477B
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Sep 2022 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIJQ1A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Sep 2022 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIJQ07 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Sep 2022 12:26:59 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B14A12E;
        Sat, 10 Sep 2022 09:26:58 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 198so1844766ybc.1;
        Sat, 10 Sep 2022 09:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=p509KDEJinkWMURv5yyZS2D1SkqNsd02Ucpl2VFNiC4=;
        b=zSjVkj1XhyGHGsqkgnonhtFa2tI39mtFuAP/Qc9jxX5qhD8ZLKv/ZeRQ3UQnJ6+6uq
         VorAQ4q4z/TRIA1czONTZJpaXG6o8VKmGQaMCqZFje49ome+lZh9+u2OGIqlCTy/SvWp
         IswFtItm5voI/jaHwJPexE859Gy0xPPwrQwOcjBIYXkUQ7W0YHAOaAm+3KLBjRnYkArl
         Rag9Td3QPMsjJLuc0AOzsLp7BILSCxoysku7KmomH9OcFwF95kqJSiyCiWd/kPdgZFdV
         DEa7Ph97CvrF9bN9P60UIFWDT6aoJMm4seYf+WZjdsn/pN2rHmSGnryO17KAwNTkUVQW
         M9/g==
X-Gm-Message-State: ACgBeo1dPJcyIpA0vERg3Pdy8d36Jo3wSN80ARjGwm4+QuZ+1EkFcurP
        MOuG7wkCjCV7bE4V6u28ozQvkTacwmppqSSXGoU=
X-Google-Smtp-Source: AA6agR5W6uJhLeHgbVX3ZkPO4fyRPV1XuSuTlB1cpH9ij6+oRcO1zRH9KldU0YYTI3cy7MwkroKEpoOruvjfy5ovzQs=
X-Received: by 2002:a25:e64c:0:b0:6a9:89cf:155 with SMTP id
 d73-20020a25e64c000000b006a989cf0155mr14884208ybh.365.1662827217769; Sat, 10
 Sep 2022 09:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220907103007.12954-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20220907103007.12954-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 18:26:46 +0200
Message-ID: <CAJZ5v0gzVtQMCvghY18LjWWfmnqF0Fqa4uPCFQ+tdVso_499BA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Use the helper acpi_dev_get_memory_resources()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 7, 2022 at 12:30 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> It removes the need to check the resource data type
> separately.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Hi Rafael,
>
> Now resending this [1]. It applies on top of -rc4 (not -rc3). The
> other patches from that series you already picked.
>
> thanks,
>
> [1] https://lore.kernel.org/linux-acpi/20220816101629.69054-7-heikki.krogerus@linux.intel.com/

Applied, thanks!

Note that I rebased the other commits from this series on top of -rc4
too, but that will become visible when the rebased ones go into my
linux-next branch.

Thanks!

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index a8e273fe204ab..e1f4df7238bf4 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -569,15 +569,6 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
>         return ret;
>  }
>
> -static int is_memory(struct acpi_resource *res, void *data)
> -{
> -       struct resource_win win = {};
> -       struct resource *r = &win.res;
> -
> -       return !(acpi_dev_resource_memory(res, r) ||
> -                acpi_dev_resource_address_space(res, &win));
> -}
> -
>  /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
>  static const struct acpi_device_id iom_acpi_ids[] = {
>         /* TigerLake */
> @@ -611,7 +602,7 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>                 return -ENODEV;
>
>         INIT_LIST_HEAD(&resource_list);
> -       ret = acpi_dev_get_resources(adev, &resource_list, is_memory, NULL);
> +       ret = acpi_dev_get_memory_resources(adev, &resource_list);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.35.1
>
