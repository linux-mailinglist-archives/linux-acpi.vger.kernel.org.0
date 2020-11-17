Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EAA2B6FF6
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 21:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgKQUXg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 15:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQUXg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 15:23:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FA1C0613CF;
        Tue, 17 Nov 2020 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=zW7PJS/kK75G8AdfaRvVDViJ861hr4mlWDOhVvzNbPs=; b=HGDME0EmiKRaW95KdNNyjYwM05
        CWmwbgUDSx7/o1/Hjofufa3hzq37Rj4xzQe4yYLwWhzshQVGaHORvFB/FdSglxS1UOASi0myH+3Q9
        aXmrxEsfockiLEoKeVuGSgcnKkozYBEEB8KRgRAra8nQc9QzKEfwP6xjjAcpWSbZhnFgiOjy67LKZ
        J75tt70fbfCnr4784SYi8aELKaV3ce0KPlM8llzcQLAVLcDkFvxAHDhAmtnjaafwyvwOiFWn3q8ZC
        piE6NIKevGXnvtGptNEHGMh8GQPla4NvtoELbGbip2X5fd59f1dpOF+P1oY76YW6O2RCYFn6l0xpK
        2tX3K6XQ==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf7Vh-0000lA-CJ; Tue, 17 Nov 2020 20:23:32 +0000
Subject: Re: [PATCH] drivers: acpi: add opt-out of apple specific property
 parsing
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
References: <20201117201825.5407-1-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <334dbf18-0e2d-ba15-0bb2-af217ec06b9c@infradead.org>
Date:   Tue, 17 Nov 2020 12:23:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117201825.5407-1-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/17/20 12:18 PM, Enrico Weigelt, metux IT consult wrote:
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..398a9ae73705 100644
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
> +	  and wanna save a few kb of memory. (embedded or hi-density VMs)

	      want to save a few KB                       high-


> +
>  config ACPI_SPCR_TABLE
>  	bool "ACPI Serial Port Console Redirection Support"
>  	default y if X86


-- 
~Randy

