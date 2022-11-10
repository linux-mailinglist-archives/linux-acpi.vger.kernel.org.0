Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D624624AC7
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Nov 2022 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKJThm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Nov 2022 14:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKJThl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 14:37:41 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA0101FA
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 11:37:41 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id x13so2136553qvn.6
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 11:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtT5hMyx3bjhxmrxdPXz5D4SEGUlUNtubHIQG6ZwWTU=;
        b=G2kMhCe1FLIgwh3rk4XOkcIt7n8i9LIYXjityomWMwmTpaE+NC4cGI7+sWpUU3gpSN
         PPcVNf58VNYcgJJyEJ/4sIFvg1mQn7thmjwQKad5CN+TRsqWgDi2uQN8XsEediCfkOVD
         UdFJioct7U5C2D0v63e+XUA37jnlPKm+U1h2whDANwiJ0pE5wVIgwsRUeYxnV/JOq1WA
         twNjA/uekidOfztxBlE6MFZdJaQnJQUj5JUSQFWnGD8ukuWhJNxhQ2fFBRzrZsDpfF0L
         9Ng+mdNoAYfha1koxOqRV/DnfOVcD5bXdhOfjDrMNjRKWIQOq39FbujLF1Amsov9Bnd4
         kzAA==
X-Gm-Message-State: ACrzQf1REJvFnYeK8omJHadtpLYLYLXGx7E3srK3AgJzs71hksiIM8xW
        d8v92lhYyBw9tS7FAGPHMqraXmUja+jtzHQ/bTgyzLFl
X-Google-Smtp-Source: AMsMyM7ooXJRogzUDjAsTXaKSDOCbuTcPPwjs9T/+o+VV6VL9lON3Vgbz20uzSZ9PTaVXcXlC7R6hOolYFBIvvEcGL4=
X-Received: by 2002:a05:6214:f63:b0:4b8:c0bc:c43e with SMTP id
 iy3-20020a0562140f6300b004b8c0bcc43emr60698902qvb.119.1668109060316; Thu, 10
 Nov 2022 11:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20221110152658.403160-1-yangyingliang@huawei.com>
In-Reply-To: <20221110152658.403160-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 20:37:29 +0100
Message-ID: <CAJZ5v0hQK++nSaKPN-LzhUBHjjPMexz_4hZ6StP4Hk0Ti=GHcQ@mail.gmail.com>
Subject: Re: [PATCH] PNP: fix name memory leak in pnp_alloc_dev()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
        guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 10, 2022 at 4:30 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's

After

> bus_id string array"), the name of device is allocated dynamically,
> it need be freed in the error path.
>
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pnp/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index 4df5aa6a309c..bb3976566822 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -152,6 +152,7 @@ struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *protocol, int id,
>
>         dev_id = pnp_add_id(dev, pnpid);
>         if (!dev_id) {
> +               kfree_const(dev->dev.kobj.name);

Would be better to move the dev_set_name() invocation after this if () unstead.

>                 kfree(dev);
>                 return NULL;
>         }
> --
