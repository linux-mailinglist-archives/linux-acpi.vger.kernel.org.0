Return-Path: <linux-acpi+bounces-14728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF6AEA5B3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA981C43974
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37162EE965;
	Thu, 26 Jun 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz4EOzjr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B52ED860;
	Thu, 26 Jun 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963668; cv=none; b=PliI4jIjEH4Rvp5+L0lYs5yb4UC5Q1zl0284X9vj2w81ByrrI4albPzPWp/NhcKjw3rxfc387B6OLOmb4Gt59rBSqpHoDWKMJZX8t+CVX91D3pGgDiz+R0yIYAoGIO4oLSHyGe6meqlSbCeuJllWOmupsTjlx+Rb9hiBKyDG25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963668; c=relaxed/simple;
	bh=N4mCm1tvBLKb5vXCcHZdR3eaEqIkHTEsXeAFPKyvTOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM45vQC9xV3Gp8GuTuapwJ8hQjbou9XL5lyyIWnbgqbCaMApPAzz3LIiS3xUox0ClhBaN7NqPFKFGlnZb37CDyTCVKSq8bcdcNYCTAednc8VRc9TRvW0KpWaQZI3Z0sV76gx4vQnlGE8GvTIS/I5o1GKZu+ktqM8Q+ZAHx0n6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz4EOzjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0EDC4CEF6;
	Thu, 26 Jun 2025 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963668;
	bh=N4mCm1tvBLKb5vXCcHZdR3eaEqIkHTEsXeAFPKyvTOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lz4EOzjrWgVsup/8+yEE8b4icxoiXAhvLNzNcduZ//XeSfGabl+NNg75D+LW6sGrg
	 hsXHPAUYoUkQADNtnlPlx7SSvPzTAFzxcWnBd+mK9/nzYSABlcqi9X5iw4Sy1AYdaW
	 Si8fCfJV1GolwR18AJcRVVLhHMRCX1cye8lKYbIeOpbCX0ykHMUkcP5oI3IFxIoJUS
	 IOotqyk2FASVXPqiNJ3Zd0/Kctak3XmUD9vtG6DsQqZNpzE6Ehbprcp5PTOuXz9ZBI
	 0HSP1Auq01NAg6hhlIVk5sir0+4oEviWVnu87dvuQuMlFY9bxcGP/q3SmTWU4fdS8y
	 lRR/CdDbUAEmA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40a4bf1ebb7so854932b6e.0;
        Thu, 26 Jun 2025 11:47:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTDphTFJu+eVcvCA3GM1dpwrpfbAXNrYO7wRGE5Xz3/Whda/i9U3/4o2TVJ7vBVf//SWj2pu1NunQL0Q==@vger.kernel.org, AJvYcCW2oHz9N0+pebYcBI1BlKnkt3+FiqVSkX4G38IhsWaSsMvHRA4KobkY3buEhtH6d3h2ysq4oqR6sENdxIRA@vger.kernel.org, AJvYcCXX4CHkOGd0r3lFS36Iy/YlJe7ETLPatzvbgbt4lMK3PieUq1cQnspD1RYDJobbQlQHFfq5eK2UidFh5Nd/qXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5GwnlVOD4IXNpE+OJvseYD1mpxbDMKDuorradvsD9MPiT0/H
	s/Pnoj2yHHuE1wYIs8rh7LNF3B+gfwQ0O9Y0gNwGzjHcfmByDXwi1mPyD8povwHSLGoKQec1uVY
	XZMKS+SjFjZjD/PVxpkmOml25FPrmBoU=
X-Google-Smtp-Source: AGHT+IHsbppHKJczzqQ4bMJdFOMLmyd/GjP9fapoW3pY62yjeDnFTUCL3ZbkvHyjDx5aIddLRXZ9Ux5mjDXK6q4z1WA=
X-Received: by 2002:a05:6808:23d2:b0:408:e690:7e38 with SMTP id
 5614622812f47-40b33d9c928mr257398b6e.16.1750963667296; Thu, 26 Jun 2025
 11:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae6286cf-4d73-4b97-8c0f-0782a65b8f51@sabinyo.mountain> <685c684533e1c_2c354429441@iweiny-mobl.notmuch>
In-Reply-To: <685c684533e1c_2c354429441@iweiny-mobl.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 20:47:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hdKWCuSeoPt1j4bon=2f=+52t7pLxFULO0TewpEO8ZzQ@mail.gmail.com>
X-Gm-Features: Ac12FXxDhy8WGxmi9b9TEZ_DCO8SCjM2TXJQV1Cr64MPDbR4joicVPExHGPUk7E
Message-ID: <CAJZ5v0hdKWCuSeoPt1j4bon=2f=+52t7pLxFULO0TewpEO8ZzQ@mail.gmail.com>
Subject: Re: [PATCH next] ACPI: APEI: EINJ: prevent memory corruption in error_type_set()
To: Ira Weiny <ira.weiny@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:19=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wr=
ote:
>
> Dan Carpenter wrote:
> > The "einj_buf" buffer is 32 chars.  If "count" is larger than that it
> > results in memory corruption.  Cap it at 31 so that we leave the last
> > character as a NUL terminator.  By the way, the highest reasonable valu=
e
> > for "count" is 24.
> >
> > Fixes: 0c6176e1e186 ("ACPI: APEI: EINJ: Enable the discovery of EINJv2 =
capabilities")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Applied, thanks!

