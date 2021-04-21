Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE47836711C
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbhDURQL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 13:16:11 -0400
Received: from foss.arm.com ([217.140.110.172]:38418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244700AbhDURPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:15:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DF8013A1;
        Wed, 21 Apr 2021 10:15:20 -0700 (PDT)
Received: from bogus (unknown [10.57.52.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2E503F694;
        Wed, 21 Apr 2021 10:15:18 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:15:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] ACPI: irq: Prevent unregistering of GIC SGIs
Message-ID: <20210421171516.hg3ex7jqigqjqa6i@bogus>
References: <20210421164317.1718831-1-maz@kernel.org>
 <20210421164317.1718831-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421164317.1718831-3-maz@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 21, 2021 at 05:43:17PM +0100, Marc Zyngier wrote:
> When using ACPI on arm64, which implies the GIC IRQ model, no
> table should ever provide a GSI number in the range [0:15],
> as these are reserved for IPIs.
>
> However, drivers tend to call acpi_unregister_gsi() with any
> random GSI number provided by half baked tables, which results
> in an exploding kernel when its IPIs have been unconfigured.
>
> In order to catch this, check for the silly case early, warn
> that something is going wrong and avoid the above disaster.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Just curious if this is just precaution or do we have a platform doing
something stupid like this ?

--
Regards,
Sudeep
