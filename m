Return-Path: <linux-acpi+bounces-11168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B043AA3513A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 23:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEA07A504F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A226FA79;
	Thu, 13 Feb 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6i2vJ2x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549AB26FA4E;
	Thu, 13 Feb 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485533; cv=none; b=sYABqrIE77fOBkFywtGoBRHSahfgA2nB7NE6xKe2cltOLeoOXyV2AMyyBWJ015D3wG5K5AQrUINA983BndduL3XdW29qWFQkdRVuPatUbG9+I+ABYp962fVQwfbYm5YkDdFcLPpd8aHDehCfsfTFU3OiTGNMlOR4ac1M830Ao7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485533; c=relaxed/simple;
	bh=p37l1nUZQkt5wQbWemeunE8WyqYxaQGz/iM2VYK+C/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIqTS1EVynC4VuBw1iAS8TIDIGqcBZBtzQlluNHFsg7kCRAGsa82rULXfijQk7ZMnKO5eDiiIY8ixaBSg7REakWk8cLCAhaZKdV1xFFHAHBUKUbTyGAiPaSh23GhtHqt/sq69Y2wuAHbAtiOafHb0WPM1XemMFU+flgOfNq67Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6i2vJ2x; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739485531; x=1771021531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p37l1nUZQkt5wQbWemeunE8WyqYxaQGz/iM2VYK+C/Q=;
  b=j6i2vJ2xzrd7oVtcYKlOLKNcLX6W2pKwgZ+M9y5CQyTtETntvo/+DQua
   KvWujycrAMN9db58Us6KmI+7Aa+OyzngnA9qAakCkirmYEUx4VO6bdSel
   CNwvYiQ6qIRcN+oQYe1AaSBK2tlaQIanXjOExX451Yoej67NM6SESGchI
   KZ2/6NLmimMlyfXSSyq0LK+smm3oXLn7w8ftV1xBuocb9x6zYeSysLJ4a
   3iR05WkQA0PdSfaHXtJVpOaQi6iH1ZJg2eNP8HMvrPB8aqFp5Dqf2DdIw
   Ie/baJNDQ7TZ/Mnqu3lf3tTK7NlgJDrQli/imqi/Wq7H7bFOq7++L6JgH
   w==;
X-CSE-ConnectionGUID: DWzBO1DTQWChR9d5kMrfMg==
X-CSE-MsgGUID: bZNaKJUeQZmE2okFrA+sWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57754306"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="57754306"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:25:31 -0800
X-CSE-ConnectionGUID: ZjWgeHoSRUenm5Pe5fkJDw==
X-CSE-MsgGUID: U4+QKx1fQK+DuStCaPMntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="144139771"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.202])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:25:29 -0800
Date: Thu, 13 Feb 2025 14:25:27 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] UAPI: ndctl / acpi: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z65xV2TaFY32eYdp@aschofie-mobl2.lan>
References: <Z618ILbAR8YAvTkd@kspp>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z618ILbAR8YAvTkd@kspp>

On Thu, Feb 13, 2025 at 03:29:12PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with flexible-array members in the
> middle of other structs, we use the `__struct_group()` helper to
> separate the flexible array from the rest of the members in the
> flexible structure. We then use the newly created tagged `struct
> nd_cmd_pkg_hdr` to replace the type of the objects causing trouble
> (`pkg`) in multiple structs.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

One sample warning is good.

How about adding a comment on why the usage of __struct_group() here
means this doesn't break userspace.

snip

> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
> index 73516e263627..34c11644d5d7 100644
> --- a/include/uapi/linux/ndctl.h
> +++ b/include/uapi/linux/ndctl.h

FWIW: In a patch like this where reviewers likely want to see
the header file change first, put it first in the diff.
(git diff.orderfile)


> @@ -227,12 +227,15 @@ enum ars_masks {
>   */
>  
>  struct nd_cmd_pkg {
> -	__u64   nd_family;		/* family of commands */
> -	__u64   nd_command;
> -	__u32   nd_size_in;		/* INPUT: size of input args */
> -	__u32   nd_size_out;		/* INPUT: size of payload */
> -	__u32   nd_reserved2[9];	/* reserved must be zero */
> -	__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
> +	/* New members MUST be added within the __struct_group() macro below. */
> +	__struct_group(nd_cmd_pkg_hdr, __hdr, /* no attrs */,
> +		__u64   nd_family;		/* family of commands */
> +		__u64   nd_command;
> +		__u32   nd_size_in;		/* INPUT: size of input args */
> +		__u32   nd_size_out;		/* INPUT: size of payload */
> +		__u32   nd_reserved2[9];	/* reserved must be zero */
> +		__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
> +	);
>  	unsigned char nd_payload[];	/* Contents of call      */
>  };
>  
> -- 
> 2.43.0
> 
> 

