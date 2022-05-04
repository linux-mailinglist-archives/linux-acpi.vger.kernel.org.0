Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C4519FF3
	for <lists+linux-acpi@lfdr.de>; Wed,  4 May 2022 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbiEDMx3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbiEDMx1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 08:53:27 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E089835DE6
        for <linux-acpi@vger.kernel.org>; Wed,  4 May 2022 05:49:51 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id v59so2140358ybi.12
        for <linux-acpi@vger.kernel.org>; Wed, 04 May 2022 05:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fI803stuI6gH1/kB/n9w8zzlJvKDRztayylY2D1Auws=;
        b=aCE5v7Go1qX7NRuhuEzfgslE7AhbrY+qE3CsRQhHSDsMpeLRd+LGN8WokrMrNuE3Ov
         jBpMLOSACf49YY7TSSDKvHoynKaHPJJ3GOwBejRraTo1xOzv1OiskIbD6+LK0cBGhkHX
         V9WQHNnnd7/wzlys/H2UOVwoesicBiYVryI50AyxdbIE4Fi5JI3/Kc2SLfdBc723xOr5
         piskKWWTBmHchMM4oyIwVkDxGFt0LcmXpwzZ2DRGBGGsSDO9OcGT+xsEAQxkLmEs3wxb
         eUO2qw9S7YE4fSFJoyr9Np//FKkOCHNODtjPuzNLcaVFMCgK8WeCsSacF4tJES+01Pc3
         sWug==
X-Gm-Message-State: AOAM530wAbL3UxXALGhoBCauq0QbwjJJH+3U8PnsoKqXaG/LApNMT4uh
        jo+E+ZXeqqfMC5QqbxQNFdxgDgpMy03DWkCfpzY=
X-Google-Smtp-Source: ABdhPJxHMAHX+1yp9qAVAYwKNNOsoFwxylzG1k3wzuFGSEnMMGm8aLAYZI04qdAOv3g3yQgJ1v/EvLJpvn+lSLaixd8=
X-Received: by 2002:a25:9102:0:b0:649:ea3d:f932 with SMTP id
 v2-20020a259102000000b00649ea3df932mr4836398ybl.633.1651668591033; Wed, 04
 May 2022 05:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <1e09b023-13d3-4474-f724-cb512d5244fb@infradead.org> <0d399fdd-fbb5-47f8-dd5c-3a646829cb3e@infradead.org>
In-Reply-To: <0d399fdd-fbb5-47f8-dd5c-3a646829cb3e@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 May 2022 14:49:29 +0200
Message-ID: <CAJZ5v0hUQedE71WkfCeFAnRJd-YQXRd-EtfLkjOF9uPoDwpp9w@mail.gmail.com>
Subject: Re: next: BUG: KASAN: slab-out-of-bounds in acpi_power_up_if_adr_present
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Sat, Apr 30, 2022 at 7:41 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 4/28/22 22:43, Randy Dunlap wrote:
> > Hi,
> >
> > I'm hitting $Subject bug on a Dell Inspiron laptop during boot.
> >
> > faddr2line says that it's here:
> >
> >       adev = to_acpi_device(dev);
> >       if (!(adev->flags.power_manageable && adev->pnp.type.bus_address)) // <<<<< HERE
> >               return 0;

This should be addressed by commit 10fa1b2cdc89 ("ACPI: bus: Avoid
non-ACPI device objects in walks over children").
