Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD94FFD2E
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Apr 2022 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiDMR6c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Apr 2022 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiDMR6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2022 13:58:32 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C253CA64
        for <linux-acpi@vger.kernel.org>; Wed, 13 Apr 2022 10:56:10 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id m132so5170347ybm.4
        for <linux-acpi@vger.kernel.org>; Wed, 13 Apr 2022 10:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/JQuj2+f1Z+HDG1CDLaHwJMb2+aMczZRi4r3aIcTIY=;
        b=lRmXW+pkLfDPF10gt/4zVEOKb034Rvj5Ps/ZavJgK/QkkETmnnQDkSwoJ/eHVR1vBI
         7ap+HEAkgt57yIX0Ki6k0dkBYVlsTg7UUnkC0ICkVDphiL0k+TQKkqYt9EDZdeaz+qqz
         38cm/b/lyJwxvYzxvfxWzxIRclY1ol0hVYy9n4tZK4SOANmEfZj8tSyYqS56oN5wyBmc
         UbvxzDLFpUGWAgtwPzDKwrdWp1aT6t62XNcvHiWHUfjNlZziYGRt6fzjd1bpV0zqeJaR
         ov7RlWGOQX4Cw9suEq8gOYK3Uteoay2y8QmH2WOoW5Gbvi1Vm7YiEMNFL12IocxScqLm
         wd9g==
X-Gm-Message-State: AOAM533CPMky3cI1DXAFT1MFP38qRprOoiQSnIcDYt79grLIrwqkDMJa
        pl93sZLc7xvVAkvlcK5WlUZveRav2O/2AhADBjTX6P80
X-Google-Smtp-Source: ABdhPJwTdk+uxcJ66XRhzZib4vguLyyDdANO3b6e98dAgCORokWdqJDlWxoqNCpu5jTOLV3FPAG9LVqrNNJWldN6F/M=
X-Received: by 2002:a25:ac9b:0:b0:641:3c32:bee7 with SMTP id
 x27-20020a25ac9b000000b006413c32bee7mr31515ybi.633.1649872569951; Wed, 13 Apr
 2022 10:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220406131208.603830-1-sakari.ailus@linux.intel.com> <YlAnXoxVdV1JAuSb@smile.fi.intel.com>
In-Reply-To: <YlAnXoxVdV1JAuSb@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 19:55:59 +0200
Message-ID: <CAJZ5v0g+s=U=XW+QKiMx06sECE9iO7mMu9EjpsJqLnAJUuAB9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Release subnode properties with data nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
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

On Fri, Apr 8, 2022 at 2:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 06, 2022 at 04:12:08PM +0300, Sakari Ailus wrote:
> > struct acpi_device_properties describes one source of properties present
> > on either struct acpi_device or struct acpi_data_node. When properties are
> > parsed, both are populated but when released, only those properties that
> > are associated with the device node are freed.
> >
> > Fix this by also releasing memory of the data node properties.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied as 5.19 material, thanks!

> > Fixes: 5f5e4890d57a ("ACPI / property: Allow multiple property compatible _DSD entries")
> > Cc: stable@vger.kernel.org (for v4.20 and up)
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 3fceb4681ec9f..2da5e7cd28134 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -433,6 +433,16 @@ void acpi_init_properties(struct acpi_device *adev)
> >               acpi_extract_apple_properties(adev);
> >  }
> >
> > +static void acpi_free_device_properties(struct list_head *list)
> > +{
> > +     struct acpi_device_properties *props, *tmp;
> > +
> > +     list_for_each_entry_safe(props, tmp, list, list) {
> > +             list_del(&props->list);
> > +             kfree(props);
> > +     }
> > +}
> > +
> >  static void acpi_destroy_nondev_subnodes(struct list_head *list)
> >  {
> >       struct acpi_data_node *dn, *next;
> > @@ -445,22 +455,18 @@ static void acpi_destroy_nondev_subnodes(struct list_head *list)
> >               wait_for_completion(&dn->kobj_done);
> >               list_del(&dn->sibling);
> >               ACPI_FREE((void *)dn->data.pointer);
> > +             acpi_free_device_properties(&dn->data.properties);
> >               kfree(dn);
> >       }
> >  }
> >
> >  void acpi_free_properties(struct acpi_device *adev)
> >  {
> > -     struct acpi_device_properties *props, *tmp;
> > -
> >       acpi_destroy_nondev_subnodes(&adev->data.subnodes);
> >       ACPI_FREE((void *)adev->data.pointer);
> >       adev->data.of_compatible = NULL;
> >       adev->data.pointer = NULL;
> > -     list_for_each_entry_safe(props, tmp, &adev->data.properties, list) {
> > -             list_del(&props->list);
> > -             kfree(props);
> > -     }
> > +     acpi_free_device_properties(&adev->data.properties);
> >  }
> >
> >  /**
> > --
