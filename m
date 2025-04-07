Return-Path: <linux-acpi+bounces-12806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F07A7E9A8
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 20:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F43A1899C10
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E821B9CE;
	Mon,  7 Apr 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnSqU0UR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CC2116EE;
	Mon,  7 Apr 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049471; cv=none; b=gUjaWJhT+b/dk10D52AreWdZvZxZg2ArjErsPC3O4/YwOVg8IBaCEklrTzdgrgR2RgXaCeLXco3zbk9jsIs7HsRfkenfjNzZ2jLwMiAarvhybvBQlRa75EBtNmH7M6yrao7wpt7zcJjSMYRerLVCwLh5Khdz6M/9qzn+hfzt+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049471; c=relaxed/simple;
	bh=tagdq/QljfjgdMX0x03i4UOxg2HpFNLPMOEOHRAu0iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGLzWlHtWAGlN62AMTJWjcTP3GKhF4CD3VHbMMVtE6/JNLmOJlDuDlKtqhG6k578ZrRL/KYB9ibEMrkpsCXoI9ZfPdwfYyLeWpuqwl/7zrB0ALyvHTYbObLJZse6frm4jKVSHp9pEMn5VVyt8kNLZIqLr7gnfCh1riTiaUU6drU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnSqU0UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFDBC4CEDD;
	Mon,  7 Apr 2025 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049471;
	bh=tagdq/QljfjgdMX0x03i4UOxg2HpFNLPMOEOHRAu0iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnSqU0URqqo0I1arFF81p8rkvHAOK4GGSZO4ubJped4npb68CDIgZGbgJI4y3UY7W
	 N+4V+YOqRzGgUcqlwUIGI8lhZNI8bv+F6cPzMb3DQTmEvs77k1EeMmuxJorddfJmGh
	 9oMLVLb+1S/uOILWJiC9qw1E2QdlQk84kJ2kbPwq0BhS3vLF64/g0iyqNNt+IfODhl
	 ZdNxgNSNadHxfhNWa5Tampv7OjAFcV0/Djvvi4mMxj0bhOaSWpLdUOzyBBce2OFSUv
	 ivAZiNSbQARBgX2PhJXjGzk98uUrO0fjs8RdN2FFt0/4qXBu0AW0Ty1m6sujpVX1P3
	 O/TeMrK2SY1Og==
Date: Mon, 7 Apr 2025 11:11:08 -0700
From: Kees Cook <kees@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] UAPI: ndctl / acpi: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504071106.3A0AF875F@keescook>
References: <Z618ILbAR8YAvTkd@kspp>
 <Z65xV2TaFY32eYdp@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z65xV2TaFY32eYdp@aschofie-mobl2.lan>

On Thu, Feb 13, 2025 at 02:25:27PM -0800, Alison Schofield wrote:
> On Thu, Feb 13, 2025 at 03:29:12PM +1030, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> > 
> > So, in order to avoid ending up with flexible-array members in the
> > middle of other structs, we use the `__struct_group()` helper to
> > separate the flexible array from the rest of the members in the
> > flexible structure. We then use the newly created tagged `struct
> > nd_cmd_pkg_hdr` to replace the type of the objects causing trouble
> > (`pkg`) in multiple structs.
> > 
> > So, with these changes, fix the following warnings:
> > 
> > drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> One sample warning is good.
> 
> How about adding a comment on why the usage of __struct_group() here
> means this doesn't break userspace.
> 
> snip
> 
> > diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
> > index 73516e263627..34c11644d5d7 100644
> > --- a/include/uapi/linux/ndctl.h
> > +++ b/include/uapi/linux/ndctl.h
> 
> FWIW: In a patch like this where reviewers likely want to see
> the header file change first, put it first in the diff.
> (git diff.orderfile)

TIL about diff.orderfile! :) Just for my own education, what do you have
as the contents for your orderfile? Is it just simply:

*.h

?

> 
> 
> > @@ -227,12 +227,15 @@ enum ars_masks {
> >   */
> >  
> >  struct nd_cmd_pkg {
> > -	__u64   nd_family;		/* family of commands */
> > -	__u64   nd_command;
> > -	__u32   nd_size_in;		/* INPUT: size of input args */
> > -	__u32   nd_size_out;		/* INPUT: size of payload */
> > -	__u32   nd_reserved2[9];	/* reserved must be zero */
> > -	__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
> > +	/* New members MUST be added within the __struct_group() macro below. */
> > +	__struct_group(nd_cmd_pkg_hdr, __hdr, /* no attrs */,
> > +		__u64   nd_family;		/* family of commands */
> > +		__u64   nd_command;
> > +		__u32   nd_size_in;		/* INPUT: size of input args */
> > +		__u32   nd_size_out;		/* INPUT: size of payload */
> > +		__u32   nd_reserved2[9];	/* reserved must be zero */
> > +		__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
> > +	);
> >  	unsigned char nd_payload[];	/* Contents of call      */
> >  };

Gustavo, any updates on this patch? I'm skimming through patchwork to
check on stalled patches...

-- 
Kees Cook

