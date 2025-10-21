Return-Path: <linux-acpi+bounces-18036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97771BF6D28
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 15:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B20BC4FAF30
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E9337BBF;
	Tue, 21 Oct 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S18DavwY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2756337B9A
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053723; cv=none; b=axCgbvFwvOZH28NO2/hvMNPoxhyNXAoNbwq5iGHIBaKAxQu7x5DqkN4ECtyNNWDQhexmbdgg1+LahjwLdOzgv2SoewecbouicHQlRGrmi+IFSABTDC78bF99q1jC9rqAgOiogFAW4FiywakvOL9SaygG9jy0tHOXa0tICvhdu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053723; c=relaxed/simple;
	bh=ZuqBsIVbt1VZeH9Nd3+eLrJ3RNjtyUBnOrvCECRWIMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTIDvwolDl+87ZxTOKzh/pFxouyfxSviXBPLjA0dJFVU+ZOXOTBKAtDTQsPeEAbWmE3ugTQYhtxDxBU3JoGeJj51jsn6Oml4RLOHY6JVfiT5yoknmYzqZWKtRBr/woHSbgnta21e0/PMiHs44gth/u2yDvFpjCq5ciV708zJ7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S18DavwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40038C4CEFF
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053723;
	bh=ZuqBsIVbt1VZeH9Nd3+eLrJ3RNjtyUBnOrvCECRWIMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S18DavwYbzRxUahcWRpwvrAe0zB/UyjTqme1jX6ivlUDXe9QF0MKnRpZNlzcuUyr8
	 qP5MgWy12F+Rs9j7/aCAn6IFq9dZJl3do1D5zUf4WGRirGdJX9e52/ghZzazGqgLq8
	 jltEEgMXbsleqCDk34o9aZkyOzhqHH5ihgj2Ag5zKitF1ewMcY0HKzIRV0L+UQBVqm
	 92UaqEccm542WIRtl/tiJOy6cjSQyveypKBIyuOGWuZm4fA2jWKGnilpLEmqBs7Xmo
	 lPOeXhXZEwXbADA8Pt1oU6PNsQ3Ei09bw7u1q+Wq9LxPo5DNaN9tkIR6oFASPG7Mob
	 KEPxeFT7w9bQw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-443ac891210so2304931b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 06:35:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7oA5t0MkMPNrfQv8QTTnkmlW4B9+P4IlLFxUmflR2t2vJDY5x/bPFi6W2U/FlrxLmskfOvfmlLu9M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZGiV4qMEjHzbAml25Q/F+MVUtMZ9rH7JNIKODaqxdZPA/lCd
	TQzZz1OV5zqVYxTRJyjHkfPVzayseavx6o29Osi87l5zKtW04if7Mv6nco/fhKje17Q4DM48UCQ
	kMi6t0qPYt/Wl7Wy7Fkp9TtdcbHLn2nA=
X-Google-Smtp-Source: AGHT+IEKKO8UIzncbp3yZO81oyf6QsCEy/ZN7tr85jZ4pwoPxanGyvexPT/O4C5oiumqVgjKTnBwE1h32ENYeNiUZgM=
X-Received: by 2002:a05:6808:444b:b0:441:8f74:f1a with SMTP id
 5614622812f47-443a315b372mr7649786b6e.52.1761053722613; Tue, 21 Oct 2025
 06:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021092825.822007-1-xry111@xry111.site>
In-Reply-To: <20251021092825.822007-1-xry111@xry111.site>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 15:35:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iy8wChaPYGmc=mWJRrA+uXnGF2Ar7aMCMRoUqS6877aQ@mail.gmail.com>
X-Gm-Features: AS18NWA8xXgTYvIuPvaLuEdFpvBPRx9_4TgORXKHv2p-jVKPnls01cOnTQbgH10
Message-ID: <CAJZ5v0iy8wChaPYGmc=mWJRrA+uXnGF2Ar7aMCMRoUqS6877aQ@mail.gmail.com>
Subject: Re: [PATCH] acpica: Work around bogus -Wstringop-overread warning
 since GCC 11
To: Xi Ruoyao <xry111@xry111.site>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org, 
	Saket Dumbre <saket.dumbre@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <linux-acpi@vger.kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:28=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> When ACPI_MISALIGNMENT_NOT_SUPPORTED, GCC can produce a bogus
> -Wstringop-overread warning, see https://gcc.gnu.org/PR122073.
>
> To me it's very clear that we have a compiler bug here, thus just
> disable the warning.
>
> Cc: stable@vger.kernel.org
> Fixes: a9d13433fe17 ("LoongArch: Align ACPI structures if ARCH_STRICT_ALI=
GN enabled")
> Link: https://lore.kernel.org/all/899f2dec-e8b9-44f4-ab8d-001e160a2aed@ro=
eck-us.net/
> Link: https://github.com/acpica/acpica/commit/abf5b573
> Co-developed-by: Saket Dumbre <saket.dumbre@intel.com>
> Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>

Please submit ACPICA changes to the upstream ACPICA project on GitHub
as pull requests (PRs).  After a given PR has been merged upstream, a
corresponding Linux patch can be submitted with a Link: tag pointing
to the upstream commit, but note that upstream ACPICA material is
automatically transferred to Linux, so it should not be necessary to
do so unless timing is important.

> ---
>  drivers/acpi/acpica/tbprint.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.=
c
> index 049f6c2f1e32..e5631027f7f1 100644
> --- a/drivers/acpi/acpica/tbprint.c
> +++ b/drivers/acpi/acpica/tbprint.c
> @@ -95,6 +95,11 @@ acpi_tb_print_table_header(acpi_physical_address addre=
ss,
>  {
>         struct acpi_table_header local_header;
>
> +#pragma GCC diagnostic push
> +#if defined(__GNUC__) && __GNUC__ >=3D 11
> +#pragma GCC diagnostic ignored "-Wstringop-overread"
> +#endif
> +
>         if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
>
>                 /* FACS only has signature and length fields */
> @@ -143,4 +148,5 @@ acpi_tb_print_table_header(acpi_physical_address addr=
ess,
>                            local_header.asl_compiler_id,
>                            local_header.asl_compiler_revision));
>         }
> +#pragma GCC diagnostic pop
>  }
> --
> 2.51.1
>

