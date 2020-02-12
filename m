Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98115A850
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBLLwr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 06:52:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:57220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgBLLwr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 06:52:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1768FB15E;
        Wed, 12 Feb 2020 11:52:46 +0000 (UTC)
Date:   Wed, 12 Feb 2020 12:52:44 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: [PATCH 1/3] ACPICA: Introduce ACPI_ACCESS_BIT_WIDTH() macro
Message-ID: <20200212125244.2b61202e@endymion>
In-Reply-To: <20200212110540.83559-1-mika.westerberg@linux.intel.com>
References: <20200211180331.11dbe525@endymion>
        <20200212110540.83559-1-mika.westerberg@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 12 Feb 2020 14:05:38 +0300, Mika Westerberg wrote:
> Sometimes it is useful to find the access_width field value in bytes and
> not in bits so add a helper that can be used for this purpose.

s/ACPI_ACCESS_BIT_WIDTH/ACPI_ACCESS_BYTE_WIDTH/ in the subject.

> 
> Suggested-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  include/acpi/actypes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index a2583c2bc054..77d40b02f62a 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -537,6 +537,7 @@ typedef u64 acpi_integer;
>   * struct acpi_resource_generic_register.
>   */
>  #define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + 2))
> +#define ACPI_ACCESS_BYTE_WIDTH(size)    (ACPI_ACCESS_BIT_WIDTH(size) / 8)

One of the points of having this macro being to avoid needless math,
I'd rather do:

#define ACPI_ACCESS_BYTE_WIDTH(size)    (1 << ((size) - 1))

Some compilers might be able to optimize it, but maybe not all, and I
see little point in giving the compiler more work anyway when it can be
easily avoided.

You may also want to replace "bit" by "bit or byte in the comment right
before the macros.

>  
>  /*******************************************************************************
>   *

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
