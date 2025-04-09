Return-Path: <linux-acpi+bounces-12910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073CA82792
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 16:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3466188E939
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E493266573;
	Wed,  9 Apr 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH3swQIe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11126656B;
	Wed,  9 Apr 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208355; cv=none; b=WAtcpxb6Kp/FTLrw2eI9jZ6/sTFwkX040N1h6PVmubigu46Z30QX6DmNXo6F01q92iwcXS/tGsLKF6TXmdH6fLJlo14/VuhpvjpHPuFofUyPavSiP80R5IUwuvOu/Tt5ToDFZxrbLWsOHy+S4TFbZczzVUEE1zkVzvpriSAeNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208355; c=relaxed/simple;
	bh=WUAExWBg52VvAPQl9UyxaRG8WdDaVLGrMNmNzhgS5PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsakY0zvy2Om7ytgFRzcQ25hX36WZOVRpnMnceweZBWCIcl/Onwx2IFNJOOB07ebEvuOKBAD3NkkYdluj/pdrXN2n/7AGb52mfkAmlOTCgCnX/+j3qbzd3aL/S4pde+6RF7HELhUEyKOeI/QeFz3tOQ4BDFgJBg4nkb5VcLClI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH3swQIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53871C4CEE7;
	Wed,  9 Apr 2025 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744208355;
	bh=WUAExWBg52VvAPQl9UyxaRG8WdDaVLGrMNmNzhgS5PY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XH3swQIeQd70CKAY0pMJIPAzjjf7btvGp5qUBJm7og3cvBoDxgcLya4S4JgTuUr7k
	 Xbs4FEP/717o1l8aJLZQ3LwcryppizrkIUqgDy7eljmDsT1ix1N+NReSyRCIG1Ez3s
	 RS1XwT2DlC+g8FHrqAsINZUS+yjJ2UWlxJcf5iG81zWwezSCNmta6a/kUAJfAl5Xnf
	 4hEUE5CPP751dOQsQ/pjpwIGYB5b71oDgn76E1ii6FXL4jUxlLNCfHLKhCNqv+bNul
	 WxuImqkShgSkARrMUongAMFPXnIevHy6A9BbSyHSrJBL/0TTEHx4vf9jZFhPzxiLGk
	 edyTyknbnyeuQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b8e26063e4so3554577fac.3;
        Wed, 09 Apr 2025 07:19:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTaJR3cWJmfTNFl60rB0gMRX8+h7W1sAxGODzHtI2AaJX/BEbqPFcwRdC60HcwlIWDDWGERQK51Alc@vger.kernel.org, AJvYcCUn2HaVZ5AGxFrmg84sMUVxNE+YQbr9AiibCVZxxaTI/dmwdr1yC81/tb0HwtMdATihLTn21dryCf68k2xL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqrpq9XDpl1PScZfDgsX47pF2F2cNhiUJinwNs/0i4ulEcY1v8
	2hPW8F7aSP45/cBKKcYNKtd0SdlvbKBa4YeiSes0ui5VXxxqPoMSI0oBMwuHxzfc2g6Uugt9URK
	LUMvw1cK2UfHeUaqRP8C43qb6+SY=
X-Google-Smtp-Source: AGHT+IETfdBpHlemMJcv4WlmYJQXFpjsfctR3zAxwL9X91TdsjCUXyKe0ykqipfCSCqRYB/k6NrsAHZUW6pvS0eOUdQ=
X-Received: by 2002:a05:6871:a901:b0:2a3:8331:717c with SMTP id
 586e51a60fabf-2d08dd68e43mr1836129fac.10.1744208354650; Wed, 09 Apr 2025
 07:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 16:19:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ib46bqNkJ9em9GKbUhJpCOjDqgLOyDQmqO1n8LMWJpyQ@mail.gmail.com>
X-Gm-Features: ATxdqUHBrltNfjee2tvUCdFbd-PgfsfnuoOEH2mj0rtgkxS5-X_o4jJyzXmnKdI
Message-ID: <CAJZ5v0ib46bqNkJ9em9GKbUhJpCOjDqgLOyDQmqO1n8LMWJpyQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add a note to the fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 6:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Add a note to the fwnode.h that the header should not be used
> directly in the leaf drivers, they all should use the higher
> level APIs and the respective headers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/fwnode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 6fa0a268d538..da537c7c30dc 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -2,6 +2,12 @@
>  /*
>   * fwnode.h - Firmware device node object handle type definition.
>   *
> + * Note, this header is not meant to be used by the leaf drivers.
> + * It provides the low level data types and definitions for the firmware
> + * and device property providers. The respective API headers should
> + * guarantee all the required data types and definitions without includi=
ng
> + * this header directly.
> + *
>   * Copyright (C) 2015, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
> --
> 2.47.2
>
>

