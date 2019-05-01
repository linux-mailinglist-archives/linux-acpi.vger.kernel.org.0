Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358B5108DB
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 16:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEAOPL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 10:15:11 -0400
Received: from foss.arm.com ([217.140.101.70]:59996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEAOPL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 May 2019 10:15:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F273BA78;
        Wed,  1 May 2019 07:15:10 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED2A83F719;
        Wed,  1 May 2019 07:15:08 -0700 (PDT)
Date:   Wed, 1 May 2019 15:15:06 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linuxarm@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH v2 0/5] arm64: SPE ACPI enablement
Message-ID: <20190501141506.GC27353@fuggles.cambridge.arm.com>
References: <20190426220309.55654-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426220309.55654-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jeremy,

On Fri, Apr 26, 2019 at 05:03:04PM -0500, Jeremy Linton wrote:
> This patch series enables the Arm Statistical Profiling
> Extension (SPE) on ACPI platforms.
> 
> This is possible because ACPI 6.3 uses a previously
> reserved field in the MADT to store the SPE interrupt
> number, similarly to how the normal PMU is described.
> If a consistent valid interrupt exists across all the
> cores in the system, a platform device is registered.
> That then triggers the SPE module, which runs as normal.
> 
> This version also adds the ability to parse the PPTT for
> IDENTICAL cores. We then use this to sanity check the
> single SPE device we create. This creates a bit of a
> problem with respect to the specification though. The
> specification says that its legal for multiple tree's
> to exist in the PPTT. We handle this fine, but what
> happens in the case of multiple tree's is that the lack
> of a common node with IDENTICAL set forces us to assume
> that there are multiple non IDENTICAL cores in the
> machine.

This looks good to me. Please can you respin, addressing Raphael's
outstanding concerns on the third patch?

Will
