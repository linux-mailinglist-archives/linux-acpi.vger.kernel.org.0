Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A01915E1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 17:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCXQNw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 12:13:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:58638 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbgCXQNw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 12:13:52 -0400
IronPort-SDR: GKb0EOgvfEjWC88/8TiHNeaUZSlGp7SN06JnaH7RcCAywxmQjb3RL/MRmlNzthNknsvdtj0GMm
 raX7HMSzG3bA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 09:13:51 -0700
IronPort-SDR: W8SciJsflDt7I1KWp22n6eTJA7U0Ua/WogD7R+qVo6jLLLwyy64NWdjac5turEh7gfGs2gJwPy
 ixWURD/+G7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; 
   d="scan'208";a="393330458"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.142.176]) ([10.249.142.176])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2020 09:13:50 -0700
Subject: Re: [PATCH][next] pnpbios: pnpbios.h: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20200320231827.GA21969@embeddedor.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <bd76497e-7d37-a38b-b12c-d6069714f2f0@intel.com>
Date:   Tue, 24 Mar 2020 17:13:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320231827.GA21969@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/21/2020 12:18 AM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>          int stuff;
>          struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/pnp/pnpbios/pnpbios.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
> index 37acb8378f39..2ce739ff9c1a 100644
> --- a/drivers/pnp/pnpbios/pnpbios.h
> +++ b/drivers/pnp/pnpbios/pnpbios.h
> @@ -107,7 +107,7 @@ struct pnp_bios_node {
>   	__u32 eisa_id;
>   	__u8 type_code[3];
>   	__u16 flags;
> -	__u8 data[0];
> +	__u8 data[];
>   };
>   #pragma pack()
>   

Please resend this with a CC to linux-acpi, thanks!


