Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2B422FF84
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 04:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgG1CWW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 22:22:22 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:56242 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726269AbgG1CWW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Jul 2020 22:22:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4FAB2181D330D;
        Tue, 28 Jul 2020 02:22:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1801:1963:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3874:4184:4321:4605:5007:9121:10004:10400:10848:11232:11233:11658:11914:12043:12048:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14180:14581:14659:14721:21060:21080:21451:21627:30054:30060:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: anger93_0e0cfdb26f66
X-Filterd-Recvd-Size: 2213
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 02:22:19 +0000 (UTC)
Message-ID: <ae54364041b99b89f818812d957d4a4bb4efdc25.camel@perches.com>
Subject: Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jul 2020 19:22:18 -0700
In-Reply-To: <b851b2c8-2d7c-939d-507d-b322dd4a0dbf@embeddedor.com>
References: <20200707200716.GA4920@embeddedor>
         <CAJZ5v0iDz_EsrpdMQQDfaVC2orMQkEcubmR6-J6mvtrXmKXbRg@mail.gmail.com>
         <BYAPR11MB325602EDA2D2ACC2B28EAF4687670@BYAPR11MB3256.namprd11.prod.outlook.com>
         <b851b2c8-2d7c-939d-507d-b322dd4a0dbf@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-07-27 at 17:23 -0500, Gustavo A. R. Silva wrote:
> Hi,
> 
> 
> This is a macro pseudo-keyword, which expands to /* fallthrough */
> for compilers that don't support the attribute __fallthrough__. See:

Not really.

It expands to
	do {} while (0)
for compilers that do not support the __fallthrough__ attribute.

The /* fallthrough */ after that is for the human reader
and is stripped before compilation.

> include/linux/compiler_attributes.h:213:
> 213 #if __has_attribute(__fallthrough__)
> 214 # define fallthrough                    __attribute__((__fallthrough__))
> 215 #else
> 216 # define fallthrough                    do {} while (0)  /* fallthrough */
> 217 #endif
> 
> So, any compiler (older or new) will be fine with it.

But old compilers should not emit warnings for these uses.


