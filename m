Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119D95A17BE
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiHYRM3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiHYRM2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 13:12:28 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C76AA3EA
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:12:27 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-33db4e5ab43so76486677b3.4
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n19QbGSaYSCERQMILiEVtLj82t7BkcHcu0BvmJ/GnXM=;
        b=CHUAcdyHBwsGZZqjYjyTthG28+q2f/d/ZdIOOIs2wJ9yzaNncAmR4Cup5l7E0i8pA8
         /6Yt36DvTOyMt5soD2dfC9ibotA83Xx9QCZxTbYhkm+t5Pre9rmgAaRr//VNrbV1u3Vs
         GnxHXR6wIlk7oflMGOC9K9uIQPefo+1KXDLaFoREbc3M9Womj0NT+209jtcPAyg60Z9F
         Kw8HmsKjiAsKTZ4L1giv1FLXPfZ7MBDWzLFvQSAseMx5rEj5OlgRWUA7yisfin1PcAmb
         BGC/Z96WrMr7f4QsusbKv43kuaG/PKkg1VMrFPQ/t618rO/IvBlIqlVTwU30SLKq4e99
         dJ7A==
X-Gm-Message-State: ACgBeo0bwI+AKbSQwlP5WIJLCw9YwQtdIz5W492WZZvQfidjO7VI99go
        WjW1Y+iROFCiIR/krpzpk1JMcNi8AtkuKkQ2/EI=
X-Google-Smtp-Source: AA6agR6+Gr9mhc1PdO26YTwh3pGKhcTPOdvoQF2XECaB8u/zzFalnRk/cx6LtkDeYpoEO2lDXBQ75QT760ACZ9Cpbeo=
X-Received: by 2002:a25:c204:0:b0:692:72b9:a778 with SMTP id
 s4-20020a25c204000000b0069272b9a778mr4222508ybf.81.1661447546816; Thu, 25 Aug
 2022 10:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
 <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
 <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com>
 <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com> <69897481-88bc-2c7a-8862-65fbc40fc0b6@redhat.com>
In-Reply-To: <69897481-88bc-2c7a-8862-65fbc40fc0b6@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 19:12:15 +0200
Message-ID: <CAJZ5v0ggAgAQqR4uF-So_7ZUDafBnD8GG9ox3C0waO4jpjmygw@mail.gmail.com>
Subject: Re: ACPI ID list termination
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Thu, Aug 25, 2022 at 7:09 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 8/25/22 19:03, Rafael J. Wysocki wrote:
> > On Thu, Aug 25, 2022 at 6:48 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >>
> >> On Thu, Aug 25, 2022 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>> On Thu, Aug 25, 2022 at 2:38 PM Andy Shevchenko
> >>> <andy.shevchenko@gmail.com> wrote:
> >>>>
> >>>> I have stumbled over __acpi_match_device() implementation and noticed
> >>>> different types of termination of the struct acpi_device_id (ACPI ID
> >>>> list), i.e. '{ }' vs. '{"", 0}'.
> >>>>
> >>>> As I read the code of the above mentioned function, I see that it
> >>>> dereferences the id field without NULL check. This means we are quite
> >>>> lucky (somebody before guarantees the match) we have no crash here.
> >>>
> >>> I'm not sure what you mean.
> >>>
> >>> In __acpi_match_device() id is a pointer used for walking the acpi_ids
> >>> table (if not NULL).  Its initial value is the acpi_ids value and it's
> >>> incremented in every step, so it cannot be NULL.
> >>>
> >>> The loop is terminated if both the first byte of the device ID field
> >>
> >> ^^^ (1)
> >>
> >>> and the cls field in the current row are both zeros, so both
> >>> termination markers in use should work.
> >>>
> >>> Or am I missing anything?
> >>
> >> Yes. The ID field itself is _dereferenced_ w/o NULL check. So, compare
> >> two ID lists:
> >>
> >> FIRST:
> >>   { "A", 1 },
> >>   { "B", 2 },
> >>   { "", 0}
> >>
> >> SECOND:
> >>   { "A", 1 },
> >>   { "B", 2 },
> >>   { }
> >>
> >> They are different in the terminator and the above mentioned function
> >> simply will crash the kernel if no match is found. Of course I might
> >> miss something, but as I said it seems we are simply lucky that
> >> somebody else (platform / device core code?) does our job.
>
> No they are not different, the id field is not a "char *" as
> I believe you are thinking. The id field actually is a pre-allocated
> array of length ACPI_ID_LEN:
>
> struct acpi_device_id {
>         __u8 id[ACPI_ID_LEN];
>         kernel_ulong_t driver_data;
>         __u32 cls;
>         __u32 cls_msk;
> };
>
> So in both terminators above id[] will be set to 0 and there is
> no problem other then the style being inconsistent.
>
>
> >
> > OK, I see.  id->id[0] doesn't work if id->id is NULL which it is in
> > the second case.
> >
> > I think it doesn't crash in practice, because it's always called when
> > there's a match.
> >
> > Anyway, something like this would fix it, wouldn't it:
> >
> > ---
> >  drivers/acpi/bus.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/bus.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/bus.c
> > +++ linux-pm/drivers/acpi/bus.c
> > @@ -868,8 +868,8 @@ static bool __acpi_match_device(struct a
> >      list_for_each_entry(hwid, &device->pnp.ids, list) {
> >          /* First, check the ACPI/PNP IDs provided by the caller. */
> >          if (acpi_ids) {
> > -            for (id = acpi_ids; id->id[0] || id->cls; id++) {
> > -                if (id->id[0] && !strcmp((char *)id->id, hwid->id))
> > +            for (id = acpi_ids; (id->id && id->id[0]) || id->cls; id++) {
> > +                if (id->id && id->id[0] && !strcmp((char *)id->id, hwid->id))
> >                      goto out_acpi_match;
> >                  if (id->cls && __acpi_match_device_cls(id, hwid))
> >                      goto out_acpi_match;
> >
>
> This change is not necessary, see above.

You're right and I forgot about it.
