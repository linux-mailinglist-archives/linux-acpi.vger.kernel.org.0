Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3C5A17AF
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiHYRIi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 13:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHYRIh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 13:08:37 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB06FB14EB
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:08:35 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id k10so16469122vsr.4
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=79Lf7jO2XEzFSz7UpnU4dxbeJARa7GlytPwlsEJ2cjs=;
        b=BGzxeT7VPVY4xkMqp+KLj43v4fpIX+iYE/SLCVZ8bG55AqkEuFa5WrVxhP0iaFqE5k
         LY+62ny/ocTtNyDoKrzOKnHdNitBC8zBBMapqLMHsnMSG7laxuCuEFZOQ1/jTQBtyggf
         q+iWlaq+94ayU5D0n74mItyLRzBO07nfmKq+st8PGEq67vuuoA4uU0MeRiTUcUJR12zN
         WnVrYsWNYthLCAWnDvc7ctqOx2Ni+GPW98ilZ4k+DLeVHKw6IDOalA8KAlKqahivC1Xq
         liEQV6g3vnBpGJ14rjZY3lUQVYQFrbbo4W4dbbPet16kL8Us0HykOM98fKyT+Th97Lu7
         yK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=79Lf7jO2XEzFSz7UpnU4dxbeJARa7GlytPwlsEJ2cjs=;
        b=xu32ez2H/0FaFxwJege1dGwR0YzVgRTFF+Vsw3zAWpJzTe88aZ7TNHOAYfIH1gJtJ1
         Do/bnwvmDaWWOdpSd7NHScI6HHnhob6CY+GZbYH94FpBb0/KUFEKQ9cq9YnITT5cWo1n
         3xRCuN6W/+0ZSugRSSPg36iz5jWG78b/wwkHrtUeKkBZ72D1j8pV6NFU4MMgiewEKKvi
         fsq8r29E64iomdf/6mNlKykgGWNpAHTCO9CGf+Chh0+1LYDVBr05cJuKfpsB/FK2WXgT
         eCUUKuHJrofZaRdahXJx5+01Fn/hzQO+RhflR+muephRBNR1PypbhSWdeSf1xQ9XDErm
         hy+g==
X-Gm-Message-State: ACgBeo0ompkv6iX0GuGAgF1fRsalqdAAe12I9vfyK6A5fyQCSwFQP9d3
        Cd9cqlTRuHwi0gSYvVz+9VkqLSJIWw3CCLqGRW9XaWE8TWP5GQ==
X-Google-Smtp-Source: AA6agR7g+xQrCpyAjrrgZyNDS2EGyYyl3MRKpji7qQ4oPJ+RBXICRRS0qq7MQXz8S9EYDrynHToVir5TBsuPtVHH/JY=
X-Received: by 2002:a67:c09c:0:b0:390:9073:1122 with SMTP id
 x28-20020a67c09c000000b0039090731122mr1943001vsi.85.1661447314752; Thu, 25
 Aug 2022 10:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
 <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
 <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com> <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 20:07:57 +0300
Message-ID: <CAHp75VecV9KKFZJDAQJjomBP3oCCJfjqts6OYRk337uGLrWVoQ@mail.gmail.com>
Subject: Re: ACPI ID list termination
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 25, 2022 at 8:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Aug 25, 2022 at 6:48 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Aug 25, 2022 at 2:38 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > I have stumbled over __acpi_match_device() implementation and noticed
> > > > different types of termination of the struct acpi_device_id (ACPI ID
> > > > list), i.e. '{ }' vs. '{"", 0}'.
> > > >
> > > > As I read the code of the above mentioned function, I see that it
> > > > dereferences the id field without NULL check. This means we are quite
> > > > lucky (somebody before guarantees the match) we have no crash here.
> > >
> > > I'm not sure what you mean.
> > >
> > > In __acpi_match_device() id is a pointer used for walking the acpi_ids
> > > table (if not NULL).  Its initial value is the acpi_ids value and it's
> > > incremented in every step, so it cannot be NULL.
> > >
> > > The loop is terminated if both the first byte of the device ID field
> >
> > ^^^ (1)
> >
> > > and the cls field in the current row are both zeros, so both
> > > termination markers in use should work.
> > >
> > > Or am I missing anything?
> >
> > Yes. The ID field itself is _dereferenced_ w/o NULL check. So, compare
> > two ID lists:
> >
> > FIRST:
> >   { "A", 1 },
> >   { "B", 2 },
> >   { "", 0}
> >
> > SECOND:
> >   { "A", 1 },
> >   { "B", 2 },
> >   { }
> >
> > They are different in the terminator and the above mentioned function
> > simply will crash the kernel if no match is found. Of course I might
> > miss something, but as I said it seems we are simply lucky that
> > somebody else (platform / device core code?) does our job.
>
> OK, I see.  id->id[0] doesn't work if id->id is NULL which it is in
> the second case.
>
> I think it doesn't crash in practice, because it's always called when
> there's a match.
>
> Anyway, something like this would fix it, wouldn't it:

Yep, that's what I had in my mind, but was in doubt about the case in
general. Hence the discussion. Yet, w/o this patch prevents us to call
the mentioned match functions when there is no guarantee that match is
there. That said, you may add my

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

to the below patch when formally sent.

> ---
>  drivers/acpi/bus.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -868,8 +868,8 @@ static bool __acpi_match_device(struct a
>      list_for_each_entry(hwid, &device->pnp.ids, list) {
>          /* First, check the ACPI/PNP IDs provided by the caller. */
>          if (acpi_ids) {
> -            for (id = acpi_ids; id->id[0] || id->cls; id++) {
> -                if (id->id[0] && !strcmp((char *)id->id, hwid->id))
> +            for (id = acpi_ids; (id->id && id->id[0]) || id->cls; id++) {
> +                if (id->id && id->id[0] && !strcmp((char *)id->id, hwid->id))
>                      goto out_acpi_match;
>                  if (id->cls && __acpi_match_device_cls(id, hwid))
>                      goto out_acpi_match;



-- 
With Best Regards,
Andy Shevchenko
