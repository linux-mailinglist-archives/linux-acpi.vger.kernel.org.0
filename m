Return-Path: <linux-acpi+bounces-9287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BF9BC031
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 22:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9468FB21111
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 21:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F481FCC75;
	Mon,  4 Nov 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="jM543o6L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8931FA272
	for <linux-acpi@vger.kernel.org>; Mon,  4 Nov 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756296; cv=none; b=UZ3LrrkJ2gCeKkqmrQRoJOj2+Y8By/p3yErWiW/TFbGk5NC7xEejK/s3wCpmcQE+3EutmbqW8wo+Gt/K8xM24/m8ijhEPNedzh3MzRQb5bzS4HTrn0zY2NOffivsc8wQINvb0B6NDA525XTolye83vw0WWRpCfw6ZsN11UrnCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756296; c=relaxed/simple;
	bh=obcFu27KQCZjTjPuY5L7sCMbgAjqr2KJwucsh+50tpU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RsP0QrPfESm5MJzaAaNKe/smU/CFSpCdjx24KI9Vho3IgpB2dWRO3E72aFxauGTiJmu50CR0Zyvs5ZHiKCYiN3SC4+4IgWmI+f8Mg39FW4cowtWmLY5Lumot03RX+wRqs5XUNILuSorFRHYQqMz4BY7MyIYrqfHInvzah+0gQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=jM543o6L; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-539d9fffea1so4989583e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 04 Nov 2024 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1730756292; x=1731361092; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vh1n/y4BqSxL61trxk9F4cMNSFBXDYeq2HQnvqXSzYs=;
        b=jM543o6Lc7jCTAS8LzoJxtYcmZPBNgrTTqW56ph04pXLgTyl9S9zlM5W4zsc5vbqcM
         1Awh2j7jdx5jLx+S4JJvJkf4PVx1Q9R/oTAAvAHNj8OKnfZa20WAgnokgh4zZSqbsZ99
         cdP2/7NLqysY4OAC+N24eJi7U7s79qYVM/87M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730756292; x=1731361092;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh1n/y4BqSxL61trxk9F4cMNSFBXDYeq2HQnvqXSzYs=;
        b=XQ7tet+f3uMpHrzCoJgmX5nIeO/s+cVGmZZYuuMJirlaLzrhV7f4n+IPn9a+NTBxKe
         zeyU1xIgfTSy8o3CLHqomj8cyVO1b8BtrSrG/EshparrRru2AC5g2A0PAnc5nVEVJOim
         nuikY0udesYvQQbm4uZE0cD7XYCjvMvrXp9R3q7iQNCmoLg108n9qtNeOj4Dna4zV8+k
         UExfsjwhtgyCx66/buZQJN/2F/yea3lD3wXtE94FoyKmwrf7fM55Nt2iG6mxqEBZC84d
         V60CbnedlaYpyZA4o9s4NqDIN86y2L1C6vWf0DPU1AXBoB8y5am7P4Wew+epld5xYFR9
         85pg==
X-Forwarded-Encrypted: i=1; AJvYcCWXgYRh9DCYKKIqg0Y3Ceg5+G7cvgmCi0m02puB1jT/Z55nCxZhQi1czHJlYlzNASVfXaxqZithk0vn@vger.kernel.org
X-Gm-Message-State: AOJu0YygLVmmi/piO8E+51p85/kaCaAjDoLJp0Gz5o5bOG53VjRJYl7J
	m9ZxhNUAzaRxbPbRdIyut51ZxTVnaZHV6xkzN2ieMJDTG1BE5WOkYRmlthnQVxQaUZnvRDt+t5G
	sdGkZOGWIkrI=
X-Google-Smtp-Source: AGHT+IEPwRwaCa+0wyq2Ttk58W9tNOdor2K6tXZmSyjZqjuf4o56Nm6ohzH0YHSYghl5u5PoQ9WhVg==
X-Received: by 2002:a05:651c:221e:b0:2fb:65c8:b4ca with SMTP id 38308e7fff4ca-2fcbe09865amr150417351fa.40.1730756291637;
        Mon, 04 Nov 2024 13:38:11 -0800 (PST)
Received: from [192.168.100.4] ([176.221.221.77])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9582esm1893755e87.59.2024.11.04.13.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:38:08 -0800 (PST)
Message-ID: <25d7112c4ca6d84e6a1289663cbf172bf7709fee.camel@intelfx.name>
Subject: Re: [PATCH v3] ACPI: processor: Move arch_init_invariance_cppc()
 call later
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"	 <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>, Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy"	 <gautham.shenoy@amd.com>, "open list:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)"	 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,  Oleksandr Natalenko
 <oleksandr@natalenko.name>
Date: Tue, 05 Nov 2024 01:38:03 +0400
In-Reply-To: <814adf82-99ec-44f8-83d0-6540f2cccbcb@kernel.org>
References: <20241104205446.3874509-1-superm1@kernel.org>
	 <CAJZ5v0jGTzRNgA7HM-r=TuhHyy0gvMuNEgz5wZ2hPkqwyFa6og@mail.gmail.com>
	 <814adf82-99ec-44f8-83d0-6540f2cccbcb@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/h+3FMQAWskMVIpDn/wq"
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-/h+3FMQAWskMVIpDn/wq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2024-11-04 at 15:14 -0600, Mario Limonciello wrote:
> On 11/4/2024 15:10, Rafael J. Wysocki wrote:
> > On Mon, Nov 4, 2024 at 9:54=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> > >=20
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > >=20
> > > arch_init_invariance_cppc() is called at the end of
> > > acpi_cppc_processor_probe() in order to configure frequency invarianc=
e
> > > based upon the values from _CPC.
> > >=20
> > > This however doesn't work on AMD CPPC shared memory designs that have
> > > AMD preferred cores enabled because _CPC needs to be analyzed from al=
l
> > > cores to judge if preferred cores are enabled.
> > >=20
> > > This issue manifests to users as a warning since commit 21fb59ab4b97
> > > ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to wa=
rn"):
> > > ```
> > > Could not retrieve highest performance (-19)
> > > ```
> > >=20
> > > However the warning isn't the cause of this, it was actually
> > > commit 279f838a61f9 ("x86/amd: Detect preferred cores in
> > > amd_get_boost_ratio_numerator()") which exposed the issue.
> > >=20
> > > To fix this problem, change arch_init_invariance_cppc() into a new we=
ak
> > > symbol that is called at the end of acpi_processor_driver_init().
> > > Each architecture that supports it can declare the symbol to override
> > > the weak one.
> > >=20
> > > Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boos=
t_ratio_numerator()")
> > > Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219431
> > > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v3:
> > >   * Weak symbol instead of macro to help riscv build failure
> > >   * Update commit message
> > >   * Add comment
> > > ---
> > >   arch/arm64/include/asm/topology.h | 2 +-
> > >   arch/x86/include/asm/topology.h   | 2 +-
> > >   drivers/acpi/cppc_acpi.c          | 6 ------
> > >   drivers/acpi/processor_driver.c   | 9 +++++++++
> > >   include/acpi/processor.h          | 2 ++
> > >   5 files changed, 13 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/a=
sm/topology.h
> > > index 5fc3af9f8f29b..8a1860877967e 100644
> > > --- a/arch/arm64/include/asm/topology.h
> > > +++ b/arch/arm64/include/asm/topology.h
> > > @@ -27,7 +27,7 @@ void update_freq_counters_refs(void);
> > >   #define arch_scale_freq_ref topology_get_freq_ref
> > >=20
> > >   #ifdef CONFIG_ACPI_CPPC_LIB
> > > -#define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> > > +#define acpi_processor_init_invariance_cppc topology_init_cpu_capaci=
ty_cppc
> > >   #endif
> > >=20
> > >   /* Replace task scheduler's default cpu-invariant accounting */
> > > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/t=
opology.h
> > > index aef70336d6247..0fb705524aeaa 100644
> > > --- a/arch/x86/include/asm/topology.h
> > > +++ b/arch/x86/include/asm/topology.h
> > > @@ -307,7 +307,7 @@ extern void arch_scale_freq_tick(void);
> > >=20
> > >   #ifdef CONFIG_ACPI_CPPC_LIB
> > >   void init_freq_invariance_cppc(void);
> > > -#define arch_init_invariance_cppc init_freq_invariance_cppc
> > > +#define acpi_processor_init_invariance_cppc init_freq_invariance_cpp=
c
> > >   #endif
> > >=20
> > >   #endif /* _ASM_X86_TOPOLOGY_H */
> > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > index 1a40f0514eaa3..5c0cc7aae8726 100644
> > > --- a/drivers/acpi/cppc_acpi.c
> > > +++ b/drivers/acpi/cppc_acpi.c
> > > @@ -671,10 +671,6 @@ static int pcc_data_alloc(int pcc_ss_id)
> > >    *  )
> > >    */
> > >=20
> > > -#ifndef arch_init_invariance_cppc
> > > -static inline void arch_init_invariance_cppc(void) { }
> > > -#endif
> > > -
> > >   /**
> > >    * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
> > >    * @pr: Ptr to acpi_processor containing this CPU's logical ID.
> > > @@ -905,8 +901,6 @@ int acpi_cppc_processor_probe(struct acpi_process=
or *pr)
> > >                  goto out_free;
> > >          }
> > >=20
> > > -       arch_init_invariance_cppc();
> > > -
> > >          kfree(output.pointer);
> > >          return 0;
> > >=20
> > > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> > > index cb52dd000b958..3b281bc1e73c3 100644
> > > --- a/drivers/acpi/processor_driver.c
> > > +++ b/drivers/acpi/processor_driver.c
> > > @@ -237,6 +237,9 @@ static struct notifier_block acpi_processor_notif=
ier_block =3D {
> > >          .notifier_call =3D acpi_processor_notifier,
> > >   };
> > >=20
> > > +void __weak acpi_processor_init_invariance_cppc(void)
> > > +{ }
> >=20
> > Does this actually work if acpi_processor_init_invariance_cppc is a
> > macro?  How does the compiler know that it needs to use
> > init_freq_invariance_cppc() instead of this?
> >=20
> > It would work if a __weak definition of init_freq_invariance_cppc() was=
 present.
>=20
> I also wasn't sure, so I explicitly added some tracing in=20
> init_freq_invariance_cppc() to make sure it got called and checked it=20
> (GCC 13.2.0).

Aren't C macros substituted strictly lexically, i.e. if the #define is
present by the time the function definition is parsed, it's just

void __weak acpi_processor_init_invariance_cppc(void) {}
-> void __weak init_freq_invariance_cppc(void) {}

? So it _is_ a weak definition of init_freq_invariance_cppc().

>=20
> But I'll admit it's a confusing behavior.  If you think it's too=20
> confusing I'll swap it around to just axe the macros.

...That said, it does look kinda confusing. Seems to be norm for that
arch/ header file though.

Anyway,

  Tested-by: Ivan Shapovalov <intelfx@intelfx.name>


>=20
> >=20
> > > +
> > >   /*
> > >    * We keep the driver loaded even when ACPI is not running.
> > >    * This is needed for the powernow-k8 driver, that works even witho=
ut
> > > @@ -270,6 +273,12 @@ static int __init acpi_processor_driver_init(voi=
d)
> > >                                    NULL, acpi_soft_cpu_dead);
> > >=20
> > >          acpi_processor_throttling_init();
> > > +
> > > +       /*
> > > +        * Frequency invariance calculations on AMD platforms can't b=
e run until
> > > +        * after acpi_cppc_processor_probe() has been called for all =
online CPUs.
> > > +        */
> > > +       acpi_processor_init_invariance_cppc();
> > >          return 0;
> > >   err:
> > >          driver_unregister(&acpi_processor_driver);
> > > diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> > > index e6f6074eadbf3..a17e97e634a68 100644
> > > --- a/include/acpi/processor.h
> > > +++ b/include/acpi/processor.h
> > > @@ -465,4 +465,6 @@ extern int acpi_processor_ffh_lpi_probe(unsigned =
int cpu);
> > >   extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)=
;
> > >   #endif
> > >=20
> > > +void acpi_processor_init_invariance_cppc(void);
> > > +
> > >   #endif
> > >=20
> > > base-commit: 6db936d4ac0fe281af48b4d1ebf69b1523bbac31
> > > --
> > > 2.43.0
> > >=20
>=20

--=-/h+3FMQAWskMVIpDn/wq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmcpPrsVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dsy0P/3EI4lHiwlZWLjBbs3efEmtyXF4V
Hhf5Qw1LibvDfdFCkSYyNux2oFYoDThhCVVYIKTpAHvOzgAE5tYs2qb7oQuv7IDK
HcXcZTRq2esbA0ax0jCDcblRjav1xB015reUSD7XrRWeY2RmRqbHhz/yUNc/2sJl
HasfPTQH6NRy4W+4uG+rbSw//+QZbJO4FXRgX89joA4Sfr4iDpyLcqrEL6ZaCVC8
I6CCoqqcf08+CNHj2L9zpbFAihx4z25ADv1hTWVq4ainLawTUnyxon+u40Gl5y0K
XtIFvvMvlZ5DnkhZ16DIcs4lxMXaJkwUbra4PjPvTZOZbkewweIuzmO68uL25uso
BhzjgXFD/EBbhLFmmz0KQYoI5lP+vUSz+oJI1kuQ3XmCFnakJS0uGc+CWMG3PFv1
vnqSQ+ttp22A3kLNENjvfSWAzFI/KxTGBf2alJDcEAzaAHaBUIw3tAVCb1KLYTSu
YhrEsmbj69T3hsw6r1Pgnq+IJasMkewn/CSpSOLsRcjlaOTqVn5OQz4/cJiqOlag
kZE10Yc48s1/3nYTkHHqSY9y7jVbG+dXgrKNHS8JKy0mrhjIUFdgJXfi3iuvXKcI
QEpRWCuI0lP/nMwqw+8ERptMq8XikeQZeFpsJoFNj6fVNbOETd1wN+e0C7C7ma61
YZQWpoMqQfMlb0v5
=2UY9
-----END PGP SIGNATURE-----

--=-/h+3FMQAWskMVIpDn/wq--

