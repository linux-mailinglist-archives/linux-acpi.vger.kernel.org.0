Return-Path: <linux-acpi+bounces-14611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00566AE8AFC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAC83B0E97
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281CF2DECD0;
	Wed, 25 Jun 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls4mqaUX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877B2DECC9;
	Wed, 25 Jun 2025 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870591; cv=none; b=VzJQ8eS3E85OgrO4g1oeGussT8Equ7ONMjmtaC9UQfxWUoogX6H6bZcZwZgxhnp3iyQDSeJERNTz0V2QVIcdpvGUHr6gK+5BmSknoGEH8uNrcRJZ62pbmTclCnaOjcBriWhIuzmu9pkBSqsNB1wrcjK8dFyn2zPvbWWkLwD2J6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870591; c=relaxed/simple;
	bh=2EEecCr0u28ZPLu/TqGbdd1N5QSKHcQ+toYx/EPSRzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrb3HPPvB3tqmdeQK0TnJIwbXtD+CYDFAhE3Imk8IjFM44wRwOxjxY+e8jYhi0cMNPKhJMhFpES81XuZukOplPl23dwdDAIGE/uwbJN0StNWJr+HpQWbMx5pMCDixOze0fDz0yZTAHUbDq9Itp8K9e89473sPYiepnxfA3bwh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls4mqaUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F553C4CEEA;
	Wed, 25 Jun 2025 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870590;
	bh=2EEecCr0u28ZPLu/TqGbdd1N5QSKHcQ+toYx/EPSRzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ls4mqaUXvRwwJRy7QFqoK1TdfAanCnWMF0aAy3RygIeKqXF6zHvPwx7y2uk991ZU3
	 v6LUzmfKluAoiqCeP1OqC58wjQZaW2mEDrLxYKyKnrCxJOmIWL6mRy94I5owJOXQKU
	 rGmszgAvxAT0hqfzjlarLSW7zjEiZozBF8rQv/nBJviAzMvj+P+MJMwOiU64ZYBzIM
	 ng+KBeqDdykIPOgxqSW3df2Xtw3BxxMUTWsOlZjMr0ueWu73g2iit/25w0isRRT0uX
	 XIwqDGceGeurSLd2Gymzrs/w+7G17osNDd/XCEn1ZufORFB1rbGdHoGw5pCPCydrRK
	 YmG9IBrAasbHQ==
Date: Wed, 25 Jun 2025 09:56:30 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202506250950.31C8A58E@keescook>
References: <aEneid7gdAZr1_kR@kspp>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEneid7gdAZr1_kR@kspp>

On Wed, Jun 11, 2025 at 01:52:41PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Refactor multiple structs that contain flexible-array members in the
> middle by replacing them with unions.
> 
> These changes preserve the memory layout while effectively adjusting
> it so that the flexible-array member is always treated as the last
> member.
> 
> With these changes, fix a dozen instances of the following type of
> warning:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v3:
>  - Use union instead of DEFINE_RAW_FLEX().

I think your TRAILING_OVERLAP macro[1] is perfect here. I'll try to get that
landed for the next rc. Can you double-check that this works correctly
in these cases?

> @@ -55,9 +55,16 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	unsigned long security_flags = 0;
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>  		struct nd_cmd_pkg pkg;
> -		struct nd_intel_get_security_state cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_get_security_state cmd;
> +		};
>  	} nd_cmd = {
>  		.pkg = {
>  			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,

I think it would be a pretty small and direct replacement:

	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
			 struct nd_intel_get_security_state cmd;
	) nd_cmd = {
		...

-Kees

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/kspp&id=29bb79e9dbf1ba100125e39deb7147acd490903f

-- 
Kees Cook

