Return-Path: <linux-acpi+bounces-16045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483ABB34969
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 19:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27EB188A7B2
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6D1DF965;
	Mon, 25 Aug 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+E+Fqam"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C42750E6
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144521; cv=none; b=JYuwYjGCJWFUIkBPliJviIN8HPJZkbiXlaN8kFzez4lQtmVGN8V009ohFpec4qjeokzf2bANTsyZguseMNeXbUzLWAjJQYdIVhJ4sz1/TfXnMLG2OHDqB7+6seHXkdSIqX9dxOpzXTemgEqRabnrQJ7gWicJZC/D5VLSOZLo0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144521; c=relaxed/simple;
	bh=woAvs9PHK6xOgfyjNsiU4NUIjDQuwKh91IoT1/uO2ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfxKL3TX8aZ1OmXgTOOusGAsLQTvkIaJ44Mtn1mNWCjLqJx+hwXpX+ldKrFb2dQ1/dQIPfj4qNt1E0xR+KoR05PD/Kv2bO9jMw2Q2ywQpV4z0RUS0SjF79wNpFONuw7c1rl4YZj/vw0ZTDP7Wt5ao/XdK4X2rPK5S1nwN9ATTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+E+Fqam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61647C4CEED
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144521;
	bh=woAvs9PHK6xOgfyjNsiU4NUIjDQuwKh91IoT1/uO2ec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T+E+FqamqO5CJgDYpQh6tE7Er4orznCraCWEu3iWjztKs1pwMK9mWQMFnrrckDBb8
	 sXZN0Ivh5bRSKXPh2WUvAXaQ0WW6xsK+h9lW1TdIEyCZ72a4kCr7L1lpKRK6Ji4eal
	 GRjI8ChwDrnCiJYI9ur9CKRRbOcH1bKbMDmskySyW3kBZT+poZq3LD9mTBKdeVnzj/
	 y9kXaGsiX5GQgOUgJnjlV6HAHrFuM94VNeXaPKKCHxa4oQBK7FuXdxPK8jhVY0MrnE
	 sE8ymckUl3p4Txn8s7cpohzvytXdOqWx8y9DWea1nCYbYdYm3cpF/n8XaQxBtai2pR
	 LjWTLXeZwVpPA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61d99c87ddcso928772eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 10:55:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXETFUkVIce6gGHXogNRIPjKbG9skX+HmSvhovWOKN6aIK1OGKWP8QK0hIrHpXlFsUK6hJBrNcpZlXL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8zRnVKcwPUWljCWmyFTB5KdzBR2NNPOD8Q+DcM9Zsnu2InUkC
	nCyw0B1l5o/9AMtmVl/NyWbDoIK4kgeRgDUVhbGltCGPA6SepTET1cFEVi7ol7j5BxLi3nw/UdN
	UB+2H/w/dOOJ3kNIDpH7L+JszrGYu4E8=
X-Google-Smtp-Source: AGHT+IGZWuHYZyft0oOxSyVAxn8xr7fDWvqTRxNaHDpzf5N7GQn9n0srBAiZm6VMnMbi0iaRimHLLxLmzINWOQCdGGE=
X-Received: by 2002:a05:6820:16a8:b0:61d:d011:16b5 with SMTP id
 006d021491bc7-61dd0113f43mr3437829eaf.5.1756144520733; Mon, 25 Aug 2025
 10:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819073517.3962847-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250819073517.3962847-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 19:55:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyuOR6gNRnikja84T5MXYtVYbeTX0NmgTnDLF166ObRA@mail.gmail.com>
X-Gm-Features: Ac12FXy6j4jn8XY2coTYnCKDNLzLjz4YHz3stT17ipfLJoPjdjcUU39aiSITJdI
Message-ID: <CAJZ5v0hyuOR6gNRnikja84T5MXYtVYbeTX0NmgTnDLF166ObRA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Fix memory leak in lpi_device_get_constraints()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:36=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add proper cleanup of lpi_constraints_table to prevent memory leaks
> when  the driver is reloaded

Which driver do you mean?

> or lpi_device_get_constraints() is called multiple times.

How exactly?

> The function lpi_device_get_constraints() allocates memory for
> lpi_constraints_table using kcalloc() but never frees any previously
> allocated memory. This leads to a memory leak on subsequent calls to
> the function.

What subsequent calls?

> Fix this by:
> 1. Adding a new helper function lpi_constraints_table_free() that properl=
y
>    frees the allocated memory and resets the table pointer and size
> 2. Calling this cleanup function before allocating new memory in
>    lpi_device_get_constraints()
>
> This ensures that any previously allocated lpi_constraints_table is
> properly freed before allocating a new one, preventing memory leaks.

No, really.

You need to say how exactly the memory is leaked, or there is nothing to fi=
x.

Thanks!

