Return-Path: <linux-acpi+bounces-2176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADF80751C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7DB20E6D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB532E62B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 16:35:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A3D44;
	Wed,  6 Dec 2023 08:31:01 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b86057b5b2so792299b6e.1;
        Wed, 06 Dec 2023 08:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880260; x=1702485060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJxffBaMiQ2oTEKkMXfgMIDNFQA4n7Ds0nLK++uGZow=;
        b=S7wQRZjCAI4ruLlWB99F2wWVg9Cxxq+OW6tJ19VDlzp3wvRo3A3xMR2ky+Is6S888I
         yKDzMmzqjoR70ycHOpsL1Dvbl7LJoQujcLrt4hFlOgNDNam8vSuyiD0L/jxteFShPa7Q
         UniZhkGaOhDayyJzbp3tTCNu973VikF9AlF6cJ3vICnhRRWfjte4BjtxFOePkvRVEmfN
         oMzgiWYuTxgMUROsO+oOVV09Fcdq0kuja7olNqhdd1yllPfA7/zkuttSC6gxK39aMDrN
         vAo2wcFFo0QYBXVU6r6RVcHJUeKU/+Qtd6h/WRrHnAIPPREE6lV6ZkzpfCTbQgnccSoG
         08ZQ==
X-Gm-Message-State: AOJu0YxfGz2umqQWXx3QL7BwuG7b84/+f0RjJiTL4Esxseaa1SYUiLuS
	BwDIqyB9FDqfZDd1IqxgIBTT0LEC8p61gLEMGZM=
X-Google-Smtp-Source: AGHT+IFPGJlxHkYT76B5iGqfPk/xee9F9t18f0t6eHfXFL1yLeB3+9iiJYLslXfNgsbsEfecYAN5wfXvomuyZirJCL8=
X-Received: by 2002:a05:6870:8086:b0:1fb:136e:fa93 with SMTP id
 q6-20020a056870808600b001fb136efa93mr2018209oab.0.1701880260700; Wed, 06 Dec
 2023 08:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 17:30:47 +0100
Message-ID: <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: XSDT: struct acpi_table_xsdt must be packed
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 2:48=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> According to the ACPI 6.5 specification the component Entry starts at
> offset 36 in the XSDT table which is not a multiple of 8. Hence we must
> mark the structure as packed.

There is #pragma pack(1) at the beginning of actbl.h.  Is it not sufficient=
?

> We did not see an error due to the incorrect packing yet as in
> acpi_tb_parse_root_table() we use ACPI_ADD_PTR() to find the address of
> Entry.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/acpi/actbl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> index 451f6276da49..1a37ac378765 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -148,7 +148,7 @@ struct acpi_table_rsdt {
>  struct acpi_table_xsdt {
>         struct acpi_table_header header;        /* Common ACPI table head=
er */
>         u64 table_offset_entry[1];      /* Array of pointers to ACPI tabl=
es */
> -};
> +} __packed;
>
>  #define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
>  #define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
> --
> 2.40.1
>

