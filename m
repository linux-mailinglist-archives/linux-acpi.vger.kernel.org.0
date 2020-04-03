Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0719D7F7
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Apr 2020 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbgDCNr4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Apr 2020 09:47:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34632 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCNr4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2020 09:47:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id i6so7984476qke.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2020 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qdNRHo0P2nwndm72nlj0KFTdzdpRIlGI2oCl2wZmqRw=;
        b=RNjWLw4SdYsHcLWyY27PZEkUnQhnM0/PeIlYt0MuHjz2S9hNjnRBxWKJa2H5rv8mMh
         nMgORm3+S6uND4lQ71jBcJ0cCim0mcrQPxSUA3ffhQ1WymqABc6Qp0WbxL+ynaka+uRJ
         0RR2XwCUx8PhytpZ9n5ddrlxOuL1vbixoRhvy9sismetnlppHtn3cK1xFTfLPGZRrzBL
         E5WJbYI7f66oLY5UhXxrw2TNKx2eV+QrMz5d/wpjyf0ukQuNtjh7hotCr+iYvFjYEEGi
         +8b31VADM8mayUpT9GwzNWJLOKt/M9of18peLupCla8JWeHSi/2ZBdpki18L+r/jinte
         7AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qdNRHo0P2nwndm72nlj0KFTdzdpRIlGI2oCl2wZmqRw=;
        b=t6bLFUBMYyiSb9aoOsnuwMdbg4MuJWSMA5go5YNXlttxVYoJbXU5dK6NAyHdJ+7MbC
         SEjr4l5PfDHFgAG3fgpEtTGRiNkYU1BYfhO5WZUxefpzHe6Df5TdGP/gRR9JNz32IXTZ
         kzgau+7lnjHw2Iyt+bnHFDmT3F2QSSzXBF9L64r0WlziYrtc2kolSrvAfnJMS6dLqDOM
         adgaq/QUKcqnL1ZKkf0VjXQAP2wAEL/aGx16BQj0eTt3kHomMUPksrridRv1p3hE3J3C
         CGmK90TFEajaxSkzrc6Vq/03r/OiifIl/YGnXIrwv7eOkghYMND9XNx8uAWR+ffNVyjc
         QX0Q==
X-Gm-Message-State: AGi0PuY96J+fxlyRrTyhZtxT6panxJvAa93O3HTC0WcaoH6Fu2tZFhBv
        0pzDF8UsCTKlmCeXFL0v1bXXow==
X-Google-Smtp-Source: APiQypLeXYDHI/XOUcp9WJ1mUTCcabpscOrlyn1mlXF4mghOr8L7htAprv8whmbrxvXBk4155DF1GA==
X-Received: by 2002:a37:844:: with SMTP id 65mr8031122qki.15.1585921673927;
        Fri, 03 Apr 2020 06:47:53 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g201sm6233789qke.99.2020.04.03.06.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:47:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] x86/acpi: fix a deadlock with cpu hotplug
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <31115293.RZinmt0Fc6@kreacher>
Date:   Fri, 3 Apr 2020 09:47:52 -0400
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        lenb@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-acpi@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CAC62A8-A604-4825-888B-D2C764C15186@lca.pw>
References: <20200329142109.1501-1-cai@lca.pw> <2025426.V7fFeAKXnt@kreacher>
 <0277E081-1807-4393-BB8D-8E851D3ED1C7@lca.pw> <31115293.RZinmt0Fc6@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> On Apr 3, 2020, at 9:43 AM, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
>=20
> On Friday, April 3, 2020 1:18:07 PM CEST Qian Cai wrote:
>>=20
>>> On Apr 3, 2020, at 5:29 AM, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
>>>=20
>>> On Sunday, March 29, 2020 4:21:09 PM CEST Qian Cai wrote:
>>>> Similar to the commit 0266d81e9bf5 ("acpi/processor: Prevent cpu =
hotplug
>>>> deadlock") except this is for acpi_processor_ffh_cstate_probe():
>>>>=20
>>>> "The problem is that the work is scheduled on the current CPU from =
the
>>>> hotplug thread associated with that CPU.
>>>>=20
>>>> It's not required to invoke these functions via the workqueue =
because
>>>> the hotplug thread runs on the target CPU already.
>>>>=20
>>>> Check whether current is a per cpu thread pinned on the target CPU =
and
>>>> invoke the function directly to avoid the workqueue."
>>>>=20
>>>> Since CONFIG_ACPI_PROCESSOR (for cstate.c) selects
>>>> CONFIG_ACPI_CPU_FREQ_PSS (for processor_throttling.c) on x86, just
>>>> make call_on_cpu() a static inline function from =
processor_throttling.c
>>>> and use it in cstate.c.
>>>>=20
>>>> WARNING: possible circular locking dependency detected
>>>> ------------------------------------------------------
>>>> cpuhp/1/15 is trying to acquire lock:
>>>> ffffc90003447a28 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: =
__flush_work+0x4c6/0x630
>>>>=20
>>>> but task is already holding lock:
>>>> ffffffffafa1c0e8 (cpuidle_lock){+.+.}-{3:3}, at: =
cpuidle_pause_and_lock+0x17/0x20
>>>>=20
>>>> which lock already depends on the new lock.
>>>>=20
>>>> the existing dependency chain (in reverse order) is:
>>>>=20
>>>> -> #1 (cpu_hotplug_lock){++++}-{0:0}:
>>>> cpus_read_lock+0x3e/0xc0
>>>> irq_calc_affinity_vectors+0x5f/0x91
>>>> __pci_enable_msix_range+0x10f/0x9a0
>>>> pci_alloc_irq_vectors_affinity+0x13e/0x1f0
>>>> pci_alloc_irq_vectors_affinity at drivers/pci/msi.c:1208
>>>> pqi_ctrl_init+0x72f/0x1618 [smartpqi]
>>>> pqi_pci_probe.cold.63+0x882/0x892 [smartpqi]
>>>> local_pci_probe+0x7a/0xc0
>>>> work_for_cpu_fn+0x2e/0x50
>>>> process_one_work+0x57e/0xb90
>>>> worker_thread+0x363/0x5b0
>>>> kthread+0x1f4/0x220
>>>> ret_from_fork+0x27/0x50
>>>>=20
>>>> -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
>>>> __lock_acquire+0x2244/0x32a0
>>>> lock_acquire+0x1a2/0x680
>>>> __flush_work+0x4e6/0x630
>>>> work_on_cpu+0x114/0x160
>>>> acpi_processor_ffh_cstate_probe+0x129/0x250
>>>> acpi_processor_evaluate_cst+0x4c8/0x580
>>>> acpi_processor_get_power_info+0x86/0x740
>>>> acpi_processor_hotplug+0xc3/0x140
>>>> acpi_soft_cpu_online+0x102/0x1d0
>>>> cpuhp_invoke_callback+0x197/0x1120
>>>> cpuhp_thread_fun+0x252/0x2f0
>>>> smpboot_thread_fn+0x255/0x440
>>>> kthread+0x1f4/0x220
>>>> ret_from_fork+0x27/0x50
>>>>=20
>>>> other info that might help us debug this:
>>>>=20
>>>> Chain exists of:
>>>> (work_completion)(&wfc.work) --> cpuhp_state-up --> cpuidle_lock
>>>>=20
>>>> Possible unsafe locking scenario:
>>>>=20
>>>> CPU0                    CPU1
>>>> ----                    ----
>>>> lock(cpuidle_lock);
>>>>                        lock(cpuhp_state-up);
>>>>                        lock(cpuidle_lock);
>>>> lock((work_completion)(&wfc.work));
>>>>=20
>>>> *** DEADLOCK ***
>>>>=20
>>>> 3 locks held by cpuhp/1/15:
>>>> #0: ffffffffaf51ab10 (cpu_hotplug_lock){++++}-{0:0}, at: =
cpuhp_thread_fun+0x69/0x2f0
>>>> #1: ffffffffaf51ad40 (cpuhp_state-up){+.+.}-{0:0}, at: =
cpuhp_thread_fun+0x69/0x2f0
>>>> #2: ffffffffafa1c0e8 (cpuidle_lock){+.+.}-{3:3}, at: =
cpuidle_pause_and_lock+0x17/0x20
>>>>=20
>>>> Call Trace:
>>>> dump_stack+0xa0/0xea
>>>> print_circular_bug.cold.52+0x147/0x14c
>>>> check_noncircular+0x295/0x2d0
>>>> __lock_acquire+0x2244/0x32a0
>>>> lock_acquire+0x1a2/0x680
>>>> __flush_work+0x4e6/0x630
>>>> work_on_cpu+0x114/0x160
>>>> acpi_processor_ffh_cstate_probe+0x129/0x250
>>>> acpi_processor_evaluate_cst+0x4c8/0x580
>>>> acpi_processor_get_power_info+0x86/0x740
>>>> acpi_processor_hotplug+0xc3/0x140
>>>> acpi_soft_cpu_online+0x102/0x1d0
>>>> cpuhp_invoke_callback+0x197/0x1120
>>>> cpuhp_thread_fun+0x252/0x2f0
>>>> smpboot_thread_fn+0x255/0x440
>>>> kthread+0x1f4/0x220
>>>> ret_from_fork+0x27/0x50
>>>>=20
>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>> ---
>>>>=20
>>>> v2:
>>>> Make call_on_cpu() a static inline function to avoid a compilation
>>>> error when ACPI_PROCESSOR=3Dm thanks to lkp@intel.com.
>>>>=20
>>>> arch/x86/kernel/acpi/cstate.c       |  3 ++-
>>>> drivers/acpi/processor_throttling.c |  7 -------
>>>> include/acpi/processor.h            | 10 ++++++++++
>>>> 3 files changed, 12 insertions(+), 8 deletions(-)
>>>>=20
>>>> diff --git a/arch/x86/kernel/acpi/cstate.c =
b/arch/x86/kernel/acpi/cstate.c
>>>> index caf2edccbad2..49ae4e1ac9cd 100644
>>>> --- a/arch/x86/kernel/acpi/cstate.c
>>>> +++ b/arch/x86/kernel/acpi/cstate.c
>>>> @@ -161,7 +161,8 @@ int acpi_processor_ffh_cstate_probe(unsigned =
int cpu,
>>>>=20
>>>> 	/* Make sure we are running on right CPU */
>>>>=20
>>>> -	retval =3D work_on_cpu(cpu, acpi_processor_ffh_cstate_probe_cpu, =
cx);
>>>> +	retval =3D call_on_cpu(cpu, acpi_processor_ffh_cstate_probe_cpu, =
cx,
>>>> +			     false);
>>>> 	if (retval =3D=3D 0) {
>>>> 		/* Use the hint in CST */
>>>> 		percpu_entry->states[cx->index].eax =3D cx->address;
>>>> diff --git a/drivers/acpi/processor_throttling.c =
b/drivers/acpi/processor_throttling.c
>>>> index 532a1ae3595a..a0bd56ece3ff 100644
>>>> --- a/drivers/acpi/processor_throttling.c
>>>> +++ b/drivers/acpi/processor_throttling.c
>>>> @@ -897,13 +897,6 @@ static long =
__acpi_processor_get_throttling(void *data)
>>>> 	return pr->throttling.acpi_processor_get_throttling(pr);
>>>> }
>>>>=20
>>>> -static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, =
bool direct)
>>>> -{
>>>> -	if (direct || (is_percpu_thread() && cpu =3D=3D =
smp_processor_id()))
>>>> -		return fn(arg);
>>>> -	return work_on_cpu(cpu, fn, arg);
>>>> -}
>>>> -
>>>> static int acpi_processor_get_throttling(struct acpi_processor *pr)
>>>> {
>>>> 	if (!pr)
>>>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>>>> index 47805172e73d..770d226b22f2 100644
>>>> --- a/include/acpi/processor.h
>>>> +++ b/include/acpi/processor.h
>>>> @@ -297,6 +297,16 @@ static inline void =
acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
>>>> }
>>>> #endif
>>>>=20
>>>> +#ifdef CONFIG_ACPI_CPU_FREQ_PSS
>>>=20
>>> Why does this depend on CONFIG_ACPI_CPU_FREQ_PSS?
>>=20
>> call_on_cpu() was only used in processor_throttling.c which has,
>>=20
>> processor-$(CONFIG_ACPI_CPU_FREQ_PSS)   +=3D processor_throttling.o
>>=20
>> after this patch, it will also be used in cstate.c which has,
>>=20
>> ifneq ($(CONFIG_ACPI_PROCESSOR),)
>> obj-y                           +=3D cstate.o
>> endif
>>=20
>> i.e.,
>>=20
>> config ACPI_PROCESSOR
>>        tristate "Processor"
>>        depends on X86 || IA64 || ARM64
>>        select ACPI_PROCESSOR_IDLE
>>        select ACPI_CPU_FREQ_PSS if X86 || IA64
>>=20
>> Therefore, call_on_cpu() is only used when =
CONFIG_ACPI_CPU_FREQ_PSS=3Dy.
>=20
> While technically kind of correct, this is also rather far from =
straightforward, because
> cstate.o and ACPI_CPU_FREQ_PSS are different things logically.
>=20
>> The #ifdef is rather a safe net that in the future, if we decided to =
make call_on_cpu()
>> a  non-inline function, it will prevent triggering an compilation =
warning for unused
>> function when CONFIG_ACPI_CPU_FREQ_PSS=3Dn.
>=20
> But as long as it is static inline, the #ifdef isn't necessary, is it?

Yes, the compiler yet to get an ability to warn about unused inline =
functions. I am not
going to insist for this tiny detail here. If nobody likes this #ifdef, =
I=E2=80=99ll happily remove it in v3.

>=20
>> It may also serve as a documentation purpose to indicate that =
function is only used
>> with  CONFIG_ACPI_CPU_FREQ_PSS=3Dy.
>=20
> Which is incidental and therefore misleading.
>=20
>>>=20
>>>> +static inline int call_on_cpu(int cpu, long (*fn)(void *), void =
*arg,
>>>> +			      bool direct)
>>>> +{
>>>> +	if (direct || (is_percpu_thread() && cpu =3D=3D =
smp_processor_id()))
>>>> +		return fn(arg);
>>>> +	return work_on_cpu(cpu, fn, arg);
>>>> +}
>>>> +#endif
>>>> +
>>>> /* in processor_perflib.c */
>>>>=20
>>>> #ifdef CONFIG_CPU_FREQ

