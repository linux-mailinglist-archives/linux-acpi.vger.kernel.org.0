Return-Path: <linux-acpi+bounces-2179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64188077B9
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 19:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC631F202CE
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A16EB74
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 18:42:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF3FA;
	Wed,  6 Dec 2023 08:39:42 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1fb2b83986cso4041fac.0;
        Wed, 06 Dec 2023 08:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880782; x=1702485582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOpsMpN5kc6thb3d1q4d3kl9xx5Ha381XUlpiCeA7Vg=;
        b=Skr0ltN7RAh68pvyRQ62RYPCxQkTu3zX5vEV7e88NMba0BheWhtM9OU0p4nbhlQNRp
         MIMIwcRA90C1ojRWsvZr23RVolctb4WJxh7Oj4o2T6Qgg/A0VaG96mk2m3ceQJuNeF3Z
         75fcagUOb/zghK32WzCh7BrrdA1LBxT1WdUR0p2Hn1XEroNWB+/AnJIaikumhAGBUxe/
         n+sbxLQqKLlTRgQwiTpIHzgIiOfzciej85BSHAUwWTN8VwxeFWeGMM5RfOa0Jx5UemB4
         lxn8z61L7FhDdk5dbR8enUfvh5Ww+URb3rkPfb+N/W6GcrVqDHJHldh710GPlLw3LsYG
         9B1Q==
X-Gm-Message-State: AOJu0Yykcspxr++1unk5wx2E8XcYlOjSFPOPWjtLZTsuCVl3V4GNavtg
	vHBeLqx+H4W+i9W8djKOmJUyIcRXbxZcGX7Fi8b3Yv/4qUM=
X-Google-Smtp-Source: AGHT+IE+QBw0uGCe3QdwQFdjnKR42J/h74k4XSadE/DgYk6WWgxdbDG4+G3mwf1tieSM1OUVNXOpgCrQ+v1vLscpEso=
X-Received: by 2002:a05:6870:e2cb:b0:1fb:23ec:3318 with SMTP id
 w11-20020a056870e2cb00b001fb23ec3318mr2127789oad.0.1701880782199; Wed, 06 Dec
 2023 08:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
In-Reply-To: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 17:39:29 +0100
Message-ID: <CAJZ5v0i7LYzF13M0qdeYWXZ7uO6HUpAS7pE5RJnOAJtKB8o88A@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: debugger: check status of acpi_evaluate_object in acpi_db_walk_for_fields
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	Erik Kaneda <erik.kaneda@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 2:33=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.r=
u> wrote:
>
> Errors in acpi_evaluate_object can lead to incorrect state of buffer.
> This can lead to access to data in previously ACPI_FREEd buffer and
> secondary ACPI_FREE to the same buffer later.
>
> Handle errors in acpi_evaluate_object the same way it is done earlier
> with acpi_ns_handle_to_pathname.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 5fd033288a86 ("ACPICA: debugger: add command to dump all fields
> of particular subtype")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/acpica/dbnames.c | 8 ++++++--

This is ACPICA code which comes from a separate project.

The way to change it is to submit a pull request with the desired change
to the upstream ACPICA project on GitHub and add a Link tag pointing
to the upstream PR to the corresponding Linux patch.  Then, the Linux
patch can only be applied after the corresponding upstream PR has been
merged.

Thanks!

>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.=
c
> index b91155ea9c34..c9131259f717 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
>         ACPI_FREE(buffer.pointer);
>         buffer.length =3D ACPI_ALLOCATE_LOCAL_BUFFER;
> -       acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> -
> +       status =3D acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_os_printf("Could Not evaluate object %p\n",
> +                              obj_handle);
> +               return (AE_OK);
> +       }
>         /*
>          * Since this is a field unit, surround the output in braces
>          */
> --
> 2.34.1
>
>

