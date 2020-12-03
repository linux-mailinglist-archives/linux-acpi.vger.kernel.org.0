Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20812CDD36
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLCSUq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 13:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLCSUp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 13:20:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88240C061A4F;
        Thu,  3 Dec 2020 10:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cD/gPx1zDgnIQ7RA23nlOJGpnoyXojHHIs8a72pYbw4=; b=3VYA0JzUAEg95sqgTyYJhvZ7Hz
        59/T3uMOZY3ab1Tvd7FE4IQaahiB7jyRSCYrVuzGdXrqOHxZX9nPLmE51u4KqoTx4M7y2uOBLI8w6
        HTdqCVq0t1Xe3YprDlwDxqtS6UA4Ku+bvgtvNPuV4QubdWzwuO3at+Jx3NtP4O7Z9EoyPYsWCL+b4
        R7s4/eUSuVJ9z9IQgRBT/cj1/WA9AZ7Yp38t+L6ICx75Dr6qPuzeyQ1xp9AcI+t4+Q6/+k6kNzVM0
        17EgiADhpRJ3kDem5S4zhEayqRf6xMuy4Q+xpnM70Znw4oIlAyimlv0JV5g47hBiiQ4/b8dhg2rtn
        nUbr3jRA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kktD1-0001Se-Cw; Thu, 03 Dec 2020 18:20:03 +0000
Subject: Re: [PATCH] drivers: acpi: add opt-out of Apple-specific property
 parsing
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
References: <20201203174453.12084-1-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <88bb006f-27bd-7be6-19b5-6b879f1df131@infradead.org>
Date:   Thu, 3 Dec 2020 10:19:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203174453.12084-1-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/3/20 9:44 AM, Enrico Weigelt, metux IT consult wrote:
> Most x86 machines aren't Apple machines, especially VMs.
> Therefore allow opt-out, making the kernel a few KBs smaller,
> eg. for embedded or high-density VMs.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/acpi/Kconfig    | 9 +++++++++
>  drivers/acpi/Makefile   | 2 +-
>  drivers/acpi/internal.h | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..cc47de4f2b18 100644
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
> +	  Extraction of Apple-specific ACPI properties.
> +
> +	  Say N if you're sure the kernel won't be used on an Apple machine
> +	  and wanna save a few kb of memory. (embedded or high-density VMs)

	      want to

As I have said before, don't use "kb". It means kilobits. We don't normally
measure memory in kilobits.


Did you read all of my previous email?


> +
>  config ACPI_SPCR_TABLE
>  	bool "ACPI Serial Port Console Redirection Support"
>  	default y if X86

-- 
~Randy

