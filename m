Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373BB6B32AA
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Mar 2023 01:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCJARq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Mar 2023 19:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjCJARp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2023 19:17:45 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A995BF34FB
        for <linux-acpi@vger.kernel.org>; Thu,  9 Mar 2023 16:17:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 16so2110879pge.11
        for <linux-acpi@vger.kernel.org>; Thu, 09 Mar 2023 16:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678407463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y55T+l/IfTjCYszzbPp698Fcr0D4XjtGiCIDgfvFkg0=;
        b=GGGeBw2uMvUsuHTfssHrt4nvsmcKhgr6GdOHAcn/hs/w9MS1XDg5m2UFoEwevuoWk/
         kZdzjwJq4ithAYy23mDIw9hMEqffNHpveWr0U0BCi3LaIpOPvtDRazQA2adwLL3xVEuI
         4xbw3w36l7Tc/gFvZ7ADzoY1elod9gEJeNmunQYw0juQAf3PPK8wuI8FYUOu3aUTXT3d
         XUMq31BTX2Xtji31A0mvwEVauTtkRccAmsGIl2QH9TqsGitvxc+QNIP67pOMQ83qYl+W
         1l/SYEdz+QFPmr+sGDi+bORjjVaFFbdzgQe2/bRauvIBKwqfnFPNMZoRLEfK3+B8jLUm
         yA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678407463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y55T+l/IfTjCYszzbPp698Fcr0D4XjtGiCIDgfvFkg0=;
        b=XDXJgaoazoyEcXtp2aGOjlHybc13WDqBVYTjRhW7ppV7Dhx1nqkQOGP9qLWfkO8cCS
         cAthwf1HU3rGKf9DX0Cd0lKKI+prsLMOC2qZ4CIQh4klrlkk3SuccOMVUT5lkZgSzJa2
         rkjInXh+aQdKB+nIqeW6RYUi0pjJdrXMFK1arN6ZhaRRbJ38Bv3C+fL0TY+5O2/pOVIg
         dIE2Xeh97VsTw0O9R2HxOi2EJBP1C3YKfTG7HsJzv4JWALLFp9rOZPflEgPsoedQCUI2
         1nfQiOtbSt/1rep7+Zqw14aed/6wMG8I0sCUJuH9UG0VvYAqQY9qBZbSBloW3tLjtJeJ
         ayrg==
X-Gm-Message-State: AO0yUKWJgj7q0ieXC6Ce5SJYmm66e8yIR3pYN2rTe8L+So1ZlCKYRuTU
        ISv9Z2xO9oE8c87yHa2zyp9RLoBd3JoqsvVtnM/+UQ==
X-Google-Smtp-Source: AK7set92DDVjOWKfeLKwM45A4T+HyVX6lNUCVfNJW8njYHTduRXJDj6gJmYe1OxHGI6KMdngasI1DOiBRQUQ5WAWPJo=
X-Received: by 2002:a62:1cc6:0:b0:620:1f4c:4b9f with SMTP id
 c189-20020a621cc6000000b006201f4c4b9fmr795319pfc.6.1678407462746; Thu, 09 Mar
 2023 16:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
 <CAGETcx_DTHW4-WMK4qRhvhxiunUB2f79cpXSfQ1x-hifZQ+tgw@mail.gmail.com> <CAMSo37XuNaV4Y3+ExrUjNzPDRD_BNSn1258Ve3We+qtbsO7qEw@mail.gmail.com>
In-Reply-To: <CAMSo37XuNaV4Y3+ExrUjNzPDRD_BNSn1258Ve3We+qtbsO7qEw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 9 Mar 2023 16:17:06 -0800
Message-ID: <CAGETcx8qKCNuD5p=e-f-T93VstptPWHq2gVzmghkQucNyhwocA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 9, 2023 at 10:53=E2=80=AFAM Yongqin Liu <yongqin.liu@linaro.org=
> wrote:
>
> Hi, Saravana
>
> Sorry for the lateness, I was just aware of this today.

No worries.

> I tested with the ACK android-mainline branch + the 12 commits ending
> with fb42378dcc7f
> + the 4 commits of this series + hikey960 AOSP Master userspace.
> The hikey960 Android build could boot to the home screen, no stuck there,

Thanks for testing! Can you confirm what happens if you drop the "12
commits ending with fb42378dcc7f" ? Does it get stuck at boot or have
some limited functionality?

It's surprising that for the same type of DT node, in your case
fw_devlink is able to handle it
correctly, but no so for Martin's case.

-Saravana

>
> Here is the link of the logat in case you want to check some message here=
:
> https://gist.github.com/liuyq/6525af08c547cd2e494af5d1c8b181b5
>
> Thanks,
> Yongqin Liu
> On Fri, 10 Mar 2023 at 02:05, Saravana Kannan <saravanak@google.com> wrot=
e:
> >
> > Greg,
> >
> > Don't pull in this series please. It needs more testing from the folks
> > I cc'ed and it's already breaking things for Martin. This needs more
> > revisions.
> >
> > -Saravana
> >
> > On Wed, Mar 1, 2023 at 1:49=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> > >
> > > Yongqin, Martin, Amelie,
> > >
> > > We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> > > ("mtd: mtdpart: Don't create platform device that'll never probe"),
> > > fw_devlink is smarter and doesn't depend on compatible property. So, =
I
> > > don't think these calls are needed anymore. But I don't have these
> > > devices to test on and be sure and the hardware I use to test changes
> > > doesn't have this issue either.
> > >
> > > Can you please test these changes on the hardware where you hit the
> > > issue to make sure things work as expected?
> > >
> > > Yongqin, If you didn't have the context, this affected hikey960.
> > >
> > > Greg,
> > >
> > > Let's wait for some tests before we land these.
> > >
> > > Thanks,
> > > Saravana
> > >
> > > Cc: Yongqin Liu <yongqin.liu@linaro.org>
> > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
> > >
> > > Saravana Kannan (4):
> > >   usb: typec: stusb160x: Remove use of
> > >     fw_devlink_purge_absent_suppliers()
> > >   usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers()
> > >   usb: typec: tcpm: Remove use of fw_devlink_purge_absent_suppliers()
> > >   driver core: Delete fw_devlink_purge_absent_suppliers()
> > >
> > >  drivers/base/core.c           | 16 ----------------
> > >  drivers/usb/typec/stusb160x.c |  9 ---------
> > >  drivers/usb/typec/tcpm/tcpm.c |  9 ---------
> > >  drivers/usb/typec/tipd/core.c |  9 ---------
> > >  include/linux/fwnode.h        |  1 -
> > >  5 files changed, 44 deletions(-)
> > >
> > > --
> > > 2.39.2.722.g9855ee24e9-goog
> > >
>
>
>
> --
> Best Regards,
> Yongqin Liu
> ---------------------------------------------------------------
> #mailing list
> linaro-android@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-android
