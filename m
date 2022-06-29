Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4AE560780
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jun 2022 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiF2Rme (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jun 2022 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiF2Rme (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2022 13:42:34 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5992F3BE
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 10:42:33 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id q132so29230461ybg.10
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 10:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUMwPBaoEzZXR1TnAOeXdEHa/2Y772IY4opAxZndNg8=;
        b=lxzbVgQ/kBNql5C1pdpnJOEhmZak094mi+2xvPAoDYW/70GlRdLwUc4PK5LIq20xUZ
         h85cjQML6Oue2NgndzN9BDQGqCpRQeA0hX9e2IlYJiXgGXwmaXb5fAfR/JwMlrTc/sQf
         kV+v+Mt+0u7sMUPsOEZEQcoCUde++6t64+DIRjzpMNknPw8Uq547GG5xSCcMT2P4DIh+
         O5C5fn3P5LpNggVPL2fZRyoqWEYnGlAdFskyZ6Qm/xyGHEcbLOOAHC9AaOI4BHR/hHy8
         wNOoKM/yn4d2awynVHXeYM5CTXQ2Yyq98lntFjMyOfjVIAXoTwj7BmPD0/SZpTdRQVI9
         X2OQ==
X-Gm-Message-State: AJIora/l6u1XF5ZnMAj4G6QSoNgFR2paitc63cZYwFPqrelnKoAGkxgP
        8o2Zr/NkJt1TiLRfqMlYOS/OkgGv3jjnUa9eX4A=
X-Google-Smtp-Source: AGRyM1t8LC1Ep9fcsH+VbM/9n93Ms2dFPn2OJ9K0fw/bmK8kPR+5++pkGbDYz8NsjgUENeImKRO4zsv36WqfLJn8qQo=
X-Received: by 2002:a25:ae26:0:b0:66d:1fdc:263c with SMTP id
 a38-20020a25ae26000000b0066d1fdc263cmr4783018ybj.137.1656524552557; Wed, 29
 Jun 2022 10:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220620092546.8298-1-hdegoede@redhat.com>
In-Reply-To: <20220620092546.8298-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 19:42:21 +0200
Message-ID: <CAJZ5v0i08vYPyDFY3KeK9vxbgfND4HUD7qMjpmK8dHQaURy-tg@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI: EC: Various cleanups
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
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

On Mon, Jun 20, 2022 at 11:26 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is a set of cleanups / removal of no longer necessary
> quirks (or so I believe please review carefully). These are all
> things which I noticed while working on my:
> "[RFC 0/4] ACPI[CA]: fix ECDT EC probe ordering issues" series.
>
> Regards,
>
> Hans
>
> p.s.
> Talking about my "[RFC 0/4] ACPI[CA]: fix ECDT EC probe ordering issues"
> series, it would be great if someone can take a look at this and let me
> know if that series seems sane. Then I can convert the ACPICA changes
> from kernel patches to upstream github acpica patches and submit a
> pull-req for those at github.
>
>
> Hans de Goede (4):
>   ACPI: EC: Remove duplicate ThinkPad X1 Carbon 6th entry from DMI
>     quirks
>   ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
>   ACPI: EC: Re-use boot_ec when possible even when
>     EC_FLAGS_TRUST_DSDT_GPE is set
>   ACPI: EC: Drop unused ident initializers from dmi_system_id tables
>
>  drivers/acpi/ec.c | 140 ++++++++++++++++------------------------------
>  1 file changed, 48 insertions(+), 92 deletions(-)
>
> --

All four patches applied as 5.20 material, thanks!
