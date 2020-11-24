Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A652C1B6E
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 03:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgKXCaC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 21:30:02 -0500
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:51632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728069AbgKXCaC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Nov 2020 21:30:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BFE0F181D3026;
        Tue, 24 Nov 2020 02:30:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2525:2553:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:9025:10004:10400:10848:10967:11232:11658:11783:11914:12043:12297:12438:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:14777:21080:21366:21451:21627:21790:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: brass76_52018ef2736a
X-Filterd-Recvd-Size: 2652
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Nov 2020 02:29:59 +0000 (UTC)
Message-ID: <2b5803f8d4fd9764c1b6f5b32e7a9716fa64024c.camel@perches.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        fthain@telegraphics.com.au,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 23 Nov 2020 18:29:57 -0800
In-Reply-To: <CAKwvOdkxY4pXN4wbYM_B1cLjr8uX6sQ2iS=m=rRGL_TkJQUFZw@mail.gmail.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <202011201129.B13FDB3C@keescook>
         <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <202011220816.8B6591A@keescook>
         <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
         <20201123174648.6a22575b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <CAKwvOdkxY4pXN4wbYM_B1cLjr8uX6sQ2iS=m=rRGL_TkJQUFZw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-11-23 at 18:05 -0800, Nick Desaulniers wrote:
> (minus all of these lists, except LKML, CBL, and ACPI)
> 
> On Mon, Nov 23, 2020 at 5:46 PM Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Mon, 23 Nov 2020 17:32:51 -0800 Nick Desaulniers wrote:
> > > On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> > > > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > > > > If none of the 140 patches here fix a real bug, and there is no
> > change
> > > > > to machine code then it sounds to me like a W=2 kind of a warning.
> > > > 
> > > > FWIW, this series has found at least one bug so far:
> > > > 
> > https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/
> > 
> > > 
> > > So looks like the bulk of these are:
> > > switch (x) {
> > >   case 0:
> > >     ++x;
> > >   default:
> > >     break;
> > > }
> > > 
> > > I have a patch that fixes those up for clang:
> > > https://reviews.llvm.org/D91895

Pity.  It's a good warning.  gcc not warning is a mistake in my view.


