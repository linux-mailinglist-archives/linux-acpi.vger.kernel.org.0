Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017FD215CB0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jul 2020 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgGFRJv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 13:09:51 -0400
Received: from foss.arm.com ([217.140.110.172]:57132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgGFRJv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Jul 2020 13:09:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A05D1FB;
        Mon,  6 Jul 2020 10:09:50 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 301E33F68F;
        Mon,  6 Jul 2020 10:09:49 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:09:47 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] Documentation: arm64/sve: drop duplicate words
Message-ID: <20200706170946.GF10992@arm.com>
References: <20200703205110.29873-1-rdunlap@infradead.org>
 <20200703205110.29873-4-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703205110.29873-4-rdunlap@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 03, 2020 at 01:51:10PM -0700, Randy Dunlap wrote:
> Drop the doubled word "for".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Dave Martin <Dave.Martin@arm.com>

Thanks!

Acked-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  Documentation/arm64/sve.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/arm64/sve.rst
> +++ linux-next-20200701/Documentation/arm64/sve.rst
> @@ -494,7 +494,7 @@ Appendix B.  ARMv8-A FP/SIMD programmer'
>  Note: This section is for information only and not intended to be complete or
>  to replace any architectural specification.
>  
> -Refer to [4] for for more information.
> +Refer to [4] for more information.
>  
>  ARMv8-A defines the following floating-point / SIMD register state:
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
