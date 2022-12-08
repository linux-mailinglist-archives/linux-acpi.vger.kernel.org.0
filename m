Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944496474A9
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiLHQvU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 11:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLHQvT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 11:51:19 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8586AAE4ED
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 08:51:17 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id fu10so1523796qtb.0
        for <linux-acpi@vger.kernel.org>; Thu, 08 Dec 2022 08:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMlu51gO6dB5X+2pxZvpr1P7z4RINH2Ww3RNt1YChVE=;
        b=GCNpNGPCVUi7FAJxSw5MvaMNnOQRALALRq46PRo9VFWybp3NWCNeHVjtV9nAOosQ28
         oHc0hRlzS9y6VRqaJKFTDDndUQMyBSP/UGQR/OtI7b7nrmBq3fkMAqGiYOzdtQiysjQn
         PjLpMkd7hhpUygEcmaRsBDvUbPFc+r28nwkDI+LmQ+SFUbgbSHFu/zo2RwC70QajOp59
         +DqGD47QK1LwaMiQ0C0NIGfjGWrUefeOchsAAk50nKHSUKLacgoxdpa8Rf4RQfTokOlI
         D0keRlX48Zf3A4gmgn/KZQMZ9jfabnyFffQcnc1znyOSCJ/XMiY7LvxOhukHcFEJMK1A
         6amQ==
X-Gm-Message-State: ANoB5plp8r/sR6sAoBSemfyPYGluqp61fgYmuDNQQct3uEcXeXsdGhZq
        moL63ViDMupveMFlXmqKm2oJVhL1u7Q2OE4/In8=
X-Google-Smtp-Source: AA0mqf4dbk2x2J02yO3qlfEKhqQ7EcQ5rlbjVSlrWUaVX49zYydMbaG8UVlpIZcvQ610bmZmfkhw8/bGENxYrJgOpUM=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr86740521qtc.48.1670518276647; Thu, 08
 Dec 2022 08:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20221208142335.488382-1-hdegoede@redhat.com>
In-Reply-To: <20221208142335.488382-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 17:51:05 +0100
Message-ID: <CAJZ5v0jA1cv5wuuouMkM1GsV3Chu+RSxBC7qH7YtDTVa4DGSOw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Thu, Dec 8, 2022 at 3:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> As you requested in:
> https://github.com/acpica/acpica/pull/786#issuecomment-1342632326
>
> Here is a non RFC version of my series fixing some ECDT EC probe
> ordering issues which are causing issues om some laptops:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>
> including the ACPICA changes.
>
> This series is rebased on top of linux-pm/bleeding-edge,
> otherwise it is unchanged from the previous [RFC v3] version.
>
> From the original cover-letter of the previous [RFC v3] version:
>
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

I've applied the series and queued it up for 6.2.

However, because I won't be able to do any kernel work before the next
week (most likely), it will not go into linux-next before Monday and I
would like it to spend at least a few days in it. This means that it
will be pushed in the second half of the merge window.

Thanks!
