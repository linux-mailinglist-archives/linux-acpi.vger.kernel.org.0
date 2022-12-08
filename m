Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB7647283
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 16:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLHPJ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 10:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLHPJz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 10:09:55 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A545ECA;
        Thu,  8 Dec 2022 07:09:52 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id a16so1205221qtw.10;
        Thu, 08 Dec 2022 07:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmY3GsGGGjooUv/XuK/Z9sIe1w6qYrlvRRnzvHsAh/4=;
        b=eKlfIAXVDc6EKp2XW9kSHL9wM9EX/op/bkXY66KZVWOL+qmyqA2PrNccFO7mUPuX0R
         bVAsuCPM92Tjom+EoNnRYSEsUowdR8/Aq+gpdpOer9Sj+R7H0dLyal6X99Z319H1ttUs
         hRm1FruZU3SntWDiqW+5hlmgrUhpl5SHDNeUA678OwTGFTjnhkUEwb/S9CPeZAB5oACT
         A0ssEPqWhD1jSttaChHXIEaylqggL0dVmFqeqHJovqkERPVFeDUw7NT+kUjyadrGMcSG
         nPyKePYgEugHFwmVOQvt7jjQ5jgQ3RrIGQ6nLjvf7J3GKRGskTMJam2bR5A6Kq9RoK72
         Otnw==
X-Gm-Message-State: ANoB5pkUSM203QvzFZ0TJK0UyaVVyD75x4V2eumE10Fc6zvR6c9LUUFZ
        jId2xw3n1QSznH+rSfi7cTz1uJwZc2AuGq505u8=
X-Google-Smtp-Source: AA0mqf6lM5gDx/Wlsx5Yj4OR52OKBAzdoUftV494ldEB7elHTNSEKNk6IWm33QmjmtuoIiI7xxpPnbLefkzuKLBOp2Q=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr86621018qtc.48.1670512191537; Thu, 08
 Dec 2022 07:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20221208110202.107326-1-hdegoede@redhat.com> <CAHp75VdADDeXbu6ERc8ng8AdacHK4=uZeqb5jy0Vx_z3_=ZQmQ@mail.gmail.com>
 <011776d4-4829-9c06-b619-cc65d2abc04e@redhat.com>
In-Reply-To: <011776d4-4829-9c06-b619-cc65d2abc04e@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 16:09:40 +0100
Message-ID: <CAJZ5v0ieeEYJhSMTC7gCkuJT3ReVphrPHemt9-6AeRqirr_DCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: x86: Add skip i2c clients quirk for Medion
 Lifetab S10346
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
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

On Thu, Dec 8, 2022 at 3:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/8/22 14:00, Andy Shevchenko wrote:
> > On Thu, Dec 8, 2022 at 1:02 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> The Medion Lifetab S10346 is a x86 tablet which ships with Android x86 as
> >> factory OS. The Android x86 kernel fork ignores I2C devices described in
> >> the DSDT, except for the PMIC and Audio codecs.
> >>
> >> As usual the Medion Lifetab S10346's DSDT contains a bunch of extra I2C
> >> devices which are not actually there, causing various resource conflicts.
> >> Add an ACPI_QUIRK_SKIP_I2C_CLIENTS quirk for the Medion Lifetab S10346 to
> >> the acpi_quirk_skip_dmi_ids table to woraround this.
> >
> > workaround
> >
> >
> > Both look good to me,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Thanks. I have merged 2/2 into my review-hans branch now.

And I've applied the [1/2] as 6.2 material.
