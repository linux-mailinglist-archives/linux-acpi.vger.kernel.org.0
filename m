Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66BC178CED
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgCDI5X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 03:57:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59771 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbgCDI5X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Mar 2020 03:57:23 -0500
Received: from [IPv6:2601:646:8600:3281:d841:929b:f37:3a31] ([IPv6:2601:646:8600:3281:d841:929b:f37:3a31])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0248uuI6301245
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 4 Mar 2020 00:56:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0248uuI6301245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1583312217;
        bh=utclo29XAiv2dCDxoewItG7aKxdh43V5IBOk+FLmUjY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=cXEyWHpJQo074KfzwRKYbKann7+FAimOqGQv6QUi4OIfOaa9rTLXfqJLtS+wYT5mj
         uyHFTop4R7A/l9kT2sBZqG/37sZaT/LkV+b0WxBGHDhx7uZWy9REvhHf4anYRPTAHV
         TxTXNJ7ey+1FhWjJbRPyXMAg1jkSgw7phFlp5EhiHfp6+lXmXrXYxijRzGVGfbHJov
         +rlGKs6OwvOTqFsmNJzFXuqbq4+nnUzRl4Qv1+wohaAq0B47aRrV8geqZ88r/wxlKN
         Iv4Cp+wJqmVyxQxhxSuEbxWfggUa/cv4c86ZGwccl31fygbpOcwUT7WS9TEZsM4PgX
         EeARcAxxx3zxg==
Date:   Wed, 04 Mar 2020 00:54:09 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20200303204144.GA9913@avx2>
References: <20200303204144.GA9913@avx2>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/acpi: make "asmlinkage" part first thing in the function definition
To:     Alexey Dobriyan <adobriyan@gmail.com>, rjw@rjwysocki.net,
        lenb@kernel.org
CC:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <9947D7CB-B9CD-47E0-BC5E-C7FC3A81FC7B@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On March 3, 2020 12:41:44 PM PST, Alexey Dobriyan <adobriyan@gmail=2Ecom> w=
rote:
>g++ insists that function declaration must start with extern "C"
>(which asmlinkage expands to)=2E
>
>gcc doesn't care=2E
>
>Signed-off-by: _Z6Alexeyv <adobriyan@gmail=2Ecom>
>---
>
> arch/x86/kernel/acpi/sleep=2Ec |    2 +-
> arch/x86/kernel/acpi/sleep=2Eh |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>--- a/arch/x86/kernel/acpi/sleep=2Ec
>+++ b/arch/x86/kernel/acpi/sleep=2Ec
>@@ -43,7 +43,7 @@ unsigned long acpi_get_wakeup_address(void)
>  *
>  * Wrapper around acpi_enter_sleep_state() to be called by assmebly=2E
>  */
>-acpi_status asmlinkage __visible x86_acpi_enter_sleep_state(u8 state)
>+asmlinkage acpi_status __visible x86_acpi_enter_sleep_state(u8 state)
> {
> 	return acpi_enter_sleep_state(state);
> }
>--- a/arch/x86/kernel/acpi/sleep=2Eh
>+++ b/arch/x86/kernel/acpi/sleep=2Eh
>@@ -19,4 +19,4 @@ extern void do_suspend_lowlevel(void);
>=20
> extern int x86_acpi_suspend_lowlevel(void);
>=20
>-acpi_status asmlinkage x86_acpi_enter_sleep_state(u8 state);
>+asmlinkage acpi_status x86_acpi_enter_sleep_state(u8 state);

Are you building the kernel with C++?!
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
