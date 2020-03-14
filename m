Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61B318572E
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Mar 2020 02:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCOBde (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Mar 2020 21:33:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48091 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgCOBde (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2020 21:33:34 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id ab1996ee3b51f96d; Sat, 14 Mar 2020 10:33:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: make "asmlinkage" part first thing in the function definition
Date:   Sat, 14 Mar 2020 10:33:31 +0100
Message-ID: <1684981.ixsy79CQbx@kreacher>
In-Reply-To: <20200303204144.GA9913@avx2>
References: <20200303204144.GA9913@avx2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, March 3, 2020 9:41:44 PM CET Alexey Dobriyan wrote:
> g++ insists that function declaration must start with extern "C"
> (which asmlinkage expands to).
> 
> gcc doesn't care.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/x86/kernel/acpi/sleep.c |    2 +-
>  arch/x86/kernel/acpi/sleep.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -43,7 +43,7 @@ unsigned long acpi_get_wakeup_address(void)
>   *
>   * Wrapper around acpi_enter_sleep_state() to be called by assmebly.
>   */
> -acpi_status asmlinkage __visible x86_acpi_enter_sleep_state(u8 state)
> +asmlinkage acpi_status __visible x86_acpi_enter_sleep_state(u8 state)
>  {
>  	return acpi_enter_sleep_state(state);
>  }
> --- a/arch/x86/kernel/acpi/sleep.h
> +++ b/arch/x86/kernel/acpi/sleep.h
> @@ -19,4 +19,4 @@ extern void do_suspend_lowlevel(void);
>  
>  extern int x86_acpi_suspend_lowlevel(void);
>  
> -acpi_status asmlinkage x86_acpi_enter_sleep_state(u8 state);
> +asmlinkage acpi_status x86_acpi_enter_sleep_state(u8 state);
> 

Applied as 5.7 material, thanks!




