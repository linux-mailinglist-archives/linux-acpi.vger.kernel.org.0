Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15CE6D249A
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Mar 2023 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCaQFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 31 Mar 2023 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjCaQFC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Mar 2023 12:05:02 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3441F781;
        Fri, 31 Mar 2023 09:04:59 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id er13so50550059edb.9;
        Fri, 31 Mar 2023 09:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680278698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ij7qgvKeOX5junf5aneurxp5ZOEewwiumhnQK1iceEo=;
        b=5//KMeCFyrDUPu8sIznfKUHSuZp/VzNEVTAoJueYVAqIGUWjH3pAqV6nCnpfb/oPpU
         hONmV1E/vo65YO++/gVUAKkCEgWygM45tbEjUVbg5IhgWLDhn+p+PuwHCAua3pHRh1UT
         2xNZOujov3/MC55uYqcT18P2/A+sxfQ+R8DlLO1D6uoRImazIjkSlw4wbHwQ+ta0hqhf
         5XubEdt3j3DAP2ct0gM/woDV/ZXsMNCTRJT6jZMFI5cJtteUN5GBOgt7eHttsM3CPw2L
         dyN1eUDobu/RE4rEOGnb4zysFg+ewQjHceucazmzInwULTFCf8ZH3+InrbjIIOw6Mj3b
         belQ==
X-Gm-Message-State: AAQBX9duam7Jem3ZnQlA5hxlYtotAvR8UyHBVLxlxl2r5fJKroImPOdE
        KybRY/fMyKh08CXd0EjO23Kr3JxM+3LI4bigjFE=
X-Google-Smtp-Source: AKy350aSC5pldvlVRpFrFY9QZV8sJSyJhmPahJDQzAvP0vfNXHdq6NWAB+uIu6O+BWoHplEGpCjS0rnymDAqzPI9xts=
X-Received: by 2002:a50:9f82:0:b0:4fa:3c0b:74b with SMTP id
 c2-20020a509f82000000b004fa3c0b074bmr14002372edf.3.1680278697658; Fri, 31 Mar
 2023 09:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gkOfbWZWzsTKLBD9C8TaAp0qmTv0L0X7E3fBSLyMUEcQ@mail.gmail.com> <a4da1cb6-80a5-a3a9-72e6-62e5ad810509@linaro.org>
In-Reply-To: <a4da1cb6-80a5-a3a9-72e6-62e5ad810509@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 18:04:46 +0200
Message-ID: <CAJZ5v0hWE_gRHj7_zZmu=firwTOnF1X4j59hrV_iy045R8GeeQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Generic trip points for ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 3, 2023 at 10:47 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 03/02/2023 19:46, Rafael J. Wysocki wrote:
> > On Fri, Feb 3, 2023 at 6:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> This series introduces the generic trip points usage in the thermal ACPI
> >> driver. It provides a step by step changes to move the current code the
> >> generic trip points.
> >>
> >> I don't have an ACPI platform, the code is not tested.
> >
> > What's the purpose of sending this now, then?  Should it be an RFC?
> > I'm certainly going to treat it this way.
>
> I did basic testing on a x86 laptop having critical trip points but
> nothing else.
>
> I understand it can be treated as RFC.

So I've gone through this series now and I'm not entirely convinced.

While I agree with the general direction (using a generically-defined
trip point representation instead of a home-grown one is definitely an
improvement IMV and I understand the idea of putting all trip points
into an array which then will allow the overhead in the core to be
reduced), I don't quite like the way the change is carried out in the
series.  In particular, I'd prefer to avoid introducing "temporary"
structures that get removed entirely by subsequent patches in the
series - this makes the intermediate steps sort of pointless and
doesn't really help to understand what's going on (quite on the
contrary even, AFAIAC).  I also don't quite like changes like the
temperature unit conversion in patch 9.

Personally, I would do it differently.  I would start with changing
the ACPI thermal driver to use the generic trip point definition (with
possible extensions) instead of the home-grown one and continue from
there.  I think that this would be more straightforward, but I guess I
just need to try it out myself.

Beyond that, there is a question regarding the desired behavior of the
whole framework in some cases, like when the trip points get modified
by firmware and the kernel gets a notification to re-enumerate them.
This may happen in ACPI-enabled systems in general, so the ACPI
thermal driver needs to be prepared for it, but not just the driver -
the thermal core needs to be prepared for it too.  So the question is
how it all should work in principle.  AFAICS, not only the trip
temperature can change, but the ordering of them can change as well
such that the passive trip point lies between the active ones, for
example.  So when this happens, is the core going to tear down all of
the trip point representation in sysfs and re-create it from scratch,
even if it may be used by user space (that may not be prepared for the
re-enumeration) at that point, or is it sufficient to simply make the
trip point attributes return different values when the corresponding
trip points change?
