Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF357188C6A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Mar 2020 18:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQRq1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Mar 2020 13:46:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:27207 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgCQRq1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Mar 2020 13:46:27 -0400
IronPort-SDR: FpVMDU1WCK/8TwREBe8AyAnvCO4v2AEh4zJyZqscjA8WKrHUXTirKmXkg/ArUiEFjBbtjUfrUK
 rO62ZygRdZkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 10:46:26 -0700
IronPort-SDR: NGOWTXOpSTQHMdTy0eJgCmrmLu/DJqaJrm8+5OrXN11OwwgLh/M+vulXTg5WfFyXFXvyteKSVF
 b7pRjKz236LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="237967855"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.143.249]) ([10.249.143.249])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2020 10:46:25 -0700
Subject: Re: [PATCH 1/2] PNP: constify driver name
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <1583481181-22972-1-git-send-email-clabbe@baylibre.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <a76a7dc9-4e5d-bb5b-b70c-cf6762b73f7d@intel.com>
Date:   Tue, 17 Mar 2020 18:46:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1583481181-22972-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/6/2020 8:53 AM, Corentin Labbe wrote:
> struct pnp_driver has name set as char* instead of const char* like platform_driver, pci_driver, usb_driver, etc...
> Let's unify a bit by setting name as const char*.
> Furthermore, all users of this structures set name from already const
> data.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   include/linux/pnp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index 3b12fd28af78..b18dca67253d 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -379,7 +379,7 @@ struct pnp_id {
>   };
>   
>   struct pnp_driver {
> -	char *name;
> +	const char *name;
>   	const struct pnp_device_id *id_table;
>   	unsigned int flags;
>   	int (*probe) (struct pnp_dev *dev, const struct pnp_device_id *dev_id);

Applied as 5.7 material along with the [2/2].

BTW, please CC PNP patches to linux-acpi in the future.


