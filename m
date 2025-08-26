Return-Path: <linux-acpi+bounces-16064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A67B352F7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 07:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CFB3A86F0
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 05:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E82877F0;
	Tue, 26 Aug 2025 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSlrG51b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1653235354
	for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2025 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184790; cv=none; b=XtbGuq4ARW6r0Tgau/uGjjB40f0Q7NBtxFo/xzhsRu4Vq0Zo7cZzEyPNm0zFQ6N8GsLwcC8Q2lS00I5ftSfgynr68OTrJpi52RyO9F9jIokoLbBQqXef+uZLdS54+sE6b+ITmlSKSLRM09N6Vjy3kgTf6foHbIH9c5t5UACl5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184790; c=relaxed/simple;
	bh=nlQWCSJIJEu0p+tCx/l5lGjuFZnb+5tzp+OQ0Czvs6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOkItvd9+vx8VdcRm82SYri6njJ5+o/Z/d66cV8w9WlIh+rPtVal5afvUzpV44YJcpvXmw5HAe+03/tC82mI+cXnsTwlnyblrVjW8lpyOxlBMQGQqExwwRde9uCHEDlx08gklNg2VknEYxxQ+H09MJfxBMMCuXQKxSthAOy/gow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSlrG51b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459fc675d11so35885e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756184787; x=1756789587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBscu6xfd05cYLGhLPKrLhfm86OpjLGxIGMcg2vbw0g=;
        b=zSlrG51btSes7EmXbz/yDAljqjQGySzbShxa13mCPeWZWnlIOXVd1WZoi+FmqFK6HA
         xaz3RxGXpTDOcHbSeTcsnUGpNBlga1ZpkBNSViWyHaW0whWRw+/DTRLBdfgr3wyAbl+y
         qP3h8M9YQcRa26EMKk++hpRgC5wTajxnI6saTxmQX6ckTL9DNswf/iAgSgaVeL0WE1yK
         aXoKHkpdPvbtvUFRpMrNS2Ih/9JiRJr1iGIeJnEH6RETB8U/0QQ5OBRIGxUVl/MxyW8q
         mqkans4HpHWtF9BbB7CWAd311v6dOb+FS9DSizyviqHDy3JVgyRpCbnsVkMC5p3tgg9s
         xU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756184787; x=1756789587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBscu6xfd05cYLGhLPKrLhfm86OpjLGxIGMcg2vbw0g=;
        b=r78U0Lq32inIHy4ZCm4oTKd3KWn9Zf2xyJc8ZUwgTny5BS8e8tHvZYsc6IrKPdc68A
         T6UCWPJxMetAIO0TjI/Lue8Gr0pX0HH0BO7H9ABhUFbS3WvSFqi0B6+dgvtFUtdoiWdD
         BZnrhY1YgNuScxJ6mdX5c71qfMjG8f234h05XeuUgz9ZVkNC50tMer2BaZLG2ET/XAeI
         M9qO2UoK1B3L5Ek4RlUmmMkA/Wix9ppLRCgNytcPTgbOxeQhoqfWs/rl1+57+uOO7sNO
         8/EmFG5oZBPVNGMiZ05OKC1QF/cGStLKfWF0dY/rR+HSxQmf31VfEGLZ+yrTKAUXl4P7
         jFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVynQllrGVL5R5vgNKoiVtDOzIxlmVA0Xo1sd0ChGsHGgN6X8C5RK7h9AErA/3AH1yqQzfSlhHX3ADL@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSvmRJkPLa7exsaftQ9iNIyVLFvP22ry+LKiUcz56YkMTOV/s
	wZj3xNPqsAWj/Ar96pGCE15w/vRz7TJ9PDqdcGMIt5ltqXUXSlHb7YWJ4nL1DoLk71hcRPNHe8L
	Jn4kHNNRwqg036sD4Tu8H17Ke+JAWnyqihqi9Fi6ctXLXTMZ9NQ9NwDCn6dg=
X-Gm-Gg: ASbGncsq4ut9VQzOAmiIGaJsKfdWm34hMRKcyDOmGuaqhC+TzJ3hfFI8pUhN1Iaa4rD
	Ba+fNPqBEmMdXkiKKgDRsCXQpqJu9JK+Uh1L5N9kWlprm1AKl+65/evuTLPYj45KvxUPvG2GKP/
	gYf75toGUm0SKk9m98UAAP/84L1Zd4iz10MCQhsSZC9pjyYrMoJoKd8VbQrrWNl2Odu9tPsGxLI
	oV2uLKuhePLjP845TvmryQzFMEhMu93w7DY4qWwcOxylKZGC9L6Hwb00w==
X-Google-Smtp-Source: AGHT+IEwe6ZZYGSkCbUorrh/eGb6b5MhBZNhYaE7DFLFwsKhVSUs3HD3g7RvzQRMvrRbF2QWWerISsXCl/JjCnWKOhQ=
X-Received: by 2002:a05:600c:c102:b0:45a:207a:eb7c with SMTP id
 5b1f17b1804b1-45b662ffd56mr612355e9.0.1756184786959; Mon, 25 Aug 2025
 22:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825223348.3780279-1-jiaqiyan@google.com> <aKzuCobhkx9X-axW@agluck-desk3>
 <CACw3F52ov0ZwaecdP2Ky-N5h6hC4dwDZfjysoVF4oF-AhMRbbA@mail.gmail.com> <SJ1PR11MB60835824926BEE57F094DE6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60835824926BEE57F094DE6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 25 Aug 2025 22:06:15 -0700
X-Gm-Features: Ac12FXydY3Wysx6dmP_PiNgoDwKxyt8rgDYC3GaRzRWUlJIfxPlvGotGFvV0lXQ
Message-ID: <CACw3F50bEpUkM=7+5i6VR2UeQ-ZhxGCGSca8b4RykbVz7o-Wng@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: APEI: EINJ: Allow injection on legacy persistent memory
To: "Luck, Tony" <tony.luck@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>
Cc: "guohanjun@huawei.com" <guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>, 
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:12=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > > I chatted offline with Dan Williams. He wondered whether this sanity
> > > check should just be reduced to pass through any address except MMIO
> > > and leave it to the BIOS to decide what is a legitimate injection
> > > target.
> >
> > I guess that's fine, but wonder should the EINJ driver still exclude
> > IORES_DESC_ACPI_TABLES and IORES_DESC_ACPI_NV_STORAGE? to prevent
> > that, say, by coincidence or not an error "corrupted" EINJ table
> > itself, or "corrupted" other ACPI data.
>
> What if I want to find out what the system does with a corrupted ACPI tab=
le?

Yeah, it sounds like a valid use case for a smart user of EINJ. I
guess I just wasn't thinking "wild" enough ;).

If other APEI maintainers and reviewers agree, I will do it in V2;
IIUC basically the following small diff:

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2561b045acc7b..3be20177d630f 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -707,14 +707,7 @@ int einj_error_inject(u32 type, u32 flags, u64
param1, u64 param2, u64 param3,
        base_addr =3D param1 & param2;
        size =3D ~param2 + 1;

-       if (((param2 & PAGE_MASK) !=3D PAGE_MASK) ||
-           ((region_intersects(base_addr, size,
IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
-                               !=3D REGION_INTERSECTS) &&
-            (region_intersects(base_addr, size, IORESOURCE_MEM,
IORES_DESC_PERSISTENT_MEMORY)
-                               !=3D REGION_INTERSECTS) &&
-            (region_intersects(base_addr, size, IORESOURCE_MEM,
IORES_DESC_SOFT_RESERVED)
-                               !=3D REGION_INTERSECTS) &&
-            !arch_is_platform_page(base_addr)))
+       if (((param2 & PAGE_MASK) !=3D PAGE_MASK))
                return -EINVAL;


>
> See discussion earlier this year about limiting error injection:
>
> https://lore.kernel.org/all/aDt77p9GYCIRIOMa@agluck-desk3/
>
> -Tony

