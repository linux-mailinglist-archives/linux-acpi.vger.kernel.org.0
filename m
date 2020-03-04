Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE3D178E10
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCDKK4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:10:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51935 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgCDKK4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Mar 2020 05:10:56 -0500
Received: from [IPv6:2601:646:8600:3281:d841:929b:f37:3a31] ([IPv6:2601:646:8600:3281:d841:929b:f37:3a31])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 024AAZQc311953
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 4 Mar 2020 02:10:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 024AAZQc311953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1583316638;
        bh=c7JAi1VlSKPPzJ5Tyh0qCJzeKbXKmYAvZ7n163Neqv4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=iPlIPmCgk+q9AqXQuGU1Ne5GrRRYgzMxOsSienrKJi4avOWTvi1nVZl2Uzea2quY/
         7ZgB4oFPQM3M/qHL+4EaBZB5D2toljgmT+YaIhyO+I8qA3IiCC4eGR4QWPD6NynVkl
         PyNNusTks1jPeOSADA1BFMGuTzIdkXcuN8gwxn/fg9Cs+ybuXVcIZFnrR6J0KJA1bx
         Wip1QbfPCQ31sEWmzVnlCqXUTGm3G7YEaO0E4shdZMichts0BSZSEtPFNAF9E5tQRH
         sRjVMBjdTzII1psNWgP2boxOzpMTfkHWUX8Du9NWcTZ4Hi5Y6u5SrS+jR+nTlq62/F
         frE66rXl65kmA==
Date:   Wed, 04 Mar 2020 02:10:29 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20200304100437.GM2596@hirez.programming.kicks-ass.net>
References: <20200303204144.GA9913@avx2> <9947D7CB-B9CD-47E0-BC5E-C7FC3A81FC7B@zytor.com> <20200304100437.GM2596@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/acpi: make "asmlinkage" part first thing in the function definition
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Alexey Dobriyan <adobriyan@gmail.com>, rjw@rjwysocki.net,
        lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <E88DA201-307C-4F47-A931-13C3894D2E8F@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On March 4, 2020 2:04:38 AM PST, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Wed, Mar 04, 2020 at 12:54:09AM -0800, hpa@zytor=2Ecom wrote:
>> On March 3, 2020 12:41:44 PM PST, Alexey Dobriyan
><adobriyan@gmail=2Ecom> wrote:
>> >g++ insists that function declaration must start with extern "C"
>> >(which asmlinkage expands to)=2E
>> >
>> >gcc doesn't care=2E
>> >
>> >Signed-off-by: _Z6Alexeyv <adobriyan@gmail=2Ecom>
>> >---
>> >
>> > arch/x86/kernel/acpi/sleep=2Ec |    2 +-
>> > arch/x86/kernel/acpi/sleep=2Eh |    2 +-
>> > 2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> >--- a/arch/x86/kernel/acpi/sleep=2Ec
>> >+++ b/arch/x86/kernel/acpi/sleep=2Ec
>> >@@ -43,7 +43,7 @@ unsigned long acpi_get_wakeup_address(void)
>> >  *
>> >  * Wrapper around acpi_enter_sleep_state() to be called by
>assmebly=2E
>> >  */
>> >-acpi_status asmlinkage __visible x86_acpi_enter_sleep_state(u8
>state)
>> >+asmlinkage acpi_status __visible x86_acpi_enter_sleep_state(u8
>state)
>> > {
>> > 	return acpi_enter_sleep_state(state);
>> > }
>> >--- a/arch/x86/kernel/acpi/sleep=2Eh
>> >+++ b/arch/x86/kernel/acpi/sleep=2Eh
>> >@@ -19,4 +19,4 @@ extern void do_suspend_lowlevel(void);
>> >=20
>> > extern int x86_acpi_suspend_lowlevel(void);
>> >=20
>> >-acpi_status asmlinkage x86_acpi_enter_sleep_state(u8 state);
>> >+asmlinkage acpi_status x86_acpi_enter_sleep_state(u8 state);
>>=20
>> Are you building the kernel with C++?!
>
>He is :-) IIRC he's got a whole bunch of patches that removes all the
>C++ keywords from the kernel=2E

I'm genuinely curious: I have heard it says that gcc is something like 10x=
 slower in C++ mode even for what is otherwise basically C code (i=2Ee=2E n=
o templates etc=2E)

Does that match observations?
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
