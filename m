Return-Path: <linux-acpi+bounces-723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81157CDBE5
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D9F1C2082A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6737D35892
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB251A5B6
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 11:17:44 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324A114;
	Wed, 18 Oct 2023 04:17:43 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bc57401cb9so1589794a34.0;
        Wed, 18 Oct 2023 04:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627862; x=1698232662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lDaOWpU3gP80StErKNHaaeq4NqieF2HqKjhl1efd+s=;
        b=FloK6dG9baKNbjkZnq6kMEngkHvyGn4334MPwdLKsO0bN7pnO2Nk/fYkwkXW94Upwi
         UqCicohQCc6n+5+jpprMdLQ/rrpFIMGEKsQos5T0Oa/Rz0d0fda4/UnyYFezj6Tg0kbY
         uADqyrf9dioX/eOJkw/GgqdIeN2w+mu7SP9En6QWrqIlD0fW/tj+z+IvarcINjHlxpFm
         sn0G/5/rnH2+mlZdBPOTPvHA0dAFFiduu9gpnLVep2G7E2Kpro2q4OfXsp3MUISfeJLC
         S2VAYkwaaMbQCf1Re/Do/K+Wz8nfeX63TXoZKLmiM9NWow5G9n8CW4CohMNPh0sB5qiQ
         mfkg==
X-Gm-Message-State: AOJu0YyvpXnEUp8LzCSgrs6ZasFUTSesLcIvTg7yZiBcrW4NVlt6xJgu
	bWoQ3mLRYdZSfIwtCGRYypLD4grVy4RpytUggOZ9EiBL
X-Google-Smtp-Source: AGHT+IFBzvL59X17lCp+HOvRqrxJ1GAaPlm2t48L9i/AjyWSD9jvbUKaFNksxYScxFhEUM0pwyn7iIFXnr1zSQ9p4fI=
X-Received: by 2002:a4a:b304:0:b0:581:d5df:9cd2 with SMTP id
 m4-20020a4ab304000000b00581d5df9cd2mr4478820ooo.0.1697627862476; Wed, 18 Oct
 2023 04:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012215903.2104652-1-visitorckw@gmail.com> <20231013122236.2127269-1-visitorckw@gmail.com>
In-Reply-To: <20231013122236.2127269-1-visitorckw@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 13:17:31 +0200
Message-ID: <CAJZ5v0gSB_ACBpK1nKu3sbA0HQ1xsk2mn3oc9AjpoFtge9Opdw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: NFIT: Optimize nfit_mem_cmp() for efficiency
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	ira.weiny@intel.com, rafael@kernel.org, lenb@kernel.org, 
	nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 2:22=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> The original code used conditional branching in the nfit_mem_cmp
> function to compare two values and return -1, 1, or 0 based on the
> result. However, the list_sort comparison function only needs results
> <0, >0, or =3D0. This patch optimizes the code to make the comparison
> branchless, improving efficiency and reducing code size. This change
> reduces the number of comparison operations from 1-2 to a single
> subtraction operation, thereby saving the number of instructions.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> v1 -> v2:
> - Add explicit type cast in case the sizes of u32 and int differ.
>
>  drivers/acpi/nfit/core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index f96bf32cd368..563a32eba888 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1138,11 +1138,7 @@ static int nfit_mem_cmp(void *priv, const struct l=
ist_head *_a,
>
>         handleA =3D __to_nfit_memdev(a)->device_handle;
>         handleB =3D __to_nfit_memdev(b)->device_handle;
> -       if (handleA < handleB)
> -               return -1;
> -       else if (handleA > handleB)
> -               return 1;
> -       return 0;
> +       return (int)handleA - (int)handleB;

Are you sure that you are not losing bits in these conversions?

>  }
>
>  static int nfit_mem_init(struct acpi_nfit_desc *acpi_desc)
> --

