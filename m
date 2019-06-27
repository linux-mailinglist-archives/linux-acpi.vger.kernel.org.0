Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06C58D4D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF0VqT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 17:46:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58677 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0VqT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 17:46:19 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 76dfd49e7acbfd3a; Thu, 27 Jun 2019 23:46:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-acpi@vger.kernel.org, lenb@kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH] acpi: make AC and battery drivers available on !X86
Date:   Thu, 27 Jun 2019 23:46:16 +0200
Message-ID: <1589846.kazOc6SxUg@kreacher>
In-Reply-To: <20190620073353.5770-1-ard.biesheuvel@linaro.org>
References: <20190620073353.5770-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, June 20, 2019 9:33:53 AM CEST Ard Biesheuvel wrote:
> ACPI battery and AC devices can be found in arm64 laptops as well,
> so drop the Kconfig dependency on X86 for their drivers.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/acpi/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e016f7a6ed13..3c8011e7b0d7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -155,7 +155,6 @@ config ACPI_EC_DEBUGFS
>  
>  config ACPI_AC
>  	tristate "AC Adapter"
> -	depends on X86
>  	select POWER_SUPPLY
>  	default y
>  	help
> @@ -168,7 +167,6 @@ config ACPI_AC
>  
>  config ACPI_BATTERY
>  	tristate "Battery"
> -	depends on X86
>  	select POWER_SUPPLY
>  	default y
>  	help
> 

Applied, thanks!



