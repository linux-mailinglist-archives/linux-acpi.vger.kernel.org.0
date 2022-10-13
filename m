Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2537C5FDE8F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Oct 2022 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJMQxt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Oct 2022 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJMQxp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Oct 2022 12:53:45 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F867069
        for <linux-acpi@vger.kernel.org>; Thu, 13 Oct 2022 09:53:34 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id l28so1867885qtv.4
        for <linux-acpi@vger.kernel.org>; Thu, 13 Oct 2022 09:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyhXL+BOmWOJePpW+D6b4OfxbrisjBOUEM77v08bvT0=;
        b=S4lXGcoOyo7CwLpg2Fuv2WIxKg1V+KeLWgd9/iXtVoE87/9A+W5dNdMr483n1WHrmg
         GBdKz1rexT6mKATT51/LYeP69F9oHQBaTJWevMXu81fK/VmG5IsRU0pSK24hSqi5jSbe
         jh5Oi3Bv8XzUxZ7rWRoK4Eos5BmVFPY3FzU6M7DrVgkaJz6QAvGC+C8VztLq0ZcCFlWG
         HHm1HYGVzKZhIttBkaNxUBBdM8yjySMsOl7UC/UGfsVie+rYdD+fbLs+d94h/CCduZ1v
         fQ7r0Dkw9YqTZzCoQZGKGkjWjwwPQbfXm22w6nTHwwu4GQOTnl/V++XULB2NGWM9V4Bd
         EqHA==
X-Gm-Message-State: ACrzQf2tiRp9RSVXPxckGpiPmTUVJaLOnVRvTQFw+xIb8vjKJ0WASv8u
        ugQXofE0NhLkf7RX8NXgmKSpR8pdv6dtd9OW1kY=
X-Google-Smtp-Source: AMsMyM7O29ZrJjJC5X7gvQ9/PB7BgegBeT2UzG7DPr2XfkkSeozAPhCACk0wd/C0VtZ3LnWxYN2NQN6AMr+oQco9C1Y=
X-Received: by 2002:a05:620a:2988:b0:6ce:cc3f:73b9 with SMTP id
 r8-20020a05620a298800b006cecc3f73b9mr647277qkp.9.1665680001557; Thu, 13 Oct
 2022 09:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144214.345279-1-hdegoede@redhat.com>
In-Reply-To: <20221003144214.345279-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 18:53:10 +0200
Message-ID: <CAJZ5v0gaCYVTSk2wCBVEj9xXCMjtt=Ce8t88Me1kb_MCAuYfBw@mail.gmail.com>
Subject: Re: [RFC v3 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
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

Hi Hans,

On Mon, Oct 3, 2022 at 4:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is v3 of my series fixing some ECDT EC probe ordering issues which
> are causing issues om some laptops:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>
> This is a RFC because fixing this requires some ACPICA changes which
> obviously need to go upstream through the ACPICA project:
> https://github.com/acpica/acpica/pull/786

I've just approved your pull request.

Also, as soon as it gets merged, you can resubmit the series with a
proper ACPICA  commit ID and I will be able to apply the patches right
away then.

> The problem this fixed is best described by the commit message of patch 4:
>
> ACPI-2.0 says that the EC OpRegion handler must be available immediately
> (like the standard default OpRegion handlers):
>
> Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
> 2. OSPM must make Embedded Controller operation regions, accessed via
> the Embedded Controllers described in ECDT, available before executing
> any control method. These operation regions may become inaccessible
> after OSPM runs _REG(EmbeddedControl, 0)."
>
> So acpi_bus_init() calls acpi_ec_ecdt_probe(), which calls
> acpi_install_address_space_handler() to install the EC's OpRegion
> handler, early on.
>
> This not only installs the OpRegion handler, but also calls the EC's
> _REG method. The _REG method call is a problem because it may rely on
> initialization done by the _INI methods of one of the PCI / _SB root devs,
> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .
>
> Generally speaking _REG methods are executed when the ACPI-device they
> are part of has a driver bound to it. Where as _INI methods must be
> executed at table load time (according to the spec). The problem here
> is that the early acpi_install_address_space_handler() call causes
> the _REG handler to run too early.
>
> To allow fixing this the ACPICA code now allows to split the OpRegion
> handler installation and the executing of _REG into 2 separate steps.
>
> This commit uses this ACPICA functionality to fix the EC probe ordering
> by delaying the executing of _REG for ECDT described ECs till the matching
> EC device in the DSDT gets parsed and acpi_ec_add() for it gets called.
> This moves the calling of _REG for the EC on devices with an ECDT to
> the same point in time where it is called on devices without an ECDT table.
>
> Changes in v3:
> - Add a prep patch to fix an indentation issue in Linux' acpixf.h to fix
>   the patch from ACPICA's script not applying
> - Add 2 new functions to ACPICA for this instead of a flags argument
>   1. acpi_install_address_space_handler_no_reg()
>   2. acpi_execute_reg_methods()
> - Add a patch to fix EC handler removal in the ECDT case
>
> From my pov this series is ready for merging once the ACPICA changes
> are accepted.

I agree, please resubmit as soon as the upstream ACPICA pull request
gets merged.

Thanks!
