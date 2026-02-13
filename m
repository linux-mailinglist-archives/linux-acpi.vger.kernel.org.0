Return-Path: <linux-acpi+bounces-20977-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF/pGqInj2kvKgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20977-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 14:31:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76E13664E
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 14:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA0FF300BE1F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3DD35B628;
	Fri, 13 Feb 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWESlMen"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889B3570BA
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770989469; cv=none; b=FVv4B3zD3/wkbhRucTjt9E9akaNeIwFjBhoClFTtnMKhrQIVMB+MkMO7hF3N8nn9pKUVKKK8hz5Tx2KrYgS7HtdpBOrsBxM6t9irZS9atAMEAsWqPqmlw3jEuI4HXdL6vTPH6keCUcaGoirOJU/PmJ4VIwUGEBHSILc3znZT+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770989469; c=relaxed/simple;
	bh=wqMmN4tHpz1pEvJQ7qQAWgMQEiExFl/FmqHIqMMAv1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXPjP4LHkTrmLuWlKWcn73zPG0dI5q8/SuhvZkMl/n6u4skXNoDuPZMGhbh/CEuHsRFzxKRFP+LCqTBCnsauBZpKQs2k1ywZw5mW/Gt4AQfGtgHaVn+ZgV08345pt3c0TNGxvAlrBytulJcwhsU4VcV6NaVJ9DzddWrMxXFoRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWESlMen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F19C116C6
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770989468;
	bh=wqMmN4tHpz1pEvJQ7qQAWgMQEiExFl/FmqHIqMMAv1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cWESlMen9fVb4AvWPK7VJ57T/7/6qiXuxlwSALRno1yWlKjT1UDCV6zLE4PEUVwb9
	 G9zzz1I2RdDQXL7S8zvLRgZWL5B7WlbBsZlsjw2qjmUuKJjZirqu05nCb1IPbdF00G
	 MIUJ6SqDi55jQnZVrO/ahJllQq7lXFr3PdfScA/tYUAMC10ad8ny51INsLqhMT5cXL
	 SZdqSYZnN8XPNCqBNU07rqgJqJvJJUF7SCqFUSRclj63DNxlW7wuXOoMvFaGwbO1o/
	 vcSvckMJ0SX89h/ZOijRcpWFRWBdvkjW37GMCefCO9Vgp+2O47tzf04r380Pdo3KkD
	 Q1mX7/UDaze0g==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-404254ffe8aso651910fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 05:31:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBhvHd3IBEu9nUHzdt0dqrJFO4SJvUBnc6xV8PiP5P44QCkllsTh8WD4vV1OHusu0w9tEk1afvibBc@vger.kernel.org
X-Gm-Message-State: AOJu0YymRoCQFVnkR5CWgXZXOaLfuhKHB60HH5bduEftGcMClpp50ivj
	wrlWaQaH0v3SWM+hBcbl8GV6cJTUEAlGfRYeKEdWJs+Mj3BirSn9cW/8vDHRx02SI5ErGPSEDxy
	IpE4C7LZn/4DBUjM56EbgjJQL970D3d0=
X-Received: by 2002:a05:6870:90d4:b0:3ff:48b3:30b7 with SMTP id
 586e51a60fabf-40f08aafd87mr58113fac.29.1770989467080; Fri, 13 Feb 2026
 05:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201181620.4964-1-sumeet4linux@gmail.com>
In-Reply-To: <20260201181620.4964-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Feb 2026 14:30:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_tOvLwUEkVTrcOVepFZkObRJAkgtQgjSRnfocuqFSAQ@mail.gmail.com>
X-Gm-Features: AZwV_QgnOmfGN8b-Gky2JP6yU3bWbjRmJbUS3kFSnyN3xzPtwj87PGy-uf9dMlM
Message-ID: <CAJZ5v0h_tOvLwUEkVTrcOVepFZkObRJAkgtQgjSRnfocuqFSAQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power/acpi: Replace strcpy/strcat with snprintf in osunixdir.c
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20977-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8E76E13664E
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 7:17=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail.=
com> wrote:
>
> Replace unsafe strcpy() and strcat() calls with snprintf() in
> osunixdir.c to prevent potential buffer overflow vulnerabilities
> when constructing file paths.
>
> The snprintf() function performs automatic bounds checking to ensure
> the destination buffer is not overflowed.
>
> No functional change.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>

The ACPI tools come from ACPICA, so if you want to make changes to
them, you need to do that in upstream ACPICA.

Refer to Documentation/driver-api/acpi/linuxized-acpica.rst for more
information.

Thanks!

> ---
>  .../power/acpi/os_specific/service_layers/osunixdir.c  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/to=
ols/power/acpi/os_specific/service_layers/osunixdir.c
> index b9bb83116549..5dc960c6b376 100644
> --- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
> +++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
> @@ -113,9 +113,8 @@ char *acpi_os_get_next_filename(void *dir_handle)
>                                 return (NULL);
>                         }
>
> -                       strcpy(temp_str, external_info->dir_pathname);
> -                       strcat(temp_str, "/");
> -                       strcat(temp_str, dir_entry->d_name);
> +                       snprintf(temp_str, str_len, "%s/%s",
> +                                external_info->dir_pathname, dir_entry->=
d_name);
>
>                         err =3D stat(temp_str, &temp_stat);
>                         if (err =3D=3D -1) {
> @@ -137,8 +136,9 @@ char *acpi_os_get_next_filename(void *dir_handle)
>
>                                 /* copy to a temp buffer because dir_entr=
y struct is on the stack */
>
> -                               strcpy(external_info->temp_buffer,
> -                                      dir_entry->d_name);
> +                               snprintf(external_info->temp_buffer,
> +                                        sizeof(external_info->temp_buffe=
r),
> +                                        "%s", dir_entry->d_name);
>                                 return (external_info->temp_buffer);
>                         }
>                 }
> --
> 2.43.0
>
>

