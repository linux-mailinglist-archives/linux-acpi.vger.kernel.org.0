Return-Path: <linux-acpi+bounces-14948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7912FAF5FD9
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 19:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7184A29F6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6230112B;
	Wed,  2 Jul 2025 17:22:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6AC30112F;
	Wed,  2 Jul 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476976; cv=none; b=ZbAoGLcaOxuAdvmaVyios8MNmfr4jpoj3tc2MatJR8Zrc0VKnJZHgAZLmXlpGWNG7CfSFFCy3+kmKWLUOoUvXQCRf8aF83yER0b19H38Vo2oOaiH9rklP0IDEF4QoGRhuRnzjU7R8w6wV6f1xE1b4yJOz7/ocyTkEizxiX15ndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476976; c=relaxed/simple;
	bh=rBer7v6TKwbZtXGGIbx+pCsCWsubSneQmgOO75t0FHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CetXbc2mXQZacEXI6BoeDhzCndRETuPsutqJgQgdfofVjCUNUp4AbQcKvjZZE7EAmAcDV9QgBR6lkR/UQK9WZt0O6qtXJ/V1qiwGowSm7N9cxP6baejpiXmcX9Sr+c65kJrey/0lGFzeIVGtP/hbEZCKJywI2Hp31Ex990SUBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so13495647a12.1;
        Wed, 02 Jul 2025 10:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476973; x=1752081773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtw6pZQE0DlhVBE2VMFX3XGHgEpdo88L0cVeYsuNgAQ=;
        b=Y73i1kULkNxSmmMAqdNuCmZ8PakRyXpoN46ZdZzf8vzAOTRTVW7oztka8hzQAMet80
         v6TJE5wAcXNKoCTVbt5AMaTmdwame1miUv6gRLekVhVmXDxvuQua/OpDz4vrP18Es5g1
         8xQxGPDAdPJMA5Iu+G20xgxEdYQkJerRIpsE8hRSenp5AZ41e6zrUmnqmn7hbCYUr4iA
         ujuXIoqCfGZNnRwQGeEqlnT08q0SYnfPlyaybyCIgGABfmRzWmuMHIGKFvM92t6W9st+
         Kh3mOrB4Qjhjnr15fDBmjvDzpXNIyW5ooRjJGdfE/8MX3XCSVvXxAsx3oTg+qFuR55S9
         bGMw==
X-Forwarded-Encrypted: i=1; AJvYcCUruDJpFFBJr7aw/mE7nGlWYXt8R004bGn5bA0fy4w85JRRuS60gxKeMoF48wHL4eLW1ekDfuwe9T9GMFxc@vger.kernel.org, AJvYcCXubQSQemcZqTnLYqC6IMJZKCCFbtrJZZm4hegdDy5mrL+JhyM5Xtpz9GFlGttB7f/5ZDqQzh0S9bVg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywun64Vdf1cR6zinAG5pXcoA3fhd9yJEcrf+ubaQlYSuY4KAbyW
	D4aD+FoMfNiL+fmqCmfUiijTgvFoKpn1PpPbRz5qEha0IlGGuVyU9MDo
X-Gm-Gg: ASbGncsFc7l64V0a7G2jDaZ50ISS9oo2ULPZmCqJolcK5RtPDJKIgFFF9ESh9jb0AmU
	NWYwOSlWSMFUDc7+NP9/n+ta3Rq5xToRSS2yOJU9C2jnl97KbJJcxkq54VXVr+YhZGGz4F77fqy
	NrJ9yBpE+GIClOegHmDkQ73CM9MrJCeZJfC6dwXRtImLFaczLq7zzIwmf1zXGwbHwor+yTpVE1r
	wXewmJjbkTm9njduxHJyO3ZyrFJipu0VcnPIuYr+czmOFA68gK9nx237Bnyjhgmx4Ck09PJ8Hkf
	4SSpnrNAisQAVyabHIDXm4TMDw8Um2zYXR1F62zUPDQngLH4eeD0
X-Google-Smtp-Source: AGHT+IEvfrsb7eTYf57GmhCFjhHDvWPbaYrMBXRhFQFoVMUGw5OFFwNtrc9VfEKQ9mKm5SEPQqkW/Q==
X-Received: by 2002:a17:907:96a3:b0:ad5:8412:1c9 with SMTP id a640c23a62f3a-ae3d8bf2173mr1556066b.59.1751476972808;
        Wed, 02 Jul 2025 10:22:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659de4sm1091039666b.42.2025.07.02.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:22:52 -0700 (PDT)
Date: Wed, 2 Jul 2025 10:22:50 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, kbusch@kernel.org, rmikey@meta.com
Subject: Re: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
Message-ID: <aGVq6khN+QdqD5Aj@gmail.com>
References: <20250702-add_tain-v1-1-9187b10914b9@debian.org>
 <aGVe4nv18dRHHV16@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGVe4nv18dRHHV16@agluck-desk3>

On Wed, Jul 02, 2025 at 09:31:30AM -0700, Luck, Tony wrote:
> On Wed, Jul 02, 2025 at 08:39:51AM -0700, Breno Leitao wrote:
> > When a GHES (Generic Hardware Error Source) triggers a panic, add the
> > TAINT_MACHINE_CHECK taint flag to the kernel. This explicitly marks the
> 
> While it might not strictly be a machine check that caused GHES to
> panic, it seems close enough from the available TAINT options.

Right, that was my reasoning as well. There are other cases where
TAINT_MACHINE_CHECK is set when the Hardware is broken.

> So unless someone feels it would be better to create a new TAINT
> flag (TAINT_FATAL_GHES? TAINT_FIRMWARE_REPORTED_FATAL_ERRROR?)
> then this seems OK to me.

Thanks. That brings another topic. I am seeing crashes and warnings that
are only happening after recoverable errors. I.e, there is a GHES
recoverable error, and then machine crashes minutes later. A classical
example is when the PCI downstream port disappear, and recovers later,
re-enumerating everything, which is simply chaotic.

I would like to be able to correlate the crash/warning with a machine
that had a recoverable error. At scale, this improves the kernel
monitoring by a lot.

So, if we go toward using TAINT_FATAL_GHES, can we have two flavors?
TAINT_FATAL_GHES_RECOVERABLE and TAINT_FATAL_GHES_FATAL?

Thanks for the review,
--breno

> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> > kernel as tainted due to a machine check event, improving diagnostics
> > and post-mortem analysis. The taint is set with LOCKDEP_STILL_OK to
> > indicate lockdep remains valid.
> > 
> > At large scale deployment, this helps to quickly determin panics that
> > are coming due to hardware failures.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/acpi/apei/ghes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index f0584ccad4519..3d44f926afe8e 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1088,6 +1088,8 @@ static void __ghes_panic(struct ghes *ghes,
> >  
> >  	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
> >  
> > +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> > +
> >  	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
> >  
> >  	if (!panic_timeout)
> > 
> > ---
> > base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
> > change-id: 20250702-add_tain-902925f3eb96
> > 
> > Best regards,
> > --  
> > Breno Leitao <leitao@debian.org>
> > 

