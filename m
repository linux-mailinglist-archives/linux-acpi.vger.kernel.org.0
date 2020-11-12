Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782AF2B0EFC
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 21:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKLUWZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 15:22:25 -0500
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:50020 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727000AbgKLUWZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 15:22:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7DB5E181D3025;
        Thu, 12 Nov 2020 20:22:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:6117:6119:7576:7875:7974:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13095:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21627:30012:30054:30063:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: yard96_2014c8327309
X-Filterd-Recvd-Size: 3419
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Nov 2020 20:22:21 +0000 (UTC)
Message-ID: <5cf1f03c2cf29ee173a7b3b81a0f2f8785b6aab8.camel@perches.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Nov 2020 12:22:20 -0800
In-Reply-To: <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
         <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
         <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2020-11-12 at 11:30 -0800, Nick Desaulniers wrote:
> On Thu, Nov 12, 2020 at 7:13 AM Moore, Robert <robert.moore@intel.com> wrote:
> > -----Original Message-----
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > On Wed, Nov 11, 2020 at 7:15 AM Moore, Robert <robert.moore@intel.com> wrote:
> > > Yes, but: isn't the "fallthrough" keyword compiler-specific? That is the problem for us.
> > It's not a keyword.
> > 
> > It's a preprocessor macro that expands to
> > __attribute__((__fallthrough__)) for compilers that support it.  For compilers that do not, it expands to nothing.  Both GCC 7+ and Clang support this attribute.  Which other compilers that support -Wimplicit-fallthrough do you care to support?
> > 
> > We need to support MSVC 2017 -- which apparently does not support this.
> 
> In which case, the macro is not expanded to a compiler attribute the
> compiler doesn't support.  Please see also its definition in
> include/linux/compiler_attributes.h.
> 
> From what I can tell, MSVC does not warn on implicit fallthrough, so
> there's no corresponding attribute (or comment) to disable the warning
> in MSVC.
> 
> That doesn't mean this code is not portable to MSVC; a macro that
> expands to nothing should not be a problem.

acpica is a special case as all the code is in a separate
repository and converted via Lindent to resemble linux
standard styles.

Perhaps it'd easier to avoid modifying acpica and add something like:
---
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 59700433a96e..469508a8d671 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -4,6 +4,7 @@
 #
 
 ccflags-y			:= -Os -D_LINUX -DBUILDING_ACPICA
+ccflags-y			+= -Wno-implicit-fallthrough
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 # use acpi.o to put all files here into acpi.o modparam namespace


