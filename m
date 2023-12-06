Return-Path: <linux-acpi+bounces-2192-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A522180796F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B341F2164C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B384B141
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C0D1;
	Wed,  6 Dec 2023 12:22:44 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso33882fac.1;
        Wed, 06 Dec 2023 12:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894164; x=1702498964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j41kzx3s+Lo9n7iUVy0Ar6AWX6l9HBvX9XWuY/yvyU=;
        b=EOcENLNTyfbIW8tSVOelHRwzhNl6IXl9pS80DwFYjozzh4qqHAUbnr3+6t8m9yY5Pl
         +IIz8i+drj/BKzQb3PEz5EcTqjSz+UpG2tRIlu2Pb4uTl6Ie8AFh3z5gEL9/QwyS3AxC
         Gk2t+H6OYOtc3t5ZUwrmZ/A8xu5FwjU/mxMBBoix3UcbiEiC1l/YZZP5XswNFj+6aJF+
         cG/IYaSkjOJ8eMS5GAfNIaLc57FE/B9uaIRYTMSIDbf35jaYIqL/VC/jnzi0gNwYLWKK
         ARf0B1aIFbd/FgAdnKnQya2kouPPAfbeUsU6Qc7AGHGtIcR1YQlxmIhEP+GJoidiXMDA
         Gwsg==
X-Gm-Message-State: AOJu0YzoQ2u5l6dav2YnziO6sdzu5In9desLJYW+Q6DnAPaD/hcZUJTQ
	CoS3q1FnRV+QNnWCMN0PIlZVc++Bk0Pfv55Xyvw=
X-Google-Smtp-Source: AGHT+IEhO2mU6P/7052PchUGl0mD/WRb+JlHzOLetzdJxqFUjJkan2T6grG1crR2CLmqbqHs5uwGwAIAsJnq65+10lk=
X-Received: by 2002:a05:6870:b69a:b0:1fb:9b:3d4c with SMTP id
 cy26-20020a056870b69a00b001fb009b3d4cmr2893274oab.0.1701894164249; Wed, 06
 Dec 2023 12:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204180037.383583-1-prarit@redhat.com>
In-Reply-To: <20231204180037.383583-1-prarit@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 21:22:33 +0100
Message-ID: <CAJZ5v0g2mgGyL3ti9Q1rS2unQbXj9mNLr_4Repp==Hh_iiUyzQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: extlog fix null dereference check
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:00=E2=80=AFPM Prarit Bhargava <prarit@redhat.com> =
wrote:
>
> The gcc plugin -fanalyzer [1] tries to detect various
> patterns of incorrect behaviour.  The tool reports
>
> drivers/acpi/acpi_extlog.c: In function =E2=80=98extlog_exit=E2=80=99:
> drivers/acpi/acpi_extlog.c:307:12: warning: check of =E2=80=98extlog_l1_a=
ddr=E2=80=99 for NULL after already dereferencing it [-Wanalyzer-deref-befo=
re-check]
>     |
>     |  306 |         ((struct extlog_l1_head *)extlog_l1_addr)->flags &=
=3D ~FLAG_OS_OPTIN;
>     |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>     |      |                                                  |
>     |      |                                                  (1) pointer=
 =E2=80=98extlog_l1_addr=E2=80=99 is dereferenced here
>     |  307 |         if (extlog_l1_addr)
>     |      |            ~
>     |      |            |
>     |      |            (2) pointer =E2=80=98extlog_l1_addr=E2=80=99 is c=
hecked for NULL here but it was already dereferenced at (1)
>     |
>
> Fix the null dereference check in extlog_exit().
>
> [1] https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Static-Analyzer-Options=
.html
>
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/acpi/acpi_extlog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e120a96e1eae..193147769146 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -303,9 +303,10 @@ static int __init extlog_init(void)
>  static void __exit extlog_exit(void)
>  {
>         mce_unregister_decode_chain(&extlog_mce_dec);
> -       ((struct extlog_l1_head *)extlog_l1_addr)->flags &=3D ~FLAG_OS_OP=
TIN;
> -       if (extlog_l1_addr)
> +       if (extlog_l1_addr) {
> +               ((struct extlog_l1_head *)extlog_l1_addr)->flags &=3D ~FL=
AG_OS_OPTIN;
>                 acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> +       }
>         if (elog_addr)
>                 acpi_os_unmap_iomem(elog_addr, elog_size);
>         release_mem_region(elog_base, elog_size);
> --

Applied as 6.8 material with minor edits in the subject and changelog, than=
ks!

