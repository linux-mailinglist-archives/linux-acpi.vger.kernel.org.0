Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BDD4A738
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfFRQmM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 12:42:12 -0400
Received: from foss.arm.com ([217.140.110.172]:49678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbfFRQmM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 12:42:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A37F344;
        Tue, 18 Jun 2019 09:42:11 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3280C3F246;
        Tue, 18 Jun 2019 09:42:10 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:42:08 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 0/4] arm64: SPE ACPI enablement
Message-ID: <20190618164208.GB4270@fuggles.cambridge.arm.com>
References: <20190615010910.33921-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615010910.33921-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 14, 2019 at 08:09:06PM -0500, Jeremy Linton wrote:
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
> We also add the ability to parse the PPTT for IDENTICAL
> cores. We then use this to sanity check the single SPE
> device we create. This creates a bit of a problem with
> respect to the specification though. The specification
> says that its legal for multiple tree's to exist in the
> PPTT. We handle this fine, but what happens in the
> case of multiple tree's is that the lack of a common
> node with IDENTICAL set forces us to assume that there
> are multiple non-IDENTICAL cores in the machine.
> 
> v3->v4: Rebase to 5.2.
> 	Minor formatting, patch rearrangement.
> 	Add missing `inline` in static header definition.
> 	Drop ARM_SPE_ACPI and just use ARM_SPE_PMU.

I'm happy to take this via the arm64 perf tree for 5.3, but I'll need
Acks from Raphael on the first two patches and an Ack from Lorenzo on
patch 3.

Cheers,

Will
