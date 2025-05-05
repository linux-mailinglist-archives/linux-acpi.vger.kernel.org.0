Return-Path: <linux-acpi+bounces-13450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2B9AA9413
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 15:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C86188D073
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62937255E44;
	Mon,  5 May 2025 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l16GkV3L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB041C63;
	Mon,  5 May 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450689; cv=none; b=WruEC0HlPCx/Yt/vnpFtDtSkOOntGegrCEJWiUJJRHa1838GqRIggxtkIr05qNK0lCA6++YbdxNMLrS4yPWIZ0SqrAD3wZCSBRoM47XIwyOhiJjm0Ahnesdyp4467O2bQ1JkDQDgulsIeXk/LXxLKiJJfoiC6k4vk5WnbIuryzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450689; c=relaxed/simple;
	bh=AiE4ZD17aPOaZAPivHMdsvTvdLsANzKVsMl0h1CzKxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQt4KSYXMjcTdUa8lUl6XvI8qXqywLGFcKu6g24caJqYzd+xOPIv6h9q2xhGxBb7654/zAWxEWXW6c6GdmY/DJYcIx/MsA+W6hkpw//J+p1nrgEoA9zK17HdHBMdFfMuyfx6LjMQ1iQaedDk+gT1UotF12y047tkG93rpa7ww8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l16GkV3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5058C4CEF0;
	Mon,  5 May 2025 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746450688;
	bh=AiE4ZD17aPOaZAPivHMdsvTvdLsANzKVsMl0h1CzKxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l16GkV3Ld2+BattRDIXJbk3w/r9clpWMvG402x5q7RD8nn7x0kXSZPgyprKVxrpN4
	 +7P7dAWCd9ART3bSmImZk6wpBngHX7qic+ioV4bm3XqnKgzh1pbJMuMUDA1DVRXvZm
	 WZxuhZCFt3+cpYv2p8ZxtWHUZ5ozU2WunK/plugnlKyRctp9dMOANTkfdy3/cP9b7e
	 VEUmW9fJxyOkOebv4J6I0tkm5B+qT8rxI77R9862v/OodWbx0qB2gVKNSM7D/MpOcS
	 vHqFNb7YTkWIWmIevDspXquSQBEeKhu5RIKzR3sr/w6pgC7dImq9/Kzh/30q8b0bhP
	 QSeHnIHN5+bYw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2d060c62b61so3798079fac.0;
        Mon, 05 May 2025 06:11:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDjOMJ1UcRyT5pFhQ2pOdGLZE8UWrxqIwr3qEXgBu/jkWmDvqttfjofMIxyHCZWF4lqU8IwKpcfIPL1oL5@vger.kernel.org, AJvYcCWr/8Kh8vG4s4MftKAPJ5LvI1VWeAYHA6DgSgMfojsh3tbqx3hC9gRnVt5BFyDqgDPB244MJCwrBpyA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4DA+e3T3TQzK13F70qwk55iytkJbF0M92PVFDdnp9MeAAFxC
	zNFkj++XQhdtMWz9rXjwFM2wD5CMW5D9uiwa3yYaG1FEh/DfLTpFG+dxMwcWJetG/ZD4BQ42YOE
	lKEPc/DoQZ7UaTwSCK4nyhqhDn4o=
X-Google-Smtp-Source: AGHT+IEtiEpKVa7HVZWvCw/510Dj6uB2h0Kb40e+MiUAYElqu3q1Q8n0n/uqo9E+TBcQ1QRXY5z5k4nxmZ0sPnnYg1Q=
X-Received: by 2002:a05:6870:30b:b0:2d4:e29d:529a with SMTP id
 586e51a60fabf-2dae82e08b1mr4199691fac.5.1746450688029; Mon, 05 May 2025
 06:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429202412.380637-1-tony.luck@intel.com> <20250429202412.380637-2-tony.luck@intel.com>
In-Reply-To: <20250429202412.380637-2-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 15:11:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ju_Xirnft+5C=-GtG3hmT9xGjVqNFPRugXR7o1RzfHrg@mail.gmail.com>
X-Gm-Features: ATxdqUFw2uXAVVggnwPyHmHSrJuw6ui02s3ht9p5pPI5ZvNwsrVhW-wXCwzpT0U
Message-ID: <CAJZ5v0ju_Xirnft+5C=-GtG3hmT9xGjVqNFPRugXR7o1RzfHrg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: Define MRRM ACPI table
To: Tony Luck <tony.luck@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, 
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:24=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> Patch for reference, this has already been applied to
> https://github.com/acpica/acpica and will in due course make its way
> into Linux when the next ACPICA release is ported over.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/acpi/actbl1.h |  7 +++++++
>  include/acpi/actbl2.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 387fc821703a..4cb36392e9e9 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -110,6 +110,13 @@ struct acpi_whea_header {
>         u64 mask;               /* Bitmask required for this register ins=
truction */
>  };
>
> +/* Larger subtable header (when Length can exceed 255) */
> +
> +struct acpi_subtbl_hdr_16 {
> +       u16 type;
> +       u16 length;
> +};
> +
>  /* https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/acpitab=
l/ns-acpitabl-aspt_table */
>  #define ASPT_REVISION_ID 0x01
>  struct acpi_table_aspt {
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2e917a8f8bca..e7423db6e24b 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -37,6 +37,7 @@
>  #define ACPI_SIG_MCHI           "MCHI" /* Management Controller Host Int=
erface table */
>  #define ACPI_SIG_MPAM           "MPAM" /* Memory System Resource Partiti=
oning and Monitoring Table */
>  #define ACPI_SIG_MPST           "MPST" /* Memory Power State Table */
> +#define ACPI_SIG_MRRM           "MRRM"      /* Memory Range and Region M=
apping table */
>  #define ACPI_SIG_MSDM           "MSDM" /* Microsoft Data Management Tabl=
e */
>  #define ACPI_SIG_NFIT           "NFIT" /* NVDIMM Firmware Interface Tabl=
e */
>  #define ACPI_SIG_NHLT           "NHLT" /* Non HD Audio Link Table */
> @@ -1736,6 +1737,47 @@ struct acpi_msct_proximity {
>         u64 memory_capacity;    /* In bytes */
>  };
>
> +/***********************************************************************=
********
> + *
> + * MRRM - Memory Range and Region Mapping (MRRM) table
> + * Conforms to "Intel Resource Director Technology Architecture Specific=
ation"
> + * Version 1.1, January 2025
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_mrrm {
> +       struct acpi_table_header header;        /* Common ACPI table head=
er */
> +       u8 max_mem_region;                      /* Max Memory Regions sup=
ported */
> +       u8 flags;                               /* Region assignment type=
 */
> +       u8 reserved[26];
> +       u8 memory_range_entry[];
> +};
> +
> +/* Flags */
> +#define ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS (1<<0)
> +
> +/***********************************************************************=
********
> +       *
> +       * Memory Range entry - Memory Range entry in MRRM table
> +       *
> +       *****************************************************************=
*************/
> +
> +struct acpi_mrrm_mem_range_entry {
> +       struct acpi_subtbl_hdr_16 header;
> +       u32 reserved0;          /* Reserved */
> +       u64 addr_base;          /* Base addr of the mem range */
> +       u64 addr_len;           /* Length of the mem range */
> +       u16 region_id_flags;    /* Valid local or remote Region-ID */
> +       u8 local_region_id;     /* Platform-assigned static local Region-=
ID */
> +       u8 remote_region_id;    /* Platform-assigned static remote Region=
-ID */
> +       u32 reserved1;          /* Reserved */
> +       /* Region-ID Programming Registers[] */
> +};
> +
> +/* Values for region_id_flags above */
> +#define ACPI_MRRM_VALID_REGION_ID_FLAGS_LOCAL   (1<<0)
> +#define ACPI_MRRM_VALID_REGION_ID_FLAGS_REMOTE  (1<<1)
> +
>  /***********************************************************************=
********
>   *
>   * MSDM - Microsoft Data Management table
> --

All of the above definitions should be there in linux-next now.

Can you please check if they are there and they are correct?
Alternatively, please check

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dtesting

