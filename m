Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E944822C443
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgGXLUc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 07:20:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46445 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXLUa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 07:20:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id n24so6672087otr.13;
        Fri, 24 Jul 2020 04:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RT1ij6hZQ0Vuyzc9YCYk+cMgOX5H+aqYQ/od4etbieA=;
        b=AE3eJ+XSJx5/MvdVW93BCP99HEDAH62s9XOrnz6Y738HPJ8YjqHKqdcFipcr5WVxQw
         NPN3+3hiNKCVpwp4Zgrj0ckmRwHcl2Oj/7pT0ltP/ak5vrR/Z6C/521xj93Ps0kIndYM
         SRQ55JAQTqvNTadFKRBmzdAhE4xGmg6TfaBxK1Kr87XWHmYCDkbj9Y4DbsNj+L2E26XE
         iHUgcU/zi1amLjH98Xwc33Bx+i8ozTGELxHbdqErHwCDwJK1OGJzh8yDzk7Noyh7L0JE
         IY2fRCijFOYLB3clzrjt5u7Qm4yp1DzG7+2cCPqvC8lLMJpoFOasV9FoX3wqM7CxT0/7
         sbvA==
X-Gm-Message-State: AOAM532jEN5ONIh8bh+glLXaP86BF4Go3Rrgrsf1RGbzZPHxGLxdhlG2
        LlkhKiFeNjCVXHv1FKA2/PhpyD73ruymZGIa/SY=
X-Google-Smtp-Source: ABdhPJzsxm4LQo1zgoIl9St1TbbJDGXLH0trq0vlIozdp420lwDRMIVsSe8E5CQQSywvRasTJhTd6PVeYBmQuhH0tt0=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr8405356oth.262.1595589628310;
 Fri, 24 Jul 2020 04:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
 <1594005196-16327-2-git-send-email-neal.liu@mediatek.com> <CAJZ5v0ihB5AJwSRpjaOnXAmciregzxARL5xfudu1h+=_LXaE_w@mail.gmail.com>
 <1594350535.4670.13.camel@mtkswgap22> <1595233294.8055.0.camel@mtkswgap22>
 <20200723190724.GA1339461@google.com> <CAJZ5v0g_14D-tyWFEZ9eOJC=GmzR-31iAAPff=Ch8KjFyK2wfw@mail.gmail.com>
 <1595586289.14121.5.camel@mtkswgap22>
In-Reply-To: <1595586289.14121.5.camel@mtkswgap22>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Jul 2020 13:20:17 +0200
Message-ID: <CAJZ5v0hnW5NB1T90QNSVuzFSZrrXzxKASWYDTW=mFF6MOan9hQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: change enter_s2idle() prototype
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
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

On Fri, Jul 24, 2020 at 12:24 PM Neal Liu <neal.liu@mediatek.com> wrote:
>
> On Fri, 2020-07-24 at 11:57 +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 23, 2020 at 9:07 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > On Mon, Jul 20, 2020 at 04:21:34PM +0800, Neal Liu wrote:
> > > > Gentle ping on this patch.
> > > >
> > > >
> > > > On Fri, 2020-07-10 at 11:08 +0800, Neal Liu wrote:
> > > > > On Thu, 2020-07-09 at 14:18 +0200, Rafael J. Wysocki wrote:
> > > > > > On Mon, Jul 6, 2020 at 5:13 AM Neal Liu <neal.liu@mediatek.com> wrote:
> > > > > > >
> > > > > > > Control Flow Integrity(CFI) is a security mechanism that disallows
> > > > > > > changes to the original control flow graph of a compiled binary,
> > > > > > > making it significantly harder to perform such attacks.
> > > > > > >
> > > > > > > init_state_node() assign same function callback to different
> > > > > > > function pointer declarations.
> > > > > > >
> > > > > > > static int init_state_node(struct cpuidle_state *idle_state,
> > > > > > >                            const struct of_device_id *matches,
> > > > > > >                            struct device_node *state_node) { ...
> > > > > > >         idle_state->enter = match_id->data; ...
> > > > > > >         idle_state->enter_s2idle = match_id->data; }
> > > > > > >
> > > > > > > Function declarations:
> > > > > > >
> > > > > > > struct cpuidle_state { ...
> > > > > > >         int (*enter) (struct cpuidle_device *dev,
> > > > > > >                       struct cpuidle_driver *drv,
> > > > > > >                       int index);
> > > > > > >
> > > > > > >         void (*enter_s2idle) (struct cpuidle_device *dev,
> > > > > > >                               struct cpuidle_driver *drv,
> > > > > > >                               int index); };
> > > > > > >
> > > > > > > In this case, either enter() or enter_s2idle() would cause CFI check
> > > > > > > failed since they use same callee.
> > > > > >
> > > > > > Can you please explain this in a bit more detail?
> > > > > >
> > > > > > As it stands, I don't understand the problem statement enough to apply
> > > > > > the patch.
> > > > > >
> > > > >
> > > > > Okay, Let's me try to explain more details.
> > > > > Control Flow Integrity(CFI) is a security mechanism that disallows
> > > > > changes to the original control flow graph of a compiled binary, making
> > > > > it significantly harder to perform such attacks.
> > > > >
> > > > > There are multiple control flow instructions that could be manipulated
> > > > > by the attacker and subvert control flow. The target instructions that
> > > > > use data to determine the actual destination.
> > > > > - indirect jump
> > > > > - indirect call
> > > > > - return
> > > > >
> > > > > In this case, function prototype between caller and callee are mismatch.
> > > > > Caller: (type A)funcA
> > > > > Callee: (type A)funcB
> > > > > Callee: (type C)funcC
> > > > >
> > > > > funcA calls funcB -> no problem
> > > > > funcA calls funcC -> CFI check failed
> > > > >
> > > > > That's why we try to align function prototype.
> > > > > Please feel free to feedback if you have any questions.
> > >
> > > I think you should include a better explanation in the commit message.
> > > Perhaps something like this?
> > >
> > >   init_state_node assigns the same callback function to both enter and
> > >   enter_s2idle despite mismatching function types, which trips indirect
> > >   call checking with Control-Flow Integrity (CFI).
> > >
> > > > > > > Align function prototype of enter() since it needs return value for
> > > > > > > some use cases. The return value of enter_s2idle() is no
> > > > > > > need currently.
> > > > > >
> > > > > > So last time I requested you to document why ->enter_s2idle needs to
> > > > > > return an int in the code, which has not been done.  Please do that.
> > >
> > > Rafael, are you happy with the commit message documenting the reason,
> > > or would you prefer to also add a comment before enter_s2idle?
> >
> > As I said before, it would be good to have a comment in the code as
> > well or people will be wondering why it is necessary to return
> > anything from that callback, because its return value is never used.
> >
> > Thanks!
>
> Is it okay to add these comments before enter_s2idle?
>
> /*
>  * Align function type since init_state_node assigns the same callback

init_state_node()

>  * function to both enter and enter_s2idle despite mismatching function

->enter_s2idle

>  * types, which trips indirect call checking with Control-Flow Integrity
>  * (CFI).
>  */
> int (*enter_s2idle)(struct cpuidle_device *dev,
>                     struct cpuidle_driver *drv,
>                     int index);

But IMO it would be sufficient to add something like this to the
existing comment regarding ->enter_s2idle:

"This callback may point to the same function as ->enter if all of the
above requirements are met by it."

That would explain why the signature is the same sufficiently in my view.

Thanks!
