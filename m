Return-Path: <linux-acpi+bounces-84-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D57ADD20
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 604EF281637
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469CA1D691
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:31:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1631B26E
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 14:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E4C433C7;
	Mon, 25 Sep 2023 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695653004;
	bh=zLu+VnRpIsjtnAXABy7BDzCTOqyINaVoPvsO++Hkwow=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qw77X9fkt0hBOpDdvTU2WKmu46P3XwVZXqEmHv04wqXA/tZs4NgonJaHKf7T8MZAC
	 oPNae1MmhWZ3eOq+eqzdXMUr7j7oPNnBXePU3V/yvxGYt+LT2sEv94UA86N3ssa4p9
	 fz6Z0JVoPlrWpHUK4hmHg0rA8lKjUp3uYG452ywN2dkQxUZlpqN4ML0W/HvnTG/LnR
	 mQw58kFoNZmb/HPdqzWT0XPfhg/ijXT/GT5Lcx89pnr12GhQ1x5zAlOPlUT4HhfwTS
	 xy1RrnkmKut5d1yXF7k93DE2LrJT+5zXjmyv4CnjDdS+Abrr+nZp1g5CeFrS7FcnLD
	 QhF4td3R7tIOg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Sep 2023 17:43:15 +0300
Message-Id: <CVS2TK6J4193.2X0455FSP2MLQ@suppilovahvero>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
 <stable@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <bp@alien8.de>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <dave.hansen@linux.intel.com>, <lenb@kernel.org>,
 <hpa@zytor.com>, <robert.moore@intel.com>, <lvying6@huawei.com>,
 <xiexiuqi@huawei.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [RESEND PATCH v8 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, <rafael@kernel.org>,
 <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
X-Mailer: aerc 0.14.0
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-2-xueshuai@linux.alibaba.com>
In-Reply-To: <20230919022127.69732-2-xueshuai@linux.alibaba.com>

On Tue Sep 19, 2023 at 5:21 AM EEST, Shuai Xue wrote:
> There are two major types of uncorrected recoverable (UCR) errors :
>
> - Action Required (AR): The error is detected and the processor already
>   consumes the memory. OS requires to take action (for example, offline
>   failure page/kill failure thread) to recover this uncorrectable error.
>
> - Action Optional (AO): The error is detected out of processor execution
>   context. Some data in the memory are corrupted. But the data have not
>   been consumed. OS is optional to take action to recover this
>   uncorrectable error.
>
> The essential difference between AR and AO errors is that AR is a
> synchronous event, while AO is an asynchronous event. The hardware will
> signal a synchronous exception (Machine Check Exception on X86 and
> Synchronous External Abort on Arm64) when an error is detected and the
> memory access has been architecturally executed.
>
> When APEI firmware first is enabled, a platform may describe one error
> source for the handling of synchronous errors (e.g. MCE or SEA notificati=
on
> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
> notification). In other words, we can distinguish synchronous errors by
> APEI notification. For AR errors, kernel will kill current process
> accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
> addition, for AO errors, kernel will notify the process who owns the
> poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
> However, the GHES driver always sets mf_flags to 0 so that all UCR errors
> are handled as AO errors in memory failure.
>
> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronou=
s
> events.
>
> Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recover=
y support")'
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ef59d6ea16da..88178aa6222d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -101,6 +101,20 @@ static inline bool is_hest_type_generic_v2(struct gh=
es *ghes)
>  	return ghes->generic->header.type =3D=3D ACPI_HEST_TYPE_GENERIC_ERROR_V=
2;
>  }
> =20
> +/*
> + * A platform may describe one error source for the handling of synchron=
ous
> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. S=
CI
> + * or External Interrupt). On x86, the HEST notifications are always
> + * asynchronous, so only SEA on ARM is delivered as a synchronous
> + * notification.
> + */
> +static inline bool is_hest_sync_notify(struct ghes *ghes)
> +{
> +	u8 notify_type =3D ghes->generic->notify.type;
> +
> +	return notify_type =3D=3D ACPI_HEST_NOTIFY_SEA;
> +}
> +
>  /*
>   * This driver isn't really modular, however for the time being,
>   * continuing to use module_param is the easiest way to remain
> @@ -475,7 +489,7 @@ static bool ghes_do_memory_failure(u64 physical_addr,=
 int flags)
>  }
> =20
>  static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gd=
ata,
> -				       int sev)
> +				       int sev, bool sync)
>  {
>  	int flags =3D -1;
>  	int sec_sev =3D ghes_severity(gdata->error_severity);
> @@ -489,7 +503,7 @@ static bool ghes_handle_memory_failure(struct acpi_he=
st_generic_data *gdata,
>  	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>  		flags =3D MF_SOFT_OFFLINE;
>  	if (sev =3D=3D GHES_SEV_RECOVERABLE && sec_sev =3D=3D GHES_SEV_RECOVERA=
BLE)
> -		flags =3D 0;
> +		flags =3D sync ? MF_ACTION_REQUIRED : 0;

Not my territory but this branching looks a bit weird to my
eyes so just in case putting a comment.

What *if* the previous condition sets MF_SOFT_OFFLINE and
this condition overwrites the value?

I know that earlier it could have been overwritten by zero.

Neither the function comment has any explanation why it is
ok overwrite like this.

Or if these cannot happen simultaenously why there is not
immediate return after settting MF_SOFT_OFFLINE?

For someone like me the functions logic is tediously hard
to understand tbh.

BR, Jarkko

