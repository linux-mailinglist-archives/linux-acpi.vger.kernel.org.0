Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615475FECCD
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Oct 2022 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJNK7s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Oct 2022 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJNK7r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Oct 2022 06:59:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 393A31740C;
        Fri, 14 Oct 2022 03:59:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEB1A13D5;
        Fri, 14 Oct 2022 03:59:50 -0700 (PDT)
Received: from bogus (unknown [10.57.35.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807B63F792;
        Fri, 14 Oct 2022 03:59:41 -0700 (PDT)
Date:   Fri, 14 Oct 2022 11:59:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     rafael@kernel.org, lenb@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Message-ID: <20221014105938.fyy6jns5fsu5xd7q@bogus>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929002834.32664-1-bwicaksono@nvidia.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Besar,

On Wed, Sep 28, 2022 at 07:28:34PM -0500, Besar Wicaksono wrote:
> ARM Performance Monitoring Unit Table describes the properties of PMU
> support in ARM-based system. The APMT table contains a list of nodes,
> each represents a PMU in the system that conforms to ARM CoreSight PMU
> architecture. The properties of each node include information required
> to access the PMU (e.g. MMIO base address, interrupt number) and also
> identification. For more detailed information, please refer to the
> specification below:
>  * APMT: https://developer.arm.com/documentation/den0117/latest
>  * ARM Coresight PMU:
>         https://developer.arm.com/documentation/ihi0091/latest
> 
> The initial support adds the detection of APMT table and generic
> infrastructure to create platform devices for ARM CoreSight PMUs.
> Similar to IORT the root pointer of APMT is preserved during runtime
> and each PMU platform device is given a pointer to the corresponding
> APMT node.
> 

This looks good to me know.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Lorenzo,

Not sure if there are any other arm specific ACPI changes in the queue
for v6.2. Can you please add this too ?

-- 
Regards,
Sudeep
