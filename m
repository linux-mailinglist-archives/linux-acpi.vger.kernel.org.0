Return-Path: <linux-acpi+bounces-5984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199848CF879
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 06:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416EF1C2017F
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 04:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0B79E1;
	Mon, 27 May 2024 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SH0R+ZAj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599B17552
	for <linux-acpi@vger.kernel.org>; Mon, 27 May 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784781; cv=none; b=YOCID6+ZJnVOd/X5/bbmZK8AB6LK3qWElcfjNNbeIE2D0l2sRSyTbqv/cTTkrEllkYfQrLg5DtqvAnXu1/HqZq4MlaoZ1J4cHz2hnZrGCzdC3FvDZu6wqOJftIKik2eHIZP15f8OopaSb4Ffuuc1P/V9U5L9je5+xEqQV1H6Vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784781; c=relaxed/simple;
	bh=oJwR3+2YrVRYYhvFhHEyHQNfR5yttFLneZk6S+2cBpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL6IKMfHvw56sg8PcbD5XynlWI5vBj7K3cOTJirM2K6m1c1VyPry6vjggir7p+DQSEKRjAst4NkfzzEhSBGSQfkw24nVoFpW8yRQSyT8f+eetkWnMHasRLqA042fbXHorpUJIgj2FYGpIwpqspNcfzSscqSByOrT3sIFNT1zwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SH0R+ZAj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f47eb2354bso5927005ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 26 May 2024 21:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716784779; x=1717389579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6YXrviCLcyxXmmDXMgEBXPU7+X84327YvIUqwBQ/Tg=;
        b=SH0R+ZAjcKQ0KsfjWdaSY/8DOKCSDQJIetvy6HmxkhcMY6EbsaOgR5uREaaae6AI3L
         X6BIJHIrVnolNVzLCUO0NP1mfLlAoT3JVgpCWFIHUKTfTdGEdV3x1juac4TCdLcr7KjD
         qhuhjyyKgUO0ld2m2NUaOI1U4jNu9UE0ISBvh55av3XyOf0XUmExtQ3tRQBhxo3f0JyM
         UE5mrYAn5Jrc1HweV71Xw43VaJFMl3oB6XG+gl86bD/VTJ2kzV9YBzOc7lDmU+OelLMN
         /6Y7Et1ZNZ8pfYuWCGGZwcFZuYzHHxcX2KTsu8rwrDBzazOXVf43SdmBI0/XINBhso26
         p/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716784779; x=1717389579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6YXrviCLcyxXmmDXMgEBXPU7+X84327YvIUqwBQ/Tg=;
        b=LxQHCzYefz5rUhjiN9ZGOJ+o/QoKcgJyeM8W0RMZM7Yx8gQfUSqZsksEJQby4/TX4i
         Wpu8y3nyE/aHNNLem8L5RKqqo32Hix0d9qqsinNpZ+tUju/ymxgTgcXZmflS0VzO52b7
         T7VkmUCCNRNQXdIu65SS7bmCHzi7RpC8z6pyR4UVm4V4uihVYcip6+7nolD5ngoxiW77
         guqYQLR5JFHUdqKDkZ25BfA7Ocl18D7jsmuvRWldjE1CgJRkm2+OkJxOk/6JyJQvU9L+
         lhL/qsSqJfk4gqu29sSuRHtI0vzzXVcPqZg2sMaiBNpp72xOM4iLA0uU0Ks4vdh5Jb1N
         rEMw==
X-Forwarded-Encrypted: i=1; AJvYcCWqxtl8r2V0VlvAu2hO0eSRUFWZdZFBu7x/uWxAKBTg2SWYCuyqJr/LSuaNGhLl/hhXks7R8aGE1wqJyytdf1rI3yVj0iE2BK+zew==
X-Gm-Message-State: AOJu0YysCCBoGRl0MkehtEPrsEtpEAv1N/JYtpKx5pCEVYiz9QyophzQ
	GH4YOCGKBBtF6+zjZ26l2fuatSdbv45P8EpIiXjzm+gjtyW0qEPB7Sfft8xzax8=
X-Google-Smtp-Source: AGHT+IE9JvCAMKXsid9Oup9PtkMG3gbKLCIeVIPVgCCtq14j1hr2UK2tj9TrDVbVzYBOJhbbgWrYoQ==
X-Received: by 2002:a17:903:188:b0:1f3:900:8f83 with SMTP id d9443c01a7336-1f4498ec4ecmr99852385ad.52.1716784778805;
        Sun, 26 May 2024 21:39:38 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9903b5sm50879945ad.189.2024.05.26.21.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:39:38 -0700 (PDT)
Date: Mon, 27 May 2024 10:09:26 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 13/17] irqchip/riscv-intc: Add ACPI support for AIA
Message-ID: <ZlQOfrMHHaGV0cDg@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-14-sunilvl@ventanamicro.com>
 <874jaofbfp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jaofbfp.ffs@tglx>

Hi Thomas,

On Thu, May 23, 2024 at 11:47:06PM +0200, Thomas Gleixner wrote:
> On Wed, May 01 2024 at 17:47, Sunil V L wrote:
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > index 9e71c4428814..af7a2f78f0ee 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -249,14 +249,105 @@ IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> >  IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
> >  
> >  #ifdef CONFIG_ACPI
> > +struct rintc_data {
> > +	u32 ext_intc_id;
> > +	unsigned long hart_id;
> > +	u64 imsic_addr;
> > +	u32 imsic_size;
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers
>
Sure, thanks!
 
> > +};
> > +
> > +static u32 nr_rintc;
> > +static struct rintc_data *rintc_acpi_data[NR_CPUS];
> > +
> > +int acpi_get_intc_index_hartid(u32 index, unsigned long *hartid)
> 
> Why int? All of these functions have strictly boolean return values:
> success = true, fail = false, no?
> 
> Either bool or get rid of the pointer and let the function return
> either the real hart id or an invalid one.
>
Sure. I just tried to keep it similar to the parent function. But let me
go with your suggestion in the next revision.
 
> > +{
> > +	if (index >= nr_rintc)
> > +		return -1;
> > +
> > +	*hartid = rintc_acpi_data[index]->hart_id;
> > +	return 0;
> 
> I.e.
> 
> 	return index >= nr_rintc ? rintc_acpi_data[index]->hart_id : INVALID_HART_ID;
> 
Sure.

> > +int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid)
> > +{
> > +	int i, j = 0;
> > +
> > +	for (i = 0; i < nr_rintc; i++) {
> > +		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id) {
> > +			if (idx == j) {
> > +				*hartid = rintc_acpi_data[i]->hart_id;
> > +				return 0;
> > +			}
> > +			j++;
> > +		}
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts)
> > +{
> > +	int i, j = 0;
> > +
> > +	for (i = 0; i < nr_rintc; i++) {
> > +		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id)
> > +			j++;
> > +	}
> > +
> > +	*nr_contexts = j;
> > +}
> > +
> > +int acpi_get_plic_context(u8 id, u32 idx, int *context_id)
> > +{
> > +	int i, j = 0;
> > +
> > +	for (i = 0; i < nr_rintc; i++) {
> > +		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id) {
> > +			if (idx == j) {
> > +				*context_id = IDC_CONTEXT_ID(rintc_acpi_data[i]->ext_intc_id);
> > +				return 0;
> > +			}
> > +
> > +			j++;
> > +		}
> > +	}
> 
> So that's the third incarnation of the same loop with the truly self
> explaining variable and argument names.
> 
>     j is actually the index of the context which is associated to a
>     given PLIC ID.
> 
>     idx is the context index to search for
> 
> Right? So why can't these things be named in a way which makes the
> intent of the code clear?
> 
> Also why are all the arguments u8/u32? There is no hardware
> involved. Simple 'unsigned int' is just fine and the u8/u32 is not bying
> you anything here.
> 
> Aside of that these ugly macros can be completely avoided and the code
> can be written without a copy & pasta orgy.
> 
> struct rintc_data {
> 	union {
> 		u32		ext_intc_id;
>                 struct {
>                 	u32	context_id	: 16,
>                         			:  8,
>                         	aplic_plic_id	:  8;
>                 }
>         };
> 	unsigned long		hart_id;
> 	u64			imsic_addr;
> 	u32			imsic_size;
> };
> 
> #define for_each_matching_plic(_plic, _plic_id)				\
> 	for (_plic = 0; _plic < nr_rintc; _plict++)			\
>         	if (rintc_acpi_data[_plic]->aplic_plic_id != _plic_id)	\
>                 	continue;					\
>                 else
> 
> unsigned int acpi_get_plic_nr_contexts(unsigned int plic_id)
> {
> 	unsigned int nctx = 0;
> 
> 	for_each_matching_plic(plic, plic_id)
> 		nctx++;
> 
> 	return nctx;
> }
> 
> static struct rintc_data *get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
> {
> 	unsigned int ctxt = 0;
> 
> 	for_each_matching_plic(plic, plic_id) {
>         	if (ctxt == ctxt_idx)
>                 	return rintc_acpi_data + plic;
>         }
>         return NULL;
> }
> 
> unsigned long acpi_get_ext_intc_parent_hartid(unsigned int plic_id, unsigned int ctxt_idx)
> {
>         struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);
> 
>         return data ? data->hart_id : INVALID_HART_ID;
> }
> 
> unsigned int acpi_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
> {
>         struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);
> 
>         return data ? data->context_id : INVALID_CONTEXT;
> }
> 
> Or something like that. Hmm?
>
Nice!. Yes, this is better. Thanks a lot for the suggestion. Let me
update in the next revision.
 
> > +int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
> > +{
> > +	if (index >= nr_rintc)
> > +		return -1;
> > +
> > +	res->start = rintc_acpi_data[index]->imsic_addr;
> > +	res->end = res->start + rintc_acpi_data[index]->imsic_size - 1;
> > +	res->flags = IORESOURCE_MEM;
> > +	return 0;
> > +}
> > +
> > +static struct fwnode_handle *ext_entc_get_gsi_domain_id(u32 gsi)
> > +{
> > +	return riscv_acpi_get_gsi_domain_id(gsi);
> > +}
> 
> This wrapper is required because using riscv_acpi_get_gsi_domain_id()
> directly is too obvious, right?
>
:-). Let me remove it.
 
> >  static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> >  				       const unsigned long end)
> >  {
> > -	struct fwnode_handle *fn;
> >  	struct acpi_madt_rintc *rintc;
> > +	struct fwnode_handle *fn;
> > +	int rc;
> >  
> >  	rintc = (struct acpi_madt_rintc *)header;
> > +	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
> > +	if (!rintc_acpi_data[nr_rintc])
> > +		return -ENOMEM;
> > +
> > +	rintc_acpi_data[nr_rintc]->ext_intc_id = rintc->ext_intc_id;
> > +	rintc_acpi_data[nr_rintc]->hart_id = rintc->hart_id;
> > +	rintc_acpi_data[nr_rintc]->imsic_addr = rintc->imsic_addr;
> > +	rintc_acpi_data[nr_rintc]->imsic_size = rintc->imsic_size;
> > +	nr_rintc++;
> >  
> >  	/*
> >  	 * The ACPI MADT will have one INTC for each CPU (or HART)
> > @@ -273,7 +364,14 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> >  		return -ENOMEM;
> >  	}
> >  
> > -	return riscv_intc_init_common(fn, &riscv_intc_chip);
> > +	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
> > +	if (rc) {
> > +		irq_domain_free_fwnode(fn);
> > +		return rc;
> > +	}
> 
> This looks like a completely unrelated bug fix. Please don't mix functional
> changes and fixes.
> 
Makes sense. Let me create separate patch.

Thanks a lot for the review!
Sunil

