Return-Path: <linux-acpi+bounces-5656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4D8BFBC5
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 13:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B721F22C2A
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48382877;
	Wed,  8 May 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XnrQWGaa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4CE824BF
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167158; cv=none; b=VyKbdrSX1OzktqvRgiidUzIKcqEQGT9MIPSSCN0JxrDqC/UfJbeTzel/HOFAH6FMnsJZJYwrNRm6gPn5CoGZt9FJjIe56IRTimaAruAzClHKKJidhaxgi4L1B5XKY3VMKMSBFZP4+KhbKwpXCAfsVL+7UaSFQX5iuD4WxxEiRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167158; c=relaxed/simple;
	bh=lx+9Xgjt8qYgmhILpcyWB1vEDTF6K3IN0xYImBlQY5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQb9D6xTJ1co/6uVlIL82LhVLUfl5kf5SWzzQMEtXB2c1u0OQowTdpAMnr61X5yke1DbwbqZ8gaF9nBeKKl6dKJhuVGgzu2XJg+FQqvmJXo0q0r9Y9Tjxcvd0ZfPsRern47Y4U7XNS8uG9pIVg5mvqrBLdBmpi2jlXpZ/z/ZfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XnrQWGaa; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23e94f0788aso2158493fac.2
        for <linux-acpi@vger.kernel.org>; Wed, 08 May 2024 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715167152; x=1715771952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx+9Xgjt8qYgmhILpcyWB1vEDTF6K3IN0xYImBlQY5U=;
        b=XnrQWGaaiN/Jj5WIv2YisHfx21btj2BHsrRbWMz8NcyUfMUYFhbpZWOl67FzUCQiJe
         HQZU8hdvQcZW6DrtIhcPUYRTrfy/GFrfmYCbX9VmkkH8oeir8uLWPb3Ax1+HMQIRRdoz
         +BCyxTpxcpAV7rUNwFE4OfvlfvK/0AeUIlqbsTRbpSlPxwu48hfjALubelTSjgSGDjfu
         hgve/46ujOFIBATvuBrOP65z8wzYh2KGDkLHBiQMOXMQxAsWrOpAIzjpNnsb+IPallok
         jkrP4wFps9w4ddsj+z0IzpuAGVPiBl5IM8tHJEHzeobawMB5V1+P5RsHqsp4C/OC7Piy
         UwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167152; x=1715771952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx+9Xgjt8qYgmhILpcyWB1vEDTF6K3IN0xYImBlQY5U=;
        b=F9egRi9nmCeGtTu0BUfQTY3+/TuCCcfVyqvcr+KEpJ1JeoMBha47v1tdhfN/GjY4Uv
         N2eAkclCuzj8uDX0cvXJv1GrzVLGnj+JFm3fo/jAjqjec4JNanI1f71kG3C6fC74cy5L
         t/mMwiK1fPcvB1gR31j2GEQQDVWmXsQU6IyxwESulGi7EokAXvxVbor3lZxAflk2PWkA
         Q50Ys9AwBZJtqXs2o51FrvUEwG7F2BohySqXkwfD6G+1EbnsJVzD2o/iG8+cVNwbYbTn
         gY6mMMGbo+NBA5S6cDwwSANgv1e8zvQtTSnXd7rfC/fZwdiZ2lD1haO3zJxWBGvjmdf5
         EoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSOQ2rcnb2txqWeUA1w35XUCt49NWN/Ug3c4icJVl5wmDU96wZWYW0wkS7lOt58MsREmHsijWF+w9QRAgnMRua5QgBmH7VNT1PZw==
X-Gm-Message-State: AOJu0YyYSmkVQIe6HTfoobuBVEpBF+2DZOcXSJ75nML9iHbedGOdtd06
	R+m3yecNjGEXjkR7uevW7Jko3I2WhiFTg5fGC+9mC3+s56qeFfhTk5tEp3LulSlLveZpiu1Uyk9
	QKqoHlB1oC8DYq+W1IMZo2NbkndA+NxNVyf824Q==
X-Google-Smtp-Source: AGHT+IF3+5FujeR3kO7PsOpHF+5mMBxLYw8Z1NzywDpU6OEN5QBCAec77PNwgwaACUPo4GNnUyl3QXQ0Gu3mZ2LA98k=
X-Received: by 2002:a05:6870:c155:b0:23d:45cd:ee66 with SMTP id
 586e51a60fabf-240992d1c8bmr2486931fac.55.1715167152059; Wed, 08 May 2024
 04:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <20240502-herald-catty-a03eafc4e6b1@spud>
In-Reply-To: <20240502-herald-catty-a03eafc4e6b1@spud>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 8 May 2024 19:19:01 +0800
Message-ID: <CAEEQ3wnthxGbrJ_qLnZUQ9w3E_1UWgMign5P=+rNP2p5xGm4Bg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Conor Dooley <conor@kernel.org>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Gentle ping...

On Fri, May 3, 2024 at 12:37=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
> > Before cacheinfo can be built correctly, we need to initialize level
> > and type. Since RSIC-V currently does not have a register group that
> > describes cache-related attributes like ARM64, we cannot obtain them
> > directly, so now we obtain cache leaves from the ACPI PPTT table
> > (acpi_get_cache_info()) and set the cache type through split_levels.
> >
> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> : Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> I'm not an ACPI head, so whether or not the table is valid on RISC-V or
> w/e I do not know, but the code here looks sane to me, so

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.

Thanks,
Yunhui

