Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94808985F
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfHLIDT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 04:03:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:13190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHLIDT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Aug 2019 04:03:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 01:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="180776919"
Received: from unknown (HELO [10.239.196.241]) ([10.239.196.241])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2019 01:03:16 -0700
Subject: Re: [PATCH] acpi/hmat: ACPI_HMAT_MEMORY_PD_VALID is deprecated in
 ACPI-6.3
To:     Daniel Black <daniel@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190806042440.16445-1-daniel@linux.ibm.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <67031b1d-5785-330d-ddd8-b862799e6f18@intel.com>
Date:   Mon, 12 Aug 2019 16:03:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806042440.16445-1-daniel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/6/2019 12:24 PM, Daniel Black wrote:
> ACPI-6.3 corresponds to when hmat revision was bumped from
> 1 to 2. In this version ACPI_HMAT_MEMORY_PD_VALID was
> deprecated and made reserved.
> 
> As such in revision 2+ we shouldn't be testing this flag.
> 
> This is as per ACPI-6.3, 5.2.27.3, Table 5-145
> "Memory Proximity Domain Attributes Structure"
> for Flags.

Looks good to me.

Reviewed-by: Tao Xu <tao3.xu@intel.com>
> 
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>
> ---
>   drivers/acpi/hmat/hmat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 96b7d39a97c6..e938e34673d9 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -382,7 +382,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>   		pr_info("HMAT: Memory Flags:%04x Processor Domain:%d Memory Domain:%d\n",
>   			p->flags, p->processor_PD, p->memory_PD);
>   
> -	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
> +	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
>   		target = find_mem_target(p->memory_PD);
>   		if (!target) {
>   			pr_debug("HMAT: Memory Domain missing from SRAT\n");
> 

