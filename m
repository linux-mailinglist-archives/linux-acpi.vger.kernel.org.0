Return-Path: <linux-acpi+bounces-10419-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957AA04907
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6F018868FA
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28151EBFE2;
	Tue,  7 Jan 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhliR7oG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9B1E0DE2;
	Tue,  7 Jan 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273704; cv=none; b=jzk47R0C883CEpCpe9G+aDT5H+4Z5+12cGLobqQ5ngmA+9guc71v9b8oBp/3gk5QcKKGQWFyOb22dyqwleip1AP/2qvQWY4hLbFZA43eKSCZT1r0OQaYwviUR1wFD7PjwcfrYpZKRCp9yunAmGv7vQUqoXth7sy/xPevBQJ8ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273704; c=relaxed/simple;
	bh=lvb6RQNRW3mlWdwo0/Ckfpfp67qkBwvTWGjjVblK0Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMI6Go529HyXTeLn1Q3L3qWY+n5O8tL9sL11DdLr2p/fp4loTidIui9OwHGA7Cx2KBhA3JZWDkH83j24MGxXhLpthOVB57bCSGYHR88wDKxaTKIetErgTzeB9omn+Z7q7B6kXnugaDBWpSUGODmSR1CqLDNnwwK/NiF53IXfoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhliR7oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45077C4CEDD;
	Tue,  7 Jan 2025 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273704;
	bh=lvb6RQNRW3mlWdwo0/Ckfpfp67qkBwvTWGjjVblK0Wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XhliR7oGoFlAZXmVoerSEiwOG0OAV8SqNZEVJxFS+hwdvuenjN2aHR6XFG6NjHjr1
	 zFi/N8HusLCeScVgAzNluhKVUOCFKUDQ0ZIViZaGBYLyyHF3L+ox9MRhImc3ibYcn8
	 dnmJr9tl9qJuag3K+AeXFekdQKUFpY9oWhZVo9I//6WEfw2rrQPWGQmJ5fK83+w/df
	 W85qja/HjYsCwxRaaLsVpkTPM/t7nCTYoIU9zL2X7Ct+yk1i2/a8bXnMTOUYSbndw7
	 FDe+IV9dmNE5cojUaQEBHlRta4059CefXr9ss82Z7ihCi8zhpOCWHUEHtweqQsblk1
	 CUwLYFVVdrM9Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f2efd94787so9395573eaf.2;
        Tue, 07 Jan 2025 10:15:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/Z7oi0DuyeAumFraAaNbObKIIlPxj1GcJm/sNLyj/shXVGZkRzCij4rcfMQFlUsmejJKoiCAu6iI5mZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBnUdKQyKW7sCQVuNam3+y/Y2o4yAu5dUPZ9weRr0xN95fqj/
	qL+sqN0wBQBdxyIMg4hIBmgG3fQaRUoOxzI8B4fYUhdge3WBtqWmIVTlWa/fs4AIQsOXv3cLifs
	G4/KKzs3Wz3NEqwJ6GXxhbsgU30Q=
X-Google-Smtp-Source: AGHT+IFSQfVb+7mIIDKjo2xyrVs8xiH9iLZaNTBBF+AwlWnTFbs6KKtqWmTkI53dNc41k6r5N/1BGcoeYK+F3vkmt9c=
X-Received: by 2002:a05:6820:4c08:b0:5f4:cd65:7619 with SMTP id
 006d021491bc7-5f62e728e81mr36008117eaf.1.1736273703501; Tue, 07 Jan 2025
 10:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103035122.50315-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250103035122.50315-1-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 19:14:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iEmYTKJ-nB+vgew5PoSYTrvc3D2tX++SLP80pxk0entg@mail.gmail.com>
X-Gm-Features: AbW1kvYAF1MmvluflFSX7ahcck_pzadFk361dZysQvPeHCUiMQ8VJom0KPdKzbU
Message-ID: <CAJZ5v0iEmYTKJ-nB+vgew5PoSYTrvc3D2tX++SLP80pxk0entg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: Use string choice helpers
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <apatel@ventanamicro.com>, 
	kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 4:51=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> Use str_enabled_disabled string helpers for better readability and to
> fix cocci warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202501010947.0e3GVHNa-lkp@intel.com/
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202501010947.0e3GVHNa-lkp@intel.com/
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/tables.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 9e1b01c35070..2295abbecd14 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -56,7 +56,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_h=
eader *header)
>                             (struct acpi_madt_local_apic *)header;
>                         pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x]=
 %s)\n",
>                                  p->processor_id, p->id,
> -                                (p->lapic_flags & ACPI_MADT_ENABLED) ? "=
enabled" : "disabled");
> +                                str_enabled_disabled(p->lapic_flags & AC=
PI_MADT_ENABLED));
>                 }
>                 break;
>
> @@ -66,7 +66,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_h=
eader *header)
>                             (struct acpi_madt_local_x2apic *)header;
>                         pr_debug("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)=
\n",
>                                  p->local_apic_id, p->uid,
> -                                (p->lapic_flags & ACPI_MADT_ENABLED) ? "=
enabled" : "disabled");
> +                                str_enabled_disabled(p->lapic_flags & AC=
PI_MADT_ENABLED));
>                 }
>                 break;
>
> @@ -160,7 +160,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable=
_header *header)
>                             (struct acpi_madt_local_sapic *)header;
>                         pr_debug("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02=
x] lsapic_eid[0x%02x] %s)\n",
>                                  p->processor_id, p->id, p->eid,
> -                                (p->lapic_flags & ACPI_MADT_ENABLED) ? "=
enabled" : "disabled");
> +                                str_enabled_disabled(p->lapic_flags & AC=
PI_MADT_ENABLED));
>                 }
>                 break;
>
> @@ -183,7 +183,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable=
_header *header)
>                         pr_debug("GICC (acpi_id[0x%04x] address[%llx] MPI=
DR[0x%llx] %s)\n",
>                                  p->uid, p->base_address,
>                                  p->arm_mpidr,
> -                                (p->flags & ACPI_MADT_ENABLED) ? "enable=
d" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_MAD=
T_ENABLED));
>
>                 }
>                 break;
> @@ -218,7 +218,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable=
_header *header)
>
>                         pr_debug("CORE PIC (processor_id[0x%02x] core_id[=
0x%02x] %s)\n",
>                                  p->processor_id, p->core_id,
> -                                (p->flags & ACPI_MADT_ENABLED) ? "enable=
d" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_MAD=
T_ENABLED));
>                 }
>                 break;
>
> @@ -228,7 +228,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable=
_header *header)
>
>                         pr_debug("RISC-V INTC (acpi_uid[0x%04x] hart_id[0=
x%llx] %s)\n",
>                                  p->uid, p->hart_id,
> -                                (p->flags & ACPI_MADT_ENABLED) ? "enable=
d" : "disabled");
> +                                str_enabled_disabled(p->flags & ACPI_MAD=
T_ENABLED));
>                 }
>                 break;
>
> --

Applied as 6.14 material, thanks!

