Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A739310EA8
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBEPpi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 10:45:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:44434 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhBEPa2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Feb 2021 10:30:28 -0500
IronPort-SDR: CQpyMXpvhloMPV9YnhO5ZJAcZTZTCrOqrn6DfzfUdkj3rMbwABTUwFNyJtY5XnI4YTC+iSfGJI
 GjqrMx9MyVWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161207378"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="161207378"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:19:12 -0800
IronPort-SDR: vI6yDYYoX55QmM8S4GOE9030RMWx8Va+4uopWh1v0W10+ipUMXOR9zWIixyR3MgA17VIG9KaiR
 eVgeFxlfACKQ==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="393923553"
Received: from gjcomber-mobl.amr.corp.intel.com (HELO [10.255.228.165]) ([10.255.228.165])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:19:11 -0800
Subject: Re: [PATCH] soundwire: intel: fix possible crash when no device is
 detected (was Re: Crash in acpi_ns_validate_handle triggered by soundwire on
 Linux 5.10)
To:     =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Slusarz, Marcin" <marcin.slusarz@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
 <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
 <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
 <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
 <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
 <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
 <CA+GA0_s7atD4O_DP0NXwVUVvdia2NWwSEfW2Mcw-UoJ9effPvg@mail.gmail.com>
 <CA+GA0_sZQXACjuzYYvrJq-vF-mmjaq82SJ=kifqo4Utv45s5Yg@mail.gmail.com>
 <CA+GA0_vSA51NbyTDtW-2A4aCCp+xXN_BtJfPFAJesRYM0eo9WQ@mail.gmail.com>
 <CA+GA0_sOQeQsaa1JFO3+ySqdLU6BNxrJRrHjqtheEuj60ZmwhA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
Date:   Fri, 5 Feb 2021 10:16:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+GA0_sOQeQsaa1JFO3+ySqdLU6BNxrJRrHjqtheEuj60ZmwhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Marcin for the patch, much appreciated.

> acpi_walk_namespace can return success without executing our
> callback which initializes info->handle.
> If the random value in this structure is a valid address (which
> is on the stack, so it's quite possible), then nothing bad will
> happen, because:
> sdw_intel_scan_controller
>   -> acpi_bus_get_device
>   -> acpi_get_device_data
>   -> acpi_get_data_full
>   -> acpi_ns_validate_handle
> will reject this handle.
> 
> However, if the value from the stack doesn't point to a valid
> address, we get this:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000050

[...]

> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index cabdadb09a1b..bc8520eb385e 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -405,11 +405,12 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
>   {
>       acpi_status status;
> 
> +    info->handle = NULL;
>       status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
>                        parent_handle, 1,
>                        sdw_intel_acpi_cb,
>                        NULL, info, NULL);
> -    if (ACPI_FAILURE(status))
> +    if (ACPI_FAILURE(status) || info->handle == NULL)
>           return -ENODEV;
> 
>       return sdw_intel_scan_controller(info);

It does seem like a required code pattern if I look at I2C and SPI. I 
had no idea. Maybe worth documenting?

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
