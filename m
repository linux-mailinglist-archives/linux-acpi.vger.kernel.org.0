Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7A1857B1
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Mar 2020 02:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCOBqD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Mar 2020 21:46:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41978 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCOBqD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2020 21:46:03 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 8c69cbe11c14e040; Sat, 14 Mar 2020 10:46:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86: ignore unspecified bit positions in the ACPI global lock field
Date:   Sat, 14 Mar 2020 10:46:00 +0100
Message-ID: <2030043.rEjxodZhqh@kreacher>
In-Reply-To: <20200305122425.32223-1-jengelh@inai.de>
References: <20200305122425.32223-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, March 5, 2020 1:24:25 PM CET Jan Engelhardt wrote:
> The value in "new" is constructed from "old" such that all bits defined
> as reserved by the ACPI spec[1] are left untouched. But if those bits
> do not happen to be all zero, "new < 3" will not evaluate to true.
> 
> The firmware of the laptop(s) Medion MD63490 / Akoya P15648 comes with
> garbage inside the "FACS" ACPI table. The starting value is
> old=0x4944454d, therefore new=0x4944454e, which is >= 3. Mask off
> the reserved bits.
> 
> [1] https://uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=206553
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  arch/x86/kernel/acpi/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 04205ce127a1..f9e84a0e2fa2 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1740,7 +1740,7 @@ int __acpi_acquire_global_lock(unsigned int *lock)
>  		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
>  		val = cmpxchg(lock, old, new);
>  	} while (unlikely (val != old));
> -	return (new < 3) ? -1 : 0;
> +	return ((new & 0x3) < 3) ? -1 : 0;
>  }
>  
>  int __acpi_release_global_lock(unsigned int *lock)
> 

Applied as 5.7 material, thanks!




