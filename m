Return-Path: <linux-acpi+bounces-10035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61B9EB95D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8755188A0F4
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FF19E97A;
	Tue, 10 Dec 2024 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAmDTS/g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB6195FEF;
	Tue, 10 Dec 2024 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855502; cv=none; b=iCKS4ZqPk8qosMRQjIltgVjhd03gUoWAzvq82Bwu2Q0X7kicQbGB5gn1/DNq926ZGx+H48bCznVd7P1oB56Pl2dF8wG3NLzC5ZI+jsQP3Xe3cSqAEVS+yqSjVEYLnqmrQ8b371q88Qym4cOkV00IPCGYrflOMkiUtIcgWL6a2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855502; c=relaxed/simple;
	bh=yMvDfYdMEC2GbNStQaUd8LmXaxCMcS26AvjUFzyncLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSMg1OeMHxKsijohOunzGJXsVD7Eh7/i6X3dbBB83CzKJG15yfqnAu43GlJgPhnh0Qt3VuAD2zX77Rlx3AeF7K5/Q/kJhQIIKl7pvH4haLE0sfDkaDxI1rYXoUMC9/BVlo5JRubpQFFThTSOiaau6NrFIcWVZyX001F9H58CiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAmDTS/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7542CC4AF09;
	Tue, 10 Dec 2024 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855502;
	bh=yMvDfYdMEC2GbNStQaUd8LmXaxCMcS26AvjUFzyncLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JAmDTS/gP3xwYtvGgG1Cp1ESfgypsbHpM7wf9vOebwtU3sQlgywaQe9Eydz61g/l8
	 onyY4yRQ/4TAnTDfJeAAeYvVM2qNn4M8848djWKF5QYvQCnIf05xP8aqLaE4RjNYom
	 T1VdNMigonKpuU7IbPAE9N3c7/vZf2wSEvUZKvN4SgqNenbR4d05am1+ia/YDD3u0T
	 zmtyquH4/8rR0eDQFCN5ufdXZ5PP9tfDgkzmEjM+jBxBMCCXPjMlP/ooJydlycfrDZ
	 7cils4KX1ltw97zK42IkfYUANMs+t2a1syYOOWYR8hmqhXZNpMfySg+K7BmIe1fgbt
	 YaWZFjPWo/zHQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f2ace8a94aso796496eaf.0;
        Tue, 10 Dec 2024 10:31:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgS7zHMWtI5XOLiN/BsKPQigqPSjMb+niDXII72Droa/9gIn4LIAGamVcx6texLIdVNR65YLadgv1Ez3k=@vger.kernel.org, AJvYcCV9tzQiL/Slgi0SXcDkklFZyEq/9ViNgqNf1KOkkwjA0VALouggChBrnRCMarpwuIqwBEnWhWzMxgiH@vger.kernel.org, AJvYcCVX1BNm6ekRR4AaFr9sN6GN/QWrQTmxiuks6qCJoyxv/RwfVo0ZCwCrv6siROYVly9/gjh86Ej/+H9yl3F0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hOPdsvvOKxFbGYrJ+WVGhgBYZV8x2OiOltU5dDIzXTJ/b8xq
	plt8nq7Rc8EUgbIZAFr3/Ml1gkN5LOrDSZr6Rc0VfTPaveuMUCvTEqBw5UeUN541gMgAA9lJ327
	6BN4eHARUSNGsCLb1rsb1PPZfFYY=
X-Google-Smtp-Source: AGHT+IGrUjOmExbcetYeztZRi2yn7rV87vBJKoza5mnnu0jBPpeX3+Ebs1lT+UBA4sTBULYeIhZEaTbL6G8LbS4Zado=
X-Received: by 2002:a05:6820:3101:b0:5ee:ebcb:e701 with SMTP id
 006d021491bc7-5f2c8eb83f6mr3635752eaf.6.1733855501744; Tue, 10 Dec 2024
 10:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org> <20241122-fix-ipu-v2-3-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-3-bba65856e9ff@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:31:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
Message-ID: <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 10:48=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.=
org> wrote:
>
> Provide an implementation of acpi_get_physical_device_location that can
> be used when CONFIG_ACPI is not set.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/acpi/acpi_bus.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index eaafca41cf02..4888231422ea 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -43,9 +43,6 @@ acpi_status
>  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
>                   struct acpi_buffer *status_buf);
>
> -acpi_status
> -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_in=
fo **pld);
> -
>  bool acpi_has_method(acpi_handle handle, char *name);
>  acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
>                                        u64 arg);
> @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *g=
uid, u64 rev, u64 funcs);
>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *g=
uid,
>                         u64 rev, u64 func, union acpi_object *argv4);
>  #ifdef CONFIG_ACPI
> +acpi_status
> +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_in=
fo **pld);
> +
>  static inline union acpi_object *
>  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>                         u64 func, union acpi_object *argv4,
> @@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *bu=
s) { return 0; }
>
>  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
>
> +#define acpi_get_physical_device_location(handle, pld) (AE_ERROR)

This is a function, so static inline please.

Analogously in patches [4,6/7].

And you can merge patches [2-6/7] together into one patch, as far as
I'm concerned.

> +
>  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                   \
>         for (adev =3D NULL; false && (hid) && (uid) && (hrv);)
>
>
> --

