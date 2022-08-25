Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626585A17C1
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 19:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiHYRN5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiHYRN5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 13:13:57 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9E2BBA42
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:13:55 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id n125so21524784vsc.5
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3esi+ryUnskgrLf/IQjvl/6RpEjamoWLTnhJpCTsxu0=;
        b=pD6mnTSJTnTurnRbfAI0zS3b9Ra/TPxnAX+16yFGw1VEcybz4woeBsEb89Tp3aWcRq
         1kAv2kSpQpKToWuyGMngUULeZCOzBZvcyoWTS8tvtrGbKg12cMXXdjyoRiszoZ9viZiZ
         dMAGHXMxMCeqR3dzUmtMD9qML7Vih+InX/C0WrwnfkMoeJUejPIv3siw6vrlE3eeYjlG
         hQgI2zPlJC9GaYzHRa08fKCfStGoYrVyUKT/DTfMlK7nOn3v6P2XNb60nk6gSraaCQkT
         FB7yqnAY1Eb3GbKcaipOlAnE0iWSNezFeLM96bT+kHN5dcC8VqyR1tJD5u+t+AJb5Ob9
         EEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3esi+ryUnskgrLf/IQjvl/6RpEjamoWLTnhJpCTsxu0=;
        b=ojNDWXYaZedKNJ+UNQRkC4r3MJHwdYd6Rf+e/2tOBf+rkprJ0694tx7ry6gUejikwb
         NVJdvjKVsozvNmMRl+Eh+Y4G+DDX1APSRwSsgCmts2T0JhCXW4JkNySprkFkLTJgrZA9
         Nh88YEE0YxAdFggS1eqPskBQDFjty7JDGSP68Po6Ks5hzPQ56r5fF8obb8kvVbW4exTh
         0pay1OOiTLzJTN7SFhA3VH8NvaHT4qJ5U832QkOlBfNRTVLqLRd62BzPD7kTRPiF0Guo
         2DzUV8VifbQZieK1fkUDuUuMB5QW6z6/keXMVU8iHPcJ34abH7S3LOUnditgmWExhVs7
         gulw==
X-Gm-Message-State: ACgBeo3WbYgStVSgh97uHOIp6wAzZxQ1XmBr7Tu0vJxXUEV4eOGDcILj
        f04ZyQP4LOnzJsjIEzp9jnTvQyhwSgYQtbtWteU=
X-Google-Smtp-Source: AA6agR42YeUHq5svEPNIlYk4iw3F9YbuGOed/bOzI461DSdBDXaeKPsz79u2/kwVODWCHEse1HkclhiJw1e/HJ8qJZE=
X-Received: by 2002:a67:c09c:0:b0:390:9073:1122 with SMTP id
 x28-20020a67c09c000000b0039090731122mr1949527vsi.85.1661447634917; Thu, 25
 Aug 2022 10:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
 <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
 <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com>
 <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com> <69897481-88bc-2c7a-8862-65fbc40fc0b6@redhat.com>
In-Reply-To: <69897481-88bc-2c7a-8862-65fbc40fc0b6@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 20:13:18 +0300
Message-ID: <CAHp75Ve4PhSLihi13oSOx88czMuxpWx18bm7SToEHLJ0SD5fVQ@mail.gmail.com>
Subject: Re: ACPI ID list termination
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Thu, Aug 25, 2022 at 8:09 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 8/25/22 19:03, Rafael J. Wysocki wrote:
> > On Thu, Aug 25, 2022 at 6:48 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
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

Ah, that's the part I missed, thanks, Hans! It was good move to Cc you.

-- 
With Best Regards,
Andy Shevchenko
