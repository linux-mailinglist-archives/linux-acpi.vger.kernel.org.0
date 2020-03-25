Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7D1926E0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCYLKq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 07:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgCYLKq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Mar 2020 07:10:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8A320714;
        Wed, 25 Mar 2020 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585134645;
        bh=+oORi421RJ9kNbff15hBXNngbNzPdLiPd7dkY8ZfVx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyTvEz1HkRScEIks3fLO6NxSaEHP3bTnF7g8lw6/Sw86AIEcst4Vj/SPWtZuK/NmF
         k0ZGmVK6WItq5DMMpc4X2IZd9Mq49bJLWf0Xffqqi6SYMw1UYEfFYhdKwRRgO6bl8X
         /zcT5VGeyoe/A3wFwuVze9CnAzNQ3nI/5MVCmnjU=
Date:   Wed, 25 Mar 2020 11:10:40 +0000
From:   Will Deacon <will@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jeff Moyer <jmoyer@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 6/6] ACPI: HMAT: Attach a device for each
 soft-reserved range
Message-ID: <20200325111039.GA32109@willie-the-truck>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 22, 2020 at 09:12:58AM -0700, Dan Williams wrote:
> The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
> "soft reserved" memory as an "hmem" device")' only registered ranges to
> the hmem driver for each soft-reservation that also appeared in the
> HMAT. While this is meant to encourage platform firmware to "do the
> right thing" and publish an HMAT, the corollary is that platforms that
> fail to publish an accurate HMAT will strand memory from Linux usage.
> Additionally, the "efi_fake_mem" kernel command line option enabling
> will strand memory by default without an HMAT.
> 
> Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
> to be published as raw resource ranges for the hmem driver to consume.
> 
> Include a module parameter to disable either this fallback behavior, or
> the hmat enabling from creating hmem devices. The module parameter
> requires the hmem device enabling to have unique name in the module
> namespace: "device_hmem".
> 
> Rather than mark this x86-only, include an interim phys_to_target_node()
> implementation for arm64.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/arm64/mm/numa.c      |   13 +++++++++++++
>  drivers/dax/Kconfig       |    1 +
>  drivers/dax/hmem/Makefile |    3 ++-
>  drivers/dax/hmem/device.c |   33 +++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 4decf1659700..00fba21eaec0 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -468,3 +468,16 @@ int memory_add_physaddr_to_nid(u64 addr)
>  	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
>  	return 0;
>  }
> +
> +/*
> + * device-dax instance registrations want a valid target-node in case
> + * they are ever onlined as memory (see hmem_register_device()).
> + *
> + * TODO: consult cached numa info
> + */
> +int phys_to_target_node(phys_addr_t addr)
> +{
> +	pr_warn_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> +			addr);
> +	return 0;
> +}

Could you implement a generic version of this by iterating over the nodes
with for_each_{,online_}node() and checking for intersection with
node_{start,end}_pfn()?

Will
