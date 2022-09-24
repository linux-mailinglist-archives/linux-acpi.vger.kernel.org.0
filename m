Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB85A5E8E71
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Sep 2022 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIXQYm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Sep 2022 12:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIXQYk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Sep 2022 12:24:40 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249F13F72
        for <linux-acpi@vger.kernel.org>; Sat, 24 Sep 2022 09:24:39 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id h21so1813521qta.3
        for <linux-acpi@vger.kernel.org>; Sat, 24 Sep 2022 09:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PBaxK+sl6eajDo60BiFf468Ta3uuBdFyMas1vcyNLY4=;
        b=y7X1MIo7k2GfRK38BUvATt3AoUGcdTZqpatSAXjY66RM7LNor6zbzdjfEYwewGAFw+
         poHFkVQME39jgusKqHznhs6CieTzqhcKb+UNXXdW9Md0Gawn0WR+1+Wnns/I1+mbjExy
         RIHJ0qRkM8v5UTGdBr4tAOnh0tMAQwxznn0hAOdB2xjin32Nb0bm8ACxxmmr9Y9G5Dz7
         YgqaJUKJWKcqC300UdDD/cYqBgRbsUM1spRhZmSP5FFk3cRA3/TzbVb0A6+8R8xbNuZ7
         xURqXPe3gsNMKkm6A9ofRePUTZ2LEqk1qbGf7n1fU48ktSawAVlSVQlIe+a9sBclyxvF
         lRdg==
X-Gm-Message-State: ACrzQf0SoF+lLkJ4qFd/KxoMMacYwgMYgNDS3RPBdrT1tYXDwQr11DKP
        Ob9SniuV2NNEvcbPmTkFkncu5lr5ZjYqsDEB+VQ=
X-Google-Smtp-Source: AMsMyM55souET69ZE3E/Pv5J4KVybu8urdrWr1fHHdL/K8bHR3zAS95nj4+OqqYyPARSCm2AEb0iJRQW/Sc7AjaPYOs=
X-Received: by 2002:a05:622a:1a08:b0:35c:d9b5:144b with SMTP id
 f8-20020a05622a1a0800b0035cd9b5144bmr11741621qtb.27.1664036678435; Sat, 24
 Sep 2022 09:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <1663407909-17686-1-git-send-email-guohanjun@huawei.com> <7b421d09-eacb-de83-4218-3c3757b004ff@redhat.com>
In-Reply-To: <7b421d09-eacb-de83-4218-3c3757b004ff@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:24:27 +0200
Message-ID: <CAJZ5v0hPuMP7J=MYAdQsnX1aExYXoSe8+U9MmzLZsBPDdB4=0A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: AC: Remove the leftover struct acpi_ac_bl
To:     Hans de Goede <hdegoede@redhat.com>,
        Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Sat, Sep 17, 2022 at 12:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 9/17/22 11:45, Hanjun Guo wrote:
> > In commit 57a183222271 ("ACPI / x86: Introduce an
> > acpi_quirk_skip_acpi_ac_and_battery() helper"), the usage of struct
> > acpi_ac_bl was removed, but left the definition of the struct in
> > the file, so remove the useless code.
> >
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>
> Good catch, thanks. Patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.1 material, thanks!

> > ---
> >  drivers/acpi/ac.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> > index c29e41b..bb9fe79 100644
> > --- a/drivers/acpi/ac.c
> > +++ b/drivers/acpi/ac.c
> > @@ -36,11 +36,6 @@
> >  static int acpi_ac_remove(struct acpi_device *device);
> >  static void acpi_ac_notify(struct acpi_device *device, u32 event);
> >
> > -struct acpi_ac_bl {
> > -     const char *hid;
> > -     int hrv;
> > -};
> > -
> >  static const struct acpi_device_id ac_device_ids[] = {
> >       {"ACPI0003", 0},
> >       {"", 0},
>
