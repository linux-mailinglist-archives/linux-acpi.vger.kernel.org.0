Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2654F46C4
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiDEUnu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385599AbiDEPPN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 11:15:13 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD93EF34;
        Tue,  5 Apr 2022 06:31:52 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2eb3db5b172so89808657b3.6;
        Tue, 05 Apr 2022 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8uchKorU3SK+3Nl3Y4nxuHq3uTyBcBu9WjlgN34Je8=;
        b=Vc4fCdlLeKnULx7WeU05PFX041SVGBWUjEsA6GNKZcLoVqWbhN1K7iaoYsGqFKbl49
         UmI01NKNlhDWxAgayyP5g3UJFRTZCSrUlkOG3nMPXoNHW0wu59FDBZEDr0rmebp+IOb3
         wCQ06ai98n46YWMs41qk6JBS8CoIzAOg2XHC/FC8JPhu1QsqYGnBOre8lYzZbdtUJAgi
         6gyohvyqjO8CAaQPi6qFrHKZBbx2TbSxE0ApqjF+3ODZ7cCIpJccTtooH95Cc/Uklbh0
         Kq95wVKRvDTAx6EvFvGHH/yYE+H8FWhc90OchrBtiOtKl1Jbx2QDKIi+JrgVNducTGnS
         hfJg==
X-Gm-Message-State: AOAM530kqsBwUcl5iEArHNFC/NRXP7UHNl+ZpVzz9AsyPVkJmAqJ41+t
        tJrwT2tVsdtxFoD2kFCxUAYirWBbULAFvezj0uc=
X-Google-Smtp-Source: ABdhPJwKbTBR54H9kDI5qJHJEMWNzG2lGwa/5kmlpVhNg7z61lDEeQed+3lON8Ka1lR4OTZjQqfCFdVwe8mIHVUXNm8=
X-Received: by 2002:a81:1257:0:b0:2eb:97cf:a4a2 with SMTP id
 84-20020a811257000000b002eb97cfa4a2mr2676401yws.149.1649165511695; Tue, 05
 Apr 2022 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220331125450.218045-1-sakari.ailus@linux.intel.com> <YkcFSgL+j1IvSsby@kuha.fi.intel.com>
In-Reply-To: <YkcFSgL+j1IvSsby@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 15:31:41 +0200
Message-ID: <CAJZ5v0iA9q+gAoOKSHYSUt-wEL8ogM-hN0_F6dcCKc1ZhwOngg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Shovel firmware specific code to appropriate locations
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
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

On Fri, Apr 1, 2022 at 3:59 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Mar 31, 2022 at 03:54:46PM +0300, Sakari Ailus wrote:
> > Hi folks,
> >
> > This set moves the implementation of recently added device property API
> > functions to OF and ACPI frameworks, where the rest of such functionality
> > resides.
> >
> > Compile tested.
> >
> > The dependencies can be found in Rafael's devprop branch now.
> >
> > since v2:
> >
> > - Add pre-processor check for CONFIG_OF_ADDRESS in of_fwnode_iomap() (3rd
> >   patch).
> >
> > changes since v1:
> >
> > - Drop wrongly placed Depends-on: tag from the first patch.
> >
> > - Drop IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode) check (3rd
> >   patch).
> >
> > Sakari Ailus (4):
> >   device property: Convert device_{dma_supported,get_dma_attr} to fwnode
> >   ACPI: property: Move acpi_fwnode_device_get_match_data() up
> >   device property: Add iomap to fwnode operations
> >   device property: Add irq_get to fwnode operation
> >
> >  drivers/acpi/property.c | 36 +++++++++++++++++++++++++++++++----
> >  drivers/base/property.c | 42 ++++++-----------------------------------
> >  drivers/of/property.c   | 34 +++++++++++++++++++++++++++++++++
> >  include/linux/fwnode.h  |  5 +++++
> >  4 files changed, 77 insertions(+), 40 deletions(-)
>
> These look good to me. FWIW:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

All patches in the series applied as 5.19 material, thanks!
