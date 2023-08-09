Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2F77561B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjHIJGD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 05:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHIJGD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 05:06:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE391FCE
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 02:06:02 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bfc2b68090so3079368fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Aug 2023 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691571961; x=1692176761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLwyECYT6Xn6msmS0NUyb2lEiZ0edDW9yNz2SldE0mc=;
        b=BJCH8EKq9jxX7cTgHO4TsdzBRQ3EvmByUEt/z+XszLHl8hJQdaHrR7je53WAWig8c5
         FR69YAOC1z9J2gzHpyc0Ltl5aqRL2CTZHWzyf4DzDNJeVLpYnobBKG1Q8vgFLExjPuOY
         NSXfmusCh0bX2Cz9X+1I24kDHvoKbpoOf7UXKhpHmzWgCtPXUu0ypG+esn7/n3XF+YXC
         1NuWj40XFfLBdVQsb1e9BFmZc8FiDfxkPS+0dZWz4DWRKGoMJ4nMbNxmTAD8Fkf4nLJX
         +TOhVaO/PnPDx3Lrofr4zp6cowNBKlS663h3znJ7Nas8g44hSLsmsBGnRIYMTDmUqe62
         UvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571961; x=1692176761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLwyECYT6Xn6msmS0NUyb2lEiZ0edDW9yNz2SldE0mc=;
        b=OAz1iUh34aid9Yl4gLfc031JSWVV0NJ44u6tYAJdL0PVMfH0EGwDYkYbnHPepDRh8j
         6uQSRGY98RLPQgHdyBvumE81nPQmeVGZXn4OPCFC3pl13o/mT1g+f5m6bXKiWS5zSxki
         yeQjRVbcJrv3r/9V2gOYJWcpuCUdNSrbE/WbQTpoyQffMOUEyfSVF7CI1i2O5tTEacQG
         rHHYsE7PzqlCqIlRYktV4B9AwCLVumpDEr7uhPoE6dPsmvxt5SUt5wRDR+0yiud1jQSY
         wRct34TYMHv784gjtZHIfntAA7/TccAWGvg5Esn02DELgq2TJPfrmp5d5EuxFMBRljbF
         8j+Q==
X-Gm-Message-State: AOJu0YxZVb4oNxpxABbu1LE9m6BQNgeK+UGLKzLM9w7/AasRiVOyll4K
        NM8gY+1KJZ5CveHOjAzQFmP7hOp6RhfjOwRjDLA=
X-Google-Smtp-Source: AGHT+IHQzYTaI51nIwXm5MeNFV+xf6Yw4lQVb/h8CESe1IEo8EoCViw6xj+zsV+CXnfG8Z/9E1I/YG517iHk47wjnCI=
X-Received: by 2002:a05:6808:2916:b0:3a7:30ad:df27 with SMTP id
 ev22-20020a056808291600b003a730addf27mr1922201oib.19.1691571961456; Wed, 09
 Aug 2023 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230721154813.310996-1-cezary.rojewski@intel.com>
 <20230721154813.310996-2-cezary.rojewski@intel.com> <ZNMdertpWWvoAJM3@surfacebook>
 <c987d5dc-ae21-8fdc-3037-ad05c44742dc@intel.com>
In-Reply-To: <c987d5dc-ae21-8fdc-3037-ad05c44742dc@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Aug 2023 12:05:25 +0300
Message-ID: <CAHp75VdbXXfWT9NB+EF3Wqdjq2egpPReRAwnG96bEckeA9a0sQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPI: NHLT: Device configuration access interface
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 9, 2023 at 11:48=E2=80=AFAM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2023-08-09 7:00 AM, andy.shevchenko@gmail.com wrote:
> > Fri, Jul 21, 2023 at 05:48:10PM +0200, Cezary Rojewski kirjoitti:
> >> Device configuration structures are plenty so declare a struct for eac=
h
> >> known variant. As neither of them shall be accessed without verifying
> >> the memory block first, introduce macros to make it easy to do so.
> >>
> >> Link: https://github.com/acpica/acpica/pull/881
> >
> > Thinking of this over night (as I replied in the above)...
> >
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Sorry, but seems I have to retract my tag and even more, NAK to the ACP=
ICA changes.
> >
> > I have thought that this is something new to the header there, but it a=
ppears that
> > it duplicates (in a wrong way in my opinion) existing data types.
> >
> > Existing data types are crafted (as far as I get them) in a way to be a=
ble to be
> > combined in the union. In the similar way how _CRS is parsed in DSDT (f=
irst that
> > comes to my mind). Hence that "simplification" is quite wrong in a few =
ways:
> > - it breaks ACPICA agreement on naming schema
> > - it duplicates existing data
> > - it made it even partially
> > - it is fine and correct in ACPICA to have long dereferenced data, agai=
n see
> >    for the union of acpi_object
> >
> > I trully believe now that the above change in ACPICA must be reverted.
> >
> > Again, sorry for this late bad news from my side. I have no clue why
> > it was merged, perhaps lack of review? Or anything subtle I so miserabl=
y
> > missed?
>
> First, you took the review seriously and provided a ton of valid
> feedback. And your reviews and expertise helped me grow as a developer,
> so from my perspective no need to sorry about spotting bad things late.
>
> Now, I admit, a bit surprised given the number of revisions and age of
> the initial patchset. The cover-letter, attached for each revision, made
> the intentions clear.

As you may notice I'm not against code that is done as a part of the
Linux kernel and my surprise is the ACPICA change. My focus for review
was a Linux kernel and it was just by a chance I looked at the PR on
GitHub. There is neither good explanation in the commit message nor
discussion of the change. What I probably miss (and that may help me
to understand better the change) are:
- the examples of the code snippets that are using data types before and af=
ter
- explanation why not all data types were covered (there are more
"strange" names like with _a, _b suffix)
- how this is supposed to be maintained as the ACPICA has users
outside of the kernel and how the change
 makes their life easier (to me it's the opposite).

> Our goal is to help actual users of NHLT i.e.:
> audio teams. While part of ACPICA, NHLT-code is hidden within sound/ so
> no one asks questions. Leaving things at status quo does not improve the
> situation.

What situation? To me it makes it worse. (Again, I'm talking solely
for ACPICA change, the rest I have reviewed and I am fine with the
direction taken.)

> Thus I believe simple "no" is not an option here. To make the
> code better overall, relevant pieces should be made part of drivers/acpi.
>
> Original problems stem from the fact that audio teams were not looped in
> during initial integration of NHLT-code. Turned out that no users
> utilize it in its current form. The problems are subtle, but a
> discussion wouldn't hurt.
>
> To avoid double posting, should we continue the discussion here or in
> the PR on github?

Let's do it there, as it's purely about ACPICA.
The kernel part will be affected depending on the result of the discussion.

--=20
With Best Regards,
Andy Shevchenko
