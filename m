Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F4659B11
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Dec 2022 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiL3Rsi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Dec 2022 12:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiL3Rsg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2022 12:48:36 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A621C13E
        for <linux-acpi@vger.kernel.org>; Fri, 30 Dec 2022 09:48:31 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id z126so442169iof.13
        for <linux-acpi@vger.kernel.org>; Fri, 30 Dec 2022 09:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2geZMe3O8eehvc6ltDWBW/t3ayopOJj2Q01dpO7X6P8=;
        b=MU4oQUrgRCCf1SuzolEfn+4IHHs845py/7nE/MEwggSm1eGnJwNvOFLGDdSb5DQuwq
         YtAj52XHYiizf2b1cNhcQLeubRHUtfLb86VSwZV0PyS+y4Jxc+sEovCvyBB4ZGDS3B56
         WLzyZ9S+xJvGcKojP/zWJIHZkaJc9w9kttFznz+T4sTSzf0v5bVdTrC5Pqhm3IPvk1C7
         so+3ESzRnGIVkoKUp40chhvOARwX6AbPnqyXqK4kUCmKIfjp2YjNY10SH+jtvS5b3uVk
         YEPQVYILMHGeaBjmhYX8nU9qo/THI8aG6DG3lYUZH1yOKrwVG84xJTZEZkll7lvpsajm
         tKKw==
X-Gm-Message-State: AFqh2ko6sKDZAeAAfb93nsQz2EdM1Pvj0Wk+SDObY2RiyLK78/dYA7+c
        9NuGuhI1mXo/hmP8L62CjPu7hLmC1gZXL5cCnhMyjrvq
X-Google-Smtp-Source: AMrXdXulO75QFq26ZgZ0uNc+9x6m+vmsMp+oLdPYSZjn4gqO4+E3nuCPF84oUWUlj2MYPH5aybQD+zh3nzBlwEAco0o=
X-Received: by 2002:a05:6638:8d:b0:38a:3357:8a4 with SMTP id
 v13-20020a056638008d00b0038a335708a4mr2583060jao.53.1672422509703; Fri, 30
 Dec 2022 09:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20221213123454.11404-1-hdegoede@redhat.com> <Y5h4WKg/npjIl10y@smile.fi.intel.com>
In-Reply-To: <Y5h4WKg/npjIl10y@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 18:48:17 +0100
Message-ID: <CAJZ5v0gLKUk6ji6EVt4G8J2FaJQk-s9+mEB2_V1oeEgUEZd32w@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PMIC: Add pmic_i2c_address to BYT Crystal Cove support
To:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 13, 2022 at 2:04 PM Andy Shevchenko <andy@kernel.org> wrote:
>
> On Tue, Dec 13, 2022 at 01:34:54PM +0100, Hans de Goede wrote:
> > Add a pmic_i2c_address entry to intel_pmic_bytcrc.c, so that
> > intel_soc_pmic_exec_mipi_pmic_seq_element() can be used on
> > devices with a Bay Trail Crystal Cove PMIC OpRegion driver.
>
> OK!
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/acpi/pmic/intel_pmic_bytcrc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> > index 9ea79f210965..2b09f8da5400 100644
> > --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
> > +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> > @@ -283,6 +283,7 @@ static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
> >       .power_table_count= ARRAY_SIZE(power_table),
> >       .thermal_table  = thermal_table,
> >       .thermal_table_count = ARRAY_SIZE(thermal_table),
> > +     .pmic_i2c_address = 0x6e,
> >  };
> >
> >  static int intel_crc_pmic_opregion_probe(struct platform_device *pdev)
> > --

Applied as 6.3 material, thanks!
