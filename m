Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD73C64706E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 14:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLHNGS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 08:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLHNGS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 08:06:18 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0798E5B4;
        Thu,  8 Dec 2022 05:06:17 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id x28so907565qtv.13;
        Thu, 08 Dec 2022 05:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVoqeakChXRYqM7mqrh4ejUdmNqnhlW5+f0PlrbzJJc=;
        b=mQ4QLvUZad16kal9zxqzJlz5lOPZI9esL6XS0U6h1Ew0XrM5C291QwjGL8SHrCkcH8
         Zh0PFe7gdRpZRlounVhBG25otjCkkLBSrjIuNskuZy8NCYfQ/jwqGdDgGoQNJpufzTqR
         PzCVNDvLrUgdeEkWVSHM2sFsAqg4MsUIHMjKyjWxblDex2LqcrS+ZfvIWDVdrKCspSfE
         5vrGBlsDlY4ABydh45l0z+myu2//y05u7E3r0VVZv53mC3zczdS/awjFx3iEXbL4jFi0
         8jdTQ05xi2sC1t5nhxfBZ79RSufKd2NVypyVOgFQTBKga65P1FmGfxsiKe3buzqDUSgl
         kbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVoqeakChXRYqM7mqrh4ejUdmNqnhlW5+f0PlrbzJJc=;
        b=GgUAEQrLx5jlG6gsXMoEXMHgSI5nVRUzcoT9TjBhbY2KDxisZn/FoHKxAvtjO9r28y
         f54831Kna5cw7ikjuMfpEZ97tWP+wok5H5C94e6uaKnDuWKCkJkGKSpWfxOk3PHeGU4T
         84sTNFCtZ1lL1G6GgPc/puRJgQrJAm55K8UeplyjqN+ZP2Kx0ifYq+YKsI6sm7y+cWRe
         4JsOpcIWCLfZlKqEMI/nEAa5P/c95bl2cp67+/brUBD5RnD/1X3VlkC9H25eBIqfx+T2
         TY5147UVXqOXO2ihoim6jhHXABehYGGKkTEqIfRvlhl8zgthjnKxWioAaneoWKSGAn9H
         8BJw==
X-Gm-Message-State: ANoB5pnHeTJcN9kKc8g1dekfm5bcQKUKfRYpCE0E+837jWMtJaJP5BkW
        JmPjWAgefVc4pvYOMMhd1pfVOxkmbplGkocUd+8=
X-Google-Smtp-Source: AA0mqf5buDdx78njPbBYkDCa/9OLGTe0ch8k2tQ3DamoysRRE2WfpM+K6sO2MKqOHhxCM5YBN01I3HXcN1amQMX5/Xs=
X-Received: by 2002:ac8:7652:0:b0:39c:c436:1ea8 with SMTP id
 i18-20020ac87652000000b0039cc4361ea8mr88106333qtr.384.1670504776446; Thu, 08
 Dec 2022 05:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20221208110202.107326-1-hdegoede@redhat.com> <CAHp75VdADDeXbu6ERc8ng8AdacHK4=uZeqb5jy0Vx_z3_=ZQmQ@mail.gmail.com>
In-Reply-To: <CAHp75VdADDeXbu6ERc8ng8AdacHK4=uZeqb5jy0Vx_z3_=ZQmQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Dec 2022 15:05:40 +0200
Message-ID: <CAHp75VchH_mfvShKrcqQK_5-szrZ5iXf3rdt7=Gr=LU8KGiJrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: x86: Add skip i2c clients quirk for Medion
 Lifetab S10346
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 8, 2022 at 3:00 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Dec 8, 2022 at 1:02 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> Side note. We adding a lot of DMI matching information here and there
> in the drivers and often it gets duplicated in handful of times, Maybe
> at some point we can create a global enum and matching table, let's
> say driver/platform/x86/dmi-platforms.c with
> include/linux/platform_data/x86/platform.h with global enum of the
> platforms?

Or even something close to vendor/device API, so you call like

/* h */
enum x86_microsoft_platforms ...;
int x86_dmi_match();

/* c */
enum x86_microsoft_platforms p;
int ret;

ret = x86_dmi_match("Microsoft" /* which is defined either as number
or string */);
if (ret < 0)
  not found
p = ret;

-- 
With Best Regards,
Andy Shevchenko
