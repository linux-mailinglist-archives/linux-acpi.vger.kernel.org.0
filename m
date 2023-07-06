Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C458749D94
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGFN13 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 6 Jul 2023 09:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGFN12 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 09:27:28 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0421FE3;
        Thu,  6 Jul 2023 06:27:13 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98273ae42d0so19194566b.0;
        Thu, 06 Jul 2023 06:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649991; x=1691241991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8kZVLJWenEvRNghpq+wxRxvsb4anWr9yVpfvfjD8WM=;
        b=D3jMMNsBais/uHnNSmts8w7yskNzB+z/Q73OUNhWaXUPnXSvFjpRoslEzEAGKMejnt
         dvof25O0rw6FHSW2BlgONaPMzcMu8uTZhgzhX8g1kSnlfhWrNQhmLLVrcZh1Gg4LtY7I
         +upUnpRZb3pji1kidVcJulOi2KKJUhnD3GZjYBycBpQF5PKg29RORuAobIZQC5I0UWBQ
         fP3JHsxwGniLrmNP7GY/BDtQ0WKjWLprZiewzNlaI2Vf9Q0OE9AC4N1Ka9aJ4XbWQ5Li
         727Qne6Frc53ZKSFcmjNIbYD2tfxfUjSylDn9IcVr1lxWKwpvbV3qElnqRGAZ7dlHtY7
         qKtg==
X-Gm-Message-State: ABy/qLaUz63fHrs9sEPmuOEdHsC40zmiMD5ChCuoKv2olGX44qK54nQX
        sM5NAm4f6nQ8cg0JhgFn2+dALTNPitHij50uX5E=
X-Google-Smtp-Source: APBJJlE6MdoXP14XVvCEAPorn69/GhvUi9hycugbXaX6dgky6UOgFAm1ym+0Svmw92ENz5lA1Daf6XiBHg+dkN+d2hg=
X-Received: by 2002:a17:906:728e:b0:976:50a4:ac40 with SMTP id
 b14-20020a170906728e00b0097650a4ac40mr1766377ejl.0.1688649991022; Thu, 06 Jul
 2023 06:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230705213010.390849-1-hdegoede@redhat.com> <20230705213010.390849-16-hdegoede@redhat.com>
 <ZKaHErGZOVXXDn9c@smile.fi.intel.com> <08825217-ff29-1f58-220d-617570836542@redhat.com>
In-Reply-To: <08825217-ff29-1f58-220d-617570836542@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jul 2023 15:26:20 +0200
Message-ID: <CAJZ5v0imzHiNxff3RQJvMzvr_xWHXERoyzYmLyZS7hASO0qN+A@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] ACPI: bus: Introduce acpi_match_acpi_device() function
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 6, 2023 at 2:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 7/6/23 11:19, Andy Shevchenko wrote:
> > On Wed, Jul 05, 2023 at 11:30:07PM +0200, Hans de Goede wrote:
> >> Some ACPI glue code (1) may want to do an acpi_device_id match while
> >> it only has a struct acpi_device available because the first physical
> >> node may not have been instantiated yet.
> >>
> >> Add a new acpi_match_acpi_device() helper for this, which takes
> >> a "struct acpi_device *" as argument rather then the "struct device *"
> >> which acpi_match_device() takes.
> >>
> >> 1) E.g. code which parses ACPI tables to transforms them
> >> into more standard kernel data structures like fwnodes
> >
> > Looks like it's v1 of my original patch, anyway this is now in Linux Next as
> > 2b5ae9604949 ("ACPI: bus: Introduce acpi_match_acpi_device() helper").
>
> Ah interesting, it does indeed look a lot like your version.
> but it was developed independently.
>
> Unfortunately it seems that this is headed for 6.6-rc1 and the atomisp
> changes in this series which rely on this are intended for 6.6-rc1 too.

No, the material Andy is talking about will be pushed for 6.5-rc1
(probably even today), because it is part of a fix for systems that
are broken in the field.

> So we still need to figure out how to merge this.

This shouldn't be a problem.
