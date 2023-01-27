Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9A67ED8F
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 19:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjA0SdW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Jan 2023 13:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjA0SdV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2023 13:33:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146D5CD2A
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 10:33:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso5526283pjp.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 10:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/9ssvHiiy+plkRR4udjNa8oEgujll5vQQ/ky9lgwkQ=;
        b=MEsqZvqHHxVo24sSLue2qMy5OYfz1En4a7Kl20FmlHTRhTya0HGbT409oGPiBizbUA
         4fK8iCvvn1iCyJ75EwGQggqarxOfVE8LUrYV3RimeD5QS7bmZFN4L3yr67zIexx3qcrj
         G8cY2peQhLqXZKSmpXGScDkKJZ78kn+33Qq/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/9ssvHiiy+plkRR4udjNa8oEgujll5vQQ/ky9lgwkQ=;
        b=oIviHPAoCY42skMO4NcCz3hA0G7++/LDrMka2w28tNaksX+Rnqqza99tPmKJn5VB9x
         2Dre+zRXtyPCzhbonDnlDwhDDOz0yILAQyF4wKhMgS3zvskCEw2ms52UmKx9voKwj4uw
         kTckSLjXp5z9tPaCGPN5WC50B6LT9v3vvgVvbXDjxADit2YDHk4aYQKp23SjEv7PZcnP
         l+ja3Tq1WgyxESFYpBR4J9aSMnxnkFZm0sF+JgpPApuyiR5UQitHh66miYY/avimXCmj
         HpayTWrM3fR4FeHGmns/vAl9qR+7/+FYlDS4/A1ssGaWmpKz26ep+fHxXjrSbbeXGqs7
         xxCA==
X-Gm-Message-State: AO0yUKVbFVPy/rsZGXfchwggzEnIqLolXcW5JJcSBsuCLvTD9XFBDCHh
        asTzFnOscDD85/h1VbT32eTPDA==
X-Google-Smtp-Source: AK7set/QEBqEUwQhnQz9ZU2M2LduC999BE9fVgvnAZDZ/H2QYc/JhCQAP95ReN55+7eQdlQ4aeO2zA==
X-Received: by 2002:a17:902:db0d:b0:196:2ba5:8ace with SMTP id m13-20020a170902db0d00b001962ba58acemr12516215plx.19.1674844399263;
        Fri, 27 Jan 2023 10:33:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b0019311ec72e8sm2810229plg.253.2023.01.27.10.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:33:18 -0800 (PST)
Date:   Fri, 27 Jan 2023 10:33:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH] ACPICA: Replace fake flexible arrays with flexible array
 members
Message-ID: <202301271032.43B50EB7@keescook>
References: <20221118181538.never.225-kees@kernel.org>
 <202301151037.20CC3F0@keescook>
 <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com>
 <202301201116.6ED85A70@keescook>
 <CAJZ5v0hQypNonoqr1V1xqN5bX+pKBF3AR=F-mRynN5yvcS9kyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hQypNonoqr1V1xqN5bX+pKBF3AR=F-mRynN5yvcS9kyA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 27, 2023 at 07:08:39PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 20, 2023 at 8:16 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Jan 20, 2023 at 07:10:52PM +0100, Rafael J. Wysocki wrote:
> > > On Sun, Jan 15, 2023 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Fri, Nov 18, 2022 at 10:15:51AM -0800, Kees Cook wrote:
> > > > > Functionally identical to ACPICA upstream pull request 813:
> > > > > https://github.com/acpica/acpica/pull/813
> > > >
> > > > Any update on this? Upstream is currently unbuildable since October.
> > > >
> > > > > One-element arrays (and multi-element arrays being treated as
> > > > > dynamically sized) are deprecated[1] and are being replaced with
> > > > > flexible array members in support of the ongoing efforts to tighten the
> > > > > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > > > > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > > > >
> > > > > Replace one-element array with flexible-array member in struct
> > > > > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > > > > padding in a union with a flexible-array member in struct
> > > > > acpi_pci_routing_table.
> > > > >
> > > > > This results in no differences in binary output.
> > > >
> > > > In the meantime, can you take this patch for Linux, and we can wait for
> > > > ACPICA to catch up?
> > >
> > > Applied now (as 6.3 material), sorry for the delay.
> >
> > Thanks!
> 
> Unfortunately, this breaks compilation for the ACPI tools in tools/power/acpi/.

What's the make target to test this?

> Apparently, the problem is that DECLARE_FLEX_ARRAY() is not defined
> when the tools are built, because kernel headers are not used then.

This should exist in the stddef.h tools headers, but perhaps it isn't
included already?

> I guess the changes from your upstream PR need to be backported
> literally for this to work, so I'll drop this one for the time being.
> Or please let me know if you have a better idea.

I can send a new version if I can reproduce the build failure you see...

-- 
Kees Cook
