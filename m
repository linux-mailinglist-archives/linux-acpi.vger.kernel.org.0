Return-Path: <linux-acpi+bounces-10694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F7A12C2F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 21:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638481888169
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1648F1B0F3D;
	Wed, 15 Jan 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZXsKAdJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646F24A7CC;
	Wed, 15 Jan 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971324; cv=none; b=WK02cE5Hbyr0809Jo2JeR2aSpa15fmzCz/BKUD0WKGTw6arOCCBq+Qy2jb29jDtTxcvfk7J38UFc7ILcyYjc3vUgA/R8DauRl6TxkKj7P0ZcYm4jrclO5jKmOn8XQqAO+P8BIKMLFHDWGh7WWUF2y6v0lcjfjfEOCnCi9nfHIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971324; c=relaxed/simple;
	bh=7Yi9wQXCf9Oa/YptQFNYrR2iLrZLm20usJHaoqVMUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVgiwqUbyxwRtIGpqf+9FD3JuWRpmInSbgp2o1ge8/74rBL9Kvx0wCcOKjniGg/8ufQ9HgIhVAbsWGrfmeO7dppKXcfcfuioju5VJghpyPjMKhvOHdFqyGGJ5PastfFVcf9x4u6SBm6AQC1iBX6Oyouj/ADa3ItPgChKCcVOnA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZXsKAdJ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a37a2a53so2024501cf.2;
        Wed, 15 Jan 2025 12:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736971321; x=1737576121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EoSDSZwOF8a5VVtN8f70jSBvhuMPwgbv5dy0No8F5E0=;
        b=MZXsKAdJUVMxCLlURQYJN/gyo74hMlES0rlfuM1AjEW1vifuhHOFAM/mVnI8BauKap
         /tUiOsz0Y1Sskk9bq8PxczgHeLyF+bZGUcZl1Dzz4tkA53EKRYdtrQsGEoAFqSJyxSlu
         xKuo8VWTKARiErSr9AJUPisi+kn/LgUsqnilrPHhRDhNnBVGgVmuzXafwkMNecppbH4g
         fMH3iutOcuCcesRGqzIGKn/BSHIJ2El0dvYO0Lciz+s+1lPZ8Jcuw49od5guk3Ew4FCo
         3Mfm98AP1ZAJ7+IAHOLIUidx715DK2rBY4wbL0m6lCQ4ZbSShBH5QtW+vqQFs13OpaX3
         cWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971321; x=1737576121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoSDSZwOF8a5VVtN8f70jSBvhuMPwgbv5dy0No8F5E0=;
        b=rZmBxLsCFGV8PjwkeBeyPzGasCu9n/q26U5BSShr9gv/8h5kS1vlyJ1VsDvDbem9gL
         QpuADNb5ZrZDLOTZyaObADxlyQ1dUObNX5RSJNFu6+bDr5irlFHjeDdJYNXmN77vSJHL
         cLWkkSXl6JIPtxM6oB2kfriJE9TwiTfIjfzDKGBYe6PcE8jwN1EFvHy1xloQHpMyRBb0
         A/wjCL6qLutT75v7DLR3a1m6ZsA1H3HSCEARbYLrazsYx+5NQs/3olflm1z7qqEJcaye
         LFCuB5E/1AQxpjGwNS00C2WNZ3yvfwWWuOOc4yWe1OKemLt+bUoFs3VXewuHzBSMJOX+
         peCg==
X-Forwarded-Encrypted: i=1; AJvYcCVJUuYT5+bW2tMQkpiOW4sBUJTGpI5wpqZdzvZ34IgQl+K8cZTSiZ0P3kOymltLgSy3J+JOmD5ZnedylfX0@vger.kernel.org, AJvYcCXCQlXqF5/Gx0MqqF9F+1kUIQoh6Qpt+LriqI0um9XHpXrDF6w6l37bYVQkPclCaBb8U3pcseCSdYWj@vger.kernel.org
X-Gm-Message-State: AOJu0YyLoJa6XWl9nhICIervpq4wEJZjBE7iWS1H9QvdJUbJ4CQOzjhJ
	sn23dI3o4slE8TtuSz8i+Vb61j2Oa6uAoCavrpXreHbeYhpnZSUU
X-Gm-Gg: ASbGncv9ltHDF2H2VQMq1IqbZL1033uPy+EBAdTHmAo9hHRryRst2Xm/VEVG6D7bsaj
	Ryx67drr2BjjCC/cBNp6XIQOWZDJjibG2CCzZkXp0PrkMcciRc1bSK6/aFRgbFylvYt1N5ZDa1L
	uWdpPBBhWEod/RisiAnMpe6teTmX+Ld0izCHXjb4RUQ2JoWCGWalynwUDXLrX9hc0gJ7Mn2l9yH
	cq95jQerIjoGvVcCPL2ERsxnQ92N8DD/WG4XgjuqXGLwvy4JNOhA5lX
X-Google-Smtp-Source: AGHT+IGMevjVBohoQpC5bCwsoBcn/4MAMRD39U6cz8jzxtQDjPU/Mq8XykjfEz4sT4E9SlXebMYDWQ==
X-Received: by 2002:ac8:59ce:0:b0:467:5082:74bd with SMTP id d75a77b69052e-46c71083dcbmr504132481cf.34.1736971321122;
        Wed, 15 Jan 2025 12:02:01 -0800 (PST)
Received: from alphacentauri ([2800:bf0:179:113e:f067:4e25:4298:6451])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8623154b329sm5868111241.27.2025.01.15.12.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:02:00 -0800 (PST)
Date: Wed, 15 Jan 2025 15:01:55 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Joshua Grisham <josh@joshuagrisham.com>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
	Ike Panhc <ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Alexis Belmonte <alexbelm48@gmail.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
	ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 19/19] ACPI: platform_profile: Add a prefix to log
 messages
Message-ID: <gwwl4a7o4drpejm7czcciradzv5jyp7hmpwev5jswqlkkb65rq@vbmamxucdmom>
References: <20250115071022.4815-1-kuurtb@gmail.com>
 <20250115071022.4815-20-kuurtb@gmail.com>
 <d90eabb9-37c0-4763-b87e-696456da4e85@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90eabb9-37c0-4763-b87e-696456da4e85@amd.com>

On Wed, Jan 15, 2025 at 10:45:48AM -0600, Mario Limonciello wrote:
> On 1/15/2025 01:10, Kurt Borja wrote:
> > Declare a pr_fmt prefix.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> 
> I had to do a bit of a double take because you removed the prefix in patch
> 15/19 of one of existing messages.  So this makes sense at this place in the
> series, thanks!

Yes, I dropped the sanity check error message in favor of WARN_ON_ONCE
because not passing that sanity check would just be a bug. Apart from
that, there was only one more log message that needed the prefix and it
didn't need to be modified.

> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks!

~ Kurt

> 
> > ---
> >   drivers/acpi/platform_profile.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> > index 4895f37dd549..c9e46b6e27da 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -2,6 +2,8 @@
> >   /* Platform profile sysfs interface */
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >   #include <linux/acpi.h>
> >   #include <linux/bits.h>
> >   #include <linux/cleanup.h>
> 

