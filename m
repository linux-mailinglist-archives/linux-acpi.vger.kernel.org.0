Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76C52DC57
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 20:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbiESSFQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 May 2022 14:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbiESSFO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2022 14:05:14 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9C5FF13
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 11:05:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id t26so10380576ybt.3
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 11:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYIvmYZB+GS1QZOVQ4BhbWq3ARcCn7umPb9LpRhAukE=;
        b=3vg8hPfQxsR6cYIVmeVGlC5D2KfQ0ifO6MVgo6wH+t4r9PCbckOjYzvoHUfOYHL2eJ
         HpXKhYQeULIMamuipJBveaZtkfLXZNcss7dJBH91YmlkT+b1yfM1Dvh496hXRXhPZf9g
         k62z/D9kiPJD43D9b3ChmOcycWQ9E+6EKCo3aJU7VOl/003a3XIhhBtDGLbyFXVEHSbf
         fJ4A78DuvziOUoisBpkPXOJDRrqQT2G4TX//84kmQZ4ONs7zigwjGHVPi448NokP+IUG
         lHRazjVlkDxCU7PdFTUb+MS/bNzvLLuNlN7M64S7JT2c4LBGlVC90Qkva1LjlUqLHlLL
         htFA==
X-Gm-Message-State: AOAM532Y95lDlG+mBFzT0hGYkm0XfGjpw1Z1m/D33jjGedu6VosGsFP8
        jrccrNxWaE0StirpVxLhIY2ri2oMmGfQ3roDISs=
X-Google-Smtp-Source: ABdhPJyKXUn7BOQUXbLQQTX0yCchYmV8USKwxuo+/sqNCy+uDwx2EScx2SGe8pu0QkEJsh1lNjKLEKPMwNFYJfFpqlM=
X-Received: by 2002:a05:6902:100a:b0:64f:44ec:13ff with SMTP id
 w10-20020a056902100a00b0064f44ec13ffmr3095906ybt.137.1652983511652; Thu, 19
 May 2022 11:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
 <20220506130025.984026-3-sakari.ailus@linux.intel.com> <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
 <YoUbUQkjKATrgf6n@paasikivi.fi.intel.com> <CAJZ5v0jvzHbD6fxNKYJ75eCc3A008fDTf8kA4nP5FK5EvuTS-w@mail.gmail.com>
 <YoVL/uDnwpfoVQwV@paasikivi.fi.intel.com>
In-Reply-To: <YoVL/uDnwpfoVQwV@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 20:05:00 +0200
Message-ID: <CAJZ5v0i2UfBKdD1uHa8R-cuHiTbX1Fc3+ow=Pz1tcpfDhpWS3w@mail.gmail.com>
Subject: Re: [PATCH 02/11] ACPI: acpica: Constify pathname argument for acpi_get_handle()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
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

On Wed, May 18, 2022 at 9:41 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, May 18, 2022 at 09:07:31PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 18, 2022 at 6:14 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Tue, May 17, 2022 at 06:21:44PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, May 6, 2022 at 2:58 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > acpi_get_handle() uses the pathname argument to find a handle related to
> > > > > that pathname but it does not need to modify it. Make it const, in order
> > > > > to be able to pass const pathname to it.
> > > > >
> > > > > Cc: "Moore, Robert" <robert.moore@intel.com>
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > >
> > > > Which patches in the rest of the series depend on this one?
> > >
> > > "ACPI: property: Parse data node string references in properties", i.e.
> > > patch 8 in this set.
> >
> > So I think I can apply the rest of the series, except for patch 8 and
> > patch 7 (as per the previous discussion) for the upcoming merge
> > window.
> >
> > Would that work?
>
> I suppose it would apply to this one, too?

Patch [2/11] will come to the kernel from upstream ACPICA at one point.

> Postponing these works for me.

So I tried to apply the series without patches [2,7-8/11], but that
didn't work (patch [9/11] did not apply).

Please resubmit without them or let's defer the entire series until we
get patch [2/11] from ACPICA.
