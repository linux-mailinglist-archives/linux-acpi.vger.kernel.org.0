Return-Path: <linux-acpi+bounces-398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2987B728A
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 099892811BC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63603D964
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739638DE6
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 19:07:03 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E350AD;
	Tue,  3 Oct 2023 12:07:01 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57b68555467so119390eaf.0;
        Tue, 03 Oct 2023 12:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360020; x=1696964820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJms9X5CgYzjQTYi0S46+K7l4i7nfUDiIw2fC9Ea75w=;
        b=g/5+l3+Gbwu+ybHrJ32uaNUsjNDKF3AscUz18AvSubMCr3PPcjFfcrBeCBsfgIc10i
         Ku4X4FDX4iP8XegIvtH0HL6k4JfnkD4/uZBhaPzhVGsynXcGH9Ulur2MpNo5NSuodULV
         e2CNvQkD4pO4smyG8M2M8UNTJL0Oj5glocshnSCEnJasUUAFCyXgjeWZL4S3XyAmAg9a
         gfxBI4gZMunPG057/CdAGIPG330hwGHkgBmIkGIzeIKlWgmFN1/zqwYnKa8VwDN8MB0h
         Adeqn8q14IOwmk9lk5YzXSRHHhlduoXPTWGKWGp/lw6LtsHsUBlL7T/OjEPVXOcbfGN6
         TGdQ==
X-Gm-Message-State: AOJu0YwvSdRY4OczRvaxeMy4VxgvK5YkW8GTkabiwykgRIgQAdpfjaQ/
	qQYrXYlZUXrCD6RpFKDr9tfspykl5elb/EwgO+g=
X-Google-Smtp-Source: AGHT+IGlUyo+Eh9vciX3F+asaZNDopwJMHEwvuHTmzKRLyVshyAQjshz7W8olqTxAZX9bk180zjwfh6f6xuePTN+LDQ=
X-Received: by 2002:a4a:b807:0:b0:57b:3b64:7ea5 with SMTP id
 g7-20020a4ab807000000b0057b3b647ea5mr237436oop.1.1696360020170; Tue, 03 Oct
 2023 12:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928214807.43409-1-bergh.jonathan@gmail.com>
In-Reply-To: <20230928214807.43409-1-bergh.jonathan@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 21:06:49 +0200
Message-ID: <CAJZ5v0jjwez87RBTYx8eKs1AYNWbv4U41=YbKC6scHkY3-920A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: acpi: Fix label indentation and leading
 comma formatting issues
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 11:48=E2=80=AFPM Jonathan Bergh
<bergh.jonathan@gmail.com> wrote:
>
> Fixed the following formatting issues flagged by checkpatch
> in utils.c:
>  * Remove incorrect indentation before goto label
>  * Remove whitespace ahead of comma in parameter list
>
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/acpi/utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 2ea14648a661..300646bf8ba7 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -399,7 +399,7 @@ acpi_evaluate_reference(acpi_handle handle,
>                 acpi_handle_debug(list->handles[i], "Found in reference l=
ist\n");
>         }
>
> -      end:
> +end:
>         if (ACPI_FAILURE(status)) {
>                 list->count =3D 0;
>                 //kfree(list->handles);
> @@ -523,7 +523,7 @@ acpi_handle_printk(const char *level, acpi_handle han=
dle, const char *fmt, ...)
>         vaf.va =3D &args;
>
>         path =3D acpi_handle_path(handle);
> -       printk("%sACPI: %s: %pV", level, path ? path : "<n/a>" , &vaf);
> +       printk("%sACPI: %s: %pV", level, path ? path : "<n/a>", &vaf);
>
>         va_end(args);
>         kfree(path);
> --

Applied as 6.7 material along with the [2/2] with edis in subjects and
changelogs.

Thanks!

