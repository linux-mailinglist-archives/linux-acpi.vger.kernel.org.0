Return-Path: <linux-acpi+bounces-12807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A0A7EB4A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 20:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0207A3583
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E784277026;
	Mon,  7 Apr 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjoMQOEa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3E277006;
	Mon,  7 Apr 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049851; cv=none; b=orn3z9vo1dDRyGKkGloIaQVl4Xs31w1lV3d9OrFJ/v9+uqbzZmJRJON5keb6yrbSMXTXWdiE+z/eRa/usVTZfmYhhGohwSk3uL1aaHRltgQnl4hYD1v1W7vWS7nvLmtTyII6AL9XjQIN3vg1S+szt76pohFlBJXJl6Hv7qsqDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049851; c=relaxed/simple;
	bh=73k/0BVysXl85xBXV2b3hE1PzEdgiYsKHfcYo5esxL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQ/ZbdWbKuEcXXcVkdUw/ZHMgs90PacpIWil0yPsYbNCCcAwr648gg85oZhpSAlAyQvRvrCgwYFtZfITtFEwe2owI34XogFbbDW+LEU8HzYLJCG9uKSoSluJXXST4geTrb/4gcl1DlGeWNLLYcQTb4tbVs/45d2Ca12hT4FwPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjoMQOEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78793C4CEED;
	Mon,  7 Apr 2025 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049849;
	bh=73k/0BVysXl85xBXV2b3hE1PzEdgiYsKHfcYo5esxL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FjoMQOEaRJFMQew/UUTFr2hKYDO6hv9g7+V3MPFy4GRbB+KyPzDtsQWqb0ld8BikB
	 y4LOg5TQyvYkQ8DJEbOPLLHoNeXgNkaPA0XwvhaLhVigaC6TXI8n8dn2M/PqeuGdHA
	 Xptdo1g80NJBvl9UvVJB59gIpvH0zApI2/kIxk67R88d6xbXktWgXPN+0bBAFkg4aD
	 MwIM52NSOjHFBfQnFLQNpvkhhVV5/4onKM0L4oziKs1qU03odqFfrlgJ5v4KfkckJL
	 UEhEhThzNlSVLUJ9c9Q6bYL7LZdoxwaggU3+38Zb3VLBN0h+MI7vRA0LDmCsLGwzNJ
	 jSLIy7VvcmllQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2b2b6019a74so2383896fac.0;
        Mon, 07 Apr 2025 11:17:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwH2S+Wq0m6hVmuZKgXvg7ZQOmcuaGcwDYkh5tmpEcB0KYir28z+Y37wcFUGkjy6OX90K3bFWaiMSz06Hb@vger.kernel.org, AJvYcCXtkojFCJsejYO43bZheHnLugFWjgvfHRX6G3HFn/9bbXACh7ffN8iuF09IpienUeqWayE+RhXNwqkd@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjds19HVLhAMTsVOyel4EXN/CRqClmpDpk4ta7D3puqdO0Tv4
	+dq4odWBBA2B0f72X0gy/oGWfMwRgcQxGoique570Qbsp4jM1cNYruFRx9wu/sIeRDe5E+VKAEP
	f36iymT4gkvrUx9p4Fdo92Yw4kfs=
X-Google-Smtp-Source: AGHT+IHb7HQkxQkd/RpdZWzCI+chrPYGzOX2Ou3UAUShksSZYvBwUdp6Xd5oT0itTCl6KmJPHoPBw1Y1/y2y6HBpHOY=
X-Received: by 2002:a05:6871:2012:b0:2b8:e4b9:47a3 with SMTP id
 586e51a60fabf-2cca19bec51mr7257158fac.22.1744049848789; Mon, 07 Apr 2025
 11:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 20:17:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcbnWA4Whyn-x7uaqEbPow9Sqa3_GO4Z_cBcpYLcF3RQ@mail.gmail.com>
X-Gm-Features: ATxdqUH4SH0U0ivnL3XXp1HsH_vqZucars30DOB9bNLycYszvuikvDD20zwIRSY
Message-ID: <CAJZ5v0gcbnWA4Whyn-x7uaqEbPow9Sqa3_GO4Z_cBcpYLcF3RQ@mail.gmail.com>
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

This sounds like a solution to a problem, but the problem statement is miss=
ing.

What's your motivation?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

