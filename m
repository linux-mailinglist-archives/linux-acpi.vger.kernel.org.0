Return-Path: <linux-acpi+bounces-13404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41168AA5690
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2893B4C4C
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 21:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8422A7E3;
	Wed, 30 Apr 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg2K3Cum"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19B1B87E8;
	Wed, 30 Apr 2025 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047990; cv=none; b=T53IuMp//nwbhjrC+Pff1c9KO0pUDn9hTgBz0qRMCKvhsjGsEJB/HfTn1v1HjCS6FDbjgZtl1zsfuH3PhWDtl6HSYXsmtEHMrksTUidKipN0PtrzSY33i3EkeshGCphTlc6QqwFfOxMB9P9qbMBKMgvWNv4JligojpbujLRsFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047990; c=relaxed/simple;
	bh=Zh1g5NmzYNwkXg+SKcvvFymhyFnP4VBrEzUpUXaEi6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiJk9QfIEsDNgxO53IPCzVU4LK0W9U7kJzZTHckVyl3K+AiXoXHmFpYDMvjFMF+/YAElYVFoyurKDohdkXf+YsXXY1r6Ov2ABnQXiqxnNQ0YMqtY8SyKhWq/O4376l2CLwkXeUS4QcJzCvgVj75zOQu8k+2kvI/klPTkGgyXFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg2K3Cum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E31C4CEE7;
	Wed, 30 Apr 2025 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746047989;
	bh=Zh1g5NmzYNwkXg+SKcvvFymhyFnP4VBrEzUpUXaEi6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg2K3CumnLN9nnRerQEZDRg2R3e+Qn0BI/W+6N5+RN0xGwI3vOg71asshKdjOVQnw
	 9DKNf8mlYlc1wad7HyRiWZGp9jXay3Y+4vvqfEGq29a+q6wJ5pClXegBBH/W9eyCyj
	 hSb4sWoaJxiI28n1+mjHYwm6OqVbxrPkEmw4bSdMKIShD0di1JqVYenhhJyRA4y+9H
	 /r33efJK/tN++qsow0d1O8AV5zd4u89ol0On98PXgUTbHvj9d8Zi+bNKLoYe4w/td/
	 qtwtblUKIfDD7+mjqxGFjAvmcyY4kHA0qRG99+Nh028F4OWIofuhJA1DLptGk/G9hy
	 NKh845kHJB1bw==
Date: Wed, 30 Apr 2025 14:19:46 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] acpi: nfit: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504301400.3B1EACEB@keescook>
References: <Z-QpUcxFCRByYcTA@kspp>
 <67e55ac4dfa2e_13cb29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <df338a70-fdfc-427e-9915-8b9e50de93ad@embeddedor.com>
 <c4828c41-e46c-43c9-a73a-38ce8ab2c1c4@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4828c41-e46c-43c9-a73a-38ce8ab2c1c4@embeddedor.com>

On Wed, Apr 30, 2025 at 02:07:24PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 30/04/25 13:41, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 27/03/25 08:03, Dan Williams wrote:
> > > Gustavo A. R. Silva wrote:
> > > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > > getting ready to enable it, globally.
> > > > 
> > > > Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> > > > a flexible structure where the size of the flexible-array member
> > > > is known at compile-time, and refactor the rest of the code,
> > > > accordingly.
> > > > 
> > > > So, with these changes, fix a dozen of the following warnings:
> > > > 
> > > > drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > > 
> > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > ---
> > > > Changes in v2:
> > > >   - Use DEFINE_RAW_FLEX() instead of __struct_group().
> > > > 
> > > > v1:
> > > >   - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
> > > > 
> > > >   drivers/acpi/nfit/intel.c | 388 ++++++++++++++++++--------------------
> > > >   1 file changed, 179 insertions(+), 209 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> > > > index 3902759abcba..114d5b3bb39b 100644
> > > > --- a/drivers/acpi/nfit/intel.c
> > > > +++ b/drivers/acpi/nfit/intel.c
> > > > @@ -55,21 +55,17 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
> > > >   {
> > > >       struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> > > >       unsigned long security_flags = 0;
> > > > -    struct {
> > > > -        struct nd_cmd_pkg pkg;
> > > > -        struct nd_intel_get_security_state cmd;
> > > > -    } nd_cmd = {
> > > > -        .pkg = {
> > > > -            .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> > > > -            .nd_family = NVDIMM_FAMILY_INTEL,
> > > > -            .nd_size_out =
> > > > -                sizeof(struct nd_intel_get_security_state),
> > > > -            .nd_fw_size =
> > > > -                sizeof(struct nd_intel_get_security_state),
> > > > -        },
> > > > -    };
> > > > +    DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
> > > > +            sizeof(struct nd_intel_get_security_state));
> > > > +    struct nd_intel_get_security_state *cmd =
> > > > +            (struct nd_intel_get_security_state *)nd_cmd->nd_payload;
> > > >       int rc;
> > > > +    nd_cmd->nd_command = NVDIMM_INTEL_GET_SECURITY_STATE;
> > > > +    nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
> > > > +    nd_cmd->nd_size_out = sizeof(struct nd_intel_get_security_state);
> > > > +    nd_cmd->nd_fw_size = sizeof(struct nd_intel_get_security_state);
> > > 
> > > Can this keep the C99 init-style with something like (untested):
> > > 
> > > _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
> > >               sizeof(struct nd_intel_get_security_state), {
> > >         .pkg = {
> > >                 .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> > >                 .nd_family = NVDIMM_FAMILY_INTEL,
> > >                 .nd_size_out =
> > >                         sizeof(struct nd_intel_get_security_state),
> > >                 .nd_fw_size =
> > >                         sizeof(struct nd_intel_get_security_state),
> > >         },
> > >     });
> > > 
> > > 
> > > ?
> > 
> > The code below works - however, notice that in this case we should
> > go through 'obj', which is an object defined in _DEFINE_FLEX().
> > 
> >          _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
> >                          sizeof(struct nd_intel_get_security_state), = {
> >                  .obj = {
> >                          .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> >                          .nd_family = NVDIMM_FAMILY_INTEL,
> >                          .nd_size_out =
> >                                  sizeof(struct nd_intel_get_security_state),
> >                          .nd_fw_size =
> >                                  sizeof(struct nd_intel_get_security_state),
> >                  },
> >          });
> > 
> 
> Now, I can modify the helper like this:
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 69533e703be5..170d3cfe7ecc 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -404,7 +404,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>         union {                                                                 \
>                 u8 bytes[struct_size_t(type, member, count)];                   \
>                 type obj;                                                       \
> -       } name##_u initializer;                                                 \
> +       } name##_u = { .obj initializer };                                      \
>         type *name = (type *)&name##_u

Ah yeah, nice. That could work!


I wish we could make it more idiomatic, but even if we pushed the
initializer to the end, we have to repeat the type...

#define _DEFINE_FLEX(type, name, member, count, initializer...)                 \
        _Static_assert(__builtin_constant_p(count),                             \
                       "onstack flex array members require compile-time const count"); \
        union {                                                                 \
                u8 bytes[struct_size_t(type, member, count)];                   \
                type obj;                                                       \
        } name##_u = { };                                                       \
        type *name = (type *)&name##_u;						\
	*name


	_DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
		     sizeof(struct nd_intel_get_security_state))
	= (struct nd_cmd_pkg){
		.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
		.nd_family = NVDIMM_FAMILY_INTEL,
		.nd_size_out =
			sizeof(struct nd_intel_get_security_state),
		.nd_fw_size =
			sizeof(struct nd_intel_get_security_state),
	};

So, I think what you have is more readable (or perhaps less surprising),
even if a little "weird". :)

> 
>  /**
> 
> and then we can use the helper as follows:
> 
>         _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
>                         sizeof(struct nd_intel_get_security_state), = {
>                         .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
>                         .nd_family = NVDIMM_FAMILY_INTEL,
>                         .nd_size_out =
>                                 sizeof(struct nd_intel_get_security_state),
>                         .nd_fw_size =
>                                 sizeof(struct nd_intel_get_security_state),
>         });
> 
> OK, I'll go and update the helper.

Sounds good!

-Kees

-- 
Kees Cook

