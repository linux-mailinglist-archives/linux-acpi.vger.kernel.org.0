Return-Path: <linux-acpi+bounces-12808-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D677CA7EBC8
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0F5188B8E5
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3FE21B19E;
	Mon,  7 Apr 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8lwMuu3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E73213E99;
	Mon,  7 Apr 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050370; cv=none; b=nmEzNY01TXRfKDctGcRiUgSIc/Rl0fpFPv5L489n5QqXlpKr8sY8t88E/uzEFX4f4j+aUD+kaYQgUWUKIBULZe6B4xjtmernL3yduOuwFLIOthS1gsfkKGEttYwxE0XX1pBsPp5LM73pyAyvg9WTykgiFapeB9HzzWmy6PHkz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050370; c=relaxed/simple;
	bh=olO9oaDx1GoQ7ivZvRHmbadSGi3duuSuYlEI+kfpHWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYebq+mHTD0LVk6NfqQG1HY0Jmmg30oeys0bPb1xWW82kmNASPYJ4PSGC59CiJk/KlxAY1Bbn4VfnRKl9R9HTtts4FFenROj7Ft5vvQYi8GVWDcOkrjvLeUB6Yfa+JFfu50OthJPDU7S06kuIPBH0fbPqeuazGP4ea51xs+yk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8lwMuu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65771C4AF09;
	Mon,  7 Apr 2025 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744050369;
	bh=olO9oaDx1GoQ7ivZvRHmbadSGi3duuSuYlEI+kfpHWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M8lwMuu34nsLsCCWFTK9rbkw2g4kW3woTke46HyqCO+DQtr+K97LprLYIaMfkalg/
	 XUBcqm4lzCatPE4MYF+qtNpmlZGmJ30f/xyvYS41c+QFvjKvAdQ+FBN4xHxdpALouP
	 xcbb8/IEJdi1EToGPMcRf07K8LCNbVkPT3qBttfBk9D66rCxghHkOnpa+3vQrYu16D
	 myXNAzMzmqAFrQ8S/8W+V2PL0ZGWsOAfaFH+LXTdOIBCoHZISawwdhF0jqz+wPQDZq
	 8ydNdJyfhRbturDW21kQW6cAKEWBthQ6jiTO7qmM5ussFcEQMtOGD+GhQM7VcP9vKE
	 N6wZPQos2Motg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72b7a53ceb6so2540508a34.0;
        Mon, 07 Apr 2025 11:26:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4T0T1TkqHvqhqcpZzXLheYCBC7jfrZ/mBWAGLpltdvoRKcXkgNlh+ZIsN8EoLdDw4vpcHUTHhcL7TBnvj@vger.kernel.org, AJvYcCW7ymQ2rA0Iimdsnj37mhFapZa1d4VFRLIafnPelXgwbSSSIa4RJYNJYbQpPRWpU4oeM28IcSYmruPt@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcEXhuD6b0eZMxf6PlTm+R+ai2QO8MOvoYx9lGIFEJWOX4TDq
	+J/pLXt95knmavO/7eRjjf3AFeKYIV1ar6qTdFjNiW0qYQJ8xS5PXyMrsR4fzzMZZ5CFSND7F1m
	Lt3zqNDXVIZ6rdPPn7U4TqYwBQAY=
X-Google-Smtp-Source: AGHT+IEcX0VH8ZU90iBSKORw+3GwDPJVmd2pUmn2aWr7n/gmmHIx/FPCgUAwkXtPasuewod5E7ViwdEazon9ShW2Q8I=
X-Received: by 2002:a05:6830:1bf9:b0:72a:b2a:476 with SMTP id
 46e09a7af769-72e64a3d4c3mr308372a34.3.1744050368683; Mon, 07 Apr 2025
 11:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402001542.2600671-1-jmeurin@google.com>
In-Reply-To: <20250402001542.2600671-1-jmeurin@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 20:25:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGjfomEJAJ8c6HwQz9oOqZk+gYfJM4q9XTWy5vHLzoSA@mail.gmail.com>
X-Gm-Features: ATxdqUENPsmh4QE5Zc_Hji6ZwnpQ2pNcLKhBpPJG0jtAYF-R_1YQdpb0-806YBU
Message-ID: <CAJZ5v0gGjfomEJAJ8c6HwQz9oOqZk+gYfJM4q9XTWy5vHLzoSA@mail.gmail.com>
Subject: Re: [PATCH] ACPI PPTT: Fix typos in a couple of sizeof() calls.
To: Jean-Marc Eurin <jmeurin@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 2:15=E2=80=AFAM Jean-Marc Eurin <jmeurin@google.com>=
 wrote:
>
> The end of table checks should be done with the structure size,
> but 2 of the 3 similar calls use the pointer size.
>
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
> ---
>  drivers/acpi/pptt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index a35dd0e41c27..f73ce6e13065 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -229,7 +229,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_head=
er *table_hdr,
>         node_entry =3D ACPI_PTR_DIFF(node, table_hdr);
>         entry =3D ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>                              sizeof(struct acpi_table_pptt));
> -       proc_sz =3D sizeof(struct acpi_pptt_processor *);
> +       proc_sz =3D sizeof(struct acpi_pptt_processor);
>
>         while ((unsigned long)entry + proc_sz < table_end) {
>                 cpu_node =3D (struct acpi_pptt_processor *)entry;
> @@ -270,7 +270,7 @@ static struct acpi_pptt_processor *acpi_find_processo=
r_node(struct acpi_table_he
>         table_end =3D (unsigned long)table_hdr + table_hdr->length;
>         entry =3D ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>                              sizeof(struct acpi_table_pptt));
> -       proc_sz =3D sizeof(struct acpi_pptt_processor *);
> +       proc_sz =3D sizeof(struct acpi_pptt_processor);
>
>         /* find the processor structure associated with this cpuid */
>         while ((unsigned long)entry + proc_sz < table_end) {
> --

Applied as 6.15-rc material with a couple of edits in the subject.

Thanks!

