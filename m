Return-Path: <linux-acpi+bounces-696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507C7CC8FA
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B795CB20ECC
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F22D03A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T0B5KIvH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7693FB24
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 15:39:33 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8F9E
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 08:39:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso40188385ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697557172; x=1698161972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDD/uryQTLCU5uMx9saGkKWkdjsc7ClRnhXCpgMi6iw=;
        b=T0B5KIvHjyJWEyO+P27cR3wrnbLUSWALFCbAOWBnddAlxNz68dy/WI+GXa6JCHA+KT
         FSuWAtZMz8WO1mCey6n84qKaOlrluj78M1kEheIrTfNXipPVKdkCkU6F9DkQVI23z1SN
         c16DGLBRV1CcfwIxsrMCJYpurvwL3H/FATNYIR1BuXYM0+ZO3t3LQTkjqVC3Jrqzq2L8
         orHr0RElUyanPAJRIFzfO5H/S4Nz2NlPLH6Ywn5ogLTWc045vrMZ8vCLYEvvEYrIybgk
         Ouj7z+8YbqRDXbQzYZ/bLi67rxDCNBldIgu3JXs9hvpahcjjD+pLcQ4mduZziragSvCB
         1YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557172; x=1698161972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDD/uryQTLCU5uMx9saGkKWkdjsc7ClRnhXCpgMi6iw=;
        b=ZiHCcbREOxMdDolgUleB3AiSpaSxrBhZUowSl1mbdWPfQEBSKaNhYaFaxp3n/q2Rpx
         AqfKSHCUxDScwz9JQast782i31xvClwbvUXJf7GbT765pZoJvrwySGMmSp/DDekYCjm7
         JDWelUJLZONiEnz04Zz/gwQxkrWE1if+C6BNqF5Q9pVXlM/RXs+uCX+6066HvzSv3HTu
         0CzV6DrrXmaj/h0K9mTX/9dGDFEe0Gn+6t0I3CYpq32DN4JecRo2Q6vFISdzqzWGlx7T
         dgvD1W2Id3o3miuiGwxIimuVMen+2W+w6A7tWGPdH5A5FeBFXOYMhlypV1ficO/MU6Ti
         l41A==
X-Gm-Message-State: AOJu0Yz3DIXFE5FxtXoqyu7D2NCniAJ7219t7hRj1FY++gL9yHqJRrZM
	c2JR/AE/hONOaXhNWaPdxtJQpg==
X-Google-Smtp-Source: AGHT+IGhHEDtApkkx2EbvNB6zNoc/nuobujehBrKazxvxt7EI5Z0029abtVr9kz7TlfWkAk9Q9siPA==
X-Received: by 2002:a17:903:27cf:b0:1ca:8e79:53af with SMTP id km15-20020a17090327cf00b001ca8e7953afmr2249385plb.3.1697557171977;
        Tue, 17 Oct 2023 08:39:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001c619fbd5fbsm1707303plh.298.2023.10.17.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:39:31 -0700 (PDT)
Date: Tue, 17 Oct 2023 21:09:23 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 2/3] RISC-V: ACPI: RHCT: Add function to get CBO
 block sizes
Message-ID: <ZS6qq1Y9bLZ868KI@sunil-laptop>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
 <20231016164958.1191529-3-sunilvl@ventanamicro.com>
 <20231017-b394a120094eeee31693e9a7@orel>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-b394a120094eeee31693e9a7@orel>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:37:41AM +0200, Andrew Jones wrote:
> On Mon, Oct 16, 2023 at 10:19:57PM +0530, Sunil V L wrote:
> > Cache Block Operation (CBO) related block size in ACPI is provided by RHCT.
> > Add support to read the CMO node in RHCT to get this information.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  6 +++
> >  drivers/acpi/riscv/rhct.c     | 93 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 99 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index d5604d2073bc..7dad0cf9d701 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  		       unsigned int cpu, const char **isa);
> >  
> >  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> > +void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
> > +			     u32 *cboz_size, u32 *cbop_size);
> >  #else
> >  static inline void acpi_init_rintc_map(void) { }
> >  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > @@ -79,6 +81,10 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  	return -EINVAL;
> >  }
> >  
> > +static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
> > +					   u32 *cbom_size, u32 *cboz_size,
> > +					   u32 *cbop_size) { }
> > +
> >  #endif /* CONFIG_ACPI */
> >  
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
> > index b280b3e9c7d9..105f1aaa3fac 100644
> > --- a/drivers/acpi/riscv/rhct.c
> > +++ b/drivers/acpi/riscv/rhct.c
> > @@ -8,6 +8,7 @@
> >  #define pr_fmt(fmt)     "ACPI: RHCT: " fmt
> >  
> >  #include <linux/acpi.h>
> > +#include <linux/bits.h>
> >  
> >  static struct acpi_table_header *acpi_get_rhct(void)
> >  {
> > @@ -81,3 +82,95 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
> >  
> >  	return -1;
> >  }
> > +
> > +static void acpi_parse_hart_info_cmo_node(struct acpi_table_rhct *rhct,
> > +					  struct acpi_rhct_hart_info *hart_info,
> > +					  u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
> > +{
> > +	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
> > +	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
> > +	struct acpi_rhct_node_header *ref_node;
> > +	struct acpi_rhct_cmo_node *cmo_node;
> > +	u32 *hart_info_node_offset;
> > +
> > +	hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
> > +	for (int i = 0; i < hart_info->num_offsets; i++) {
> > +		ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
> > +					rhct, hart_info_node_offset[i]);
> > +		if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
> > +			cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
> > +						ref_node, size_hdr);
> > +			if (cbom_size && cmo_node->cbom_size <= 30) {
> > +				if (!*cbom_size) {
> > +					*cbom_size = BIT(cmo_node->cbom_size);
> > +				} else if (*cbom_size !=
> > +						BIT(cmo_node->cbom_size)) {
> 
> No need to break the if line, we can go to 100 chars. And then, since both
> the if and else if arms only have single statements, all the {} can be
> dropped too. Same comment for cboz and cbop.
> 
Yeah, it is a side effect of working on repos with different coding
standards. It is interesting that checkpatch didn't recommend to remove
the braces. Let me fix it in next revision. Thanks!.

> > +					pr_warn("CBOM size is not the same across harts\n");
> > +				}
> > +			}
> > +
> > +			if (cboz_size && cmo_node->cboz_size <= 30) {
> > +				if (!*cboz_size) {
> > +					*cboz_size = BIT(cmo_node->cboz_size);
> > +				} else if (*cboz_size !=
> > +						BIT(cmo_node->cboz_size)) {
> > +					pr_warn("CBOZ size is not the same across harts\n");
> > +				}
> > +			}
> > +
> > +			if (cbop_size && cmo_node->cbop_size <= 30) {
> > +				if (!*cbop_size) {
> > +					*cbop_size = BIT(cmo_node->cbop_size);
> > +				} else if (*cbop_size !=
> > +						BIT(cmo_node->cbop_size)) {
> > +					pr_warn("CBOP size is not the same across harts\n");
> > +				}
> > +			}
> > +		}
> > +	}
> > +}
> > +
> > +/*
> > + * During early boot, the caller should call acpi_get_table() and pass its pointer to
> > + * these functions(and free up later). At run time, since this table can be used
>                      ^ add a space here
> 
> > + * multiple times, pass NULL so that the table remains in memory
> > + */
> > +void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
> > +			     u32 *cboz_size, u32 *cbop_size)
> > +{
> > +	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
> > +	struct acpi_rhct_node_header *node, *end;
> > +	struct acpi_rhct_hart_info *hart_info;
> > +	struct acpi_table_rhct *rhct;
> > +
> > +	if (acpi_disabled)
> > +		return;
> > +
> > +	if (table) {
> > +		rhct = (struct acpi_table_rhct *)table;
> > +	} else {
> > +		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
> 
> Not an issue of this patch, but it seems like acpi_get_rhct() should
> return a struct acpi_table_rhct pointer instead of a struct
> acpi_table_header pointer since it's specifically returning an RHCT.
> 
Makes sense. Let me add a patch to improve this.

> > +		if (!rhct)
> > +			return;
> > +	}
> > +
> > +	if (cbom_size)
> > +		*cbom_size = 0;
> > +
> > +	if (cboz_size)
> > +		*cboz_size = 0;
> > +
> > +	if (cbop_size)
> > +		*cbop_size = 0;
> > +
> > +	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
> > +	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
> > +	     node < end;
> > +	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
> > +		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
> > +			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
> > +			acpi_parse_hart_info_cmo_node(rhct, hart_info, cbom_size,
> > +						      cboz_size, cbop_size);
> > +		}
> > +	}
> > +}
> > -- 
> > 2.39.2
> >
> 
> Other than the nits
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
Thanks a lot for the review!
Sunil

