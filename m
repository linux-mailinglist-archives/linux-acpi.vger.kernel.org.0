Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490A32CC446
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgLBRwg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 12:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgLBRwg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 12:52:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896CC0613CF;
        Wed,  2 Dec 2020 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=acMSM2cxOCx0tOvk8v1BFFK1BOtvWzyxSd8ojevIz3A=; b=NrZ5GVanJfAildZIYw5HrbgMNi
        I46mGrSIaySOXWYkGPgkm8OtE/9eZ1I1AYe5VG7MuQDQ0+4ke+kaAIJPEWOlwHYcDWzanvwtLu0nd
        PZIaIf9cbv+9zensIxNmWR3yMxIkdujgee030pNUOdgJ79as5w53VFTox6e+kWBEOB4nYCVqWCav/
        kSSmWynEfSpknFmdaRdS/bnXBJ0HhPJe/lwRICdFqpvZvqwpENl/V0OAimVyXuKFfi+/D5rKM8rfl
        LfQXg9P/qOmYfiCfGU/FxdBejlraWyRYbU+Qw914owfKN8NB8LCpfBO7X+KPUc+Z5aWyaJ8UK01Ts
        BQshhUfg==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkWID-0000MJ-Fm; Wed, 02 Dec 2020 17:51:54 +0000
Subject: Re: [PATCH v2] drivers: acpi: add opt-out of apple-specific property
 parsing
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
References: <20201202122123.10229-1-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ad917055-8b27-9ef3-bff1-873a6df354ab@infradead.org>
Date:   Wed, 2 Dec 2020 09:51:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202122123.10229-1-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi--

On 12/2/20 4:21 AM, Enrico Weigelt, metux IT consult wrote:
> Most x86 machines aren't Apple machines, especially VMs.
> Therefore allow opt-out, making the kernel a few KBs smaller,
> eg. for embedded or high-density VMs.
> 
> v2: fixed spelling
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/acpi/Kconfig    | 9 +++++++++
>  drivers/acpi/Makefile   | 2 +-
>  drivers/acpi/internal.h | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..fc37a9a5c2a8 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -79,6 +79,15 @@ config ACPI_DEBUGGER_USER
>  
>  endif
>  
> +config ACPI_APPLE
> +	bool "Apple ACPI properties support"
> +	default y if X86
> +	help
> +	  Extraction of apple specific ACPI properties.

	                Apple-specific

> +
> +	  Say N if you're sure the kernel won't be used on an Apple machine
> +	  and wanna save a few kb of memory. (embedded or high-density VMs)

	      want to

and kb == kilobits. Is that what you mean here?

> +
>  config ACPI_SPCR_TABLE
>  	bool "ACPI Serial Port Console Redirection Support"
>  	default y if X86

-- 
~Randy

