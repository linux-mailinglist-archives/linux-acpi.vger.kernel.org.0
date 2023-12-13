Return-Path: <linux-acpi+bounces-2378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E3811219
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 13:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6061F21394
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4829438;
	Wed, 13 Dec 2023 12:52:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC93255;
	Wed, 13 Dec 2023 04:51:55 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso789363fac.1;
        Wed, 13 Dec 2023 04:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702471915; x=1703076715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZdG9f53iWojvJlp0dRw/Gg/hPo7SN2nW69zkEzGkVc=;
        b=W1pXWwFkwzmRKIDDKWarwgG9EzuwcjxW9pbM6JPS+f1+M8x3MxFaLCHyGAM0aunXvZ
         BRRxZTJT4TKxfZIdKkhxmt4RVvQihTIElSmFsIUtfbUXhsLM8RquBxhi9x2aNDNe9m7X
         EAOb1D5wAoVxeeP21O3o3Qe2Dgc3cJpTTVbGoBNf88Q8pQMIv/iYyHnYXaMxwQ+nVXry
         M2ecEEekt/BsvGGqnFLSJL7eePvPJqWBbK1Qbao5nLGxVk1UK8QHOF//v+Wkpc5ExHc3
         M4Q/JHaVU8nNr8BJ7yWAIFR6W48K2pTs+iR7eVc58FYilPh+FlhPkhdZkPs9bs2vh+QM
         kTuw==
X-Gm-Message-State: AOJu0Yx1ZUz225Ir0PqkMNNuzlnrlGd0e/3r18+yM3YAw8CXe53pNuMB
	OrtiTC19HmJ5QRM2iidXnczOnibu+o4WoiiA19M=
X-Google-Smtp-Source: AGHT+IF2GvASrlb2vnHcx3R+WpqWs3lUMJPslS5M8PZ2C1ZfKJahHhmnOrKvbW6AXAX5qntO0Ob2wHWnBjSLO13DsHc=
X-Received: by 2002:a05:6870:f6aa:b0:1fb:10e7:4f00 with SMTP id
 el42-20020a056870f6aa00b001fb10e74f00mr14653654oab.4.1702471914679; Wed, 13
 Dec 2023 04:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212212239.8971-1-tony.luck@intel.com>
In-Reply-To: <20231212212239.8971-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 13:51:43 +0100
Message-ID: <CAJZ5v0j4djPUdJ3pdzH+E0npJHxMCHFYj4sG2-=S50=XyX_0qg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: extlog: Clear Extended Error Log status when
 RAS_CEC handled the error
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, 
	Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:22=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> When both CONFIG_RAS_CEC and CONFIG_ACPI_EXTLOG are enabled, Linux does
> not clear the status word of the BIOS supplied error record for corrected
> errors. This may prevent logging of subsequent uncorrected errors.
>
> Fix by clearing the status.
>
> Fixes: 23ba710a0864 ("x86/mce: Fix all mce notifiers to update the mce->k=
flags bitmask")
> Reported-by: Erwin Tsaur <erwin.tsaur@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e120a96e1eae..71e8d4e7a36c 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -145,9 +145,14 @@ static int extlog_print(struct notifier_block *nb, u=
nsigned long val,
>         static u32 err_seq;
>
>         estatus =3D extlog_elog_entry_check(cpu, bank);
> -       if (estatus =3D=3D NULL || (mce->kflags & MCE_HANDLED_CEC))
> +       if (!estatus)
>                 return NOTIFY_DONE;
>
> +       if (mce->kflags & MCE_HANDLED_CEC) {
> +               estatus->block_status =3D 0;
> +               return NOTIFY_DONE;
> +       }
> +
>         memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
>         /* clear record status to enable BIOS to update it again */
>         estatus->block_status =3D 0;
> --

Applied as 6.8 material, thanks!

