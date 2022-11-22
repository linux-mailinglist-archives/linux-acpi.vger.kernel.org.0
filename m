Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3A6344B7
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Nov 2022 20:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiKVTjA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Nov 2022 14:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKVTi7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Nov 2022 14:38:59 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5B6F361
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2022 11:38:58 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id g10so11026940qkl.6
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2022 11:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbvNYN/FE8hmOq8T16bOr2Q7Wr4I97z6plEGlKgs+mg=;
        b=JUHhOXiSKGttZ1D+dW9a3xPHBUQZcB7oDMYYn2a69LCj1qrz2P31K+gjqme9caADO7
         4Wpk8M/dA/eBimqBuIPCvUCdwI9epMtSgBtHlmsnm0x4TPeL1S42UnzIXvWjOjWMVpYv
         njL2t+6DNOWfUjkfC20Pghpd7mXh3HjSj0royCL6/1UGKGUep+bGW/xEzfi6aOBIcrbq
         J7PLFX9UneKil73baLVTwZ5qkmh5kVsSa4UO/iRR2T3whAgj0VehUKQBSoVkSE8S308q
         7tW4m7oL0hBLXez4fQlSowHidAIBaVpnPngotr3PDy89L4CsZGxPBUnzCVkWctI9KBnA
         c0AA==
X-Gm-Message-State: ANoB5pkVazLVEZ7eazl1d2K0CKeAnbwIToSjvIMslwM7fcGANrFePANF
        v4M1amUt4+L5oQfQF0ldpU4FEf/qFPf9UUgKbwG40Z5p
X-Google-Smtp-Source: AA0mqf5X4nYhpaTGQa/14iskaucxz+wOV6o6XX86kkTi/WpJOw5faKlbT++X8QrVmkoMoOx0x9AF7V83Y532ysNa50A=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr21732767qkb.443.1669145937926; Tue, 22
 Nov 2022 11:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20221111012358.661210-1-yangyingliang@huawei.com> <7cfb5d2e-e802-7210-f18d-e4f861d28f1d@huawei.com>
In-Reply-To: <7cfb5d2e-e802-7210-f18d-e4f861d28f1d@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Nov 2022 20:38:46 +0100
Message-ID: <CAJZ5v0h8FD6vMhR+a5LgamaX4j+Sa2RU4V9W4WQ5tYqSHMRNAg@mail.gmail.com>
Subject: Re: [PATCH v2] PNP: fix name memory leak in pnp_alloc_dev()
To:     Hanjun Guo <guohanjun@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
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

On Tue, Nov 22, 2022 at 2:10 PM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2022/11/11 9:23, Yang Yingliang wrote:
> > After commit 1fa5ae857bb1 ("driver core: get rid of struct device's
> > bus_id string array"), the name of device is allocated dynamically,
> > move dev_set_name() after pnp_add_id() to avoid memory leak.
> >
> > Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> > v1 -> v2:
> >    Move dev_set_name() after pnp_add_id().
> > ---
> >   drivers/pnp/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> > index 4df5aa6a309c..6a60c5d83383 100644
> > --- a/drivers/pnp/core.c
> > +++ b/drivers/pnp/core.c
> > @@ -148,14 +148,14 @@ struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *protocol, int id,
> >       dev->dev.coherent_dma_mask = dev->dma_mask;
> >       dev->dev.release = &pnp_release_device;
> >
> > -     dev_set_name(&dev->dev, "%02x:%02x", dev->protocol->number, dev->number);
> > -
> >       dev_id = pnp_add_id(dev, pnpid);
> >       if (!dev_id) {
> >               kfree(dev);
> >               return NULL;
> >       }
> >
> > +     dev_set_name(&dev->dev, "%02x:%02x", dev->protocol->number, dev->number);
>
> Lots of places in the kernel didn't check the return value of
> dev_set_name(), so it looks good to me,
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Applied as 6.2 material, thanks!
