Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB94B2973
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Feb 2022 16:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbiBKPz2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Feb 2022 10:55:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbiBKPz1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Feb 2022 10:55:27 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D01A8;
        Fri, 11 Feb 2022 07:55:26 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id y8so9371850qtn.8;
        Fri, 11 Feb 2022 07:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AH0zRbzoPMr4Bd6tgyQDZWCWGv2pXghKVXWK7zK281s=;
        b=efzbaOheMKMZSeFqgQ3d59v31LX3BLHp8rVpk/XBESAS7vD15E1xJvbi3E2dEYBcB/
         cmskRHa9VB9vFIQqRTW1TBwWZ773d594V0AVVDAk56I4KYsGXgoKxecfXgTD39bWp+OC
         9yAT16qawCC2+iWeLY1UKfu4pBdZy1hWDNDBw4MEp7ZYC5D2bNGV4iWEyXiSsnlIwQWy
         PL1rnhYc7ZqVOalTz/g155p2vsS0G6xFYqDMFWk16gAOeDlo0X9UGs+K70o3dvqeEyc7
         9Rjt3VFeejiCj0SRrFEAS0aE/X4dgTbcumLD2yW4XokfCcHpzgunFceOABCuzM1Qi3p9
         Y4Sg==
X-Gm-Message-State: AOAM531C7fnjgTqC2PBhY8+wn7wjtz4Aa2iSs8kXF9Uu7HOZqpzB+nD4
        YHhiSMw6raAOQO4GVaQ50Q==
X-Google-Smtp-Source: ABdhPJxA/ON1DK15WDvj2byI74bSPhUCDuN9XgCfCDlDD9l0wut8Nd0zOyV9Jy46i+vlICGGqwwmyQ==
X-Received: by 2002:ac8:5993:: with SMTP id e19mr1575392qte.226.1644594925847;
        Fri, 11 Feb 2022 07:55:25 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id v22sm12749925qta.60.2022.02.11.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 07:55:25 -0800 (PST)
Received: (nullmailer pid 422968 invoked by uid 1000);
        Fri, 11 Feb 2022 15:55:22 -0000
Date:   Fri, 11 Feb 2022 09:55:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/4] device property: Convert
 device_{dma_supported,get_dma_attr} to fwnode
Message-ID: <YgaG6sQjKs+ZxNm6@robh.at.kernel.org>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206091643.276833-2-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 06, 2022 at 11:16:40AM +0200, Sakari Ailus wrote:
> Make the device_dma_supported and device_get_dma_attr functions to use the
> fwnode ops, and move the implementation to ACPI and OF frameworks.
> 
> Depends-on: ("device property: Don't split fwnode_get_irq*() APIs in the code")

Is this some new convention? What's wrong with 'base-commit' and 
shouldn't it be below the '---'?

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 14 ++++++++++++++
>  drivers/base/property.c | 25 ++++---------------------
>  drivers/of/property.c   | 17 +++++++++++++++++
>  include/linux/fwnode.h  |  3 +++
>  4 files changed, 38 insertions(+), 21 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
