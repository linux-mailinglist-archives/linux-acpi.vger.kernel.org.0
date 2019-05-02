Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5111269
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2019 06:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbfEBE63 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 May 2019 00:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfEBE63 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 May 2019 00:58:29 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A012075E;
        Thu,  2 May 2019 04:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556773108;
        bh=AlJ7fhDL8zv1DFy/4ydx44JaOUdD+SCp0M+l+7To4Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpbZos6rpTINadMWn1nKzCfUFszahKJ0vXJP2WiXTWV353VANv3wilfr+SK8RHHsy
         fPhgeErlz9pG40sridkX9jHWEvLUBoKpyJxGn2UFRtzRUJ9mwvL6Dm4Jtc8SXCd2Bh
         SNGXr8rjqJm6mOrdIbGyBFEM8fAMhRl2MzY9qn+s=
Date:   Thu, 2 May 2019 10:28:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH v2] ACPI / device_sysfs: change _ADR representation to 64
 bits
Message-ID: <20190502045817.GZ3845@vkoul-mobl.Dlink>
References: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 01-05-19, 07:53, Pierre-Louis Bossart wrote:
> Standards such as the MIPI DisCo for SoundWire 1.0 specification
> assume the _ADR field is 64 bits.
> 
> _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> struct acpi_device_info.
> 
> This patch bumps the representation used for sysfs to 64 bits. To
> avoid any compatibility/ABI issues, the printf format is only extended
> to 16 characters when the actual _ADR value exceeds the 32 bit
> maximum.
> 
> Example with a SoundWire device, the results show the complete
> vendorID and linkID which were omitted before:
> 
> Before:
> $ more /sys/bus/acpi/devices/device\:38/adr
> 0x5d070000
> After:
> $ more /sys/bus/acpi/devices/device\:38/adr
> 0x000010025d070000
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> v2: only use 64 bits when required to avoid compatibility issues
> (feedback from Vinod and Rafael)
> 
>  drivers/acpi/device_sysfs.c | 6 ++++--
>  include/acpi/acpi_bus.h     | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 8940054d6250..7dda0ee05cd1 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -428,8 +428,10 @@ static ssize_t acpi_device_adr_show(struct device *dev,
>  {
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  
> -	return sprintf(buf, "0x%08x\n",
> -		       (unsigned int)(acpi_dev->pnp.bus_address));
> +	if (acpi_dev->pnp.bus_address > 0xFFFFFFFF)

Would prefer to use U32_MAX instead of 0xFFFFFFFF

> +		return sprintf(buf, "0x%016llx\n", acpi_dev->pnp.bus_address);
> +	else
> +		return sprintf(buf, "0x%08llx\n", acpi_dev->pnp.bus_address);
>  }
>  static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index f7981751ac77..9075e28ea60a 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -230,7 +230,7 @@ struct acpi_device_dir {
>  /* Plug and Play */
>  
>  typedef char acpi_bus_id[8];
> -typedef unsigned long acpi_bus_address;
> +typedef u64 acpi_bus_address;
>  typedef char acpi_device_name[40];
>  typedef char acpi_device_class[20];
>  
> -- 
> 2.17.1

-- 
~Vinod
