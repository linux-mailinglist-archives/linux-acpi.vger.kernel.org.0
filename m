Return-Path: <linux-acpi+bounces-7953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08CB9642E2
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 13:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF745B21C76
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CE7E59A;
	Thu, 29 Aug 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1wEQn1Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22619474
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930514; cv=none; b=Rwyv0sBsrTs/fLGOewf8CmLBRppgrKo3PmAlYFaYQ46nkPAsoyQJn9d1WRJkJUIcjAf4KuQ8F6BeqoM4pECqD+GAUXMvMaoJyi2U30L3SNqIU+ntIEjrB0xoKrBTdfiaNDKm3CEmTjDZm+xW0gE7cYBJZp4BsNu2uQTKDcT7Wos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930514; c=relaxed/simple;
	bh=IFqIgKIs7xQOlALJMM68DXa48kfsyicy5jAxMuqc+VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNpPUnw25LtZLcJIW932UH9/0xo9ey9ZukbZJXAldQkOSwPLLSwfK7ECphT9axCN8fhLTao3U7zWdF0GMPde/khI4AXlDSq1PG0skiIMAEEqDQuB+exHaB3Hziz7anoROti/JkQlsVAuE6EtQn3MVmsGh+TgwN/1p2JoIRAbvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1wEQn1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F12C4CEC1
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724930513;
	bh=IFqIgKIs7xQOlALJMM68DXa48kfsyicy5jAxMuqc+VE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s1wEQn1YVHGNtbB4TOb1PigbY3Qa38mHNgl5AfE1ryj8gULSXW7isSxG1JqJLzHFe
	 KjG6UckxE+Jd+FXNDh7z+pHiVPvOEB/l/SPUtRpShf5itNsKl3vnE6THIkmxXXFKIw
	 RiQIfysPlOo3AwROXQarCoReUxN51HKa1PMiUS30FDgUVlx6mxJpUBjiIgVydaf/wV
	 xTIBcm+9w28gLv+h8P3OO+fFM8ezqKwI5w/gPkjIhIcjAqt66tqKY4TKklblhuPVpT
	 FCjC5MCeaGqTFICFY5FVW1nFafek+ElHiXTHvFAFpT++7+Qc1TPJ93sBjKuxwDpngm
	 M4DWq6i26U3mA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-709485aca4bso283837a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 04:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXP2PSKnLugCZh4wF0WlsH0eIZgZxpX4ET/QcTQtsYx0ubZbSmySXbWYuVliiYD6L7DkTj8ZMcafSe5@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoCS+P3ihhP0LrkSu7+zLs2hDRZSHDzXfeOOiJXnb0WELFGdm
	YUX5b3VS575VkxJhUahAPHcLxIR7z4PLVBo2vb8BFC3nPgjQSs45bjpMO15lHgmscB3WSzrHEAi
	aNbo1TLe4XEeCU4YIHnMeKDuH7AA=
X-Google-Smtp-Source: AGHT+IEeLWAl67+hRQ08/BfkHYUBbg+TvBBblfYNyF3cGx5p9nsuASVElFe2XDeGbPAZxbh4JK3k+FtSQ0f0BpAunR0=
X-Received: by 2002:a05:6808:2003:b0:3db:215d:71ea with SMTP id
 5614622812f47-3df05e85ec7mr2250250b6e.51.1724930512790; Thu, 29 Aug 2024
 04:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825141352.25280-1-snishika@redhat.com>
In-Reply-To: <20240825141352.25280-1-snishika@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 13:21:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOJum_D2=0afjUWVo8ZRG6Vbe8cYChDBHPHFF7jsVcBw@mail.gmail.com>
Message-ID: <CAJZ5v0jOJum_D2=0afjUWVo8ZRG6Vbe8cYChDBHPHFF7jsVcBw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_pad: fix crash in exit_round_robin()
To: Seiji Nishikawa <snishika@redhat.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 4:16=E2=80=AFPM Seiji Nishikawa <snishika@redhat.co=
m> wrote:
>
> The kernel occasionally crashes in cpumask_clear_cpu(), which is called
> within exit_round_robin(), because when executing clear_bit(nr, addr) wit=
h
> nr set to 0xffffffff, the address calculation may cause misalignment with=
in
> the memory, leading to access to an invalid memory address.
>
> ----------
> BUG: unable to handle kernel paging request at ffffffffe0740618
>         ...
> CPU: 3 PID: 2919323 Comm: acpi_pad/14 Kdump: loaded Tainted: G           =
OE  X --------- -  - 4.18.0-425.19.2.el8_7.x86_64 #1
>         ...
> RIP: 0010:power_saving_thread+0x313/0x411 [acpi_pad]
> Code: 89 cd 48 89 d3 eb d1 48 c7 c7 55 70 72 c0 e8 64 86 b0 e4 c6 05 0d a=
1 02 00 01 e9 bc fd ff ff 45 89 e4 42 8b 04 a5 20 82 72 c0 <f0> 48 0f b3 05=
 f4 9c 01 00 42 c7 04 a5 20 82 72 c0 ff ff ff ff 31
> RSP: 0018:ff72a5d51fa77ec8 EFLAGS: 00010202
> RAX: 00000000ffffffff RBX: ff462981e5d8cb80 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
> RBP: ff46297556959d80 R08: 0000000000000382 R09: ff46297c8d0f38d8
> R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000000e
> R13: 0000000000000000 R14: ffffffffffffffff R15: 000000000000000e
> FS:  0000000000000000(0000) GS:ff46297a800c0000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffe0740618 CR3: 0000007e20410004 CR4: 0000000000771ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  ? acpi_pad_add+0x120/0x120 [acpi_pad]
>  kthread+0x10b/0x130
>  ? set_kthread_struct+0x50/0x50
>  ret_from_fork+0x1f/0x40
>         ...
> CR2: ffffffffe0740618
>
> crash> dis -lr ffffffffc0726923
>         ...
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x=
86_64/./include/linux/cpumask.h: 114
> 0xffffffffc0726918 <power_saving_thread+776>:   mov    %r12d,%r12d
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x=
86_64/./include/linux/cpumask.h: 325
> 0xffffffffc072691b <power_saving_thread+779>:   mov    -0x3f8d7de0(,%r12,=
4),%eax
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x=
86_64/./arch/x86/include/asm/bitops.h: 80
> 0xffffffffc0726923 <power_saving_thread+787>:   lock btr %rax,0x19cf4(%ri=
p)        # 0xffffffffc0740620 <pad_busy_cpus_bits>
>
> crash> px tsk_in_cpu[14]
> $66 =3D 0xffffffff
>
> crash> px 0xffffffffc072692c+0x19cf4
> $99 =3D 0xffffffffc0740620
>
> crash> sym 0xffffffffc0740620
> ffffffffc0740620 (b) pad_busy_cpus_bits [acpi_pad]
>
> crash> px pad_busy_cpus_bits[0]
> $42 =3D 0xfffc0
> ----------
>
> To fix this, ensure that tsk_in_cpu[tsk_index] !=3D -1 before calling
> cpumask_clear_cpu() in exit_round_robin(), just as it is done in
> round_robin_cpu().
>
> Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
> ---
>  drivers/acpi/acpi_pad.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 350d3a892889..699fbc795cfe 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -136,7 +136,8 @@ static void exit_round_robin(unsigned int tsk_index)
>  {
>         struct cpumask *pad_busy_cpus =3D to_cpumask(pad_busy_cpus_bits);
>
> -       cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
> +       if (tsk_in_cpu[tsk_index] !=3D -1)
> +               cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
>         tsk_in_cpu[tsk_index] =3D -1;
>  }
>
> --

If you already put the check in there, it is generally better to avoid
updates to the same value or you artificially make a cache line hot,
so I've applied this version (modulo GMail-induced white space
breakage):

--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -136,8 +136,10 @@ static void exit_round_robin(unsigned int tsk_index)
 {
     struct cpumask *pad_busy_cpus =3D to_cpumask(pad_busy_cpus_bits);

-    cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
-    tsk_in_cpu[tsk_index] =3D -1;
+    if (tsk_in_cpu[tsk_index] !=3D -1) {
+        cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
+        tsk_in_cpu[tsk_index] =3D -1;
+    }
 }

 static unsigned int idle_pct =3D 5; /* percentage */

