Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A93693EC
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhDWNoo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 09:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239670AbhDWNoQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 09:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DCC861175;
        Fri, 23 Apr 2021 13:43:37 +0000 (UTC)
Date:   Fri, 23 Apr 2021 14:43:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/2] arm64: ACPI GTDT watchdog fixes
Message-ID: <20210423134334.GO18757@arm.com>
References: <20210421164317.1718831-1-maz@kernel.org>
 <20210422142334.GA24087@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422142334.GA24087@lpieralisi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2021 at 03:23:42PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Apr 21, 2021 at 05:43:15PM +0100, Marc Zyngier wrote:
> > Dann recently reported that his ThunderX machine failed to boot since
> > 64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard
> > interrupts"), with a not so pretty crash while trying to send an IPI.
> > 
> > It turned out to be caused by a mix of broken firmware and a buggy
> > GTDT watchdog driver. Both have forever been buggy, but the above
> > commit revealed that the error handling path of the driver was
> > probably the worse part of it all.
> > 
> > Anyway, this short series has two goals:
> > - handle broken firmware in a less broken way
> > - make sure that the route cause of the problem can be identified
> >   quickly
> > 
> > Thanks,
> > 
> > 	M.
> > 
> > Marc Zyngier (2):
> >   ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
> >   ACPI: irq: Prevent unregistering of GIC SGIs
> > 
> >  drivers/acpi/arm64/gtdt.c | 10 ++++++----
> >  drivers/acpi/irq.c        |  6 +++++-
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> Patch(2) needs an ACK from Rafael - usually these patches go via
> the ARM64 tree but I don't think it is compulsory for this series.
> 
> Thank you !
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks Lorenzo.

Rafael, if there are no objections, I'll take these two patches in the
arm64 tree.

-- 
Catalin
