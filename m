Return-Path: <linux-acpi+bounces-11011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477FA30B92
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 13:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D33C3AC11A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2D01FA14B;
	Tue, 11 Feb 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAoTaa7N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938131EB9E3;
	Tue, 11 Feb 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276179; cv=none; b=BQwzJxKBuElMO/wKlRcUhAA8lPhq4JTM+7Zrzs0FDhezFLvR0E5JPG2Dx7WIxGNqwyWax5HeMmjjnuZX87iLaPkXBxf98QeMdzey5KBhdCddC1q6goWCSIG3v/1mjLKamqNCAv6zht6DEJ/Ud4h1G3CdjzJ0sN3w0rYAIr/6gZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276179; c=relaxed/simple;
	bh=MU6yp0uVmHSvhlg0eZOaCvSj/yEbYjzcgmlHVf6TAE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flbn+2Rn2hH8RZv4AntBAkXpN51B+MjqcqEIrAA0N0Tec6nNqq7ow/tLgZ9+BzyNyWYw03ptLhDUuTu6JbM0A8yJEB/fMgug16kUqjr18mDYsf6RCVEGAGVPsYm6EDpAnfnOWJxCpaapiH6Du/9iDb1QmebeYV8eEtLaH90CsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAoTaa7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C3CC4AF09;
	Tue, 11 Feb 2025 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739276179;
	bh=MU6yp0uVmHSvhlg0eZOaCvSj/yEbYjzcgmlHVf6TAE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eAoTaa7NpghysdEQG4MMv0SDnRMaNQBLGa7NyXfp9se9d0eqG6CdXeO1y7ZYeID3b
	 rrWUmsT2r1vfw1movEBJQ2Axiwsfi1sORJ1W7W9sXeA+TePVLh+BRezSL/8sx05nI3
	 wcjozpOiETE+9guc4FjwYcmWFsL6ud4/hyTnNez6WgD/1Tf5gTf8XkA08a5lIKhi73
	 eifMEB5PmIliZqJbaUqvaRRTAqdjCxbOUCWfuVFLTvE4IL6PRCsENwFXfrDSJ+SDiy
	 aOpBU2jKo+ecTPC+D6Y9qyqMdeo8PgL+vHQtYiPY0UREbTdL8MRoWh7o4ut63EA+2E
	 P0zAmwaQh85Vg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-726d1760f23so1293675a34.1;
        Tue, 11 Feb 2025 04:16:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqh3bJjeA280u3iCUYlP0NhqxogHvw2B3k5Y+Spj/6YoWd2UK7ajZmXnqLQgx4rdlN9ZzuVJdFTfnp@vger.kernel.org, AJvYcCXxWpo4mx/bG79rSfGbQ0+FWa6maJv6uJIOyOQ/ETCAALWCkn4963MATWmvkXtCP09Q1P0y36Pwzgxyumqe@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxydws7HBT6uX7UsVL4W6V9RvTGRM2l9UmLivFJNJlEbqVOdm
	247H5Gws0j0ujPQTMBJP2AUTdqGh9r5Y7YjEhNoa5KiEhP/m4lFkO7b+b0H2NaXf/uGjg9mAre4
	i6ZSLvMDLV0a0ew4ygF2T6P7WtBk=
X-Google-Smtp-Source: AGHT+IFEzSXnaFW3fXpl8HEm6wmuusCX522zCeoYDCQQ9T2IkFUiDR3+WnRuNEqVE8qBh5Gv74Fj17wD41RMNi2l2ic=
X-Received: by 2002:a05:6870:2253:b0:297:683:8b5b with SMTP id
 586e51a60fabf-2b8b6e3082amr1999660fac.10.1739276178243; Tue, 11 Feb 2025
 04:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210211223.6139-1-tony.luck@intel.com> <20250210211223.6139-2-tony.luck@intel.com>
In-Reply-To: <20250210211223.6139-2-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Feb 2025 13:16:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gfeiHOVzi=YLJivuc7yt=1Rmbo6u759B0=xp_hTOAjXg@mail.gmail.com>
X-Gm-Features: AWEUYZmd-8dXPwgv8smRTbZJNEbp_Na1VjY_SDkiWWFBKIWRdRIJqCE5PVkTers
Message-ID: <CAJZ5v0gfeiHOVzi=YLJivuc7yt=1Rmbo6u759B0=xp_hTOAjXg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPICA: Define MRRM ACPI table
To: Tony Luck <tony.luck@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:12=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> From: Fenghua Yu <fenghua.yu@intel.com>
>
> The MRRM table describes association between physical address ranges
> and "region numbers". This is used by:
>
> 1) The /sys/fs/resctrl filesystem to report memory traffic per-RMID for
> each region.
> 2) Perf subsystem to report memory related uncore events per region.
>
> Structure defined in the Intel Resource Director Technology (RDT)
> Architecture specification downloadable from www.intel.com/sdm
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

So the process for ACPICA changes is that they first need to go into
the upstream ACPICA project on GitHub.

Once merged there, you can submit a corresponding Linux patch pointing
to the upstream commit, but submitting it is not mandatory because
upstream material lands in the Linux kernel eventually automatically.

> ---
>  include/acpi/actbl3.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index 5cd755143b7d..1b9a03ff73ba 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -42,6 +42,7 @@
>  #define ACPI_SIG_WSMT           "WSMT" /* Windows SMM Security Mitigatio=
ns Table */
>  #define ACPI_SIG_XENV           "XENV" /* Xen Environment table */
>  #define ACPI_SIG_XXXX           "XXXX" /* Intermediate AML header for AS=
L/ASL+ converter */
> +#define ACPI_SIG_MRRM           "MRRM" /* Memory Range and Region Mappin=
g table */
>
>  /*
>   * All tables must be byte-packed to match the ACPI specification, since
> @@ -793,6 +794,45 @@ struct acpi_table_xenv {
>         u8 event_flags;
>  };
>
> +/***********************************************************************=
********
> + *
> + * MRRM - Memory Range and Region Mapping (MRRM) table
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_mrrm {
> +       struct acpi_table_header header;
> +       u8 max_mem_region;      /* Max Memory Regions supported */
> +       u8 flags;               /* Region assignment type */
> +       u8 reserved[26];
> +       /* Memory range entry array */
> +};
> +#define ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS   (1<<0)
> +
> +/***********************************************************************=
********
> + *
> + * Memory Range entry - Memory Range entry in MRRM table
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_mrrm_mem_range_entry {
> +       u16 type;               /* Type 0=3D"MRRM" */
> +       u16 length;             /* 32B + sizeof(Region-ID Programming Reg=
[]) */
> +       u32 reserved;           /* Reserved */
> +       u32 base_addr_low;      /* Low 32 bits of base addr of the mem ra=
nge */
> +       u32 base_addr_high;     /* High 32 bits of base addr of the mem r=
ange */
> +       u32 len_low;            /* Low 32 bits of length of the mem range=
 */
> +       u32 len_high;           /* High 32 bits of length of the mem rang=
e */
> +       u16 region_id_flags;    /* Valid local or remote Region-ID */
> +       u8  local_region_id;    /* Platform-assigned static local Region-=
ID */
> +       u8  remote_region_id;   /* Platform-assigned static remote Region=
-ID */
> +       u32 reserved1;          /* Reserved */
> +       /* Region-ID Programming Registers[] */
> +};
> +
> +#define ACPI_MRRM_VALID_REGION_ID_FLAGS_LOCAL  (1<<0)
> +#define ACPI_MRRM_VALID_REGION_ID_FLAGS_REMOTE (1<<1)
> +
>  /* Reset to default packing */
>
>  #pragma pack()
> --
> 2.48.1
>
>

