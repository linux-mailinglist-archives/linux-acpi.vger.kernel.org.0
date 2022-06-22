Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45730554C43
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jun 2022 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357952AbiFVOKY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jun 2022 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357939AbiFVOKX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2022 10:10:23 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172338BFD
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 07:10:18 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-317710edb9dso164394577b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 07:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIqG+aR0A6Wet03mdwIoz78Ax35Y2zEF9BoEJgp3axM=;
        b=ccN0FIuOm6NCs5fMxudrBlGjdBHj7qSf1fbISgYvm6bygnCJ/yis6tEjV28PAyX+aP
         p+KrHdArUIJtVMmypYyXbURDHR8HTyrg6HTaZ34ArIa+vnhe+KrhpIc0t4sAUG+xWylm
         84aOh5ZA552wUSLq9zm5Cncp4/vEmSNpazsMH3dak74duegZ0HAcnUJ/DLqe4JsYmKwI
         NCPVzeu9IJ78a2Tje6KrdUipmPuAz/AOo53hlLjFIpD2qMh3CoqOL+Xu0oRpNn37aU/m
         j7D1fMAQjEOFO2H9lvC+2WHc6fZ4IeJz4KzwjzQ5ieCBlxBoAAVb/2aNBYYfDyAUpbj2
         jU8g==
X-Gm-Message-State: AJIora+5tZz1MsFTvXcA+gUS0bkXNW7k7LGEnft/j+cvYbhj0f660Fjx
        RoDav+/5cMbBcX5cPWV/OpRzZAhev2Gg02dOhGcKOwdn
X-Google-Smtp-Source: AGRyM1vvVPDK1Zpc831zAfOsxRT2OB/S+6XgOlQZb1M1Mncy9ucyvP5OsS7+Vg+Xcv9G+AWqaFIbCEtD+6XHvSLEOqc=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr4443200ywb.326.1655907017987; Wed, 22
 Jun 2022 07:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220616090106.2154906-1-sudeep.holla@arm.com>
 <20220616090106.2154906-2-sudeep.holla@arm.com> <CAJZ5v0j0Ayb3KGpfxuuXH9CHUrt8rupVg5OK=r6hqZQEYm3jFA@mail.gmail.com>
 <20220622140042.bjg72oxjo43l2rwo@bogus>
In-Reply-To: <20220622140042.bjg72oxjo43l2rwo@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 16:10:06 +0200
Message-ID: <CAJZ5v0huYTjyDnPBjSth1BdZcKQ3KhMtH7GC-GaL7gpeg5HTiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPICA: Add support for FFH Opregion special context data
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
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

On Wed, Jun 22, 2022 at 4:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jun 22, 2022 at 02:50:08PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 16, 2022 at 11:01 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > FFH(Fixed Function Hardware) Opregion is approved to be added in ACPIC 6.5 via
> >
> > s/ACPIC/ACPI/
> >
>
> Fixed and pushed in ACPICA PR.
>
> > > code first approach[1]. It requires special context data similar to GPIO and
> > > Generic Serial Bus as it needs to know platform specific offset and length.
> > >
> > > Add support for the special context data needed by FFH Opregion.
> > >
> > > FFH OpRegion enables advanced use of FFH on some architectures. For example,
> > > it could be used to easily proxy AML code to architecture-specific behavior
> > > (to ensure it is OS initiated)
> > >
> > > Actual behavior of FFH is ofcourse architecture specific and depends on
> > > the FFH bindings. The offset and length could have arch specific meaning
> > > or usage.
> > >
> > > [1] https://bugzilla.tianocore.org/show_bug.cgi?id=3598
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > This looks reasonable to me and I see that you've already submitted a
> > pull request to the upstream ACPICA.
>
> I assume you would prefer me to post the other 2 patches once this lands
> in your -next.

That would be ideal, but technically I can apply an ACPICA patch in
advance once the corresponding pull request has been integrated
upstream.

> Worst case I would like to get the generic patch in along
> with ACPICA changes, I can then route the arm64 specific next cycle if it
> gets too late for v5.20

Let's try the normal flow and worry about workarounds if it gets late.
