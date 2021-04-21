Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAEA36710F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbhDURPa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 13:15:30 -0400
Received: from foss.arm.com ([217.140.110.172]:38388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241576AbhDURP0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:15:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3549E11FB;
        Wed, 21 Apr 2021 10:14:53 -0700 (PDT)
Received: from bogus (unknown [10.57.52.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5673F694;
        Wed, 21 Apr 2021 10:14:51 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:14:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vgerlkernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] ACPI: GTDT: Don't corrupt interrupt mappings on
 watchdow probe failure
Message-ID: <20210421171449.pukjblgxfp7hcok6@bogus>
References: <20210421164317.1718831-1-maz@kernel.org>
 <20210421164317.1718831-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421164317.1718831-2-maz@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 21, 2021 at 05:43:16PM +0100, Marc Zyngier wrote:
> When failing the driver probe because of invalid firmware properties,
> the GTDT driver unmaps the interrupt that it mapped earlier.
> 
> However, it never checks whether the mapping of the interrupt actially
> succeeded. Even more, should the firmware report an illegal interrupt
> number that overlaps with the GIC SGI range, this can result in an
> IPI being unmapped, and subsequent fireworks (as reported by Dann
> Frazier).
> 
> Rework the driver to have a slightly saner behaviour and actually
> check whether the interrupt has been mapped before unmapping things.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
