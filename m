Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3416B213F4E
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jul 2020 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCSiF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jul 2020 14:38:05 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:33204 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgGCSiF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2020 14:38:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4DED118019D2D;
        Fri,  3 Jul 2020 18:38:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:968:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3690:3865:3868:3871:3872:3874:4250:5007:7901:7903:7974:9389:10004:10400:10848:11658:11914:12048:12297:12760:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:30012:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brake39_4f0b1a926e94
X-Filterd-Recvd-Size: 1193
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 18:38:02 +0000 (UTC)
Message-ID: <62c65ee8328ec544bdb33220e4ef21d1e39d87ac.camel@perches.com>
Subject: ACPICA and lindent vs Lindent removal
From:   Joe Perches <joe@perches.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Zong Li <zong.li@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 03 Jul 2020 11:38:01 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There's a thought that Lindent should be removed from the
linux kernel and replaced by clang-format.

Will Lindent removal impact ACPICA?

Is Linux's ACPICA code base still being modified using lindent?

What and where is lindent?  How does it differ from Lindent?


