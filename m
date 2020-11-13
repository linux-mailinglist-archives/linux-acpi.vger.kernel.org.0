Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD72B207A
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKMQ34 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 11:29:56 -0500
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:47578 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgKMQ34 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Nov 2020 11:29:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1CE8118224D75;
        Fri, 13 Nov 2020 16:29:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2561:2564:2682:2685:2689:2691:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4559:5007:6117:6742:7576:7903:7904:7974:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12679:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21939:30012:30041:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wren57_400b39e27310
X-Filterd-Recvd-Size: 3413
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Nov 2020 16:29:53 +0000 (UTC)
Message-ID: <61039da395c8a28444e2f3958d29deda4c0d49b3.camel@perches.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Nov 2020 08:29:52 -0800
In-Reply-To: <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
         <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
         <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
         <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com>
         <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2020-11-13 at 09:14 +0100, Miguel Ojeda wrote:
> On Fri, Nov 13, 2020 at 1:09 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > 
> > Thank you for the explicit diagnostics observed.  Something fishy is
> > going on though, https://godbolt.org/z/Gbxbxa is how I expect MSVC to
> > handle include/linux/compiler_attributes.h.
> > 
> > The C preprocessor should make it such that MSVC never sees
> > `__attribute__` or `__fallthrough__`; that it does begs the question.
> > That would seem to imply that `#if __has_attribute(__fallthrough__)`
> > somehow evaluates to true on MSVC, but my godbolt link shows it does
> > not.
> > 
> > Could the upstream ACPICA project be #define'ing something that could
> > be altering this? (Or not #define'ing something?)
> > 
> > Worst case, we could do as Joe Perches suggested and disable
> > -Wfallthrough for drivers/acpi/acpica/.
> 
> I agree, something is fishy. MSVC has several flags for conformance
> and extensions support, including two full C preprocessors in newer
> versions; which means we might be missing something, but I don't see
> how the code in compiler_attributes.h could be confusing MSVC even in
> older non-conforming versions.

I believe this has nothing to do with linux and only
to do with compiling acpica for other environments
like Windows.

From: https://acpica.org/

The ACPI Component Architecture (ACPICA) project provides an
operating system (OS)-independent reference implementation of the
Advanced Configuration and Power Interface Specification (ACPI).

It can be easily adapted to execute under any host OS.


