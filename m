Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0884D1C50
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347999AbiCHPvX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 10:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348001AbiCHPvW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 10:51:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A244F45C;
        Tue,  8 Mar 2022 07:50:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9FB5B81A49;
        Tue,  8 Mar 2022 15:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CE1C340EB;
        Tue,  8 Mar 2022 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646754623;
        bh=+lkMBgVLm+jH8x95EsB3ayX724E8SPmBBqaxqcA8SzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mYj+WAYy9F5hTcRbygc5tB+udV1UMLnHv8ZniT42jEfFz4p0Tst87WnGH4z1KLIPI
         C1Dyau7dKuvXqpYoxxarxJonTSlZPr26QSQXd4z+9wWVEB3MJuQVxI9CA9Binwn3Mv
         jDNAuYHdAV1GMPKgidDOPSk+Y7EMNeVztuzwxj7zrInerPbl+ml/GfLYkuH2e228Tt
         cloNFFb7GuOsCzuucW2OQLS8MiblbcL/9EIsEz36sdxbwvGlWEI6rYbhrn6cn89VuM
         dhEZE9f0BwLRzkiTCSJSkP810b2w+0sfzXo/IHgOT/NAAQJaHHf3Tmds75dfD5H9s8
         bqJsBhw3E6+iA==
Received: by mail-ed1-f47.google.com with SMTP id o1so24000507edc.3;
        Tue, 08 Mar 2022 07:50:23 -0800 (PST)
X-Gm-Message-State: AOAM530Pdl1lD95nrAYctQsrGnIFh3PZnzJUvCYj53vSjjopO2FkdxSI
        XykSFnfWCXphTzkPfrhzXmoSxBicggFSLjN1Qw==
X-Google-Smtp-Source: ABdhPJy9UZE5EsZvGS0pOWeAVrM+jBKKZ+tr2GX+09bj7WIDu4kWUw7uvBx7JK9Ef4qd27fgNd/9DAg+0iaQQrsOnUY=
X-Received: by 2002:a05:6402:438a:b0:416:1b04:2b58 with SMTP id
 o10-20020a056402438a00b004161b042b58mr16810424edc.280.1646754621771; Tue, 08
 Mar 2022 07:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-2-sakari.ailus@linux.intel.com> <YgaG6sQjKs+ZxNm6@robh.at.kernel.org>
 <YgaMaYeC8q7IZlcW@smile.fi.intel.com>
In-Reply-To: <YgaMaYeC8q7IZlcW@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Mar 2022 09:50:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+k+3FVaF4wpFGbi31f9Dxc41=X1P7iHFBvnat5Tyu4PA@mail.gmail.com>
Message-ID: <CAL_Jsq+k+3FVaF4wpFGbi31f9Dxc41=X1P7iHFBvnat5Tyu4PA@mail.gmail.com>
Subject: Re: [PATCH 1/4] device property: Convert device_{dma_supported,get_dma_attr}
 to fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 11, 2022 at 10:19 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 11, 2022 at 09:55:22AM -0600, Rob Herring wrote:
> > On Sun, Feb 06, 2022 at 11:16:40AM +0200, Sakari Ailus wrote:
> > > Make the device_dma_supported and device_get_dma_attr functions to use the
> > > fwnode ops, and move the implementation to ACPI and OF frameworks.
> > >
> > > Depends-on: ("device property: Don't split fwnode_get_irq*() APIs in the code")
> >
> > Is this some new convention?
>
> % git log --oneline --no-merges --grep Depends-on | wc -l
> 83

With 10k+ commits per cycle that's not really compelling.

> Or I misunderstood your question?

% git grep 'Depends-on' | wc -l
0

What I mean is where's the documentation for using this? Or even a discussion?

Rob
