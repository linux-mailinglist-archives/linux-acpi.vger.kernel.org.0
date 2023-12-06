Return-Path: <linux-acpi+bounces-2185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D3807968
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EBB1C2088D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB704B14F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A76FA;
	Wed,  6 Dec 2023 11:49:42 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b9b5b254e2so31526b6e.1;
        Wed, 06 Dec 2023 11:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892182; x=1702496982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp7+4/skeq3z1JjM3KigvsLSXGvrXr1gskXOMgpelSY=;
        b=CysehOvfQJu5YxK3jdN2InAl6O8JpAI0enLtXaC7iJjaIs1J13bs/dCoGzlqf6dtZ+
         MqdFbC6K3OWPmaqptAuWlEzx7fwyHa6NkPJYdUUROQNfLNVnXo440wTDMR7KGLUkQCNF
         wayscpiXYsASJbSoOfdGGIUG9HrxQYu7osnW+0oF4zn/dUs1Mv4s7J81NbxUBxUy0FLf
         lyDgBVzdQiyKHEZLQsBxguMUaR82kf+5byieayAk6OWyGdo5DznYHEb7Biv9WAzDUaU3
         7jNLjohIk0wgxMqk52hTzGg4tMXFMkxQIRfR6AdrdqosmH5aYSCN5h//k5u2WjOp8CYA
         5VJg==
X-Gm-Message-State: AOJu0YyIv02B5IokNNAfm7iDorOhcWOz2wYPIM23QSs7aivIvBNAhlXC
	XesLK39CVrhRA9BA+eyJxtk71a+YxUVs1Ahaexg=
X-Google-Smtp-Source: AGHT+IExIFz0Wd6u8xUoM+mJ2csD63ycuSkUyWPAXV3GY072wzEGAsU15EY9wikRo0era7uyehQBhU1ZBS4x7XKxo1M=
X-Received: by 2002:a05:6870:b69a:b0:1fb:9b:3d4c with SMTP id
 cy26-20020a056870b69a00b001fb009b3d4cmr2791355oab.0.1701892181729; Wed, 06
 Dec 2023 11:49:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127055858.41004-1-ytcoode@gmail.com>
In-Reply-To: <20231127055858.41004-1-ytcoode@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 20:49:30 +0100
Message-ID: <CAJZ5v0h-7mhSP5BAig6fj-pax6V_m=u2ygjYU4DxMypJfqv5Cg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Remove unused struct field and incorrect comments
To: Yuntao Wang <ytcoode@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 6:59=E2=80=AFAM Yuntao Wang <ytcoode@gmail.com> wro=
te:
>
> The return_object_type field in `struct acpi_evaluate_info` is unused,
> so remove it.
>
> There are also some issues in the comments of acpi_ps_execute_method().
> First, the parameter_type field has already been removed from
> `struct acpi_evaluate_info`, so the corresponding field description in
> the comments should also be removed. Second, the return_object field
> description in the comments is duplicated. Remove these incorrect comment=
s.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  drivers/acpi/acpica/acstruct.h | 1 -
>  drivers/acpi/acpica/psxface.c  | 3 ---
>  2 files changed, 4 deletions(-)

This is ACPICA code which comes from a separate project.

The way to change it is to submit a pull request with the desired change
to the upstream ACPICA project on GitHub and add a Link tag pointing
to the upstream PR to the corresponding Linux patch.  Then, the Linux
patch can only be applied after the corresponding upstream PR has been
merged.

Thanks!

> diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruc=
t.h
> index f8fee94ba708..fe57c3a16e59 100644
> --- a/drivers/acpi/acpica/acstruct.h
> +++ b/drivers/acpi/acpica/acstruct.h
> @@ -169,7 +169,6 @@ struct acpi_evaluate_info {
>         u16 param_count;        /* Count of the input argument list */
>         u16 node_flags;         /* Same as Node->Flags */
>         u8 pass_number;         /* Parser pass number */
> -       u8 return_object_type;  /* Object type of the returned object */
>         u8 flags;               /* General flags */
>  };
>
> diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.=
c
> index 6f4eace0ba69..df5679bbc510 100644
> --- a/drivers/acpi/acpica/psxface.c
> +++ b/drivers/acpi/acpica/psxface.c
> @@ -70,9 +70,6 @@ acpi_debug_trace(const char *name, u32 debug_level, u32=
 debug_layer, u32 flags)
>   *                                    NULL if no parameters are being pa=
ssed.
>   *                  return_object   - Where to put method's return value=
 (if
>   *                                    any). If NULL, no value is returne=
d.
> - *                  parameter_type  - Type of Parameter list
> - *                  return_object   - Where to put method's return value=
 (if
> - *                                    any). If NULL, no value is returne=
d.
>   *                  pass_number     - Parse or execute pass
>   *
>   * RETURN:      Status
> --
> 2.43.0
>
>

