Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A062CB9D9
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbgLBJ4x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 04:56:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388389AbgLBJ4w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Dec 2020 04:56:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4682730E;
        Wed,  2 Dec 2020 01:56:07 -0800 (PST)
Received: from bogus (unknown [10.57.62.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C2A93F66B;
        Wed,  2 Dec 2020 01:56:02 -0800 (PST)
Date:   Wed, 2 Dec 2020 09:55:56 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, xuwei5@huawei.com, prime.zeng@hisilicon.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH v2 1/2] topology: Represent clusters of CPUs within a
 die.
Message-ID: <20201202095556.cke6caza2hpw3cmn@bogus>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-2-song.bao.hua@hisilicon.com>
 <jhj360pv7h9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj360pv7h9.mognet@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 01, 2020 at 04:03:46PM +0000, Valentin Schneider wrote:
> 
> On 01/12/20 02:59, Barry Song wrote:
> > Currently the ID provided is the offset of the Processor
> > Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> > it is not terribly elegant so alternative suggestions welcome.
> >

I had already mentioned that you need to fix the firmware/PPTT on your
platform. If you fill only mandatory fields, then yes this is optional
and we resort to use offset as unique number in the kernel.

>
> Skimming through the spec, this sounds like something the ID structure
> (Type 2) could be used for. However in v1 Jonathan and Sudeep talked about
> UID's / DSDT, any news on that?
>

FYI, type 2 is for SoC identification which is being deprecated(still
need to check if that progressed and made to the official release yet)
in favour of Arm SMCCC v1.2 SOC_ID. Anyways it is irrelevant in this
context. They need to use UIDs and mark the corresponding flag as valid
for OSPM/kernel to use it.

> > Note that arm64 / ACPI does not provide any means of identifying
> > a die level in the topology but that may be unrelate to the cluster
> > level.
> >

May need spec extension if there are no ways to identify the same.

-- 
Regards,
Sudeep
