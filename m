Return-Path: <linux-acpi+bounces-12918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EFA82B65
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591D88A1F5D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64D267733;
	Wed,  9 Apr 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOtWYNjU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AB267391;
	Wed,  9 Apr 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213448; cv=none; b=nBzMaALRB1i4JC7A5SrKxTTSMTZNjCncZx+t/jil3STqkvW5nwFpU3h0viqrpT/SqyX4Krx4eWdDquaxLudbSUMxgeUb63J8PoYqBgZ1srLnLlWIXLV0R+wpoT21nh0dHHI+EV83fksLNMEBepg21dR5oWuTEK3Eatt8oIbRHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213448; c=relaxed/simple;
	bh=kQ3wQbDc5JG8OPCU1O+OK2OQX1ChfBc/gTmkkY4bph4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzY4xD1axgIYmGqcG8nafFzASkknqIo4xTuajyMiH577qLCfSfTvUXiFtjKhVHhugRvcIOBKINcQJVvCD66CV5QOLY2npxfG0xquT3jXZ11b/JDDkdtjEpmL4m4fx6BYnPXhIcjOv4wAajXMgw7r0Vq6qHbl+I6lJoTU35WryzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOtWYNjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE103C4CEED;
	Wed,  9 Apr 2025 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744213447;
	bh=kQ3wQbDc5JG8OPCU1O+OK2OQX1ChfBc/gTmkkY4bph4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GOtWYNjU9qgGUVnhlZSmjEMHqguhWbytJh3KvbxYJTguz9WB9BqPr0kaFp4u8cAGH
	 4xxUgz+U8Up5Tj6NQDM2h1EIE8eEraqSP+HCfvBGTfeiNTlz5H4j1haLUdNqKb5RlS
	 pK6BbqCIFO6RCGg/42GkrNBt2kiuHrpPrxNpDYemzxJf0qgBr9czn15U4kIVbEZcWs
	 XB8t/dal1w1T6Q1EUJfq7LoWFc0+s05Ber7Cr4LLYIgf44dIkMkEO5ITndOM9FHlMc
	 B+LlBm8IFdHWVW3wLPuC4Z+k3cj6PISmB7XqHBUHCfl5v+BsbZsDAh2Q92+ZjnLx3j
	 FSW5EHhQt6Liw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so520224fac.0;
        Wed, 09 Apr 2025 08:44:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA0uePchl8cz1aJfkdqCVPydw3qJoNz+aWP+vsDK9W/+GbXDQ4MdrxZwz5296nuNQNMM7lQaN51AV1@vger.kernel.org, AJvYcCVbo/M27auRpStwDv9HfRLX/VkjqGk61o4hlZL4wkn1U0VqG31+1r46AM+d9uqxClIyqgO9T7Yc97BQy0iA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TPt2nvF0PxSRIrmsYyLba7OM2xfFGJMWfqSqL/g07LzPPjwZ
	OF9DifgH4QYqGwjm53gZ7pQGTGwQTU6cxW7L8Kh7Icm3fEcCjTJ6vMM0liDKsmYtqd5XSKoIwnv
	IrpEk0vs+J08oAoFzTbUk1TphAwQ=
X-Google-Smtp-Source: AGHT+IEbyKNkwTkeJilgJrYKJ1+pd9kSKTiAjzZqlGFQD9zhLC2ME4zvpVkHk63vpGujcPfKcuSlJTnX6BNJCRy2v8Y=
X-Received: by 2002:a05:6871:62c1:b0:2bd:2ff2:95b0 with SMTP id
 586e51a60fabf-2d08df2ebcamr1961246fac.12.1744213447226; Wed, 09 Apr 2025
 08:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408095229.1298005-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250408095229.1298005-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 17:43:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8amXrhPzBR2WuuDpZhKLyODjMMm681ohXys_K9mpV=A@mail.gmail.com>
X-Gm-Features: ATxdqUGHj_5AxMCPv7V2YOia2x645h1AlcJv3emQa0Rsf_u8yWFhiEA_lr7vZ3E
Message-ID: <CAJZ5v0g8amXrhPzBR2WuuDpZhKLyODjMMm681ohXys_K9mpV=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] device property: Add a note to the fwnode.h
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

On Tue, Apr 8, 2025 at 11:52=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Add a note to the fwnode.h that the header should not be used
> directly in the leaf drivers, they all should use the higher
> level APIs and the respective headers.
>
> The purpose of this note is to give guidance to driver writers
> to avoid repeating a common mistake.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> v3: reworded the note, added problem statement into commit message (Rafae=
l)
> v2: added "...into the driver" piece at the end to remove ambiguity
>
>  include/linux/fwnode.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 87b183595ba1..900ecd8f45a1 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -2,6 +2,11 @@
>  /*
>   * fwnode.h - Firmware device node object handle type definition.
>   *
> + * This header file provides low-level data types and definitions for fi=
rmware
> + * and device property providers. The respective API header files suppli=
ed by
> + * them should contain all of the requisite data types and definitions f=
or end
> + * users, so including it directly should not be necessary.
> + *
>   * Copyright (C) 2015, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
> --
> 2.47.2
>

