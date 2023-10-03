Return-Path: <linux-acpi+bounces-379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF87B6BCA
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B23E32815B1
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933EC328BF
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263092134E
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 14:05:40 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99076AB
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 07:05:38 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57b68555467so81697eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Oct 2023 07:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696341938; x=1696946738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96OAizNHn5IUNhRYXlujPgFs8wLFeiew/An0qdOy7WM=;
        b=fr3Sam5NlaEJUgjMzAmxAAZ7khXPLyCZ5WgWqmLb2cy8FbZZXRfeZjHDqj+tVcTGuD
         4ifGhZLFZFF28GVsdy2f7jlln13ACOC1ysdtoL/oWzf5OyHLRZP1IJ6BdBRC5BSwyIzP
         sIZ1S+URRgg2L8sPN1HkcUt4Ockf3vNgLBBpoRRxYtskz2BDcupFD8/a7UB8JawVxYbC
         FCBQoZSfYv2uZTfqqVbtGt461JSvUpTNpzca2hEFQWRg36jBPYfSH5Yvkzoo2gu2krxs
         1IIsP5hZk1U8kBL7jAWg/LyzBeLAgA2bLl13gdERxMCB3Hyvr0r/2U2WDCtLbDacSOcH
         KocA==
X-Gm-Message-State: AOJu0YzDcpUfq2Dagc8f8b8TXNyQvX8xIT4TxQDMQvpyH08pr3SaXgR/
	eqP9rTrl1LHNP2sm8/mRf/bBnNkLa8vWtupPeY4=
X-Google-Smtp-Source: AGHT+IEoWRgZqJ+G6h9wGbvC9T6dDQdcsvYzkNkYsl43dVA2QbxwIO70dLG+rRJz0kdc1utrneTkxpXtNhdDtUn6qlE=
X-Received: by 2002:a4a:2542:0:b0:57b:3b64:7ea5 with SMTP id
 v2-20020a4a2542000000b0057b3b647ea5mr12231208ooe.1.1696341937644; Tue, 03 Oct
 2023 07:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169617092924.200640.7431532323074217381.stgit@djiang5-mobl3>
In-Reply-To: <169617092924.200640.7431532323074217381.stgit@djiang5-mobl3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 16:05:26 +0200
Message-ID: <CAJZ5v0hL=qHCJ1a4AAVtUb9RaXjmHSEQQ7sLFrkYHGXdB2jtnw@mail.gmail.com>
Subject: Re: [PATCH] acpi: Add defines for CDAT SSLBIS
To: Dave Jiang <dave.jiang@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 1, 2023 at 4:35=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> wr=
ote:
>
> Add upstream port and any port definition for SSLBIS.
>
> Link: https://github.com/acpica/acpica/pull/898
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> ---
>  include/acpi/actbl1.h |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 8d5572ad48cb..a33375e055ad 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -465,6 +465,9 @@ struct acpi_cdat_sslbe {
>         u16 reserved;
>  };
>
> +#define ACPI_CDAT_SSLBIS_US_PORT       0x0100
> +#define ACPI_CDAT_SSLBIS_ANY_PORT      0xffff
> +
>  /***********************************************************************=
********
>   *
>   * CEDT - CXL Early Discovery Table
>

Applied as 6.7 material, thanks!

