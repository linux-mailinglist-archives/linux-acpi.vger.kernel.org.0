Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF8551636
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jun 2022 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbiFTKrW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 06:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiFTKrV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 06:47:21 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B814C140CF
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 03:47:20 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l66so16789816ybl.10
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQxVUR3KkNZp6NTcyfHqfpPd7JX5R2m1n9r/wmEzqtI=;
        b=hBbbWsA3cKehJ6AlguUiyrnNE8N0lfdakHS80IQMySuvTup7ViH07CehUJqA/DwiEz
         6uW1AlMDULlGhhh77NMqHGi4Jwb9ng22udpUKg3KtYCJwefKkhhdpZzp1oxmXC5uEuZ3
         XVG7MEOD+un4e99ef15EwsoXi3GZ9K+PwZtUPqg43egPVKCrsVb7wYSqLYcBM2NYChHJ
         nDHGNeIAWotNxU8LGXcidSbOA2NwdR0S1NXUY2RvhrX9YlP2KE1oY+OUTzTssSO42ra5
         txfLKS0CQPO1tXbwI/s0NqMqzItrfL5AU3gRA8Vop/2at9DKrd4jQx7tZmbFAofU1Yht
         b5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQxVUR3KkNZp6NTcyfHqfpPd7JX5R2m1n9r/wmEzqtI=;
        b=1ofGlmPS+pgMXNjV21Xoj8kpYESJUlqPVVGtdxwQTreUfR+Bc4GSAVQwIQ3JDIqa50
         9L51Yp/uRyvL+xZW86/nG+cxUmhvFLdFg/g/LKJwDonqA+mRBWq8XvUo9WeDVkKBYC0r
         ljQaQrtA/7zsqhH0QMV5A6y7fT6oPLUk6PFyW1UJoM+4/qoSM/h8xzk/Gj0vdUCXQg/V
         1hQxge6HB4Kq1wRKY/sIIqoqXIlrfuQnl6XBW4bG6YSAjlILFRLeQsUgLBmwrMI0GXRl
         J7biKD2yeosnZMAGCcvFeJh/FdI8hO5JOlW6/7WQK8Df7RTemK7HOCHjolLPgtQz1Qer
         LD8A==
X-Gm-Message-State: AJIora83TLXRbgas1S0OayoDODSPvbriOIN4jKoWstu5FP3BWRyFThvi
        6GZ1mOzPyokK0No5dEGWLVwFgc2QRjJpK22ThWDFNw==
X-Google-Smtp-Source: AGRyM1u3ezJMIpGMnHKvlILdP2kRoxrigbHF4Hi3LpQuaGgKvdO8Q/Newea9x/DE2SLhR4JI0/OMGCFjXdmlkn6hsik=
X-Received: by 2002:a25:ca46:0:b0:668:ae1d:6592 with SMTP id
 a67-20020a25ca46000000b00668ae1d6592mr19438922ybg.101.1655722039989; Mon, 20
 Jun 2022 03:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220620092546.8298-1-hdegoede@redhat.com> <20220620092546.8298-3-hdegoede@redhat.com>
In-Reply-To: <20220620092546.8298-3-hdegoede@redhat.com>
From:   Daniel Drake <drake@endlessos.org>
Date:   Mon, 20 Jun 2022 18:47:09 +0800
Message-ID: <CAD8Lp45ismm5yG2ajGH_h=BKLh6hs8yC7gy3jq1Kn1pst0AFKg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Lv Zheng <lv.zheng@intel.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Carlo Caione <carlo@caione.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

Thanks for looking at this.

On Mon, Jun 20, 2022 at 5:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
> Which leaves commit 6306f0431914 ("ACPI: EC: Make more Asus laptops
> use ECDT _GPE"), which was committed way after the generic fix.
> But this was just due to slow upstreaming of it. This commit stems
> from Endless from 15 Aug 2017 (committed upstream 20 May 2021):
> https://github.com/endlessm/linux/pull/288
>
> The current code should work fine without this:

Your explanation of the code flow seems clear and logical, but I have
not checked the details. This is a bit of a tricky issue as you have
probably seen from history, we went in a couple of wrong directions
before we spotted the real cause.

The one thing I don't see clearly in your explanation (which I may
have read too quickly) is how the generic fix 69b957c26b32 is
responsible for making this a "no-op" code flow now.

We don't have access to any of the affected hardware any more, unfortunately.

For certainty I wonder if you could recreate this on another system.
Something like:
1. Create DSDT override which has the wrong _GPE value
2. Run the original 2017 kernel with that override and observe that
Linux uses that wrong value
3. Apply the generic fix and check that it uses the right one from the ECDT now

Daniel
