Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D699CC21
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHZJFE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 05:05:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41121 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfHZJFE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Aug 2019 05:05:04 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 3ebf26800505d6b8; Mon, 26 Aug 2019 11:05:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] acpi/hmat: Skip publishing target info for nodes with no online memory
Date:   Mon, 26 Aug 2019 11:05:02 +0200
Message-ID: <1922204.kTHyOg1r71@kreacher>
In-Reply-To: <CAJZ5v0hCkibcbiYdPmBXdnDHZbGP2q0uNRi01oU0NMz5o3WwGA@mail.gmail.com>
References: <20190805142706.22520-1-keith.busch@intel.com> <20190805142706.22520-4-keith.busch@intel.com> <CAJZ5v0hCkibcbiYdPmBXdnDHZbGP2q0uNRi01oU0NMz5o3WwGA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, August 12, 2019 10:59:58 AM CEST Rafael J. Wysocki wrote:
> On Mon, Aug 5, 2019 at 4:30 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > From: Dan Williams <dan.j.williams@intel.com>
> >
> > There are multiple scenarios where the HMAT may contain information
> > about proximity domains that are not currently online. Rather than fail
> > to report any HMAT data just elide those offline domains.
> >
> > If and when those domains are later onlined they can be added to the
> > HMEM reporting at that point.
> >
> > This was found while testing EFI_MEMORY_SP support which reserves
> > "specific purpose" memory from the general allocation pool. If that
> > reservation results in an empty numa-node then the node is not marked
> > online leading a spurious:
> >
> >     "acpi/hmat: Ignoring HMAT: Invalid table"
> >
> > ...result for HMAT parsing.
> >
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Keith Busch <keith.busch@intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> When you send somebody else's patches, you should sign them off as a
> rule, but since you sent this one with your own R-by, I converted that
> to a S-o-b.
> 

And all patches in the series have been applied.

Thanks!




