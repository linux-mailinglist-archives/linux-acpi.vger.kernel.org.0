Return-Path: <linux-acpi+bounces-14777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B0AEBC8D
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E586452D3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A02EAB6B;
	Fri, 27 Jun 2025 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HptNLOij"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E82EA755;
	Fri, 27 Jun 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039564; cv=none; b=qMJIiD+AOPv8Ek9lj/ZjG0t76LUFDiB2+1SsHg0aC9Mn+FM5WRQJA3ZCplDvnrnsW3LEHHPydfc5ObLYxQ8Q7UKHlwZKgJOO614u7ZEBZUGB9ffceIpqrDFeAJPDrJje6UYorITKXl7TYkkiF/0nqxaH3Ma4XStUt7Mh6w/ZBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039564; c=relaxed/simple;
	bh=gy9CL9y+gfjM4QOF0F7e8FXJmc5anJ3Go0BAtsFvsKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ/UsQ7KSHDX1W4g4pO5spN99GWZrfhS3nvy1/R4TCX/+26yjoOYHVJBnZjYGG3a3CF3jcrRau4LLrNDfSQEzgPoO/Hnvxvi5zFk0JUvRX7ipC6la7qzFwXHXKvk7eZy7nPP1dG2++JzLy4d1+xh4/CKLrlvUYCb+Ei32pYjOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HptNLOij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAC9C4CEF3;
	Fri, 27 Jun 2025 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751039563;
	bh=gy9CL9y+gfjM4QOF0F7e8FXJmc5anJ3Go0BAtsFvsKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HptNLOijAQuThXyOxRbHv92Tpzf90xR4vy7kfuhDOhzs21PwCMTLa/n8A7+FkixcA
	 Do1jFS+DS4LuXGoeDkq3q78CvN5ZHGP5nGaNDnhCmDYKWuecBEqAeQaN4WVnCoesfs
	 rszraaQAVmK/qcWUSPrhTrkAc/r+ADkSNvvx8KJ8FEGTi9jsPlUNNm9UbCKjkACL0R
	 2UyJ1ENh7PDdR7V9aWsKw7YD/F70DKGmeGtbhFe7pdpOxxT3CKrYMZRdV8Q6AgxUq9
	 Jf5NNu6Y+EP++/i+iy8LCMwYxi4DVMgCwb7jAY1MbRO/p0PvxmO6rpN1PiOMUyjAv1
	 x4osoJ4oZjibQ==
Date: Fri, 27 Jun 2025 08:52:42 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4][for-next/hardening] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202506270850.8631FABC17@keescook>
References: <aFxtOLs6Yv_uzgt4@kspp>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFxtOLs6Yv_uzgt4@kspp>

On Wed, Jun 25, 2025 at 03:42:16PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix a dozen instances of
> the following type of warning:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> This patch should go through:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/ (for-next/hardening)
> 
> Changes in v4:
>  - Use the new TRAILING_OVERLAP() helper.
> 
> Changes in v3:
>  - Use union instead of DEFINE_RAW_FLEX().
>  - Link: https://lore.kernel.org/linux-hardening/aEneid7gdAZr1_kR@kspp/
> 
> Changes in v2:
>  - Use DEFINE_RAW_FLEX() instead of __struct_group().
>  - Link: https://lore.kernel.org/linux-hardening/Z-QpUcxFCRByYcTA@kspp/ 
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
> 
>  drivers/acpi/nfit/intel.c | 84 +++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index 3902759abcba..d0b72e906428 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -55,10 +55,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	unsigned long security_flags = 0;
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_get_security_state cmd;
> -	} nd_cmd = {
> +	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> +			 struct nd_intel_get_security_state cmd;
> +	) nd_cmd = {

If you wanted, these could be even further minimized to this, leaving
the trailing object indentation unchanged:

-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_get_security_state cmd;
-	} nd_cmd = {
+	) nd_cmd = {

-- 
Kees Cook

