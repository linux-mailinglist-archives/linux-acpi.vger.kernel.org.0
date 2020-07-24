Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFC22C2A3
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgGXJ5u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 05:57:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38760 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXJ5t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 05:57:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id r8so7569102oij.5;
        Fri, 24 Jul 2020 02:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfdi8y7XT/GLwjnF+qwRBjmFZVJUF6UVVDZU9wm5TaQ=;
        b=Ez+sMokykO4w4KpZehFNr7BA5uhHCSc4xXzgwp5QiYK+vnky5ScwO5vFCaqqqiaYSf
         ObCXes2JOIvaMkcOnz96S3/aL+SMR29FNyVhT7bkwPklTXLczgsepDnfS+TsJpv5cLUP
         MH9X7F/TQIQTnZoRhyJ1/uTFczOp2BIarRVFRftbtRpTsqNRVx7wm6irfs5vC2Bu4dNS
         1lnVRr7VALhlvO08+oULoaBKjyEMTteLb6xPW9Ks8doOURX6yI+JjhEg3oBtENL6yguq
         eCKZxdGqWqs+LmgPJ9UpxRocBzE1dFm6fYRUOZ6Xx4TkjjDr3CxEgcXVTUNfO6bKFoT9
         hL6A==
X-Gm-Message-State: AOAM5327SSChE3uN6u+HJEVr8bY3b8flL10O2gVJpff++tBBr0fYSriE
        WAtwbsSaydo9ui7hq5XOzwVbuA4Yuq0TlPbcj8pwEA==
X-Google-Smtp-Source: ABdhPJwmw50/j/jb4uqGVrXM5kRvrFzs5LGQOnnkqUtcmCKjUVWpuSyy9Ti+bMSPaa4DokJrmiScLfe79eQwwUT3sQc=
X-Received: by 2002:a05:6808:34e:: with SMTP id j14mr7576095oie.110.1595584668419;
 Fri, 24 Jul 2020 02:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
 <1594005196-16327-2-git-send-email-neal.liu@mediatek.com> <CAJZ5v0ihB5AJwSRpjaOnXAmciregzxARL5xfudu1h+=_LXaE_w@mail.gmail.com>
 <1594350535.4670.13.camel@mtkswgap22> <1595233294.8055.0.camel@mtkswgap22> <20200723190724.GA1339461@google.com>
In-Reply-To: <20200723190724.GA1339461@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Jul 2020 11:57:37 +0200
Message-ID: <CAJZ5v0g_14D-tyWFEZ9eOJC=GmzR-31iAAPff=Ch8KjFyK2wfw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: change enter_s2idle() prototype
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Neal Liu <neal.liu@mediatek.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 23, 2020 at 9:07 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Mon, Jul 20, 2020 at 04:21:34PM +0800, Neal Liu wrote:
> > Gentle ping on this patch.
> >
> >
> > On Fri, 2020-07-10 at 11:08 +0800, Neal Liu wrote:
> > > On Thu, 2020-07-09 at 14:18 +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Jul 6, 2020 at 5:13 AM Neal Liu <neal.liu@mediatek.com> wrote:
> > > > >
> > > > > Control Flow Integrity(CFI) is a security mechanism that disallows
> > > > > changes to the original control flow graph of a compiled binary,
> > > > > making it significantly harder to perform such attacks.
> > > > >
> > > > > init_state_node() assign same function callback to different
> > > > > function pointer declarations.
> > > > >
> > > > > static int init_state_node(struct cpuidle_state *idle_state,
> > > > >                            const struct of_device_id *matches,
> > > > >                            struct device_node *state_node) { ...
> > > > >         idle_state->enter = match_id->data; ...
> > > > >         idle_state->enter_s2idle = match_id->data; }
> > > > >
> > > > > Function declarations:
> > > > >
> > > > > struct cpuidle_state { ...
> > > > >         int (*enter) (struct cpuidle_device *dev,
> > > > >                       struct cpuidle_driver *drv,
> > > > >                       int index);
> > > > >
> > > > >         void (*enter_s2idle) (struct cpuidle_device *dev,
> > > > >                               struct cpuidle_driver *drv,
> > > > >                               int index); };
> > > > >
> > > > > In this case, either enter() or enter_s2idle() would cause CFI check
> > > > > failed since they use same callee.
> > > >
> > > > Can you please explain this in a bit more detail?
> > > >
> > > > As it stands, I don't understand the problem statement enough to apply
> > > > the patch.
> > > >
> > >
> > > Okay, Let's me try to explain more details.
> > > Control Flow Integrity(CFI) is a security mechanism that disallows
> > > changes to the original control flow graph of a compiled binary, making
> > > it significantly harder to perform such attacks.
> > >
> > > There are multiple control flow instructions that could be manipulated
> > > by the attacker and subvert control flow. The target instructions that
> > > use data to determine the actual destination.
> > > - indirect jump
> > > - indirect call
> > > - return
> > >
> > > In this case, function prototype between caller and callee are mismatch.
> > > Caller: (type A)funcA
> > > Callee: (type A)funcB
> > > Callee: (type C)funcC
> > >
> > > funcA calls funcB -> no problem
> > > funcA calls funcC -> CFI check failed
> > >
> > > That's why we try to align function prototype.
> > > Please feel free to feedback if you have any questions.
>
> I think you should include a better explanation in the commit message.
> Perhaps something like this?
>
>   init_state_node assigns the same callback function to both enter and
>   enter_s2idle despite mismatching function types, which trips indirect
>   call checking with Control-Flow Integrity (CFI).
>
> > > > > Align function prototype of enter() since it needs return value for
> > > > > some use cases. The return value of enter_s2idle() is no
> > > > > need currently.
> > > >
> > > > So last time I requested you to document why ->enter_s2idle needs to
> > > > return an int in the code, which has not been done.  Please do that.
>
> Rafael, are you happy with the commit message documenting the reason,
> or would you prefer to also add a comment before enter_s2idle?

As I said before, it would be good to have a comment in the code as
well or people will be wondering why it is necessary to return
anything from that callback, because its return value is never used.

Thanks!
