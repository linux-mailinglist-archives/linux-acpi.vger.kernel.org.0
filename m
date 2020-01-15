Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB113BDD2
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 11:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgAOK47 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 05:56:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:32556 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgAOK47 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Jan 2020 05:56:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 02:56:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="424978975"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.136.80]) ([10.249.136.80])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2020 02:56:56 -0800
Subject: Re: [PATCH] PNP: isapnp: remove set but not used variable 'checksum'
To:     yu kuai <yukuai3@huawei.com>
Cc:     perex@perex.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhengbin13@huawei.com, linux-acpi@vger.kernel.org
References: <20200103121710.4761-1-yukuai3@huawei.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <2406530b-704b-2168-8f88-66c9b0fc6727@intel.com>
Date:   Wed, 15 Jan 2020 11:56:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200103121710.4761-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 1/3/2020 1:17 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/pnp/isapnp/core.c: In function ‘isapnp_build_device_list’:
> drivers/pnp/isapnp/core.c:777:27: warning: variable ‘checksum’ set
> but not used [-Wunused-but-set-variable]
>
> It is never used, and so can be removed.
>
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>   drivers/pnp/isapnp/core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index 179b737280e1..e39d49bceae0 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -774,7 +774,7 @@ static unsigned char __init isapnp_checksum(unsigned char *data)
>   static int __init isapnp_build_device_list(void)
>   {
>   	int csn;
> -	unsigned char header[9], checksum;
> +	unsigned char header[9];
>   	struct pnp_card *card;
>   	u32 eisa_id;
>   	char id[8];
> @@ -784,7 +784,6 @@ static int __init isapnp_build_device_list(void)
>   	for (csn = 1; csn <= isapnp_csn_count; csn++) {
>   		isapnp_wake(csn);
>   		isapnp_peek(header, 9);
> -		checksum = isapnp_checksum(header);
>   		eisa_id = header[0] | header[1] << 8 |
>   			  header[2] << 16 | header[3] << 24;
>   		pnp_eisa_id_to_string(eisa_id, id);

Applied as 5.6 material, thanks!

Note that it is recommended to CC patches that touch the PNP code to 
linux-acpi@vger.kernel.org


