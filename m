Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4B53F6FA
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jun 2022 09:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiFGHP1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jun 2022 03:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiFGHPZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jun 2022 03:15:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5DADEC8
        for <linux-acpi@vger.kernel.org>; Tue,  7 Jun 2022 00:15:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j10so26845681lfe.12
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jun 2022 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtcjALjI2RZjsiofJNrRsd8EXD975AiTacZTv5laD3A=;
        b=f19PMMaVtX+BpJFFtU0Q2VO6fMGbOuJgz1c/nFXb3jADKHD6RE8bc/7KA/pI+rkX00
         ybDIVaW11W0wAoniwtNsqCLG/50GCtvMU8/n4twyfDCbZ8cjJRj4a7qRSeyqA1vLLLrZ
         7GTNTZmnzfob0R++KIEhuymJltw9rPlWjAm7GHHK8n+bICqn7KRgKh1VAvOdmrIH25rL
         226hoidniZOStstv09tB6xTZVHpwYC795Ig5R1HrELOOmPC6MFGVJ0m0tnle7VE2/4oG
         ejvQQGfLuvOGSSUrsZPjtQ6CM3cdp7Gfd6V8Cg29vyhLqnFbV6fEUQ7p+YYNkjXCc0Xw
         eEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtcjALjI2RZjsiofJNrRsd8EXD975AiTacZTv5laD3A=;
        b=Ie6T0fX9BcBfMU7OAKQ6vX0Kg9ZGPWYAm+XmJAhLJepsBlNz6Uoy5uJf4ksyV3i98f
         /pxMjPru14q6POWEedXnaBd8dV8W5yDS1S6bsypzvADFyBk4rcB8qDgtbxIZWw1ksA7p
         3eG0YxOB4thZwA8QaNM1iwtoAuBk5B13dmpIee0EWcXda+AKq0GNRchpwTohagC4+5PO
         PoAhiXGgtBafK/H9XNik++r7UYfB3k89vTf84KxHijMca90Qk7RG/KlvcmS/cO+vh+1b
         eMtTWICjl8BD5gqh0ZKMBu2dzPiBhhtcGflnAROTxBEHcytwufHpt0T0dJpWDXiHFtNs
         /ryQ==
X-Gm-Message-State: AOAM531s4YxBCkEY/7Hsgt9Ey8G8h5RZOn2oYCAdpC20asythdXv7Mrx
        WsXRMl/cWSEJhS2/OpfGj/Pb7VvFBaqLR3PW39bozg==
X-Google-Smtp-Source: ABdhPJz4O8/a80YWrP8iHg32QGtqg64ZDJWv3CN+Yh1UTo6DQ30IJZeQhx92HsCuaD0TO7q46mPTTeT7H0VNqwLKbBg=
X-Received: by 2002:a05:6512:1085:b0:479:478b:d2cc with SMTP id
 j5-20020a056512108500b00479478bd2ccmr5934514lfg.540.1654586122236; Tue, 07
 Jun 2022 00:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb7f1c05da29b601@google.com> <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com> <Ypor265BTdnmgwpM@rowland.harvard.edu>
 <YpouRmanvCQeKA3S@kroah.com> <Ypow1LRZ3Hau36ci@rowland.harvard.edu>
 <Ypoyy/stICFdHauR@kroah.com> <CACT4Y+bBWrLRwiowaWk8o4+XAtCHxxJiEQfiSkgM3BDut9atAw@mail.gmail.com>
 <20220606123839.GW2146@kadam>
In-Reply-To: <20220606123839.GW2146@kadam>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Jun 2022 09:15:09 +0200
Message-ID: <CACT4Y+Y_kg1J00iBL=sMr5AP7U4RXuBizusvQG52few2NcJ6dg@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in __device_attach
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 6 Jun 2022 at 14:39, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sat, Jun 04, 2022 at 10:32:46AM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > On Fri, 3 Jun 2022 at 18:12, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > But again, is this a "real and able to be triggered from userspace"
> > > problem, or just fault-injection-induced?
> >
> > Then this is something to fix in the fault injection subsystem.
> > Testing systems shouldn't be reporting false positives.
> > What allocations cannot fail in real life? Is it <=page_size?
> >
>
> Apparently in 2014, anything less than *EIGHT?!!* pages succeeded!
>
> https://lwn.net/Articles/627419/
>
> I have been on the look out since that article and never seen anyone
> mention it changing.  I think we should ignore that and say that
> anything over PAGE_SIZE can fail.  Possibly we could go smaller than
> PAGE_SIZE...

+linux-mm for GFP expertise re what allocations cannot possibly fail
and should be excluded from fault injection.

Interesting, thanks for the link.

PAGE_SIZE looks like a good start. Once we have the predicate in
place, we can refine it later when/if we have more inputs.

But I wonder about GFP flags. They definitely have some impact on allocations.
If GFP_ACCOUNT is set, all allocations can fail, right?
If GFP_DMA/DMA32 is set, allocations can fail, right? What about other zones?
If GFP_NORETRY is set, allocations can fail?
What about GFP_NOMEMALLOC and GFP_ATOMIC?
What about GFP_IO/GFP_FS/GFP_DIRECT_RECLAIM/GFP_KSWAPD_RECLAIM? At
least some of these need to be set for allocations to not fail? Which
ones?
Any other flags are required to be set/unset for allocations to not fail?

FTR here is quick link to flags list:
https://elixir.bootlin.com/linux/v5.19-rc1/source/include/linux/gfp.h#L32
